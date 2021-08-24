.486
.model flat, stdcall
option casemap :none ; ���������������� � �������� ���� � ���������������
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
	buf2 dd ?
	;
	numberOfCharsWritten dd ?
     	;data
     	a dd ?
     	apow dd ?
     	
     	b dd ?
     	divbdivc dd ?
     	del dd ?
     	
     	cc dd ?
     	
     	l dd ?
     	r dd ?
     	
     	res dd ?
     	
     	
	cin dd ?
	cout dd ?
.code
entryPoint:
	push STD_OUTPUT_HANDLE    ; �������� ��������� � �������. ������� � windows.inc (����� �����)
	call GetStdHandle           ; ����� ��������� �������. ����������� ���������� ������ ������	            
	mov cout, EAX        ; ���������� ���������� �������. �� EAX � cout
	
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
    	push 25
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
    	push 25
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
         
        ;mov EDX, 0 ; obnulenie EDX
        ;div tt ; division by 8
        shr b, 3
                
        cdq ; ���������� EAX �� 8-���������
            
        ;start pow      
        mov EAX, a
        mul a  ;2    
        mul EAX ;4
        mov buf, EAX
        mul buf	  ;8
        mov buf2, EAX
        mov EAX, buf          
	mul a   ;5 	
	mul buf2  ;13
	;end pow    
	  
	add EAX, b      ;a^13+b/8
	adc EDX, 0 ; ��������� ��� ��������
	;
        div cc    
        add EAX,EDX
 
        
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

	push NULL
    	push offset numberOfCharsWritten 
    	push 25
    	push offset buffer 
    	push cin 
    	call ReadConsole
	
			                                                                                       
	push 0 ; ���������� ������ return 0
	call ExitProcess ; ��� ����������� ���������� ���������

end entryPoint
