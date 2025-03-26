	.file	"calculadora.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"\tErro na alocacao de memoria!"
	.text
.global	empilhar
	.type	empilhar, @function
empilhar:
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
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 12 */
.L__stack_usage = 12
	movw r16,r24
	movw r8,r20
	movw r10,r22
	ldi r24,lo8(6)
	ldi r25,0
	call malloc
	movw r28,r24
	or r24,r25
	breq .L2
	movw r12,r8
	movw r14,r10
	st Y,r12
	std Y+1,r13
	std Y+2,r14
	std Y+3,r15
	std Y+4,r16
	std Y+5,r17
.L1:
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
	pop r11
	pop r10
	pop r9
	pop r8
	ret
.L2:
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call puts
	rjmp .L1
	.size	empilhar, .-empilhar
	.section	.rodata.str1.1
.LC5:
	.string	"\tPilha vazia!"
	.text
.global	desempilhar
	.type	desempilhar, @function
desempilhar:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r30,r24
	ld r28,Z
	ldd r29,Z+1
	sbiw r28,0
	breq .L5
	ldd r24,Y+4
	ldd r25,Y+5
	std Z+1,r25
	st Z,r24
.L4:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L5:
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call puts
	rjmp .L4
	.size	desempilhar, .-desempilhar
.global	operacao
	.type	operacao, @function
operacao:
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
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,36
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 36 */
/* stack size = 51 */
.L__stack_usage = 51
	cpi r16,lo8(45)
	brne .+2
	rjmp .L8
	brge .L9
	cpi r16,lo8(42)
	brne .+2
	rjmp .L10
	cpi r16,lo8(43)
	brne .+2
	rjmp .L11
	cpi r16,lo8(38)
	brne .+2
	rjmp .L12
.L16:
	ldi r22,0
	ldi r23,0
	ldi r24,0
	ldi r25,0
.L7:
	std Y+33,r22
	std Y+34,r23
	std Y+35,r24
	std Y+36,r25
	ldd r22,Y+33
	ldd r23,Y+34
	ldd r24,Y+35
	ldd r25,Y+36
/* epilogue start */
	adiw r28,36
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
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
	ret
.L9:
	cpi r16,lo8(47)
	brne .+2
	rjmp .L14
	cpi r16,lo8(124)
	brne .L16
	movw r12,r18
	movw r14,r20
	movw r20,r14
	movw r18,r12
	std Y+25,r22
	std Y+26,r23
	std Y+27,r24
	std Y+28,r25
	ldd r22,Y+25
	ldd r23,Y+26
	ldd r24,Y+27
	ldd r25,Y+28
/* epilogue start */
	adiw r28,36
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
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
	jmp powf
.L11:
	std Y+1,r18
	std Y+2,r19
	std Y+3,r20
	std Y+4,r21
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r20,Y+3
	ldd r21,Y+4
	std Y+5,r22
	std Y+6,r23
	std Y+7,r24
	std Y+8,r25
	ldd r22,Y+5
	ldd r23,Y+6
	ldd r24,Y+7
	ldd r25,Y+8
	call __addsf3
	rjmp .L7
.L8:
	movw r4,r18
	movw r6,r20
	movw r20,r6
	movw r18,r4
	std Y+9,r22
	std Y+10,r23
	std Y+11,r24
	std Y+12,r25
	ldd r22,Y+9
	ldd r23,Y+10
	ldd r24,Y+11
	ldd r25,Y+12
	call __subsf3
	rjmp .L7
.L14:
	movw r8,r18
	movw r10,r20
	movw r20,r10
	movw r18,r8
	std Y+13,r22
	std Y+14,r23
	std Y+15,r24
	std Y+16,r25
	ldd r22,Y+13
	ldd r23,Y+14
	ldd r24,Y+15
	ldd r25,Y+16
	call __divsf3
	rjmp .L7
.L10:
	std Y+17,r18
	std Y+18,r19
	std Y+19,r20
	std Y+20,r21
	ldd r18,Y+17
	ldd r19,Y+18
	ldd r20,Y+19
	ldd r21,Y+20
	std Y+21,r22
	std Y+22,r23
	std Y+23,r24
	std Y+24,r25
	ldd r22,Y+21
	ldd r23,Y+22
	ldd r24,Y+23
	ldd r25,Y+24
	call __mulsf3
	rjmp .L7
.L12:
	std Y+29,r22
	std Y+30,r23
	std Y+31,r24
	std Y+32,r25
	ldd r22,Y+29
	ldd r23,Y+30
	ldd r24,Y+31
	ldd r25,Y+32
/* epilogue start */
	adiw r28,36
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
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
	jmp sqrtf
	.size	operacao, .-operacao
	.section	.rodata.str1.1
