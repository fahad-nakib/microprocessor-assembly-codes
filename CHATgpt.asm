.MODEL SMALL
.STACK 100H
.DATA       

;DECLARED STRINGS
INTRO DB '*************************SHOPPING MANAGEMENT SYSTEM*****************************$',10,13
INTRO2 DB '         ****************        COA PROJECT 2.0      *************** $',10,13
                              
ENTER DB 10,13,'PLEASE ENTER THE KEYS WHAT YOU WANT TO BUY OR SEARCH BY ITEM NAME (S): $'
SEARCH_PROMPT DB 10,13,'PLEASE ENTER THE ITEM NAME TO SEARCH: $'

INFO DB 10,13,'KEYS         ITEMS               PRICE$'
CS_MALE DB 10,13,' 1    CASUAL SHIRT(MALE)        150 USD $'                    
FS_MALE DB 10,13,' 2    FORMAL SHIRT(MALE)        140 USD $'                 
PANT_MALE DB 10,13,' 3    PANT (MALE)               210 USD $'
M_SHOES DB 10,13,' 4    MALE SHOES                350 USD $'
CS_FEMALE DB 10,13,' 5    CASUAL SHIRT(FEMALE)      140 USD $'
PANT_FEMALE DB 10,13,' 6    PANT (FEMALE)             220 USD $'
F_SHOES DB 10,13,' 7    FEMALE SHOES              310 USD $'
PANJABI DB 10,13,' 8    PANJABI                   180 USD $'
KURTI DB 10,13,' 9    KURTI                     225 USD $'

E_QUANTITY DB 10,13,'ENTER QUANTITY: $'
AGAIN DB 10,13,'DO YOU WANT TO BUY MORE? (1.YES || 2.NO): $'
ER_MSG DB 10,13,'ERROR INPUT$'  
CHOICE DB 10,13,'ENTER YOUR CHOICE:$'    
FT DB 10,13,'TOTAL AMOUNT IS :$' 
ERR DB 0DH,0AH,'WRONG INPUT! START FROM THE BEGINNING $'   
R DB 0DH,0AH,'PRESENT AMOUNT IS : $' 
E_DISCOUNT DB 10,13,'ENTER DISCOUNT(IF NOT AVAILABLE ENTER 0 ): $' 
ERASK DB 10,13,'START FROM THE BEGINNING $'
EN_DIS DB 10,13,'AGAIN ENTER DISCOUNT: $'
A DW ?                           ;DECLARED VARIABLES
B DW ?
C DW ?
S DW 0,'$'
NL DB 0DH,0AH,'$'                ;NEW LINE

.CODE
  
     MOV AX, @DATA               
     MOV DS, AX     
     
     LEA DX,INTRO                ;PRINT INTRO STRING 
     MOV AH,9
     INT 21H
     
     LEA DX,INTRO2               ;PRINT INTRO2 STRING 
     MOV AH,9
     INT 21H      
          
     LEA DX,NL                   ;PRINT A NEW LINE
     MOV AH,9
     INT 21H       

     JMP BEGINTOP                ;DIRECTLY GO TO BEGINTOP LABEL WHERE USER WILL GIVE INPUT 

ERROR121:  
     LEA DX,ER_MSG               ;PRINT ERROR MESSAGE 
     MOV AH,9
     INT 21H 
     LEA DX,ERASK
     MOV AH,9
     INT 21H

BEGINTOP:   
     LEA DX,NL                   ;PRINT A NEW LINE
     MOV AH,9
     INT 21H
    
     MOV BL,10                   ;COLOR CODE
     MOV AH,9 
     MOV AL,0  
     INT 10H                
      
     LEA DX,INFO                 ;PRINT INFO STRING
     MOV AH,9 
     INT 21H                     

     LEA DX,ENTER                ;Prompt user to buy or search
     MOV AH,9       
     INT 21H    

     MOV AH,1                    ;Take input: 1-9 for item, or 'S' for search
     INT 21H 

     CMP AL,'S'                  ;If the user inputs 'S', jump to search section
     JE SEARCH_ITEM

     CMP AL,49                   ;If AL=1, go to CS_MALEB label
     JE CS_MALEB
     CMP AL,50                   ;If AL=2, go to FS_MALEB label
     JE FS_MALEB
     CMP AL,51                   ;If AL=3, go to PANT_MALEB label
     JE PANT_MALEB
     CMP AL,52                   ;If AL=4, go to M_SHOESB label
     JE M_SHOESB
     CMP AL,53                   ;If AL=5, go to CS_FEMALEB label
     JE CS_FEMALEB
     CMP AL,54                   ;If AL=6, go to PANT_FEMALEB label
     JE PANT_FEMALEB
     CMP AL,55                   ;If AL=7, go to F_SHOESB label
     JE F_SHOESB
     CMP AL,56                   ;If AL=8, go to PANJABIB label
     JE PANJABIB
     CMP AL,57                   ;If AL=9, go to KURTIB label
     JE KURTIB
     
     JMP ERROR121                ;If wrong key is pressed, display error

