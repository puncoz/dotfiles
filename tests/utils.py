"""Testing utility functions."""

from functools import partial
from re import search


def matcher(regex, iterable):
    """Grab all the matches from the iterable."""
    func = partial(search, regex)
    matches = filter(None, map(func, iterable))
    return [match.group() for match in matches]


def parse_neovim_plugins(fpath):
    """Get list of Neovim plugins from fpath."""
    contents = open(fpath).read().split("\n")

    plug_def_regex = r"Plug\s'(.*?)'"
    plug_defs = matcher(plug_def_regex, contents)

    plug_name_regex = r"(?<=/)(.*?)(?=')"
    return matcher(plug_name_regex, plug_defs)


def match_neovim_plugins(installed, parsed):
    """Holistically match installed and parsed plugins."""
    potentials = ["vim-"+parsed, parsed+".vim", parsed+"-vim", parsed]
    return any((p in installed for p in potentials))
