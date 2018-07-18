generic_install() {
    # shellcheck disable=SC2048
    # shellcheck disable=SC2086
    apt install -y "$*" > /dev/null 2>&1 || \
    brew install -y "$*" > /dev/null 2>&1 || \
    yum install -y "$*" > /dev/null 2>&1 || \
    pacman -S --noconfirm "$*" > /dev/null 2>&1
}

generic_update() {
    apt update > /dev/null 2>&1 || \
    brew update -y > /dev/null 2>&1 || \
    yum update -y > /dev/null 2>&1 || \
    pacman -Sy --noconfirm > /dev/null 2>&1
}
