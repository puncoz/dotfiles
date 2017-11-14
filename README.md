[![Build Status](https://travis-ci.org/lwm/dotfiles.svg?branch=master)](https://travis-ci.org/lwm/dotfiles)

# dotfiles

My [Debian Stretch] system configuration files.

[Debian Stretch]: https://www.debian.org/

Mostly plundered on the high seas of the internet.

# Test It

I provision my system with [Ansible].

[Ansible]: https://docs.ansible.com/

This is tested on a per commit basis with [Travis CI].

[Travis CI]: https://travis-ci.org/lwm/dotfiles/builds/

You can see what the system feels like by running:

```bash
$ cd ansible && make dockerbuild && make ansiblerun
```

# Provision It

To get a system configured, install [pipenv] and:

[pipenv]: https://docs.pipenv.org/install.html#fancy-installation-of-pipenv

```bash
$ cd ansible
$ pipenv install --dev --three
$ pipenv run ansible-playbook -i localhost
```
