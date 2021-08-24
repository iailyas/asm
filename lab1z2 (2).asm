.486
.model flat, stdcall
option casemap :none 
include windows.inc
include kernel32.inc
includelib kernel32.lib

.data
	messageSt1 db "{"  
	messageSt2 db "}"
	inputBuffer db 100 dup (" ")

.data?
	inputHandle dd ?
	outputHandle dd ?
	numberOfChars dd ?

.code
entryPoint:
	
	push STD_INPUT_HANDLE     
	call GetStdHandle         
	mov inputHandle, EAX      
	
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov outputHandle, EAX  
	 
        push NULL
	push offset numberOfChars
	push 100
	push offset inputBuffer
	push inputHandle
	call ReadConsole   
	
	mov EDX, offset inputBuffer      ;���������� ������ ����������� ������
	mov EAX, numberOfChars           ;���������� ����� ����������� ������
	mov byte ptr [ EDX + EAX - 2], 0 ;������ ������������ 0 � ����� ������, ��� ���� ��������� 2 �� ������ ���������� ��� 
					 ;������������ �������� � ������ 13 � 10 � ����� ������, ���������� � ����� ����� ������� Enter
	
	push NULL                 
	push offset numberOfChars 
	push 1                   
	push offset messageSt1
	push outputHandle         
	call WriteConsole    
	
      	push offset inputBuffer  	;����� ������
      	call lstrlen                    ;����� ������
	
	push NULL                 
	push offset numberOfChars 
	push EAX                 
	push offset inputBuffer
	push outputHandle         
	call WriteConsole      
	
	push NULL                 
	push offset numberOfChars 
	push 1                   
	push offset messageSt2
	push outputHandle         
	call WriteConsole

	push NULL
	push offset numberOfChars
	push 1
	push offset inputBuffer
	push inputHandle
	call ReadConsole

	push 0
	call ExitProcess

end entryPoint