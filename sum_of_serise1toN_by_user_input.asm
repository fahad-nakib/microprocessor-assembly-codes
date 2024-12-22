include 'emu8086.inc'
org 100h

.MODEL SMALL

.STACK

.DATA
              
    I DW 1    ;initialize number where to start.
    ADDS DW ? ;variable for store the result of sum.     

.CODE

    MAIN PROC 
                
        MOV AX,@DATA 
        MOV DS,AX
                
        MOV CX,0    ;clear counter   
        
        PRINT "Enter a number:"  
        CALL SCAN_NUM;
        
        
        MOV BX,0    ;clear result resister 
        
        
        SUM:
            ADD BX,I
            INC I
            LOOP SUM
            
            MOV ADDS, BX     
            
    MAIN ENDP
    
    DEFINE_SCAN_NUM
END MAIN
RET








