FROM debian:stretch

ENV LANG C.UTF-8
ENV SHELL /bin/bash

RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get install -y \
  ctags \
  curl \
  git \
  gnupg \
  gtimelog \
  haskell-stack \
  ipython3 \
  msmtp \
  mutt \
  neovim \
  newsbeuter \
  python3 \
  python3-pip \
  tmux \
  wget \
  zsh

RUN pip3 install ansible

WORKDIR /var/dotfiles
