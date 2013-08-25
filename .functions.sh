function mkcd(){
    mkdir -p $1 && cd $1
}

function rmpyc(){
    find . -name "*.pyc" -exec rm -rfv {} \;
}

function gitbranch(){
    # Show current branch on a git directory
    if git branch > /dev/null 2>&1; then
        echo -e "$(git branch 2> /dev/null | grep '^*' | sed 's/^* //') "
    fi
}

function manopt(){
    man $1 | sed 's/.\x08//g' | sed -n "/^\s\+-\+$2\b/,/^\s*$/p" | less
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

function compile-and-test(){

    # function to run tests in programming contest folders

    function clean(){
            find . -regex '.*\.\(py[co]\|out\)$' -delete
            find . -name 'out2.txt' -delete
    }

    if [ -f 'in.txt' -a -f 'out.txt' ]; then
        gcc -Wall *.c -lm 2> /dev/null && ./a.out < in.txt > out2.txt
        test -f out2.txt && echo 'C code: ' && diff out.txt out2.txt && echo ' - OK'
        clean

        g++ -Wall *.cpp -lm 2> /dev/null && ./a.out < in.txt > out2.txt
        test -f out2.txt && echo 'C++ code: ' && diff out.txt out2.txt  && echo ' - OK'
        clean

        test -f *.py && python *.py < in.txt > out2.txt
        test -f out2.txt && echo 'Python code: ' && diff out.txt out2.txt && echo ' - OK'
        clean
    elif [ -f 'out.txt' ]; then
        gcc -Wall *.c -lm 2> /dev/null && ./a.out > out2.txt
        test -f out2.txt && echo 'C code: ' && diff out.txt out2.txt && echo ' - OK'
        clean

        g++ -Wall *.cpp -lm 2> /dev/null && ./a.out > out2.txt
        test -f out2.txt && echo 'C++ code: ' && diff out.txt out2.txt && echo ' - OK'
        clean

        test -f *.py && python *.py > out2.txt
        test -f out2.txt && echo 'Python code: ' && diff out.txt out2.txt && echo ' - OK'
        clean
    fi
}