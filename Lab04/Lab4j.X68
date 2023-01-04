*-----------------------------------------------------------
* Title      : If Statement
* Written by : Gunteshwar Soin
* Date       : 19/10/2022
* Description: sets values A and B to C if A > B
*              if not then swap A and B
*-----------------------------------------------------------
        ORG     $8000
START   MOVE.W  A,D1

CON1    CMPI.W  #0,D1   ;A >= 0
        BLO     CON2
        
        CMPI.W  #100,D1 ;A > 100
        BLS     CON2    ;branch if passed A <= 100


CON2    CMPI.W  #800,D1 ;A >= 800
        BLO     FAIL
        
        CMPI.W  #900,D1 ;A <= 900
        BHI     FAIL
        
SUCCESS MOVE.W  #1,B
        BRA     EXIT

FAIL    MOVE.W  #0,B

EXIT    CLR.W   D1
        SIMHALT

        ORG     $9000
A       DC.W    99
B       DS.W    1
        END    START








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
