start:
	docker build . --tag ctf-telnet
	docker run -p 9023:23 --name ctf-telnet -d ctf-telnet

stop:
	docker stop ctf-telnet
	docker rm ctf-telnet
