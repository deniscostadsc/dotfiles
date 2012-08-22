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
    # Show current branch on a git directory
    if git branch > /dev/null 2>&1; then
        echo -e "($(git branch 2> /dev/null | grep "^*" | sed "s/^* //")) "
    fi
}

function stripy(){
    # Remove spaces from end of lines
    (find . | xargs file | grep text | sed 's/:[^:]\+$//' | xargs sed -i 's/[[:space:]]\+$//') 2> /dev/null
}

function sysname(){
    # Show Ubuntu version
    codename="$(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/^[^=]\+=//')"

    if [[ $1 =~ ^(-a|--all)$ ]]; then
        description="$(grep 'DISTRIB_DESCRIPTION' /etc/lsb-release | sed 's/^[^=]\+=//;s/"//g')"
        echo "$description $codename"
    else
        echo "$codename"
    fi
}
