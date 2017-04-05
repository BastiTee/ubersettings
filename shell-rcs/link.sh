cd $( dirname $( readlink -f $0 ))
../mklinks.sh ".gitconfig .inputrc .screenrc .vimrc .Xresources" ~/
[ ! -z "$( uname -a | grep -i ubuntu)" ] && [ ! -z $( command -v xrdb ) ] && xrdb ~/.Xresources
profhome="$( readlink -f ~ )/.config/profanity"
mkdir -p $profhome
../mklinks.sh "profrc" $profhome
