.stack 100h
.model small
.data
    CHAR DB 0DH,0AH,'Enter a Character : $'
.code proc
    
    MOV AX,@DATA
    MOV DS,AX 
 
    LEA DX,CHAR
    MOV AH,9
    INT 21H 
    
    
    mov ah,1
    int 21h
    mov bl,al 
    
    mov ah,1
    int 21h
    mov cl,al
    
    cmp bl,cl
    jge gr 
        
    mov ah,2
    mov dl,0dh
    int 21h
    mov ah,2
    mov dl,0ah
    int 21h   
    
    mov ah,2
    mov dl,cl
    int 21h 
    
    mov ah,2
    mov dl,bl
    int 21h
    jmp exit:
    
   gr:
   mov ah,2
   mov dl,bl
   int 21h
   mov ah,2
   mov dl,cl
   int 21h 
   exit: