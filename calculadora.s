	.file	"calculadora.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.data
.LC0:
	.string	"\tPilha vazia!"
	.text
.global	desempilhar
	.type	desempilhar, @function
desempilhar:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	movw r30,r24
	ld r28,Z
	ldd r29,Z+1
	sbiw r28,0
	breq .L2
	ldd r24,Y+4
	ldd r25,Y+5
	std Z+1,r25
	st Z,r24
	rjmp .L3
.L2:
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call puts
.L3:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	desempilhar, .-desempilhar
.global	operacao
	.type	operacao, @function
operacao:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
/* prologue: function */
/* frame size = 0 */
	movw r12,r22
	movw r14,r24
	movw r8,r18
	movw r10,r20
	cpi r16,lo8(43)
	breq .L10
	cpi r16,lo8(44)
	brge .L14
	cpi r16,lo8(38)
	breq .L8
	cpi r16,lo8(42)
	breq .L9
	cpi r16,lo8(37)
	brne .L6
	rjmp .L18
.L14:
	cpi r16,lo8(47)
	breq .L12
	cpi r16,lo8(94)
	breq .L13
	cpi r16,lo8(45)
	breq .L11
.L6:
	ldi r22,lo8(0)
	ldi r23,lo8(0)
	ldi r24,lo8(0)
	ldi r25,lo8(0)
	rjmp .L15
.L10:
	call __addsf3
	rjmp .L15
.L11:
	call __subsf3
	rjmp .L15
.L12:
	movw r24,r20
	movw r22,r18
	ldi r18,lo8(0x0)
	ldi r19,hi8(0x0)
	ldi r20,hlo8(0x0)
	ldi r21,hhi8(0x0)
	call __nesf2
	tst r24
	brne .L16
	ldi r22,lo8(0)
	ldi r23,lo8(0)
	ldi r24,lo8(-64)
	ldi r25,lo8(127)
	rjmp .L15
.L16:
	movw r24,r14
	movw r22,r12
	movw r20,r10
	movw r18,r8
	call __divsf3
	rjmp .L15
.L9:
	call __mulsf3
	rjmp .L15
.L13:
	call pow
	rjmp .L15
.L8:
	call sqrt
	rjmp .L15
.L18:
	call fmod
.L15:
/* epilogue start */
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
	.size	operacao, .-operacao
	.data
.LC1:
	.string	"\tErro na aloca\303\247\303\243o de mem\303\263ria!"
	.text
.global	empilhar
	.type	empilhar, @function
empilhar:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	movw r12,r24
	movw r14,r20
	movw r16,r22
	ldi r24,lo8(6)
	ldi r25,hi8(6)
	call malloc
	movw r28,r24
	sbiw r24,0
	breq .L20
	st Y,r14
	std Y+1,r15
	std Y+2,r16
	std Y+3,r17
	std Y+5,r13
	std Y+4,r12
	rjmp .L21
.L20:
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call puts
.L21:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	empilhar, .-empilhar
	.data
.LC2:
	.string	" "
.LC3:
	.string	"RES"
.LC4:
	.string	"\tResultado N n\303\243o foi encontrado."
.LC5:
	.string	"MEM"
.LC6:
	.string	"V MEM"
.LC7:
	.string	"+-/*^&%"
.LC8:
	.string	"\tErro: Pilha nao contem elementos suficientes para a operacao!"
.LC9:
	.string	"\tErro: Pilha final vazia!"
	.text
.global	resolverExp
	.type	resolverExp, @function
resolverExp:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r29
	push r28
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	ldi r22,lo8(.LC2)
	ldi r23,hi8(.LC2)
	call strtok
	movw r16,r24
	movw r8,r28
	sec
	adc r8,__zero_reg__
	adc r9,__zero_reg__
	rjmp .L24
.L32:
	movw r30,r16
	ld r22,Z
	cpi r22,lo8(40)
	breq .+2
	rjmp .L25
	movw r24,r16
	ldi r22,lo8(.LC3)
	ldi r23,hi8(.LC3)
	call strstr
	sbiw r24,0
	breq .L26
	movw r24,r16
	adiw r24,5
	call atoi
	movw r30,r24
	sbrc r25,7
	rjmp .L27
	lds r24,contResultados
	lds r25,(contResultados)+1
	cp r30,r24
	cpc r31,r25
	brge .L27
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(resultado))
	sbci r31,hi8(-(resultado))
	ld r20,Z
	ldd r21,Z+1
	ldd r22,Z+2
	ldd r23,Z+3
	rjmp .L37
