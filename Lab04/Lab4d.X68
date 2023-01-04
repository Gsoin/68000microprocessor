*-----------------------------------------------------------
* Title      : Lab4d
* Written by : Gunteshwar Soin
* Date       : 18/10/2022
* Description: Comparing numbers
*-----------------------------------------------------------
        
        ORG     $8000
START   MOVE.B  NUM2,D0          ;move NUM2 to register for
        CMP.B   NUM1,D0          ;comparision with NUM1
        BLS     LESS             ;NUM2 <= NUM1? Then branch
        MOVE.B  D0,D5            ;NUM2 greater? move to D5
        BRA     EXIT             ;goto EXIT
LESS    MOVE.B  D0,D6            ;move to D6

EXIT    SIMHALT      

        ORG  $9000
NUM1    DC.B %10000000           ;variable NUM1
NUM2    DC.B %10000001           ;variable NUM2
        END  START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
