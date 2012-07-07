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
