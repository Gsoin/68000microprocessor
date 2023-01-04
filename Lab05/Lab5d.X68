*-----------------------------------------------------------
* Title      : Lab5d
* Written by : Gunteshwar Soin
* Date       : 01/11/2022
* Description: An example of preserving register values
*              upon entry and exit from a subroutine
*-----------------------------------------------------------
        
        ORG     $8000

**** Main (calling) Code *****

START:  MOVE.L  #$D1D1D1D1,D1       ;initialize registers
        MOVE.L  #$D2D2D2D2,D2       ;with easy to recognize
        MOVE.L  #$D3D3D3D3,D3       ;values
        MOVEA.L #$A4A4A4A4,A4
        MOVEA.L #$A5A5A5A5,A5
        
        BSR     FOO                 ;call subroutine

        SIMHALT


**** Subroutine foo() ****

FOO     MOVEM.L D1-D3/A4-A5,-(A7)   ;save working registers
        MOVEM.L zero,D1-D3/A4-A5    ;simulate use of registers
        MOVEM.L (A7)+,D1-D3/A4-A5   ;restore working registers
        RTS                         ;return to calling code     

ZERO    DC.L    0,0,0,0,0           
        END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
