#!/bin/bash

ATOM_PACKAGES="\
atom-beautify \
sort-lines \
linter \
linter-flake8 \
autocomplete-python \
"

PY_PACKAGES="\
beautysh \
autopep8 \
flake8 \
flake8-docstrings \
"

for tool in atom apm pip3; do
    [ -z $( command -v $tool ) ] && { echo "'$tool' not installed."; exit 1; }
done

echo "++ reading installed packages.."
installed=$( apm list --installed | grep "@" | tr "@" " " | awk '{print $2}' )

for atom_package in $ATOM_PACKAGES; do
    echo "++ $atom_package"
    [ -z "$( grep "$atom_package" <<< "$installed" )" ] && {
        apm install $atom_package
    } || {
        echo "   > already installed."
    }
done

sudo -H pip3 install $PY_PACKAGES
