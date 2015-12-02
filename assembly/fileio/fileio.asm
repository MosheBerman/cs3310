section .data
    hello:  db 'Hello, world!',10   ; Our string
    helloLen : equ $-hello         ; Length of our string

section .bss                       ; Uninitialized section
filedesc: resw 1                   ; reserve 1 word

 section .text
    global main

main:
    pop ebx         ; Get the word off of the stack.
    pop ebx         ; Get the number of parameters from the stack
    pop ebx         ; Pointer to address of paramater for the directory string
    ; The three pops are necessary to get ebx to contain the address of where the file designation is

    mov ebx, [ebx+4] ; Now, get the address of the first parameter

    mov eax, 8          ; The syscall for creat (8) is placed in eax
                        ; We already have our filename in the stack



    mov ecx, 755Q       ; Read/write permissions in octal (Q) for bits (8, 7, 6)

    int 80h             ; Call the interrupt creating the file and returning the
                        ; file descriptor in eax

    mov [filedesc], eax  ; Move the returned descriptor into the uninitialized word,
                        ; which we reserved in .bss

    test eax, eax       ; And eax with itself to make sure that the high bit
                        ; is off to be a valid file descriptor

    js skipWrite        ; If the descriptor is invalid, jump to skipWrite
    call fileWrite      ; else, write information to the file and close it


skipWrite:
    mov eax, 1          ; Move the exit code to eax
    int 80h            ; Call the kernel to exit


fileWrite:
    mov ebx, [filedesc] ; Put the file descriptor into ebx
    mov eax, 4          ; Put the file write instruction for the kernel (4) into eax
    mov ecx, hello      ; Put the address of "Hello World!" into ecx
    mov edx, helloLen   ; Put the length of the message into edx
    int 80h

    ; Now close the file

    mov eax, 6          ; Put the file close instruction (6) into eax
    int 80h             ; Call the interrupt
    ret                 ; Return from fileWrite
