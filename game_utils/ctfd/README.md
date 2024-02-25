# CTFd

Serves as a platform for CTF competitions. Provides basic CTF functionality, including user registration, challenges,
and score tracking.

## Setup

Docker image is built upon the base copas image. The following environment variables are required:
- `CTF_ADMIN_TOKEN`: The admin token for the CTFd instance. Can be created in the Setting -> Access Token -> Generate
- `CTFD_PORT`: The port to expose the CTFd instance on. Defaults to 8000.
