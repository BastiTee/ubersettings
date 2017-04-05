#!/bin/bash
# This script extracts all hex color codes from infile, inverts the colors 
# and writes it to stdout. 

infile="../stylers.xml ../userDefineLang.xml"

inv () {
    echo "\
$( printf "%02s" $( echo "obase=16;ibase=16;$1-FF" | bc | tr -d "-" ) ) \
$( printf "%02s" $( echo "obase=16;ibase=16;$2-FF" | bc | tr -d "-" ) ) \
$( printf "%02s" $( echo "obase=16;ibase=16;$3-FF" | bc | tr -d "-" ) ) "
}

cat $infile | tr " " "\n" | grep -i "color" | sed -e "s/\"/ /g" |\
awk '{print $2}' | sort -u | while read cl; do 
    rgbhex=$( echo $cl | sed -r -e "s/(.{2})(.{2})(.{2})/\1 \2 \3/" )
    rgbhexi=$( inv $rgbhex )
    echo "$rgbhex~$rgbhexi" | tr -d " " | tr "~" " " |\
    awk '{print $1" "$2}'
done 
