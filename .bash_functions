function calc(){
    bc <<< $1
}

function is_in(){
    grep $1 <<< $2 > /dev/null 2>&1 && return 0 || return 1
}
