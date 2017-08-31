#!/bin/bash
cd "$( dirname "$( readlink -f "$0" )" )"
[ -z $( command -v nativefier ) ] && sudo npm install -g nativefier
rm -rf build
rm -f ~/.local/share/applications/nativefier_*
mkdir -vp build
defaults="--disable-dev-tools -e 1.4.5"

#------------------------------------------------------------------------------
# HELPER 
#------------------------------------------------------------------------------

function desktop_link () {
trg=~/.local/share/applications/nativefier_${1}.desktop
cat << EOF > $trg
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Name=$1
Icon=$( dirname $( readlink -f $2 ) )/resources/app/icon.png
Exec=$( readlink -f $2 )
StartupNotify=false
StartupWMClass=$1
EOF
chmod 755 $trg
echo "----------"
cat $trg
echo "----------"
}

function run_nativefier () {
    url=$1
    shift 
    name=$1
    shift
    nativefier $url -n $name ${defaults} $@ build/
    desktop_link $name build/$name-linux-x64/$name
}

#------------------------------------------------------------------------------
# SETUPS 
#------------------------------------------------------------------------------

run_nativefier https://trello.com/b/cEBcoTqe/scopevisio trello --maximize --inject trello.css

run_nativefier https://wunderlist.com/de/\#/lists/inbox wunderlist 