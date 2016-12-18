FROM ubuntu:xenial

RUN apt update
RUN apt install -y make sudo

ADD makefiles makefiles
COPY Makefile .
