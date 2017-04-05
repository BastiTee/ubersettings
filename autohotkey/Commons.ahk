; ==============================================================================
; COMMON FUNCTIONS 
;
; GLOBALS TO DEFINE:
;     - None
; ==============================================================================

#NoEnv
#SingleInstance Force
;#NoTrayIcon
;#InstallKeybdHook
;#Persistent
;KeyHistory
; Retrieve current machine and user name 
global local_name := A_ComputerName "-" A_UserName

ActivateProgramWindow(Target, WinTitle = "", RunIfNotRunning = True )
{	
	; Get the filename without a path
	SplitPath, Target, TargetNameOnly
	if (!TargetNameOnly) {
		TargetNameOnly = Target
	}
	Process, Exist, %TargetNameOnly%

	;DebugBox( TargetNameOnly " -- " Target)

	; If the program is already running, run it 
	if (ErrorLevel > 0) {
		PID = %ErrorLevel%
		WinWait, ahk_pid %PID%, , 3
		WinActivate, ahk_pid %PID%
		Return
	; If the program does not run, run it if desired 
	} else if (RunIfNotRunning) {
		Run, %Target%, , , PID
		Return
	}
	; If nothing worked so far, try to activate the window by its title 
	If WinTitle <> 
	{
		SetTitleMatchMode, 2
		WinWait, %WinTitle%, , 3
		WinActivate, %WinTitle%
		Return
	}
}

ListFiles( Directory, Pattern, FirstOnly=False, FullPath=True  )
{
	files =
	Loop, Files, %Directory%\%Pattern%, FR
	{
		if ( FirstOnly ) {
			if ( FullPath ) {
				return %A_LoopFileFullPath%
			} else {
				return %A_LoopFileName%
			}
		} else {
			; TODO Currently the files variable will start with a line break 
			if ( FullPath ) {
				files = %files%`n%A_LoopFileFullPath%
			} else {
				files = %files%`n%A_LoopFileName%
			}		
		}
	}
	return files 
}

BreakOnEmptyVariable( Variable, VariableLabel, ScriptName )
{
    if (Variable = "") {
    MsgBox Global variable '%VariableLabel%' in %ScriptName% not set. Will exit the script.
    ExitApp
    }
}

DebugTray( Message ) {
	TrayTip, , %Message%
	SetTimer, TrayTipClear, 3000
}
	
TrayTipClear() {
	SetTimer, TrayTipClear, off
	TrayTip
}

DebugBox( Message ) {
	MsgBox 0x1000, , %Message%
}

DebugPing( ) {
	DebugBox( "PING" )
}
