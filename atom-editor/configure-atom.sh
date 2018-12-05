#!/bin/bash
# -----------------------------------------------------------------------------
# BASTI'S ATOM SETUP FOR UBUNTU
# -----------------------------------------------------------------------------

sudo echo # to prompt immediately

dist=$( grep "DISTRIB_ID" /etc/lsb-release 2> /dev/null | tr "=" " " |\
awk '{print $2}' | tr "[:upper:]" "[:lower:]" )
[ -z "$dist" ] && dist="mac"
echo ">> running: $dist"

SYS_PACKAGES_MAC="\
moreutils \
python3 \
wget \
`# Spell checking package` \
hunspell
"

SYS_PACKAGES_UBUNTU="\
moreutils \
python3 \
python3-pip \
`# Spell checking package` \
hunspell \
hunspell-de-de \
hunspell-en-gb \
hunspell-en-us \
"

SYS_PACKAGES_MANJARO="\
moreutils \
python3 \
`# Spell checking package` \
hunspell \
hunspell-de \
hunspell-en \
"

ATOM_PACKAGES="\
`# ----- UTILITIES -----`
`# Basic sorting of selected lines` \
sort-lines \
`# Allow for jumping between cursor positions` \
last-cursor-position \
`# Open recent files/projects` \
open-recent \
`# Highlights the current word selected when double clicking` \
highlight-selected \
`# Hyperclick subsystem` \
hyperclick \
`# Open hyperlink in new browser window` \
hyperlink-hyperclick \
`# Graphical color selector` \
color-picker \
`# A sublime style preview of the full source code` \
minimap \
`# A package to display colors in project and files` \
pigments \
`# Beautify HTML, CSS, JavaScript, Python and more in Atom` \
atom-beautify \
`# Diffs text between two split panes` \
split-diff \
`# ----- LINTER FEATURES -----`
`# Base package for showing intentions in Atom` \
intentions \
`# Easy to use API to show your package is performing a task` \
busy-signal \
`# ----- IDE FEATURES -----`
`# A collection of Atom UIs to support language services` \
atom-ide-ui \
`# TypeScript and JavaScript language support` \
ide-typescript \
`# Python language support` \
ide-python \
`# Docker language support` \
language-docker \
`# ----- COLLABORATION FEATURES -----`
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

echo "++ updating atom"
if [ "$dist" == "ubuntu" ]; then
  dl_link=$( curl -s https://atom.io/download/deb |\
  sed -e "s/.*href=\"//" -e "s/\".*/\n/" -e "s/?.*/\n/" )
  version_remote=$( echo $dl_link | sed -e "s/.*\/v//" -e "s/\/.*//" )
  version_local=$( atom --version | head -n1 | awk '{ print $3}' )
  echo "   dl-link: $dl_link"
  echo "   dl-vers: $version_remote"
  echo "   lo-vers: $version_local"
  # version_local="1.0.0"
  if [ "$version_local" == "$version_remote" ]
  then
      echo "   -- atom up-to-date"
  else
      echo "   -- newer version available"
      curl -L https://atom.io/download/deb --output /tmp/atom.deb
      sudo apt install /tmp/atom.deb
      rm -f /tmp/atom.deb
  fi
else
  echo "On Mac only manual Atom updates are supported."
fi

echo "++ installing system dependencies"
if [ "$dist" == "manjarolinux" ]; then
  sudo pacman -Syu --needed --noconfirm $SYS_PACKAGES_MANJARO
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python3 get-pip.py
  rm get-pip.py
elif [ "$dist" == "ubuntu" ]; then
  sudo apt update && sudo apt install -y $SYS_PACKAGES_UBUNTU
elif [ "$dist" == "mac" ]; then
   brew install $SYS_PACKAGES_MAC
   wget https://bootstrap.pypa.io/get-pip.py
   sudo python3 get-pip.py
   rm get-pip.py
fi
sudo -H python3 -m pip install $PY_PACKAGES

for tool in atom apm; do
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

if [ "$dist" != "mac" ]; then
  echo "++ fix hunspell dictionaries"
  tmpf=$( mktemp )
  cat << EOF > $tmpf
  cd /usr/share/hunspell
  file * | grep "ISO-8859 text" | grep -v ".old" | cut -d":" -f1 |\
  while read file; do
      iconv -f "iso-8859-1" -t "utf-8" \$file > \${file}.2
      [ ! -f \${file}.old ] && mv \${file} \${file}.old
      mv \${file}.2 \${file}
  done
  echo "---"
  file *
EOF
  chmod a+x $tmpf
  sudo $tmpf
  rm $tmpf
fi

echo "++ uninstalling experimental apm-packages"
uninstall_list=""
for pack in $(apm list -pbi | tr "@" " " | awk '{print $1}' | grep -v -e "^$")
do
    sys_pack_search=$( echo $ATOM_PACKAGES | tr " " "\n" | grep $pack )
    if [ -z "$sys_pack_search" ];
    then
        uninstall_list="$uninstall_list $pack"
    fi
done
echo "++ packages: $uninstall_list"
[ ! -z "$uninstall_list" ] && apm uninstall $uninstall_list

echo "++ upgrading apm-packages"
apm upgrade --no-confirm

cd $( cd "$( dirname "$0" )"; pwd )
ls
