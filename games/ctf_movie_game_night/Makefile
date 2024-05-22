FINAL_TAG_PLAYER:=registry.gitlab.com/plhak.s/copas/movie_game.player
FINAL_TAG_MASTER:=registry.gitlab.com/plhak.s/copas/movie_game.master

build-player:
	docker build . --tag copas.movie_game.player:latest -f player.Dockerfile

run-player:
	docker run \
		--rm \
		--name copas.movie_game.player \
		-p 8022:8022 \
		-p 8080:8080 \
		-e HTTP_PORT=8022 \
		--network=copas \
		copas.movie_game.player:latest

run-player-2:
	docker run \
		--rm \
		--name copas.movie_game.player.1 \
		-p 8023:8023 \
		-p 8081:8080 \
		-e HTTP_PORT=8023 \
		--network=copas \
		copas.movie_game.player:latest

run-player-global:
	docker run \
		--rm \
		--name copas.movie_game.player \
		-p 8000:8000 \
		-p 8080:8080 \
		copas.movie_game.player:latest


build-master:
	docker build . --tag copas.movie_game.master:latest -f master.Dockerfile

run-master:
	docker run \
		--rm \
		--name copas.movie_game.master \
		-p 8000:8000 \
		-p 8001:8001 \
		--network=copas \
		copas.movie_game.master:latest

run-master-global:
	docker run \
		--rm \
		--name copas.movie_game.master \
		-p 8000:8000 \
		-p 8001:8001 \
		--net=host \
		copas.movie_game.master:latest

stop:
	docker stop copas.web_protocol

export-master:
	docker tag copas.movie_game.master $(FINAL_TAG_MASTER)
	docker push $(FINAL_TAG_MASTER)

export-player:
	docker tag copas.movie_game.player $(FINAL_TAG_PLAYER)
	docker push $(FINAL_TAG_PLAYER)