SEARCH_ITEM:   
     LEA DX,SEARCH_PROMPT        ;Prompt user for item name
     MOV AH,9
     INT 21H

     ; Example search process: Assume item names are limited to simple inputs for now
     MOV AH,1                    ;Take input of the item name (in a simple way, one char)
     INT 21H 

     CMP AL,'C'                  ;For demonstration, check if input is 'C' (Casual Shirt)
     JE SHOW_CS_MALE
     
     CMP AL,'F'                  ;Check for 'F' (Formal Shirt or Female items)
     JE SHOW_FS_MALE
     
     JMP ERROR121                ;If item not found, show error

SHOW_CS_MALE:
     LEA DX,CS_MALE              ;Display Casual Shirt details
     MOV AH,9
     INT 21H
     JMP BEGINTOP                ;Return to the top

SHOW_FS_MALE:
     LEA DX,FS_MALE              ;Display Formal Shirt details
     MOV AH,9
     INT 21H
     JMP BEGINTOP                ;Return to the top

; The rest of your code continues from here, including QUANTITY, ADD, MULTI, etc.

CS_MALEB:
MOV A,150                        ;Price of Casual Shirt Male is 150
JMP QUANTITY

FS_MALEB:
MOV A,140                        ;Price of Formal Shirt Male is 140
JMP QUANTITY 

PANT_MALEB:
MOV A,210                        ;Price of Pant Male is 210
JMP QUANTITY 

M_SHOESB: 
MOV A,350                        ;Price of Male Shoes is 350
JMP QUANTITY 

CS_FEMALEB: 
MOV A,140                        ;Price of Casual Shirt Female is 140
JMP QUANTITY 

PANT_FEMALEB:
MOV A,220                        ;Price of Pant Female is 220
JMP QUANTITY 

F_SHOESB:   
MOV A,310                        ;Price of Female Shoes is 310
JMP QUANTITY 

PANJABIB:   
MOV A,180                        ;Price of Panjabi is 180
JMP QUANTITY 

KURTIB:      
MOV A,225                        ;Price of Kurti is 225
JMP QUANTITY 

; Continue with the rest of the existing code

QUANTITY:  

    MOV BL,6 
    MOV AH,9                     ;COLOR CODE
    MOV AL,0  
    INT 10H

    LEA DX,E_QUANTITY            ;PRINT ENTER QUANTITY STRING
    MOV AH,9
    INT 21H 
    
    JMP MULTI           ;PROGRAM WILL GO TO MULTI LEBEL WHERE THE PRICE WILL BE MILTIPLIED WITH THE AMOUNT


ASK: 

    MOV BL,1                     ;COLOR  CODE
    MOV AH,9 
    MOV AL,0  
    INT 10H
    
    LEA DX,AGAIN                 ;PRINT AGAIN IF USER WANTS TO BUY MORE
    MOV AH,9
    INT 21H 
    
    MOV AH,1                     ;TAKES THE INPUT OF YES OR NO
    INT 21H
    
    CMP AL,49                    ;IF YES, THEN AGAIN GO TO SHOPLIST MENU AND BUY AGAIN
    JE BEGINTOP
    
    CMP AL,50
    JE OUTPUT2                   ;IF NO, PROGRAM WILL GIVE THE TOTAL OUTPUT
    
    LEA DX,ER_MSG
    MOV AH,9                     ;IF ANY WRONG INPUT, PRINT ERROR MESSAGE AND AGAIN ASK TO BUY AGAIN
    INT 21H
    
    JMP ASK                      
    


ERROR:
    
    LEA DX,ER_MSG                ;PRINT ERROR MESSAGE 
    MOV AH,9
    INT 21H
    
    JMP QUANTITY                 ;JUMP TO QUANTITY LEBEL
    
ER_DISCOUNT:   

    LEA DX,ER_MSG                ;DURING DISCOUNT INPUT IF WRONG INPUT IS PRESSES ERROR MESSSAGE WILL SHOW
    MOV AH,9
    INT 21H
    
    LEA DX,NL                    ;PRINT NEW LINE
    MOV AH,9
    INT 21H
    
    LEA DX,EN_DIS                ;PRINT AGAIN INPUT DISCOUNT VALUE 
    MOV AH,9
    INT 21H
    
    JMP INPUT_SUB                ;DIRECLTY JUMP TO INPUT OF DISCOUNT 
    
    
