FROM python:3.14-rc-bullseye

RUN mkdir /code
WORKDIR /code

RUN wget https://raw.githubusercontent.com/aureliojargas/clitest/master/clitest
RUN chmod +x clitest
RUN mv clitest /usr/bin

CMD clitest $(find tests/ -name '*.txt')
