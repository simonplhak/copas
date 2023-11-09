# Root The Box

https://github.com/moloch--/RootTheBox/wiki

CTF framework

## Build

```shell
make build-rtb
```

Build is intended only as a base image for game specific rootthebox image.
E.g. Dockerfile for OWASP Juice Shop rootthebox image:

```Dockerfile
FROM rootthebox:latest

COPY ctf_config.xml ctf_config.xml

RUN python3 rootthebox.py --xml=ctf_config.xml
```

`--xml` flag is used to load game specific configuration.
