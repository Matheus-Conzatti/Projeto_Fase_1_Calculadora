.global _start
.global div_avr
.global pow_avr
.global mod_avr

.section .text

_start:
    ldi r16, 0
    ldi r17, 0
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    sub r16, r17
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 0
    call div_avr
    ldi r16, 0
    ldi r17, 0
    call pow_avr
    ldi r16, 0
    ldi r17, 0
    call mod_avr
    ldi r16, 0
    ldi r17, 4
    mul r16, r17
    ldi r16, 0
    ldi r17, 7
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    sub r16, r17
    ldi r16, 0
    ldi r17, 0
    call div_avr
    ldi r16, 0
    ldi r17, 0
    call pow_avr
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 0
    call div_avr
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 0
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 0
    call mod_avr
    ldi r16, 0
    ldi r17, 2
    call pow_avr
    ldi r16, 0
    ldi r17, 0
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 0
    call pow_avr
    ldi r16, 0
    ldi r17, 0
    call div_avr
    ldi r16, 0
    ldi r17, 0
    call mod_avr
    ldi r16, 0
    ldi r17, 0
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 7
    add r16, r17
    ldi r16, 0
    ldi r17, 0
    mul r16, r17
    ldi r16, 0
    ldi r17, 9
    call div_avr
    rjmp _start   ; Loop infinito para evitar comportamento indefinido

; ===================================
; Implementação das funções matemáticas
; ===================================
div_avr:
    clr r18
loop_div:
    cp r16, r17
    brlo fim_div
    sub r16, r17
    inc r18
    rjmp loop_div
fim_div:
    mov r16, r18
    ret

pow_avr:
    ldi r18, 1
loop_pow:
    cp r17, r0
    breq fim_pow
    mul r16, r18
    mov r18, r0
    dec r17
    rjmp loop_pow
fim_pow:
    mov r16, r18
    ret

mod_avr:
loop_mod:
    cp r16, r17
    brlo fim_mod
    sub r16, r17
    rjmp loop_mod
fim_mod:
    ret
