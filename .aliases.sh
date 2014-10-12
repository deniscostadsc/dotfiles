alias reload_bashrc='. ~/.bashrc'

# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# complete ls
alias ll='ls -alhF'

alias rm='git_rm'
alias mv='git_mv'
alias git-remove-branchs='git branch -D $(git branch | grep -v "*\|master")'
