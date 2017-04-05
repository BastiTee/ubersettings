; ==============================================================================
; UBERLAUNCHER
;
; GLOBALS TO DEFINE:
;     - chrome_bin - Path to chrome executable 
;     - notebook_folder - Path to local notebook with txt files 
;     - notepad_bin - Path to notepad++ executable 
;     - mintty_bin - Path to mintty executable
;     - bugzilla_url - URL to bugzilla instance
; ==============================================================================

#Include %A_ScriptDir%\Commons.ahk
BreakOnEmptyVariable( chrome_bin, "chrome_bin", A_ScriptName )
BreakOnEmptyVariable( notebook_folder, "notebook_folder", A_ScriptName )
BreakOnEmptyVariable( notepad_bin, "notepad_bin", A_ScriptName )
BreakOnEmptyVariable( mintty_bin, "mintty_bin", A_ScriptName )
BreakOnEmptyVariable( cmdow_bin, "cmdow_bin", A_ScriptName )
BreakOnEmptyVariable( bugzilla_url, "bugzilla_url", A_ScriptName )

; ==============================================================================
; HOTKEYS 
; ==============================================================================

#Tab::UberlauncherGui()
#w::UberlauncherGui()

; ==============================================================================
; COMMAND DEFINITION
; ==============================================================================

IsLauncherCommand( UserInput )
{
	IsCommand := RegExMatch( UserInput, "^(![ ]*|\?[ ]*|#[ ]*|\+[ ]*|-bug[ ]*|-bob|-bos|-bmb|-bms|-bot|-b1)")
	if ( IsCommand = 1 ) {
		return true
	} else {
		return false
	}
}

EvaluateCommand( Command, RunCommand=True ) 
{
	if ( RegExMatch( Command, "^\?[ ]*" ) = 1 ) {
		RunCommandSearch( Command, RunCommand )
		Return "?<Term> - Search for term in Google."
	} else if ( RegExMatch( Command, "^\+[ ]*" ) = 1 ) {
		RunCommandOpenNotes( Command, RunCommand )
		Return "+<Notes> - Open subpage of notebook."
	} else if ( RegExMatch( Command, "^#[ ]*" ) = 1 ) {
		RunCommandLookupBug( Command, RunCommand )
		Return "#<BugID> - Open Bugzilla bug with given id."
	} else if ( RegExMatch( Command, "^-bob" ) = 1 ) {
		RunCommandBabunOpenBig( Command, RunCommand )
		Return "-bob - Babun, Open four big Babun windows."
	} else if ( RegExMatch( Command, "^-bos" ) = 1 ) {
		RunCommandBabunOpenSmall( Command, RunCommand )
		Return "-bos - Babun, Open four small Babun windows."
	} else if ( RegExMatch( Command, "^-bmb" ) = 1 ) {
		RunCommandBabunMoveBig( Command, RunCommand )
		Return "-bmb - Babun, Recalibrate to big Babun windows."
	} else if ( RegExMatch( Command, "^-bms" ) = 1 ) {
		RunCommandBabunMoveSmall( Command, RunCommand )
		Return "-bms - Babun, Recalibrate to small Babun windows."
	} else if ( RegExMatch( Command, "^-bot" ) = 1 ) {
		RunCommandBabunOnTop( Command, RunCommand )
		Return "-bot - Babun, Put Babun windows on top."
	} else if ( RegExMatch( Command, "^-b1" ) = 1 ) {
		RunCommandBabunOpenSingle( Command, RunCommand )
		Return "-b1 - Babun, Open a single shell."
	} 
}

RunCommandSearch( Command, RunCommand ) {
	Arguments := RegExReplace( Command, "^\?[ ]*", "")
	if ( RunCommand ) {
		Arguments := RegExReplace( Arguments, "[ ]+", "+") 
		address = "https://www.google.de/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q="
		ActivateProgramWindow(chrome_bin " /new-tab " address Arguments)
	}
}

RunCommandOpenNotes( Command, RunCommand ) {
	Arguments := RegExReplace( Command, "^\+[ ]*", "")
	if ( RunCommand ) {
		FilePattern := "*" Arguments "*.md"
		NotebookFile := ListFiles( notebook_folder, FilePattern, True, True  ) 
		if ( NotebookFile != "" ) {
			Run %comspec% /c ""%notepad_bin%" %NotebookFile%",,HIDE
		} else {
			DebugTray( "No notebook page with pattern '" Arguments "' found.")
		}
	}
}

