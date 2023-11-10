VERSION ?= latest
current_dir := $(shell pwd)
ROLE ?= master


role:
	python3 manage.py role $(ROLE)


update:
	git submodule update --remote --recursive

link-frontend:
	mkdir -p "backend/static/"
	ln -s frontend/dist/ backend/dist

unlink-frontend:
	rm templates/index.html
	rm -r "frontend"

clear:
	curl -X POST localhost:8000/api/-/clear/

build:
	docker build . -t copas:$(VERSION)

run:
	docker run --rm --name copas -p 8100:8000 -d copas:$(VERSION)

stop:
	docker stop copas


build-frontend:
	cd frontend && ng build --base-href /static/


run-juice-shop-web:
	docker run --name juice-shop \
	-p 3000:3000 \
	-e "NODE_ENV=ctf" \
 	--rm \
 	-d \
 	bkimminich/juice-shop

stop-juice-shop-web:
	docker stop juice-shop

build-rtb:
	cd game_utils/rootthebox && docker build --progress=plain . -t rootthebox:latest

build-rtb-juice-shop:
	cd games/owasp_juice_shop && docker build --progress=plain . -t rtb-juice-shop:latest

run-rtb-juice-shop:
	docker network create rootthebox
	docker run --name memcached \
	--network rootthebox \
	-p 11212:11211 \
	--rm \
	-d \
	memcached:latest
	 docker run --name rootthebox \
 	--network rootthebox \
 	-p 8888:8888 \
 	--rm \
 	-d \
 	rtb-juice-shop:latest

stop-rtb-juice-shop:
	docker stop rootthebox
	docker stop memcached
	docker network rm rootthebox

run-juice-shop:
	docker run --rm \
	--name copas \
	-p 8100:8000 \
	-d \
	-v /home/simon/Documents/bc/copas/games/owasp_juice_shop:/app/config \
	copas:$(VERSION)
	$(MAKE) run-juice-shop-web
	$(MAKE) run-rtb-juice-shop

stop-juice-shop:
	$(MAKE) stop \
	$(MAKE) stop-juice-shop-web
	$(MAKE) stop-rtb-juice-shop
