.486
.model flat, stdcall
option casemap :none ; чувствительность к регистру букв в идентификаторах
include windows.inc
include kernel32.inc
includelib kernel32.lib

.data   
	firstStr db 16 dup (' ')     
     	secondStr db 16 dup (0B0H)
      	thirtSrt db 18 dup (0B1H)
   
   
       	onePic db 13, 10, 0DAH, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0C4H, 0BFH, 10, 13, 0B3H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B0H, 0B3H, 13, 10, 0
       	
      	twoPic db 13, 10, 0B3H, 0B0H, 0B0H, 0B0H, 0C9H, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CFH, 0CDH, 0CDH, 0CDH, 0BBH, 13, 10, 0C0H, 0C4H, 0C4H, 0C4H, 0B6H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0B1H, 0BAH, 13, 10, 0 
       
        threePic db "    ", 0BAH, 0B1H, 0B1H,  0B1H,  0B1H,  0B1H,  0B1H,  0B1H,  0B1H,  0B1H,  0B1H,  0B1H,  0B1H, 0BAH, 13, 10, "    ", 0C8H, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0CDH, 0BCH, 0
.data?
       	firstInput dd ?
       	secondInput dd ?
       	thirtInput dd ?      
       	
	cin dd ?
	cout dd ?
	numberOfChars dd ?
.code
entryPoint:
	push STD_OUTPUT_HANDLE    ; передача параметра в функцию. Описана в windows.inc (нектр число)
	call GetStdHandle           ; вызов системной функции. Запрашивает дескриптор потока вывода	            
	mov cout, EAX        ; сохранение результата функции. Из EAX в cout
	
    	push STD_INPUT_HANDLE
    	call GetStdHandle
   	mov cin, EAX 
;------------------------------------------------------------------------------------------------------	
	; Ввод первой строки
     	push NULL
    	push offset firstInput
    	push 12
    	push offset firstStr + 4
    	push cin 
    	call ReadConsole 
    	
    	; Ввод второй строки
     	push NULL
   	push offset secondInput
    	push 12
    	push offset secondStr + 2
    	push cin 
    	call ReadConsole
    	
    	; Ввод второй строки
     	push NULL
   	push offset thirtInput
    	push 12
    	push offset thirtSrt + 6
    	push cin 
    	call ReadConsole
;------------------------------------------------------------------------------------------------------
	;Редактирование первой строки
     	mov ESI, firstInput
     	mov EBX, offset firstStr
     	mov byte ptr [ EBX + ESI + 4 - 2 ], ' '
       	mov byte ptr [ EBX + ESI + 4 - 1 ], ' '
	;Вывод #1

	  
    	push NULL                 
    	push offset numberOfChars
    	push 16     
    	push offset firstStr    
	push cout           
    	call WriteConsole     
;##################################################	
	;Вывод рисунка #1
	push offset onePic
	call lstrlen
	
	push NULL
  	push offset numberOfChars
  	push EAX
  	push offset onePic
  	push cout 
  	call WriteConsole
;------------------------------------------------------------------------------------------------------	
	         
	;Редактирование второй строки  
      	mov ESI, secondInput
     	mov EBX, offset secondStr
     	mov byte ptr [ EBX ], 0B3H 
   	
     	mov byte ptr [ EBX + ESI + 2 - 2 ], 0B0H ; Решетка (убираем ентер)
      	mov byte ptr [ EBX + ESI + 2 - 1 ], 0B0H ; Аналогично
   	
     	mov byte ptr [ EBX + 13 ], 0B3H
	;Вывод #2
    	push NULL                 
    	push offset numberOfChars
    	push 14      
    	push offset secondStr    
    	push cout           
    	call WriteConsole   
	
;##################################################	
	;Вывод рисунка #1
	push offset twoPic
	call lstrlen
	
	push NULL
  	push offset numberOfChars
  	push EAX
  	push offset twoPic
  	push cout 
  	call WriteConsole	
	
;------------------------------------------------------------------------------------------------------	
	;Редактирование первой строки
     	mov ESI, thirtInput
     	mov EBX, offset thirtSrt
     	mov byte ptr [ EBX ], 0
     	mov byte ptr [ EBX + 1 ], 0
     	mov byte ptr [ EBX + 2 ], 0
     	mov byte ptr [ EBX + 3 ], 0
     	
     	mov byte ptr [ EBX + 4 ], 0BAH
     	
     	mov byte ptr [ EBX + ESI + 6 - 2 ], 0B1H
       	mov byte ptr [ EBX + ESI + 6 - 1 ], 0B1H
       	
       	mov byte ptr [ EBX + 17], 0BAH
	
	;Вывод #3
    	push NULL                 
    	push offset thirtInput
    	push 20      
    	push offset thirtSrt   
    	push cout           
    	call WriteConsole 
	
	;Вывод рисунка #3
	push offset threePic
	call lstrlen
	
	push NULL
  	push offset numberOfChars
  	push EAX
  	push offset threePic
  	push cout 
  	call WriteConsole
	
	push 0 ; аналогично плюсам return 0
	call ExitProcess ; Для корректного завершения программы

end entryPoint
