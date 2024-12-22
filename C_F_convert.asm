include 'emu8086.inc'
org 100h             

print "Input Celsius value :"; 
call scan_num ; 

mov ax,n
mul cx
mov bx,m
div bx
add ax,r 
sub ax,1
   
print "Fahrenheit temperature result: "   
call print_num    

ret

define_scan_num
r dw 32
m dw 5
n dw 9 

define_print_num
define_print_num_uns 

end




