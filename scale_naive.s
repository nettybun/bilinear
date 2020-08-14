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
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #68
	str	r0, [fp, #-56]
	str	r1, [fp, #-60]
	str	r2, [fp, #-64]	@ float
	mov	r3, #0
	str	r3, [fp, #-36]
	vmov.f32	s13, #1.0e+0
	vldr.32	s14, [fp, #-64]
	vdiv.f32	s15, s13, s14
	vcvt.f64.f32	d16, s15
	vstr.64	d16, [fp, #-12]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L2
.L5:
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L3
.L4:
	ldr	r3, [fp, #-40]
	vmov	s15, r3	@ int
	vcvt.f64.u32	d17, s15
	vldr.64	d16, [fp, #-12]
	vmul.f64	d7, d17, d16
	vcvt.u32.f64	s15, d7
	vmov	r3, s15	@ int
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-44]
	vmov	s15, r3	@ int
	vcvt.f64.u32	d17, s15
	vldr.64	d16, [fp, #-12]
	vmul.f64	d7, d17, d16
	vcvt.u32.f64	s15, d7
	vmov	r3, s15	@ int
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-40]
	vmov	s15, r3	@ int
	vcvt.f64.u32	d17, s15
	vldr.64	d16, [fp, #-12]
	vmul.f64	d17, d17, d16
	ldr	r3, [fp, #-32]
	vmov	s15, r3	@ int
	vcvt.f64.u32	d16, s15
	vsub.f64	d16, d17, d16
	vcvt.f32.f64	s15, d16
	vstr.32	s15, [fp, #-24]
	ldr	r3, [fp, #-44]
	vmov	s15, r3	@ int
	vcvt.f64.u32	d17, s15
	vldr.64	d16, [fp, #-12]
	vmul.f64	d17, d17, d16
	ldr	r3, [fp, #-28]
	vmov	s15, r3	@ int
	vcvt.f64.u32	d16, s15
	vsub.f64	d16, d17, d16
	vcvt.f32.f64	s15, d16
	vstr.32	s15, [fp, #-20]
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	ldr	r2, [fp, #-28]
	mul	r3, r2, r3
	ldr	r2, [fp, #-32]
	add	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-56]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3]
	strb	r3, [fp, #-49]
	ldr	r3, [fp, #-56]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]
	strb	r3, [fp, #-48]
	ldr	r3, [fp, #-56]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-56]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]
	strb	r3, [fp, #-47]
	ldr	r3, [fp, #-56]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-56]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-16]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]
	strb	r3, [fp, #-46]
	ldrb	r3, [fp, #-49]	@ zero_extendqisi2
	vmov	s15, r3	@ int
	vcvt.f32.s32	s14, s15
	vmov.f32	s13, #1.0e+0
	vldr.32	s15, [fp, #-24]
	vsub.f32	s15, s13, s15
	vmul.f32	s14, s14, s15
	vmov.f32	s13, #1.0e+0
	vldr.32	s15, [fp, #-20]
	vsub.f32	s15, s13, s15
	vmul.f32	s14, s14, s15
	ldrb	r3, [fp, #-48]	@ zero_extendqisi2
	vmov	s15, r3	@ int
	vcvt.f32.s32	s13, s15
	vldr.32	s15, [fp, #-24]
	vmul.f32	s13, s13, s15
	vmov.f32	s12, #1.0e+0
	vldr.32	s15, [fp, #-20]
	vsub.f32	s15, s12, s15
	vmul.f32	s15, s13, s15
	vadd.f32	s14, s14, s15
	ldrb	r3, [fp, #-47]	@ zero_extendqisi2
	vmov	s15, r3	@ int
	vcvt.f32.s32	s13, s15
	vldr.32	s15, [fp, #-20]
	vmul.f32	s13, s13, s15
	vmov.f32	s12, #1.0e+0
	vldr.32	s15, [fp, #-24]
	vsub.f32	s15, s12, s15
	vmul.f32	s15, s13, s15
	vadd.f32	s14, s14, s15
	ldrb	r3, [fp, #-46]	@ zero_extendqisi2
	vmov	s15, r3	@ int
	vcvt.f32.s32	s13, s15
	vldr.32	s15, [fp, #-24]
	vmul.f32	s13, s13, s15
	vldr.32	s15, [fp, #-20]
	vmul.f32	s15, s13, s15
	vadd.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vstr.32	s15, [fp, #-68]	@ int
	ldr	r3, [fp, #-68]
	strb	r3, [fp, #-45]
	ldr	r3, [fp, #-60]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-36]
	add	r1, r3, #1
	str	r1, [fp, #-36]
	add	r3, r2, r3
	ldrb	r2, [fp, #-45]
	strb	r2, [r3]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L3:
	ldr	r3, [fp, #-60]
	ldr	r3, [r3]	@ unaligned
	ldr	r2, [fp, #-40]
	cmp	r2, r3
	bcc	.L4
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L2:
	ldr	r3, [fp, #-60]
	ldr	r3, [r3, #4]	@ unaligned
	ldr	r2, [fp, #-44]
	cmp	r2, r3
	bcc	.L5
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
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
	beq	.L7
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	puts
	mov	r3, #1
	b	.L8
.L7:
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
	bne	.L9
	mov	r3, #1
	b	.L8
.L9:
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
.L8:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
