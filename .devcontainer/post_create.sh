mkdir ~/.config/tmuxinator -p && cp /copas-docker/.devcontainer/copas.yml ~/.config/tmuxinator/copas.yml
apt update
apt install -y software-properties-common git
add-apt-repository ppa:deadsnakes/ppa -y
apt install -y python3.10 python3-pip inetutils-ping git python3.10-venv curl vim netcat tmuxinator mariadb-server mariadb-client
cd /copas-docker/backend && python3.10 -m venv docker_env && source docker_env/bin/activate && pip install poetry==1.3.2 && poetry install && deactivate
# setting up CTFd
mkdir -p /run/mysqld
git clone https://github.com/CTFd/CTFd.git /ctfd
cd /ctfd && python3.10 -m venv env && source env/bin/activate && pip install -r requirements.txt && deactivate
sh /copas-docker/game_utils/ctfd/ctfd.entrypoint.sh
