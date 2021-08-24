.486
    .model flat, stdcall
    option casemap :none   
    
    include windows.inc
    include user32.inc
    include kernel32.inc
    include masm32.inc
    
    includelib masm32.lib
    includelib user32.lib
    includelib kernel32.lib     
    
.data
     
    message1 db "Enter x: ", 0  
    message2 db "Enter y: ", 0
    error db "Error: Division by zero!", 0 
    firstStr db 100 dup (" ")
    secondStr db 100  dup (" ")                       
    number1 dd 0
    number2 dd 0
    inputBuffer db 1000 dup (' ')  
    ent db 10
    
.data? 
 	min1 dd ? 
 	min2 dd ?
 	max1 dd ? 
 	max2 dd ?
 	x10 dd ?
 	y10 dd ?
 	res dd ?
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
	
	
	push offset message1
   	call lstrlen
                      
    	push NULL
  	push offset numberOfChars
   	push EAX
   	push offset message1
    	push outputHandle         
    	call WriteConsole
    
  	push NULL
	push offset numberOfChars
	push 100
	push offset firstStr
	push inputHandle   
	call ReadConsole 
	
	mov EDX, offset firstStr
	mov EAX, numberOfChars           
 	mov byte ptr [ EDX + EAX - 2 ], 0 
 	
 	mov EBX, offset firstStr

	push EBX
   	call atodw
                                                                                              
   	mov number1, EAX  
   	
   	push offset message2
   	call lstrlen
   	
   	push NULL
  	push offset numberOfChars
   	push EAX
   	push offset message2
    	push outputHandle         
    	call WriteConsole  
		
   	push NULL
	push offset numberOfChars
	push 100
	push offset secondStr
	push inputHandle   
	call ReadConsole
	    
        mov EDX, offset secondStr
	mov EAX, numberOfChars           
 	mov byte ptr [ EDX + EAX - 2 ], 0 
 	
 	mov EBX, offset secondStr

	push EBX
   	call atodw
    
   	mov number2, EAX  
   	 
;min(10,y)
	mov EAX, 10
	mov EBX, number2 
	
	cmp EAX, EBX 
	JLE Metka1        
		mov min1, EBX         
		JMP Metka2
Metka1:
	mov min1, EAX	   

Metka2: 	
;max(x,y)	
	mov EAX, number1
	mov EBX, number2
	
	cmp EAX, EBX
	JGE Metka3
		mov max1, EBX
		JMP Metka4
Metka3:
	mov max1, EAX  
				
Metka4:      
;min(min1, max1)
       mov EAX, min1
       mov EBX, max1
       
       cmp EAX, EBX  
       JLE Metka5
       		mov min2, EBX
       		JMP Metka6
Metka5:
	mov  min2, EAX
       		
Metka6: 
;max(x%10, y%10)
	mov EAX, number1
	mov EDX, 0
	mov EBX, 10
	div EBX
	mov x10, EDX
	
	mov EAX, number2
	mov EDX, 0
	mov EBX, 10
	div EBX
	mov y10, EDX
	
	mov EAX, x10
	mov EBX, y10
	
	cmp  EAX, EBX
	JGE Metka7
		mov max2, EBX
		JMP Metka8
Metka7: 
	mov max2, EAX
       	   
Metka8:	
    	cmp max2, 0
 	JE err
	
	mov EAX, min2
       	cdq
	mov EBX, max2
	idiv EBX
	mov res, EAX     		
       
        push offset res
	push EAX
	call dwtoa
		  
 	push offset res
	call lstrlen 
	
       	push NULL                 
	push offset numberOfChars 
	push EAX
	push offset res
	push outputHandle         
	call WriteConsole 	      		
 	
 	push NULL                 
	push offset numberOfChars 
	push 1
	push offset ent
	push outputHandle         
	call WriteConsole
	  
 		JMP Metka
	
err:    
	push offset error
	call lstrlen
	
 	push NULL
     	push offset numberOfChars
        push EAX
        push offset error 
        push outputHandle         
        call WriteConsole 		 
	
Metka:	        
	push 3000h
	call Sleep
	
	push 0
	call ExitProcess

end entryPoint