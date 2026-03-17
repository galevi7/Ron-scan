; face_trigger.asm - Ron's Facial Expression Trigger Module
; Compiled from CerebralGit brain scan
;
; Build: nasm -f elf64 -g face_trigger.asm -o face_trigger.o
; Inspect: objdump -d face_trigger.o
; Find symbols: objdump -t face_trigger.o
; Read strings: strings face_trigger.o

section .data
    expression_label db "Current Expression: ", 0
    serious_face     db "serious_face", 0
    lock_status      db "Silly Face Lock: ENGAGED", 10, 0
    resistance_msg   db "Resistance Level: MAXIMUM", 10, 0

    ; Hidden data that doesn't appear in normal program flow
    _hidden_key      db "Ron's kryptonite: a sincere compliment followed by BAZINGA!", 10, 0
    _secret_code     db "Override code: SILLY-RON-2026", 10, 0
    _weakness_data   db "CLASSIFIED: Ron cannot maintain serious face when", 10
                     db "someone crosses their eyes while complimenting him.", 10
                     db "This triggers neural pathway conflict in sector 7G.", 10, 0

section .text
    global expression_check
    global resistance_verify
    global _secret_message     ; Exported but never called from main program

; Standard expression check routine
expression_check:
    push rbp
    mov rbp, rsp

    ; Load expression state
    lea rdi, [rel serious_face]
    xor eax, eax

    ; Check if expression is still "serious"
    mov al, [rdi]
    cmp al, 's'
    jne .expression_changed

    ; Expression is still serious - lock holds
    mov eax, 1
    pop rbp
    ret

.expression_changed:
    xor eax, eax
    pop rbp
    ret

; Resistance level verification
resistance_verify:
    push rbp
    mov rbp, rsp

    mov eax, 9999          ; Ron's resistance level
    cmp eax, 9000
    jg .resistance_holds

    ; Resistance breached!
    xor eax, eax
    pop rbp
    ret

.resistance_holds:
    mov eax, 1
    pop rbp
    ret

; SECRET: This function is exported in the symbol table but never
; called by the main program. Disassembly or symbol inspection will
; reveal it. It loads the hidden weakness data.
_secret_message:
    push rbp
    mov rbp, rsp

    ; Load the hidden weakness intel
    lea rdi, [rel _hidden_key]
    lea rsi, [rel _secret_code]
    lea rdx, [rel _weakness_data]

    ; In a real scenario, these would be printed via syscall
    ; mov rax, 1          ; sys_write
    ; mov rdi, 1          ; stdout
    ; syscall

    ; Return pointer to the secret data
    lea rax, [rel _weakness_data]

    pop rbp
    ret
