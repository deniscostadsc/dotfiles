.DEFAULT: deploy-all

deploy-all:
	./deploy.sh

test: test-separateroles

test-separateroles:
	for role in $(find roles -name '*.sh'); do
		role=$(sed 's|\.sh$||' <<< $role);
		role=$(sed 's|^roles/||' <<< $role);
		sed -i "s|###|$role|g" .ci/Dockerfile-separateroles;
		if ! docker build -f .ci/Dockerfile-separateroles .; then
			echo "Failed at $role";
			exit 1;
		fi;
		git checkout .ci/Dockerfile-separateroles;
	done

test-archlinux:
	docker build -f .ci/Dockerfile-linux .;

test-fedora:
	docker build -f .ci/Dockerfile-fedora .;

test-ubuntu1604:
	docker build -f .ci/Dockerfile-ubuntu1604 .;

test-ubuntu1804:
	docker build -f .ci/Dockerfile-ubuntu1804 .;
