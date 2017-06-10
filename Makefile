PROJECT_ROOT  = .
DOTFILES_ROOT = ./dotfiles/

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "test: to run the tests"
.PHONY: help

test:
	py.test -v
.PHONY: test
