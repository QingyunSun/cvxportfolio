#!/bin/bash
# This script is meant to be called by the "install" step defined in
# .travis.yml. See http://docs.travis-ci.com/ for more details.
# The behavior of the script is controlled by environment variabled defined
# in the .travis.yml in the top level folder of the project.

set -e

# Deactivate the travis-provided virtual environment and setup a
# conda-based environment instead
deactivate

# Use the miniconda installer for faster download / install of conda
# itself
wget http://repo.continuum.io/miniconda/Miniconda-3.9.1-Linux-x86_64.sh \
    -O miniconda.sh
chmod +x miniconda.sh && ./miniconda.sh -b
export PATH=/home/travis/miniconda/bin:$PATH
conda update --yes conda

conda create -n testenv --yes python=$PYTHON_VERSION pip nose pandas
source activate testenv
conda install --yes -c cvxgrp cvxpy matplotlib
pip install flake8

if [[ "$COVERAGE" == "true" ]]; then
    pip install coverage coveralls
fi
