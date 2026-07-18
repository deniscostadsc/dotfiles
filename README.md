# dotfiles

:warning: **DISCLAIMER: This project is intentended to be a personal project to setup my
personal computers.**

[![CI workflow status](https://github.com/deniscostadsc/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/deniscostadsc/dotfiles/actions)

- [dotfiles](#dotfiles)
  - [Running the playbooks](#running-the-playbooks)
    - [On Pop!\_os](#on-pop_os)
    - [On MacOS](#on-macos)
    - [Manual steps](#manual-steps)
      - [On MacOS](#on-macos-1)
  - [Development](#development)
    - [Running the tests](#running-the-tests)
  - [Troubleshooting](#troubleshooting)
    - [Pop!\_os](#pop_os)
      - [Could not import python modules: apt, apt\_pkg. Please install python3-apt package.](#could-not-import-python-modules-apt-apt_pkg-please-install-python3-apt-package)
      - [ERROR! ansible-galaxy requires resolvelib\<1.1.0,\>=0.5.3](#error-ansible-galaxy-requires-resolvelib110053)
  - [What this project does](#what-this-project-does)
    - [Applications installed](#applications-installed)
    - [Packages installed](#packages-installed)
    - [Bash](#bash)
    - [Code Editors](#code-editors)
    - [Docker](#docker)
    - [Git](#git)
    - [SSH](#ssh)
    - [Terminal (emulators)](#terminal-emulators)

## Running the playbooks

To execute playbook, you need to install ansible and its dependencies locally.
To do that run the following commands:

### On Pop!_os

```
sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```

### On MacOS

```
pip3 install ansible-core
ansible-galaxy collection install --requirements-file roles/requirements.yml --upgrade
```

After that, you can run the playbooks:

```
make run
```

### Manual steps

#### On MacOS

- [Iterm profile config](/roles/terminal/files/iterm/Default.json) needs to be imported manually.
  1. iTerm2 > **Preferences** > **Profiles**;
  1. Open the **Other Actions...** drop-down in the bottom left corner;
  1. Select **Import JSON Profiles...** from the list;
  1. Select the `DenisCosta.json` file;
  1. Select **DenisCosta** from the Profiles list;
  1. Set it as default in the same dropdown below.

- [Iterm2 theme](/roles/terminal/files/iterm/Dracula.itermcolors) needs to be imported
  manually. [Reference here](https://draculatheme.com/iterm).

  1. iTerm2 > **Preferences** > **Profiles** > **Colors Tab**;
  1. Open the **Color Presets...** drop-down in the bottom right corner;
  1. Select **Import...** from the list;
  1. Select the `Dracula.itermcolors` file;
  1. Select **Dracula** from **Color Presets**.

Look at [Terminal role README](/roles/terminal/README.md) for more information.

## Development

### Running the tests

There are make tasks to run lint and tests

```
make lint
make lint-fix
make test
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

There are many sugestions listed on the internet, but the [creation
symlinks](https://stackoverflow.com/a/69107017) to the lib `*.so` solved the
problem on Pop!_os.

```
cd /usr/lib/python3/dist-packages
sudo ln -s apt_pkg.cpython*.so apt_pkg.so
sudo ln -s apt_inst.cpython*.so apt_inst.so
```

#### ERROR! ansible-galaxy requires resolvelib<1.1.0,>=0.5.3

```
pip uninstall resolvelib
pip install resolvelib==1.0.1
```

## What this project does

### Applications installed

- [Caffeine](https://www.caffeine-app.net/) (MaCOS)
- [Dash](https://kapeli.com/dash) (MacOS)
- [DBeaver](https://dbeaver.io/)
- [docker-compose](https://docs.docker.com/compose/)
- [Docker](https://docs.docker.com/)
- [Dropbox](https://www.dropbox.com/)
- [firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Google Chrome](https://www.google.com/intl/en/chrome/)
- [iTerm2](https://iterm2.com/) (MacOS)
- [Password Gorilla](https://github.com/zdia/gorilla#readme)
- [Slack](https://slack.com/)
- [Spotify](https://www.spotify.com)
- [Terminator](https://gnome-terminator.org/) (Linux)
- [Visual Studio Code](https://code.visualstudio.com/)
- [VLC](https://www.videolan.org/vlc/)
- [Zeal](https://zealdocs.org/) (Linux)

### Packages installed

- [Ag (The Silver Searcher)](https://github.com/ggreer/the_silver_searcher#readme)
- [asdf](https://github.com/asdf-vm/asdf#readme)
- [bat](https://github.com/sharkdp/bat#readme)
- [delta](https://github.com/dandavison/delta#readme)
- [ffmpeg](https://ffmpeg.org/)
- [fzf](https://github.com/junegunn/fzf#readme)
- [Git](https://git-scm.com/)
- [GnuPG](https://gnupg.org/)
- [Homebrew](https://brew.sh/) (MacOS)
- [htop](https://github.com/htop-dev/htop#readme)
- [jq](https://jqlang.github.io/jq/)
- [Neovim](https://neovim.io/)
- [ripgrep](https://github.com/BurntSushi/ripgrep#readme)
- [tig](https://github.com/jonas/tig#readme)
- [tree](https://linux.die.net/man/1/tree)
- [z](https://github.com/rupa/z/#readme)

### Bash

Look at [bash README](/roles/bash/README.md) for more details.

### Code Editors

Look at [code editors README](/roles/code_editors/README.md) for more details.

### Docker

Creates a Docker user group and adds the current user to it on Linux. This step
is required to avoid use of `sudo` for every docker command you run.

Add also the command `docker-full-clean` that remove everything related to
Docker. Like images, containers, cache, volumes, etc..

### Git

Look at [Git role README](/roles/git/README.md) for more details.

### SSH

Look at [SSH role README](/roles/ssh/README.md) for more details.

### Terminal (emulators)

Look at [Terminal role README](/roles/terminal/README.md) for more details.
