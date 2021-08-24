.486
.model flat, stdcall
option casemap :none 
include windows.inc
include kernel32.inc
includelib kernel32.lib 
include masm32.inc
includelib masm32.lib

.data
	  ent db 10 
	  n db 4 
	  string_1 db 10 dup (" Vvedite b"), 0
	  string_2 db 10 dup (" Vvedite a"), 0
	  string_3 db 10 dup (" Vvedite c"), 0  
	  string_4 db 10 dup (" b^2-4*a*c"), 0

.data?  
	a db ?
	b db ?     
	d db ?  
	raz db ?
	pr_1 db ?
	pr_2 db ?
	del db ? 
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
	push 10
	push offset string_1
	push outputHandle
	call WriteConsole   
	
	push NULL
	push offset numberOfChars
	push 1
	push offset ent
	push outputHandle
	call WriteConsole      
	 
        push NULL
	push offset numberOfChars
	push 100
	push offset b
	push inputHandle
	call ReadConsole       
	
       	mov EDX, offset b	         ;сохранение адреса прочитанной строки
       	mov EAX, numberOfChars           ;сохранение длины прочитанной строки
       	mov byte ptr [ EDX + EAX - 2], 0 ;запись завершающего 0 в конец строки, при этом вычитание 2 из адреса необходимо для 
					 ;отбрасывания символов с кодами 13 и 10 в конце строки, помещаемых в буфер после нажатия Enter
       	push offset b
	call atodw	                
 
	mul EAX 
	mov ESI, EAX	

       	push NULL
	push offset numberOfChars
	push 10
	push offset string_2
	push outputHandle
	call WriteConsole   
	
	push NULL
	push offset numberOfChars
	push 1
	push offset ent
	push outputHandle
	call WriteConsole  	     
	
       	push NULL                 
	push offset numberOfChars 
	push 100                   
	push offset a
	push inputHandle         
	call ReadConsole   
       	
      	mov EDX, offset a 	         ;сохранение адреса прочитанной строки
       	mov EAX, numberOfChars           ;сохранение длины прочитанной строки
       	mov byte ptr [ EDX + EAX - 2], 0 ;запись завершающего 0 в конец строки, при этом вычитание 2 из адреса необходимо для 
					 ;отбрасывания символов с кодами 13 и 10 в конце строки, помещаемых в буфер после нажатия Enter	                   
	
	push offset a
	call atodw 
	mov EBX, EAX  
	
      	push NULL
	push offset numberOfChars
	push 10
	push offset string_3
	push outputHandle
	call WriteConsole   
	
	push NULL
	push offset numberOfChars
	push 1
	push offset ent
	push outputHandle
	call WriteConsole  
	
       	push NULL                 
	push offset numberOfChars 
	push 100                   
	push offset d
	push inputHandle         
	call ReadConsole   
       	
      	mov EDX, offset d 	         ;сохранение адреса прочитанной строки
       	mov EAX, numberOfChars           ;сохранение длины прочитанной строки
       	mov byte ptr [ EDX + EAX - 2], 0 ;запись завершающего 0 в конец строки, при этом вычитание 2 из адреса необходимо для 
					 ;отбрасывания символов с кодами 13 и 10 в конце строки, помещаемых в буфер после нажатия Enter	                   
	
	push offset d
	call atodw     	
    	mov EDX, EAX  
    	
    	mov EAX, EBX
    	mul EDX 
    	mul n
        mov EDI, EAX  

	push NULL
	push offset numberOfChars
	push 10
	push offset string_4
	push outputHandle
	call WriteConsole  

	push NULL
	push offset numberOfChars
	push EAX
	push offset ent
	push outputHandle
	call WriteConsole   
	
       	sub ESI, EDI   
	
	push offset raz
	push ESI
	call dwtoa

	push offset raz
	call lstrlen
	
     	push NULL
	push offset numberOfChars
	push EAX
	push offset raz
	push outputHandle
	call WriteConsole    
;--------------------------------------------------------------		 
	push 3000h
	call Sleep
	
	push 0
	call ExitProcess

end entryPoint