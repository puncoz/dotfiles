FROM debian:stretch

ENV LANG C.UTF-8
ENV SHELL /bin/bash

RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get install -y python3 python3-pip

RUN pip3 install ansible

WORKDIR /var/dotfiles
