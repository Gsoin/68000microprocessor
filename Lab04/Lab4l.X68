*-----------------------------------------------------------
* Title      : If Statement
* Written by : Gunteshwar Soin
* Date       : 19/10/2022
* Description: loops and arrays
*-----------------------------------------------------------
        ORG     $8000
START   MOVE.B  #0,D0   ; i
        MOVE.W  #0,D1   ; odd
        MOVE.W  #0,D2   ; even
        MOVE.L  #0,D7   ; division
        LEA     MY_SID,A0

LOOP    CMPI.W  #7,D0   ;D0 < 7
        BHS     EXIT    ;break loop if false
        
        CLR.L   D7
        MOVE.W  (A0)+,D7 ;move A0 to D7 for
        DIVS    #2,D7   ;A % 2
        SWAP    D7      ;remainder swaped to lower word
        
        CMPI.W  #0,D7   ;D7 == 0
        BNE     ODD
        
EVEN    ADD.W   #1,D2   ;even++
        BRA     IDX

ODD     ADD.W   #1,D1   ;odd++
        
IDX     ADD.B   #1,D0   ; i++
        BRA     LOOP    ; continue loop

EXIT    CLR.W   D0
        CLR.L   D7
        SIMHALT

        ORG     $9000
MY_SID  DC.W    1,1,7,8,2,5,7   ;id number array
        END     START








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
