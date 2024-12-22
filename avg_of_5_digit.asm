.MODEL SMALL
.STACK 100H

.DATA
PROMPT1 DB 'Enter 5 decimal digits (0-9): $'
PROMPT2 DB 13, 10, 'Average: $'
PROMPT3 DB 13, 10, 'Largest: $'
PROMPT4 DB 13, 10, 'Smallest: $'
DIGITS DB 5 DUP(0)     ; Array to store the digits
AVERAGE DB 0
LARGEST DB 0
SMALLEST DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    ; Prompt user to enter 5 digits
    LEA DX, PROMPT1
    MOV AH, 09H
    INT 21H

    ; Read 5 digits
    MOV CX, 5
    LEA DI, DIGITS
READ_LOOP:
    MOV AH, 01H
    INT 21H
    SUB AL, '0'             ; Convert ASCII to decimal
    MOV [DI], AL
    INC DI
    LOOP READ_LOOP

    ; Call procedures
    CALL CALC_LARGEST
    CALL CALC_SMALLEST
    CALL CALC_AVERAGE

    ; Display results
    LEA DX, PROMPT2
    MOV AH, 09H
    INT 21H
    MOV AL, AVERAGE
    CALL PRINT_DECIMAL

    LEA DX, PROMPT3
    MOV AH, 09H
    INT 21H
    MOV AL, LARGEST
    CALL PRINT_DECIMAL

    LEA DX, PROMPT4
    MOV AH, 09H
    INT 21H
    MOV AL, SMALLEST
    CALL PRINT_DECIMAL

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Procedure to calculate the largest digit
CALC_LARGEST PROC
    MOV CX, 5
    LEA SI, DIGITS
    MOV AL, [SI]
    MOV LARGEST, AL
    INC SI
    DEC CX
LARGEST_LOOP:
    MOV AL, [SI]
    CMP AL, LARGEST
    JLE CONT_LARGEST
    MOV LARGEST, AL
CONT_LARGEST:
    INC SI
    LOOP LARGEST_LOOP
    RET
CALC_LARGEST ENDP

; Procedure to calculate the smallest digit
CALC_SMALLEST PROC
    MOV CX, 5
    LEA SI, DIGITS
    MOV AL, [SI]
    MOV SMALLEST, AL
    INC SI
    DEC CX
SMALLEST_LOOP:
    MOV AL, [SI]
    CMP AL, SMALLEST
    JGE CONT_SMALLEST
    MOV SMALLEST, AL
CONT_SMALLEST:
    INC SI
    LOOP SMALLEST_LOOP
    RET
CALC_SMALLEST ENDP

; Procedure to calculate the average digit
CALC_AVERAGE PROC
    MOV CX, 5
    LEA SI, DIGITS
    XOR AX, AX
    XOR BX, BX

AVERAGE_LOOP:
    MOV AL, [SI]
    ADD BX, AX
    INC SI
    LOOP AVERAGE_LOOP

    MOV AX, BX
    MOV CL, 5
    DIV CL
    MOV AVERAGE, AL
    RET
CALC_AVERAGE ENDP

; Procedure to print a decimal value
PRINT_DECIMAL PROC
    ADD AL, '0'             ; Convert decimal to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    RET
PRINT_DECIMAL ENDP

END MAIN
