# Workfy Repo Script Tests

> **Purpose**: Test suite for the `workfy-repo.sh` script that switches Git remote URLs between personal and work GitHub accounts.

> **Script Location**: `roles/git/files/bin/workfy-repo.sh`

> **Default Behavior**: Toggles between personal (`github.com`) and work (`work.github.com`) remote URLs.

## Test Overview

This test suite validates:
- ✅ Repository initialization handling
- ✅ Remote URL switching functionality
- ✅ Toggle behavior between personal and work accounts

## Setup and Environment

Prepares the test environment by creating a clean repository directory.

	$ rm -rf /repo 2> /dev/null
	$ mkdir /repo

## Core Functionality

### Initial State (No Git Repo)

Tests behavior when no Git repository exists:

	$ cd /repo && /code/roles/git/files/bin/workfy-repo.sh

### Repository Initialization

Tests behavior after initializing a Git repository:

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

### Remote URL Switching

Tests the remote URL switching functionality:

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
