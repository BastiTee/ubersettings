#!/bin/sh
cd "$( cd "$( dirname "$0" )"; pwd )"

for f in `find . -type f`; do
    if [ "$f" = "." ]; then continue; fi
    if [[ "$f" =~ .*\.sh ]]; then continue; fi
    echo "ln -s $( pwd )$( dirname $f | sed -e "s/^\.// " )/$( basename $f )"
done
