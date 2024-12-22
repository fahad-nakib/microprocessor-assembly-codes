;1+2+3+.....N
.MODEL SMALL

.STACK

.DATA
              ;initialize number where to start.
    I DW 1
    ADDS DW ? ;variable for store the result of sum.     

.CODE

    MAIN PROC
        
        MOV AX,@DATA 
        MOV DS,AX
        
        MOV AH,01H  ;taking user input
        INT 21H  
        
        SUB AL,48   ;sub 48 for getting the original value of user input
        
        MOV CX,0    ;clear counter
        MOV CL,AL   ;set counter
        
        MOV BX,0    ;clear result resister
        
        SUM:
            ADD BX,I
            INC I
            LOOP SUM
            
            MOV ADDS, BX
            
    MAIN ENDP
END MAIN
RET