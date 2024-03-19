FROM alpine:latest

RUN apk -U upgrade && apk add bash shellcheck shfmt

RUN mkdir /code
WORKDIR /code

CMD ./scripts/lint-sh.sh
