.PHONY: \
	__build_lint_ansible \
	__build_lint_sh \
	__build_lint_tests \
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
		playbook.yml

test: __build_lint_tests
	@$(DOCKER_RUN) dotfiles-tests tests
