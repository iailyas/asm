.486
.model flat, stdcall

option casemap : none

include windows.inc
include kernel32.inc
include masm32.inc
include user32.inc

includelib kernel32.lib
includelib masm32.lib
includelib user32.lib 


list struct
	 mec dd 0
	 god	dd 0
	 massa 	dq 0 
list ends

.data
	template db "mec: %d, god: %d, massa: %s;", 0ah, 0
	enterN	 db "Enter n: ", 0
	enterArrElem db "Enter array element (r, pl, pr):", 0ah, 0
	try db "Invalid input. Try again.", 0ah, 0
	byPlace db 0ah, "Sorted by date:", 0ah, 0
	byPrice	db 0ah, "Sorted by mas: ", 0ah, 0
	n dd 0
	array list 100 dup ( <> )

.data?
	inputHandle     dd ?
	outputHandle	dd ?
	numberOfChars	dd ?
	buffer	db 3000 dup (?)
	tmp db 100 dup (?)

.code                                                                                               
; void readList(list* array, int size)
readList:
	push EBP
	mov  EBP, ESP
	           
	startLoopRead:
		cmp dword ptr [ EBP + 12 ], 0
		je endLoopRead
		
        jmp startRead
                                                                                                   
        retry:
        ;????? "???????????? ????"
        push NULL
        push offset numberOfChars
        push 26
        push offset try
        push outputHandle
        call WriteConsole
        
       
        startRead:
	;??????? ????? ?? ????	
	push offset enterArrElem  
	call lstrlen
		
	push NULL
	push offset numberOfChars
	push EAX
	push offset enterArrElem
	push outputHandle
	call WriteConsole
	
	;????????? ?????? ??????? ?? ????????????	
	mov EBX, dword ptr [ EBP + 8 ]          ; EBX = array
	
	; read list[i].row
	push	NULL
	push	offset numberOfChars
	push	15
	push	offset buffer
	push	inputHandle
	call	ReadConsole
	
	cmp  buffer[0], '-'
	jne lblrow
	mov buffer[0], 2d
	lblrow:
		
	mov EDX, offset buffer
	mov EAX, numberOfChars
	mov byte ptr [ EDX + EAX - 2], 0
	
	push offset buffer
	call atodw
	mov dword ptr [ EBX ], EAX
		
		   			                                                                                            
	cmp dword ptr [ EBX ], 0
	jle retry            ;???? ???????????
	
	; read list[i].place
	push	NULL
	push	offset numberOfChars
	push	15
	push	offset buffer
	push	inputHandle
	call	ReadConsole
	
	cmp buffer[0], '-'
	jne lblplace
	mov 	buffer[0], 2d
	lblplace:
	
	mov EDX, offset buffer
	mov EAX, numberOfChars
	mov byte ptr [ EDX + EAX - 2], 0
	
	push offset buffer
	call atodw
	mov dword ptr [ EBX  + 4 ], EAX
		
	
												                                                                                            
	cmp dword ptr [ EBX + 4 ], 0
	jle retry                ;???? ???????????
	
	; read list[i].price
	push NULL
	push offset numberOfChars
	push 15
	push offset buffer
	push inputHandle
	call ReadConsole
		
	mov EDX, offset buffer
	mov EAX, numberOfChars
	mov byte ptr [ EDX + EAX - 2 ], 0
	
	add EBX, 8
		
	push EBX
	push offset buffer
	call StrToFloat 
			
       	mov EBX, dword ptr [ EBP + 8 ]  		; EBX = offset array
       	                                                                                            
       	finit					; clear ST     ???????????
	fldz                                        ; ST(0) = 0
	fld qword ptr [ EBX + 8 ]               ; ST(0) -> ST(1), ST(0) = list[i].price
	fcom ST(1)                               ; ?????????? ST(0) and ST(1)
	fstsw AX                                  ; ????????? ???? ????????? ? AX
	sahf                                        ; ???????? ???? ?? AX ? ??????
	jbe  retry                                ;???? ???????????
	
	
		
	add dword ptr [ EBP + 8 ], 16 		;??????? ? ?????????? ????????
	dec dword ptr [ EBP + 12 ]                                  
	
	jmp startLoopRead
	endLoopRead:
	
	pop EBP
ret 8

; int listCompareByPlace(list* first, list* second)
listCompareByPlace:
	push EBP
	mov EBP, ESP     
               
	mov EAX, dword ptr [ EBP + 8 ]			; EAX = first
	mov EBX, dword ptr [ EBP + 12 ]             ; EBX = second
	
	mov EDX, dword ptr [ EAX +4 ]                  ; EDX = first.mec
	cmp EDX, dword ptr [ EBX +4 ]                  ; ?????????? EDX and second.mec  ?? ???? ?????? ? ?????? ????
	jg  gcbpl                                   ;???? ?????? ??????
	jl  lcbpl                                   ;???? ??????
	
	mov EDX, dword ptr [ EAX ]				; EDX = first.god
	cmp EDX, dword ptr [ EBX ]              ; ?????????? EDX and second.god ?? ???? ?????? ? ?????? ?????
	jg gcbpl
	jl lcbpl
								; if ( first == second )
	mov		EAX, 0                                  ; return 0
	jmp		returnCBPL
	
	gcbpl:							; ???? ?????? ??????
	mov		EAX, 1                                  ; return 1
	jmp		returnCBPL
	
	lcbpl:                            	; ???? ?????? ??????
	mov		EAX, -1                  ; return -1
	
	returnCBPL:
	
    pop	EBP
