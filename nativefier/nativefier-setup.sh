#!/bin/bash
cd "$( dirname "$( realpath "$0" )" )"
[ -z $( command -v nativefier ) ] && sudo npm install -g nativefier
[ $( hostname ) == "zenbook" ] && defaults="$defaults --zoom 1.5"
create_link=1
[ $( uname |tr "[:upper:]" "[:lower:]" ) == "darwin" ] && create_link=

#------------------------------------------------------------------------------
# HELPER
#------------------------------------------------------------------------------

function desktop_link () {
    if [ -z "$create_link" ]; then return; fi
    trg=~/.local/share/applications/nativefier_${1}.desktop
cat << EOF > $trg
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Name=$1
Icon=$( dirname $( realpath $2 ) )/resources/app/icon.png
Exec=$( realpath $2 )
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
    rm -rf build/$name-linux-x64
    nativefier $url -n $name \
    --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/60.0.3112.113 Chrome/60.0.3112.113 Safari/537.36" --disable-dev-tools --disable-context-menu \
    $@ build/
    desktop_link $name build/$name-linux-x64/$name
}

#------------------------------------------------------------------------------
# SETUPS
#------------------------------------------------------------------------------

mkdir -vp build

if [ ! -z "$1" ] # if provided, only run nativefier for given URL
then
    run_nativefier $@
    exit 0
fi

# otherwise run standards
run_nativefier https://wunderlist.com/de/\#/lists/inbox wunderlist
run_nativefier https://twitter.com/ twitter
run_nativefier https://keep.google.com keep
