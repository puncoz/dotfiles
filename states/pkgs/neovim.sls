neovim-ppa:
  pkgrepo.managed:
    - ppa: neovim-ppa/stable

neovim:
  pkg:
    - installed
    - require:
      - pkgrepo: neovim-ppa

# FIXME:
# Symlink the correct file
# Install the plugins
