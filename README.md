# Copas Game Infrastructure

Template for creating training games in Co-PAS. CoPAS provides its solutions in containerized form, which make
specific requirements for template. The template empowers game
designers to configure the game infrastructure, providing a flexible
framework for diverse training scenarios. A chat system is integrated
to foster communication among users during gameplay. Additionally,
the template enables the use of different Capture The Flag frameworks,
simplifying game development and game management.

## Run locally

```shell
python3 -m venv env
source env/bin/activate
pip install poetry==1.3.2
poetry install
uvicorn app.main:app --reload
```

## Run with devcontainer

```shell
# create docker network to enable communication between containers and simulate real environment
docker network create copas
```

Most popular IDEs support devcontainer. Just open the project in your IDE and it will ask you to open it in
devcontainer.
Otherwise you can use [cli tool](https://github.com/devcontainers/cli).

## Run with docker

```shell
make build
# create docker network to enable communication between containers and simulate real environment
docker network create copas
make run-master
# make run-player
```

More details in [Makefile](Makefile).

## Create a new game

1. Build a docker base image via `make build`
2. Optional - if you want to use CTFd framework you need to build it via `make build-ctfd`
3. Create a new Dockerfile in `games` directory in subdirectory with the name of the game
4. Dockerfile should inherit from selected base image(`copas` or if you want to use CTFd `copas-ctfd`)
5. Add necessary dependencies to the Dockerfile(via `apt-get`)
6. Create a [config](#config) file for the game
7. Add config file to the Dockerfile
8. Optional - create [events.py](#events) file in the game directory and `COPY` it in final docker image
9. Add game specific files to the Dockerfile
10. Build the Dockerfile
11. Optional - Run the game in case you want to add custom challenges in CTFd
    1. Initialize master
    2. Go to CTFd -> CTFd page
    3. Initialize CTFd(specify `administration` should be enough)
    4. Generate CTFd admin token (Settings -> Access Token -> Generate Access Token)
    5. Store CTFd admin token in `ctf_copas` app(CTFd -> token)
    6. Add custom challenges to CTFd (Admin panel -> Challenges)
    7. Save the game via `docker commit copas <game_name>:<tag>`
12. [Export](#export-final-game) the final game

```Dockerfile
FROM copas.ctfd:latest
COPY config.yml /app/config.yml
COPY config.yml /app/config.yml
COPY ctfd_backup.zip /ctfd/ctfd_backup.zip
COPY events.py /app/app/master/events.py
WORKDIR /workdir
ENV ROLE=master
```

## Config

```yaml
infrastructure:
  dns: <true|false>
  setup:
    - name: <str>
      run: <str>
master:
  services:
    - <service>
teams:
  - name: <str>
    roles:
      - name: <str>
        services:
          - <service>
services:
  - name: <str>
    run: <str>
    port: <int>
events:
  - name: <str>
    trigger: <start|time>
    timeout: optional <int>
```

## Events


```python
def event_name(master: dict, teams: dict[str, dict]) -> list[dict]:
    ...
```

### Models

```python
master = agent = {
    "name": <str>,
    "ip": <str>, # IP address of agent
    "domain": <str>, # agent ’s domain
    "token": <str>,
    "team_token": <str>,
    "role": <str>, # role assigned to agent
    "port": <int>, # port on which runs agent base server
    "services": list <service>, # services assigned to agent
    "state": <up|down|unknown>, # agent’s accessibility state
}

team = {
    "name" : <str>, # type of team
    "instance_name" : <str>, # specific team name
    "agents" : <list[agent]>, # agents assigned to a team
    "token" : <str>,
}

service = {
    "token": <str>,
    "name": <str>,
    "port": <int>, # port in which service runs
    "host": <str>, # agent ’s IP address
    "state": <up|down|unknown>,
    "check": <str>, # how should be service checked ( shell command )
    "agent_token": <str>,
}

agent_event = { 
    "name" : "<str>",  # event name(in our case it would be `event_name`)
    "action": <str>, 
    "agent": <agent>
}
```

## Export final game

## Usage

## Infrastructure

![picture](images/components.png)

## ERD

![picture](images/erd.png)
