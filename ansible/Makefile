ROLES := roles
IMAGE := dotfiles

newrole:
	@mkdir -p $(ROLES)/$(NEWROLE) $(ROLES)/$(NEWROLE)/tasks && \
	echo "---" > $(ROLES)/$(NEWROLE)/tasks/main.yml
.PHONY: newrole

dockerbuild:
	@docker build -t $(dotfiles) .
.PHONY: build

ansiblerun:
	@echo 'TODO!'
	# TODO: Run the bootstrap.yml inside the Debian container!
.PHONY: ansiblerun
