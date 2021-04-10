from flask import Flask
from google.cloud import firestore


app = Flask(__name__)
db = firestore.Client()


db.collection("posts").document("test").set({"title": "first post"})


@app.route("/")
def hello_world():
    return "Hello, World!"
