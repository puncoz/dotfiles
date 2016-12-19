SHELL:=bash

DOCKER_OPTS:=--tty --interactive --rm
IMAGE:=lwm/xenial
dockerize:
	docker run $(DOCKER_OPTS) $(IMAGE) /bin/sh -ci '$(CMDS)'

update:
	sudo apt update

upgrade:
	sudo apt upgrade

curl: update
	@sudo apt install -y $@

tmux: update
	@sudo apt install -y $@

git: update
	@sudo apt install -y $@

rvm: curl
	@gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	@curl -sSL https://get.rvm.io | bash -s stable --ruby

ruby_2.3.0: rvm
	bash -l -c 'rvm install ruby-2.3.0'

tmuxinator_gemset: ruby_2.3.0
	bash -l -c 'rvm use 2.3.0 && rvm gemset use tmuxinator --create'

tmuxinator: tmuxinator_gemset
	bash -l -c 'rvm gemset use tmuxinator && gem install tmuxinator'

autoenv: apti_git
	git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

pyenv:
	#TODO

nvim:
	#TODO

stack:
	#TODO
