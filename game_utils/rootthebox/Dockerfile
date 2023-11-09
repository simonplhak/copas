FROM python:3.8
# todo check if version can be bumbed up

RUN apt-get update && apt-get install -y \
	build-essential zlib1g-dev rustc \
	python3-pycurl sqlite3 libsqlite3-dev

RUN git clone https://github.com/moloch--/RootTheBox.git

RUN mkdir /opt/rtb && mv RootTheBox/* /opt/rtb

ENV SQL_DIALECT=sqlite

WORKDIR /opt/rtb

RUN ./setup/depends.sh

COPY rootthebox.cfg files/rootthebox.cfg

RUN python3 rootthebox.py --tests=True --setup=prod

ENTRYPOINT ["python3", "/opt/rtb/rootthebox.py", "--start"]
