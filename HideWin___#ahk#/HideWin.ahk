#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

wid := 0

#h::
WinGet, wid, ID, A
WinHide, ahk_id %wid%
return

#s::
if wid != 0
{
    WinShow, ahk_id %wid%
    WinActivate, ahk_id %wid%
}
return