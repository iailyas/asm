    .486
    .model flat, stdcall
    option casemap :none   ; case sensitive

    include windows.inc
    include user32.inc
    include kernel32.inc

    includelib user32.lib
    includelib kernel32.lib

; #########################################################################

    .data
szTitle    db "Message",0
szMessage  db "Hello, World!",0

    .code

start:            

    push MB_OK + MB_ICONINFORMATION ; кнопка и пиктограмма
    push offset szTitle    ; строка заголовок окна
    push offset szMessage  ; текст выводимого сообщения
    push 0                 ; указатель на родительское окно
    call MessageBox

    push 0                 ; код завершения программы
    call ExitProcess

end start
