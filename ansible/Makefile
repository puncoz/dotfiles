ROLES      := roles
IMAGE      := dotfiles
WORKDIR    := /var/dotfiles
DOCKERHOME := /root

dockerbuild:
	@docker build -t $(IMAGE) .
.PHONY: dockerbuild

dockerrun:
	@docker run -ti $(IMAGE) bash
.PHONY: dockerrun

ansiblerun:
	@docker run \
	-v $$(pwd):$(WORKDIR) \
	-ti $(IMAGE) \
	ansible-playbook -i "localhost" bootstrap.yml --skip-tags="install"
.PHONY: ansiblerun
