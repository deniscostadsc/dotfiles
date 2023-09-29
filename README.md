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
