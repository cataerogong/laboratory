#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Change2CUI=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Global $ipc_prompt = StringLower('ipc-py>')
Global $ipc_prompt_len = StringLen($ipc_prompt)

Func IpcInit($cmdline)
    Local $pid = Run($cmdline, '', Default, $STDIN_CHILD + $STDOUT_CHILD)
    ConsoleWrite($pid & @CRLF)
    IpcRead($pid)
    Return $pid
EndFunc ;==> IpcInit

Func IpcClose($pid)
    IpcWrite($pid, 'exit')
    StdinWrite($pid)
    StdioClose($pid)
    ProcessClose($pid)
EndFunc ;==> IpcClose

Func IpcCall($pid, $cmd)
    IpcWrite($pid, $cmd)
    Return IpcRead($pid)
EndFunc ;==> IpcCall

Func IpcWrite($pid, $msg)
    ConsoleWrite('>>>>>>>>' & @CRLF & $msg & @CRLF)
    StdinWrite($pid, $msg & @CRLF)
EndFunc ;==> IpcWrite

Func IpcRead($pid)
    Local $o = ''
    While 1
        $o &= StdoutRead($pid)
        If @error Then
            ExitLoop
        EndIf
        If StringLower(StringRight($o, $ipc_prompt_len)) == $ipc_prompt Then
            $o = StringLeft($o, StringLen($o) - $ipc_prompt_len)
            ExitLoop
        EndIf
    WEnd
    ConsoleWrite('<<<<<<<<' & @CRLF & $o & @CRLF)
    Return $o
EndFunc ;==> IpcRead

;-------- TEST ---------
Func Ipc()
    Local $myPID = _WinAPI_GetCurrentProcessID()
    ConsoleWrite('My PID: ' & $myPID & @CRLF)
    Local $iPID = IpcInit('ipc-py.exe --ppid=' & $myPID)

    Local $resp = ''

    $resp = IpcCall($iPID, 'help me')
    $resp = IpcCall($iPID, 'hello ROME')

    IpcClose($iPID)
EndFunc ;==> Ipc

Ipc()
ConsoleWrite('<--- end --->' & @CRLF)
