ROLES      := roles
IMAGE      := dotfiles
WORKDIR    := /var/dotfiles
DOCKERHOME := /root

# Quick and dumb way to create a new role.
# Run like this: NEWROLE=foobar make newrole
newrole:
	@mkdir -p $(ROLES)/$(NEWROLE) $(ROLES)/$(NEWROLE)/tasks && \
	echo "---" > $(ROLES)/$(NEWROLE)/tasks/main.yml
.PHONY: newrole

# Build the docker image
dockerbuild:
	@docker build -t $(IMAGE) .
.PHONY: dockerbuild

# Drop into a bash shell on the built container
dockerrun:
	@docker run -ti $(IMAGE) bash
.PHONY: dockerrun

# Run the Ansible bootstrap playbook
ansiblerun:
	@docker run \
	-v $$(pwd):$(WORKDIR) \
	-ti $(IMAGE) \
	ansible-playbook -i "localhost" bootstrap.yml
.PHONY: ansiblerun
