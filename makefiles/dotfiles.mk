# TODO: change target names to the files

symlink: LNARGS:=--force --symbolic --verbose
symlink:
	ln $(LNARGS) $(realpath $(FPATH)) $(FLINK)

mutt: FPATH:=dotfiles/mutt/muttrc
mutt: FLINK:=~/.mutt/muttrc
mutt: symlink

irssi: FPATH:=dotfiles/irssi/config
irssi: FLINK:=~/.irssi/config
irssi: symlink

stack: FPATH:=dotfiles/stack/config.yaml
stack: FLINK:=~/.stack/config.yaml
stack: symlink

nvim: FPATH:=dotfiles/nvim/init.vim
nvim: FLINK:=~/.config/nvim/init.vim
nvim: symlink

newsbeuter_conf: FPATH:=dotfiles/newsbeuter/config
newsbeuter_conf: FLINK:=~/.newsbeuter/config
newsbeuter_conf: symlink

newsbeuter_url: FPATH:=dotfiles/newsbeuter/urls
newsbeuter_url: FLINK:=~/.newsbeuter/urls
newsbeuter_url: symlink

ctags: FPATH:=dotfiles/exuberant-ctags/ctags
ctags: FLINK:=~/.ctags
ctags: symlink

ghci: FPATH:=dotfiles/ghc/ghci
ghci: FLINK:=~/.ghci
ghci: symlink

git_config: FPATH:=dotfiles/git/gitconfig
git_config: FLINK:=~/.gitconfig
git_config: symlink

git_ignore: FPATH:=dotfiles/git/gitignore_global
git_ignore: FLINK:=~/.gitignore_global
git_ignore: symlink

remind: FPATH:=dotfiles/remind/reminders
remind: FLINK:=~/.reminders
remind: symlink

tmux: FPATH:=dotfiles/tmux/tmux.conf
tmux: FLINK:=~/.tmux.conf
tmux: symlink

tmux_daily: FPATH:=tmuxinator/daily.yml
tmux_daily: FLINK:=~/.tmuxinator/daily.yml
tmux_daily: symlink

.zshrc: FPATH:=dotfiles/zsh/zshrc
.zshrc: FLINK:=~/.zshrc
.zshrc: symlink

dotfiles:
	@$(MAKE) -s nvim 
	@$(MAKE) -s tmux
	@$(MAKE) -s remind
	@$(MAKE) -s git_ignore
	@$(MAKE) -s git_config
	@$(MAKE) -s ghci
	@$(MAKE) -s ctags
	@$(MAKE) -s mutt
	@$(MAKE) -s irssi
	@$(MAKE) -s stack
	@$(MAKE) -s newsbeuter_conf
	@$(MAKE) -s newsbeuter_url
	@$(MAKE) -s tmux_daily
	@$(MAKE) -s .zshrc
.PHONY: dotfiles
