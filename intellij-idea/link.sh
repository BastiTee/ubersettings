cd $( dirname $( readlink -f $0 ))
ideapath=$( find ~ -maxdepth 1 -iname ".Idea*" | head -n1 )
echo -e "--- installing to: $ideapath\n"
mkdir -vp ${ideapath}/config
find ${ideapath}/config -type l | xargs rm -v 
echo
cd _
for file in *; do
    ../../mklinks.sh $file ${ideapath}/config
echo; done
cd ..

for folder in codestyles colors inspection keymaps options; do
    mkdir -vp ${ideapath}/config/$folder
    for file in $folder/*; do
        ../mklinks.sh $file ${ideapath}/config
    echo; done
done
