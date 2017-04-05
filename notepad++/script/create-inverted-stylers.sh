#!/bin/bash

infiles="../stylers.xml ../userDefineLang.xml"
icolors="color-table.txt"

for infile in $infiles
do
    outfile=$( basename $infile .xml ).inv.xml
    cat $infile | sed -r -e "s/fgColor=\"([^\"]+)\"/fgColor=\"\n~\1~\n\"/g" \
    -e "s/bgColor=\"([^\"]+)\"/bgColor=\"\n~\1~\n\"/g" | while read line; do
        if [[ $line =~ ~[A-F0-9]+~ ]]
        then 
            color=$( echo $line | tr -d "~" )
            icolor=$( cat $icolors | grep -e "^$color" | cut -d" " -f2 )
            echo $icolor         
        else
            echo $line
        fi
    done > $outfile
done
