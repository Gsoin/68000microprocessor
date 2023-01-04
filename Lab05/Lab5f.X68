*-----------------------------------------------------------
* Title      : Lab5f
* Written by : Gunteshwar Soin
* Date       : 01/11/2022
* Description: input list of nums and display
*              min, max, and avg
*-----------------------------------------------------------
        
        ORG     $8000

**** Main Code *****

MAIN    PEA     LIST                  ;push pointer to list   at location 10(A7)
        MOVE.W  #LENGTH,-(A7)         ;push length of list    at location  8(A7)
        PEA     STRUCT                ;push pointer to struct at location  4(A7)
        
        *MOVE.L  #4,D0                ;task number for reading a signed number entered
        *MOVE.L  #13,D0               ;task number for displaying string
        *MOVE.L  #14,D0               ;task number for displaying string without newline
        *LEA     MSG0,A1              ;point to MSG0
        *TRAP    #15                  ;system call
        *
        *MOVE.L  #4,D0                ;task number for reading a signed number entered
        *TRAP    #15                  ;system call
        
        BSR     DATA                  ;get data
        BSR     STATS                 ;calculate max min avg
        BSR     DIS                   ;display data
        
        SIMHALT

**** Subroutine: int get_data(*list)    ****
*          ARG1: *LIST at 10(A7)           *
*   Returns LENGTH at 8(A7)                *
********************************************   
        
        * display enter num of vals message
DATA    MOVE.L  #14,D0               ;task number for displaying string without newline
        LEA     MSG0,A1              ;point to MSG0
        TRAP    #15                  ;system call
        
        * get num input from user
        MOVE.L  #4,D0                ;task number for reading a signed number entered
        TRAP    #15                  ;system call
        
        * branch back if num is not in range 1-10
        CMPI.L  #1,D1                ;compare D1 to 1
        BLT     DATA                 ;branch back if D1<1
        CMPI.L  #10,D1               ;compare D1 to 1
        BGT     DATA                 ;branch back if D1>10
        
        * set counter to D2
        MOVE.L  D1,D2                ;set counter to D2
        MOVE.W  D2,8(A7)             ;set counter in stack
        MOVE.L  10(A7),A2             ;move list pointer to A2
        
        
        * display enter num message
LOOP1   MOVE.L  #14,D0               ;task number for displaying string without newline
        LEA     MSG1,A1              ;point to MSG0
        TRAP    #15                  ;system call
        
        * get num input from user
        MOVE.L  #4,D0                ;task number for reading a signed number entered
        TRAP    #15                  ;system call
        
        * add num to list
        MOVE.L  D1,(A2)+             ;add num to list
        
        * branch back if counter > 0
        SUB.L   #1,D2                ;decrement loop counter
        BNE     LOOP1                ;branch back if counter>0
        
        * end funciton
        RTS                          ;return
        
        
MSG0    DC.B      'Enter number of values in list (1-10): ',0
MSG1    DC.B      'Enter number: ',0

**** Subroutine: int Statistics(int number,*list,*struct) ****
*          ARG1: *LIST   at  10(A7)                          *
*          ARG2: LENGTH  at  8(A7)                           *
*          ARG3: *struct at  4(A7)                           *
**************************************************************
        *initialize registers
STATS   MOVE.W  8(A7),D2             ;initiaize loop counter
        MOVE.L  10(A7),A2            ;initilize pointer to list
        MOVE.L  4(A7),A3             ;initilize pointer to struct
        
        *compute maximum
MAX     MOVE.L  (A2)+,D3             ;initialize max
        SUB.L   #1,D2                ;decrement loop counter
        BEQ     MIN                  ;counter = 0? yes, then go min
        
        *compare max
LOOP2   CMP.L   (A2)+,D3             ;compare D3 to (A2)
        BGE     NOMAX                ;branch to skip update max if D3>=(A2)
        
        *update max
        MOVE.L  -4(A2),D3              ;set new max
        
        * branch back if counter > 0
NOMAX   SUB.L   #1,D2                ;decrement loop counter
        BNE     LOOP2                ;branch back if counter>0
        
        *store at struct[0]
        MOVE.L  D3,(A3)+
        
        
        *compute minimum
MIN     MOVE.W  8(A7),D2             ;initiaize loop counter
        MOVE.L  10(A7),A2            ;initilize pointer to list
        
        MOVE.L  (A2)+,D3             ;initialize min
        SUB.L   #1,D2                ;decrement loop counter
        BEQ     AVG                  ;counter = 0? yes, then go avg

        *compare min
