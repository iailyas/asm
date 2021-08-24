;Задание 3. На языке Ассемблера создать консольное приложение, которое считывает три введённых пользователем строки,
;усекает или дополняет пробелами каждую строку до 10 символов, после чего выводит текст в соответствии с заданием 
     
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
         
         line1 db 0DAH,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0BFH
         line2 db 0B3H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,0B3H    
         
         line3 db 0B3H,000H
         
         line5 db 0DAH,0C1H,0C4H,0C4H,0C4H,0C4H,0C4H,0C4H,0C4H,0C4H,0C4H,0C4H,0C4H,0BFH
         line6 db 0B3H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,0B3H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,0B3H
         line7 db 0C0H,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0C4h,0B4H,000H,000H
         line8 db 000H,0B3H   
         line9 db 000H,000H,000H,000H,000H,0C9H,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CFH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0BBH,000H,000H,000H,000H,0B3H
        line10 db 000H,000H,000H,000H,000H,0BAH,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,0C7H,0C4h,0C4h,0C4h,0C4h,0D9H
        line11 db 000H,000H,000H,000H,000H,0BAH,000H  
        line12 db 000H,000H,000H,0BAH     
        line13 db 000H,000H,000H,000H,000H,0BAH,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,0BAH  
        line14 db 000H,000H,000H,000H,000H,0C8H,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0CDH,0BCH
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
		mov inputHandle, EAX						 
	
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
        mov byte ptr [ EBX + EAX - 1 ], " "			;добавляем в конце строки сиввол " "для перевода курсора 
        mov byte ptr [ EBX + EAX - 2 ], " "			
        
	push NULL
	push offset numberOfChars
	push 1000
	push offset inputBuffer2
	push inputHandle
	call ReadConsole
	
	mov EBX, offset inputBuffer2
        mov EAX, numberOfChars
        mov byte ptr [ EBX + EAX - 1 ], " "       ;добавляем в конце строки сиввол " "для перевода курсора 
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
	push 14              
	push offset line1            ;
	push outputHandle         
	call WriteConsole 
	;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole    
	
	push NULL                 
	push offset numberOfChars 
	push 14            
	push offset line2           ;
	push outputHandle         
	call WriteConsole    
	
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole  
	
		push NULL                 
	push offset numberOfChars 
	push 2             
	push offset line3          ;
	push outputHandle         
	call WriteConsole    
	;выводим текст
	push NULL
	push offset numberOfChars
	push 10
	push offset inputBuffer1  
	push outputHandle
	call WriteConsole
       
        
	
		push NULL                 
	push offset numberOfChars 
	push 14             
	push offset line5         ;
	push outputHandle         
	call WriteConsole
	 
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole  
		push NULL                 
	push offset numberOfChars 
	push 26     
	push offset line6         ;
	push outputHandle         
	call WriteConsole  
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
        	push NULL                 
	push offset numberOfChars 
	push 14      
	push offset line7        ;
	push outputHandle         
	call WriteConsole 
	
	;выводим текст
	push NULL
	push offset numberOfChars
	push 10
	push offset inputBuffer2  
	push outputHandle
	call WriteConsole 
	 
		push NULL                 
	push offset numberOfChars 
	push 2     
	push offset line8        ;
	push outputHandle         
	call WriteConsole   
	
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	
		push NULL                 
	push offset numberOfChars 
	push 26
	push offset line9        ;
	push outputHandle         
	call WriteConsole
	 
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	
		push NULL                 
	push offset numberOfChars 
	push 26
	push offset line10       ;
	push outputHandle         
	call WriteConsole  
	 
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole
       
	 
		push NULL                 
	push offset numberOfChars 
	push 7
	push offset line11       ;
	push outputHandle         
	call WriteConsole  
		;выводим текст
	push NULL
	push offset numberOfChars
	push 10
	push offset inputBuffer3  
	push outputHandle
	call WriteConsole   
	
	push NULL                 
	push offset numberOfChars 
	push 4
	push offset line12     ;
	push outputHandle         
	call WriteConsole
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole 
	 	 
	
	push NULL                 
	push offset numberOfChars 
	push 21
	push offset line13     ;
	push outputHandle         
	call WriteConsole 
		;перевод 
        	push NULL                 
	push offset linebuf   
	push 2                 
	push offset newLine
	push outputHandle         
	call WriteConsole

	
		push NULL                 
	push offset numberOfChars 
	push 21
	push offset line14    ;
	push outputHandle         
	call WriteConsole 
	
	
        push NULL
	push offset numberOfChars
	push 1 
	push offset inputBuffer
	push inputHandle
	call ReadConsole 
	
      
	push 0
	call ExitProcess					 ;завершения приложения

end entryPoint			