.LC6:
	.string	" "
	.text
.global	resolverExp
	.type	resolverExp, @function
resolverExp:
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
	push r28
	push r29
	rcall .
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 6 */
/* stack size = 22 */
.L__stack_usage = 22
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	ldi r22,lo8(.LC6)
	ldi r23,hi8(.LC6)
	call strtok
	movw r14,r24
	ldi r17,lo8(43)
.L18:
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	brne .L24
	movw r24,r28
	adiw r24,1
	call desempilhar
	movw r30,r24
	ld r8,Z
	ldd r9,Z+1
	ldd r10,Z+2
	ldd r11,Z+3
	call free
	movw r24,r10
	movw r22,r8
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
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
	ret
.L24:
	movw r30,r14
	ld r24,Z
	cpi r24,lo8(48)
	brlt .+2
	rjmp .L19
	cpi r24,lo8(42)
	brge .L20
	cpi r24,lo8(38)
.L29:
	brne .L22
.L21:
	movw r24,r28
	adiw r24,1
	call desempilhar
	movw r8,r24
	movw r24,r28
	adiw r24,1
	call desempilhar
	movw r10,r24
	movw r30,r8
	ld r18,Z
	ldd r19,Z+1
	ldd r20,Z+2
	ldd r21,Z+3
	movw r30,r24
	ld r22,Z
	ldd r23,Z+1
	ldd r24,Z+2
	ldd r25,Z+3
	movw r30,r14
	ld r16,Z
	call operacao
	movw r4,r22
	movw r6,r24
	movw r22,r6
	movw r20,r4
	ldd r24,Y+1
	ldd r25,Y+2
	call empilhar
	std Y+2,r25
	std Y+1,r24
	movw r24,r8
	call free
	movw r24,r10
	call free
.L23:
	ldi r22,lo8(.LC6)
	ldi r23,hi8(.LC6)
	ldi r24,0
	ldi r25,0
	call strtok
	movw r14,r24
	rjmp .L18
.L20:
	subi r24,lo8(-(-42))
	mov r31,r17
	rjmp 2f
	1:
	lsr r31
	2:
	dec r24
	brpl 1b
	sbrc r31,0
	rjmp .L21
.L22:
	movw r24,r14
	call atof
	std Y+3,r22
	std Y+4,r23
	std Y+5,r24
	std Y+6,r25
	ldd r20,Y+3
	ldd r21,Y+4
	ldd r22,Y+5
	ldd r23,Y+6
	ldd r24,Y+1
	ldd r25,Y+2
	call empilhar
	std Y+2,r25
	std Y+1,r24
	rjmp .L23
.L19:
	cpi r24,lo8(124)
	rjmp .L29
	.size	resolverExp, .-resolverExp
	.section	.rodata.str1.1
.LC7:
	.string	"r"
.LC8:
	.string	"Erro ao abrir o arquivo %s.\n"
.LC9:
	.string	"Resultados do arquivo %s:\n"
.LC10:
	.string	"\n"
.LC11:
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
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	subi r28,-52
	sbc r29,__zero_reg__
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 204 */
/* stack size = 222 */
.L__stack_usage = 222
	movw r14,r22
	in r18,__SP_L__
	in r19,__SP_H__
	subi r28,lo8(-201)
	sbci r29,hi8(-201)
	std Y+1,r19
	st Y,r18
	subi r28,lo8(201)
	sbci r29,hi8(201)
	movw r18,r22
	lsl r18
	rol r19
	in r20,__SP_L__
	in r21,__SP_H__
	sub r20,r18
	sbc r21,r19
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r21
	out __SREG__,__tmp_reg__
	out __SP_L__,r20
	in r30,__SP_L__
	in r31,__SP_H__
	adiw r30,1
	movw r6,r30
	movw r16,r24
	subi r28,lo8(-203)
	sbci r29,hi8(-203)
	std Y+1,r31
	st Y,r30
	subi r28,lo8(203)
	sbci r29,hi8(203)
	movw r8,r30
	movw r10,r24
	mov r12,__zero_reg__
	mov r13,__zero_reg__
.L31:
	cp r12,r14
	cpc r13,r15
	brlt .L34
	mov r12,__zero_reg__
	mov r13,__zero_reg__
	ldi r24,lo8(.LC9)
	mov r4,r24
	ldi r24,hi8(.LC9)
	mov r5,r24
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	movw r10,r20
	ldi r25,lo8(.LC11)
	mov r8,r25
	ldi r25,hi8(.LC11)
	mov r9,r25
	movw r2,r20
.L35:
	cp r12,r14
	cpc r13,r15
	brge .+2
	rjmp .L38
	ldi r16,0
	ldi r17,0