RunCommandLookupBug( Command, RunCommand ) {
	Arguments := RegExReplace( Command, "^#[ ]*", "")
	if ( RunCommand ) {
		address = "%bugzilla_url%/show_bug.cgi?id="
		ActivateProgramWindow( chrome_bin " /new-tab " address Arguments)
	}
}

RunCommandBabunOpenBig( Command, RunCommand ) {
	if ( RunCommand ) {
		code =
			(join&
			start %mintty_bin% -s 118,27 -p 1920,0 -t BABUN-01 -
			start %mintty_bin% -s 118,27 -p 2880,0 -t BABUN-02 -
			start %mintty_bin% -s 118,27 -p 1920,540 -t BABUN-03 -
			start %mintty_bin% -s 118,27 -p 2880,540 -t BABUN-04 -
			)
		run %comspec% /Q /C %code%,,HIDE
	}
}

RunCommandBabunOpenSmall( Command, RunCommand ) {
	if ( RunCommand ) {
		code =
			(join&
			start %mintty_bin% -s 83,19 -p 0,0 -t BABUN-01 -
			start %mintty_bin% -s 83,19 -p 683,0 -t BABUN-02 -
			start %mintty_bin% -s 83,19 -p 0,370 -t BABUN-03 -
			start %mintty_bin% -s 83,19 -p 683,370 -t BABUN-04 -
			)
		run %comspec% /Q /C %code%,,HIDE
	}
}

RunCommandBabunMoveBig( Command, RunCommand ) {
	if ( RunCommand ) {
		code =
			(join&
			%cmdow_bin% BABUN-01 /mov 1920 0 /siz 954 531
			%cmdow_bin% BABUN-02 /mov 2880 0 /siz 954 531 
			%cmdow_bin% BABUN-03 /mov 1920 540 /siz 954 531
			%cmdow_bin% BABUN-04 /mov 2880 540 /siz 954 531
			)
		run %comspec% /Q /C %code%,,HIDE
	}
}

RunCommandBabunMoveSmall( Command, RunCommand ) {
	if ( RunCommand ) {
		code =
			(join&
			%cmdow_bin% BABUN-01 /mov 0 0 /siz 682 362
			%cmdow_bin% BABUN-02 /mov 683 0 /siz 682 362 
			%cmdow_bin% BABUN-03 /mov 0 370 /siz 682 362
			%cmdow_bin% BABUN-04 /mov 683 370 /siz 682 362
			)
		run %comspec% /Q /C %code%,,HIDE
	}
}

RunCommandBabunOnTop( Command, RunCommand ) {
	if ( RunCommand ) {
		code =
			(join&
			%cmdow_bin% BABUN-01 /act
			%cmdow_bin% BABUN-02 /act
			%cmdow_bin% BABUN-03 /act
			%cmdow_bin% BABUN-04 /act
			)
		run %comspec% /Q /C %code%,,HIDE
	}
}

RunCommandBabunOpenSingle( Command, RunCommand ) {
	if ( RunCommand ) {
		code =
			(join&
			start %mintty_bin% -s 118,27 -p 1920,0 -t BABUN-01 -
			)
		run %comspec% /Q /C %code%,,HIDE
	}
}


; ==============================================================================
; GUI ELEMENTS AND CONTROLS 
; ==============================================================================

ConvertLauncherInput( UserInput ) 
{
	; No input is bad
	if (!UserInput) {
		return ""
	}
	; Only whitespaces as input is also bad 
	OnlyWhitespaces := RegExMatch(UserInput, "^[\s]*$")
	if ( OnlyWhitespaces > 0 ) {
		return ""
	}
	; Trim input 
	UserInput := RegExReplace( UserInput, "^[\s]+", "")
	UserInput := RegExReplace( UserInput, "[\s]+$", "")
	; Check if a command was invoked 
	if ( IsLauncherCommand( UserInput ) ) {
		return UserInput
	}
	; Replace whitespaces with arbitrary numbers of whitespaces 
	UserInput := RegExReplace( UserInput, "[\s]+", "[\s]+")
	; Allow arbitrary characters between numbers and characters 
	UserInput := RegExReplace(UserInput, "([0-9])([^0-9])", "$1.*$2" ) 
	UserInput := RegExReplace(UserInput, "([^0-9])([0-9])", "$1.*$2" ) 
	UserInput := RegExReplace(UserInput, "(\.\*)+", ".*" )
	; Allow * as simplified wildcard 
	UserInput := RegExReplace(UserInput, "\*", ".*" )
	; Construct final pattern 
	Pattern = i).*
	Pattern .= UserInput
	Pattern .= ".*"
	
	;DebugBox( "'" Pattern "'" )
	return Pattern
}

