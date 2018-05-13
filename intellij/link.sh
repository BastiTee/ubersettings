#!/bin/bash

cd $( dirname $( realpath $0 ))

# Lookup configuration folder
if [ "$( hostname )" == "zenbook" ]; then
    ideapath=$( find ~ -maxdepth 1 -type d  \
    -iname ".Idea*" | head -n1 )
    ideapath=${ideapath}/config
else
    ideapath=$( find ~/Library/Preferences -type d -maxdepth 1 \
    -iname "Idea*" | head -n1 )
fi
echo -e "--- installing to: $ideapath\n"

# Link global exception configurations
cd _
for file in *; do
    ../../mklinks.sh $file ${ideapath}
echo; done
cd ..

# Link host-independent settings
for folder in codestyles inspection options; do
    mkdir -vp ${ideapath}/$folder
    for file in $folder/*; do
        ../mklinks.sh $file ${ideapath}/
    echo; done
done

# Link host-dependent settings
mkdir -vp ${ideapath}/keymaps
src="keymaps/keymap-basti.xml"
[ "$( hostname )" == "zenbook" ] && src="keymaps/keymap-basti-zenbook.xml"
rm -vf ${ideapath}/keymaps/keymap-basti.xml
ln -vs $( realpath $src ) ${ideapath}/keymaps/keymap-basti.xml
