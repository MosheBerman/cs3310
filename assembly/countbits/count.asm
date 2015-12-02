
;   Returns The number of enabled bits in the number which we put into ebx.

section .text
global main

main:

    mov ax,
    mov ebx, 0   ; bl will contain the count of ON bits
    mov ecx, 32  ; ecx is the loop counter

    count_loop:
        shl ax, 1           ; Shift the high bit into CF
        jnc skip_inc
        inc ebx          ; count up

    skip_inc:
        loop count_loop


    mov ecx, ebx        ; Put the counted value in

    mov eax, 1 			; The system call for exit (sys_Exit)
    mov ebx, ecx 		; Exit with return code of 0 (no error)

    Int	80h			    ; Call the kernel to execute the exit