SearchWindowByPattern( Pattern, LimitListLength=False, LimitLength=64 ) 
{
	; No empty patterns 
	if (!Pattern) {
		return ""
	}
	WindowList=
	WindowListDebug=
	Delim=`n
	DetectHiddenWindows, Off
	WinGet, l_array, List
	
	Loop, %l_array%
	{	
		; Get title of window 
		WinGetTitle, winTitleTemp, % "ahk_id " l_array%A_Index%
		if (winTitleTemp) 
		{
			; Get process name of window 
			WinGet, winProcTemp, ProcessName, % "ahk_id " l_array%A_Index%
			
			; Find pattern in title 
			FoundPos := RegExMatch(winTitleTemp, Pattern)
			if (LimitListLength) {
				winTitleTemp := SubStr( winTitleTemp, 1, LimitLength )
			}
			if ( FoundPos > 0 ) {
				if (WindowList) {
					WindowList .= Delim winTitleTemp
				} else 
				{
					WindowList .= winTitleTemp
				}
			}
			; Find pattern in process name  
			FoundPos := RegExMatch(winProcTemp, Pattern)
			if (LimitListLength) {
				winProcTemp := SubStr( winProcTemp, 1, LimitLength )
			}
			if ( FoundPos > 0 ) {
				if (WindowList) {
					WindowList .= Delim winProcTemp
				} else 
				{
					WindowList .= winProcTemp
				}
			}
			
			if (WindowListDebug) {
				WindowListDebug .= Delim winTitleTemp Delim winProcTemp
			} else 
			{
				WindowListDebug .= winTitleTemp Delim winProcTemp
			}
		}

	}
	return WindowList 
}

UberlauncherGui() {
	
	Global UserInput
	Global CurrentWindowList
	
	Gui, Uberlauncher: New
	Gui, Uberlauncher: Color, F3F3F3
	Gui, Uberlauncher: Font, Norm, Consolas
	Gui, Uberlauncher: Add, Edit, r1 vUserInput gDisplayLauncherHits +Lowercase -WantReturn w400
	Gui, Uberlauncher: Add, Edit, +ReadOnly -VScroll +BackgroundTrans r5 vCurrentWindowList w400
	Gui, Uberlauncher: Add, Button, Default h0 w0, Ok
	Gui, Uberlauncher: +LastFound +AlwaysOnTop +ToolWindow
	Gui, Uberlauncher: -Caption
	Gui, Uberlauncher: Show
	
	GuiControl, Uberlauncher:, CurrentPattern
	GuiControl, Uberlauncher:, CurrentWindowList
	
	WinWaitClose, ahk_id %GuiHWND%  ;--waiting for gui to close
	Return 
	
	UberlauncherGuiEscape: 
		Gui, Uberlauncher: Destroy
	Return
	
	UberlauncherButtonOk:
		Gui, Uberlauncher: Submit
		Gui, Uberlauncher: Destroy
		Pattern := ConvertLauncherInput( UserInput ) 
		if ( IsLauncherCommand( Pattern ) ) {
			EvaluateCommand( Pattern )
			Exit
		}
		WindowList := SearchWindowByPattern( Pattern ) 
		
		;Take first window from list and execute 
		WindowToStart := RegExReplace(WindowList, "`n.*", "" )
		if (WindowToStart) {
			ActivateProgramWindow( WindowToStart, WindowToStart, False )
		}
	Return

	DisplayLauncherHits:
		Gui, Uberlauncher: Submit, NoHide
		Pattern := ConvertLauncherInput( UserInput )
		GuiControl, Uberlauncher:, CurrentPattern,%Pattern%

		if ( IsLauncherCommand( Pattern ) ) {
			Gui, Uberlauncher: Font, Bold Underline,Consolas
			GuiControl, Uberlauncher:Font, UserInput
			Description := EvaluateCommand( Pattern, False )
			GuiControl, Uberlauncher:, CurrentWindowList,%Description%
		} else {
			Gui, Uberlauncher: Font, Norm,Consolas
			GuiControl, Uberlauncher:Font, UserInput
			WindowList := SearchWindowByPattern( Pattern, True ) 
			GuiControl, Uberlauncher:, CurrentWindowList,%WindowList%
		}	
	Return
}