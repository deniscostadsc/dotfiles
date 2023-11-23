FROM python:3.11.4

RUN mkdir /code
WORKDIR /code

RUN apt update -y && apt install -y xclip

RUN wget https://raw.githubusercontent.com/aureliojargas/clitest/master/clitest
RUN chmod +x clitest
RUN mv clitest /usr/bin

CMD clitest $(find tests/ -name '*.txt')
