from os.path import expanduser, join

import pytest


@pytest.fixture
def home_dir():
    return expanduser("~")


@pytest.fixture
def neovim_root(home_dir):
    return join(home_dir, ".config/nvim")


@pytest.fixture
def init_vim(neovim_root):
    return join(neovim_root, "init.vim")


@pytest.fixture
def plugged_dir(neovim_root):
    return join(neovim_root, "plugged")
