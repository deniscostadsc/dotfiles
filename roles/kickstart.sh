kickstart.context 'Kickstart'

[[ ! -d ~/.kickstart ]] && \
    git clone https://github.com/deniscostadsc/kickstart.git ~/.kickstart

cd ~/.kickstart
git pull origin master
git reset --hard origin/master
cd -

echo 'eval "$(kickstart autocomplete)"' >> ~/.bashrc

kickstart.file.link ~/.kickstart/bin/kickstart ~/.bin/kickstart

