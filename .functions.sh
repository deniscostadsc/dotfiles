function mkcd {
    mkdir -p $1 && cd $1
}

function rmpyc {
    find . -name "*.pyc" -delete;
}

function screencast {
    now=$(date +"%Y%m%d-%H%M%S")
    ffmpeg -f x11grab -s 1366x768 -r 25 -i :0.0 -acodec pcm_s16le -sameq -f alsa -ac 2 -i pulse ~/screencast_$now.mkv
}

function git_rm {
    git rm $* 2> /dev/null || trash $*
}

function git_mv {
    git mv $* 2> /dev/null || mv $*
}

function remove_trailing_spaces {
    find . -regex '.*\.py\|.*\.php\|.*\.js\|.*\.c\|.*\.cpp\|\|.*\.sh.*\.html' |\
        xargs sed -i 's/[[:space:]]\+$//'
}

function update_fonts {
    find ~/Dropbox/fonts -regex '.*\.ttf\|.*\.otf' -exec cp '{}' ~/.local/share/fonts/ \;
}

function sysname {
    # Show Ubuntu version
    codename="$(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/^[^=]\+=//')"

    if [[ $1 =~ ^(-a|--all)$ ]]; then
        description="$(grep 'DISTRIB_DESCRIPTION' /etc/lsb-release | sed 's/^[^=]\+=//;s/\"//g')"
        echo "$description $codename"
    else
        echo "$codename"
    fi
}

# Programming contests traiining helpers

function new-problem {
    if [ -z $1 ]; then
        echo "You should inform a problem ID."
        return 1
    fi

    if [ -z $2 ]; then
        echo "You should inform a language."
        return 1
    fi

    dir=$1
    language=$2

    if [ -d $dir ]; then
        echo "Already there is a folder called $dir."
        return 1
    fi

    mkcd $dir && echo "Created $dir."

    touch in.txt
    touch out.txt
    touch problem.txt
    touch $dir.$language
}

function marathon {

    # function to run tests in programming contest folders

    function clean {
            find . -regex '.*\.\(py[co]\|out\)$' -delete
            find . -name 'out2.txt' -delete
    }

    function _test {
        test -f out2.txt && echo "$1" && diff out.txt out2.txt && echo ' - OK'
    }

    if [ -f 'in.txt' -a -f 'out.txt' ]; then
        if [ -f *.c ]; then
            gcc -Wall *.c -lm && ./a.out < in.txt > out2.txt
            _test 'C code: '
            clean
        fi

        if [ -f *.cpp ]; then
            g++ -Wall *.cpp -lm && ./a.out < in.txt > out2.txt
            _test 'C++ code: '
            clean
        fi

        if [ -f *.py ]; then
            python *.py < in.txt > out2.txt
            _test 'Python code: '
            clean
        fi

        if [ -f *.js ]; then
            node *.js < in.txt > out2.txt
            _test 'Javascript code: '
            clean
        fi

    elif [ -f 'out.txt' ]; then
        if [ -f *.c ]; then
            gcc -Wall *.c -lm && ./a.out > out2.txt
            _test 'C code: '
            clean
        fi

        if [ -f *.cpp ]; then
            g++ -Wall *.cpp -lm && ./a.out > out2.txt
            _test 'C++ code: '
            clean
        fi

        if [ -f *.py ]; then
            python *.py > out2.txt
            _test 'Python code: '
            clean
        fi

        if [ -f *.js ]; then
            node *.js > out2.txt
            _test 'Javascript code: '
            clean
        fi
    fi
}
