FROM python:3.11.4

RUN pip install -U pip pip-tools

RUN mkdir /code
WORKDIR /code

COPY .docker/lint-ansible-requirements.lock /code/
RUN pip install -r lint-ansible-requirements.lock

CMD ./scripts/lint-ansible-requirements-update.sh 2> /dev/null && ansible-lint
