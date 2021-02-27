#!/bin/bash

cd $( cd "$( dirname "$0" )"; pwd )

# Lookup configuration folder
ideapath=$( find ~/Library/Application\ Support/JetBrains -type d -maxdepth 1 \
-iname "Idea*" | head -n1 )
echo -e "--- installing to: $ideapath\n"

# Link global exception configurations
cd _
for file in *; do
    ../../mklinks.sh "$file" "${ideapath}"
echo; done
cd ..

# Link host-independent settings
for folder in codestyles inspection options; do
    mkdir -vp "${ideapath}/$folder"
    for file in $folder/*; do
        ../mklinks.sh "$file" "${ideapath}"/
    echo; done
done

# Link host-dependent settings
mkdir -vp "${ideapath}/keymaps"
src="keymaps/keymap-basti.xml"
rm -vf "${ideapath}/keymaps/keymap-basti.xml"
ln -vs $( cd "$( dirname "$src" )"; pwd )/$( basename $src ) \
"${ideapath}/keymaps/keymap-basti.xml"

open "$ideapath"