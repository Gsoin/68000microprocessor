*-----------------------------------------------------------
* Title      : If Statement
* Written by : Gunteshwar Soin
* Date       : 18/10/2022
* Description: sets values A and B to C if A == B
*              if not then swap A and B
*-----------------------------------------------------------
        ORG     $8000
START   MOVE.B  A,D1
        MOVE.B  B,D2
        CMP.B   D2,D1
        BNE     ISNOTZ
        
        MOVE.B  C,A     ;A == B
        MOVE.B  C,B

        BRA EXIT
ISNOTZ  MOVE.B  A,D0    ;A != B
        MOVE.B  B,A
        MOVE.B  D0,B
        CLR.B   D0
EXIT    CLR.B   D1
        CLR.B   D2
    
     
        SIMHALT

        ORG     $9000
A       DC.B    1
B       DC.B    1
C       DC.B    8
        END    START






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