.L39:
	cp r16,r14
	cpc r17,r15
	brge .L41
	subi r28,lo8(-203)
	sbci r29,hi8(-203)
	ld r30,Y
	ldd r31,Y+1
	subi r28,lo8(203)
	sbci r29,hi8(203)
	ld r24,Z+
	ld r25,Z+
	subi r28,lo8(-203)
	sbci r29,hi8(-203)
	std Y+1,r31
	st Y,r30
	subi r28,lo8(203)
	sbci r29,hi8(203)
	call fclose
	subi r16,-1
	sbci r17,-1
	rjmp .L39
.L34:
	movw r2,r10
	ldi r31,2
	add r10,r31
	adc r11,__zero_reg__
	ldi r22,lo8(.LC7)
	ldi r23,hi8(.LC7)
	movw r30,r2
	ld r24,Z
	ldd r25,Z+1
	call fopen
	movw r30,r8
	st Z+,r24
	st Z+,r25
	movw r8,r30
	or r24,r25
	brne .L32
	movw r30,r2
	ldd r24,Z+1
	push r24
	ld r24,Z
	push r24
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	push r25
	push r24
	call printf
.L41:
	subi r28,lo8(-201)
	sbci r29,hi8(-201)
	ld r18,Y
	ldd r19,Y+1
	subi r28,lo8(201)
	sbci r29,hi8(201)
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r19
	out __SREG__,__tmp_reg__
	out __SP_L__,r18
	subi r28,lo8(-201)
	sbci r29,hi8(-201)
	ld r20,Y
	ldd r21,Y+1
	subi r28,lo8(201)
	sbci r29,hi8(201)
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r21
	out __SREG__,__tmp_reg__
	out __SP_L__,r20
/* epilogue start */
	subi r28,52
	sbci r29,-1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
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
.L32:
	ldi r19,-1
	sub r12,r19
	sbc r13,r19
	rjmp .L31
.L38:
	movw r30,r16
	ld r24,Z
	ldd r25,Z+1
	subi r16,-2
	sbci r17,-1
	push r25
	push r24
	push r5
	push r4
	call printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
.L36:
	movw r30,r6
	ld r20,Z
	ldd r21,Z+1
	ldi r22,lo8(100)
	ldi r23,0
	movw r24,r28
	subi r24,-101
	sbci r25,-1
	call fgets
	or r24,r25
	brne .L37
	ldi r24,lo8(10)
	ldi r25,0
	call putchar
	ldi r31,-1
	sub r12,r31
	sbc r13,r31
	ldi r18,2
	add r6,r18
	adc r7,__zero_reg__
	rjmp .L35
.L37:
	ldi r22,lo8(.LC10)
	ldi r23,hi8(.LC10)
	movw r24,r28
	subi r24,-101
	sbci r25,-1
	call strcspn
	movw r30,r28
	subi r30,-101
	sbci r31,-1
	add r30,r24
	adc r31,r25
	st Z,__zero_reg__
	movw r22,r28
	subi r22,-101
	sbci r23,-1
	movw r24,r2
	call strcpy
	movw r24,r28
	subi r24,-101
	sbci r25,-1
	call resolverExp
	push r25
	push r24
	push r23
	push r22
	push r11
	push r10
	push r9
	push r8
	call printf
	in r18,__SP_L__
	in r19,__SP_H__
	subi r18,-8
	sbci r19,-1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r19
	out __SREG__,__tmp_reg__
	out __SP_L__,r18
	rjmp .L36
	.size	lerArquivos, .-lerArquivos
.global	gerarAssembly
	.type	gerarAssembly, @function
gerarAssembly:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbi 0x4,5
	ldi r25,lo8(32)
.L43:
	in r24,0x5
	eor r24,r25
	out 0x5,r24
	ldi r18,lo8(159999)
	ldi r19,hi8(159999)
	ldi r24,hlo8(159999)
1:	subi r18,1
	sbci r19,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	rjmp .L43
	.size	gerarAssembly, .-gerarAssembly
	.section	.rodata.str1.1
.LC0:
	.string	"expressoes1.txt"
.LC1:
	.string	"expressoes2.txt"
.LC2:
	.string	"expressoes3.txt"
	.section	.rodata
.LC12:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
	rcall .
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 6 */
/* stack size = 6 */
.L__stack_usage = 6
	ldi r24,lo8(6)
	ldi r30,lo8(.LC12)
	ldi r31,hi8(.LC12)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	ldi r22,lo8(3)
	ldi r23,0
	movw r24,r28
	adiw r24,1
	call lerArquivos
	ldi r24,0
	ldi r25,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	ret
	.size	main, .-main
.global	__mulsf3
.global	__divsf3
.global	__subsf3
.global	__addsf3
	.ident	"GCC: (GNU) 14.2.0"
.global __do_copy_data
