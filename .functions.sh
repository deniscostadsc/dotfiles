function is_mac {
    if [ $(uname) == "Darwin" ]; then
        return 0
    fi
    return 1
}

function is_linux {
    if ! is_mac; then
        return 0
    fi
    return 1
}

function mkcd {
    mkdir -p $1 && cd $1
}

function rmpyc {
    find . -name "*.pyc" -delete;
}

function __git_rm {
    git rm $* 2> /dev/null || trash $*
}

function __git_mv {
    MV=$(which mv)
    git mv $* 2> /dev/null || $MV $*
}

function remove_trailing_spaces {
    find . -regex '.*\.py\|.*\.php\|.*\.js\|.*\.c\|.*\.cpp\|\|.*\.sh.*\.html' |\
        xargs sed -i 's/[[:space:]]\+$//'
}

function update_fonts {
    find ~/Dropbox/fonts -regex '.*\.ttf\|.*\.otf' -exec cp '{}' ~/.local/share/fonts/ \;
}
