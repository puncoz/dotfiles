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
