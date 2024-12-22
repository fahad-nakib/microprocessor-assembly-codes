ORG 256

  ;prompt     
  mov ah, 9
  lea dx, msg_in
  int 21h
  
  ;input 
  xor cx, cx
INPUT:
  mov ah, 1
  int 21h
  cmp al, 13
  je BR_INPUT 
  xor ah, ah
  push ax
  inc cx
  jmp INPUT

BR_INPUT: 
  ;check for empty input
  cmp cx, 0
  je PRINT
  
  ;process second stack
  mov bx, 8000h         ;50h
  
REVERSE:
  pop dx
  xchg bx, sp
  push dx
  xchg bx, sp
  loop REVERSE
  
  ;print   
PRINT:
  mov ah, 9
  lea dx, msg_out
  int 21h
  xchg bx, sp
  mov ah, 2
  
WHILE:
  ; Skip leading whitespace
  cmp  sp, 8000h
  jae  BR_WHILE
  pop  dx
  cmp  dl, " "
  je   WHILE
  push dx

  xor cx, cx  
WORD: 
  cmp  sp, 8000h
  jae  BR_WORD
  pop  dx
  cmp  dl, " "
  je   BR_WORD
  xchg bx, sp
  push dx
  inc  cx
  xchg bx, sp
  jmp  WORD

BR_WORD:
  xchg bx, sp

PRINT_WORD:    
  pop dx
  int 21h
  loop PRINT_WORD
  xchg bx, sp
    
  cmp sp, 8000h
  jae BR_WHILE
  mov dl, " "
  int 21h 
  jmp WHILE
    
BR_WHILE:   
  ;exit
  mov ax, 4C00h
  int 21h


msg_in:  db "Enter a text: $"
msg_out: db 10, 13, "Each word reversed: $"