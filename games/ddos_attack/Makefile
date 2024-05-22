FINAL_TAG:=registry.gitlab.com/plhak.s/copas/ddos_attack.master

build-master-all:
	cd ../.. && make build
	docker build . --tag copas.ddos_attack.master:latest -f master.Dockerfile

build-master:
	docker build . --tag copas.ddos_attack.master:latest -f master.Dockerfile

run-master:
	docker run \
		--rm \
		--name copas.ddos_attack.master \
		-p 8000:8000 \
		-p 8080:8080 \
		-p 8081:8081 \
		-e L1_MAX_REQUESTS_PER_SECOND=10 \
		-e L2_MAX_REQUESTS_PER_SECOND=10 \
		--network=copas \
		copas.ddos_attack.master:latest

run-master-global:
	docker run \
		--rm \
		--name copas.ddos_attack.master \
		-p 8000:8000 \
		-p 8080:8080 \
		-p 8081:8081 \
		-e L1_MAX_REQUESTS_PER_SECOND=10 \
		-e L2_MAX_REQUESTS_PER_SECOND=10 \
		--net=host \
		copas.ddos_attack.master:latest


run-player:
	docker run \
		--rm \
		--name copas.player \
		-p 8002:8002 \
		-e HTTP_PORT=8002 \
		--network=copas \
		copas:latest

export:
	docker tag copas.ddos_attack.master $(FINAL_TAG)
	docker push $(FINAL_TAG)
