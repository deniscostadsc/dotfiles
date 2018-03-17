
function mkcd {
    mkdir -p $1 && cd $1
}

function rmpyc {
    find . -name "*.pyc" -delete;
}

function remove_trailing_spaces {
    find . -regex '.*\.py\|.*\.php\|.*\.js\|.*\.c\|.*\.cpp\|\|.*\.sh.*\.html' |\
        xargs sed -i 's/[[:space:]]\+$//'
}

function update_fonts {
    find ~/Dropbox/fonts -regex '.*\.ttf\|.*\.otf' -exec cp '{}' ~/.local/share/fonts/ \;
}
