.PHONY: \
	__build_lint_ansible \
	__build_lint_sh \
	__build_lint_tests \
	__check_pre_commit \
	decrypt-secrets \
	encrypt-secrets \
	help \
	install-git-hook \
	lint \
	lint-fix \
	run \
	run-public \
	run-simple \
	run-user \
	test

DOCKER_RUN := docker run --rm -v $$(pwd):/code --name
DOCKER_BUILD := docker build -q -f
SKIP_SECRETS ?= false

__build_lint_sh:
	@$(DOCKER_BUILD) .docker/lint-sh.Dockerfile -t lint-sh .

__build_lint_ansible:
	@$(DOCKER_BUILD) .docker/lint-ansible.Dockerfile -t lint-ansible .

__build_lint_tests:
	@$(DOCKER_BUILD) .docker/tests.Dockerfile -t tests .

__check_pre_commit:
	@if [[ ! -f ./.git/hooks/pre-commit-check-secrets-file.sh ]]; then \
		echo "Before decrypting secrets file run: make install-git-hook"; \
		exit 1; \
	fi

decrypt-secrets: __check_pre_commit
	ansible-vault decrypt secrets.enc

encrypt-secrets:
	ansible-vault encrypt secrets.enc

help:
	@echo "Available targets:"
	@echo ""
	@grep -E '^[a-zA-Z0-9_-]+:' $(MAKEFILE_LIST) | grep -v '^__' | cut -d: -f1

install-git-hook:
	@cp ./scripts/pre-commit-check-secrets-file.sh ./.git/hooks/

lint: __build_lint_ansible __build_lint_sh
	@$(DOCKER_RUN) dotfiles-lint-ansible lint-ansible
	@$(DOCKER_RUN) dotfiles-lint-sh lint-sh ./scripts/lint-sh.sh

lint-fix: __build_lint_sh
	@$(DOCKER_RUN) dotfiles-lint-sh lint-sh shfmt -l -w .

run:
	@ansible-playbook \
		--connection=local \
		--ask-become-pass \
		--extra-vars "current_user=$$USER home_folder=$$HOME skip_secrets=false skip_root=false" \
		-vv \
		-i inventory.ini \
		-e @secrets.enc --ask-vault-pass \
		playbook.yml

run-public:
		@ansible-playbook \
		--connection=local \
		--ask-become-pass \
		--extra-vars "current_user=$$USER home_folder=$$HOME skip_secrets=true skip_root=false" \
		-vv \
		-i inventory.ini \
		playbook.yml

run-user:
	@ansible-playbook \
		--connection=local \
		--extra-vars "current_user=$$USER home_folder=$$HOME skip_secrets=false skip_root=true" \
		-vv \
		-i inventory.ini \
		-e @secrets.enc --ask-vault-pass \
		playbook.yml

run-simple:
	@ansible-playbook \
		--connection=local \
		--extra-vars "current_user=$$USER home_folder=$$HOME skip_secrets=true skip_root=true" \
		-vv \
		-i inventory.ini \
		playbook.yml
