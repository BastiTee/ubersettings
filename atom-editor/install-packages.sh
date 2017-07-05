#!/bin/bash
# -----------------------------------------------------------------------------
#
#   Inspiration
#   ===========
# 
# - http://www.jonobacon.com/2015/11/16/atom-my-new-favorite-code-editor/
# - http://www.marinamele.com/install-and-configure-atom-editor-for-python
#
# -----------------------------------------------------------------------------

SYS_PACKAGES="\
vim
"
ATOM_PACKAGES="\
atom-beautify \
sort-lines \
intentions \
busy-signal \
linter \
linter-flake8 \
linter-ui-default \
autocomplete-python \
symbols-tree-view \
last-cursor-position \
open-recent \
highlight-selected \
tidy-markdown \
color-picker \
minimap \
"

PY_PACKAGES="\
beautysh \
autopep8 \
flake8 \
flake8-docstrings \
"

sudo apt update && \
sudo apt install $SYS_PACKAGES
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
