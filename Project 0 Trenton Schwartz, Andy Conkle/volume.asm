TITLE Add and Subtract, Version 2         (AddSub2.asm)

;This program accepts 6 inputs, 3 feet values and 3 inches values
;These are then used to calculate a volume using the equation
;(x1 * 12 + x2)*(x3 * 12 + x4)*(x5 * 12 + x6) where the even numbered variables are in inches and the odds are in feet
;This program was written by Trenton Schwartz / Andy Conkle

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
INCLUDE Irvine32.inc

.data
heightPrompt DB 'Enter the height in feet:',0
widthPrompt DB 'Enter the width in feet:',0
lengthPrompt DB 'Enter the length in feet:',0
inchesPrompt DB 'and inches:',0
outPrompt1 DB 'Volume (inches):',0
outPrompt2 DB ' Volume (feet):',0
feetIndicator DB ' feet ',0
inchIndicator DB ' inches',0
volume DW 0
divisor DW 1728

.code
main PROC
	
	;HEIGHT
	XOR ax, ax
	MOV edx, OFFSET heightPrompt    
	call writestring			 ;display height prompt from edx

	BadInput1: call readint  ;starts input
	JGE GoodInput1
	JMP BadInput1
	GoodInput1: MOV cx, ax                   ;move feet input (ax) into cx

	MOV edx, OFFSET inchesPrompt    
	call writestring             ;display inches prompt

	BadInput2: call readint	             ;enter inches input into ax
	JGE GoodInput2
	JMP BadInput2
	GoodInput2: IMUL cx, cx, 12			 ;cx is the destination, multiply cx by 12 and place this result in cx 

	ADD cx, ax					 ;12 * feet (cx) + inches
	MOV volume, cx

	;WIDTH
	MOV edx, OFFSET widthPrompt    
	call writestring

	BadInput3: call readint  ;starts input
	JGE GoodInput3
	JMP BadInput3
	GoodInput3: MOV cx, ax  

	MOV edx, OFFSET inchesPrompt        
	call writestring			 ;display inches prompt

	BadInput4: call readint
	JGE GoodInput4
	JMP BadInput4
	GoodInput4: IMUL cx, cx, 12

	ADD cx, ax  ;12 * feet + inches
	MOV ax, cx  
	MUL volume
	MOV volume, ax			   ;takes sum from previous calculation and puts it into volume variable

	;LENGTH
	MOV edx, OFFSET lengthPrompt    
	call writestring

	BadInput5: call readint  ;starts input
	JGE GoodInput5
	JMP BadInput5
	GoodInput5:	MOV cx, ax	  

	MOV edx, OFFSET inchesPrompt    
	call writestring

	BadInput6: call readint
	JGE GoodInput6
	JMP BadInput6
	GoodInput6: IMUL cx, cx, 12	

	ADD ax, cx  ;12 * feet + inches
	MUL volume	

	;OUTPUT
	MOV edx, OFFSET outPrompt1    
	call writestring             ;display output in feet
	call writedec
	MOV edx, OFFSET outPrompt2    
	call writestring             ;display output in inches
	XOR dx,dx
	DIV divisor
	call writedec
	XCHG dx, ax
	MOV edx, OFFSET feetIndicator
	call writestring
	XOR dx, dx
	call writedec
	MOV edx, OFFSET inchIndicator
	call writestring
	invoke ExitProcess,0
main ENDP
END main