*-----------------------------------------------------------
* Title      : Lab7d
* Written by : Gunteshwar Soin
* Date       : 09/11/2022
* Description: displays integer n recursively
*-----------------------------------------------------------

quotientOffset     EQU     -2              ;displacement from frame pointer
remainderOffset     EQU     -4              ;displacement from frame pointer
nOffset     EQU      8              ;displacement from frame pointer


*
* Prologue: Prompt user to enter a and b, then compute (a+b)^2 
*

        ORG     $8000
main    LEA     MSGN,A1             ;initalize pointer to string
        MOVE    #14,D0              ;print string is task 14
        TRAP    #15                 ;system call
        MOVE    #4,D0               ;read integer from keyboard is task 4
        TRAP    #15                 ;get value of a
        MOVE.W  D1,-(A7)            ;push n onto stack  

call_display
        BSR     display             ;call subroutine
        LEA     2(A7),A7            ;remove parameter from stack
        
        SIMHALT

*
* display (n)
*  - see above for offsets
*

display 
        LINK    A6,#-4               ;allocate storage sum
        MOVEM.L  A0/D0,-(A7)         ;save working register
        CLR.L   D0
        
        *
        *   if (!n): return
        *
        
        CMPI    #0,nOffset(A6)      ;is n=0?
        BNE     L1                  ;no
*
*       return
*
        BRA     L2                  ;return
*
*       display(n)
*        
L1      MOVE.W  nOffset(A6),D0              ;get n
        DIVS    #10,D0                      ;compute n/10 and n%10
        MOVE.L  D0,remainderOffset(A6)      ;fill remainder and quotient
        
        MOVE.W  quotientOffset(A6),-(A7)            ;push quotient to stack
        BSR     display                     ;call display(n)
        
        MOVE.W  remainderOffset(A6),D1  ;get remainder ready to display
        MOVE    #3,D0               ;display integer is task 3
        TRAP    #15                 ;system call
        
L2      MOVEM.L  (A7)+,A0/D0        ;restore working register
        UNLK    A6                  ;deallocate stack frame
        RTS                         ;return value of sumSquared(a,b) in D1

        ORG $9000
MSGN    DC.B 'Enter n: ',0

        END     main



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
