from datetime import datetime
from types import SimpleNamespace

from flask import Flask, request, abort, make_response
from google.cloud import firestore, language_v1
from scipy.stats import linregress


app = Flask(__name__)
db = firestore.Client()


def die(status, message):
    abort(make_response({"message": message}, status))


def validate(obj, types):
    if obj is None:
        die(400, "No JSON body provided")
    for key in obj:
        if key not in types:
            die(400, f"Unexpected attribute '{key}'")
    for key, type_spec in types.items():
        if isinstance(type_spec, tuple) and type(None) in type_spec:
            continue
        if key not in obj:
            die(400, " ".join([
                f"Missing required attribute '{key}'",
                f"of type '{types[key].__name__}'",
            ]))
        if not isinstance(obj[key], type_spec):
            die(400, " ".join([
                f"Attribute '{key}' was type '{type(obj[key]).__name__}';",
                f"expected '{type_spec.__name__}'",
            ]))
    return SimpleNamespace(**obj)


def get_sentiment_mood(body):
    client = language_v1.LanguageServiceClient()
    document = language_v1.Document(content=body,
            type_=language_v1.Document.Type.PLAIN_TEXT)
    response = client.analyze_sentiment(request={"document": document})
    sentiment = response.document_sentiment
    mood = (sentiment.score + 1) / 2
    mood = (mood - 0.3) * 1.4
    mood = max(0, min(1, mood))
    return mood


def get_user_ref(username):
    user_ref = db.collection("user").document(username)
    if not user_ref.get().exists:
        die(404, f"User '{username}' not found")
    return user_ref


@app.route("/api/user", methods=["POST"])
def user_create():
    parsed = validate(request.json, {
        "username": str,
        "realName": str,
    })

    user_ref = db.collection("user").document(parsed.username)
    if user_ref.get().exists:
        die(409, f"Username '{parsed.username}' is taken")
    else:
        user_ref.set({
            "realName": parsed.realName,
            "following": [],
        })
        return user_ref.get().to_dict(), 201


@app.route("/api/user/<username>")
def user_get(username):
    return get_user_ref(username).get().to_dict()


@app.route("/api/follow", methods=["POST"])
def user_follow():
    parsed = validate(request.json, {
        "username": str,
        "targetUsername": str,
        "follow": bool,
    })

    user_ref = get_user_ref(parsed.username)
    target_ref = get_user_ref(parsed.targetUsername)

    if parsed.follow:
        if parsed.targetUsername in user_ref.get().to_dict()["following"]:
            die(400, f"Already following '{parsed.targetUsername}'")
        else:
            user_ref.update({
                "following": firestore.ArrayUnion([parsed.targetUsername])
            })
    else:
        if parsed.targetUsername not in user_ref.get().to_dict()["following"]:
            die(400, f"Already not following '{parsed.targetUsername}'")
        else:
            user_ref.update({
                "following": firestore.ArrayRemove([parsed.targetUsername])
            })

    return user_ref.get().to_dict()


def post_dict(post):
    data = post.to_dict()
    data["date"] = data["date"].isoformat()
    return data


@app.route("/api/post", methods=["POST"])
def post_create():
    parsed = validate(request.json, {
        "username": str,
        "body": str,
        "category": str,
        "userMood": float,
        "sentimentMood": (float, type(None)),
        "date": (str, type(None)),
    })

    try:
        date = datetime.fromisoformat(parsed.date)
    except AttributeError:
        date = datetime.utcnow()

    _, post_ref = db.collection("post").add({
        "username": parsed.username,
        "body": parsed.body,
        "category": parsed.category,
        "userMood": parsed.userMood,
        "sentimentMood": get_sentiment_mood(parsed.body),
        "date": date,
    })

    return post_dict(post_ref.get()), 201


@app.route("/api/post/<username>")
def post_history(username):
    user_ref = get_user_ref(username)
    
    query = (db.collection("post")
            .where("username", "==", username)
            .order_by("date"))
    posts = [post.to_dict() for post in query.stream()]

    if len(posts) >= 2:
        dates = [post["date"].timestamp() for post in posts]
        moods = [(post["userMood"] + post["sentimentMood"]) / 2 for post in posts]
        regression = linregress(dates, moods)
        total_change = regression.slope * (dates[-1] - dates[0])
    else:
        total_change = 0

    for post in posts:
        post["date"] = post["date"].isoformat()

    return {
        "posts": posts,
        "totalChange": total_change,
    }


@app.route("/api/feed/<username>")
def feed(username):
    user_ref = get_user_ref(username)
    users = set([username] + user_ref.get().to_dict()["following"])

    posts = []

    query = (db.collection("post")
            .order_by("date", direction=firestore.Query.DESCENDING))
    for post in query.stream():
        as_dict = post_dict(post)
        if as_dict["username"] in users:
            posts.append(as_dict)

    return {"posts": posts}
