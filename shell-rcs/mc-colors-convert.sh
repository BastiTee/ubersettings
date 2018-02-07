#!/bin/bash
cd "$( dirname "$( readlink -f "$0" )" )"
{
    echo base_color=linux:
    cat mc-colors-test.sh | grep -v -e "#" -e "^mc " | sed -e "s/:.*$/:/g"
} | tr -d "\n" 
echo
