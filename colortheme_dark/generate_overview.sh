#!/bin/bash

SIZE=50
FRAME=$(( $SIZE + 1 ))
CCM=README.md
LOCAL_UID=$( uuidgen | sed -e "s/-.*//g" )

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPTDIR

rm *.svg $CCM 2>/dev/null

touch $CCM
echo "## Color codes" >> $CCM
echo "" >> $CCM
echo "| *Color* | *RGB* | *HEX* | *SAMPLE* |" >> $CCM
echo "|---|---|---| ---|" >> $CCM

cat _colors.txt | grep -v -e "^$" | while read line; do
    R=$( echo $line | awk '{print $1}' )
    G=$( echo $line | awk '{print $2}' )
    B=$( echo $line | awk '{print $3}' )
    LABEL=$( echo $line | awk '{print $4}' | tr "-" " " )
    HEX="$( echo "obase=16; $R" | bc )$( echo "obase=16; $G" | bc )$( echo "obase=16; $B" | bc )"
    SVG_FILE="${HEX}_${LOCAL_UID}.svg"
    echo "Processing: $line --> $HEX"
    echo "| $LABEL | $R $G $B | $HEX |
![](https://cdn.rawgit.com/BastiTee/ubersettings/master/colortheme_dark/${SVG_FILE}) |" >> $CCM 
    echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"$FRAME\" height=\"$FRAME\" >\n<rect  width=\"$SIZE\" height=\"$SIZE\" fill=\"~~~COLOR~~~\" stroke=\"black\" stroke-width=\"1\" /></svg>\n" | sed -e "s/~~~COLOR~~~/#${HEX}/" > ${SVG_FILE}
done

ls -l *.svg 2>/dev/null
echo ""
cat $CCM 

