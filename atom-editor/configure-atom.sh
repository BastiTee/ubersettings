#!/bin/bash
# -----------------------------------------------------------------------------
# BASTI'S ATOM EXTENSION RECOMMENDATIONS
# -----------------------------------------------------------------------------

SYS_PACKAGES="\
moreutits \
vim \
python3 \
python3-pip \
`# Spell checking package` \
hunspell-de-de \
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
`# Hyperclick subsystem` \
hyperclick \
`# Open hyperlink in new browser window` \
hyperlink-hyperclick \
`# Collaborative coding` \
teletype
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

# fix hunspell dictionaries ----------------------------
tmpf=$( mktemp )
cat << EOF > $tmpf
cd /usr/share/hunspell
file * | grep "ISO-8859 text" | cut -d":" -f1 |\
while read file; do
    iconv -f "iso-8859-1" -t "utf-8" \$file > \${file}.2
    mv \${file} \${file}.old
    mv \${file}.2 \${file}
done
echo "---"
file *
EOF
chmod a+x $tmpf
sudo $tmpf
rm $tmpf
