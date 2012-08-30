function mkd(){
    mkdir -p $1 && cd $1
}

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
    if [ $# -gt 0 ]; then
        files=$(find . -name "$1" | xargs file | grep text[^:]*$ | sed 's/:[^:]\+$//')
    else
        files=$(find . | xargs file | grep text[^:]*$ | sed 's/:[^:]\+$//')
    fi

    for file_ in $files; do
        sed -i.bak 's/[[:space:]]\+$//' $file_
        if ! diff $file_ $file_.bak > /dev/null; then
            echo "$file_ was changed."
        fi
        rm $file_.bak
    done
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
