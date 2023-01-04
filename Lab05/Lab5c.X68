*-----------------------------------------------------------
* Title      : Lab5c
* Written by : Gunteshwar Soin
* Date       : 01/11/2022
* Description: Demonstration of subroutine call-return using
*              runtime stack (A7) to hold return address
*-----------------------------------------------------------
        
        ORG     $8000

**** Main (calling) Code *****

START:  MOVE.L  #13,D0          ;task number for displaying string
        LEA     MSG0,A1         ;point to MSG0
        TRAP    #15             ;system call
        
        BSR     FOO             ;call subroutine foo()
        
        LEA     MSG2,A1         ;point to MSG2
        TRAP    #15             ;system call

        SIMHALT        
 
 
**** Subroutine foo() *****       
FOO     LEA     MSG1,A1         ;point to MSG1
        TRAP    #15             ;system call
        RTS                     ;return to calling code

MSG0    DC.B    '1. Running calling code',0
MSG1    DC.B    '2. Control passed from calling code to subroutine foo()', 0
MSG2    DC.B    '3. Control passed from subroutne foo() back to calling code',0
                      
        END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
