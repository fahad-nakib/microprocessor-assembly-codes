
    num1 dw 6  ; First number (6)
    num2 dw 2  ; Second number (2)
    result dw 0  ; Variable to store result


    ; Load the first number into AX
    mov ax, [num1]
    
    ; Addition
    add ax, [num2]  ; AX = AX + num2 (6 + 2 = 8)
    mov [result], ax  ; Store the result of addition in 'result'
    
    ; Subtraction
    mov ax, [num1]  ; Reload num1 into AX
    sub ax, [num2]  ; AX = AX - num2 (6 - 2 = 4)
    mov [result], ax  ; Store the result of subtraction in 'result'
    
    ; Multiplication
    mov ax, [num1]  ; Reload num1 into AX
    mov bx, [num2]  ; Load num2 into BX
    mul bx  ; AX = AX * BX (6 * 2 = 12)
    mov [result], ax  ; Store the result of multiplication in 'result'
    
    ; Division
    mov ax, [num1]  ; Reload num1 into AX
    mov bx, [num2]  ; Load num2 into BX
    xor dx, dx  ; Clear DX for division
    div bx  ; AX = AX / BX (6 / 2 = 3)
    mov [result], ax  ; Store the result of division in 'result'
