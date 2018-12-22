#!/bin/bash

function link() {
    rm -vf "$2"
    ln -vs "$1" "$2"
}

here="$( cd "$( dirname "$0" )"; pwd )"
target=~/Library/Application\ Support/Code/User/

if [ $( hostname ) == "zenbook" ]; then
    rd=".zenbook"
    target=~/.config/Code/User/
fi

mkdir -vp "${target}"
mkdir -vp "${target}/snippets"

link "${here}/settings${rd}.json" "${target}/settings.json"
link "${here}/keybindings${rd}.json" "${target}/keybindings.json"

for file in ${here}/snippets/*; do
    link $file ${target}/snippets/$( basename $file )
done

ls -l "${target}"
ls -l "${target}/snippets"
