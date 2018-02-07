#!/bin/bash
cd "$( dirname "$( readlink -f "$0" )" )"
tf=$( mktemp )
{
echo base_color=linux:
cat mc-colors-test.sh | grep -v -e "#" -e "^mc " | sed -e "s/:.*$/:/g"
} > $tf
new_colors=$( cat $tf | tr -d "\n" )
rm -f $tf
sed -i "s/^base_color=linux:.*/$new_colors/" ini

