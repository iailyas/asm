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

    push MB_OK + MB_ICONINFORMATION ; ������ � �����������
    push offset szTitle    ; ������ ��������� ����
    push offset szMessage  ; ����� ���������� ���������
    push 0                 ; ��������� �� ������������ ����
    call MessageBox

    push 0                 ; ��� ���������� ���������
    call ExitProcess

end start
