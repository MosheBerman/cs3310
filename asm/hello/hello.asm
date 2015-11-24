
section .data

hello:	db	'Hello World',10	;'Hello World!' plus a linefeed character.
helloLen:	equ	$-hello 		; Length of 'Hello World!' string

section	.text
    global main

main:

			mov eax, 4			; The system call for write (sys_write)
			mov	ebx, 1 			; File descriptor 1 - standard output
			mov ecx, hello 		; Put the offset of hello in ecx
			mov edx, helloLen 	; helloLen is a constant, so no need to say
								; mov edx,[helloLen] to get actual value
			Int	80h			    ; call the kernel to write the string.


			mov eax, 1 			; The system call for exit (sys_Exit)
			mov ebx, 0 			; Exit with return code of 0 (no error)
			Int	80h			    ; Call the kernel to execute the exit
