build:
	docker build . -t copas.ctfd:latest

run:
	docker run \
		--rm \
		--name copas.ctfd \
		-p 8004:8004 \
		-p 8005:8005 \
		-v /home/simon/Documents/bc/copas/backend/config.yml:/app/config.yml \
		-v /home/simon/Documents/bc/copas/games_utils/ctfd/ctfd_blank_backup.zip:/ctfd/ctfd_backup.zip \
		-e ROLE=master \
		-e HTTP_PORT=8004 \
		-e CTFD_PORT=8005 \
		-e CTFD_CONFIG=/ctfd/ctfd_backup.zip \
		-e CTFD_ADMIN_TOKEN=ctfd_9cc6c4906617986493209fcb6cbe3b82f247a6776b4dda3f114d11dc7aba7c81 \
		copas.ctfd:latest