ret 8
                                                                                                    
; int listCompareByPrice(list* first, list* second)
listCompareByPrice:
	push EBP
	mov EBP, ESP
	           
	mov EAX, dword ptr [ EBP + 8 ]				; EAX = first	
	mov EBX, dword ptr [ EBP + 12 ]             ; EBX = second
	
	finit                           		; ??????????? 
        fld  qword ptr [ EAX + 8 ]                   ; ST(0) = first.massa
        fcom  qword ptr [ EBX + 8 ]                   ; ?????????? ST(0) and second.massa  ?? ???? ?????? ? ?????? ?????????
	fstsw	AX                                      ; ????????? ?????????(????) ? AX
	sahf                                            ; ???????? ? ?????? ???? ?? AX
	ja		acbpr                            ;???? ?????? ?????? 
	jb		bcbpr
							; if ( first == second )
	mov		EAX, 0                                  ; return 0
	jmp		returnCBPR
	
	acbpr:    					        ;???? ?????? ?????? 
	mov		EAX, 1                                  ; return 1
	jmp		returnCBPR
	
	bcbpr: 							; ???? ?????? ??????
	mov		EAX, -1                                 ; return -1
	
	returnCBPR:
		
	pop		EBP
ret 8
                                                                                            
; void swap(list* first, list* second)
swap:
	push EBP
	mov EBP, ESP
	           
	mov EBX, dword ptr [ EBP + 8 ]				; EBX = first
	mov EDX, dword ptr [ EBP + 12 ]             ; EDX = second
	
	mov EAX, dword ptr [ EBX ]                	; EAX = first.mec
	mov ECX, dword ptr [ EDX ]                  ; ECX = second.mec
	mov dword ptr [ EDX ], EAX                  ; second.mec = EAX
	mov dword ptr [ EBX ], ECX                  ; first.mec = ECX
	
	mov EAX, dword ptr [ EBX + 4 ]         	    ; EAX = first.god
	mov ECX, dword ptr [ EDX + 4 ]              ; ECX = second.god
	mov dword ptr [ EDX + 4 ], EAX              ; first.god = EAX
	mov dword ptr [ EBX + 4 ], ECX              ; second.god = ECX        
	
	finit                       					; clear ST
	fld qword ptr [ EBX + 8 ]                   ; ST(0) = first.massa
	fld qword ptr [ EDX + 8 ]                   ; ST(0) -> ST(1), ST(0) = second.massa
	fstp qword ptr [ EBX + 8 ]                   ; first.massa = ST(0), ST(1) -> ST(0)
	fstp qword ptr [ EDX + 8 ]                   ; second.massa = ST(0)
	
	pop EBP
ret 8
                                                                                                   
; void	bubbleSort(list* array, int size)
bubbleSort:
	push EBP
	mov EBP, ESP
	              
	sub ESP, 4								
	           
    mov	ECX, 1
    
    startLoopSort1:
       	cmp ECX, dword ptr [ EBP + 12 ]			; for ( ECX = 1; ECX < size; ECX++ )
        je endLoopSort1                                  ;???? ?????, ?? ? ?????????? 
               	
       	mov EAX, dword ptr [ EBP + 12 ]			; EAX = size
       	sub EAX, ECX                            ; EAX = EAX - ECX
       	mov dword ptr [ EBP - 4 ], EAX 			; localVarible = EAX		
       	
       	push ECX									; ????????? ECX ? ????
    	mov ECX, 0
    		 		             
    	startLoopSort2:
    		cmp ECX, dword ptr [ EBP - 4 ]		; for ( ECX = 0; ECX < ( size - prev ECX ); ECX++ )
    		je endLoopSort2
    		           
    		push ECX								; ????????? ECX ? ????
    		
    		mov EBX, dword ptr [ EBP + 8 ]		; EBX = array
    		
    		mov EAX, 16				; EAX = 16
    		mul ECX                             ; EAX = 16 * ECX ( element offset )
    		
    		add EBX, EAX						; EBX = EBX + EAX ( array[ ECX ] )
    		push EBX						
    		add EBX, 16							; EBX = EBX + EAX + 16 ( array[ ECX + 1 ] )
    		push EBX
    		call dword ptr [ EBP + 16 ]			; call compare function
    		
    		pop ECX								; ???????????? ECX 
    	
    		cmp EAX, 0							; ???????? return value and 0
    		jge continueSort
    										; if ( array[ ECX ] > array[ ECX + 1 ] ) 
    		push ECX							; ????????? ECX ? ????
    		
    		mov EBX, dword ptr [ EBP + 8 ]		; EBX = array
    		
    		mov EAX, 16							; EAX = 16                     
    		mul ECX								; EAX = 16 * ECX ( element )
    		   
       		add EBX, EAX						; EBX = EBX + EAX ( array[ ECX ] )						
    		push EBX
    		add EBX, 16							; EBX = EBX + EAX + 16 ( array[ ECX + 1 ] )
    		push EBX
    		call swap							; swap(array[ ECX + 1 ], array[ ECX ]) 
    		
    		pop ECX								; restore ECX value
    		
    		continueSort:
    		
    		inc ECX
    		
    		jmp startLoopSort2
    	endLoopSort2:
        
        pop ECX									; restore ECX value from stack
        inc ECX
        
    	jmp startLoopSort1
    endLoopSort1:
    
    add	 ESP, 4									; clear memory
	
	pop EBP
