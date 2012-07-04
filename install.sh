cd "$(dirname "$0")"

function install() {
    rsync \
        --exclude ".git/" \
        --exclude ".gitignore" \
        --exclude "install.sh" \
        --exclude "README.md" \
        -av . ~
}

install
