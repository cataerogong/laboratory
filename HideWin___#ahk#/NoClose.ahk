#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On

; AutoHotkey v1.1.32
author := "cataerogong"
ver := "1.0.0"

ids=
OnExit,EXIT
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,About, ABOUT
Menu,Tray,Add,Exit, EXIT
Menu,Tray,Tip, NoClose

^!x::
{
	WinGet,id,ID,A
	WinGetTitle,title,ahk_id %id%
	WinGetClass,class,ahk_id %id%
	IfInString,ids,%id%`,
	{
		ENABLE(id)
		StringReplace,ids,ids,%id%`,,
		Return
	}
	DISABLE(id)
	ids=%ids%%id%`,
	return
}

DISABLE(id) ;By RealityRipple at http://www.xtremevbtalk.com/archive/index.php/t-258725.html
{
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",0)
  DllCall("user32\DeleteMenu","UInt",menu,"UInt",0xF060,"UInt",0x0)
  WinGetPos,x,y,w,h,ahk_id %id%
  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h-1
  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h+1
}


ENABLE(id) ;By Mosaic1 at http://www.xtremevbtalk.com/archive/index.php/t-258725.html
{
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",1)
  DllCall("user32\DrawMenuBar","UInt",id)
}

ABOUT:
{
	MsgBox, , , Press <Ctrl>+<Alt>+<x> to disable/enable the close button [X]
    return
}

EXIT:
{
	WinGet,id_,List,,,Program Manager
	Loop,%id_%
	{
	  id:=id_%A_Index%
	  IfInString,ids,%id%`,
	  {
	    ENABLE(id)
	    StringReplace,ids,ids,%id%`,,
	  }
	}
    ExitApp
}