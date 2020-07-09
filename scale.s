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
	.align	2
	.global	getpixel
	.syntax unified
	.arm
	.fpu softvfp
	.type	getpixel, %function
getpixel:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	ldr	r3, [fp, #-16]
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
	ldr	r3, [fp, #-24]
	mul	r2, r3, r2
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-16]
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
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	getpixel, .-getpixel
	.align	2
	.global	putpixel
	.syntax unified
	.arm
	.fpu softvfp
	.type	putpixel, %function
putpixel:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	strb	r3, [fp, #-25]
	ldr	r3, [fp, #-16]
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
	ldr	r3, [fp, #-24]
	mul	r2, r3, r2
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-16]
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
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r2, [fp, #-25]
	strb	r2, [r3]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	putpixel, .-putpixel
	.align	2
	.global	lerp
	.syntax unified
	.arm
	.fpu softvfp
	.type	lerp, %function
lerp:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-8]
	sub	r3, r2, r3
	ldr	r2, [fp, #-16]
	mul	r2, r3, r2
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	lerp, .-lerp
	.align	2
	.global	blerp
	.syntax unified
	.arm
	.fpu softvfp
	.type	blerp, %function
blerp:
	@ args = 8, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #12
	mov	ip, r0
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	mov	r3, ip
	strb	r3, [fp, #-13]
	mov	r3, r0
	strb	r3, [fp, #-14]
	mov	r3, r1
	strb	r3, [fp, #-15]
	mov	r3, r2
	strb	r3, [fp, #-16]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	ldrb	r1, [fp, #-14]	@ zero_extendqisi2
	ldr	r2, [fp, #4]
	mov	r0, r3
	bl	lerp
	mov	r4, r0
	ldrb	r3, [fp, #-15]	@ zero_extendqisi2
	ldrb	r1, [fp, #-16]	@ zero_extendqisi2
	ldr	r2, [fp, #4]
	mov	r0, r3
	bl	lerp
	mov	r3, r0
	ldr	r2, [fp, #8]
	mov	r1, r3
	mov	r0, r4
	bl	lerp
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
	.size	blerp, .-blerp
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
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #72
	str	r0, [fp, #-72]
	str	r1, [fp, #-76]
	str	r2, [fp, #-80]	@ float
	ldr	r3, [fp, #-72]
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
	ldr	r1, [fp, #-80]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-72]
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
	ldr	r1, [fp, #-80]	@ float
	mov	r0, r3
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-72]
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
	ldr	r3, .L13
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
	ldr	r3, .L13+4
	bl	__aeabi_dadd
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_d2iz
	mov	r3, r0
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-72]
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
	ldr	r3, .L13
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
	ldr	r3, .L13+4
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
	b	.L9
.L12:
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
	b	.L10
.L11:
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
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-32]
	mov	r1, r3
	ldr	r0, [fp, #-72]
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-65]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	mov	r1, r3
	ldr	r3, [fp, #-32]
	mov	r2, r3
	ldr	r0, [fp, #-72]
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-64]
	ldr	r1, [fp, #-20]
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	mov	r2, r3
	ldr	r0, [fp, #-72]
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-63]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	mov	r1, r3
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	mov	r2, r3
	ldr	r0, [fp, #-72]
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-62]
	ldrb	r3, [fp, #-65]	@ zero_extendqisi2
	ldr	r2, [fp, #-16]
	rsb	r2, r2, #2048
	mul	r3, r2, r3
	ldr	r2, [fp, #-28]
	rsb	r2, r2, #2048
	mul	r2, r3, r2
	ldrb	r3, [fp, #-64]	@ zero_extendqisi2
	ldr	r1, [fp, #-16]
	mul	r3, r1, r3
	ldr	r1, [fp, #-28]
	rsb	r1, r1, #2048
	mul	r3, r1, r3
	add	r2, r2, r3
	ldrb	r3, [fp, #-63]	@ zero_extendqisi2
	ldr	r1, [fp, #-16]
	rsb	r1, r1, #2048
	mul	r3, r1, r3
	ldr	r1, [fp, #-28]
	mul	r3, r1, r3
	add	r2, r2, r3
	ldrb	r3, [fp, #-62]	@ zero_extendqisi2
	ldr	r1, [fp, #-16]
	mul	r3, r1, r3
	ldr	r1, [fp, #-28]
	mul	r3, r1, r3
	add	r3, r2, r3
	add	r3, r3, #2097152
	asr	r3, r3, #22
	strb	r3, [fp, #-61]
	ldr	r1, [fp, #-60]
	ldr	r2, [fp, #-56]
	ldrb	r3, [fp, #-61]	@ zero_extendqisi2
	ldr	r0, [fp, #-76]
	bl	putpixel
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L10:
	ldr	r3, [fp, #-76]
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
	bhi	.L11
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L9:
	ldr	r3, [fp, #-76]
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
	bhi	.L12
	nop
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
.L14:
	.align	2
.L13:
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
	beq	.L16
	ldr	r0, .L19
	bl	puts
	mov	r3, #1
	b	.L17
.L16:
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
	bne	.L18
	mov	r3, #1
	b	.L17
.L18:
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
.L17:
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
.L20:
	.align	2
.L19:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
