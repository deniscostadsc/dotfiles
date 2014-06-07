alias reload_bashrc='. ~/.bashrc'

# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# complete ls
alias ll='ls -alhF'

# no more lost files 8D
alias rm='trash --verbose'

# remove git branchs
alias git-remove-branchs='git branch -D $(git branch | grep -v "*\|master")'
