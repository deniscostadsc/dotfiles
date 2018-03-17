kickstart.context 'Tmux'

kickstart.package.install tmux
kickstart.package.install tmate

cp files/tmux/tmux.conf ~/.tmux.conf

#TODO
alias tmux="TERM=screen-256color-bce tmux"
alias my-tmux='tmux attach -t denis || tmux new -s denis'
