ARG BASE_IMAGE=python:3.8-alpine

FROM ${BASE_IMAGE} AS base
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV VIRTUAL_ENV=/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apk update && \
    apk add --no-cache g++ gcc libffi-dev openssl-dev musl-dev
WORKDIR /code

RUN pip install --upgrade pip wheel poetry

COPY pyproject.toml /code/pyproject.toml
COPY poetry.lock /code/poetry.lock

RUN poetry install

COPY . /code

RUN pip install .

CMD ["pytest"]
