section .text
    global main

main:
    cmp eax, 0      ; Compare eax to 0.
                    ; The zero flag, ZF, is
                    ; going to be 1 iff eax-0 == 0

    jz  ifblock     ; If the Zero flag is zero, jump to "ifblock"
                    ; "ifblock" is an arbitrary label name

    mov ebx, 2      ; The ELSE block
    jmp next        ; Now it we skip the IF block

    ifblock:        ; This code executes if the Z register is 1
        mov ebx, 1 ; Move 1 into the ebx register

    next:           ; This always executes.
                    ; We might fall through from "ifblock"
                    ; or we might have jumped if ZF was 0
                    ; after comparing

        Int 80h     ; return

