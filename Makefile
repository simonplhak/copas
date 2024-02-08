VERSION ?= latest
current_dir := $(shell pwd)
NAME ?= player0

create-agent:
	$(MAKE) role ROLE=player
	curl -X POST -H "Content-Type: application/json" -d '{"name":"$(NAME)"}' localhost:8000/api/agent/
	$(MAKE) role


update:
	git submodule update --remote --recursive

link-frontend:
	mkdir -p "backend/static/"
	ln -s ../frontend/out/ backend/

unlink-frontend:
	rm templates/index.html
	rm -r "frontend"

clear:
	curl -X POST localhost:8000/api/-/clear/

build:
	docker build . -t copas:latest

run-master:
	docker run \
		--rm \
		--name copas \
		-p 8001:8001 \
		-v /home/simon/Documents/bc/copas/games/owasp_juice_shop/config.yml:/app/config.yml \
		-e ROLE=master \
		-e HTTP_PORT=8001 \
		-e MASTER_HTTP_PORT=8001 \
		--network=copas_network \
		copas:latest

run-player:
	docker run \
		--rm \
		--name copas2 \
		-p 8004:8004 \
		-e HTTP_PORT=8004 \
		--network=copas \
		copas:latest
stop:
	docker stop copas


build-frontend:
	export PRODUCTION=true
	cd frontend && npm run build
	export PRODUCTION=false


run-juice-shop-web:
	docker run --name juice-shop \
	-p 3001:3000 \
	-e "NODE_ENV=ctf" \
 	--rm \
 	-d \
 	bkimminich/juice-shop

stop-juice-shop-web:
	docker stop juice-shop
