
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV DL, 10
MOV BL, 0

scanNum:
    MOV AH, 1H
    INT 21H
    
    CMP AL, 13 ; if userr prace ENTER KEY the exit
    JE exit
    
    MOV AH, 0
    SUB AL, '0'
    
    MOV CL, AL
    MOV AL, BL
    MUL DL
    
    ADD AL, CL
    MOV BL, AL
    
    JMP scanNum
exit:
    MOV AH, 04CH
    INT 21H
ret




