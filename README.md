# dotfiles

## Running the playbooks

To execute playbook, you need to install ansible and its dependencies locally.
To do that run the following commands

```
pip3 install ansible-core
```

After that, you can run the playbooks:

```
make run
```

## Manual steps

### On MacOS

- [Iterm2 theme](roles/terminal/files/Dracula.itermcolors) need to be imported manually. [Reference here](https://draculatheme.com/iterm).

## What this project does

### Packages installed

- [asdf](https://github.com/asdf-vm/asdf)
- [bat](https://github.com/sharkdp/bat)
- [Caffeine](https://www.caffeine-app.net/) (MaCOS)
- [Dash](https://kapeli.com/dash) (MacOS)
- [DBeaver](https://dbeaver.io/)
- [docker-compose](https://docs.docker.com/compose/)
- [Docker](https://docs.docker.com/)
- [Dropbox](https://www.dropbox.com/)
- [ffmpeg](https://ffmpeg.org/)
- [firefox](https://www.mozilla.org/en-US/firefox/new/)
- [fzf](https://github.com/junegunn/fzf)
- [Git](https://git-scm.com/)
- [GnuPG](https://gnupg.org/)
- [Google Chrome](https://www.google.com/intl/en/chrome/)
- [Homebrew](https://brew.sh/) (MacOS)
- [htop](https://github.com/htop-dev/htop)
- [iterm](https://iterm2.com/) (MacOS)
- [jq](https://jqlang.github.io/jq/)
- [Neovim](https://neovim.io/)
- [Password Gorilla](https://github.com/zdia/gorilla)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [Slack](https://slack.com/)
- [Spotify](https://www.spotify.com)
- [Terminator](https://gnome-terminator.org/) (Linux)
- [tig](https://github.com/jonas/tig)
- [tmux](https://github.com/tmux/tmux)
- [tree](https://linux.die.net/man/1/tree)
- [Visual Studio Code](https://code.visualstudio.com/)
- [VLC](https://www.videolan.org/vlc/)
- [Zeal](https://zealdocs.org/) (Linux)

### Bash

#### Commands

Installs the following commands:

- [clipboard](roles/bash/files/bin/clipboard.sh) (you can copy/paste using shell redirections and pipes)
- [colors](roles/bash/files/bin/colors.sh) (cheatsheet for colors on terminal)
- [ll](roles/bash/files/bash_aliases.sh) (alias for `ls -alhF`)
- [mkcd](roles/bash/files/bash_functions.sh) (create and got into a directory)
- [passphrase](roles/bash/files/bin/passphrase.sh) (generates passphrases)

#### Commands with color

Adds color by default to the following command:

- egrep
- fgrep
- grep
- ls

#### Terminal prompt

Costomizes PS1 variable, which is responsible for the prompt on terminals, like bellow:

```
~/projects/personal/dotfiles 13:55:25 master ⇡
$
```

It shows:

- Current folder name
- Time when the promt was shown on screen
- Git branch name (if current directory is in a Git repository)
- Arrows that indicates you are ahead/behind remote branch

#### Terminal history

Sets the history to 100000 commands, while avoid logging in history the following commands:

- bg
- clear
- fg
- ll
- ls
- pwd

It also add the date and time to history output. See example bellow:

```
~/projects/personal/dotfiles 13:55:25 master ⇡
$ history
...
11374  22/11/20 - 13:54:43 git commit
11375  22/11/20 - 13:55:25 git status
11376  22/11/20 - 13:56:05 history
```

## Troubleshooting

### Pop!_os

#### Could not import python modules: apt, apt_pkg. Please install python3-apt package.

In a new installation of Ansible a problem related to `python3-apt` can occour.

```
...
"msg": "Could not import python modules: apt, apt_pkg. Please install python3-apt package."
...
```

There are many sugestions listed on the internet, but the
[creation symlinks](https://stackoverflow.com/a/69107017) to the lib `*.so`
solved the problem on Pop!_os.

```
cd /usr/lib/python3/dist-packages
sudo ln -s apt_pkg.cpython*.so apt_pkg.so
sudo ln -s apt_inst.cpython*.so apt_inst.so
```
