FROM python:3.11.4

RUN pip install -U pip pip-tools

RUN mkdir /code
WORKDIR /code

COPY .docker/lint-ansible-requirements.lock /code/
RUN pip install -r lint-ansible-requirements.lock

RUN ansible-galaxy collection install community.general

CMD ./scripts/update-requirements.sh .docker/lint-ansible-requirements.txt 2> /dev/null && \
    ./scripts/lint-yml.sh && \
    ansible-lint
