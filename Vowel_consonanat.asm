 org 100h
.data
msg1 db 'capital Letter$'
msg2 db 'digital$'
msg3 db 'Small letter$'
value db 'Enter Something : $'

.code

main proc 
    
mov ah, 09h
lea dx, value
int 21h    

;input

mov ah, 01h
int 21h

mov bl, al   ; move A to bl register


cmp bl, 30h  ; compare bl with ascii value of 01
jge print    ; if greater or equal jump to label print

print:       ; label print

cmp bl, 39h  ; compare bl with ascii value of 09
jle print1   ; if less or equal jump to label print1
jg end       ; if greater or equal jump to label print



print1:  

; new line

mov ah, 02h    
mov dl, 0Ah    
int 21h        
mov dl ,0Dh    
int 21h        
       

mov ax, @data
mov ds, ax
mov ah, 09h
lea dx, msg2
int 21h
ret

end:

cmp bl, 41h
jge print2

print2:  

; new line

mov ah, 02h    
mov dl, 0Ah    
int 21h        
mov dl ,0Dh    
int 21h
       

cmp bl, 5Ah
jle print3
jge end1

print3:   

; new line

mov ah, 02h    
mov dl, 0Ah    
int 21h        
mov dl ,0Dh    
int 21h
       

mov ax, @data
mov ds, ax
mov ah, 09h
lea dx, msg1
int 21h
ret

end1:
mov ax, @data
mov ds, ax
mov ah, 09h
lea dx, msg3
int 21h
ret


     
main endp
endp