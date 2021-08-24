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
pr db 0
tt dd 8 
inputBuffer db 1000 dup (' ')   
message1 db "Enter a:", 0       
message2 db "Enter b:", 0  
message3 db "Enter c:", 0  
firstStr db 100 dup (" ") 
secondStr db 100 dup (" ") 
thertStr db 100 dup (" ") 
number1 dd 0 
number2 dd 0 
number3 dd 0

.data? 
res db ? 
resofpow dd ?
buffer dd ?       
a1 dd ?
a2 dd ?
buf dd ?
d2 dd ?
mulb dd ?
mulbc dd ?  
ed dd ?
resed dd ?
result dd ?

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

;preobr
push NULL 
push offset numberOfChars 
push 100 
push offset firstStr 
push inputHandle 
call ReadConsole      


mov EDX, offset firstStr 
mov EAX, numberOfChars
mov byte ptr [ EDX + EAX - 2 ], 0   


push offset firstStr 
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
  
push offset secondStr 
call atodw 	

mov number2, EAX 


push offset message3 
call lstrlen 

push NULL 
push offset numberOfChars 
push EAX 
push offset message3 
push outputHandle 
call WriteConsole 

push NULL 
push offset numberOfChars 
push 100 
push offset thertStr
push inputHandle 
call ReadConsole 

mov EDX, offset thertStr 
mov EAX, numberOfChars
mov byte ptr [ EDX + EAX - 2 ], 0 
  
push offset thertStr 
call atodw 	

mov number3, EAX 
   
;start

;b/8
mov EAX, number2   
mov EDX,0
div tt  
mov mulb,EAX 
;(b/8)/c
mov EAX,mulb
mov EDX,0
div number3   
adc EAX,EDX
mov mulb,EAX  
;mov ed,EDX


;start pow
mov EAX, number1
mul number1  ;2
mov buf,EAX 
mul buf ;4
mov a1,EAX 
mul a1  ;8
mul buf ;12
mul number1 ;13
;end pow
 ; a^13/c
;mov res,EAX
mov EDX, 0 

div number3 
adc EAX,EDX
adc EAX,mulb


;adc EAX, res
mov res,EAX
;adc res,mulb
 
;adc result,EAX  


push offset buffer
push res
call dwtoa 
        
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
push 1
push offset inputBuffer
push inputHandle
call ReadConsole

push 0 
call ExitProcess 

end entryPoint