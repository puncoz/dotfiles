"""Are all those packages you wanted installed correctly configured?"""

from os import listdir
from os.path import isfile, islink
from shutil import which

from tests.utils import match_neovim_plugins, parse_neovim_plugins


def test_neovim():
    assert which("nvim") is not None


def test_neovim_configuration(init_vim):
    assert isfile(init_vim) and islink(init_vim)


def test_neovim_plugins(init_vim, plugged_dir):
    installed_plugins = listdir(plugged_dir)
    parsed_plugins = parse_neovim_plugins(init_vim)
    assert all((
        match_neovim_plugins(installed_plugins, plugin)
        for plugin in parsed_plugins
    ))
