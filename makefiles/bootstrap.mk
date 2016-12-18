SHELL:=bash

DOCKER_OPTS:=--tty --interactive --rm
IMAGE:=lwm/xenial
dockerize:
	docker run $(DOCKER_OPTS) $(IMAGE) /bin/sh -ci '$(CMDS)'
.PHONY: dockerize

update:
	sudo apt update
.PHONY: update

upgrade:
	sudo apt upgrade
.PHONY: upgrade

install:
	@sudo apt install -y $(PROGRAM)
.PHONY: install

apti_curl: PROGRAM:=curl
apti_curl: install

apti_tmux: PROGRAM:=tmux
apti_tmux: install

apti_git: PROGRAM:=git
apti_git: install

rvm: apti_curl
	@gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	@curl -sSL https://get.rvm.io | bash -s stable --ruby

rvm_ruby: rvm
	bash -l -c 'rvm install ruby-2.3.0'

install_tmuxinator: rvm_ruby
	bash -l -c 'rvm gemset use tmuxinator --create && gem install tmuxinator'
.PHONY: tmuxinator

autoenv: apti_git
	git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

local_autoenv_files: autoenv
	@echo ". .venv/bin/activate" >> ~/.env
	@echo "rvm use 2.3.0" >> ~/.env
	@echo "rvm gemset use tmuxinator --create" >> ~/.env

# install rvm
# install pyenv
# install nvim (plugins)
# get new zsh manager
