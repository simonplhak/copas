FROM node:21.4.0 as frontend_builder

# Set the working directory
WORKDIR /frontend

# Copy package.json and package-lock.json
COPY frontend/package*.json /frontend

# Install Next.js and dependencies
RUN npm install

# Copy the rest of the source code
COPY frontend /frontend

# Build the Next.js project for production use
RUN npm run build

#It instructs Docker Engine to use official python:3.10 as the base image
FROM ubuntu:22.04

# install Python 3.10
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install -y python3.10 python3-pip

# install supervisord for running multiple processes
RUN pip install supervisor

#It creates a working directory(app) for the Docker image and container
WORKDIR /app

RUN pip install poetry==1.3.2

#It copies the framework and the dependencies for the FastAPI application into the working directory
COPY backend/poetry.lock backend/pyproject.toml /app/

#Turn of creation of virtualenv(docker is already isolated) and install the framework and the dependencies
RUN poetry config virtualenvs.create false && poetry install

#Copies application into docker image
COPY /backend/ /app

# Copy the built Next.js files from the builder image
COPY --from=frontend_builder /frontend/out /app/out

#It will expose the FastAPI application on port `8000` inside the container
EXPOSE 8000

# set default env variables
ENV PRODUCTION=true
ENV HOST="http://localhost:8000/api"
ENV HTTP_PORT="8000"
ENV MASTER_HTTP_PORT="8000"

# Copy the supervisord configuration file
COPY supervisord.conf /etc/supervisord.conf

# start supervisord
CMD supervisord -c /etc/supervisord.conf
