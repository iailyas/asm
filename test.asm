.486
.model flat, stdcall
option casemap :none

include windows.inc
include kernel32.inc
include user32.inc
include masm32.inc
includelib kernel32.lib
includelib user32.lib
includelib masm32.lib


.data


.data?

result1 dd ?

inputHandle dd ?
outputHandle dd ?

numberOfCharsBuffer dd ?


inputBuffer dd ?
outputBuffer dd ?





.code
entryPoint:

; ????????? ??????? ?????/??????

push STD_INPUT_HANDLE
call GetStdHandle
mov inputHandle, EAX

push STD_OUTPUT_HANDLE
call GetStdHandle
mov outputHandle, EAX

;--------------------------------------------------------
mov EAX,-36
mov EBX,39
sub EAX,EBX

push offset result1
push EAX
call dwtoa

push offset result1
call lstrlen


push NULL
push offset numberOfCharsBuffer
push EAX
push offset result1
push outputHandle
call WriteConsole

push 50000
call Sleep

push 0
call ExitProcess

end entryPoint