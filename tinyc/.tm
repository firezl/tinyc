* TINY Compilation to TM Code
* File: .tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
* -> assign
* -> Const
  2:    LDC  0,97(0) 	load const
* <- Const
  3:     ST  0,0(5) 	assign: store value
* <- assign
* -> assign
* -> Const
  4:    LDC  0,98(0) 	load const
* <- Const
  5:     ST  0,1(5) 	assign: store value
* <- assign
* -> assign
* -> Const
  6:    LDC  0,5(0) 	load const
* <- Const
  7:     ST  0,2(5) 	assign: store value
* <- assign
* -> if
* -> Op
* -> Id
  8:     LD  0,2(5) 	load id value
* <- Id
  9:     ST  0,0(6) 	op: push left
* -> Const
 10:    LDC  0,6(0) 	load const
* <- Const
 11:     LD  1,0(6) 	op: load left
 12:    SUB  0,1,0 	op <
 13:    JLT  0,2(7) 	br if true
 14:    LDC  0,0(0) 	false case
 15:    LDA  7,1(7) 	unconditional jmp
 16:    LDC  0,1(0) 	true case
* <- Op
* if: jump to else belongs here
* -> Id
 18:     LD  0,0(5) 	load id value
* <- Id
 19:    OUC  0,0,0 	write char ac
* if: jump to end belongs here
 17:    JEQ  0,3(7) 	if: jmp to else
* -> if
* -> Op
* -> Id
 21:     LD  0,2(5) 	load id value
* <- Id
 22:     ST  0,0(6) 	op: push left
* -> Const
 23:    LDC  0,10(0) 	load const
* <- Const
 24:     LD  1,0(6) 	op: load left
 25:    SUB  0,1,0 	op <
 26:    JLT  0,2(7) 	br if true
 27:    LDC  0,0(0) 	false case
 28:    LDA  7,1(7) 	unconditional jmp
 29:    LDC  0,1(0) 	true case
* <- Op
* if: jump to else belongs here
* -> Id
 31:     LD  0,1(5) 	load id value
* <- Id
 32:    OUC  0,0,0 	write char ac
* if: jump to end belongs here
 30:    JEQ  0,3(7) 	if: jmp to else
 33:    LDA  7,0(7) 	jmp to end
* <- if
 20:    LDA  7,13(7) 	jmp to end
* <- if
* End of execution.
 34:   HALT  0,0,0 	
