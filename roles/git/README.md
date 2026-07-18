# Git

## General config

### Git aliases
This task adds the following aliases:

- alias - show all custom aliases
- append - add staged changes to previous commit
- authors - show all authors sorted by number of commits
- branches - show all branches with better format
- cleanup-branches - remove all branches, but current, main and master
- contributors - same as authors
- current-branch - Show current-branch
- lg - same as log with better format
- main = switch to main branch
- master - switch to master branch
- push - add -u to all usages of push
- s - short for status
- wip - add all changes to stage and commit this with the message WIP

## Work and personal config

Today I have two different github account, one for my work, and another for
personal projects. To use the correct email and Github username for each
reposoitory there is a `includeIf` section in the [Git config
file](/roles/git/files/git/.gitconfig).

## SSH keys

To understand how the SSH key are menaged, look at [SSH role
README](/roles/ssh/README.md)
