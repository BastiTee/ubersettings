#!/bin/bash
# Manjaro Linux Bootstrapping

cd ~

# Update system
sudo pacman -Syu --noconfirm

# Install basic tools
sudo pacman -Syu --noconfirm --needed git screen vim  curl unzip mc htop psmisc \
elinks lynx net-tools owncloud-client base-devel yaourt

# SSH keygen
[ ! -e ~/.ssh/id_rsa ] && ssh-keygen
[ ! -d ~/github/bastis-bash-commons ] && {
	cat ~/.ssh/id_rsa.pub
	read -p "Copy SSH keys to github now!" -n 1 -r
	echo ""
}

# Install basic shell environment
mkdir -p github
cd github
for proj in ubersettings bastis-bash-commons
do
	[ ! -d $proj ] && git clone git@github.com:BastiTee/${proj}.git
done
echo "source /home/st/github/bastis-bash-commons/bbc-bash-defaults" > ~/.bashrc
/home/st/github/ubersettings/shell-rcs/link.sh

# Relocate Gnome folders
[ -d ~/Pictures ] && {
	script="/home/st/github/ubersettings/ubuntu/relocate-ubuntu-home-folders.sh"
	chmod a+x $script
	$script
}
rm -f ~/Readme

# Install arch user repository tools
sudo yaourt -Syu --noconfirm --needed atom

