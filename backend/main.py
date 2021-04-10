from types import SimpleNamespace

from flask import Flask, request, abort
from google.cloud import firestore


app = Flask(__name__)
db = firestore.Client()


def validate(obj, types):
    for key in types:
        if key not in obj:
            abort(400, " ".join([
                f"Missing required attribute '{key}'",
                f"of type '{types[key].__name__}'",
            ]))
    for key in obj:
        if key not in types:
            abort(400, f"Unexpected attribute '{key}'")
    for key, expected_type in types.items():
        if not isinstance(obj[key], expected_type):
            abort(400, " ".join([
                f"Attribute '{key}' was type '{type(obj[key]).__name__}';",
                f"expected '{expected_type.__name__}'",
            ]))
    return SimpleNamespace(**obj)


@app.route("/")
def hello_world():
    return "Hello, World!"


@app.route("/api/user/create", methods=["POST"])
def user_create():
    parsed = validate(request.json, {
        "realName": str,
        "username": str,
    })

    user_ref = db.collection("user").document(parsed.username)
    if user_ref.get().exists:
        abort(409, description=f"Username '{parsed.username}' is taken")
    else:
        user_ref.set({
            "realName": parsed.realName,
            "following": [],
        })
        return user_ref.get().to_dict(), 201


@app.route("/api/user/get/<username>")
def user_get(username):
    user = db.collection("user").document(username).get()
    if user.exists:
        return user.to_dict()
    else:
        abort(404, description="User not found")
