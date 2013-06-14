# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=100000
HISTIGNORE='ls:history'
HISTTIMEFORMAT="%d/%h/%y - %H:%M:%S "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Import of aliases
if [ -f ~/.aliases/bash.sh ]; then
    . ~/.aliases/bash.sh
fi

if [ -f ~/.aliases/git.sh ]; then
    . ~/.aliases/git.sh
fi

if [ -f ~/.aliases/python.sh ]; then
    . ~/.aliases/python.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Import of bash function
if [ -f ~/.functions.sh ]; then
    . ~/.functions.sh
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
    PS1='\[\033[01;32m\]$(gitbranch)\[\033[01;35m\]\w\[\033[00m\]\n\$ '
else
    PS1='$(gitbranch)\w\n\$ '
fi
unset color_prompt

# Virtualenv Wrapper
WORKON_HOME='~/Envs'
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    . /usr/local/bin/virtualenvwrapper.sh
else
    echo "Virtualenv Wrapper apparently is not installed."
fi

# Add GAE SDK to PATH
if [ -d /home/denis/bin/google_appengine ]; then
    PATH="$PATH:/home/denis/bin/google_appengine"
    export GAE_SDK="/home/denis/bin/google_appengine"
fi
