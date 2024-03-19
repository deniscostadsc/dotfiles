.PHONY: lint run test

run:
	ansible-playbook \
		--connection=local \
		--ask-become-pass \
		--extra-vars "current_user=$$USER home_folder=$$HOME" \
		-vv \
		-i inventory.ini \
		playbook.yml

lint:
	@docker build -q -f .docker/lint-ansible.Dockerfile -t lint-ansible .
	@docker build -q -f .docker/lint-sh.Dockerfile -t lint-sh .
	@docker run --rm --name dotfiles-lint-ansible -v $$(pwd):/code lint-ansible
	@docker run --rm --name dotfiles-lint-sh -v $$(pwd):/code lint-sh ./scripts/lint-sh.sh

lint-fix:
	@docker build -q -f .docker/lint-sh.Dockerfile -t lint-sh .
	@docker run --rm --name dotfiles-lint-sh -v $$(pwd):/code lint-sh shfmt -l -w .

test:
	@docker build -q -f .docker/tests.Dockerfile -t tests .
	@docker run --rm --name tests -v $$(pwd):/code tests
