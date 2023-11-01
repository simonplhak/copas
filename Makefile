VERSION ?= latest

update:
	git submodule update --remote --recursive

link-frontend:
	mkdir -p "backend/static/"
	ln -s frontend/dist/ backend/dist

unlink-frontend:
	rm templates/index.html
	rm -r "frontend"


build:
	docker build . -t copas:$(VERSION)

run:
	docker run --name copas -p 8100:8000 copas:$(VERSION)

stop:
	docker stop copas && docker rm copas


build-frontend:
	cd frontend && ng build --base-href /static/
