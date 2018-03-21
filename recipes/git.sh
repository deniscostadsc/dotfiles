kickstart.git.cloneandpull() {
    [[ ! -d $2 ]] && {
        kickstart.info "Cloning $1"
        kickstart.mute git clone $1 $2
    }

    kickstart.mute cd $2
    kickstart.info "Fetchcing $1"
    kickstart.mute git fetch --all
    kickstart.mute git reset --hard origin/master
    kickstart.mute cd -
}
