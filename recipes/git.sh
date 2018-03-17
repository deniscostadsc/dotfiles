kickstart.git.cloneandpull() {
    [[ ! -d $2 ]] && \
        git clone $1 $2

    cd $2
    git pull origin master
    git reset --hard origin/master
    cd -
}
