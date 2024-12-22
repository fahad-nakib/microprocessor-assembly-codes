include 'emu8086.inc'
org 100h             

print "Input value :"; 
call scan_num ; 

mov ax,cx
mov bx,5
div bx

cmp dx,0
je divisible

print "The number is not divisible by 5"
ret

divisible:
    print "The number is divisible by 5"   
exit_divisible:   
ret

define_scan_num
 
end
