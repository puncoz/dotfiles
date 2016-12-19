include makefiles/dotfiles.mk
include makefiles/bootstrap.mk

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
