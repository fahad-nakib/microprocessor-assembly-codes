org 100h
.data
prompt_1 db 'Enter: ', '$'
prompt_2 db 0dh, 0ah, 'Ascending: ', '$'
prompt_3 db 0dh, 0ah, 'Descending: ', '$'
array db 7 dup(0)
.code
main proc
mov ax, @data
mov ds, ax
mov ah, 9
lea dx, prompt_1
int 21h
mov cx, 7
mov bx, offset array
mov ah, 1
inputs:
int 21h
mov [bx], al
inc bx
loop inputs
main endp
ascending proc :
mov cx, 7
dec cx
outerloop:
mov bx, cx
mov si, 0
comploop:
mov al, array[si]
mov dl, array[si+1]
cmp al, dl
jc noswap
mov array[si], dl
mov array[si+1], al
noswap:
inc si
dec bx
jnz comploop
loop outerloop
mov ah, 2
mov dl,  10
int 21h
mov dl, 13
int 21h
mov ah, 9
lea dx, prompt_2
int 21h
mov cx, 7
mov bx, offset array
outputs:
mov dl, [bx]
mov ah, 2
int 21h
mov dl, 32
mov ah, 2
int 21h
inc bx
loop outputs
ascending endp
descending proc :
mov cx, 7
dec cx
outer:
mov bx, cx
mov si, 0
comp:
mov al, array[si]
mov dl, array[si+1]
cmp al, dl
jc swap
swap:
mov array[si], dl
mov array[si+1], al
inc si
dec bx
jnz comp
loop outer
mov ah, 2
mov dl, 10
int 21h
mov dl, 13
int 21h
mov ah, 9
lea dx, prompt_3
int 21h
mov cx, 7
mov bx, offset array
display:
mov dl, [bx]
mov ah, 2
int 21h
mov dl, 32
mov ah, 2
int 21h
inc bx
loop display
descending endp
end main
ret