.L27:
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	rjmp .L36
.L26:
	movw r24,r16
	ldi r22,lo8(.LC5)
	ldi r23,hi8(.LC5)
	call strstr
	sbiw r24,0
	breq .L29
	lds r20,memoria
	lds r21,(memoria)+1
	lds r22,(memoria)+2
	lds r23,(memoria)+3
.L37:
	ldd r24,Y+1
	ldd r25,Y+2
	call empilhar
	std Y+2,r25
	std Y+1,r24
	rjmp .L28
.L29:
	movw r24,r16
	ldi r22,lo8(.LC6)
	ldi r23,hi8(.LC6)
	call strstr
	sbiw r24,0
	brne .+2
	rjmp .L28
	movw r24,r16
	adiw r24,6
	call atof
	sts memoria,r22
	sts (memoria)+1,r23
	sts (memoria)+2,r24
	sts (memoria)+3,r25
	rjmp .L28
.L25:
	clr r23
	sbrc r22,7
	com r23
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call strchr
	sbiw r24,0
	brne .+2
	rjmp .L30
	ldd r30,Y+1
	ldd r31,Y+2
	sbiw r30,0
	brne .+2
	rjmp .L31
	ldd r24,Z+4
	ldd r25,Z+5
	or r24,r25
	breq .L31
	movw r24,r8
	call desempilhar
	movw r10,r24
	movw r24,r8
	call desempilhar
	movw r12,r24
	movw r30,r24
	ld r22,Z
	ldd r23,Z+1
	ldd r24,Z+2
	ldd r25,Z+3
	movw r30,r10
	ld r18,Z
	ldd r19,Z+1
	ldd r20,Z+2
	ldd r21,Z+3
	movw r30,r16
	ld r16,Z
	call operacao
	movw r14,r22
	movw r16,r24
	ldd r24,Y+1
	ldd r25,Y+2
	movw r22,r16
	movw r20,r14
	call empilhar
	std Y+2,r25
	std Y+1,r24
	lds r24,contResultados
	lds r25,(contResultados)+1
	movw r30,r24
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(resultado))
	sbci r31,hi8(-(resultado))
	st Z,r14
	std Z+1,r15
	std Z+2,r16
	std Z+3,r17
	adiw r24,1
	sts (contResultados)+1,r25
	sts contResultados,r24
	movw r24,r10
	call free
	movw r24,r12
	call free
	rjmp .L28
.L31:
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
.L36:
	call puts
	rjmp .L28
.L30:
	movw r24,r16
	call atof
	movw r14,r22
	movw r16,r24
	ldd r24,Y+1
	ldd r25,Y+2
	movw r22,r16
	movw r20,r14
	call empilhar
	std Y+2,r25
	std Y+1,r24
	lds r24,contResultados
	lds r25,(contResultados)+1
	movw r30,r24
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(resultado))
	sbci r31,hi8(-(resultado))
	st Z,r14
	std Z+1,r15
	std Z+2,r16
	std Z+3,r17
	adiw r24,1
	sts (contResultados)+1,r25
	sts contResultados,r24
.L28:
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r22,lo8(.LC2)
	ldi r23,hi8(.LC2)
	call strtok
	movw r16,r24
.L24:
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .+2
	rjmp .L32
	ldd r24,Y+1
	ldd r25,Y+2
	or r24,r25
	breq .L33
	movw r24,r28
	adiw r24,1
	call desempilhar
	movw r30,r24
	ld r12,Z
	ldd r14,Z+1
	ldd r16,Z+2
	ldd r17,Z+3
	call free
	rjmp .L34
.L33:
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call puts
	clr r12
	clr r14
	ldi r16,lo8(0)
	ldi r17,lo8(0)
.L34:
	mov r18,r12
	mov r19,r14
	movw r22,r18
	movw r24,r16
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r28
	pop r29
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
	.size	resolverExp, .-resolverExp
	.data
.LC10:
	.string	"r"
.LC11:
	.string	"Erro ao abrir o arquivo %s.\n"
.LC12:
	.string	"Resultados do arquivo %s:\n"
.LC13:
	.string	"\n"
.LC14:
	.string	"Expressao: %s = %.0f\n"
	.text
.global	lerArquivos
	.type	lerArquivos, @function
