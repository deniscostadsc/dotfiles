kickstart.context 'Kickstart'

source recipes/git.sh

kickstart.git.cloneandpull https://github.com/bltavares/kickstart.git ~/.kickstart

echo 'eval "$(kickstart autocomplete)"' >> ~/.bashrc

kickstart.file.link ~/.kickstart/bin/kickstart ~/.bin/kickstart

