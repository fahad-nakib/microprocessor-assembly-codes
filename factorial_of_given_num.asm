.model small
.stack 100h
.data
    prompt db "Enter a number: $"
    result_msg db "Factorial is: $"
    num db 0
    factorial dw 1
.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov num, al

    mov ax, 1
    mov cl, num
factorial_loop:
    mul cl
    dec cl
    jnz factorial_loop
    mov factorial, ax

    mov ah, 2
    mov dl, 0Ah 
    int 21h
    mov dl, 0Dh 
    int 21h

    lea dx, result_msg
    mov ah, 09h
    int 21h

    mov ax, factorial
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