LOOP3   CMP.L   (A2)+,D3             ;compare D3 to (A2)
        BLE     NOMIN                ;branch to skip update min if D3<=(A2)
        
        *update min
        MOVE.L  -4(A2),D3            ;set new min
        
        * branch back if counter > 0
NOMIN   SUB.L   #1,D2                ;decrement loop counter
        BNE     LOOP3                ;branch back if counter>0
        
        *store at struct[1]
        MOVE.L  D3,(A3)+
        
        
        *compute average
AVG     MOVE.W  8(A7),D2             ;initiaize loop counter
        MOVE.L  10(A7),A2            ;initilize pointer to list
        CLR.L   D3                   ;set sum to zero
        
        *loop and get sum in D3
LOOP4   ADD.L   (A2)+,D3             ;add val to sum

        * branch back if counter > 0
        SUB.L   #1,D2                ;decrement loop counter
        BNE     LOOP4                ;branch back if counter>0
        
        *divide to get avg
        MOVE.W  8(A7),D2             ;initiaize loop counter
        DIVS    D2,D3                ;compute remainder and quotient
        SWAP    D3                   ;store as (quotient and remainder)
        
        *store (quotient and remainder) at struct[2]
        MOVE.L  D3,(A3)+
        
        * end funciton
        RTS                          ;return
        
        

**** Subroutine: display(int max, int min, int quotient, int remainder) ****
*          ARG1: *struct at 4(A7)                                          *
*   Returns average in data register D0                                    *
****************************************************************************
        
        *initialize values
DIS     MOVE.L  4(A7),A3             ;initilize pointer to struct
        
        *display minimum 4(A3)
        MOVE.L  4(A3),D1             ;initilize min in D1
        MOVE.L  #14,D0               ;task number for displaying string without newline
        LEA     MSGMIN,A1            ;point to MSGMIN
        TRAP    #15                  ;system call
        MOVE.L  #3,D0                ;task 3 to display number of keyboard
        TRAP    #15                  ;system call
        *display newline
        MOVE.L  #13,D0               ;task number for displaying string
        LEA     EMPTY,A1             ;point to EMPTY
        TRAP    #15                  ;system call
        
        *display maximum  (A3)
        MOVE.L  (A3),D1              ;initilize max in D1
        MOVE.L  #14,D0               ;task number for displaying string without newline
        LEA     MSGMAX,A1            ;point to MSGMAX
        TRAP    #15                  ;system call
        MOVE.L  #3,D0                ;task 3 to display number of keyboard
        TRAP    #15                  ;system call
        *display newline
        MOVE.L  #13,D0               ;task number for displaying string
        LEA     EMPTY,A1             ;point to EMPTY
        TRAP    #15                  ;system call
        
        *display average
        CLR.L   D1                   ;clear D1
        MOVE.W  8(A3),D1             ;initilize quotient in D1
        MOVE.L  #14,D0               ;task number for displaying string without newline
        LEA     MSGAVG,A1            ;point to MSGAVG
        TRAP    #15                  ;system call
        MOVE.L  #3,D0                ;task 3 to display number of keyboard
        TRAP    #15                  ;system call
        *display space
        MOVE.L  #14,D0               ;task number for displaying string without newline
        LEA     EMPTY,A1             ;point to EMPTY
        TRAP    #15                  ;system call
        *display remainder
        MOVE.W  10(A3),D1             ;initilize remainder in D1
        MOVE.L  #3,D0                ;task 3 to display number of keyboard
        TRAP    #15                  ;system call
        *display /
        MOVE.W  #47,D1               ;initilize / in D1
        MOVE.L  #6,D0                ;task 6 to display a single ascii character
        TRAP    #15                  ;system call
        *display denominator
        MOVE.W  8(A7),D1             ;initilize LENGTH in D1
        MOVE.L  #3,D0                ;task 3 to display number of keyboard
        TRAP    #15                  ;system call
        
        *display newline
        MOVE.L  #13,D0               ;task number for displaying string
        LEA     EMPTY,A1             ;point to EMPTY
        TRAP    #15                  ;system call
        
        *quotient  =  8(A3)
        *remainder = 10(A3)
        
        * end funciton
        RTS                          ;return

MSGMAX   DC.B      'Maximum = ',0
MSGMIN   DC.B      'Minimum = ',0
MSGAVG   DC.B      'Average = ',0
EMPTY    DC.B      ' ',0






        ORG     $9000
LIST    DS.L      10                  ;list of numbers to average
LENGTH  DS.W      1                   ;size of list in words
STRUCT  DS.L      3                   ;four members in struct, max, min, (quotient and remainder)
        
        END        MAIN







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
