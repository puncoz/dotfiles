# TODO: Convert to Haskell script using shell-conduit

SHELL=bash
DOCKER_OPTS=--tty --interactive --rm
IMAGE=lwm/xenial
LNARGS=--force --symbolic --verbose

dockerize:
	docker run $(DOCKER_OPTS) $(IMAGE) /bin/sh -ci '$(CMDS)'

~/.mutt/muttrc:
	@ln $(LNARGS) $(realpath dotfiles/mutt/$(@F)) $@

~/.stack/config.yaml:
	@ln $(LNARGS) $(realpath dotfiles/stack/$(@F)) $@

~/.gtimelog/gtimelogrc:
	@ln $(LNARGS) $(realpath dotfiles/gtimelog/$(@F)) $@

~/.config/nvim/init.vim:
	@ln $(LNARGS) $(realpath dotfiles/nvim/$(@F)) $@

~/.newsbeuter/config:
	@ln $(LNARGS) $(realpath dotfiles/newsbeuter/$(@F)) $@

~/.newsbeuter/urls:
	@ln $(LNARGS) $(realpath dotfiles/newsbeuter/$(@F)) $@

~/.ctags:
	@ln $(LNARGS) $(realpath dotfiles/exuberant-ctags/ctags) $@

~/.msmtprc:
	@ln $(LNARGS) $(realpath dotfiles/msmtp/msmtprc) $@

~/.ghci:
	@ln $(LNARGS) $(realpath dotfiles/ghc/ghci) $@

~/.gitconfig:
	@ln $(LNARGS) $(realpath dotfiles/git/gitconfig) $@

~/.gitignore_global:
	@ln $(LNARGS) $(realpath dotfiles/git/gitignore_global) $@

~/.reminders:
	@ln $(LNARGS) $(realpath dotfiles/remind/reminders) $@

~/.tmux.conf:
	@ln $(LNARGS) $(realpath dotfiles/tmux/tmux.conf) $@

~/.tmuxinator/daily.yml:
	@ln $(LNARGS) $(realpath dotfiles/tmuxinator/$(@F)) $@

~/.zshrc:
	@ln $(LNARGS) $(realpath dotfiles/zsh/zshrc) $@

~/.zsha:
	@ln $(LNARGS) $(realpath dotfiles/zsh/zsha) $@

~/.zshf:
	@ln $(LNARGS) $(realpath dotfiles/zsh/zshf) $@

update:
	@sudo apt update

upgrade:
	@sudo apt upgrade

curl:
	@sudo apt install -y $@

tmux:
	@sudo apt install -y $@

git:
	@sudo apt install -y $@

stack:
	@sudo apt install -y $@

cmus:
	@sudo apt install -y $@

nvim:
	@sudo apt install -y software-properties-common
	@sudo apt install -y python-dev python-pip python3-dev python3-pip
	@sudo add-apt-repository -y ppa:neovim-ppa/unstable
	@$(MAKE) update
	@sudo apt install -y neovim

oh-my-zsh: git
	@git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

rvm:
	@gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	@curl -sSL https://get.rvm.io | bash -s stable --ruby

ruby_2.3.0:
	@rvm install ruby-2.3.0

tmuxinator_gemset:
	@rvm use 2.3.0
	@rvm gemset use tmuxinator --create

tmuxinator:
	@rvm gemset use tmuxinator && gem install tmuxinator

autoenv: git
	@git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

nvim_plugins: nvim curl ~/.config/nvim/init.vim
	@curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://git.io/VgrSsw
	@nvim +PlugInstall

pyenv:
	@git clone https://github.com/yyuu/pyenv.git ~/.pyenv

pyenv_3.5.2: pyenv
	@pyenv install 3.5.2

pyenv_2.7.12: pyenv
	@pyenv install 2.7.12

dotfiles:
	@$(MAKE) --always-make --silent \
	~/.mutt/muttrc \
	~/.stack/config.yaml \
	~/.gtimelog/gtimelogrc \
	~/.config/nvim/init.vim \
	~/.newsbeuter/config \
	~/.newsbeuter/urls \
	~/.ctags \
	~/.msmtprc \
	~/.ghci \
	~/.gitconfig \
	~/.gitignore_global \
	~/.reminders \
	~/.tmux.conf \
	~/.tmuxinator/daily.yml \
	~/.zshrc \
	~/.zsha \
	~/.zshf \
	| sort | column -t
.PHONY: dotfiles
