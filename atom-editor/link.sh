cd $( dirname $( readlink -f $0 ))
../mklinks.sh "*.coffee *.cson *.less" ~/.atom
