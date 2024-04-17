build:
	docker build . -t copas.ctfd:latest

run:
	docker run \
		--rm \
		--name copas.ctfd \
		-p 8001:8001 \
		-p 8002:8002 \
		-v /home/simon/Documents/bc/copas/backend/config.yml:/app/config.yml \
		-e HTTP_PORT=8001 \
		-e CTFD_PORT=8002 \
		copas.ctfd:latest


store-token:
	@if [ -z "$$TOKEN" ]; then \
		echo "No argument provided. Usage: make store-token TOKEN='<token>'"; \
		exit 1; \
	fi
	@docker exec -it copas.ctfd sh -c "echo $$TOKEN > /etc/ctfd.secret"


store-image:
	@if [ -z "$$NAME" ]; then \
		echo "No argument provided. Usage: make store-image NAME='<name>'"; \
		exit 1; \
	fi
	docker commit copas.ctfd ${NAME}
