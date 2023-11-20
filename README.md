# copas-game-infrastructure

## Run locally

```shell
python3 -m venv env
source env/bin/activate
pip install poetry==1.3.2
poetry install
uvicorn app.main:app --reload
```

### Run in kubernates

To run application on kubernates follow these commands:

```shell
# build docker image from Dockerfile
docker build -t copas-game-architecture .
# start local cluster
minikube start
# create a deployment for application 
kubectl apply -f deployment.yml
# create a service from application
kubectl apply -f service.yml
# see app url
minikube service copas-service --url
```

## Notes

- Create a quick MVP and iterate
- Work with Dockerfile throughout the development process
- Document the project at the end
- Start by creating the game and then abstract it
- Use decorators to determine which endpoints (chat/infrastructure_overview) to allow
- use sqlalchemy instead peewee(asynchronous)
- split models which differs for different endpoints
- use logging
- possibility to run multiple containers of one image (e.g. 12 containers of juice-shop)
- by default members of a team can see each other
- `get_agents` endpoint returns all agents in flat form
- `get_agents` -> master then creates teams and distributes agents into teams
- `get_teams` -> returns all agents distributed into teams in following format:

1) More teams

```json
{
  "master": {
    "id": "master",
    "ip": "192.168.0.111"
  },
  "teams": [
    {
      "name": "team_1",
      "agents": [
        {
          "name": "agent_1",
          "ip": "192.168.0.112",
          "role": "player"
        }
      ]
    },
    {
      "name": "team_2",
      "agents": [
        {
          "name": "agent_2",
          "ip": "192.168.0.113",
          "role": "player"
        }
      ]
    }
  ]
}
```

2) one team

```json
{
  "master": {
    "id": "master",
    "ip": "192.168.0.111"
  },
  "teams": [
    {
      "name": "players",
      "agents": [
        {
          "name": "agent_1",
          "ip": "192.168.0.112",
          "role": "player"
        },
        {
          "name": "agent_2",
          "ip": "192.168.0.113",
          "role": "player"
        }
      ]
    }
  ]
}
```
3) more teams, multiple roles

```json
{
  "master": {
    "id": "master",
    "ip": "192.168.0.111"
  },
  "teams": [
    {
      "name": "attackers",
      "agents": [
        {
          "name": "agent_1",
          "ip": "192.168.0.112",
          "role": "attacker"
        }
      ]
    },
    {
      "name": "defenders",
      "agents": [
        {
          "name": "agent_2",
          "ip": "192.168.0.113",
          "role": "defender"
        },
        {
          "name": "agent_2",
          "ip": "192.168.0.113",
          "role": "defender_main"
        }
      ]
    }
  ]
}
```


## Goal

Create an infrastructure that facilitates communication during educational games played in a classroom setting.

This infrastructure can also be utilized for other purposes that require similar functionality,
such as configuring shared resources (e.g., elastic search database) to run on multiple agents.

The game and its associated features will be displayed directly in a web browser.

The basic server will run on port 7000 and provide access to other infrastructure functions (chat,
infrastructure_overview).

Game designers can utilize a module with the necessary dependencies and communication infrastructure,
which they can customize using configuration files. The infrastructure should enable the following functionalities:

- Set roles for participants
- Configure chat (allow conversations within teams or between teams)
- Record scores
- Log all requests (master)
- Log all requests (slave)
- Create a local DNS
- Visualize the infrastructure (entire or specific components visible to agents)
- Display score graphs
- Display logged requests
- Quiz feature
- Send and download files
- Send and display images
- Make a checkpoint to restore the game if necessary
- Display the status (green/red) of current services
- Share files for all agents (initially as read-only access)
- Every user(including master) at the start of the game chooses which image he wants and `copas` will pull it
  from docker hub and run it. `copas` may pull more docker images if necessary(needed services).

### Master:

