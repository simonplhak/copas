import random
import string

from ctfd_sdk import CtfdApi

api = CtfdApi()


def _generate_flag() -> str:
    return ''.join(random.choice(string.ascii_lowercase) for _ in range(10))


def create_movie_challenge(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    api.create_challenge('movie', 100)
    for team in teams.values():
        if team['name'] != 'movie':
            continue
        for agent in team['agents']:
            if agent['role'] != 'movie_main':
                continue
            flag = _generate_flag()
            api.create_flag('movie', f'{agent["token"]}_flag', flag)
            events.append({'action': f'echo "{flag}" > /flag.txt', 'agent': agent, 'name': 'create_movie_challenge'})
            break
    return events


def create_game_challenge(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    api.create_challenge('game', 100)
    for team in teams.values():
        if team['name'] != 'game':
            continue
        for agent in team['agents']:
            if agent['role'] != 'game_main':
                continue
            flag = _generate_flag()
            api.create_flag('movie', f'{agent["token"]}_flag', flag)
            events.append({'action': f'echo "{flag}" > /flag.txt', 'agent': agent, 'name': 'create_game_challenge'})
            break
    return events


def update_movie_flag(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    for team in teams.values():
        if team['name'] != 'movie':
            continue
        for agent in team['agents']:
            if agent['role'] != 'movie_main':
                continue
            flag = _generate_flag()
            api.update_flag(f'{agent["token"]}_flag', flag)
            events.append({'action': f'echo "{flag}" > /flag.txt', 'agent': agent, 'name': 'update_movie_flag'})
            break
    return events


def update_game_flag(master: dict, teams: dict[str, dict]) -> list[dict]:
    events = []
    for team in teams.values():
        if team['name'] != 'game':
            continue
        for agent in team['agents']:
            if agent['role'] != 'game_main':
                continue
            flag = _generate_flag()
            api.update_flag(f'{["agent"]}_flag', flag)
            events.append({'action': f'echo "{flag}" > /flag.txt', 'agent': agent, 'name': 'update_game_flag'})
            break
    return events
