*-----------------------------------------------------------
* Title      : Lab4a
* Written by : Gunteshwar Soin
* Date       : 18/10/2022
* Description: 8-bit and 16-bit branch encodings
*-----------------------------------------------------------
        
        ORG    $8000
L1      BRA    L2       ;8-bit  branch forward
        ORG    $8080
L2      BRA    L3       ;16-bit branch forward
        ORG    $8200
L3      BRA    L1       ;16-bit branch backward
        END    $8000


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
