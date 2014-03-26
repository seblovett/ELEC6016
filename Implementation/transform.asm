LUI 4; load constants
STACC 0 ; a11 = 0.5 = x40
LUI 9; 
STACC 1 ; a12 = -0.875 = x90
LUI 9; 
STACC 2 ; a21 = -0.875 = x90
LUI 6
STACC 3 ; a22 = 0.75 = x60
LUI 0; 
ADDI 5
STACC 4 ; b1
LUI 0; 
ADDI 12
STACC 5 ; b2
WAIT0 ;wait while sw8 == 0 ; LOOP
STSW 6 ; store switches to R6 ; X
WAIT1 ; Wait while sw8 == 1
WAIT0 ; Wait while sw8 == 0
STSW 7 ; store switches to R7 ; Y
WAIT1
PASSA 6 ;transform - load x1 to acc
MULT 0 ; a11 * x1
STACC 8 ; store to r8
PASSA 7 ; y1 to acc
MULT 1 ; acc * a12
ADD 8 ; (y1 * a12) + (x1 + a11)
ADD 4 ; acc + b1
STACC 9
PASSA 6 ;transform - load x1 to acc
MULT 2 ; a21 * x1
STACC 8 ; store to r8
PASSA 7 ; y1 to acc
MULT 3 ; acc * a22
ADD 8 ; (y1 * a12) + (x1 + a11)
ADD 5 ; acc + b1
STACC 10
PASSA 9 ; display x2
WAIT0
PASSA 10 ; display y2
WAIT1
LUI 1 ;return to loop - load address to acc
JMPA 2 ; jump to address 19
