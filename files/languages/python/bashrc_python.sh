# shellcheck disable=SC2148
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

function rmpyc {
    find . -name "*.pyc" -delete
}

eval "$(pyenv virtualenv-init -)"