- Instructor/supervisor
- Log request
- Record scores
- Create score graphs
- Track recorded requests
- Send messages (to all, one, or a team)
- Define IP addresses visible to slaves (individual addresses can be sent)
- Display the server's address and port where the infrastructure is running
- Select game difficulty or type
- Provide a way to upload a custom game version (e.g., scavenger hunt)
- Upload questions and correct answers
- View the infrastructure
- Game Flow:
    - Select the master role
    - Display IP:port -> the master's task is to share this information with other participants
    - Create a map of IP addresses (to be stored in case of infrastructure or application failure)
    - After all participants log in, assign players to teams
    - Send initial instructions to slaves
    - Allow communication among participants
    - Evaluate scores based on received requests
    - Provide hints during the game
    - Display the current score during the game (e.g., on a projector)
    - Allow communication among multiple team members
    - Announce the end of the game
    - Manage chat communication directly as the master (implementing encrypted communication is optional)

### Slave

- Participant
- Display the initial window where the IP:port of the master is entered
- Log requests
- View scores
- Display IP addresses/domains of other users
- Send messages (to all, one, a team, another team, master)
- Display the slave's address and port where the infrastructure is running
- Display the infrastructure
- Game Flow:
    - Select the slave role
    - Enter an ID (name)
    - Enter the IP:port of the master in the initial window
    - Display the task
    - Display the IP addresses received from the master
    - Send a message to a specific IP address
    - Play the game
    - Send part or the entire result to the master
    - Display messages from slaves/master during the game
    - Display hints from the master during the game
    - Display information about the game's end
    - Display the results

## Infrastructure Overview

Participants are considered as agents. Each agent will have an infrastructure application running on a defined port.
The infrastructure provides an overview of all running services (e.g., Telnet) on the agents.

### Backend application

The backend application will provide an interface with the following endpoints:

- /game_window??
- /chat: List[dict] - a list of all agents available for communication
- /chat/<token>: dict - agent, conversation history with the agent
- /infrastructure: List[dict] - a list of all agents allowed by the master
- /score ??

#### Master

- /roles
- /chat/settings
- /roles/settings
- /chat/all

#### Game Designer

- /event/<specific_event>

### Frontend application

The UI application will provide a web interface with the following endpoints:

- /
- /game_window
- /chat
- /chat/<token>
- /infrastructure
- /score

#### Master

- /roles
- /chat/settings
- /roles/settings
- /chat/all

#### Game Designer

- /event/<specific_event>

### Event

Specific to a particular game (e.g., 'start_game' event).

When the game designer wants to define an endpoint, they must define an application (the default application will be
provided) that will provide an endpoint to handle the specified event.

For example, if the game designer wants to define
an action, they need to define an application that runs on port 7001 and provides the /start_game endpoint. Then, the
game designer defines the event in the UI configuration, similar to how Ondřej Machala defined it in his bachelor's
thesis:

```yaml
contents:
  - content_type: control
    control_type: checkbox
    title: The title of the configuration item
    description: An optional description of the configuration item.
    label: Checkbox label
    config_key: config.checkbox
    default_value: true
    +
    event: `/start_game`
    state: 'start_game'
```

Subsequently, the checkbox will be displayed in /game_window, along with a submit button. After submission, the response
is sent to the specified endpoint.
The state field indicates the game's current state in which the checkbox should be displayed in the game window. See the
Game Window section for more details.

## Game Window

Displayed at the /game_window endpoint, the game window is defined by a string representing the current game state. It
shows all defined controls and their descriptions for that state. It defines the current game state and instructs the
agent on what to do in that phase.

Nice to Have
Users can define in the config:

```yaml
game_window:
  - <state_of_game>: `/client-endpoint/defined/by/game-designer`
```

This causes a redirect to the specified address when the game is in a particular state (the redirect could be replaced
by rewriting the content) on the web application, which the game designer needs to define.

Content Configuration Example

```yaml
- content_type: control
  control_type: checkbox
  title: The title of the configuration item
  description: An optional description of the configuration item.
  label: Checkbox label
  config_key: config.checkbox
  default_value: true
```

Event Configuration Example

```yaml
  event: `/start_game`
  state: 'start_game'
```

When an event is triggered, the game designer needs to define an endpoint that returns the new game state in the
response:
In /game_window, control buttons will be displayed for each defined state. When a specific event is triggered, the game
designer must return the new state of the game as a response,

## Development

Proposed way is to have kubernates and run in minicube multiple pods, where each pod represents an user.
These pods will be all exposed on different ports. This way we can access different runs by just switching ports.
