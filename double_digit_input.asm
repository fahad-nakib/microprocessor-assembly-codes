
org 100h

.model small
.data
    msg db 10,13,"Enter Two Digit Number : $"
    ;num db ?
.code
main proc
    MOV AX, @data
    MOV DS, AX
    
    MOV DX, offset msg
    MOV AH, 9
    INT 21H
    
    XOR AX, AX
    
    MOV AH, 1
    INT 21H
    
    CMP AL, 9
    JBE number:
    
    number:
    MOV AH, 1
    INT 21H
    
    

ret




