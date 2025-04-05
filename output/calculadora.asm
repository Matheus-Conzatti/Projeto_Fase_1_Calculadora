; Definição dos registradores
.equ UBRR0L = 0xC4
.equ UCSR0B = 0xC1
.equ UCSR0C = 0xC2
.equ UCSR0A = 0xC0
.equ UDR0   = 0xC6
.equ TXEN0  = 3
.equ UCSZ01 = 2
.equ UCSZ00 = 1
.equ UDRE0  = 5

.text
.global start
start:
    ; Operando 1
    ldi r30, lo8(16896)
    ldi r31, hi8(16896)
    ; Operando 2
    ldi r24, lo8(17408)
    ldi r25, hi8(17408)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(17664)
    ldi r31, hi8(17664)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    sub r30, r24
    ; Operando 1
    ldi r30, lo8(17920)
    ldi r31, hi8(17920)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(18432)
    ldi r31, hi8(18432)
    ; Operando 2
    ldi r24, lo8(17408)
    ldi r25, hi8(17408)
    call div_avr
    ; Operando 1
    ldi r30, lo8(18560)
    ldi r31, hi8(18560)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    call pow_avr
    ; Operando 1
    ldi r30, lo8(18688)
    ldi r31, hi8(18688)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    call mod_avr
    ; Operando 1
    ldi r30, lo8(16384)
    ldi r31, hi8(16384)
    ; Operando 2
    ldi r24, lo8(18176)
    ldi r25, hi8(18176)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(19200)
    ldi r31, hi8(19200)
    ; Operando 2
    ldi r24, lo8(17408)
    ldi r25, hi8(17408)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(0)
    ldi r31, hi8(0)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(16896)
    ldi r31, hi8(16896)
    ; Operando 2
    ldi r24, lo8(18176)
    ldi r25, hi8(18176)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(0)
    ldi r31, hi8(0)
    ; Operando 2
    ldi r24, lo8(18560)
    ldi r25, hi8(18560)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(19328)
    ldi r31, hi8(19328)
    ; Operando 2
    ldi r24, lo8(18176)
    ldi r25, hi8(18176)
    sub r30, r24
    ; Operando 1
    ldi r30, lo8(18432)
    ldi r31, hi8(18432)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    call div_avr
    ; Operando 1
    ldi r30, lo8(18560)
    ldi r31, hi8(18560)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    call pow_avr
    ; Operando 1
    ldi r30, lo8(17664)
    ldi r31, hi8(17664)
    ; Operando 2
    ldi r24, lo8(17920)
    ldi r25, hi8(17920)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(20032)
    ldi r31, hi8(20032)
    ; Operando 2
    ldi r24, lo8(17664)
    ldi r25, hi8(17664)
    call div_avr
    ; Operando 1
    ldi r30, lo8(19456)
    ldi r31, hi8(19456)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(17664)
    ldi r31, hi8(17664)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(18176)
    ldi r31, hi8(18176)
    ; Operando 2
    ldi r24, lo8(17920)
    ldi r25, hi8(17920)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(18432)
    ldi r31, hi8(18432)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    call mod_avr
    ; Operando 1
    ldi r30, lo8(0)
    ldi r31, hi8(0)
    ; Operando 2
    ldi r24, lo8(0)
    ldi r25, hi8(0)
    call pow_avr
    ; Operando 1
    ldi r30, lo8(15360)
    ldi r31, hi8(15360)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(18688)
    ldi r31, hi8(18688)
    ; Operando 2
    ldi r24, lo8(17664)
    ldi r25, hi8(17664)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(16896)
    ldi r31, hi8(16896)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(17408)
    ldi r31, hi8(17408)
    ; Operando 2
    ldi r24, lo8(16384)
    ldi r25, hi8(16384)
    call pow_avr
    ; Operando 1
    ldi r30, lo8(18944)
    ldi r31, hi8(18944)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    call div_avr
    ; Operando 1
    ldi r30, lo8(19456)
    ldi r31, hi8(19456)
    ; Operando 2
    ldi r24, lo8(17408)
    ldi r25, hi8(17408)
    call mod_avr
    ; Operando 1
    ldi r30, lo8(20032)
    ldi r31, hi8(20032)
    ; Operando 2
    ldi r24, lo8(17920)
    ldi r25, hi8(17920)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(16384)
    ldi r31, hi8(16384)
    ; Operando 2
    ldi r24, lo8(18432)
    ldi r25, hi8(18432)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(0)
    ldi r31, hi8(0)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(16896)
    ldi r31, hi8(16896)
    ; Operando 2
    ldi r24, lo8(18176)
    ldi r25, hi8(18176)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(17664)
    ldi r31, hi8(17664)
    ; Operando 2
    ldi r24, lo8(16896)
    ldi r25, hi8(16896)
    mul r30, r124
    ; Operando 1
    ldi r30, lo8(0)
    ldi r31, hi8(0)
    ; Operando 2
    ldi r24, lo8(19328)
    ldi r25, hi8(19328)
    add r30, r24
    ; Operando 1
    ldi r30, lo8(0)
    ldi r31, hi8(0)
    ; Operando 2
    ldi r24, lo8(0)
    ldi r25, hi8(0)
    call div_avr
    ; Operando 1
    ldi r30, lo8(31744)
    ldi r31, hi8(31744)
    ; Operando 2
    ldi r24, lo8(18560)
    ldi r25, hi8(18560)
    mul r30, r124
    rjmp _start

; Inicializa comunicação serial
uart_init:
    ldi r16, 103              ; Baud rate 9600 (para 16MHz)
    out UBRR0L, r16
    ldi r16, (1<<TXEN0)
    out UCSR0B, r16
    ldi r16, (1<<UCSZ01)|(1<<UCSZ00)
    out UCSR0C, r16
    ret

; Envia caractere via serial
uart_transmit:
    sbis UCSR0A, UDRE0
    rjmp uart_transmit
    out UDR0, r16
    ret

; Converte inteiro de 8 bits para 2 dígitos hex e envia
print_int:
    push r18
    push r19
    mov r18, r16
    swap r18
    andi r18, 0x0F
    cpi r18, 10
    brlt pi_digit1
    subi r18, -55
    rjmp pi_send1
pi_digit1:
    subi r18, -48
pi_send1:
    mov r16, r18
    rcall uart_transmit
    pop r19
    push r19
    mov r19, r16
    andi r19, 0x0F
    cpi r19, 10
    brlt pi_digit2
    subi r19, -55
    rjmp pi_send2
pi_digit2:
    subi r19, -48
pi_send2:
    mov r16, r19
    rcall uart_transmit
    pop r18
    ret
