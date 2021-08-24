.486
.model flat, stdcall
option casemap :none ; чувствительность к регистру букв в идентификаторах
include windows.inc
include kernel32.inc
include masm32.inc

includelib kernel32.lib
includelib masm32.lib

.data   
	condition db "Enter the numbers A and B", 13, 10, 0
	
	tt dd 8,0
	
.data?  
	;BUFFER
	buffer db 25 dup (?)
	buf dd ?
	;
	numberOfCharsWritten dd ?
     	;data
     	a dd ?
     	apow dd ?
     	
     	b dd ?
     	divb dd ?
     	del dd ?
     	
     	cc dd ?
     	
     	l dd ?
     	r dd ?
     	
     	res dd ?
     	
     	
	cin dd ?
	cout dd ?
.code
entryPoint:
	push STD_OUTPUT_HANDLE    ; передача параметра в функцию. Описана в windows.inc (нектр число)
	call GetStdHandle           ; вызов системной функции. Запрашивает дескриптор потока вывода	            
	mov cout, EAX        ; сохранение результата функции. Из EAX в cout
	
    	push STD_INPUT_HANDLE
    	call GetStdHandle
   	mov cin, EAX 
;------------------------------------------------------------------------------------------------------
	;Output condition
	push offset condition
	call lstrlen
	
	push NULL                 
    	push NULL
    	push EAX      
    	push offset condition 
    	push cout           
    	call WriteConsole
    	;Input firstnum
     	push NULL
    	push offset numberOfCharsWritten 
    	push 25
    	push offset buffer 
    	push cin 
    	call ReadConsole
    	
    	mov ESI, numberOfCharsWritten
    	mov EBX, offset buffer
    	mov byte ptr [ EBX + ESI - 2 ], 0
    	
    	push offset buffer
    	call atodw
    	mov a, EAX
    	;Input secondnum	
     	push NULL
    	push offset numberOfCharsWritten 
    	push 32
    	push offset buffer 
    	push cin 
    	call ReadConsole     
    	
     	mov ESI, numberOfCharsWritten
    	mov EBX, offset buffer
    	mov byte ptr [ EBX + ESI - 2 ], 0
    	
    	push offset buffer
    	call atodw
    	mov b, EAX
    	;Input secondnum	
     	push NULL
    	push offset numberOfCharsWritten 
    	push 32
    	push offset buffer 
    	push cin 
    	call ReadConsole     
    	
     	mov ESI, numberOfCharsWritten
    	mov EBX, offset buffer
    	mov byte ptr [ EBX + ESI - 2 ], 0
    	
    	push offset buffer
    	call atodw
    	mov cc, EAX
;------------------------------------------------------------------------------------------------------
        ;b/8
        mov EAX, b 
        mov EDX, 0 ; obnulenie EDX
        div tt ; division by 8
        mov divb, EAX
                        
        cdq ; expanded    
            
        ;start pow      
        mov EAX, a
        mul a  ;2    
        mul EAX ;4
        mov buf, EAX
        mul EAX	  ;8
	mul buf ;12
	mul a
	;end pow
	add EAX, divb ; a^7 + b/8
	
	adc EDX, 0 ; учитываем бит переноса
	;
        div cc 
                                          
        add EAX, EDX
        mov res, EAX
;------------------------------------------------------------------------------------------------------           
        push offset buffer
        push res
        call dwtoa 
        
        push offset buffer
        call lstrlen
        
        push NULL                 
    	push numberOfCharsWritten 
    	push EAX
    	push offset buffer
    	push cout           
    	call WriteConsole

;------------------------------------------------------------------------------------------------------    		                                                                                       
	push 0 ; аналогично плюсам return 0
	call ExitProcess ; Для корректного завершения программы

end entryPoint
