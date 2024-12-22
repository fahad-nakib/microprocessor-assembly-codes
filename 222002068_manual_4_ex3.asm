.model small
.stack 100h
.data
    prompt db "Enter a number: $"
    odd_msg db "The number is odd.$"
    even_msg db "The number is even.$"
    repeat_msg db "Do you want to continue? (Y/N): $"
    num db 0
    response db 0
.code
main proc
    mov ax, @data
    mov ds, ax

main_loop:
    lea dx, prompt
    mov ah, 09h
    int 21h


    mov ah, 01h
    int 21h
    sub al, '0'
    mov num, al
    mov al, num
    and al, 1
    
    mov ah, 02h
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah 
    int 21h
    
    jz print_even
    lea dx, odd_msg
    jmp print_msg

print_even:
    lea dx, even_msg

print_msg:
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah 
    int 21h

    lea dx, repeat_msg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov response, al
    cmp response, 'N'
    je terminate
    cmp response, 'n'
    je terminate
    
    mov ah, 02h
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah 
    int 21h 
    
    jmp main_loop

terminate:
    mov ah, 4Ch
    int 21h

main endp
end main
