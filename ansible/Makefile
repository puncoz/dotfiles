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
	ansible-playbook bootstrap.yml \
	--inventory "localhost" \
	--skip-tags="install" \
	--skip-tags="longrun"
.PHONY: ansiblerun

bootstrap:
	@sudo ansible-playbook --inventory localhost bootstrap.yml -vv
.PHONY: bootstrap
