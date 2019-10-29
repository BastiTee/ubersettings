#!/bin/sh
mc --colors \
`# File display `\
normal=white,default:\
selected=red,gray:\
marked=black,yellow:\
markselect=red,yellow:\
`# File types `\
directory=white,default:\
executable=white,default:\
link=white,default:\
device=white,default:\
special=white,default:\
errors=white,default:\
`# Dialog boxes `\
dnormal=white,black:\
dfocus=yellow,gray:\
dhotnormal=yellow,black:\
dhotfocus=yellow,gray:\
errdhotnormal=red,blue:\
errdhotfocus=red,blue:\
`# User menu `\
menu=black,cyan:\
menunormal=black,cyan:\
menuinactive=black,cyan:\
menuhot=black,blue:\
menusel=black,blue:\
menuhotsel=yellow,blue:\
`# Help subsystem `\
helpnormal=white,black:\
helpitalic=yellow,black:\
helpbold=red,black:\
helplink=cyan,black:\
helpslink=cyan,black:\
`# Viewer settings `\
viewnormal=white,default:\
viewbold=red,default:\
viewunderline=blue,default:\
viewselected=yellow,gray:\
`# Popup menu `\
pmenunormal=black,cyan:\
pmenusel=black,blue:\
pmenutitle=black,blue:\
`# Global settings `\
reverse=cyan,default:\
gauge=green,default:\
input=white,default:\
header=black,cyan:\
bbarhotkey=black,blue:\
bbarbutton=black,cyan:\
statusbar=black,cyan
