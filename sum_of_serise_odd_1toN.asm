;1+3+5+.....99
.MODEL SMALL

.STACK

.DATA
       
    ADDS DW ?
    
.CODE

    MAIN PROC
        
        MOV AX,@DATA 
        MOV DS,AX 
        
        MOV CX,1
        MOV AX,0
        
        
        SUM:
            ADD AX,CX
            ADD CL,2
            CMP CL,99
            MOV ADDS,AX
            
            JLE SUM
            
                        
            MOV AH,4CH   ;exit code
            INT 21H              
            
    MAIN ENDP
END MAIN
RET