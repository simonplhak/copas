FINAL_TAG:=registry.gitlab.com/plhak.s/copas/owasp_juice_shop.master

build:
	cd ../.. && make build-ctfd
	docker build . -t copas.ctfd.owasp_juice_shop:latest -f master.Dockerfile

run-master:
	docker run \
		--rm \
		--name copas.ctfd.owasp_juice_shop \
		-p 8001:8001 \
		-p 8002:8002 \
		-p 3000:3000 \
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
		-p 3000:3000 \
		-e HTTP_PORT=8001 \
		-e MASTER_HTTP_PORT=8001 \
		-e CTFD_PORT=8002 \
		--network=copas \
		$(FINAL_TAG):latest


create-juice-shop-import:
	juice-shop-ctf -c owasp_config.yml

run-player:
	docker run \
		--rm \
		--name copas.player \
		-p 8004:8004 \
		-e HTTP_PORT=8004 \
		--network=copas \
		copas:latest


commit:
	docker commit copas.ctfd.owasp_juice_shop $(FINAL_TAG)

export:
	docker push $(FINAL_TAG)
