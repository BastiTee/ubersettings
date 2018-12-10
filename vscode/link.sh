#!/bin/bash

function link() {
    rm -vf "$2"
    ln -vs "$1" "$2"
}

here="$( cd "$( dirname "$0" )"; pwd )"
target=~/Library/Application\ Support/Code/User/
mkdir -vp "${target}"

[ $( hostname ) == "zenbook" ] && rd=".zenbook" ||rd=""

# defaults
link "${here}/settings${rd}.json" "${target}/settings.json"
link "${here}/keybindings${rd}.json" "${target}/keybindings.json"

ls -l "${target}"
