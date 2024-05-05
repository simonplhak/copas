import os
from http.server import BaseHTTPRequestHandler, HTTPServer
import time


PORT = 8081
MAX_REQUESTS_PER_SECOND = os.getenv("L2_MAX_REQUESTS_PER_SECOND", None)
MAX_REQUESTS_PER_SECOND = (
    None if MAX_REQUESTS_PER_SECOND is None else int(MAX_REQUESTS_PER_SECOND)
)
RATE_LIMIT = int(os.getenv("L2_RATE_LIMIT", 5))
start = time.time()
request_count = 0

clients = {}
clients_start = time.time()


def update_request_count():
    global start, request_count
    curr_time = time.time()
    if curr_time - start >= 1:
        request_count = 1
        start = time.time()
    else:
        request_count += 1
    return request_count


def update_client_request_count(client):
    global clients, clients_start
    curr_time = time.time()
    if curr_time - clients_start >= 1:
        clients[client] = 1
        clients_start = time.time()
    else:
        clients[client] += 1
    return clients[client]


class RateLimitedHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        client_address = self.client_address[0]
        client_request_count = update_client_request_count(client_address)
        if client_request_count >= RATE_LIMIT:
            self.send_response(429)  # Too Many Requests
            self.end_headers()
            self.wfile.write(b"Too Many Requests.")
            return
        if MAX_REQUESTS_PER_SECOND is not None:
            _request_count = update_request_count()
            if _request_count > MAX_REQUESTS_PER_SECOND:
                raise Exception("Oh no, they killed me!")

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello, world!")


def run(server_class=HTTPServer, handler_class=RateLimitedHTTPRequestHandler):
    server_address = ("0.0.0.0", PORT)
    httpd = server_class(server_address, handler_class)
    print(f"Starting server on http://localhost:{PORT} with {MAX_REQUESTS_PER_SECOND=}")
    httpd.serve_forever()


if __name__ == "__main__":
    run()
