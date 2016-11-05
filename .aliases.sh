alias reload_bashrc='. ~/.bashrc'

alias vim='nvim'
alias tmux="TERM=screen-256color-bce tmux"
alias my-tmux='tmux attach -t denis || tmux new -s denis'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alhF'

alias git-remove-branchs='git branch -D $(git branch | grep -v "*\|master")'

if is_linux; then
    alias ack='ack-grep'
    alias ls='ls --color=auto'
fi
