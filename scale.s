	.cpu arm10tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"scale.c"
	.text
	.align	2
	.global	getpixel
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
	ldr	r2, [fp, #-16]
	ldrb	r1, [r2, #0]	@ zero_extendqisi2
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r2, r3
	ldr	r3, [fp, #-24]
	mul	r2, r3, r2
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	ldrb	r1, [r2, #8]	@ zero_extendqisi2
	ldrb	r3, [r2, #9]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #10]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #11]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	getpixel, .-getpixel
	.align	2
	.global	putpixel
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
	ldr	r2, [fp, #-16]
	ldrb	r1, [r2, #0]	@ zero_extendqisi2
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r2, r3
	ldr	r3, [fp, #-24]
	mul	r2, r3, r2
	ldr	r3, [fp, #-20]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-16]
	ldrb	r1, [r2, #8]	@ zero_extendqisi2
	ldrb	r3, [r2, #9]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #10]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #11]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r2, r2, r3
	ldrb	r3, [fp, #-25]
	strb	r3, [r2, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	putpixel, .-putpixel
	.global	__aeabi_fsub
	.global	__aeabi_fmul
	.global	__aeabi_fadd
	.align	2
	.global	lerp
	.type	lerp, %function
lerp:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-8]	@ float
	str	r1, [fp, #-12]	@ float
	str	r2, [fp, #-16]	@ float
	ldr	r3, [fp, #-12]	@ float
	ldr	r2, [fp, #-8]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fsub
	mov	r3, r0
	ldr	r2, [fp, #-16]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fmul
	mov	r3, r0
	ldr	r2, [fp, #-8]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fadd
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
	.size	lerp, .-lerp
	.align	2
	.global	blerp
	.type	blerp, %function
blerp:
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-16]	@ float
	str	r1, [fp, #-20]	@ float
	str	r2, [fp, #-24]	@ float
	str	r3, [fp, #-28]	@ float
	ldr	r0, [fp, #-16]	@ float
	ldr	r1, [fp, #-20]	@ float
	ldr	r2, [fp, #4]	@ float
	bl	lerp
	mov	r4, r0
	ldr	r0, [fp, #-24]	@ float
	ldr	r1, [fp, #-28]	@ float
	ldr	r2, [fp, #4]	@ float
	bl	lerp
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	ldr	r2, [fp, #8]	@ float
	bl	lerp
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, pc}
	.size	blerp, .-blerp
	.global	__aeabi_i2f
	.global	__aeabi_f2iz
	.global	__aeabi_fdiv
	.global	__aeabi_ui2f
	.global	__aeabi_f2uiz
	.align	2
	.global	scale
	.type	scale, %function
scale:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, lr}
	add	fp, sp, #24
	sub	sp, sp, #68
	str	r0, [fp, #-72]
	str	r1, [fp, #-76]
	str	r2, [fp, #-80]	@ float
	str	r3, [fp, #-84]	@ float
	ldr	r2, [fp, #-72]
	ldrb	r1, [r2, #0]	@ zero_extendqisi2
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r0, r3
	bl	__aeabi_i2f
	mov	r3, r0
	ldr	r2, [fp, #-80]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-68]
	ldr	r2, [fp, #-72]
	ldrb	r1, [r2, #4]	@ zero_extendqisi2
	ldrb	r3, [r2, #5]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #6]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #7]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r0, r3
	bl	__aeabi_i2f
	mov	r3, r0
	ldr	r2, [fp, #-84]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-64]
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L10
.L13:
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L11
.L12:
	ldr	r0, [fp, #-60]
	bl	__aeabi_i2f
	mov	r4, r0
	ldr	r0, [fp, #-68]
	bl	__aeabi_i2f
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	bl	__aeabi_fdiv
	mov	r3, r0
	mov	r4, r3
	ldr	r2, [fp, #-72]
	ldrb	r1, [r2, #0]	@ zero_extendqisi2
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	sub	r3, r3, #1
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	bl	__aeabi_fmul
	mov	r3, r0
	str	r3, [fp, #-52]	@ float
	ldr	r0, [fp, #-56]
	bl	__aeabi_i2f
	mov	r4, r0
	ldr	r0, [fp, #-64]
	bl	__aeabi_i2f
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	bl	__aeabi_fdiv
	mov	r3, r0
	mov	r4, r3
	ldr	r2, [fp, #-72]
	ldrb	r1, [r2, #4]	@ zero_extendqisi2
	ldrb	r3, [r2, #5]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #6]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #7]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	sub	r3, r3, #1
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	bl	__aeabi_fmul
	mov	r3, r0
	str	r3, [fp, #-48]	@ float
	ldr	r0, [fp, #-52]	@ float
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-44]
	ldr	r0, [fp, #-48]	@ float
	bl	__aeabi_f2iz
	mov	r3, r0
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-44]
	ldr	r2, [fp, #-40]
	ldr	r0, [fp, #-72]
	mov	r1, r3
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-33]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	ldr	r2, [fp, #-40]
	ldr	r0, [fp, #-72]
	mov	r1, r3
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-32]
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	ldr	r0, [fp, #-72]
	mov	r1, r2
	mov	r2, r3
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-31]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	mov	r2, r3
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	ldr	r0, [fp, #-72]
	mov	r1, r2
	mov	r2, r3
	bl	getpixel
	mov	r3, r0
	strb	r3, [fp, #-30]
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r5, r0
	ldrb	r3, [fp, #-32]	@ zero_extendqisi2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r6, r0
	ldrb	r3, [fp, #-31]	@ zero_extendqisi2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r7, r0
	ldrb	r3, [fp, #-30]	@ zero_extendqisi2
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r8, r0
	ldr	r0, [fp, #-44]
	bl	__aeabi_i2f
	mov	r2, r0
	ldr	r3, [fp, #-52]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fsub
	mov	r3, r0
	mov	r4, r3
	ldr	r0, [fp, #-40]
	bl	__aeabi_i2f
	mov	r2, r0
	ldr	r3, [fp, #-48]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fsub
	mov	r3, r0
	str	r4, [sp, #0]	@ float
	str	r3, [sp, #4]	@ float
	mov	r0, r5
	mov	r1, r6
	mov	r2, r7
	mov	r3, r8
	bl	blerp
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2uiz
	mov	r3, r0
	strb	r3, [fp, #-29]
	ldr	r3, [fp, #-60]
	ldr	r2, [fp, #-56]
	ldrb	ip, [fp, #-29]	@ zero_extendqisi2
	ldr	r0, [fp, #-76]
	mov	r1, r3
	mov	r3, ip
	bl	putpixel
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L11:
	ldr	r0, [fp, #-60]
	ldr	r2, [fp, #-76]
	ldrb	r1, [r2, #0]	@ zero_extendqisi2
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	cmp	r0, r3
	bcc	.L12
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L10:
	ldr	r0, [fp, #-56]
	ldr	r2, [fp, #-76]
	ldrb	r1, [r2, #4]	@ zero_extendqisi2
	ldrb	r3, [r2, #5]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #6]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #7]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	cmp	r0, r3
	bcc	.L13
	sub	sp, fp, #24
	ldmfd	sp!, {r4, r5, r6, r7, r8, fp, pc}
	.size	scale, .-scale
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Usage: ./scale input.simple output.simple 0.5\000"
	.global	__aeabi_d2f
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #44
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	ldr	r3, [fp, #-40]
	cmp	r3, #4
	beq	.L16
	ldr	r0, .L20
	bl	puts
	mov	r3, #1
	str	r3, [fp, #-48]
	b	.L17
.L16:
	ldr	r3, [fp, #-44]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-44]
	add	r3, r3, #12
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	atof
	mov	r3, r0
	mov	r4, r1
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2f
	mov	r3, r0
	str	r3, [fp, #-28]	@ float
	ldr	r0, [fp, #-36]
	bl	SIMPLE_open
	mov	r3, r0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L18
	mov	r3, #1
	str	r3, [fp, #-48]
	b	.L17
.L18:
	ldr	r2, [fp, #-24]
	ldrb	r1, [r2, #0]	@ zero_extendqisi2
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	ldr	r2, [fp, #-28]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2uiz
	mov	r4, r0
	ldr	r2, [fp, #-24]
	ldrb	r1, [r2, #4]	@ zero_extendqisi2
	ldrb	r3, [r2, #5]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r1, r3, r1
	ldrb	r3, [r2, #6]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r1, r3, r1
	ldrb	r3, [r2, #7]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r3, r1
	mov	r0, r3
	bl	__aeabi_ui2f
	mov	r3, r0
	ldr	r2, [fp, #-28]	@ float
	mov	r0, r3
	mov	r1, r2
	bl	__aeabi_fmul
	mov	r3, r0
	mov	r0, r3
	bl	__aeabi_f2uiz
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	bl	SIMPLE_new
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r0, [fp, #-24]
	ldr	r1, [fp, #-20]
	ldr	r2, [fp, #-28]	@ float
	ldr	r3, [fp, #-28]	@ float
	bl	scale
	ldr	r0, [fp, #-20]
	ldr	r1, [fp, #-32]
	bl	SIMPLE_save
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r0, [fp, #-24]
	bl	SIMPLE_destroy
	ldr	r0, [fp, #-20]
	bl	SIMPLE_destroy
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-48]
.L17:
	ldr	r3, [fp, #-48]
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, pc}
.L21:
	.align	2
.L20:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
