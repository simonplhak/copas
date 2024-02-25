build:
	docker build . -t copas.ctfd:latest

run:
	docker run \
		--rm \
		--name copas.ctfd \
		-p 8004:8004 \
		-p 8005:8005 \
		-v /home/simon/Documents/bc/copas/games/owasp_juice_shop/config.yml:/app/config.yml \
		-v /home/simon/Documents/bc/copas/games/owasp_juice_shop/ctfd_backup.zip:/ctfd/ctfd_backup.zip \
		-e ROLE=master \
		-e HTTP_PORT=8004 \
		-e CTFD_PORT=8005 \
		-e CTFD_CONFIG=/ctfd/ctfd_backup.zip \
		-e CTFD_ADMIN_TOKEN=ctfd_36a898496644fba42c3c29234662b454e09d48ddeeb8d279f7b279488fbc5d71 \
		copas.ctfd:latest
