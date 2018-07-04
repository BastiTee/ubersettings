#!/bin/bash

cd $( cd "$( dirname "$0" )"; pwd )
rm -rf gen
mkdir -p gen
sudo mkdir -p /Library/Scripts/Basti
sudo chmod 777 /Library/Scripts/Basti
tools="\
Finder \
Google_Chrome \
Terminal \
Atom \
IntelliJ_IDEA_CE \
Visual_Studio_Code \
Microsoft_Outlook \
Slack \
Firefox \
Spotify \
"

i=1
for tool in $tools; do
    echo "---"
  pad=$( printf "%02g" $i )
  i=$(( $i + 1 ))
  trg=$( echo "gen/Focus_${pad}_$( sed -e "s/ /_/g" \
  <<< ${tool} ).applescript" )
  bn=$( basename $trg )
  tool_ws=$( sed -e "s/_/ /g" <<< $tool )
  echo "-- '$tool_ws' > $trg ($bn)"
  sed -e "s/##TOOL##/$tool_ws/g" Template.AppleScript > $trg
  cp -v $trg /Library/Scripts/Basti/$bn
done
