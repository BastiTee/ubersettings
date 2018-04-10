#!/bin/bash

cd $( dirname $( realpath $0 ))
rm -rf gen
mkdir -p gen
tools="\
Finder \
Chrome \
Terminal \
Atom \
IntelliJ_IDEA \
Microsoft_Outlook \
Slack \
MacPass \
Firefox \
Spotify \
"

for tool in $tools; do
  trg=$( realpath "gen/Focus_$( sed -e "s/ /_/g" <<< ${tool} ).applescript" )
  bn=$( basename $trg )
  tool_ws=$( sed -e "s/_/ /g" <<< $tool )
  echo "-- '$tool_ws' > $trg ($bn)"
  sed -e "s/##TOOL##/$tool_ws/g" Template.AppleScript > $trg
  cp -v $trg /Library/Scripts/Basti/$bn
done
