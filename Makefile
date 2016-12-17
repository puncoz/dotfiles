symlink: LNARGS:=--force --symbolic --verbose
symlink:
	ln $(LNARGS) $(realpath $(FPATH)) $(FLINK)
.PHONY: symlink

mutt: FPATH:=dotfiles/muttrc
mutt: FLINK:=~/.mutt/muttrc
mutt: symlink

irssi: FPATH:=dotfiles/irssi_config
irssi: FLINK:=~/.irssi/config
irssi: symlink

stack: FPATH:=dotfiles/config.yaml
stack: FLINK:=~/.stack/config.yaml
stack: symlink

nvim: FPATH:=dotfiles/init.vim
nvim: FLINK:=~/.config/nvim/init.vim
nvim: symlink

newsbeuter_conf: FPATH:=dotfiles/newsbeuter_config
newsbeuter_conf: FLINK:=~/.newsbeuter/config
newsbeuter_conf: symlink

newsbeuter_url: FPATH:=dotfiles/urls
newsbeuter_url: FLINK:=~/.newsbeuter/urls
newsbeuter_url: symlink

ctags: FPATH:=dotfiles/ctags
ctags: FLINK:=~/.ctags
ctags: symlink

ghci: FPATH:=dotfiles/ghci
ghci: FLINK:=~/.ghci
ghci: symlink

git_config: FPATH:=dotfiles/gitconfig
git_config: FLINK:=~/.gitconfig
git_config: symlink

git_ignore: FPATH:=dotfiles/gitignore_global
git_ignore: FLINK:=~/.gitignore_global
git_ignore: symlink

remind: FPATH:=dotfiles/reminders
remind: FLINK:=~/.reminders
remind: symlink

tmux: FPATH:=dotfiles/tmux.conf
tmux: FLINK:=~/.tmux.conf
tmux: symlink

regular_dotfiles:
	$(MAKE) tmux
	$(MAKE) remind
	$(MAKE) git_ignore
	$(MAKE) git_config
	$(MAKE) ghci
	$(MAKE) ctags
.PHONY: regular_dotfiles

irregular_dotfiles:
	$(MAKE) mutt
	$(MAKE) irssi
	$(MAKE) stack
	$(MAKE) newsbeuter_conf
	$(MAKE) newsbeuter_url
.PHONY: irregular_dotfiles

dotfiles: regular_dotfiles irregular_dotfiles
