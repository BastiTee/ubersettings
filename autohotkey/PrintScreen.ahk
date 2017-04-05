; ==============================================================================
; SCREENSHOT-2-FILE
; 
; GLOBALS TO DEFINE:
;     - irfan_bin - Path to irfan view executable 
;     - screenshot_folder - Target folder for screenshots 
; ==============================================================================

#Include %A_ScriptDir%\Commons.ahk
BreakOnEmptyVariable( irfan_bin, "irfan_bin", A_ScriptName )
BreakOnEmptyVariable( screenshot_folder, "screenshot_folder", A_ScriptName )

#PrintScreen::ScreenshotToFile( "Screen" )
#!PrintScreen::ScreenshotToFile( "Window" )

ScreenshotToFile( Mode="Screen" ) {
	prefix := ""
	if ( Mode = "Screen" ) {
		Send,{PrintScreen}
		prefix := "ScreenShot_" 
	} else {
		Send,!{PrintScreen}
		prefix := "WindowShot_"
	}
	Sleep, 500
	FileName := screenshot_folder prefix A_Now ".jpg"
	Run, %irfan_bin% /clippaste /convert=%FileName%,,HIDE
	DebugTray( FileName " created")
}
