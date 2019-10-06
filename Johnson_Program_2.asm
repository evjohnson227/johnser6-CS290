TITLE Fibonacci Numbers     (Johnson_Program_2.asm)

; Author: Eric Johnson
; Last Modified: 7/13/19
; OSU email address: johnser6@oregonstate.edu
; Course number/section: CS 271 400 U2019
; Assignment Number: 2                Due Date: 7/14/19
; Description: MASM program that calculates Fibonacci numbers and does the following:
;				- Displays the program title and programmer’s name. Then prompts the user for their name and greets them (by name).
;				- Prompts the user to enter the number of Fibonacci terms to be displayed. Advises the user to enter an integer in the range [1 .. 46].
;				- Gets and validates the user input (n).
;				- Calculates and displays all of the Fibonacci numbers up to and including the nth term. The results should be displayed 4 terms per line with at least 5 spaces between terms.
;				- Displays a parting message that includes the user’s name, and terminates the program.

INCLUDE Irvine32.inc

.data
introduction			BYTE			"Fibonacci Numbers", 0
displayProgrammerName	BYTE			"Programmed by Eric Johnson", 0
getUserInfoMessage		BYTE			"What's your name? ", 0
greetUserMessage		BYTE			"Hello, ", 0
userName				BYTE			40 DUP(0)
instruction				BYTE			"Enter the number of Fibonacci terms to be displayed.", 0
instruction2			BYTE			"Provide a number as an integer in the range [1..46].", 0
getFibNumMessage		BYTE			"How many Fibonacci terms do you want? ", 0
userNumFibTerms			DWORD			?
inputValidationMessage	BYTE			"Out of range. Enter a number in [1..46]", 0
spaces					BYTE			"     ", 0
endMessage1				BYTE			"Results certified by Eric Johnson.", 0
endMessage2				BYTE			"Goodbye, ", 0
UPPERLIMIT = 46
LOWERLIMIT = 1

.code
main PROC

; Introduction
; Display the program title and programmer's name
	mov		edx, OFFSET introduction
	call	WriteString
	call	CrLf
	mov		edx, OFFSET displayProgrammerName
	call	WriteString
	call	CrLf

; Get user info
; Prompt the user for their name and greet them (by name)
	mov		edx, OFFSET getUserInfoMessage
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, SIZEOF userName
	call	ReadString

; Greet user
	mov		edx, OFFSET greetUserMessage
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

; Display instructions
; Prompts the user to enter the number of Fibonacci terms to be displayed
; Advise the user to enter an integer in the range [1..46]
	mov		edx, OFFSET instruction
	call	WriteString
	call	CrLf
	mov		edx, OFFSET instruction2
	call	WriteString
	call	CrLf
	mov		edx, OFFSET getFibNumMessage
	call	WriteString

; Get user input for how many Fibonacii terms to be displayed
L1:
	call	ReadInt
	mov		ebx, UPPERLIMIT
	cmp		eax, ebx
	jge		fBlock
	mov		ebx, LOWERLIMIT
	cmp		eax, ebx
	jl		fBlock
	jmp		doneL1

; Get and validate user input
; Loop until user until is within range
fBlock:
	mov		edx, OFFSET inputValidationMessage
	call	WriteString
	call	CrLf
	mov		edx, OFFSET getFibNumMessage
	call	WriteString
	jmp		L1

; Exit loop on valid user input
doneL1:
	mov		userNumFibTerms, eax

; Calculate and display all of the Fibonacci numbers up to and including the nth term
; Initialize registers to begin calculating Fibonacci numbers
	mov		eax, 1
	mov		ebx, LOWERLIMIT						; initialize ebx to 1 to begin sequence
	mov		ecx, userNumFibTerms				; set loop counter to user input
	mov		esi, 4								; set esi to 4 (numbers output per line)

; Loop to calculate and display Fibonacci numbers
L2:
	mov		edx, eax
	add		edx, ebx
	call	WriteDec
	mov		eax, ebx
	mov		ebx, edx
	cmp		ecx, 1
	je		doneL2
	cmp		esi, 1
	je		endLine
	dec		esi
	jg		addSpaces

; Block that determines when to end output line
endLine:
	call	CrLf
	mov		esi, 4
	loop	L2

; Block that adds 5 spaces between each number output
addSpaces:
	mov		edx, OFFSET spaces
	call	WriteString
	loop	L2

; Exit loop once Fibonacci numbers are calculated
doneL2:
	call	CrLf

; Display parting message that includes the user's name, and terminate the program
	mov		edx, OFFSET endMessage1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET endMessage2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString

	exit	; exit to operating system

main ENDP


END main