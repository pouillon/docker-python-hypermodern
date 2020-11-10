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
