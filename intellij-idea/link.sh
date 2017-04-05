cd $( dirname $( readlink -f $0 ))
ideapath=$( find ~ -maxdepth 1 -iname ".Idea*" | head -n1 )
../mklinks.sh colortheme-basti-linux.icls ${ideapath}/config/colors
../mklinks.sh keymap-basti.xml ${ideapath}/config/keymaps
../mklinks.sh codestyle-basti.xml ${ideapath}/config/codestyles
../mklinks.sh inspection-basti.xml ${ideapath}/config/inspection
../mklinks.sh "web-browsers.xml editor.xml ide.general.xml keyboard.xml ui.lnf.xml code.style.schemes.xml colors.scheme.xml keymap.xml" ${ideapath}/config/options
