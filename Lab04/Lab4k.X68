*-----------------------------------------------------------
* Title      : If Statement
* Written by : Gunteshwar Soin
* Date       : 19/10/2022
* Description: runs a for loop
*-----------------------------------------------------------
        ORG     $8000
START   MOVE.W  A,D1

LOOP    CMPI.W  #50,D1  ;D1 < 50
        BHS     EXIT    ;break loop if false
        ADD.W   #1,A
        ADD.W   #1,D1
        BRA     LOOP

EXIT    CLR.W   D1
        SIMHALT

        ORG     $9000
A       DC.W    10
        END    START








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
