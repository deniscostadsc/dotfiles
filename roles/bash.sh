kickstart.context 'Bash'

cp files/bash/bashrc ~/.bashrc
cp files/bash/bash_profile ~/.bash_profile  # to work on OSX

kickstart.mute mkdir ~/.bin || true
cp files/bash/bin/* ~/.bin


function mkcd {
    mkdir -p $1 && cd $1
}

function rmpyc {
    find . -name "*.pyc" -delete;
}

#TODO
alias ll='ls -alhF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#if is_linux; then
    alias ls='ls --color=auto'
#fi
