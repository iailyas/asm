    .486
    .model flat, stdcall
    option casemap :none   ; case sensitive

    include windows.inc
    include kernel32.inc
    include user32.inc
    include masm32.inc
    include gdi32.inc

    includelib kernel32.lib
    includelib user32.lib
    includelib masm32.lib
    includelib gdi32.lib

; #########################################################################

    .code

start:

; Place your code here

    invoke ExitProcess,0

end start
