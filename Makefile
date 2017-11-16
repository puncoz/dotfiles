IMAGE      := dotfiles
WORKDIR    := /var/dotfiles

build:
	@docker build -t $(IMAGE) .
.PHONY: build

run:
	@docker run -ti $(IMAGE) bash
.PHONY: run

test:
	@docker run \
	-v $$(pwd):$(WORKDIR) \
	-ti $(IMAGE) \
	ansible-playbook bootstrap.yml \
	--inventory "localhost" \
	--skip-tags="install" \
	--skip-tags="longrun"
.PHONY: test

bootstrap:
	@ansible-playbook --inventory localhost bootstrap.yml
.PHONY: bootstrap
