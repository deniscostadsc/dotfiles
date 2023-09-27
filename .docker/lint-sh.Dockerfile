FROM alpine:latest

RUN apk -U upgrade && apk add shellcheck bash

RUN mkdir /code
WORKDIR /code

CMD ./scripts/lint-sh.sh
