#!/bin/bash

function help() {
echo $@
cat << EOF
Usage: $( basename $0 ) [color-in] [color-out]
EOF
exit 1
}

cd $( dirname $( dirname $( readlink -f $0 )))
echo "-- cwd = $( pwd )"
[ -z $1 ] && help "No color-in set."
[ -z $2 ] && help "No color-out set."
inc=$( sed -r -e "s/^#+//" <<< $1 )
outc=$( sed -r -e "s/^#+//" <<< $2 )
echo "-- converting $inc to $outc"

find -type f | grep -v -e "\.git" -e "color-palette" -e "README" -e "LICENSE" |\
while read file
do
    hascol=$( cat $file | grep -i "#$inc" )
    [ -z "$hascol" ] && continue
    echo "   + $file"
    cat $file | grep -i "#$inc"
    sed -i "s/#$inc/#$outc/Ig" $file
done

echo "-- done"
