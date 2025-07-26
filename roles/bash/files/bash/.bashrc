#!/usr/bin/env bash
# If not running interactively, don't do anything
[[ -z "${PS1:-}" ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE='ll:ls:clear:[bf]g:pwd:history'
HISTTIMEFORMAT="%d/%m/%y - %H:%M:%S "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
# shellcheck disable=SC2312
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# shellcheck disable=SC1091
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

# Checking for colors support
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

# Checking for 24-bit true color support
TRUE_COLOR_SUPPORT=0

if [[ -n "${COLORTERM:-}" ]] && [[ "${COLORTERM}" =~ ^(truecolor|24bit)$ ]]; then
    # Terminal explicitly supports 24-bit color
    TRUE_COLOR_SUPPORT=1
elif [[ -n "${TERM:-}" ]] && [[ "${TERM}" =~ ^(xterm|screen|tmux|iterm2|vscode) ]]; then
    # Common terminals that support true color
    TRUE_COLOR_SUPPORT=1
elif [[ -n "${TERM_PROGRAM:-}" ]] && [[ "${TERM_PROGRAM}" =~ ^(iTerm|Apple_Terminal|vscode)$ ]]; then
    # macOS terminal programs that support true color
    TRUE_COLOR_SUPPORT=1
elif [[ -n "${color_prompt:-}" ]]; then
    # Test if terminal supports true color by checking if it can display RGB colors
    printf '\033[48;2;255;0;0m' >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        TRUE_COLOR_SUPPORT=1
    fi
fi

export TRUE_COLOR_SUPPORT

# Color variables
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[0;37m'

export BRIGHT_BLACK='\033[1;30m'
export BRIGHT_RED='\033[1;31m'
export BRIGHT_GREEN='\033[1;32m'
export BRIGHT_YELLOW='\033[1;33m'
export BRIGHT_BLUE='\033[1;34m'
export BRIGHT_PURPLE='\033[1;35m'
export BRIGHT_CYAN='\033[1;36m'
export BRIGHT_WHITE='\033[1;37m'

export BG_BLACK='\033[40m'
export BG_RED='\033[41m'
export BG_GREEN='\033[42m'
export BG_YELLOW='\033[43m'
export BG_BLUE='\033[44m'
export BG_PURPLE='\033[45m'
export BG_CYAN='\033[46m'
export BG_WHITE='\033[47m'

export NC='\033[0m'
export RESET='\033[0m'

if [[ "${TRUE_COLOR_SUPPORT:-}" -eq 1 ]]; then
    function bg_rgb {
        local r=$1
        local g=$2
        local b=$3
        printf '\033[48;2;%d;%d;%dm' "$r" "$g" "$b"
    }
fi

PATH_COLOR="\[$BRIGHT_PURPLE\]"
TIME_COLOR="\[$BRIGHT_CYAN\]"
GIT_COLOR="\[$BRIGHT_GREEN\]"
GIT_STATUS_COLOR="\[$BRIGHT_RED\]"
TODO_COLOR="\[$BRIGHT_WHITE\]"

if [[ "${color_prompt}" = yes ]]; then
    PS1="$PATH_COLOR\w $TIME_COLOR\$(__now) $GIT_COLOR\$(__git_branch) $GIT_STATUS_COLOR\$(__git_arrows)$TODO_COLOR\$(current_todo_task)$NC\n\$ "
else
    PS1='\w $(__now) $(__git_branch) $(__git_arrows)$(current_todo_task)\n\$ '
fi

unset color_prompt

LC_ALL="en_US.UTF-8"

PATH=~/.bin/:${PATH}
MANPATH=~/.man/:${MANPATH}

# no zsh here!
export BASH_SILENCE_DEPRECATION_WARNING=1
