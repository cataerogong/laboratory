#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On

; AutoHotkey v1.1.32
author := "cataerogong"
ver := "1.0.0"

arrWins := {}

Gui, Add, Text, , Press <Ctrl>+<Alt>+<a> to hide active window.
Gui, Add, Text, , Hidden Windows:
Gui, Add, ListBox, r5 w400 vLstWins
Gui, Add, Button, gShowAllWindows, Show All Windows
Gui, Show, , % "HideWin v" . ver
return

^!a::
{
    WinGet, w_pid, PID, A
	s_pid := DllCall("GetCurrentProcessId")
	if (w_pid = s_pid)
	{
		MsgBox, , , Can not hide self
        return
    }
    WinGetTitle, w_title, ahk_pid %w_pid%
    arrWins[w_pid] := w_title
    WinHide, ahk_pid %w_pid%
    RefreshList()
    return
}

RefreshList()
{
	global arrWins
    lst := "|"
    for k, v in arrWins
        lst := lst . "[pid=" . k . "] " . v . "|"
    GuiControl, , LstWins, %lst%
    return
}

ShowAllWindows()
{
	global arrWins
    for k, v in arrWins
    {
    	;MsgBox, , , % k . "-" . v
        WinShow, ahk_pid %k%
        Sleep, 100
        WinActivate, ahk_pid %k%
    }
    arrWins := {}
    RefreshList()
    return
}

GuiClose(Hwnd)
{
	ShowAllWindows()
    return 0
}
