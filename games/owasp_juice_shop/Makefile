FINAL_TAG_MASTER:=registry.gitlab.com/plhak.s/copas/owasp_juice_shop.master
FINAL_TAG_PLAYER:=registry.gitlab.com/plhak.s/copas/owasp_juice_shop.player

build-master-all:
	cd ../.. && make build-ctfd
	docker build . -t copas.ctfd.owasp_juice_shop:latest -f master.Dockerfile

build-master:
	docker build . -t copas.ctfd.owasp_juice_shop:latest -f master.Dockerfile

run-master:
	docker run \
		--rm \
		--name copas.ctfd.owasp_juice_shop \
		-p 8001:8001 \
		-p 8002:8002 \
		-e HTTP_PORT=8001 \
		-e MASTER_HTTP_PORT=8001 \
		-e CTFD_PORT=8002 \
		--network=copas \
		copas.ctfd.owasp_juice_shop:latest


run-master-export:
	docker run \
		--rm \
		--name copas.ctfd.owasp_juice_shop.export \
		-p 8001:8001 \
		-p 8002:8002 \
		-e HTTP_PORT=8001 \
		-e MASTER_HTTP_PORT=8001 \
		-e CTFD_PORT=8002 \
		--network=copas \
		$(FINAL_TAG_MASTER):latest

run-master-export-global:
	docker run \
		--rm \
		--name copas.ctfd.owasp_juice_shop.export \
		-p 8000:8000 \
		-p 8001:8001 \
		--net=host \
		$(FINAL_TAG_MASTER):latest


create-juice-shop-import:
	juice-shop-ctf -c owasp_config.yml

build-player-all:
	cd ../.. && make build
	docker build . -t copas.owasp_juice_shop.player:latest -f player.Dockerfile

build-player:
	docker build . -t copas.owasp_juice_shop.player:latest -f player.Dockerfile

run-player:
	docker run \
		--rm \
		--name copas.player \
		-p 8003:8003 \
		-p 3000:3000 \
		-e HTTP_PORT=8003 \
		--network=copas \
		copas.owasp_juice_shop.player:latest


run-player-global:
	docker run \
		--rm \
		--name copas.player \
		-p 8000:8000 \
		-p 3000:3000 \
		copas.owasp_juice_shop.player:latest

commit-master:
	docker commit copas.ctfd.owasp_juice_shop $(FINAL_TAG_MASTER)

export-master:
	docker push $(FINAL_TAG_MASTER)

export-player:
	docker tag copas.owasp_juice_shop.player $(FINAL_TAG_PLAYER)
	docker push $(FINAL_TAG_PLAYER)
