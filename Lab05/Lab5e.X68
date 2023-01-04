*-----------------------------------------------------------
* Title      : Lab5e
* Written by : Gunteshwar Soin
* Date       : 01/11/2022
* Description: An example of a subroutine to compute the 
*              average of a list of 16-bit numbers
*-----------------------------------------------------------
        
        ORG     $8000

**** Main Code *****

MAIN    PEA     LIST                 ;push pointer to list   
        MOVE.W  #LENGTH,-(A7)        ;push length of list
        BSR     AVERAGE              ;calculate average  
        LEA     6(A7),A7             ;remove arguments
        
        SIMHALT


**** Subroutine: AVERAGE(LENGTH,*LIST)  ****
*          ARG1: LENGTH at 16(A7)          *
*          ARG2: *LIST at 18(A7)           *
*   Returns average in data register D0    *
********************************************
 
AVERAGE MOVEM.L   D1/D2/A1,-(A7)      ;save working registers
        CLR.L     D2                  ;set sum to zero     
        MOVEA.L   18(A7),A1           ;initilize pointer to list
        MOVE.W    16(A7),D1           ;initiaize loop counter
LOOP    BEQ       EXIT                ;counter = 0? yes, then exit
        ADD.W     (A1)+,D2            ;no, add list item to sum
        SUB.W     #1,D1               ;decrement loop counter
        BRA       LOOP                ;do it again!
EXIT    EXT.L     D2                  ;extend sum to form dividend
        DIVS      16(A7),D2           ;compute quotient and remainder
        MOVE.W    D2,D0               ;move quotient to D0
        MOVEM.L   (A7)+,D1/D2/A1      ;restore working registers
        RTS


LIST    DC.W      147,23,-56,432,79   ;list of numbers to average
LENGTH  EQU       (*-LIST)/2          ;size of list in words
        
        END        MAIN



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
