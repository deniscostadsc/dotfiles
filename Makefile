.PHONY: run

run:
	ansible-playbook \
		--connection=local \
		--ask-become-pass \
		provisioning.yml -i hosts
