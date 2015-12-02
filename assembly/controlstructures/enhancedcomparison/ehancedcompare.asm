
section .data
    global main

main:

    cmp eax, 5      ; Compare 5 to eax

    jge ifblock     ; Jump to 'ifblock'
                    ; if eax >= 5

    mov ebx, 2      ; else set ebx = 2

    jmp nextlabel   ; Then skip the 'ifblock'

    ifblock:        ; The body of 'ifblock'
        mov ebx, 1  ; Set ebx = 1

    nextlabel:      ; Here's where we continue
                    ; regardless of the output
                    ; of the comparison
        Int 80h
