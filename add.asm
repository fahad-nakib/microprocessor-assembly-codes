org 100h

; Printing A
MOV AH, 2
MOV DL, 'A'
INT 21H

; Taking input for A
MOV AH, 1 
INT 21H
SUB AL, '0'
MOV BL, AL  

; Printing B
MOV AH, 2
MOV DL, 'B'
INT 21H

; Taking input for B
MOV AH, 1 
INT 21H
SUB AL, '0'
MOV CL, AL

; Printing Result (R) Addition
MOV AH, 2
MOV DL, 'R'
INT 21H

MOV AL, BL
ADD AL, CL
MOV DL, AL
ADD DL, '0'
MOV AH, 2
INT 21H

; Printing Result (R) Subtraction
MOV AH, 2
MOV DL, 'R'
INT 21H

MOV AL, BL
SUB AL, CL
MOV DL, AL
ADD DL, '0'
MOV AH, 2
INT 21H

; Printing Result (R) Multiplication
MOV AH, 2
MOV DL, 'R'
INT 21H

MOV AX, BX
MUL CL
MOV DX, AX
ADD DX, '0'
MOV AH, 2
INT 21H

; Printing Result (R) Division
MOV AH, 2
MOV DL, 'R'
INT 21H


XOR AX, AX
MOV AL, BL
DIV CL
MOV DL, AL
ADD DL, '0'
MOV AH, 2
INT 21H
  
ret    