kickstart.context 'Git'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa

kickstart.package.install git
kickstart.package.install gitg

cp files/git/functions.sh ~/.bashrc_git.sh
echo '. ~/.bashrc_git.sh' >> ~/.bashrc

cp files/git/gitconfig ~/.gitconfig
