#!/bin/bash

# Stop at first error
set -e -o pipefail

# Check arguments
script_name=`basename "${0}"`
python_versions="${*}"
tmp_chk_args=`echo "${python_versions}" | sed -e 's/^[ ]*//; s/[ ]*$//'`
if test "${tmp_chk_args}" = ""; then
  echo "${script_name}: Error: Missing argument(s): Python version(s)" >&2
  exit 1
fi
unset tmp_chk_args

# Install Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Install Pyenv
curl -sSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Update the environment
. "${HOME}/load-hypermodern-env.sh"

# Install the desired versions of Python and their tooling
for version in ${python_versions}; do
  pyenv install "${version}"
  pyenv rehash
  pyenv local "${version}"
  pip install --upgrade pip
  pip install --upgrade wheel
  pip install -c hypermodern-constraints.txt -r hypermodern-requirements.txt
done
pyenv local ${python_versions}
pyenv global ${python_versions}

# Make the environment always available
for rc_file in .bashrc .profile; do
  echo '. "${HOME}/load-hypermodern-env.sh"' >>"${HOME}/${rc_file}"
done

# Report on the installed environments
pyenv global
