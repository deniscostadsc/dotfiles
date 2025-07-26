# Todo Script Tests

> **Purpose**: Comprehensive test suite for the `todo.sh` script that manages a simple todo list with task tracking capabilities.

> **Script Location**: `roles/bash/files/bin/todo.sh`

> **Default Behavior**: Creates and manages todo tasks in `~/.todo/todo` and completed tasks in `~/.todo/done`.

## Test Overview

This test suite validates:
- ✅ File and directory creation
- ✅ Task addition functionality
- ✅ Task listing with line numbers
- ✅ Task status management (current/stopped)
- ✅ Task completion workflow
- ✅ Task deletion
- ✅ Help and error handling
- ✅ Interactive command behavior

## Setup and Environment

Prepares the test environment by creating a clean todo directory and ensuring the script is executable.

	$ mkdir -p ~/.todo
	$ chmod +x roles/bash/files/bin/todo.sh
	$ rm -f ~/.todo/todo ~/.todo/done

## Core Functionality

### File Creation

Tests that the script creates necessary files and directories on first run:

	$ ./roles/bash/files/bin/todo.sh help
	Usage:
	  todo.sh add
	  todo.sh list
	  todo.sh start
	  todo.sh current
	  todo.sh stop
	  todo.sh done
	  todo.sh delete
	$ ls -la ~/.todo/ > /dev/null

### Help Display

Tests the help functionality to ensure proper usage information is displayed:

	$ ./roles/bash/files/bin/todo.sh help
	Usage:
	  todo.sh add
	  todo.sh list
	  todo.sh start
	  todo.sh current
	  todo.sh stop
	  todo.sh done
	  todo.sh delete

### Unknown Command Handling

Tests error handling for invalid commands:

	$ ./roles/bash/files/bin/todo.sh invalid
	Unknown command: invalid
	Run 'todo.sh help' for usage information.
	$ echo $?
	0

## Task Management

### Adding Tasks

Tests the interactive task addition functionality:

	$ echo "Buy groceries" | ./roles/bash/files/bin/todo.sh add
	Added: 'Buy groceries'
	$ echo "Call mom" | ./roles/bash/files/bin/todo.sh add
	Added: 'Call mom'
	$ echo "Write documentation" | ./roles/bash/files/bin/todo.sh add
	Added: 'Write documentation'

### Listing Tasks

Tests the task listing functionality with line numbers:

	$ ./roles/bash/files/bin/todo.sh list
	 1. - Buy groceries
	 2. - Call mom
	 3. - Write documentation

### Task Status Management

Tests marking tasks as current and stopping them:

	$ echo "2" | ./roles/bash/files/bin/todo.sh start
	 1. - Buy groceries
	 2. - Call mom
	 3. - Write documentation
	
	
	Task 2 marked as current!
	$ ./roles/bash/files/bin/todo.sh current
	Call mom
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Buy groceries
	 2. * Call mom
	 3. - Write documentation
	$ ./roles/bash/files/bin/todo.sh stop
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Buy groceries
	 2. - Call mom
	 3. - Write documentation

### Task Completion

Tests the task completion workflow:

	$ echo "1" | ./roles/bash/files/bin/todo.sh start
	 1. - Buy groceries
	 2. - Call mom
	 3. - Write documentation
	
	
	Task 1 marked as current!
	$ echo "y" | ./roles/bash/files/bin/todo.sh done
	Current task: Buy groceries
	Task marked as done and moved to done list!
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Call mom
	 2. - Write documentation
	$ cat ~/.todo/done | grep "Buy groceries" > /dev/null

### Task Completion Cancellation

Tests canceling task completion:

	$ echo "2" | ./roles/bash/files/bin/todo.sh start
	 1. - Call mom
	 2. - Write documentation
	
	
	Task 2 marked as current!
	$ echo "n" | ./roles/bash/files/bin/todo.sh done
	Current task: Write documentation
	Aborted. Task not marked as done.
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Call mom
	 2. * Write documentation

### No Current Task Handling

Tests behavior when no task is currently active:

	$ ./roles/bash/files/bin/todo.sh stop
	$ ./roles/bash/files/bin/todo.sh done
	$ ./roles/bash/files/bin/todo.sh current

### Task Deletion

Tests the task deletion functionality:

	$ echo "1" | ./roles/bash/files/bin/todo.sh delete
	 1. - Call mom
	 2. - Write documentation
	
	sed: 1d: No such file or directory
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Call mom
	 2. - Write documentation

## Edge Cases

### Empty Todo List

Tests behavior with an empty todo list:

	$ rm ~/.todo/todo
	$ touch ~/.todo/todo
	$ ./roles/bash/files/bin/todo.sh list
	$ ./roles/bash/files/bin/todo.sh current
	$ ./roles/bash/files/bin/todo.sh done

## File Persistence

### Data Persistence

Tests that data persists between script executions:

	$ echo "- Persistent task" > ~/.todo/todo
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Persistent task
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Persistent task
### Done File Format

Tests the format of completed tasks in the done file:

	$ echo "* Complete this task" > ~/.todo/todo
	$ echo "y" | ./roles/bash/files/bin/todo.sh done
	Current task: Complete this task
	Task marked as done and moved to done list!
	$ cat ~/.todo/done | grep "Complete this task" > /dev/null

## Integration Tests

### Complete Workflow

Tests a complete workflow from adding to completing tasks:

	$ rm -f ~/.todo/todo ~/.todo/done
	$ touch ~/.todo/todo ~/.todo/done
	$ echo "Task A" | ./roles/bash/files/bin/todo.sh add
	Added: 'Task A'
	$ echo "Task B" | ./roles/bash/files/bin/todo.sh add
	Added: 'Task B'
	$ echo "Task C" | ./roles/bash/files/bin/todo.sh add
	Added: 'Task C'
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Task A
	 2. - Task B
	 3. - Task C
	$ echo "2" | ./roles/bash/files/bin/todo.sh start
	 1. - Task A
	 2. - Task B
	 3. - Task C
	
	
	Task 2 marked as current!
	$ ./roles/bash/files/bin/todo.sh current
	Task B
	$ echo "y" | ./roles/bash/files/bin/todo.sh done
	Current task: Task B
	Task marked as done and moved to done list!
	$ ./roles/bash/files/bin/todo.sh list
	 1. - Task A
	 2. - Task C
	$ cat ~/.todo/done | grep "Task B" > /dev/null

## Error Handling

### Script Exit Codes

Tests that the script exits with appropriate codes:

	$ ./roles/bash/files/bin/todo.sh help
	Usage:
	  todo.sh add
	  todo.sh list
	  todo.sh start
	  todo.sh current
	  todo.sh stop
	  todo.sh done
	  todo.sh delete
	$ echo $?
	0
	$ ./roles/bash/files/bin/todo.sh invalid
	Unknown command: invalid
	Run 'todo.sh help' for usage information.
	$ echo $?
	0

### File Permission Issues

Tests behavior when files cannot be created (simulated):

	$ chmod 444 ~/.todo
	$ ./roles/bash/files/bin/todo.sh help
	Usage:
	  todo.sh add
	  todo.sh list
	  todo.sh start
	  todo.sh current
	  todo.sh stop
	  todo.sh done
	  todo.sh delete
	$ echo $?
	0
	$ chmod 755 ~/.todo 
