# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Import of bash function
. ~/.functions.sh

# Import of git function
. ~/.git_functions.sh

# Import of aliases
. ~/.aliases.sh

# Import sensitive things
. ~/.sensitive.sh

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE='ls:clear:[bf]g:pwd'
HISTTIMEFORMAT="%d/%m/%y - %H:%M:%S "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if is_mac; then
    . $(brew --prefix)/etc/bash_completion
else
    . /etc/bash_completion
fi

# Checking for colors support
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;35m\]\w\[\033[01;32m\]$(__git_ps1) \[\033[31m\]$(__git_arrows) \[\033[00m\]\n\$ '
else
    PS1='\w$(__git_ps1) $(__git_arrows)\n\$ '
fi
unset color_prompt

PATH=$PATH:~/.bin/
