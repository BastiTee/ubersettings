#!/bin/bash

# basic rc files
cd $( dirname $( readlink -f $0 ))
../mklinks.sh ".gitconfig .gitignore .inputrc .screenrc .vimrc .Xresources" ~/
if [ ! -z "$( uname -a | grep -i ubuntu)" ] && [ ! -z $( command -v xrdb ) ]
then
    xrdb ~/.Xresources
fi

# midnight commander
apphome="$( readlink -f ~ )/.config/mc"
mkdir -p $apphome
../mklinks.sh "ini" $apphome

# profanity cmd-line jabber
apphome="$( readlink -f ~ )/.config/profanity"
mkdir -p $apphome
../mklinks.sh "profrc" $apphome
