#!/bin/bash

function link() {
    rm -vf "$2"
    ln -vs "$1" "$2"
}

here="$( cd "$( dirname "$0" )"; pwd )"
target=~/.atom
mkdir -vp ${target}

[ $( hostname ) == "zenbook" ] && rd=".zenbook" ||rd=""

# defaults
link ${here}/keymap${rd}.cson ${target}/keymap.cson
link ${here}/snippets.cson ${target}/snippets.cson
link ${here}/config.cson ${target}/config.cson
link ${here}/init${rd}.coffee ${target}/init.coffee
link ${here}/styles.less ${target}/styles.less

ls -l ${target}
