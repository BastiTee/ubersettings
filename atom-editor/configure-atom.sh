#!/bin/bash
# -----------------------------------------------------------------------------
# BASTI'S ATOM EXTENSION RECOMMENDATIONS
# -----------------------------------------------------------------------------

SYS_PACKAGES="\
vim \
python3 \
python3-pip \
"

ATOM_PACKAGES="\
`# Beautify HTML, CSS, JavaScript, Python and more in Atom` \
atom-beautify \
`# Basic sorting of selected lines` \
sort-lines \
`# Base package for showing intentions in Atom` \
intentions \
`# Provides an easy to use API to show your package is performing a task` \
busy-signal \
`# A Base Linter with Cow Powers` \
linter \
`# Default UI for the Linter package` \
linter-ui-default \
`# Linter for Python / flake8` \
linter-flake8 \
`# Python completions for packages, variables, etc with their arguments` \
autocomplete-python \
`# Allow for jumping between cursor positions` \
last-cursor-position \
`# Open recent files/projects` \
open-recent \
`# Highlights the current word selected when double clicking` \
highlight-selected \
`# Graphical color selector` \
color-picker \
`# A sublime style preview of the full source code` \
minimap \
`# A package to display colors in project and files` \
pigments \
`# A collection of Atom UIs to support language services` \
atom-ide-ui \
`# TypeScript and JavaScript language support for Atom-IDE` \
ide-typescript \
`# Python language support for Atom-IDE` \
ide-python \
"

PY_PACKAGES="\
`# System-package to beautify shell scripts with atom-beautify` \
beautysh \
`# System-packages to beautify python with atom-beautify` \
autopep8 \
flake8 \
flake8-docstrings \
python-language-server \
"

sudo apt update && \
sudo apt install -y $SYS_PACKAGES
sudo -H python3 -m pip install $PY_PACKAGES

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
