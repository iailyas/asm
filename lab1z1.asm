push NULL
push offset numberOfChars
push 1000
push offset buffer
push inputHandle
call ReadConsole                  ; чтение с клавиатуры строки, при этом длина
                                  ; прочитанной строки записывается в
                                  ; переменную numbersOfChars
mov EDX, offset buffer            ; сохранение адреса прочитанной строки
mov EAX, numberOfChars            ; сохранение длины прочитанной строки
mov byte ptr [ EDX + EAX - 2 ], 0 ; запись завершающего нуля в конец строки,
                                  ; при этом вычитание 2 из адреса необходимо
                                  ; для отбрасывания символов с кодами 13 и 10
                                  ; в конце строки, помещаемых в буфер после
                                  ; нажатия пользователем клавиши Enter
                                  
push offset message       ; указатель на строку, описанную, например, так:
                          ; message db "hello", 0
call lstrlen              ; вычисление длины строки, завершающейся нулём,
                          ; при этом длина возвращается в регистре EAX
push NULL
push offset numberOfChars
push EAX                  ; ограничение количества выводимых символов
                          ; вычисленной ранее длиной строки
push offset message
push outputHandle
call WriteConsole