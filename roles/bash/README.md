# Bash

## Commands

Installs the following commands:

- [clipboard](/roles/bash/files/bin/clipboard.sh) (you can copy/paste using shell
  redirections and pipes)
- [colors](/roles/bash/files/bin/colors.sh) (cheatsheet for colors on terminal)
- [ll](/roles/bash/files/bash_aliases.sh) (alias for `ls -alhF`)
- [mkcd](/roles/bash/files/bash_functions.sh) (create and got into a directory)
- [passphrase](/roles/bash/files/bin/passphrase.sh) (generates passphrases)

## Commands with color

Adds color by default to the following command:

- egrep
- fgrep
- grep
- ls

## Terminal prompt

Costomizes PS1 variable, which is responsible for the prompt on terminals, like
bellow:

```
~/projects/personal/dotfiles 13:55:25 master ⇡
$
```

It shows:

- Current folder name
- Time when the promt was shown on screen
- Git branch name (if current directory is a Git repository)
- Arrows that indicates you are ahead/behind remote branch

## Terminal history

Sets the history limit size to 100000 commands, while avoid logging in history
the following commands:

- bg
- clear
- fg
- ll
- ls
- pwd

It also add the date and time to history output. See example bellow:

```
~/projects/personal/dotfiles 13:55:25 master ⇡
$ history
...
11374  22/11/20 - 13:54:43 git commit
11375  22/11/20 - 13:55:25 git status
11376  22/11/20 - 13:56:05 history
```
