SHELL:=bash

DOCKER_OPTS=--tty --interactive --rm
IMAGE=lwm/xenial
dockerize:
	docker run $(DOCKER_OPTS) $(IMAGE) /bin/sh -ci '$(CMDS)'


LNARGS=--force --symbolic --verbose
~/.mutt/muttrc:
	ln $(LNARGS) $(realpath dotfiles/mutt/$(@F)) $@

~/.irssi/config:
	ln $(LNARGS) $(realpath dotfiles/irssi/$(@F)) $@

~/.stack/config.yaml:
	ln $(LNARGS) $(realpath dotfiles/stack/$(@F)) $@

~/.config/nvim/init.vim:
	ln $(LNARGS) $(realpath dotfiles/nvim/$(@F)) $@

~/.newsbeuter/config:
	ln $(LNARGS) $(realpath dotfiles/newsbeuter/$(@F)) $@

~/.newsbeuter/urls:
	ln $(LNARGS) $(realpath dotfiles/newsbeuter/$(@F)) $@

~/.ctags:
	ln $(LNARGS) $(realpath dotfiles/exuberant-ctags/ctags) $@

~/.ghci:
	ln $(LNARGS) $(realpath dotfiles/ghc/ghci) $@

~/.gitconfig:
	ln $(LNARGS) $(realpath dotfiles/git/gitconfig) $@

~/.gitignore_global:
	ln $(LNARGS) $(realpath dotfiles/git/gitignore_global) $@

~/.reminders:
	ln $(LNARGS) $(realpath dotfiles/remind/reminders) $@

~/.tmux.conf:
	ln $(LNARGS) $(realpath dotfiles/tmux/tmux.conf) $@

~/.tmuxinator/daily.yml:
	ln $(LNARGS) $(realpath dotfiles/tmuxinator/$(@F)) $@

~/.zshrc:
	ln $(LNARGS) $(realpath dotfiles/zsh/zshrc) $@

update:
	sudo apt update

upgrade:
	sudo apt upgrade

curl:
	@sudo apt install -y $@

tmux:
	@sudo apt install -y $@

git:
	@sudo apt install -y $@

stack:
	@sudo apt install -y $@

nvim:
	@sudo apt install -y software-properties-common
	@sudo apt install -y python-dev python-pip python3-dev python3-pip
	@sudo add-apt-repository -y ppa:neovim-ppa/unstable
	@$(MAKE) update
	@sudo apt install -y neovim

oh-my-zsh: git
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

rvm:
	@gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	@curl -sSL https://get.rvm.io | bash -s stable --ruby

ruby_2.3.0:
	bash -l -c 'rvm install ruby-2.3.0'

tmuxinator_gemset:
	bash -l -c 'rvm use 2.3.0 && rvm gemset use tmuxinator --create'

tmuxinator:
	bash -l -c 'rvm gemset use tmuxinator && gem install tmuxinator'

autoenv: git
	git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

nvim_plugins: nvim curl ~/.config/nvim/init.vim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://git.io/VgrSsw
	nvim +PlugInstall

pyenv:
	#TODO

dotfiles:
	@$(MAKE) --always-make --silent \
	~/.mutt/muttrc \
	~/.irssi/config \
	~/.stack/config.yaml \
	~/.config/nvim/init.vim \
	~/.newsbeuter/config \
	~/.newsbeuter/urls \
	~/.ctags \
	~/.ghci \
	~/.gitconfig \
	~/.gitignore_global \
	~/.reminders \
	~/.tmux.conf \
	~/.tmuxinator/daily.yml \
	~/.zshrc \
	| sort | column -t
.PHONY: dotfiles
