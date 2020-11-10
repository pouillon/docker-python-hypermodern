#!/bin/bash

# Stop at first error
set -e

# Check arguments
script_name=`basename "${0}"`
python_versions="${*}"
tmp_chk_args=`echo "${python_versions}" | sed -e 's/^[ ]*//; s/[ ]*$//'`
if test "${tmp_chk_args}" = ""; then
  echo "${script_name}: Error: Missing argument(s): Python version(s)" >&2
  exit 1
fi
unset tmp_chk_args

# Update the environment
. "${HOME}/hypermodern-env.sh"

# Create a virtual environment for application development
python_default=`echo "${python_versions}" | awk '{print $1}'`
pyenv virtualenv "${python_default}" hypermodern
pyenv activate hypermodern
pip install --upgrade pip
pip install --upgrade wheel
pip install -c hypermodern-constraints.txt -r hypermodern-requirements.txt
pip install -c app-constraints.txt -r app-requirements.txt
pyenv deactivate

# Report on the installed environments
pyenv virtualenvs
