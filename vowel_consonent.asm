
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.data 
    msg1 db 'Enter a Character : '
    msg2 db 0dh,0ah,'Character is Vowel.'
    msg3 db 0dh,0ah,'Character is Consonant.'
.code
    main proc
        mov ax,@data
        mov ds,ax
        
        mov ah,02h
        lea dx,msg1
        int 21h
        
        mov ah,01h
        INT 21H
        
        cmp al,'a'
        je vowel
        cmp al,'e'
        je vowel
        cmp al,'i'
        je vowel
        cmp al,'o'
        je vowel
        cmp al,'u'
        je vowel
        
        mov ah,09h
        lea dx,msg3
        int 21h
        jmp exit
        
     vowel:
        mov ah,09h
        lea dx,msg2
        int 21h
     exit:
        mov ah,4ch
        int 21h
     main endp
    end main



