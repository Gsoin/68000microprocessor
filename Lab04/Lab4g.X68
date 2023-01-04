*-----------------------------------------------------------
* Title      : Lab4f
* Written by : Gunteshwar Soin
* Date       : 18/10/2022
* Description: Example of a conditional program
*-----------------------------------------------------------
        
        ORG     $8000
START   LEA     LIST,A0          ;pointer to list
        CLR.L   D2               ;clear for use with ADD
        MOVE.L  #INDEX,D1        ;initialize index counter
AGAIN   BEQ     ISZSET           ;last word? goto DONE
        ADD.L   (A0)+,D2         ;add word
        SUB     #1,D1            ;decrement counter
        BRA     AGAIN            ;do it again!
ISZSET  MOVE.L  D2,SUM           ;store result

        SIMHALT      

        ORG     $9000
LIST    DC.L    1,2,3,4,5,6,7,8  ;list of word values
SUM     DS.L    1                ;location of result
INDEX   EQU     (SUM-LIST)/4     ;number of words in list
        END     START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