ret 12

; void listToStr(char* buffer, list* array, int size)
listToStr:
	push EBP
	mov EBP, ESP           

	startLoopConvert:		
		cmp dword ptr [ EBP + 16 ], 0
		je endLoopConvert 
		                        
	 	mov EAX, dword ptr [ EBP + 12 ]			; EAX = array
	 
		push offset tmp
		push dword ptr [ EAX + 12 ]
		push dword ptr [ EAX + 8 ]
		call FloatToStr      					; ?????????????? array[i].massa ? ??????
		
	 	mov  EAX, dword ptr [ EBP + 12 ]			; EAX = array	 
		
	   	push offset tmp
	   	push dword ptr [ EAX + 4 ]
		push dword ptr [ EAX ]
		push offset template
		push dword ptr [ EBP + 8 ]
		call wsprintf 							; ??????? ??????
			
		add ESP, 20
		
		add [ EBP + 8 ], EAX
		add dword ptr [ EBP + 12 ], 16 		       ;	? ???? ????????
		dec dword ptr [ EBP + 16 ]
		
		jmp startLoopConvert 
	endLoopConvert:
	
	pop EBP	
ret 16

main:
                                                                                                   
	push STD_INPUT_HANDLE
	call GetStdHandle
	mov inputHandle, EAX
	
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov outputHandle, EAX
	
   	; read n
    tryN:     ;?????????												      												                                                                                              
	push	NULL
	push	offset numberOfChars
	push	9
	push	offset enterN
	push 	outputHandle
	call	WriteConsole
	
	push	NULL
	push	offset numberOfChars
	push	15
	push	offset buffer
	push	inputHandle
	call	ReadConsole
	
	cmp buffer[0], '-'
	jne lbln
	mov buffer[0], 2d
	lbln:
	
	mov EDX, offset buffer
	mov EAX, numberOfChars
	mov byte ptr [ EDX + EAX - 2 ], 0
	
	push offset buffer
	call atodw  ;? ?????  
	
	mov n, EAX 
	
	cmp n, 0
	jle tryN   ;???? ?????? ??? ?????

                                                                                                  
	push	n
	push	offset array
	call	readList 								; readList(array, n)                                                                               
	
	; ????? ????
	push	NULL
	push	offset numberOfChars
	push	18
	push	offset byPlace
	push	outputHandle
	call	WriteConsole

       ;?????????? ?? ?????
	push	listCompareByPlace
	push	n
	push	offset array
	call	bubbleSort		  		; bubbleSort(array, n, listCompareByPlace)
                                                                                                   
	push	n
	push	offset array
	push	offset buffer
	call	listToStr    							; ?????????????? ?????? ? ??????
	
	push	offset buffer
	call	lstrlen
	
	push	NULL
	push	offset numberOfChars
	push	EAX
	push	offset buffer
	push	outputHandle
	call	WriteConsole  
     		

       	; ????? ????												
	push	NULL
	push	offset numberOfChars
	push	18
	push	offset byPrice
	push	outputHandle
	call	WriteConsole

;?????????? ?? ?????
                                                                                                   
	push	listCompareByPrice
	push	n
	push	offset array
	call	bubbleSort 								; bubbleSort(array, n, listCompareByPrice)

                                                                                                   
	push	n
	push	offset array
	push	offset buffer
	call	listToStr   							; ?????????????? ?????? ? ??????
	
	push	offset buffer
	call	lstrlen
	
	push	NULL
	push	offset numberOfChars
	push	EAX
	push	offset buffer
	push	outputHandle
	call	WriteConsole
	

	
	push	NULL
	push	offset numberOfChars
	push	1
	push	offset buffer
	push	inputHandle
	call	ReadConsole
	
	push	0
	call	ExitProcess
		
end main 