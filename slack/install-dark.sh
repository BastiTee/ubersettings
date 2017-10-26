#!/bin/bash
[ $( whoami ) != "root" ] && { echo "run as root!"; exit 1; }
cd "$( dirname "$( readlink -f "$0" )" )"
# -----------------------------------------------------------------------------
base="/usr/lib/slack/resources/app.asar.unpacked/src/static/"
# if already changed, then restore old first
[ -f ${base}/index.js.old ] && {
    mv ${base}/index.js.old ${base}/index.js
}
cp ${base}/index.js ${base}/index.js.old
echo >> ${base}/index.js
cat theme.js >> ${base}/index.js
# show result
cat ${base}/index.js
echo