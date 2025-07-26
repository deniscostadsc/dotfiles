# XKCD Script Tests

> **Purpose**: Comprehensive test suite for the `xkcd.sh` script that displays XKCD comics in the terminal.

> **Script Location**: `roles/bash/files/bin/xkcd.sh`

> **Default Behavior**: Shows a random XKCD comic with basic information (title, image, alt text, URL).

## Test Overview

This test suite validates:
- ✅ Core comic display functionality
- ✅ Command-line option handling and validation
- ✅ Caching mechanisms (latest comic number, individual comics)
- ✅ Different comic selection modes (random, latest, specific)
- ✅ Error handling and edge cases
- ✅ Image rendering command detection

## Setup and Environment

Prepares the test environment by creating a mock image renderer and setting up cache directory.

> **Note**: Tests use a mock `viu` command that simulates image display for consistent testing.

	$ mkdir -p /tmp/mock-bin
	$ cp tests/functional/fixtures/mock-viu.sh /tmp/mock-bin/viu
	$ cp tests/functional/fixtures/mock-curl.sh /tmp/mock-bin/curl
	$ chmod +x /tmp/mock-bin/viu /tmp/mock-bin/curl
	$ export PATH="/tmp/mock-bin:$PATH"

## Core Functionality - Default Behavior

Tests the basic comic display with default parameters (random comic):
- **Default Output**: Random XKCD comic with title, image, alt text, and URL
- **Mode**: Random comic selection
- **Explanation**: Not shown by default

	$ ./roles/bash/files/bin/xkcd.sh | grep "XKCD #[0-9]\+: Comic" > /dev/null

## Core Functionality - Help Display

Tests the help functionality to ensure proper usage information is displayed.

	$ ./roles/bash/files/bin/xkcd.sh --help
	Usage: xkcd.sh [OPTIONS]
	
	View XKCD comics in your terminal, random by default.
	
	OPTIONS:
	    -l, --latest              Show the latest comic (cannot be used with -n)
	    -n, --number <NUMBER>     Show a specific comic (cannot be used with -l)
	    -x, --show-explanation    Include explanation link in output
	    -h, --help                Show this help message
	
	$ ./roles/bash/files/bin/xkcd.sh -h
	Usage: xkcd.sh [OPTIONS]
	
	View XKCD comics in your terminal, random by default.
	
	OPTIONS:
	    -l, --latest              Show the latest comic (cannot be used with -n)
	    -n, --number <NUMBER>     Show a specific comic (cannot be used with -l)
	    -x, --show-explanation    Include explanation link in output
	    -h, --help                Show this help message
	
## Options Validation

Tests command-line option handling and validation.

### Invalid Options
Tests that invalid or incomplete options are properly rejected:

	$ ./roles/bash/files/bin/xkcd.sh --non-existing
	--non-existing is an invalid option.
	$ ./roles/bash/files/bin/xkcd.sh --invalid
	--invalid is an invalid option.
	$ ./roles/bash/files/bin/xkcd.sh -z
	-z is an invalid option.

### Conflicting Options
Tests that mutually exclusive options are properly rejected:

	$ ./roles/bash/files/bin/xkcd.sh -l -n 123
	Error: -l and -n options cannot be used together.
	$ ./roles/bash/files/bin/xkcd.sh --latest --number 123
	Error: -l and -n options cannot be used together.

### Missing Parameters
Tests that options requiring parameters are properly handled:

	$ ./roles/bash/files/bin/xkcd.sh -n
	You must inform the comic number

## Comic Selection Modes

Tests different comic selection modes and their behavior.

### Latest Comic Mode

Tests the `-l` and `--latest` flags to show the most recent comic.

	$ ./roles/bash/files/bin/xkcd.sh -l
	
	XKCD #3120: Comic #3120
	
	[Displaying image from https://imgs.xkcd.com/comics/comic3120.png]
	
	Alt Text: Alt text for comic 3120
	Comic URL: https://xkcd.com/3120/
	Explanation: https://www.explainxkcd.com/wiki/index.php/3120
	
### Specific Comic Mode

Tests the `-n` and `--number` flags to show a specific comic by number.

	$ ./roles/bash/files/bin/xkcd.sh -n 1
	
	XKCD #1: Comic #1
	
	[Displaying image from https://imgs.xkcd.com/comics/comic1.png]
	
	Alt Text: Alt text for comic 1
	Comic URL: https://xkcd.com/1/
	Explanation: https://www.explainxkcd.com/wiki/index.php/1
	
	$ ./roles/bash/files/bin/xkcd.sh --number 100
	
	XKCD #100: Comic #100
	
	[Displaying image from https://imgs.xkcd.com/comics/comic100.png]
	
	Alt Text: Alt text for comic 100
	Comic URL: https://xkcd.com/100/
	Explanation: https://www.explainxkcd.com/wiki/index.php/100
	
### Random Comic Mode (Default)

Tests the default random comic selection behavior.

	$ ./roles/bash/files/bin/xkcd.sh | grep "XKCD #[0-9]\+: Comic" > /dev/null
	$ ./roles/bash/files/bin/xkcd.sh | grep "Alt Text: [a-zA-Z ]\+" > /dev/null
	$ ./roles/bash/files/bin/xkcd.sh | grep "Comic URL: https://xkcd.com/[0-9]\+/" > /dev/null

## Output Validation

### Comic Number Validation

Tests that displayed comic numbers match requested numbers.

	$ ./roles/bash/files/bin/xkcd.sh -n 100 | grep "XKCD #100:"
	XKCD #100: Comic #100

	$ ./roles/bash/files/bin/xkcd.sh -n 500 | grep "XKCD #500:"
	XKCD #500: Comic #500

## Cache Test

Tests that the script can read from cache after initial fetch.

	$ ./roles/bash/files/bin/xkcd.sh -n 1 | grep "XKCD #1:"
	XKCD #1: Comic #1
	$ sed 's/"Comic #1"/"CACHED Comic #1"/' "${HOME}/.cache/xkcd/1" > "${HOME}/.cache/xkcd/1.tmp" && mv "${HOME}/.cache/xkcd/1.tmp" "${HOME}/.cache/xkcd/1"
	$ ./roles/bash/files/bin/xkcd.sh -n 1 | grep "XKCD #1:"
	XKCD #1: CACHED Comic #1

Tests that the clear cache functionality works correctly.

	$ ls -la "${HOME}/.cache/xkcd/" | wc -l
	12
	$ echo y | ./roles/bash/files/bin/xkcd.sh -c
	$ ls -la "${HOME}/.cache/xkcd/" | wc -l
	3
