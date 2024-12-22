.model small
.stack 100h
.data
    prompt db "Enter a number (0 to end): $"
    odd_msg db "Sum of odd numbers: $"
    even_msg db "Sum of even numbers: $"
    newline db 0Dh, 0Ah, '$'
    num db 0
    odd_sum dw 0
    even_sum dw 0
.code
main proc
    mov ax, @data
    mov ds, ax

input_loop:
    lea dx, prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'        
    mov num, al        

    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    cmp num, 0          
    je display_result

    mov al, num        
    and al, 1           
    jz add_even        
    mov ax, odd_sum
    mov bl, num         
    add ax, bx          
    mov odd_sum, ax
    jmp input_loop

add_even:
    mov ax, even_sum
    mov bl, num         
    add ax, bx          
    mov even_sum, ax
    jmp input_loop

display_result:
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    lea dx, odd_msg
    mov ah, 09h
    int 21h

    mov ax, odd_sum
    call print_number

    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    lea dx, even_msg
    mov ah, 09h
    int 21h

    mov ax, even_sum
    call print_number

    mov ah, 4Ch
    int 21h
    main endp

print_number proc
    push ax
    xor cx, cx
    mov bx, 10
convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz convert_loop
print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits
    pop ax
    ret
print_number endp


end main
