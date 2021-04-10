from datetime import datetime
from types import SimpleNamespace

from flask import Flask, request, abort, make_response
from google.cloud import firestore, language_v1


app = Flask(__name__)
db = firestore.Client()


def die(status, message):
    abort(make_response({"message": message}, status))


def validate(obj, types):
    for key in types:
        if key not in obj:
            die(400, " ".join([
                f"Missing required attribute '{key}'",
                f"of type '{types[key].__name__}'",
            ]))
    for key in obj:
        if key not in types:
            die(400, f"Unexpected attribute '{key}'")
    for key, expected_type in types.items():
        if not isinstance(obj[key], expected_type):
            die(400, " ".join([
                f"Attribute '{key}' was type '{type(obj[key]).__name__}';",
                f"expected '{expected_type.__name__}'",
            ]))
    return SimpleNamespace(**obj)


def get_sentiment_mood(body):
    client = language_v1.LanguageServiceClient()
    document = language_v1.Document(content=body,
            type_=language_v1.Document.Type.PLAIN_TEXT)
    response = client.analyze_sentiment(request={"document": document})
    sentiment = response.document_sentiment
    return (sentiment.score + 1) / 2


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


@app.route("/api/user/follow", methods=["POST"])
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
    })

    _, post_ref = db.collection("post").add({
        "username": parsed.username,
        "body": parsed.body,
        "category": parsed.category,
        "userMood": parsed.userMood,
        "sentimentMood": get_sentiment_mood(parsed.body),
        "date": datetime.utcnow(),
    })

    return post_dict(post_ref.get()), 201


@app.route("/api/post/<username>")
def post_history(username):
    user_ref = get_user_ref(username)
    
    query = (db.collection("post")
            .where("username", "==", username)
            .order_by("date"))
    posts = [post_dict(post) for post in query.stream()]

    return {"posts": posts}


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
