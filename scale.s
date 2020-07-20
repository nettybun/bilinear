	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"scale.c"
	.text
	.global	__aeabi_ui2f
	.global	__aeabi_fmul
	.global	__aeabi_f2iz
	.global	__aeabi_ui2d
	.global	__aeabi_dmul
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.global	__aeabi_dadd
	.global	__aeabi_d2iz
	.align	2
	.global	scale
	.syntax unified
	.arm
	.fpu softvfp
	.type	scale, %function
scale:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #64
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	str	r2, [fp, #-72]	@ float
	ldr	r3, [fp, #-64]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r1, [r3, #1]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #2]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	ldr	r1, [fp, #-72]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-64]
	ldrb	r2, [r3, #4]	@ zero_extendqisi2
	ldrb	r1, [r3, #5]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #6]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	ldr	r1, [fp, #-72]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-64]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r1, [r3, #1]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #2]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_ui2d
	mov	r2, #0
	ldr	r3, .L6
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r4, r2
	mov	r5, r3
	ldr	r0, [fp, #-52]
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	mov	r2, #0
	ldr	r3, .L6+4
	bl	__aeabi_dadd
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_d2iz
	mov	r3, r0
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-64]
	ldrb	r2, [r3, #4]	@ zero_extendqisi2
	ldrb	r1, [r3, #5]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #6]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_ui2d
	mov	r2, #0
	ldr	r3, .L6
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r4, r2
	mov	r5, r3
	ldr	r0, [fp, #-48]
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	mov	r2, #0
	ldr	r3, .L6+4
	bl	__aeabi_dadd
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_d2iz
	mov	r3, r0
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L2
.L5:
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-40]
	mul	r3, r2, r3
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	asr	r3, r3, #11
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #11
	ldr	r2, [fp, #-36]
	sub	r3, r2, r3
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L3
.L4:
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-44]
	mul	r3, r2, r3
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	asr	r3, r3, #11
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	lsl	r3, r3, #11
	ldr	r2, [fp, #-24]
	sub	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-64]
	ldrb	r2, [r3, #8]	@ zero_extendqisi2
	ldrb	r1, [r3, #9]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #10]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #11]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	ldr	r3, [fp, #-64]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r1, [r3, #1]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #2]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r2, r3
	ldr	r3, [fp, #-32]
	mul	r2, r3, r2
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	add	r3, r0, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, [fp, #-16]
	rsb	r3, r3, #2048
	mul	r3, r2, r3
	ldr	r2, [fp, #-28]
	rsb	r2, r2, #2048
	mul	r2, r3, r2
	ldr	r3, [fp, #-64]
	ldrb	r1, [r3, #8]	@ zero_extendqisi2
	ldrb	r0, [r3, #9]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #10]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #11]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mov	ip, r3
	ldr	r3, [fp, #-64]
	ldrb	r1, [r3]	@ zero_extendqisi2
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #2]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mov	r1, r3
	ldr	r3, [fp, #-32]
	mul	r1, r3, r1
	ldr	r3, [fp, #-20]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, ip, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-16]
	mul	r3, r1, r3
	ldr	r1, [fp, #-28]
	rsb	r1, r1, #2048
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-64]
	ldrb	r1, [r3, #8]	@ zero_extendqisi2
	ldrb	r0, [r3, #9]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #10]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #11]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mov	ip, r3
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	mov	lr, r3
	ldr	r3, [fp, #-64]
	ldrb	r1, [r3]	@ zero_extendqisi2
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #2]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mul	r1, r3, lr
	ldr	r3, [fp, #-20]
	add	r3, r1, r3
	add	r3, ip, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-16]
	rsb	r3, r3, #2048
	mul	r3, r1, r3
	ldr	r1, [fp, #-28]
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-64]
	ldrb	r1, [r3, #8]	@ zero_extendqisi2
	ldrb	r0, [r3, #9]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #10]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #11]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mov	ip, r3
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	mov	lr, r3
	ldr	r3, [fp, #-64]
	ldrb	r1, [r3]	@ zero_extendqisi2
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #2]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mul	r1, r3, lr
	ldr	r3, [fp, #-20]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, ip, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-16]
	mul	r3, r1, r3
	ldr	r1, [fp, #-28]
	mul	r3, r1, r3
	add	r3, r2, r3
	add	r3, r3, #2097152
	asr	r2, r3, #22
	ldr	r3, [fp, #-68]
	ldrb	r1, [r3, #8]	@ zero_extendqisi2
	ldrb	r0, [r3, #9]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #10]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #11]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mov	ip, r3
	ldr	r3, [fp, #-68]
	ldrb	r1, [r3]	@ zero_extendqisi2
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	lsl	r0, r0, #8
	orr	r1, r0, r1
	ldrb	r0, [r3, #2]	@ zero_extendqisi2
	lsl	r0, r0, #16
	orr	r1, r0, r1
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r1
	mov	r1, r3
	ldr	r3, [fp, #-56]
	mul	r1, r3, r1
	ldr	r3, [fp, #-60]
	add	r3, r1, r3
	add	r3, ip, r3
	and	r2, r2, #255
	strb	r2, [r3]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L3:
	ldr	r3, [fp, #-68]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r1, [r3, #1]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #2]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r2, r3
	ldr	r3, [fp, #-60]
	cmp	r2, r3
	bhi	.L4
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L2:
	ldr	r3, [fp, #-68]
	ldrb	r2, [r3, #4]	@ zero_extendqisi2
	ldrb	r1, [r3, #5]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #6]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r2, r3
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	bhi	.L5
	nop
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
.L7:
	.align	2
.L6:
	.word	1084227584
	.word	1071644672
	.size	scale, .-scale
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Usage: ./scale input.simple output.simple 0.5\000"
	.global	__aeabi_d2f
	.global	__aeabi_f2uiz
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	ldr	r3, [fp, #-40]
	cmp	r3, #4
	beq	.L9
	ldr	r0, .L12
	bl	puts
	mov	r3, #1
	b	.L10
.L9:
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, #8]
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-44]
	add	r3, r3, #12
	ldr	r3, [r3]
	mov	r0, r3
	bl	atof
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_d2f
	mov	r3, r0
	str	r3, [fp, #-28]	@ float
	ldr	r0, [fp, #-36]
	bl	SIMPLE_open
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L11
	mov	r3, #1
	b	.L10
.L11:
	ldr	r3, [fp, #-24]
	ldrb	r2, [r3]	@ zero_extendqisi2
	ldrb	r1, [r3, #1]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #2]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	ldr	r1, [fp, #-28]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2uiz
	mov	r4, r0
	ldr	r3, [fp, #-24]
	ldrb	r2, [r3, #4]	@ zero_extendqisi2
	ldrb	r1, [r3, #5]	@ zero_extendqisi2
	lsl	r1, r1, #8
	orr	r2, r1, r2
	ldrb	r1, [r3, #6]	@ zero_extendqisi2
	lsl	r1, r1, #16
	orr	r2, r1, r2
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	ldr	r1, [fp, #-28]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2uiz
	mov	r3, r0
	mov	r1, r3
	mov	r0, r4
	bl	SIMPLE_new
	str	r0, [fp, #-20]
	ldr	r2, [fp, #-28]	@ float
	ldr	r1, [fp, #-20]
	ldr	r0, [fp, #-24]
	bl	scale
	ldr	r1, [fp, #-32]
	ldr	r0, [fp, #-20]
	bl	SIMPLE_save
	str	r0, [fp, #-16]
	ldr	r0, [fp, #-24]
	bl	SIMPLE_destroy
	ldr	r0, [fp, #-20]
	bl	SIMPLE_destroy
	ldr	r3, [fp, #-16]
.L10:
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
.L13:
	.align	2
.L12:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
