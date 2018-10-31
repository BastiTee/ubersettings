#!/bin/bash

function link() {
    rm -vf "$2"
    ln -vs "$1" "$2"
}

here="$( cd "$( dirname "$0" )"; pwd )"
target=/Library/Scripts/Basti
mkdir -vp ${target}
chmod -R 777 ${target}
rm -rv ${target}/*

# defaults
for file in *.applescript; do
    cp ${here}/$file ${target}/$file
done

ls -la ${target}
