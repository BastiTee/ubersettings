@ECHO OFF
CD %~dp0
IF "%BBC_SHELLHOME%"=="" (
    ECHO Variable BBC_SHELLHOME is NOT defined. 
    PAUSE
    EXIT
) 
..\mklinks.bat ".gitconfig .inputrc .minttyrc .screenrc .vimrc" %BBC_SHELLHOME%
