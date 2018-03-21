kickstart.context 'Bash'

kickstart.info "Copy rcfiles to home folder"
cp --preserve=mode,ownership files/bash/bashrc ~/.bashrc
cp --preserve=mode,ownership files/bash/bash_profile ~/.bash_profile

kickstart.mute mkdir ~/.bin || true

kickstart.info "Copy bin files to bin folder"
cp --preserve=mode,ownership files/bash/bin/* ~/.bin

echo  >> ~/.bashrc
echo "# Bash - added by kickstart" >> ~/.bashrc

kickstart.info "Add aliases to bashrc"
echo "alias ll='ls -alhF'" >> ~/.bashrc
echo "alias grep='grep --color=auto'" >> ~/.bashrc
echo "alias fgrep='fgrep --color=auto'" >> ~/.bashrc
echo "alias egrep='egrep --color=auto'" >> ~/.bashrc
kickstart.os.is "Ubuntu" && echo "alias ls='ls --color=auto'" >> ~/.bashrc

kickstart.info "Add functions to bashrc"
echo 'function mkcd {
    mkdir -p $1 && cd $1
}' >> ~/.bashrc
