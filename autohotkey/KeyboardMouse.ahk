; ==============================================================================
; KEYBOARD MOUSE
;
; ESC + Arrows        - Move mouse fast
; ESC + Alt + Arrows  - Move mouse precise
; ESC + Enter         - Perform a left click 
; ESC + Backspace     - Place mouse pointer in center of active window
;
; GLOBALS TO DEFINE:
;     - None
; ==============================================================================

#Include %A_ScriptDir%\Commons.ahk

~Esc & Down::HandleKeyboardMouseAction( "Down" ) 
~Esc & Up::HandleKeyboardMouseAction( "Up" )
~Esc & Left::HandleKeyboardMouseAction( "Left" )
~Esc & Right::HandleKeyboardMouseAction( "Right" )
~Esc & Enter::MouseTask( "Click" )
~Esc & Backspace::MouseTask( "WindowReset" )

HandleKeyboardMouseAction( Key ) 
{
	; This in-between method is necessary to overcome the 
	; key-repeat delay mechanism of windows
	While GetKeyState(Key,"p")  
	{ 
		MouseTask( )
	}
}

MouseTask( Action="Move", Stepsize=40 )
{	
	; If mouse clicked 
	if ( Action == "Click" )
	{
		MouseClick, left
		Return
	}
	; If reset to window requested 
	if ( Action == "WindowReset" )
	{
		WinGetPos, WinX, WinY, WinW, WinH, A
		PosX := WinX + ( WinW / 2 )
		PosY := WinY + ( WinH / 2 )
		CoordMode, Mouse, Screen
		MouseMove, PosX, PosY, 0
		CoordMode, Mouse, Relative
		Return
	}
	; If Mouse moved 
	GetKeyState, DownState, Down, P
	GetKeyState, UpState, Up, P
	GetKeyState, LeftState, Left, P
	GetKeyState, RightState, Right, P
	GetKeyState, FastMoveState, Alt, P

	X := Y := 0	
	if ( DownState == "D" ) {
		Y=%Stepsize%
	} else if ( UpState == "D" ) {
		Y=-%Stepsize%
	}
	if ( LeftState == "D" ) { 
		X=-%Stepsize%
	} else if ( RightState == "D" ) {
		X=%Stepsize%
	}
	
	; On diagonal movement only move a third of the step size
	; This seems to be more natural 
	if ( X != 0 ) && ( Y != 0) {
		X := X / 1.4
		Y := Y / 1.4
	}
	; Activate fine movement mode (10% of step size) 
	if ( FastMoveState == "D" ) {
		X := X * 0.15
		Y := Y * 0.15
	} 

	; Perform the actual move 
	MouseMove, X, Y, 0, R
	Return 

}