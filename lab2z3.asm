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
	  n db 16 
	  string_1 db 10 dup (" Vvedite a"), 0
	  string_2 db 10 dup (" Vvedite b"), 0
	  string_3 db 10 dup (" Vvedite c"), 0  
	  string_4 db 35 dup (" (a^9 + b/16)/c + (a^9 + b/16)%c"), 0

.data?  
	a db ?
	b db ?     
	d db ?  
	sum db ?
	pr_1 db ?
	pr_2 db ? 
	pr db ?
	pr_3 db ? 
	pr_4 db ?
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
	push offset a
	push inputHandle
	call ReadConsole       
	
       	mov EDX, offset a	         
       	mov EAX, numberOfChars           
       	mov byte ptr [ EDX + EAX - 2], 0 
       	
       	push offset a
	call atodw  
	mov ESI, EAX	                 
	mul EAX
	mul EAX
	mul EAX
	mul ESI
	mov ESI, EAX
	
COMMENT *
	push offset pr_1
	push ESI
	call dwtoa
	
	push offset pr_1
	call lstrlen
	
	push NULL
	push offset numberOfChars
	push EAX
	push offset pr_1
	push outputHandle
	call WriteConsole  
  	*
	
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
	push offset b
	push inputHandle         
	call ReadConsole   
       	
      	mov EDX, offset b 	         
       	mov EAX, numberOfChars          
       	mov byte ptr [ EDX + EAX - 2], 0 
	
	push offset b
	call atodw 
	div n 

COMMENT *	
	push offset pr_2
	push EAX
	call dwtoa 
	
	push offset pr_2
	call lstrlen
	
	push NULL
	push offset numberOfChars
	push EAX
	push offset pr_2
	push outputHandle
	call WriteConsole   
	
	push NULL
	push offset numberOfChars
	push 1
	push offset ent
	push outputHandle
	call WriteConsole  
    	*    
	
       	add ESI, EAX
       	  
COMMENT *       	
       	push offset pr
       	push ESI
       	call dwtoa
       	
       	push offset pr
       	call lstrlen
       	
	push NULL
	push offset numberOfChars
	push EAX
	push offset pr
	push outputHandle
	call WriteConsole 
	 *
	
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
       	
      	mov EDX, offset d 	         
       	mov EAX, numberOfChars           
       	mov byte ptr [ EDX + EAX - 2], 0                 
	
	push offset d
	call atodw     	
    	mov EBP, EAX      	
    	
    	mov EAX, ESI
 	div EBP 
 	mov ESI, EAX
 	mov EBP, EDX
 	
COMMENT *
 	push offset pr_3
       	push EAX
       	call dwtoa
       	
       	push offset pr_3
       	call lstrlen
       	
	push NULL
	push offset numberOfChars
	push EAX
	push offset pr_3
	push outputHandle
	call WriteConsole 
	
       	push offset pr_4
       	push EDX
       	call dwtoa
       	
       	push offset pr_4
       	call lstrlen
       	
	push NULL
	push offset numberOfChars
	push EAX
	push offset pr_4
	push outputHandle
	call WriteConsole 
	*

	push NULL
	push offset numberOfChars
	push 32
	push offset string_4
	push outputHandle
	call WriteConsole  

	push NULL
	push offset numberOfChars
	push EAX
	push offset ent
	push outputHandle
	call WriteConsole  
	
      	add ESI, EBP
	
	push offset sum
	push ESI
	call dwtoa

	push offset sum
	call lstrlen  
	
     	push NULL
	push offset numberOfChars
	push EAX
	push offset sum
	push outputHandle
	call WriteConsole  
	  
	push NULL
	push offset numberOfChars
	push 1
	push offset ent
	push outputHandle
	call WriteConsole  	     
	
       			 
	push 3000h
	call Sleep
	
	push 0
	call ExitProcess

end entryPoint