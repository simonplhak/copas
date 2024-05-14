import requests

if __name__ == "__main__":
    while True:
        response = requests.get("http://master:8080")
        print(response.text)
