frontend_dir=../copas_game_frontend

VERSION ?= latest

update:
	git submodule update --remote --recursive

link-frontend:
	mkdir -p "static"
	ln -s ../../copas_games_frontened/dist/copas_games_frontened/ static/dist
	#ln  -s ../static/dist/copas_game_frontend/index.html templates/index.html

unlink-frontend:
	rm templates/index.html
	rm -r "frontend"


build:
	docker build . -t copas:$(VERSION)

run:
	docker run --name copas -p 8100:8000 copas:$(VERSION)

stop:
	docker stop copas && docker rm copas
