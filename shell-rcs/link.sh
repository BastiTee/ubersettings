#!/bin/bash

mkdir -p ~/.config/mc
mkdir -p ~/.config/profanity


# basic rc files
cd $( cd "$( dirname "$0" )"; pwd )
../mklinks.sh ".gitconfig .gitignore .inputrc .screenrc .vimrc .Xresources" ~/
if [ ! -z "$( uname -a | grep -i ubuntu)" ] && [ ! -z $( command -v xrdb ) ]
then
    xrdb ~/.Xresources
fi

# midnight commander
apphome=~/.config/mc
mkdir -p $apphome
../mklinks.sh "ini" $apphome
../mklinks.sh "ini.theme" $apphome

# profanity cmd-line jabber
apphome=~/.config/profanity
mkdir -p $apphome
../mklinks.sh "profrc" $apphome
