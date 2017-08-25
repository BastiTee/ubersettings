#!/bin/bash
cd $( dirname $( readlink -f $0 ))

function link() {
    rm -vf "$2"
    ln -vs "$(pwd)/$1" "$2"
}

target=~/.atom
hn=$( hostname )
mkdir -vp ${target}

# defaults
link keymap.cson ${target}/keymap.cson
link snippets.cson ${target}/snippets.cson
link init.coffee ${target}/init.coffee
# machine-specific 
[ $hn == "zenbook" ] && config="config.zenbook.cson" || config="config.cson"
link $config ${target}/config.cson
[ $hn == "zenbook" ] && config="styles.zenbook.less" || config="styles.less"
link $config ${target}/styles.less

#
ls -l ~/.atom
