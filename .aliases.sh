alias reload_bashrc='. ~/.bashrc'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alhF'

alias rm='__git_rm'
alias mv='__git_mv'
alias git-remove-branchs='git branch -D $(git branch | grep -v "*\|master")'

if is_linux; then
    alias ack='ack-grep'
    alias ls='ls --color=auto'
fi
