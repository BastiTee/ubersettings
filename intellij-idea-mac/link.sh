cd $( dirname $( realpath $0 ))
ideapath=$( find ~/Library/Preferences -type d -maxdepth 1 -iname "Idea*" |\
head -n1 )
echo -e "--- installing to: $ideapath\n"

# mkdir -vp ${ideapath}/config
# find ${ideapath}/config -type l | xargs rm -v
# echo
# cd _
# for file in *; do
#     ../../mklinks.sh $file ${ideapath}/config
# echo; done
# cd ..

 #keymaps options
for folder in codestyles inspection keymaps options; do
    mkdir -vp ${ideapath}/$folder
    for file in $folder/*; do
        ../mklinks.sh $file ${ideapath}/
    echo; done
done
