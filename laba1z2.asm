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
	
	mov EDX, offset inputBuffer      ;сохранение адреса прочитанной строки
	mov EAX, numberOfChars           ;сохранение длины прочитанной строки
	mov byte ptr [ EDX + EAX - 2], 0 ;запись завершающего 0 в конец строки, при этом вычитание 2 из адреса нелбходимо для 
					 ;отбрасывания символов с кодами 13 и 10 в конце строки, помещаемых в буфер после нажатия Enter
	
	push NULL                 
	push offset numberOfChars 
	push 1                   
	push offset messageSt1
	push outputHandle         
	call WriteConsole    
	
      	push offset inputBuffer  	;адрес строки
      	call lstrlen                    ;длина строки
	
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