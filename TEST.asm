section.data
    menu db 0       ; variable for menu input
    message db 'Pharmacy Management System', 0 ; strings for output
    thank_you db 'Thank you', 0

section.text
    global_start

_start:
    ; System color change command (system("COLOR 0");) would be done via system calls
    ; For simplicity, we omit this in assembly.

main_menu:
    ; Display main menu
    mov edx, len_message  ; length of the message
    mov ecx, message      ; message to display
    mov ebx, 1            ; file descriptor (stdout)
    mov eax, 4            ; syscall number (sys_write)
    int 0x80              ; call kernel
    
    ; Get user input for menu choice
    ; Use syscall to read input (simplified)
    mov eax, 3           ; syscall read
    mov ebx, 0           ; stdin
    mov ecx, menu        ; where to store input
    mov edx, 1           ; read 1 byte
    int 0x80

    ; Evaluate input (switch-case like in C++)
    cmp byte [menu], '1'
    je take_order
    cmp byte [menu], '2'
    je delete_order
    cmp byte [menu], '6'
    je exit_program

    ; Default case: invalid input, re-display menu
    jmp main_menu

take_order:
    ; Call the take_order function
    call take_order_asm
    jmp main_menu

delete_order:
    ; Call delete_order function
    call delete_order_asm
    jmp main_menu

exit_program:
    ; Display thank you message and exit
    mov edx, len_thank_you
    mov ecx, thank_you
    mov ebx, 1
    mov eax, 4
    int 0x80              ; call kernel
    
    ; Exit the program
    mov eax, 1            ; syscall number (sys_exit)
    xor ebx, ebx          ; return 0
    int 0x80
