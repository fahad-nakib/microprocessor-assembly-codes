.DATA
    prompt_hex db "Enter a hexadecimal digit (0-9, A-F): ", 0
    error_msg  db "Invalid input! Please try again.", 0
    result_msg db "The decimal equivalent is: ", 0
    cont_msg   db "Do you want to continue? (Y/N): ", 0
    new_line   db 0Dh, 0Ah, 0
    user_input db ?
    cont_input db ?

.CODE
main PROC
    ; Set up the console
    MOV  AH, 09h           ; DOS interrupt for displaying string
    LEA  DX, prompt_hex     ; Load the address of prompt message
    INT  21h               ; Interrupt to display the message
    
get_hex_input:
    ; Get user input
    MOV AH, 01h            ; DOS interrupt for single character input
    INT 21h
    MOV user_input, AL      ; Store the input character

    ; Check if the input is a valid hex digit (0-9, A-F)
    CALL validate_input     ; Call validation function
    CMP AL, 0               ; Check if invalid
    JE invalid_input        ; Jump if invalid

    ; Convert and display the result
    CALL hex_to_dec         ; Call the conversion function
    MOV AH, 09h
    LEA DX, result_msg      ; Load result message
    INT 21h
    CALL display_dec        ; Call function to display the decimal value

    ; Ask if the user wants to continue
    MOV AH, 09h
    LEA DX, cont_msg
    INT 21h
    MOV AH, 01h
    INT 21h                 ; Get user response (Y/N)
    MOV cont_input, AL
    CMP AL, 'Y'
    JE main
    CMP AL, 'N'
    JE exit_program
    JMP get_hex_input       ; If anything else, ask again

invalid_input:
    ; Display error message for invalid input
    MOV AH, 09h
    LEA DX, error_msg
    INT 21h
    JMP main                ; Retry after invalid input

hex_to_dec PROC
    ; Convert valid hexadecimal input to decimal
    MOV AL, user_input
    CMP AL, '0'
    JB invalid_input        ; Jump if input is less than '0'
    CMP AL, '9'
    JBE from_digit          ; If AL <= '9', it's a number

    ; Handle A-F input
    CMP AL, 'A'
    JB invalid_input        ; Jump if less than 'A'
    CMP AL, 'F'
    JA invalid_input        ; Jump if greater than 'F'
    SUB AL, 37h             ; Convert A-F to 10-15
    RET

from_digit:
    SUB AL, 30h             ; Convert '0'-'9' to 0-9
    RET

hex_to_dec ENDP

display_dec PROC
    ; Convert the value in AL (decimal) to displayable ASCII
    ADD AL, 30h             ; Convert the decimal value to ASCII
    MOV DL, AL
    MOV AH, 02h             ; DOS interrupt for displaying a single char
    INT 21h
    MOV AH, 09h
    LEA DX, new_line
    INT 21h
    RET
display_dec ENDP

validate_input PROC
    ; Validate if the input is a valid hexadecimal character
    MOV AL, user_input
    CMP AL, '0'
    JB invalid               ; If less than '0', invalid
    CMP AL, '9'
    JBE valid                ; If between '0'-'9', valid
    CMP AL, 'A'
    JB invalid               ; If less than 'A', invalid
    CMP AL, 'F'
    JBE valid                ; If between 'A'-'F', valid
invalid:
    MOV AL, 0                ; Set AL to 0 for invalid input
    RET
valid:
    MOV AL, 1                ; Set AL to 1 for valid input
    RET
validate_input ENDP

exit_program:
    MOV AH, 4Ch              ; DOS interrupt to exit
    INT 21h
;main ENDP
END main
