
section .text
global main

main:
    mov ecx, 10
    mov eax, 0

    looplabel:

    add eax, ecx

    loop looplabel    ; Jump back to loop if it is

    mov eax, 1
    mov ebx, 0

    int 80h
