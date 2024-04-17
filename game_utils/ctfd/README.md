# CTFd

Serves as a platform for CTF competitions. Provides basic CTF functionality, including user registration, challenges,
and score tracking.

## Setup

Docker image is built upon the base copas image. The following environment variables are required:
- `CTF_ADMIN_TOKEN`: The admin token for the CTFd instance. Can be created in the Setting -> Access Token -> Generate
- `CTFD_PORT`: The port to expose the CTFd instance on. Defaults to 8000.

## Game creation

1. Start docker container `make run`
2. Open `localhost:8002`
3. Proceed through setup
4. Generate admin token(Setting -> Access Token -> Generate)
5. Store admin token in /etc/ctfd.secret (`make store-token TOKEN=<token>`)
6. Create challenges for your game
7. Install master's services
8. Store the docker image (`make store-image NAME=<name>`)
