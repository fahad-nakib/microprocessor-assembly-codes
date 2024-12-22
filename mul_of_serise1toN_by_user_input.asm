.data
    result db 1  ; initializing result to 1



_start:
    mov ecx, 5    ; setting counter to 5

factorial:
    mul byte [result]  ; result = result * counter
    loop factorial    ; decrement counter and loop if not zero

    ; printing the result (for simplicity, assume it's an integer between 0-9)
    add byte [result], 48  ; convert to ASCII
    mov eax, 4            ; sys_write
    mov ebx, 1            ; file descriptor (stdout)
    mov ecx, result       ; pointer to result
    mov edx, 1            ; number of bytes to write
    int 0x80              ; call kernel

    ; exiting the program
    mov eax, 1            ; sys_exit
    xor ebx, ebx          ; exit code 0
    int 0x80              ; call kernel
