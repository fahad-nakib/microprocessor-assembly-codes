include 'emu8086.inc'
org 100h             

print "Enter a number :" 
call scan_num
mov ax,cx 

cmp cx,0h
jg above
jl below
je zero

above:
    print "The Number is Positive_ " 
    call print_num 
exit_above:   
ret 

below:
    print "The Number is Negative_ "   
    call print_num 
exit_below:
ret

zero:
    print "The Number is Zero_ "   
    call print_num 
exit_zero:
ret 

define_scan_num
define_print_num
define_print_num_uns 

end






