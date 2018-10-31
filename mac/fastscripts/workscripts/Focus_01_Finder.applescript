tell application "Finder"
	activate
end tell
tell application "System Events" to tell process "Finder"
	keystroke "n" using command down
end tell
