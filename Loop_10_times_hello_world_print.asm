include 'emu8086.inc'
.stack 100h
.model small

.data

.code

    main proc
        
        mov cx,10
        
         start:
           
           print 'Hello World'
           
           mov dl,10
           mov ah,02
           int 21h
           
           mov dl,13
           mov ah,02
           int 21h
           
         loop start
     main endp

end main