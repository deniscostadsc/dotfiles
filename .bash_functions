function calc(){
    python -c "print $*"
}

function rmpyc(){
    find . -name "*.pyc" -exec rm -rfv {} \;
}

function is_in(){
    grep $1 <<< $2 > /dev/null 2>&1 && return 0 || return 1
}

function gvim(){
    /usr/bin/gvim -f $* &
}

function gitbranch(){
    if git branch > /dev/null 2>&1; then
        echo -e "($(git branch 2> /dev/null | grep "^*" | sed "s/^* //")) "
    fi
}

function name(){
    codename="$(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/^[^=]\+=//')"
    description="$(grep 'DISTRIB_DESCRIPTION' /etc/lsb-release | sed 's/^[^=]\+=//;s/"//g')"

    if [[ $1 =~ ^(-a|--all)$ ]]; then
        echo "$description $codename"
    else
        echo "$codename"
    fi
}
