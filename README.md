dotfiles
========

### @deniscostadsc's dotfiles

This project is a collections of my personal dotfiles used on my Ubuntu machine.

clone the project

```bash
git clone https://github.com/deniscostadsc/dotfiles.git
```

or download it:

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

