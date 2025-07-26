# Git Aliases Script Tests

> **Purpose**: Test suite for the `git-aliases.sh` script that displays custom Git aliases.

> **Script Location**: `roles/git/files/bin/git-aliases.sh`

> **Default Behavior**: Lists all custom Git aliases with their descriptions.

## Test Overview

This test suite validates:
- ✅ Core alias display functionality
- ✅ Proper formatting of alias output
- ✅ Description handling for aliases

## Setup and Environment

Prepares the test environment by creating a mock gitconfig file with test aliases.

	$ cp /code/tests/functional/fixtures/gitconfig-fixture ~/.gitconfig

## Core Functionality

### Alias Display

Tests the basic alias display functionality:

	$ /code/roles/git/files/bin/git-aliases.sh
	alias              - Show all custom aliases
	append             - No description
	lg                 - Show log with better format
	push               - Add -u by default to push
