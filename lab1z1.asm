push NULL
push offset numberOfChars
push 1000
push offset buffer
push inputHandle
call ReadConsole                  ; ������ � ���������� ������, ��� ���� �����
                                  ; ����������� ������ ������������ �
                                  ; ���������� numbersOfChars
mov EDX, offset buffer            ; ���������� ������ ����������� ������
mov EAX, numberOfChars            ; ���������� ����� ����������� ������
mov byte ptr [ EDX + EAX - 2 ], 0 ; ������ ������������ ���� � ����� ������,
                                  ; ��� ���� ��������� 2 �� ������ ����������
                                  ; ��� ������������ �������� � ������ 13 � 10
                                  ; � ����� ������, ���������� � ����� �����
                                  ; ������� ������������� ������� Enter
                                  
push offset message       ; ��������� �� ������, ���������, ��������, ���:
                          ; message db "hello", 0
call lstrlen              ; ���������� ����� ������, ������������� ����,
                          ; ��� ���� ����� ������������ � �������� EAX
push NULL
push offset numberOfChars
push EAX                  ; ����������� ���������� ��������� ��������
                          ; ����������� ����� ������ ������
push offset message
push outputHandle
call WriteConsole