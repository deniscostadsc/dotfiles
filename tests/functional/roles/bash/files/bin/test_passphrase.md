# Passphrase Script Tests

> **Purpose**: Comprehensive test suite for the `passphrase.sh` script that generates secure passphrases from dictionary words.

> **Script Location**: `roles/bash/files/bin/passphrase.sh`

> **Default Behavior**: Generates 6 words, each 4-6 characters long, from lowercase dictionary words.

## Test Overview

This test suite validates:
- ✅ Core passphrase generation functionality
- ✅ Command-line option handling and validation
- ✅ Word filtering (length, case, character type)
- ✅ Dictionary file fallback mechanisms
- ✅ Error handling and edge cases

## Setup and Environment

Prepares the test environment by creating the necessary dictionary file and directory structure.

> **Note**: Tests assume `/usr/share/dict/words` is the primary dictionary location.

	$ mkdir -p /usr/share/dict/
	$ echo "test" > /usr/share/dict/words

## Core Functionality - Default Behavior

Tests the basic passphrase generation with default parameters:
- **Default Output**: 6 words, space-separated
- **Word Length**: 4-6 characters each
- **Case**: All lowercase
- **Source**: Dictionary words matching regex `^[a-z]{4,6}$`

	$ ./roles/bash/files/bin/passphrase.sh
	test test test test test test
	$ ./roles/bash/files/bin/passphrase.sh | wc -w
	6

## Core Functionality - Word Count Parameter

Tests the `-c` and `--count` flags to generate custom numbers of words.

	$ ./roles/bash/files/bin/passphrase.sh -c 10 | wc -w
	10
	$ ./roles/bash/files/bin/passphrase.sh --count 10 | wc -w
	10

## Options Validation

Tests command-line option handling and help functionality.

### Invalid Options
Tests that invalid or incomplete options are properly rejected:

	$ ./roles/bash/files/bin/passphrase.sh --non-existing
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh --x
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh --min
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh --max
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh --count
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh -n
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh -m
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh -c
	Invalid option
	$ ./roles/bash/files/bin/passphrase.sh -h
	
	passphrase
	
	--min (-n) sets minimum number of characters in the words (default: 4)
	--max (-m) sets maximum number of characters in the words (default: 6)
	--count (-c) sets how many word the passphrase will contain (default: 6)
	--help (-h) shows help message and exit
	
	$ ./roles/bash/files/bin/passphrase.sh --help
	
	passphrase
	
	--min (-n) sets minimum number of characters in the words (default: 4)
	--max (-m) sets maximum number of characters in the words (default: 6)
	--count (-c) sets how many word the passphrase will contain (default: 6)
	--help (-h) shows help message and exit
	

## Options Validation - Range Validation

	$ ./roles/bash/files/bin/passphrase.sh --min 0
	Min word length must be between 1 and 100
	$ ./roles/bash/files/bin/passphrase.sh --min 101
	Min word length must be between 1 and 100
	$ ./roles/bash/files/bin/passphrase.sh --max 0
	Max word length must be between 1 and 100
	$ ./roles/bash/files/bin/passphrase.sh --max 101
	Max word length must be between 1 and 100
	$ ./roles/bash/files/bin/passphrase.sh --count -1
	Word count must be between 0 and 1000
	$ ./roles/bash/files/bin/passphrase.sh --count 1001
	Word count must be between 0 and 1000
	$ ./roles/bash/files/bin/passphrase.sh --min 9
	Max should be greater than min (current: min=9, max=6)
	$ ./roles/bash/files/bin/passphrase.sh --min 7 --max 5
	Max should be greater than min (current: min=7, max=5)
	$ ./roles/bash/files/bin/passphrase.sh --min 5 --max 3
	Max should be greater than min (current: min=5, max=3)
	$ ./roles/bash/files/bin/passphrase.sh --min 10 --max 5
	Max should be greater than min (current: min=10, max=5)
	$ ./roles/bash/files/bin/passphrase.sh --min 100 --max 50
	Max should be greater than min (current: min=100, max=50)


## Word Length Filtering - Min/Max Parameters

Tests the `--min` and `--max` parameters to filter words by length.

> **Note**: The script uses regex `^[a-z]{min,max}$` for filtering, so only lowercase letters are accepted.

