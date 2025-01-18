include 'emu8086.inc'
org 100h             

print "Input First value :" 
call scan_num
mov ax,cx
mov bx,ax  

print "Input Second value :" 
call scan_num  
sub ax,cx  

ja above:
jb below:

above:
    print "The Largest Number is : "
    mov ax,bx   
    call print_num 
exit_above:   
ret 

below:
    print "The Largest Number is : "   
    mov ax,cx
    call print_num 
exit_below:
ret 

define_scan_num
define_print_num
define_print_num_uns 

end






