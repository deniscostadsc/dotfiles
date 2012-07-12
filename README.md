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