lerArquivos:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
	subi r28,lo8(-(-200))
	sbci r29,hi8(-(-200))
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 200 */
	movw r8,r22
	movw r14,r24
	clr r12
	clr r13
	movw r10,r28
	sec
	adc r10,__zero_reg__
	adc r11,__zero_reg__
	ldi r23,lo8(101)
	mov r6,r23
	mov r7,__zero_reg__
	add r6,r28
	adc r7,r29
	ldi r22,lo8(.LC14)
	mov r2,r22
	ldi r22,hi8(.LC14)
	mov r3,r22
	ldi r21,lo8(.LC11)
	mov r4,r21
	ldi r21,hi8(.LC11)
	mov r5,r21
	rjmp .L39
.L44:
	movw r26,r14
	ld r24,X+
	ld r25,X
	ldi r22,lo8(.LC10)
	ldi r23,hi8(.LC10)
	call fopen
	movw r16,r24
	sbiw r24,0
	brne .L40
	rcall .
	rcall .
	in r30,__SP_L__
	in r31,__SP_H__
	std Z+2,r5
	std Z+1,r4
	movw r26,r14
	ld r24,X+
	ld r25,X
	std Z+4,r25
	std Z+3,r24
	call printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L41
.L40:
	rcall .
	rcall .
	ldi r18,lo8(.LC12)
	ldi r19,hi8(.LC12)
	in r30,__SP_L__
	in r31,__SP_H__
	std Z+2,r19
	std Z+1,r18
	movw r26,r14
	ld r24,X+
	ld r25,X
	std Z+4,r25
	std Z+3,r24
	call printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L42
.L43:
	movw r24,r10
	ldi r22,lo8(.LC13)
	ldi r23,hi8(.LC13)
	call strcspn
	movw r30,r24
	add r30,r10
	adc r31,r11
	st Z,__zero_reg__
	movw r24,r6
	movw r22,r10
	call strcpy
	movw r24,r10
	call resolverExp
	in r30,__SP_L__
	in r31,__SP_H__
	sbiw r30,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r31
	out __SREG__,__tmp_reg__
	out __SP_L__,r30
	adiw r30,1
	in r26,__SP_L__
	in r27,__SP_H__
	adiw r26,1+1
	st X,r3
	st -X,r2
	sbiw r26,1
	std Z+3,r7
	std Z+2,r6
	std Z+4,r22
	std Z+5,r23
	std Z+6,r24
	std Z+7,r25
	call printf
	in r30,__SP_L__
	in r31,__SP_H__
	adiw r30,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r31
	out __SREG__,__tmp_reg__
	out __SP_L__,r30
.L42:
	movw r24,r10
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	movw r20,r16
	call fgets
	or r24,r25
	brne .L43
	ldi r24,lo8(10)
	ldi r25,hi8(10)
	call putchar
	movw r24,r16
	call fclose
.L41:
	sec
	adc r12,__zero_reg__
	adc r13,__zero_reg__
	ldi r18,lo8(2)
	ldi r19,hi8(2)
	add r14,r18
	adc r15,r19
.L39:
	cp r12,r8
	cpc r13,r9
	brge .+2
	rjmp .L44
/* epilogue start */
	subi r28,lo8(-(200))
	sbci r29,hi8(-(200))
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r28
	pop r29
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	ret
	.size	lerArquivos, .-lerArquivos
.global	main
	.type	main, @function
main:
	push r29
	push r28
	rcall .
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 6 */
	movw r26,r28
	adiw r26,1
	ldi r30,lo8(C.19.1808)
	ldi r31,hi8(C.19.1808)
	ldi r24,lo8(6)
.L47:
	ld r0,Z+
	st X+,r0
	subi r24,lo8(-(-1))
	brne .L47
	movw r24,r28
	adiw r24,1
	ldi r22,lo8(3)
	ldi r23,hi8(3)
	call lerArquivos
	ldi r24,lo8(0)
	ldi r25,hi8(0)
/* epilogue start */
	adiw r28,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r28
	pop r29
	ret
	.size	main, .-main
.global	memoria
.global	memoria
	.section .bss
	.type	memoria, @object
	.size	memoria, 4
memoria:
	.skip 4,0
.global	contResultados
.global	contResultados
	.type	contResultados, @object
	.size	contResultados, 2
contResultados:
	.skip 2,0
	.data
.LC15:
	.string	"expressoes1.txt"
.LC16:
	.string	"expressoes2.txt"
.LC17:
	.string	"expressoes3.txt"
	.type	C.19.1808, @object
	.size	C.19.1808, 6
C.19.1808:
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.comm resultado,400,1
.global __do_copy_data
.global __do_clear_bss
