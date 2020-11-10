#!/bin/bash

if test "`which poetry 2>/dev/null`" = ""; then
  . "${HOME}/.poetry/env"
fi

if test "${PYENV_ROOT}" = ""; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

echo ""
echo "Hypermodern Development Environment:"
echo ""

python --version
python -m pip --version
python -m wheel version
echo ""

nox --version
poetry --version
pre-commit --version
echo ""

pyenv --version
pyenv virtualenvs
echo ""