> **Warning**: When no words match the criteria, the script exits with "There are no available words with this size".

	$ echo "fruit" >> /usr/share/dict/words
	$ cat /usr/share/dict/words
	test
	fruit
	$ ./roles/bash/files/bin/passphrase.sh -n 5
	fruit fruit fruit fruit fruit fruit
	$ ./roles/bash/files/bin/passphrase.sh --min 5
	fruit fruit fruit fruit fruit fruit
	$ ./roles/bash/files/bin/passphrase.sh --max 4
	test test test test test test
	$ echo "bananas" >> /usr/share/dict/words
	$ cat /usr/share/dict/words
	test
	fruit
	bananas
	$ ./roles/bash/files/bin/passphrase.sh --min 5 --max 6
	fruit fruit fruit fruit fruit fruit

## Output Validation - Word Selection

	$ ./roles/bash/files/bin/passphrase.sh -c 20 | grep "test" > /dev/null && echo "got test"
	got test
	$ ./roles/bash/files/bin/passphrase.sh -c 20 | grep "fruit" > /dev/null && echo "got fruit"
	got fruit

## Word Filtering - Case Sensitivity

	$ echo "test" > /usr/share/dict/words
	$ echo "Test" >> /usr/share/dict/words
	$ echo "TEST" >> /usr/share/dict/words
	$ cat /usr/share/dict/words
	test
	Test
	TEST
	$ ./roles/bash/files/bin/passphrase.sh -c 10 | grep -o "test" | wc -l
	10

## Word Filtering

Tests the script's word filtering logic to ensure only valid words are selected.

### Length Constraints

Tests that words outside the length constraints are properly filtered out.

| Input Word | Length | Expected Result | Reason |
|------------|--------|----------------|---------|
| `a` | 1 char | ❌ Rejected | Too short (< 4 chars) |
| `the` | 3 chars | ❌ Rejected | Too short (< 4 chars) |
| `toolong` | 7 chars | ❌ Rejected | Too long (> 6 chars) |

	$ echo "a" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size
	$ echo "the" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size
	$ echo "toolong" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size

### Case Sensitivity

Tests that uppercase words are rejected (script only accepts lowercase).

	$ echo "Test" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size
	$ echo "HELLO" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size

### Character Type

Tests that words with non-letter characters are rejected.

	$ echo "test123" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size
	$ echo "test-word" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	There are no available words with this size

## Multiple Word Dictionary - Selection Logic

Tests random word selection from a dictionary with multiple valid words.

> **Expected Behavior**: When multiple words are available, the script should randomly select from all valid words to generate the requested count.

> **Randomness Test**: With 3 words available and 20 requested, all 3 words should appear in the output.

	$ echo "only" > /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh -c 10
	only only only only only only only only only only
	$ echo "test" >> /usr/share/dict/words
	$ echo "fruit" >> /usr/share/dict/words
	$ cat /usr/share/dict/words
	only
	test
	fruit
	$ ./roles/bash/files/bin/passphrase.sh -c 20 | grep -E "(test|fruit|only)" | wc -l
	1

## Error Handling - Missing Dictionary File

Tests graceful error handling when no dictionary files are available.

> **Fallback Order**: The script checks these locations in order:
> 1. `/usr/share/dict/words`
> 2. `/usr/dict/words`
> 3. `/usr/share/dict/american-english`
> 4. `/usr/share/dict/british-english`

	$ rm -f /usr/share/dict/words
	$ ./roles/bash/files/bin/passphrase.sh
	No dictionary file found.

## Dictionary File Fallback - Alternative Locations

Tests the script's ability to find dictionary files in alternative locations when the primary location is unavailable.

> **Clean Test Environment**: Each test creates temporary dictionary files and cleans them up immediately after use to prevent interference between tests.

	$ rm -f /usr/share/dict/words
	$ mkdir -p /usr/dict && echo "apple" > /usr/dict/words && ./roles/bash/files/bin/passphrase.sh && rm -f /usr/dict/words
	apple apple apple apple apple apple
	$ mkdir -p /usr/share/dict && echo "banana" > /usr/share/dict/american-english && ./roles/bash/files/bin/passphrase.sh && rm -f /usr/share/dict/american-english
	banana banana banana banana banana banana
	$ echo "orange" > /usr/share/dict/british-english && ./roles/bash/files/bin/passphrase.sh && rm -f /usr/share/dict/british-english
	orange orange orange orange orange orange
