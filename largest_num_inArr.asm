.MODEL SMALL
.STACK 100H
.DATA
MAX_NUM DB 00H
INPUT_MSG DB 'ENTER YOUR ARRAY OF ELEMENTS: $'
OUTPUT_MSG DB 'LARGEST NUMBER IS: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    ;MOV ES, AX
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    MOV AH, 1
    MOV SI, 0
    INPUT:
        INT 21H
        CMP AL, 0DH
        JE EXIT_INPUT
        
        CMP AL, MAX_NUM
        JLE SKIP
        MOV MAX_NUM, AL
        
        SKIP:
        INC SI
        JMP INPUT
    EXIT_INPUT:
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, MAX_NUM
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN
