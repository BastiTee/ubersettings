#!/bin/bash

# basic rc files
cd $( dirname $( realpath $0 ))
../mklinks.sh ".gitconfig .gitignore .inputrc .screenrc .vimrc .Xresources" ~/
if [ ! -z "$( uname -a | grep -i ubuntu)" ] && [ ! -z $( command -v xrdb ) ]
then
    xrdb ~/.Xresources
fi

# midnight commander
apphome="$( realpath ~ )/.config/mc"
mkdir -p $apphome
../mklinks.sh "ini" $apphome

# profanity cmd-line jabber
apphome="$( realpath ~ )/.config/profanity"
mkdir -p $apphome
../mklinks.sh "profrc" $apphome
