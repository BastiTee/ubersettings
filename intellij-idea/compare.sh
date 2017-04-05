#!/bin/bash

function print () {
    echo "$( tput setaf 1 )$1$(tput sgr0 )"
}

ideapath=$( find ~ -maxdepth 1 -iname ".Idea*" | head -n1 )
cd "$( dirname "$( readlink -f "$0" )" )"
find -type f ! -iname "*.sh" | while read file
do
    bn=$( basename $file )
    ifile=$( find $ideapath -iname "$bn" )
    [ -z "$ifile" ] && { print "--- $bn not installed."; continue; }
    print "--- $bn <<>> $ifile"
    diff $bn $ifile
done
