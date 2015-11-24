section .data

    hello       db 'Hello World!', 10   ; Our string.
    helloLen    equ $ - hello           ; Length of our string

section .bss                            ; Uninitialized data section

filedesc: resw 1                         ; reserve one word

section	.text
    global main

main:
			pop ebx             ; Get the first word off of the stack.
			pop ebx             ; Get the number of arguments from the stack.
			pop ebx             ; Pointer to address of parameters directory string.

			mov ebx,[ebx + 4]    ; Move the pointer to the address of the parameter
                                ; list, ebx+4 and use it to move the address of
                                ; the parameter list int ebx.

            ; ebx now contains the address of the parameter list, needed by kernel
            ; calls or any other code, which does something with the parameters.

            mov eax, 8          ; The syscall for create (8) is put in eax.
                                ; The file name is in ebx already.
                                ; We got it from the imput parameter.

            mov ecx, 755Q       ; Read/Write permissions in octal for user. (Bits 8,7 and 6.)

            int 80h             ; Call kernel interrupt, creating the file name and returning
                                ; the file descriptor into eax.

            mov [filedesc], eax ; Move the file descriptor to the previously uninitialized
                                ; word, [filedesc].

            test eax, eax       ; Test eax with itself to make sure the high bit is off to be
                                ; a valid file descriptor.

            js  skipWrite       ; If the descriptor is invalid, jump to skipWrite and exit.
            call fileWrite      ; else, write the information to the file and close it.

skipWrite:
            mov eax, 1          ; Get the exit code into eax
            int 80h             ; Call the kernel to get out.

fileWrite:
            mov ebx, [filedesc] ; Put the file descriptor into ebx.

            mov eax, 4          ; Put the file function into eax.
            mov ecx, hello      ; Put the address of "Hello World!" into ecx.
            mov edx, helloLen   ; Put the length of the message into edx.
            int 80h             ; Call the kernel to write to file

            ; Now close the file

            mov eax, 6          ; Put the code for closing a file into
                                ; ebx. We already have the file descriptor
                                ; in the ebx register.

            int 80h             ; Call the kernel to execute the closing.

            ret                 ; Return from the procedure.
