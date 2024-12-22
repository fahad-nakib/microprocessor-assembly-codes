.MODEL SMALL
.STACK 100H

.DATA
ARRAY DB 2, 0, 4, 7, 1, 9, '$'  ; Input array
LENGTH_ARR DW 6 
ODD_LABEL DB 'ODD Digits: $'
EVEN_LABEL DB 'EVEN Digits: $'
NEWLINE DB 0DH, 0AH, '$'

.CODE
; Macro to process the array
SEPARATE_ARRAY MACRO ARRAY, LENGTH_ARR
    LEA SI, ARRAY                 ; Load address of the array into SI
    MOV CX, LENGTH_ARR          ; Load array length into CX
    MOV AH, 09H

    ; Print odd digits
    LEA DX, ODD_LABEL
    INT 21H

PROCESS_ODD:
    MOV AL, [SI]                ; Load current element into AL
    INC SI                      ; Move to next element

    MOV BL, AL
    AND BL, 1                   ; Check least significant bit (odd/even check)
    CMP BL, 1
    JNE SKIP_ODD                ; If even, skip to next element
    MOV DL, AL
    ADD DL, 30H                 ; Convert to ASCII
    MOV AH, 02H
    INT 21H
SKIP_ODD:
    LOOP PROCESS_ODD            ; Repeat for all elements

    ; Print newline
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H

    ; Print even digits
    LEA SI, ARRAY                 ; Reload address of the array into SI
    MOV CX, LENGTH_ARR          ; Reload array length into CX
    LEA DX, EVEN_LABEL
    MOV AH, 09H
    INT 21H

PROCESS_EVEN:
    MOV AL, [SI]                ; Load current element into AL
    INC SI                      ; Move to next element

    MOV BL, AL
    AND BL, 1                   ; Check least significant bit (odd/even check)
    CMP BL, 0
    JNE SKIP_EVEN               ; If odd, skip to next element
    MOV DL, AL
    ADD DL, 30H                 ; Convert to ASCII
    MOV AH, 02H
    INT 21H
SKIP_EVEN:
    LOOP PROCESS_EVEN           ; Repeat for all elements

    ; Print newline
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H
ENDM

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                    ; Initialize data segment

    ; Pass array to macro
    SEPARATE_ARRAY ARRAY, LENGTH_ARR

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

END MAIN
