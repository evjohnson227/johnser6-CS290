TITLE Elementary Arithmetic     (Johnson_Program_1.asm)

; Author: Eric Johnson
; Last Modified: 7/7/19
; OSU email address: johnser6@oregonstate.edu
; Course number/section: CS_271_400_U2019
; Assignment Number: 1            Due Date: 7/7/19
; Description: MASM program that performs the following tasks:
;				1. Displays name and program title on the output screen.
;				2. Displays instructions for the user.
;				3. Prompts the user to enter two numbers.
;				4. Calculates the sum, difference, product, (integer) quotient and remainder of the numbers.
;				5. Displays a terminating message.

INCLUDE Irvine32.inc

.data
intro			BYTE		"Elementary Arithmetic by Eric Johnson", 0
extraCredit1	BYTE		"**EC: Program verifies second number less than first.", 0
extraCredit2	BYTE		"**EC: Program calculates and displays the square of each number.", 0
instruction		BYTE		"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0
ecInstruction	BYTE		"The second number must be less than the first!", 0														; Extra credit instruction
prompt1			BYTE		"First number: ", 0
value1			DWORD		?																										; First value to be entered by user
prompt2			BYTE		"Second number: ", 0			
value2			DWORD		?																										; Second value to be enered by user
Sum				DWORD		?					
Difference		DWORD		?
Product			DWORD		?
Quotient		DWORD		?
Remainder		DWORD		?
squareVal1		DWORD		?
squareVal2		DWORD		?
equalSign		BYTE		" = ", 0
plusSign		BYTE		" + ", 0
minusSign		BYTE		" - ", 0
timesSign		BYTE		" x ", 0
divideSign		BYTE		" / ", 0
remainderSign	BYTE		" remainder ", 0
squareSign		BYTE		"Square of ", 0
endProgram		BYTE		"Impressed? Bye!", 0

.code
main PROC

; Introduction
; Displays your name and program title on the output screen
	mov		edx, OFFSET intro
	call	WriteString
	call	CrLf

; Display extra credit statements
	mov		edx, OFFSET extraCredit1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET extraCredit2
	call	WriteString
	call	CrLf

; Displays instructions for the user
	mov		edx, OFFSET instruction
	call	WriteString
	call	CrLf

L1:

; Get the data
; Get first value from user
	mov		edx, OFFSET prompt1
	call	WriteString
	call	ReadDec
	mov		value1, eax

; Get second value from user
	mov		edx, OFFSET prompt2
	call	WriteString
	call	ReadDec
	mov		value2, eax

; **EC: Check that first value is greater than second value
	mov		eax, value1
	cmp		eax, value2
	jl		tBlock
	jge		done					; Exit loop if value 1 is greater than or equal to value 2

; Jump to this block if value 1 is less than value 2
tBlock:
	mov		edx, OFFSET ecInstruction
	call	WriteString
	call	CrLf
	jmp		L1						; Loop until value 1 is greater than value 2

done:

; Calculate the required values
; Calculate the sum of user values
	mov		eax, value1
	mov		ebx, value2
	add		eax, ebx
	mov		Sum, eax

; Calculate the difference of user values
	mov		eax, value1
	mov		ebx, value2
	sub		eax, ebx
	mov		Difference, eax

; Calculate the product of user values
	mov		eax, value1
	mov		ebx, value2
	mul		ebx
	mov		Product, eax

; Calculate (integer) quotient and remainder of user values
	mov		edx, 0
	mov		eax, value1
	mov		ebx, value2
	mov		edx, 0
	div		ebx
	mov		Quotient, eax
	mov		Remainder, edx

; **EC: Calculate the square of each user value by multiplying each value by itself
; Calculate the square of the first value
	mov		eax, value1
	mov		ebx, value1
	mul		ebx
	mov		squareVal1, eax

; Calculate the square of the second value
	mov		eax, value2
	mov		ebx, value2
	mul		ebx
	mov		squareVal2, eax

; Display the results
; Display the sum
	mov		eax, value1
	call	WriteDec
	mov		edx, OFFSET plusSign
	call	WriteString
	mov		eax, value2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, Sum
	call	WriteDec
	call	CrLf

; Display the difference
	mov		eax, value1
	call	WriteDec
	mov		edx, OFFSET minusSign
	call	WriteString
	mov		eax, value2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, Difference
	call	WriteDec
	call	CrLf

; Display the product
	mov		eax, value1
	call	WriteDec
	mov		edx, OFFSET timesSign
	call	WriteString
	mov		eax, value2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, Product
	call	WriteDec
	call	CrLf

; Display the (integer) quotient and remainder
	mov		eax, value1
	call	WriteDec
	mov		edx, OFFSET divideSign
	call	WriteString
	mov		eax, value2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, Quotient
	call	WriteDec
	mov		edx, OFFSET remainderSign
	call	WriteString
	mov		eax, remainder
	call	WriteDec
	call	CrLf

; Display the square of each number
; Display the square of first number
	mov		edx, OFFSET squareSign
	call	WriteString
	mov		eax, value1
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, squareVal1
	call	WriteDec
	call	CrLf

; Display the square of second number
	mov		edx, OFFSET squareSign
	call	WriteString
	mov		eax, value2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, squareVal2
	call	WriteDec
	call	CrLf


; Say goodbye
	mov		edx, OFFSET endProgram
	call	WriteString

	exit							; exit to operating system

main ENDP

END main