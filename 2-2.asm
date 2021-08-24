              .486
.model flat, stdcall
option casemap :none ; 
include windows.inc
include kernel32.inc
include masm32.inc
includelib kernel32.lib
includelib masm32.lib
.data
	new_line  db 13,10
    	buffer    db 1000 dup (" ")
    	buffer1   db 1000 dup (" ")
    	firs      db 'x=',0
    	sec       db 'y=',0
    	fs4 	  db 'x/y+3*(x-y)=',0 
    	ne_del db "ne_del"

.data?
	inputHandle   dd ?
	outputHandle  dd ?
	numberOfChars dd ?
	first         dd ?
	second        dd ?
	temp          db ?   
	chislo1       dd ?
	chislo2       dd ?
	chislo3       dd ?
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
    	push 1000            	   
    	push offset buffer         
    	push inputHandle           
    	call ReadConsole
         
                                          
    	mov EDX, offset buffer
    	mov EAX, numberOfChars 
    	mov byte ptr [ EDX + EAX - 1 ], 0 
    	mov byte ptr [ EDX + EAX - 2 ], 0


    	CMP byte ptr buffer , '-'
    	JE code1
    	JMP code2

        code1:
        push offset buffer + 1
        call atodw
        NEG EAX
        JMP base

        code2:
        push offset buffer
        call atodw
        JMP base

    	base:
    	mov first,EAX
    
    
    	push NULL
    	push offset numberOfChars
    	push 1000
    	push offset buffer1
    	push inputHandle
    	call ReadConsole

    	mov EDX, offset buffer1
    	mov EAX, numberOfChars 
    	mov byte ptr [ EDX + EAX - 1 ], 0 
    	mov byte ptr [ EDX + EAX - 2 ], 0
         
  
    	CMP byte ptr buffer1 , '-'
    	JE Code1
    	JMP Code2
    	
    	Code1:
    	push offset buffer1 + 1
    	call atodw
    	NEG EAX
    	JMP base2

	Code2:
    	push offset buffer1
    	call atodw
    	JMP base2

    	base2:
    	mov second,EAX
              
       ;	/////////////////////////  
                     
       	cmp second ,0
	je nol
	ja ne_nol       
	
	nol: 
     	push 0
	push offset numberOfChars
	push 6
	push offset ne_del
	push outputHandle
	call WriteConsole
	
	
	ne_nol:
	
       
    	mov EAX, first
        sub EAX, second
        
	mov chislo1, EAX  
	
	mov EAX, chislo1
	mov EBX, 3
        imul EAX, EBX
	mov chislo2, EAX  
	  
	mov EBX, second                  
	mov EAX, first
    	mov EDX, 0
    	cdq
        idiv EBX
    	mov ECX, EAX    
    	
    	mov EAX, chislo2
    	add EAX, ECX
    	
    
    	
    	push offset buffer
    	push EAX
    	call dwtoa  
    	
	push NULL 
        push offset numberOfChars
        push 12
        push offset fs4
        push outputHandle
        call WriteConsole 
    	
    	push offset buffer
    	call lstrlen
        
    	
    	push NULL
    	push offset numberOfChars
    	push EAX
    	push offset buffer
    	push outputHandle
    	call WriteConsole
    	
    		push NULL
	push offset numberOfChars 
	push 2                   
	push offset new_line 
	push outputHandle         
	call WriteConsole
	
	
	
        
        push 500000 
	call Sleep
	
	push 0
	call ExitProcess     
end entryPoint


	
	
	


	
	 

	
;--------------------------------------------------------------		 
