; ==============================================================================
; HOTKEY FUNCTIONS 
;
; GLOBALS TO DEFINE:
;     - freecom_bin - Path to free commander executable
; ==============================================================================

#Include %A_ScriptDir%\Commons.ahk
BreakOnEmptyVariable( freecom_bin, "freecom_bin", A_ScriptName )

; Activating programs 
#e::ActivateProgramWindow( freecom_bin )
#^e::ActivateProgramWindow( "explorer" )
#Space::return ;deactives locale switching in windows 10 

; Writing horizontal rules 
^!-::SendInput, --------------------------------------------------------------------------------
^!=::SendInput, ================================================================================
