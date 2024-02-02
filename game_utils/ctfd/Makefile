build:
	docker build . -t copas.ctfd:latest

run:
	docker run \
		--rm \
		--name copas.ctfd \
		-p 8004:8004 \
		-p 8005:8005 \
		-v /home/simon/Documents/bc/copas/games/owasp_juice_shop/config.yml:/app/config.yml \
		-v /home/simon/Documents/bc/copas/games/owasp_juice_shop/owasp_config.zip:/ctfd/owasp_config.zip \
		-e ROLE=master \
		-e HTTP_PORT=8004 \
		-e CTFD_PORT=8005 \
		-e CTFD_CONFIG=/ctfd/owasp_config.zip \
		-e CTFD_ADMIN_TOKEN=ctfd_c00f4d5832504faa924629d90f7e885db07faa03cd1deafe26e2cf05983611a4 \
		copas.ctfd:latest
