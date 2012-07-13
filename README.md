dotfiles
========

### @deniscostadsc's dotfiles

This project is a collections of dotfiles. I used just on Ubuntu.

to download the project:

```bash
git clone https://github.com/deniscostadsc/dotfiles.git
```

or, on Ubuntu:

```bash
wget https://github.com/deniscostadsc/dotfiles/zipball/master
file-roller -fh master
```

install system applications:

```bash
cd *dotfiles*
sudo ./prepare_environment.sh
```

and then, install the dotfiles

```bash
./install.sh
source ~/.bashrc
```

### Aliases

#### Bash Aliases
```
rself = 'source ~/.bashrc'

ls = 'ls --color=auto'
grep = 'grep --color=auto'
fgrep = 'fgrep --color=auto'
egrep = 'egrep --color=auto'

alias ll = 'ls -alF'
alias la = 'ls -A'
alias l = 'ls -CF'

alert = 'notify-send --urgency=low -i \
    "$([ $? = 0 ] && echo terminal || echo error)" \
    "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
```

#### Git Aliases
```
ga = 'git add'
gb = 'git branch'
gbl = 'git blame'
gc = 'git checkout'
gcl = 'git clone'
gcm = 'git commit -m'
gcma = 'git commit -am'
gd = 'git diff'
gl = 'git log'
glo = 'git log --oneline'
gps = 'git push'
gpl = 'git pull'
gra = 'git remote add'
grm = 'git rm'
grr = 'git remote rm'
gst = 'git status'
```

#### Python Aliases
```
rmpyc = 'find . -name "*.pyc" | xargs rm -v'
```

#### Django aliases
```
dserver = 'python manage.py runserver'
dtest = 'python manage.py test'
dshell = 'python manage.py shell'
ddump = 'python manage.py dumpdata'
dload = 'python manage.py loaddata'
```

### Bash Functions
An map function, to execute a function over a list of parameters:
```bash
$ function square(){ echo $(($1 * $1)); }
$ map square 1 2 3 4 5 6 7 8 9
1
4
9
16
25
36
49
64
81
```

An reduce function, to accumulate a value from a list:
```bash
$ function sum(){ echo $(($1 + $2)); }
$ reduce sum 1 2 3 4 5 6 7 8 9
45
```

An gitbranch function to show current branch on a Git directory:
```bash
$ gitbranch 
(master)
```

An calc function:
```bash
$ calc 2 + 2
4
```

A is_in function to check if a text is in another text:
```bash
$ is_in 'hello' 'hello world'
$ echo $?
0
$ is_in 'cat' 'hello world'
$ echo $?
1
```

### PS1
If you are in a git directory, the prompt (PS1 environment variable) will change to include the branch name.
```bash
~
$ cd Projects/
~/Projects
$ cd dotfiles/
(master)~/Projects/dotfiles
$
```
