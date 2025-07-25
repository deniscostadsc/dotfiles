	$ rm -rf /repo 2> /dev/null
	$ mkdir /repo
	$ cd /repo && /code/roles/git/files/bin/workfy-repo.sh
	$ cd /repo && git init
	hint: Using 'master' as the name for the initial branch. This default branch name
	hint: is subject to change. To configure the initial branch name to use in all
	hint: of your new repositories, which will suppress this warning, call:
	hint:
	hint: 	git config --global init.defaultBranch <name>
	hint:
	hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
	hint: 'development'. The just-created branch can be renamed via this command:
	hint:
	hint: 	git branch -m <name>
	Initialized empty Git repository in /repo/.git/
	$ cd /repo && git remote add origin git@github.com:deniscostadsc/dotfiles.git
	$ cd /repo && git remote -v
	origin	git@github.com:deniscostadsc/dotfiles.git (fetch)
	origin	git@github.com:deniscostadsc/dotfiles.git (push)
	$ cd /repo && /code/roles/git/files/bin/workfy-repo.sh
	origin	git@work.github.com:deniscostadsc/dotfiles.git (fetch)
	origin	git@work.github.com:deniscostadsc/dotfiles.git (push)
	$ cd /repo && /code/roles/git/files/bin/workfy-repo.sh
	origin	git@github.com:deniscostadsc/dotfiles.git (fetch)
	origin	git@github.com:deniscostadsc/dotfiles.git (push)
