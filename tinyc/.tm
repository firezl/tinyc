* TINY Compilation to TM Code
* File: .tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
* -> assign
* -> Const
  2:    LDC  0,115(0) 	load const
* <- Const
  3:     ST  0,0(5) 	assign: store value
* <- assign
* -> assign
* -> Const
  4:    LDC  0,1(0) 	load const
* <- Const
  5:     ST  0,1(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
  6:     LD  0,0(5) 	load id value
* <- Id
  7:     ST  0,0(6) 	op: push left
* -> Id
  8:     LD  0,1(5) 	load id value
* <- Id
  9:     LD  1,0(6) 	op: load left
 10:    ADD  0,1,0 	op +
* <- Op
 11:     ST  0,0(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 12:     LD  0,0(5) 	load id value
* <- Id
 13:     ST  0,0(6) 	op: push left
* -> Const
 14:    LDC  0,1(0) 	load const
* <- Const
 15:     LD  1,0(6) 	op: load left
 16:    ADD  0,1,0 	op +
* <- Op
 17:     ST  0,0(5) 	assign: store value
* <- assign
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
* -> Const
 24:    LDC  0,0(0) 	load const
* <- Const
 25:     ST  0,2(5) 	assign: store value
* <- assign
* -> assign
* -> Const
 26:    LDC  0,97(0) 	load const
* <- Const
 27:     ST  0,3(5) 	assign: store value
* <- assign
* -> while
* while: if test is false jump to end
* -> Op
* -> Id
 28:     LD  0,2(5) 	load id value
* <- Id
 29:     ST  0,0(6) 	op: push left
* -> Const
 30:    LDC  0,5(0) 	load const
* <- Const
 31:     LD  1,0(6) 	op: load left
 32:    SUB  0,1,0 	op <
 33:    JLT  0,2(7) 	br if true
 34:    LDC  0,0(0) 	false case
 35:    LDA  7,1(7) 	unconditional jmp
 36:    LDC  0,1(0) 	true case
* <- Op
* -> Id
 38:     LD  0,3(5) 	load id value
* <- Id
 39:    OUC  0,0,0 	write char ac
* -> assign
* -> Op
* -> Id
 40:     LD  0,3(5) 	load id value
* <- Id
 41:     ST  0,0(6) 	op: push left
* -> Const
 42:    LDC  0,1(0) 	load const
* <- Const
 43:     LD  1,0(6) 	op: load left
 44:    ADD  0,1,0 	op +
* <- Op
 45:     ST  0,3(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 46:     LD  0,2(5) 	load id value
* <- Id
 47:     ST  0,0(6) 	op: push left
* -> Const
 48:    LDC  0,1(0) 	load const
* <- Const
 49:     LD  1,0(6) 	op: load left
 50:    ADD  0,1,0 	op +
* <- Op
 51:     ST  0,2(5) 	assign: store value
* <- assign
 52:    LDA  7,-25(7) 	jumop to the start
 37:    JEQ  0,15(7) 	jump to the end
* <- while
* End of execution.
 53:   HALT  0,0,0 	
