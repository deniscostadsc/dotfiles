kickstart.context 'Python'

source recipes/git.sh

kickstart.git.cloneandpull https://github.com/pyenv/pyenv.git ~/.pyenv
kickstart.git.cloneandpull https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc

source ~/.bashrc

pip install ipython
pip install flake8
pip install pygments
pip install gitlint
