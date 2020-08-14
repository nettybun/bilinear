	.arch armv7-a
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"scale.c"
	.text
	.align	2
	.global	scale
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	scale, %function
scale:
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #84
	str	r0, [fp, #-88]
	str	r1, [fp, #-92]
	str	r2, [fp, #-96]	@ float
	ldr	r3, [fp, #-92]
	ldr	r3, [r3, #4]	@ unaligned
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-92]
	ldr	r3, [r3, #4]	@ unaligned
	ldr	r2, [fp, #-92]
	ldr	r2, [r2]	@ unaligned
	mul	r3, r2, r3
	sub	r3, r3, #1
	str	r3, [fp, #-80]
	vmov.f32	s13, #1.0e+0
	vldr.32	s14, [fp, #-96]
	vdiv.f32	s15, s13, s14
	vldr.32	s14, .L6
	vmul.f32	s15, s15, s14
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-72]
	b	.L2
.L5:
	ldr	r3, [fp, #-72]
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-84]
	lsl	r3, r3, #16
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r1
	mul	ip, r0, r3
	add	ip, lr, ip
	umull	r2, r3, r0, r2
	add	r1, ip, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	lsr	r3, r3, #16
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-72]
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-84]
	lsl	r3, r3, #16
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r1
	mul	ip, r0, r3
	add	ip, lr, ip
	umull	r2, r3, r0, r2
	add	r1, ip, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	ldr	r3, [fp, #-68]
	lsl	r3, r3, #16
	sub	r3, r2, r3
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-92]
	ldr	r3, [r3]	@ unaligned
	str	r3, [fp, #-76]
	b	.L3
.L7:
	.align	2
.L6:
	.word	1199570944
.L4:
	ldr	r3, [fp, #-72]
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-76]
	lsl	r3, r3, #16
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r1
	mul	ip, r0, r3
	add	ip, lr, ip
	umull	r2, r3, r0, r2
	add	r1, ip, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	lsr	r3, r3, #16
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-72]
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-76]
	lsl	r3, r3, #16
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r1
	mul	ip, r0, r3
	add	ip, lr, ip
	umull	r2, r3, r0, r2
	add	r1, ip, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	ldr	r3, [fp, #-60]
	lsl	r3, r3, #16
	sub	r3, r2, r3
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-56]
	rsb	r3, r3, #65536
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-64]
	rsb	r3, r3, #65536
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-88]
	ldr	r3, [r3]	@ unaligned
	ldr	r2, [fp, #-68]
	mul	r3, r2, r3
	ldr	r2, [fp, #-60]
	add	r3, r2, r3
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-88]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-44]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-88]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-88]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-88]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-44]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-88]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-88]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-44]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-40]
	lsl	r3, r3, #16
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-52]
	mov	r4, r3
	mov	r5, #0
	ldr	r3, [fp, #-48]
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r5
	mul	ip, r4, r3
	add	ip, lr, ip
	umull	r2, r3, r4, r2
	add	ip, ip, r3
	mov	r3, ip
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r1
	mul	ip, r0, r3
	add	ip, lr, ip
	umull	r2, r3, r0, r2
	add	r1, ip, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r6, r2
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #16
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-56]
	mov	r4, r3
	mov	r5, #0
	ldr	r3, [fp, #-48]
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r5
	mul	ip, r4, r3
	add	ip, lr, ip
	umull	r2, r3, r4, r2
	add	ip, ip, r3
	mov	r3, ip
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	mov	r2, r3
	mov	r3, #0
	mul	lr, r2, r1
	mul	ip, r0, r3
	add	ip, lr, ip
	umull	r2, r3, r0, r2
	add	r1, ip, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	add	ip, r6, r3
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #16
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-64]
	mov	r4, r3
	mov	r5, #0
	ldr	r3, [fp, #-52]
	mov	r2, r3
	mov	r3, #0
	mul	r6, r2, r5
	mul	lr, r4, r3
	add	lr, r6, lr
	umull	r2, r3, r4, r2
	add	lr, lr, r3
	mov	r3, lr
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	mov	r2, r3
	mov	r3, #0
	mul	r4, r2, r1
	mul	lr, r0, r3
	add	lr, r4, lr
	umull	r2, r3, r0, r2
	add	r1, lr, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	add	ip, ip, r3
	ldr	r3, [fp, #-28]
	lsl	r3, r3, #16
	mov	r0, r3
	mov	r1, #0
	ldr	r3, [fp, #-56]
	mov	r4, r3
	mov	r5, #0
	ldr	r3, [fp, #-64]
	mov	r2, r3
	mov	r3, #0
	mul	r6, r2, r5
	mul	lr, r4, r3
	add	lr, r6, lr
	umull	r2, r3, r4, r2
	add	lr, lr, r3
	mov	r3, lr
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	mov	r2, r3
	mov	r3, #0
	mul	r4, r2, r1
	mul	lr, r0, r3
	add	lr, r4, lr
	umull	r2, r3, r0, r2
	add	r1, lr, r3
	mov	r3, r1
	lsr	r2, r2, #16
	orr	r2, r2, r3, lsl #16
	lsr	r3, r3, #16
	mov	r3, r2
	add	r3, ip, r3
	lsr	r3, r3, #16
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-92]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-80]
	sub	r1, r3, #1
	str	r1, [fp, #-80]
	add	r3, r2, r3
	ldr	r2, [fp, #-24]
	uxtb	r2, r2
	strb	r2, [r3]
.L3:
	ldr	r3, [fp, #-76]
	sub	r2, r3, #1
	str	r2, [fp, #-76]
	cmp	r3, #0
	bne	.L4
.L2:
	ldr	r3, [fp, #-84]
	sub	r2, r3, #1
	str	r2, [fp, #-84]
	cmp	r3, #0
	bne	.L5
	nop
	nop
	sub	sp, fp, #16
	@ sp needed
	pop	{r4, r5, r6, fp, pc}
	.size	scale, .-scale
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Usage: ./scale input.simple output.simple 0.5\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	ldr	r3, [fp, #-32]
	cmp	r3, #4
	beq	.L9
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	puts
	mov	r3, #1
	b	.L10
.L9:
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #4]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-36]
	ldr	r3, [r3, #8]
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-36]
	add	r3, r3, #12
	ldr	r3, [r3]
	mov	r0, r3
	bl	atof
	vmov	d16, r0, r1
	vcvt.f32.f64	s15, d16
	vstr.32	s15, [fp, #-20]
	ldr	r0, [fp, #-28]
	bl	SIMPLE_open
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L11
	mov	r3, #1
	b	.L10
.L11:
	ldr	r3, [fp, #-16]
	ldr	r3, [r3]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-20]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s13, s15
	ldr	r3, [fp, #-16]
	ldr	r3, [r3, #4]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-20]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r1, s15	@ int
	vmov	r0, s13	@ int
	bl	SIMPLE_new
	str	r0, [fp, #-12]
	ldr	r2, [fp, #-20]	@ float
	ldr	r1, [fp, #-12]
	ldr	r0, [fp, #-16]
	bl	scale
	ldr	r1, [fp, #-24]
	ldr	r0, [fp, #-12]
	bl	SIMPLE_save
	str	r0, [fp, #-8]
	ldr	r0, [fp, #-16]
	bl	SIMPLE_destroy
	ldr	r0, [fp, #-12]
	bl	SIMPLE_destroy
	ldr	r3, [fp, #-8]
.L10:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
