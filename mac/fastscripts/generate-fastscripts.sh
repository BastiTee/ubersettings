#!/bin/bash

cd $( dirname $( realpath $0 ))
rm -rf gen
mkdir -p gen
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
Pivotal \
"

i=1
for tool in $tools; do
  pad=$( printf "%02g" $i )
  i=$(( $i + 1 ))
  trg=$( realpath "gen/Focus_${pad}_$( sed -e "s/ /_/g" \
  <<< ${tool} ).applescript" )
  bn=$( basename $trg )
  tool_ws=$( sed -e "s/_/ /g" <<< $tool )
  echo "-- '$tool_ws' > $trg ($bn)"
  sed -e "s/##TOOL##/$tool_ws/g" Template.AppleScript > $trg
  cp -v $trg /Library/Scripts/Basti/$bn
done
