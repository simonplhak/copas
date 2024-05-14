import requests
import time


if __name__ == "__main__":
    while True:
        response = requests.get("http://master:8081")
        print(response.text)
        time.sleep(0.25)
