#include-once

#include <Constants.au3>
#include <Json.au3>
#include <HTTP.au3>

; ---------------------------------------
; Json-RPC Client
;
; Dependency:
;   Json.au3 (2015.01.08) by Ward
;   HTTP.au3 (2017.05.28) by @Jefrey, Repo: http://github.com/jesobreira/HTTP.au3
; ---------------------------------------
Global $__jrcRpcProxy = ''

; Return Value
;   Success: 1
;   Failure: 0 if $proxy is not a string or empty
Func jrcSetProxy($proxy)
    If IsString($proxy) And ($proxy <> '') Then
        $__jrcRpcProxy = $proxy
        Return 1
    Else
        Return 0
    EndIf
EndFunc ;==> jrcSetProxy

; Return Value
;   Success: JSON object (of "Json.au3") of the response
;   Failure: Null, and sets the @error flag to 1
Func jrcCall($method, $params)
    Local $req = '{"jsonrpc":"2.0","id":"jrc"'
    $req &= ',"method":"' & $method & '"'
    If $params Then $req &= ',"params":"' & $params & '"'
    $req &= '}'
    Local $resp = _HTTP_Post($__jrcRpcProxy, $req)
    ;MyLog($resp)
    Return Json_Decode($resp)
EndFunc ;==> jrcCall

;---------------------------------------------------------------------------

Func MyLog($msg)
    ;MsgBox($MB_SYSTEMMODAL, "Message", $msg)
    ConsoleWrite($msg & @CRLF)
EndFunc ;==> MyLog

Func test()
    jrcSetProxy('http://localhost:6800/jsonrpc')
    Local $resp = jrcCall('system.listMethods', '')

    if Json_Get($resp, '.error.code') Then
        MyLog('----------- ERROR -------------')
        MyLog(Json_Get($resp, '.error.code'))
        MyLog(Json_Get($resp, '.error.message'))
    Else
        MyLog('----------- SUCC -------------')
        Local $re = Json_Get($resp, '.result')
        For $m In $re
            MyLog($m)
        Next
    EndIf
EndFunc ;==> test

;test()