.MODEL SMALL
.STACK 100H

.DATA
ARRAY DB 3, 1, 4, 5, 1, 6, 8, 7  ; Input array
LENGTH DW 8                      ; Length of the array
SUM_ODD DW 0                     ; To store sum of odd digits
SUM_EVEN DW 0                    ; To store sum of even digits

.CODE
    ; Macro to process the array
    PROCESS_ARRAY MACRO ARR, LEN
        LEA SI, ARR                 ; Load address of the array into SI
        MOV CX, LEN                 ; Load array length into CX
        XOR AX, AX
        XOR BX, BX                  ; Initialize sum of odd digits
        XOR DX, DX                  ; Initialize sum of even digits

        MOV SUM_ODD, BX
        MOV SUM_EVEN, DX

    PROCESS_LOOP:
        MOV AL, [SI]                ; Load current element into AL
        INC SI                      ; Move to next element

        ; Check if number is odd or even
        MOV AH, 0
        MOV BL, AL
        AND BL, 1                   ; Check least significant bit (odd/even check)
        CMP BL, 0
        JE ADD_TO_EVEN              ; If even, jump to ADD_TO_EVEN
        ADD_ODD AX                  ; Add to sum of odd digits
        JMP NEXT_ITERATION

    ADD_TO_EVEN:
        ADD_EVEN AX                 ; Add to sum of even digits

    NEXT_ITERATION:
        LOOP PROCESS_LOOP            ; Repeat for all elements

        ; Store results in variables
        MOV [SUM_ODD], BX
        MOV [SUM_EVEN], DX
    ENDM

    ; Macro to add to odd sum
    ADD_ODD MACRO VAL
        ADD BX, VAL
    ENDM

    ; Macro to add to even sum
    ADD_EVEN MACRO VAL
        ADD DX, VAL
    ENDM

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                    ; Initialize data segment

    ; Pass array and length to macro
    PROCESS_ARRAY ARRAY, LENGTH

    ; Display results
    MOV AX, SUM_ODD
    CALL PRINT_RESULT             ; Print sum of odd digits

    MOV AX, SUM_EVEN
    CALL PRINT_RESULT             ; Print sum of even digits

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Subroutine to print the result
PRINT_RESULT PROC
    ; Convert result to ASCII and display
    MOV DX, AX                    ; Load value to print into DX
    MOV BX, 10                    ; Base 10 for division
    XOR CX, CX                    ; Clear CX (stores digits)
    
CONVERT_LOOP:
    XOR DX, DX                    ; Clear DX for division
    DIV BX                        ; Divide AX by 10 (result in AX, remainder in DX)
    PUSH DX                       ; Push remainder onto stack
    INC CX                        ; Increment digit count
    CMP AX, 0                     ; Check if number is fully processed
    JNE CONVERT_LOOP              ; Repeat if AX > 0

PRINT_DIGITS:
    POP DX                        ; Pop digit from stack
    ADD DL, 30H                   ; Convert to ASCII
    MOV AH, 2                     ; DOS interrupt to print character
    INT 21H
    LOOP PRINT_DIGITS             ; Print all digits

    ; Print newline
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H

    RET
PRINT_RESULT ENDP

END MAIN
