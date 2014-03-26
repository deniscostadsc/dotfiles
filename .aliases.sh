alias rself='. ~/.bashrc'

# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alhF'

alias ack='ack-grep'

alias git-remove-branchs='git branch -D $(git branch | grep -v "*\|master")'
