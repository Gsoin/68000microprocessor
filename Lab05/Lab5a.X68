*-----------------------------------------------------------
* Title      : Lab5a
* Written by : Gunteshwar Soin
* Date       : 01/11/2022
* Description: Push and Pop Operations involving the
*              runtime stack (A7)
*-----------------------------------------------------------
        
        ORG     $8000

* Initialize registers with values that are easy to recognize
* when viewed on the stack

START:  MOVE.L  #$D0D0D0D0,D0   ;initialize D0
        MOVE.W  #$D1D1,D1       ;initialize D1
        MOVE.B  #$D2,D2         ;initialize D2
        LEA     $A1A1A1A1,A1    ;initialize A1
        
* Save previous values on the (runtime) stack in sequence 
 
        MOVE.L  D0,-(A7)        ;push long word in D0 
        MOVE.W  D1,-(A7)        ;push word in D1
        MOVE.B  D2,-(A7)        ;push byte in D2

* Restore previous values from stack in reverse order         

        MOVE.B  (A7)+,D2        ;pop 8-bit value into D2
        MOVE.W  (A7)+,D1        ;pop 8-bit value in D1
        MOVE.L  (A7)+,D0        ;pop 32-bit value in D0
      
* Save/restore D1 and A1 using a single push/pop instruction      

        MOVEM.L A1/D1,-(A7)     ;push 32-bit values in A1 and D1
        LEA     0,A1            ;clear A1  
        CLR.L   D1              ;clear D1
        MOVEM.L (A7)+,A1/D1     ;pop 32-bit values into D1 and A1 
                
        END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
