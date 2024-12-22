include 'emu8086.inc'
.model small 
.stack 100h
.data
   msg db 'Sum: $' 
.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov cx, 1         
    mov bx, 0          
    mov dx, 0        

    l1:
    add bx, cx        
    add cx, 2          
    inc dx             
    cmp dx, 50         
    jl l1     
    
    mov ah,9
    lea dx,msg
    int 21h 
    
    mov ax,bx
    call print_num
    
    
    Exit:
    mov ah, 4ch 
    int 21h        
    main endp 
    define_print_num
    define_print_num_uns
end main



