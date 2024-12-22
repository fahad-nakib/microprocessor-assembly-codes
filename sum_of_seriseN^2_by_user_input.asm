.MODEL SMALL

.STACK

.DATA
    I DB 1
    ADDS DW ?

.CODE

    MAIN PROC
        
        MOV AX,@DATA
        MOV DS,AX
        
        MOV AH,01H
        INT 21H
        SUB AL,48
        
        MOV CX,0
        MOV CL,AL
        
        MOV BX,0
        
        MOV AX,0
        
        SUM:
            MOV AL,I
            MUL AL
            ADD BX,AX
            INC I
            LOOP SUM
            
            MOV ADDS,BX
            
    MAIN ENDP 
    
    ;DEFINE_SCAN_NUM
END MAIN
RET