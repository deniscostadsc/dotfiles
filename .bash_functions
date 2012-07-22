function calc(){
    python -c "print $*"
}

function is_in(){
    grep $1 <<< $2 > /dev/null 2>&1 && return 0 || return 1
}

function map(){
    function=$1
    shift
    for item in $*; do
        $function $item
    done
}

function reduce(){
    function=$1
    shift
    accumulator=$1
    shift
    for item in $*; do
        accumulator=$($function $accumulator $item)
    done
    echo $accumulator
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

    if [[ $1 =~ ^-a|--all$ ]]; then
        echo "$description $codename"
    else
        echo "$codename"
    fi
}
