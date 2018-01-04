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
link config.cson ${target}/config.cson

# machine-specific
[ $hn == "zenbook" ] && config="init.zenbook.coffee" || config="init.coffee"
link $config ${target}/init.coffee

[ $hn == "zenbook" ] && config="styles.zenbook.less" || config="styles.less"
link $config ${target}/styles.less

#
ls -l ~/.atom
