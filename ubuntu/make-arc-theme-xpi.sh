#!/bin/bash
# A script to create an Arc firefox theme with slightly adapted
# colors. Base project: https://github.com/horst3180/arc-firefox-theme
# -----

git clone https://github.com/horst3180/arc-firefox-theme
cd arc-firefox-theme

function replace {
    grep -ilr --exclude-dir=.git --exclude=*.xpi --exclude=*.sh $1 |\
    while read file; do
        sed -i -e "s/$1/$2/gI" $file
    done
}

replace 2F343F 292929
replace 353945 313434
replace 383C4A 393F3F
replace 404552 424040

./autogen.sh --disable-light --disable-darker
make mkxpi
