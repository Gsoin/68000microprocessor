*-----------------------------------------------------------
* Title      : Lab4b
* Written by : Gunteshwar Soin
* Date       : 18/10/2022
* Description: Testing a variable
*-----------------------------------------------------------
        
        ORG     $8000
START   MOVE.B  VAR,D0      ;move sets the flags in CCR
        BPL     ISNOTN      ;branch if variable is positive
        NEG.B   D0          ;complement variable
ISNOTN  MOVE.B  D0,VAR      ;move result back to variable
        
        SIMHALT
        
        ORG     $9000
VAR     DC.B    1           ;a variable
        END     START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
