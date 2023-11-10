from pathlib import Path

import click
from dotenv import load_dotenv

repo = Path(__file__).resolve().parent
backend_env = repo / 'backend' / '.env'
frontend_env = repo / '..' / 'copas-frontend' / '.env'  # todo will be change in the future 


def set_role(role: str, path: Path):
    with open(path) as f:
        lines = f.readlines()
    new_lines = []
    for line in lines:
        key, value = line.split('=')
        if key == 'ROLE' or key == 'NEXT_PUBLIC_ROLE':
            value = role
        new_lines.append(f'{key}={value}')
    with open(path, 'w') as f:
        f.write('\n'.join(new_lines))


@click.group()
def cli():
    pass


@cli.command()
@click.argument('role')
def role(role):
    paths = [backend_env, frontend_env]
    for path in paths:
        set_role(role, path)
    load_dotenv()
    print(f'ROLE set to: {role} in {", ".join([str(path) for path in paths])}')


if __name__ == '__main__':
    cli()
