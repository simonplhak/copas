import os
import sys
import time
from http.server import BaseHTTPRequestHandler, HTTPServer


PORT = 8080
MAX_REQUESTS_PER_SECOND = os.getenv("L1_MAX_REQUESTS_PER_SECOND", None)
MAX_REQUESTS_PER_SECOND = (
    None if MAX_REQUESTS_PER_SECOND is None else int(MAX_REQUESTS_PER_SECOND)
)
start = time.time()
request_count = 0


def update_request_count():
    global start, request_count
    curr_time = time.time()
    if curr_time - start >= 1:
        request_count = 1
        start = time.time()
    else:
        request_count += 1
    return request_count


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if MAX_REQUESTS_PER_SECOND is not None:
            _request_count = update_request_count()
            if _request_count > MAX_REQUESTS_PER_SECOND:
                sys.exit(1)

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello, world!")


def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler):
    server_address = ("0.0.0.0", PORT)
    httpd = server_class(server_address, handler_class)
    print(f"Starting server on http://localhost:{PORT} with {MAX_REQUESTS_PER_SECOND=}")
    httpd.serve_forever()


if __name__ == "__main__":
    run()
