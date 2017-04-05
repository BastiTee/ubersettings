#!/bin/bash
hf=$( echo ~ )
folders="Desktop Documents Downloads Music Pictures Public Templates Videos"
cfgfile="$hf/.config/user-dirs.dirs"
fname="ubuntu"
targetfolder="$hf/$fname"

[ -d $targetfolder ] && { echo "Target folder exists!"; exit 1; }
[ ! -e $cfgfile ] && { echo "Cannot find cfg file $cfgfile"; exit 1; }
mkdir -p $targetfolder
cp $cfgfile ${cfgfile}.bak
for folder in $folders
do
	fabs=${hf}/$folder
	if [ -d $fabs ]
	then
		echo "fixing folder $fabs ..."
		sed -i -e "s/\$HOME\/$folder/\$HOME\/$fname\/$folder/" $cfgfile
		mv -v $fabs $targetfolder	
	fi
done
xdg-user-dirs-update

