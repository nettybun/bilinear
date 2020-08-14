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
	.section	.rodata
	.align	2
.LC0:
	.word	__stack_chk_guard
	.text
	.align	2
	.global	scale
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	scale, %function
scale:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #112
	str	r0, [fp, #-104]
	str	r1, [fp, #-108]
	str	r2, [fp, #-112]	@ float
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	mov	r3, #0
	str	r3, [fp, #-88]
	vmov.f32	s13, #1.0e+0
	vldr.32	s14, [fp, #-112]
	vdiv.f32	s15, s13, s14
	vstr.32	s15, [fp, #-84]
	mov	r3, #1065353216
	str	r3, [fp, #-48]	@ float
	mov	r3, #0
	str	r3, [fp, #-44]	@ float
	mov	r3, #0
	str	r3, [fp, #-96]
	b	.L2
.L5:
	ldr	r3, [fp, #-96]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-84]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-80]
	ldr	r3, [fp, #-96]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-84]
	vmul.f32	s14, s14, s15
	ldr	r3, [fp, #-80]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s15, s15
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-76]
	vmov.f32	s14, #1.0e+0
	vldr.32	s15, [fp, #-76]
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-72]
	ldr	r3, [fp, #-104]
	ldr	r2, [r3]	@ unaligned
	ldr	r3, [fp, #-80]
	mul	r3, r2, r3
	str	r3, [fp, #-68]
	mov	r3, #0
	str	r3, [fp, #-92]
	b	.L3
.L4:
	ldr	r3, [fp, #-92]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-84]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-92]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-84]
	vmul.f32	s14, s14, s15
	ldr	r3, [fp, #-64]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s15, s15
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-60]
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-68]
	add	r3, r2, r3
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-104]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-56]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-104]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-104]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-104]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-56]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-104]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-104]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-56]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-60]	@ float
	str	r3, [fp, #-24]	@ float
	ldr	r3, [fp, #-60]	@ float
	str	r3, [fp, #-20]	@ float
	ldr	r3, [fp, #-60]	@ float
	str	r3, [fp, #-16]	@ float
	ldr	r3, [fp, #-60]	@ float
	str	r3, [fp, #-12]	@ float
	vldr.32	s14, [fp, #-24]
	movw	r3, #:lower16:v_const0.6526
	movt	r3, #:upper16:v_const0.6526
	vldr.32	s15, [r3]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-24]
	vldr.32	s14, [fp, #-20]
	movw	r3, #:lower16:v_const0.6526
	movt	r3, #:upper16:v_const0.6526
	vldr.32	s15, [r3, #4]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-20]
	vldr.32	s14, [fp, #-16]
	movw	r3, #:lower16:v_const0.6526
	movt	r3, #:upper16:v_const0.6526
	vldr.32	s15, [r3]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-16]
	vldr.32	s14, [fp, #-12]
	movw	r3, #:lower16:v_const0.6526
	movt	r3, #:upper16:v_const0.6526
	vldr.32	s15, [r3, #4]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-12]
	vldr.32	s14, [fp, #-48]
	vldr.32	s15, [fp, #-24]
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-24]
	vldr.32	s14, [fp, #-44]
	vldr.32	s15, [fp, #-20]
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-20]
	vldr.32	s14, [fp, #-48]
	vldr.32	s15, [fp, #-16]
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-16]
	vldr.32	s14, [fp, #-44]
	vldr.32	s15, [fp, #-12]
	vsub.f32	s15, s14, s15
	vstr.32	s15, [fp, #-12]
	vldr.32	s14, [fp, #-24]
	vldr.32	s15, [fp, #-72]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-24]
	vldr.32	s14, [fp, #-20]
	vldr.32	s15, [fp, #-72]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-20]
	vldr.32	s14, [fp, #-16]
	vldr.32	s15, [fp, #-76]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-16]
	vldr.32	s14, [fp, #-12]
	vldr.32	s15, [fp, #-76]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [fp, #-12]
	ldr	r3, [fp, #-40]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-24]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-36]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-20]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-32]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-16]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-28]
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-12]
	vmul.f32	s15, s14, s15
	vcvt.u32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-32]
	add	r2, r2, r3
	ldr	r3, [fp, #-36]
	add	r2, r2, r3
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-108]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-88]
	add	r1, r3, #1
	str	r1, [fp, #-88]
	add	r3, r2, r3
	ldr	r2, [fp, #-52]
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [fp, #-92]
	add	r3, r3, #1
	str	r3, [fp, #-92]
.L3:
	ldr	r3, [fp, #-108]
	ldr	r3, [r3]	@ unaligned
	ldr	r2, [fp, #-92]
	cmp	r2, r3
	bcc	.L4
	ldr	r3, [fp, #-96]
	add	r3, r3, #1
	str	r3, [fp, #-96]
.L2:
	ldr	r3, [fp, #-108]
	ldr	r3, [r3, #4]	@ unaligned
	ldr	r2, [fp, #-96]
	cmp	r2, r3
	bcc	.L5
	nop
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	eors	r2, r3, r2
	beq	.L6
	bl	__stack_chk_fail
.L6:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	scale, .-scale
	.section	.rodata
	.align	2
.LC1:
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
	beq	.L8
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	puts
	mov	r3, #1
	b	.L9
.L8:
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
	bne	.L10
	mov	r3, #1
	b	.L9
.L10:
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
.L9:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.section	.rodata
	.align	2
	.type	v_const0.6526, %object
	.size	v_const0.6526, 8
v_const0.6526:
	.word	1065353216
	.word	3212836864
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
