from datetime import datetime
from types import SimpleNamespace

from flask import Flask, request, abort, make_response
from google.cloud import firestore


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
        "sentimentMood": 0.0, # TODO
        "date": datetime.utcnow(),
    })

    post_dict = post_ref.get().to_dict()
    post_dict["date"] = post_dict["date"].isoformat()
    return post_dict, 201