MULTI:         

    MOV BL,4                       ;COLOR CODE
    MOV AH,9 
    MOV AL,0  
    INT 10H    

INDEC3 PROC                        ;INDEC3 IS FOR TAKING INPUT FOR MULTIPLY WITH THE GIVEN AMOUNT
    
    PUSH BX                        ;TAKE VALUES INTO STACK 
    PUSH CX
    PUSH DX

    
    
    XOR BX,BX                       ;HOLDS TOTAL
    
    XOR CX,CX                       ;SIGN
                    
    
    MOV AH,1                        ;TAKE CHARACTER IN AL
    INT 21H


    
    REPEAT4: 
                                     
    CMP AL,48                       ;IF AL<0, PRINT ERROR MESSAGE
    JL ERROR
    
    CMP AL,57                       ;IF AL>9, PRINT ERRIR MESSAGE 
    JG ERROR


    AND AX,00FH                     ;CONVERT TO DIGIT
    PUSH AX                         ;SAVE ON STACK
    
    MOV AX,10                       ;GET 10
    MUL BX                          ;AX=TOTAL * 10
    POP BX                          ;GET DIGIT BACK
    ADD BX,AX                       ;TOTAL = TOTAL X 10 +DIGIT
    
    
    MOV AH,1
    INT 21H
    
    CMP AL,0DH                      ;CARRIAGE RETURN
    JNE REPEAT4                     ;IF NO CARRIEGE RETURN THEN MOVE ON
    
    MOV AX,BX                       ;STORE IN AX
    
    
    JMP MUL_
    
    POP DX                          ;RESTORE REGISTERS
    POP CX
    POP BX
    RET                             ;AND RETURN
    
    

INDEC3 ENDP                         ;END OF INDEC3 

ADD_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX  
    
    MOV BL,4                         ;COLOR CODE
    MOV AH,9 
    MOV AL,0  
    INT 10H 
    
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,B                         ;MOV B TO AX
    ADD A,AX                         ;ADD A WITH AX
    
    
    MOV AX,A                         ;MOV A TO AX
    
    PUSH AX                          ;TAKE AX INTO STACK
    
    
    JMP END

SUB_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX 
    
    LEA DX,R                         ;PRINT PRESENT AMOUNT STRING
    MOV AH,9
    INT 21H
    
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,B                         ;MOV B TO AX
    SUB A,AX                         ;SUBSTRACT AX FROM A
    
    
    MOV AX,A                         ;MOV A TO AX
    
    PUSH AX  
    
    ADD S,AX
    
    JMP OUTPUT

MUL_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX             
    
    MOV BL,4
    MOV AH,9                         ;COLOR CODE
    MOV AL,0  
    INT 10H 
    
    LEA DX,E_DISCOUNT                ;PRINT ENTER DISCOUNT STRING
    MOV AH,9
    INT 21H
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,B
    
    MUL A                            ;MULTIPLY A WITH AX
    
    
    PUSH AX                          ;TAKE AX INTO STACK
    
    MOV A,AX 
   
                                     
    JMP INPUT_SUB                    ;JUMP TO INP1UT_SUB
    
    
    
    JMP OUTPUT 
                                          
INPUT_ADD: 

INDEC1 PROC                          ;INDEC PROC1 IS FOR ADDING THE PRESENT AMOUNTS INTO TOTAL 
    
    PUSH BX                          ;TAKE THE VALUES IN STACK
    PUSH CX
    PUSH DX
    
        
    BEGIN1:
    
    
    XOR BX,BX                        ;HOLDS TOTAL
    
    XOR CX,CX                        ;SIGN
                    
    
    MOV AH,1                         ;TAKE CHARACTER IN AL
    INT 21H

    
    REPEAT2: 
                                     ;IF AL<0, PRINT ERROR MESSAGE
    CMP AL,48
    JL ERROR
    
    CMP AL,57                        ;IF AL>9, PRINT ERROR MESSAGE
    JG ERROR


    AND AX,00FH                      ;CONVERT TO DIGIT
    PUSH AX                          ;SAVE ON STACK
    
    MOV AX,10                        ;GET 10
    MUL BX                           ;AX=TOTAL * 10
    POP BX                           ;GET DIGIT BACK
    ADD BX,AX                        ;TOTAL = TOTAL X 10 +DIGIT
    
    
    MOV AH,1                         ;TAKE VALUE INTO AL
    INT 21H
    
    CMP AL,0DH                       ;CARRIAGE RETURN
    JNE REPEAT2                      ;NO KEEP GOING
    
    MOV AX,BX                        ;STORE IN AX
                         
    
    JMP ADD_                         ;JUMP TO ADD_ TO STORE THE TOTAL VALUE
    
    POP DX                           ;RESTORE REGISTERS
    POP CX
    POP BX
    RET                              ;AND RETURN
    
    

