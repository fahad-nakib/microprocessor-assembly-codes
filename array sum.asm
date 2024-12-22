.MODEL SMALL
.STACK 100H
.DATA
ARRAY DB 3, 1, 4, 5, 1, 6, 8, 7  ; Input array
LENGTH DW 8                      ; Length of the array
SUM_ODD DW 0                     ; To store sum of odd digits
SUM_EVEN DW 0                    ; To store sum of even digits

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                    ; Initialize data segment

    LEA SI, ARRAY                 ; Load address of the array into SI
    MOV CX, LENGTH                ; Load array length into CX

    ; Initialize sums to 0
    MOV AX, 0
    MOV SUM_ODD, AX
    MOV SUM_EVEN, AX

PROCESS_ARRAY:                    ; Loop to process the array
    MOV AL, [SI]                  ; Load current element into AL
    INC SI                        ; Move to next element

    ; Check if number is odd or even
    MOV AH, 0
    MOV BL, AL
    AND BL, 1                     ; Check least significant bit (odd/even check)
    CMP BL, 0
    JE ADD_TO_EVEN                ; If even, jump to ADD_TO_EVEN
    ADD SUM_ODD, AX          ; Add to SUM_ODD using macro
    JMP NEXT_ELEMENT

ADD_TO_EVEN:
    ADD SUM_EVEN, AX         ; Add to SUM_EVEN using macro

NEXT_ELEMENT:
    LOOP PROCESS_ARRAY            ; Repeat for all elements

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
