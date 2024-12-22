;;1+2+3+....+9
.MODEL SMALL

.STACK

.DATA
    
    I DW 1
    ADDs DW ?
    
.CODE

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        MOV CX,100
        MOV BX,0
        
        SUM:
            ADD BX,I
            INC I
            LOOP SUM
            
        MOV ADDS,BX    
            
    MAIN ENDP
END MAIN
RET