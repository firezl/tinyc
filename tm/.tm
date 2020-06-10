* TINY Compilation to TM Code
* File: .tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
* -> assign
* -> Const
  2:    LDC  0,0(0) 	load const
* <- Const
  3:     ST  0,0(5) 	assign: store value
* <- assign
* -> assign
* -> Const
  4:    LDC  0,97(0) 	load const
* <- Const
  5:     ST  0,1(5) 	assign: store value
* <- assign
* -> while
* while: if test is false jump to end
* -> Op
* -> Id
  6:     LD  0,0(5) 	load id value
* <- Id
  7:     ST  0,0(6) 	op: push left
* -> Const
  8:    LDC  0,5(0) 	load const
* <- Const
  9:     LD  1,0(6) 	op: load left
 10:    SUB  0,1,0 	op <
 11:    JLT  0,2(7) 	br if true
 12:    LDC  0,0(0) 	false case
 13:    LDA  7,1(7) 	unconditional jmp
 14:    LDC  0,1(0) 	true case
* <- Op
* -> Id
 16:     LD  0,1(5) 	load id value
* <- Id
 17:    OUC  0,0,0 	write char ac
* -> assign
* -> Op
* -> Id
 18:     LD  0,1(5) 	load id value
* <- Id
 19:     ST  0,0(6) 	op: push left
* -> Const
 20:    LDC  0,1(0) 	load const
* <- Const
 21:     LD  1,0(6) 	op: load left
 22:    ADD  0,1,0 	op +
* <- Op
 23:     ST  0,1(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 24:     LD  0,0(5) 	load id value
* <- Id
 25:     ST  0,0(6) 	op: push left
* -> Const
 26:    LDC  0,1(0) 	load const
* <- Const
 27:     LD  1,0(6) 	op: load left
 28:    ADD  0,1,0 	op +
* <- Op
 29:     ST  0,0(5) 	assign: store value
* <- assign
 30:    LDA  7,-25(7) 	jumop to the start
 15:    JEQ  0,15(7) 	jump to the end
* <- while
* End of execution.
 31:   HALT  0,0,0 	