INDEC1 ENDP   

INPUT_SUB: 

INDEC2 PROC
    
    PUSH BX                          ;SAVE TO STACK 
    PUSH CX
    PUSH DX
    
    
    
    XOR BX,BX                        ;HOLDS TOTAL
    
    XOR CX,CX                        ;SIGN
                    

    MOV AH,1                         ;CHAR IN AL
    INT 21H
    
    
    
    REPEAT3: 
    
    CMP AL,48                        ;IF AL<0, PRINT ERROR MESSAGE 
    JL ER_DISCOUNT
    
    CMP AL,57                        ;IF AL>9, PRINT ERROR MESSAGE 
    JG ER_DISCOUNT


    AND AX,00FH                      ;CONVERT TO DIGIT
    PUSH AX                          ;SAVE ON STACK
    
    MOV AX,10                        ;GET 10
    MUL BX                           ;AX=TOTAL * 10
    POP BX                           ;GET DIGIT BACK
    ADD BX,AX                        ;TOTAL = TOTAL X 10 +DIGIT
    
    
    MOV AH,1
    INT 21H
    
    CMP AL,0DH                       ;CARRIAGE RETURN
    JNE REPEAT3                      ;NO KEEP GOING
    
    MOV AX,BX                        ;STORE IN AX
    
    OR CX,CX                         ;NEG NUM
    
    
    JMP SUB_

    POP DX                           ;RESTORE REGISTERS
    POP CX
    POP BX
    RET                              ;AND RETURN
                            


INDEC2 ENDP 
    
OUTPUT:         

;OUTDEC PROC IS FOR GIVING THE OUTPUT OF THE PRESENT AMOUNT

OUTDEC PROC
    
    
    PUSH AX                          ;SAVE REGISTERS
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR CX,CX                        ;CX COUNTS DIGITS
    MOV BX,10D                       ;BX HAS DIVISOR
    
    REPEAT1:
    
    XOR DX,DX                        ;PREP HIGH WORD
    DIV BX                           ;AX = QUOTIENT, DX=REMAINDER
    
    PUSH DX                          ;SAVE REMAINDER ON STACK
    INC CX                           ;COUNT = COUNT +1
    
    OR AX,AX                         ;QUOTIENT = 0?
    JNE REPEAT1                      ;NO, KEEP GOING
    
    MOV AH,2                         ;PRINT CHAR FUNCTION
    
    PRINT_LOOP:
    
    POP DX                           ;DIGIT IN DL
    OR DL,30H                        ;CONVERT TO CHAR
    INT 21H                          ;PRINT DIGIT
    LOOP PRINT_LOOP                  ;LOOP UNTILL DONE
    
    POP DX
    POP CX                           ;RESTORE REGISTERS
    POP BX
    POP AX 
    
    JMP ASK
    
    RET
    OUTDEC ENDP 

OUTPUT2: 

    LEA DX,FT                        ;PRINT FINAL TOTAL
    MOV AH,9
    INT 21H
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,S                         ;SET AX INTO 0
    
    
    ;OUTDEC2 IS FOR GIVING THE TOTAL OUTPUT OF THE AMOUNT
    
                                     
OUTDEC2 PROC
    
    
    PUSH AX                          ;SAVE REGISTERS
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX,CX                        ;CX COUNTS DIGITS
    MOV BX,10D                       ;BX HAS DIVISOR
    
    REPEAT12:
    
    XOR DX,DX                        ;PREP HIGH WORD
    DIV BX                           ;AX = QUOTIENT, DX=REMAINDER
    
    PUSH DX                          ;SAVE REMAINDER ON STACK
    INC CX                           ;COUNT = COUNT +1
    
    OR AX,AX                         ;QUOTIENT = 0?
    JNE REPEAT12                     ;NO, KEEP GOING
    
    MOV AH,2                         ;PRINT CHAR FUNCTION
    
    PRINT_LOOP2:
    
    POP DX                           ;DIGIT IN DL
    OR DL,30H                        ;CONVERT TO CHAR
    INT 21H                          ;PRINT DIGIT
    LOOP PRINT_LOOP2                 ;LOOP UNTILL DONE
    
    POP DX
    POP CX                           ;RESTORE REGISTERS
    POP BX
    POP AX 
    

    OUTDEC2 ENDP 
 

     
END:
MOV AH, 4CH                  
INT 21H