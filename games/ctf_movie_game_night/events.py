import os
import random
import string
from pathlib import Path

from ctfd_sdk import CtfdApi

CTFD = os.getenv("CTFD", "false") == "true"
CTFD_HOST = os.getenv("CTFD_HOST", "http://localhost:8001")
CTFD_ADMIN_TOKEN = os.getenv("CTFD_ADMIN_TOKEN")
CTFD_ADMIN_TOKEN_FILE = Path(os.getenv("CTFD_ADMIN_TOKEN_FILE", "/etc/ctfd.secret"))


def get_ctfd_admin_token():
    if CTFD_ADMIN_TOKEN is not None:
        return CTFD_ADMIN_TOKEN
    assert (
        CTFD_ADMIN_TOKEN_FILE.exists()
    ), f"`CTFD_ADMIN_TOKEN not specified(inlude as env variable or in {CTFD_ADMIN_TOKEN_FILE})"
    with open(CTFD_ADMIN_TOKEN_FILE, "r") as f:
        return f.read().strip()


api = CtfdApi(get_ctfd_admin_token(), CTFD_HOST)


def _generate_flag() -> str:
    return "".join(random.choice(string.ascii_lowercase) for _ in range(10))


def create_movie_challenge(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    api.create_challenge("movie", 100)
    for team in teams.values():
        if team["name"] != "movie":
            continue
        for agent in team["agents"]:
            if agent["role"] != "movie_main":
                continue
            flag = _generate_flag()
            api.create_flag("movie", f'{agent["token"]}_flag', flag)
            events.append(
                {
                    "action": f'echo "{flag}" > /flag.txt',
                    "agent": agent,
                    "name": "create_movie_challenge",
                }
            )
            break
    return events


def create_game_challenge(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    api.create_challenge("game", 100)
    for team in teams.values():
        if team["name"] != "game":
            continue
        for agent in team["agents"]:
            if agent["role"] != "game_main":
                continue
            flag = _generate_flag()
            api.create_flag("movie", f'{agent["token"]}_flag', flag)
            events.append(
                {
                    "action": f'echo "{flag}" > /flag.txt',
                    "agent": agent,
                    "name": "create_game_challenge",
                }
            )
            break
    return events


def update_movie_flag(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    for team in teams.values():
        if team["name"] != "movie":
            continue
        for agent in team["agents"]:
            if agent["role"] != "movie_main":
                continue
            flag = _generate_flag()
            api.update_flag(f'{agent["token"]}_flag', flag)
            events.append(
                {
                    "action": f'echo "{flag}" > /flag.txt',
                    "agent": agent,
                    "name": "update_movie_flag",
                }
            )
            break
    return events


def update_game_flag(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    for team in teams.values():
        if team["name"] != "game":
            continue
        for agent in team["agents"]:
            if agent["role"] != "game_main":
                continue
            flag = _generate_flag()
            api.update_flag(f'{["agent"]}_flag', flag)
            events.append(
                {
                    "action": f'echo "{flag}" > /flag.txt',
                    "agent": agent,
                    "name": "update_game_flag",
                }
            )
            break
    return events
