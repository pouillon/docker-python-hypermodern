#!/bin/bash

set +e

echo ""
echo "Hypermodern Development Environment:"
echo ""

pyenv --version
echo "pyenv virtualenvs:"
pyenv virtualenvs
echo "pyenv global:"
pyenv global
echo "pyenv local:"
pyenv local
echo ""

python --version
python -m pip --version
python -m wheel version
echo ""

nox --version
poetry --version
pre-commit --version
echo ""

exit 0
