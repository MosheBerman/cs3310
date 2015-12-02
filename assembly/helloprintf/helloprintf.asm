extern printf                   ; Make printf available to assembly

section .data
    hello db "Hello printf!", 10    ; Declare a 13 byte word, hello world.
    helloLen equ $-hello          ; Get the length of the hello message

section .text
    global main                     ; Make main available to assembly

main:
    mov eax, hello                  ; Move "hello" into the eax register.
    push eax                        ; Push eax onto the stack
    call printf                     ; Call printf

    pop eax                         ; Pop eax

    mov eax, 1                      ; Push the call for return into eax
    mov ebx, 0                      ; Put the return value into ebx
    int 80h                         ; Kernel interrupt
