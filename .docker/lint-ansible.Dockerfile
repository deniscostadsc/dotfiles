FROM python:3.14-rc-alpine

RUN mkdir /code
WORKDIR /code

RUN apk add build-base libffi-dev bash

COPY .docker/requirements.txt /code/
RUN pip install -r requirements.txt

RUN ansible-galaxy collection install community.general

CMD ./scripts/lint-yml.sh && ansible-lint
