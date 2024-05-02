VERSION ?= latest
current_dir := $(shell pwd)
NAME ?= player0

update:
	git submodule update --remote --recursive

link-frontend:
	mkdir -p "backend/static/"
	ln -s ../frontend/out/ backend/

unlink-frontend:
	rm templates/index.html
	rm -r "frontend"

link-ctfd:
	pip uninstall -y ctfd-sdk
	pip install /home/simon/Documents/bc/ctfd-sdk/dist/ctfd_sdk-0.1.0-py3-none-any.whl

unlink-ctfd:
	pip uninstall -y ctfd-sdk
	pip install -y ctfd-sdk

clear:
	curl -X POST localhost:8006/api/-/clear/

build:
	docker build . -t copas:latest

build-ctfd:
	docker build game_utils/ctfd -t copas.ctfd:latest -f game_utils/ctfd/Dockerfile

run-ctfd:
	docker run \
		--rm \
		--name copas.ctfd \
		-p 8001:8001 \
		-p 8002:8002 \
		-v /home/simon/Documents/bc/copas/backend/config.yml:/app/config.yml \
		-e HTTP_PORT=8001 \
		-e CTFD_PORT=8002 \
		copas.ctfd:latest

run-master:
	docker run \
		--rm \
		--name copas \
		-p 8001:8001 \
		-v /home/simon/Documents/bc/copas/backend/config.yml:/app/config.yml \
		-e ROLE=master \
		-e HTTP_PORT=8001 \
		-e MASTER_HTTP_PORT=8001 \
		--network=copas \
		copas:latest

run-player:
	docker run \
		--rm \
		--name copas.player \
		-p 8002:8002 \
		-e HTTP_PORT=8002 \
		--network=copas \
		copas:latest

run-player-2:
	docker run \
		--rm \
		--name copas.player.1 \
		-p 8003:8003 \
		-e HTTP_PORT=8003 \
		--network=copas \
		copas:latest


build-frontend:
	export PRODUCTION=true
	cd frontend && npm run build
	export PRODUCTION=false
