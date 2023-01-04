*-----------------------------------------------------------
* Title      : Lab7c
* Written by : Gunteshwar Soin
* Date       : 09/11/2022
* Description: Computes c=(a+b)^2
*-----------------------------------------------------------

xOffset     EQU     -2              ;displacement from frame pointer
yOffset     EQU     -4              ;displacement from frame pointer
zOffset     EQU     -6              ;displacement from frame pointer
aOffset     EQU     14              ;displacement from frame pointer
bOffset     EQU     12              ;displacement from frame pointer
cOffset     EQU      8              ;displacement from frame pointer


*
* Prologue: Prompt user to enter a and b, then compute (a+b)^2 
*

        ORG     $8000
main    LEA     MSGA,A1             ;initalize pointer to string
        MOVE    #14,D0              ;print string is task 14
        TRAP    #15                 ;system call
        MOVE    #4,D0               ;read integer from keyboard is task 4
        TRAP    #15                 ;get value of a
        MOVE.W  D1,-(A7)            ;push a onto stack  
        
        LEA     MSGB,A1             ;initalize pointer to string
        MOVE    #14,D0              ;print string is task 14
        TRAP    #15                 ;system call
        MOVE    #4,D0               ;read integer from keyboard is task 4
        TRAP    #15                 ;get value of b
        MOVE.W  D1,-(A7)            ;push b onto stack 
        
        PEA     C                   ;push address of c onto stack

call_sumSquared
        BSR     sumSquared          ;call subroutine
        LEA     8(A7),A7            ;remove parameter from stack

        LEA     MSG2,A1             ;initilaize pointer to string
        MOVE    #14,D0              ;print string is task 14
        TRAP    #15                 ;system call
        MOVE    #3,D0               ;display integer is task 3
        MOVE.W  C,D1
        TRAP    #15                 ;system call
        
        SIMHALT

*
* sumSquared (a,b,*c)
*  - see above for offsets
*  - value of (a+b)^2 is stored at c

sumSquared 
        LINK    A6,#-6               ;allocate storage sum
        MOVEM.L  A0/D0,-(A7)         ;save working register
        
        MOVE.W  aOffset(A6),D0      ;move a to D0
        MULS.W  D0,D0               ;a * a
        MOVE.W  D0,xOffset(A6)      ;save x = a * a
        
        MOVE.W  bOffset(A6),D0      ;move b to D0
        MULS.W  D0,D0               ;b * b
        MOVE.W  D0,yOffset(A6)      ;save y = b * b
        
        MOVE.W  aOffset(A6),D0      ;move a to D0
        MULS.W  bOffset(A6),D0      ;a * b
        MULS.W  #2,D0               ;2 * a * b
        MOVE.W  D0,zOffset(A6)      ;save z = 2 * a * b
        
        MOVE.W  xOffset(A6),D0      ;move x to D0
        ADD.W   yOffset(A6),D0      ;x + y
        ADD.W   zOffset(A6),D0      ;x + y + z
        
        MOVEA.L cOffset(A6),A0      ;get address of c
        MOVE.W  D0,(A0)             ;*c = x + y + z
        
L2      MOVEM.L  (A7)+,A0/D0        ;restore working register
        UNLK    A6                  ;deallocate stack frame
        RTS                         ;return value of sumSquared(a,b) in D1

        ORG $9000
MSGA    DC.B 'Enter a: ',0
MSGB    DC.B 'Enter b: ',0
MSG2    DC.B 'Sum Squared: ',0
C       DS.W 1

        END     main



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
