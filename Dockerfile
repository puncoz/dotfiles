FROM ubuntu:xenial

RUN apt update
RUN apt install -y make sudo

COPY Makefile .
