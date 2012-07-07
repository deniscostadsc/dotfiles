function calc(){
    bc <<< "$*"
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
