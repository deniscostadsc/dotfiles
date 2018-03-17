kickstart.context 'Git'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa

kickstart.package.install git
kickstart.package.install gitg

cp files/git/globalignore ~/.config/git/ignore
cp files/git/gitconfig ~/.gitconfig
cp files/git/functions.sh ~/.bashrc_git.sh
echo '. ~/.bashrc_git.sh' >> ~/.bashrc

kickstart.mute mkdir -p ~/.git_template/hooks || true
cp files/git/hooks/* ~/.git_template/hooks/ || true
