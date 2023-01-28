# dotfiles

## Instalation

```
make run
```

## Manual steps

### On Macs

- Iterm2 theme need to be imported manually. [Reference here](https://draculatheme.com/iterm).

## Troubleshooting

In a new installation of Ansible the problem related to `python3-apt` can
occour.

```
...
"msg": "Could not import python modules: apt, apt_pkg. Please install python3-apt package."
...
```

There are many sugestions listed on the internet, but the
[creation symlinks](https://stackoverflow.com/a/69107017) to the lib `*.so`
solved the problem on Pop!_os.

```
sudo ln -s apt_pkg.cpython*.so apt_pkg.so
sudo ln -s apt_inst.cpython*.so apt_inst.so
```
