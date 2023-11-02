#It instructs Docker Engine to use official python:3.10 as the base image
#FROM python:3.10
FROM docker:dind

#It creates a working directory(app) for the Docker image and container
RUN apk add python3
RUN apk add py3-pip

WORKDIR /app

# RUN #pip install poetry==1.3.2

#It copies the framework and the dependencies for the FastAPI application into the working directory
#COPY backend/poetry.lock backend/pyproject.toml /app/
COPY backend/requirements.txt /app/

#Turn of creation of virtualenv(docker is already isolated) and install the framework and the dependencies
#RUN poetry config virtualenvs.create false && poetry install --without
RUN pip install -r /app/requirements.txt

#Copies application into docker image
COPY /backend/ /app

COPY /frontend/dist/ /app/static/dist

#It will expose the FastAPI application on port `8000` inside the container
EXPOSE 8000

RUN export PRODUCTION=1
ENV PRODUCTION=1

#It is the command that will start and run the FastAPI application container
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0"]
