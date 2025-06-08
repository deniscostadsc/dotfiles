FROM python:3.14-rc-alpine

RUN mkdir /code
WORKDIR /code

RUN apk add build-base libffi-dev bash

COPY .docker/requirements.txt roles/requirements.yml /code/
RUN pip install -r requirements.txt

RUN ansible-galaxy collection install --requirements-file requirements.yml

CMD ./scripts/lint-yml.sh && ansible-lint
