#!/bin/bash

function print () {
    echo "$( tput setaf 1 )$1$(tput sgr0 )"
}

ideapath=$( find ~ -maxdepth 1 -iname ".Idea*" | head -n1 )
ideapath=${ideapath}/config
echo "--- comparing with: $ideapath"
cd "$( dirname "$( readlink -f "$0" )" )"
find -type f ! -iname "*.sh" | while read ofile
do
    file=$( sed -e "s/_\///" <<< $ofile )
    # bn=$( basename $file )
    ifile=$( ls ${ideapath}/$file 2> /dev/null )
    [ -z "$ifile" ] && { print "--- $file not installed."; continue; }
    print "--- $file <<>> $ifile"
    diff $ofile $ifile
done
