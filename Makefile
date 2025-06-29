.PHONY: \
	__build_lint_ansible \
	__build_lint_sh \
	__build_lint_tests \
	__check_pre_commit \
	decrypt-secrets \
	encrypt-secrets \
	install-git-hook \
	lint \
	lint-fix \
	run \
	test

DOCKER_RUN := docker run --rm -v $$(pwd):/code --name
DOCKER_BUILD := docker build -q -f

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

install-git-hook:
	@cp ./scripts/pre-commit-check-secrets-file.sh ./.git/hooks/

lint: __build_lint_ansible __build_lint_sh
	@$(DOCKER_RUN) dotfiles-lint-ansible lint-ansible
	@$(DOCKER_RUN) dotfiles-lint-sh lint-sh ./scripts/lint-sh.sh

lint-fix: __build_lint_sh
	@$(DOCKER_RUN) dotfiles-lint-sh lint-sh shfmt -l -w .

run:
	ansible-playbook \
		--connection=local \
		--ask-become-pass \
		--extra-vars "current_user=$$USER home_folder=$$HOME" \
		-vv \
		-i inventory.ini \
		-e @secrets.enc --ask-vault-pass \
		playbook.yml

test: __build_lint_tests
	@$(DOCKER_RUN) dotfiles-tests tests
