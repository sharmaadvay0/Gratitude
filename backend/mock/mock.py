import json
import subprocess
import time


def post_json(url, data):
    return subprocess.run([
        "curl",
        "--header", "Content-Type: application/json",
        "--request", "POST",
        "--data", json.dumps(data),
        url
    ])


def main():
    mock_data = json.load(open("mock.json"))
    for key, objs in mock_data.items():
        for obj in objs:
            post_json(f"http://localhost:5000/api/{key}", obj)
            time.sleep(1)


if __name__ == "__main__":
    main()
