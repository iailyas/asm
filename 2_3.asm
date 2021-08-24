;«адание 3. Ќа €зыке јссемблера создать консольное приложение, которое считывает три введЄнных пользователем строки,
;усекает или дополн€ет пробелами каждую строку до 10 символов, после чего выводит текст в соответствии с заданием 
       ????????????
       ?aaaaaaaaaa?
       ????????????
          ?    ?
     ??????    ??????
     ?              ?
????????????  ????????????
?bbbbbbbbbb?  ?cccccccccc?
????????????  ????????????
;-----------------------------------------------------------------------------------------------------;	
.486
.model flat, stdcall						
option casemap :none					 ; чувствительность к регистру букв в идентификаторах
include windows.inc
include kernel32.inc
includelib kernel32.lib

.data     
         inputBuffer db 0
         inputBuffer1 db 1000 dup (" ")
         inputBuffer2 db 1000 dup (" ")
         inputBuffer3 db 1000 dup (" ")     
         
         line1 db 000H,000H,000H,000H,000H,000H,000H,0C9H,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0BBH
         line2 db 000H,000H,000H,000H,000H,000H,000H,0BAH 
         line3 db 0BAH   
         line4 db 000H,000H,000H,000H,000H,000H,000H,0C8H,0CDH,0D1H,0CDH,0CDH,0CDH,0CDH,0D1H,0CDH,0CDH, 0CDH, 0BCH
         line5 db 000H,000H,000H,000H,000H,000H,000H,000H,000H,0B3H,000H,000H,000H,000H,0B3H       
         line6 db 000H,000H,000H,000H,000H,0DAH,0C4H,0C4H,0C4H,0D9H,000H,000H,000H,000H,0C0H,0C4H,0C4H,0C4H,0BFH
         line7 db 000H,000H,000H,000H,000H,0B3H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,0B3H
         line8 db 0C9H,0CDH,0CDH,0CDH,0CDH,0CFH,0CDH,0CDH,0CDH,0CDH,0CDH,0BBH,000H,0C9H,0CDH,0CDH,0CDH,0CDH,0CFH,0CDH,0CDH,0CDH,0CDH,0CDH,0BBH
         line9 db 0BAH
         line10 db 0BAH
         line11 db 000H,0BAH
         line12 db 0BAH   
         line13 db 0C8H,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0BCH,000H,0C8H,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0BCH
         newLine db 10,13
.data?
	inputHandle dd ?
	outputHandle dd ?
	numberOfChars dd ? 
	linebuf dd ? 
	
.code

entryPoint:
;-----------------------------------------------------------------------------------------------------;	
		push STD_INPUT_HANDLE					    ;поток ввода 
		call GetStdHandle					
		mov inputHandle, 						 
	
		push STD_OUTPUT_HANDLE					   ;поток вывода
		call GetStdHandle       
		mov outputHandle, EAX    
;-----------------------------------------------------------------------------------------------------;	  
	push NULL                   
	push offset numberOfChars
	push 1000
	push offset inputBuffer1
	push inputHandle
	call ReadConsole
	
	mov EBX, offset inputBuffer1
        mov EAX, numberOfChars
        mov byte ptr [ EBX + EAX - 1 ], " "			;добавл€ем в конце строки сиввол " "дл€ перевода курсора 
        mov byte ptr [ EBX + EAX - 2 ], " "			
        
	push NULL
	push offset numberOfChars
	push 1000
	push offset inputBuffer2
	push inputHandle
	call ReadConsole
	
	mov EBX, offset inputBuffer2
        mov EAX, numberOfChars
        mov byte ptr [ EBX + EAX - 1 ], " "       ;добавл€ем в конце строки сиввол " "дл€ перевода курсора 
        mov byte ptr [ EBX + EAX - 2 ], " "
        
        push NULL
	push offset numberOfChars
	push 1000
	push offset inputBuffer3
	push inputHandle
	call ReadConsole
	
	mov EBX, offset inputBuffer3
        mov EAX, numberOfChars
        mov byte ptr [ EBX + EAX - 1 ], " "
        mov byte ptr [ EBX + EAX - 2 ], " "  
         
        push NULL                 
	push offset numberOfChars 
	push 19                 
	push offset line1
	push outputHandle         
	call WriteConsole
       
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole  
         
        push NULL                 
	push offset numberOfChars 
	push 8                 
	push offset line2
	push outputHandle         
	call WriteConsole 
	
	push NULL
	push offset numberOfChars
	push 10
	push offset inputBuffer1  
	push outputHandle
	call WriteConsole
	
	push NULL                 
	push offset numberOfChars 
	push 1                 
	push offset line3
	push outputHandle         
	call WriteConsole
	
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole
       
	push NULL                 
	push offset numberOfChars 
	push 20                 
	push offset line4
	push outputHandle         
	call WriteConsole
	
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole	         
	
	push NULL                 
	push offset numberOfChars 
	push 15                 
	push offset line5
	push outputHandle         
	call WriteConsole 
	
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	
    push NULL                 
    push offset numberOfChars 
    push 19                 
    push offset line6
    push outputHandle         
    call WriteConsole  
        
    push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	
	push NULL                 
	push offset numberOfChars 
	push 19                 
	push offset line7
	push outputHandle         
	call WriteConsole 
	 
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	
	push NULL                 
	push offset numberOfChars 
	push 25                 
	push offset line8
	push outputHandle         
	call WriteConsole 
	
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	   
	push NULL                 
	push offset numberOfChars 
	push 1                 
	push offset line9
	push outputHandle         
	call WriteConsole 
	 
	push NULL
	push offset numberOfChars
	push 10
	push offset inputBuffer2  
	push outputHandle
	call WriteConsole
	
	push NULL                 
	push offset numberOfChars 
	push 1                 
	push offset line10
	push outputHandle         
	call WriteConsole 
	
	push NULL                 
	push offset numberOfChars 
	push 2                 
	push offset line11
	push outputHandle         
	call WriteConsole 
	 
	push NULL
	push offset numberOfChars
	push 10
	push offset inputBuffer3  
	push outputHandle
	call WriteConsole
	
	push NULL                 
	push offset numberOfChars 
	push 1                 
	push offset line12
	push outputHandle         
	call WriteConsole 
	     
	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	   
	push NULL                 
	push offset numberOfChars 
	push 25                 
	push offset line13
	push outputHandle         
	call WriteConsole  
	 
        push NULL
	push offset numberOfChars
	push 1
	push offset inputBuffer
	push inputHandle
	call ReadConsole
      
	push 0
	call ExitProcess					 ;завершени€ приложени€

end entryPoint			