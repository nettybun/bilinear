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
	@ args = 0, pretend = 0, frame = 280
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #280
	str	r0, [fp, #-272]
	str	r1, [fp, #-276]
	str	r2, [fp, #-280]	@ float
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	mov	r3, #0
	str	r3, [fp, #-252]
	vmov.f32	s9, #1.0e+0
	vldr.32	s10, [fp, #-280]
	vdiv.f32	s11, s9, s10
	vldr.32	s10, .L20+16
	vmul.f32	s11, s11, s10
	vcvt.u32.f32	s11, s11
	vmov	r3, s11	@ int
	str	r3, [fp, #-248]
	vldr	d16, .L20
	vstr	d16, [fp, #-188]
	vldr	d16, .L20+8
	vstr	d16, [fp, #-180]
	mov	r3, #0
	str	r3, [fp, #-260]
	b	.L2
.L18:
	ldr	r3, [fp, #-248]
	ldr	r2, [fp, #-260]
	mul	r3, r2, r3
	asr	r3, r3, #11
	str	r3, [fp, #-244]
	ldr	r3, [fp, #-248]
	ldr	r2, [fp, #-260]
	mul	r2, r2, r3
	ldr	r3, [fp, #-244]
	lsl	r3, r3, #11
	sub	r3, r2, r3
	str	r3, [fp, #-240]
	ldr	r3, [fp, #-240]
	rsb	r3, r3, #2048
	str	r3, [fp, #-236]
	mov	r3, #0
	str	r3, [fp, #-256]
	b	.L3
.L17:
	ldr	r3, [fp, #-248]
	ldr	r2, [fp, #-256]
	mul	r3, r2, r3
	asr	r3, r3, #11
	str	r3, [fp, #-232]
	ldr	r3, [fp, #-248]
	ldr	r2, [fp, #-256]
	mul	r2, r2, r3
	ldr	r3, [fp, #-232]
	lsl	r3, r3, #11
	sub	r3, r2, r3
	str	r3, [fp, #-264]
	ldr	r3, [fp, #-272]
	ldr	r3, [r3]	@ unaligned
	ldr	r2, [fp, #-244]
	mul	r2, r2, r3
	ldr	r3, [fp, #-232]
	add	r3, r2, r3
	str	r3, [fp, #-228]
	ldr	r3, [fp, #-272]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-228]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-204]
	ldr	r3, [fp, #-272]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-228]
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-200]
	ldr	r3, [fp, #-272]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-272]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-228]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-196]
	ldr	r3, [fp, #-272]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-272]
	ldr	r1, [r3]	@ unaligned
	ldr	r3, [fp, #-228]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-192]
	sub	r3, fp, #264
	str	r3, [fp, #-208]
	ldr	r3, [fp, #-208]
	vld1.32	{d16[]}, [r3]
	vstr	d16, [fp, #-172]
	sub	r3, fp, #264
	str	r3, [fp, #-212]
	ldr	r3, [fp, #-212]
	vld1.32	{d16[]}, [r3]
	vstr	d16, [fp, #-164]
	vldr	d16, [fp, #-172]
	vstr	d16, [fp, #-28]
	vldr	d16, [fp, #-188]
	vstr	d16, [fp, #-20]
	vldr	d17, [fp, #-28]
	vldr	d16, [fp, #-20]
	vmul.i32	d16, d17, d16
	vstr	d16, [fp, #-172]
	vldr	d16, [fp, #-164]
	vstr	d16, [fp, #-44]
	vldr	d16, [fp, #-188]
	vstr	d16, [fp, #-36]
	vldr	d17, [fp, #-44]
	vldr	d16, [fp, #-36]
	vmul.i32	d16, d17, d16
	vstr	d16, [fp, #-164]
	vldr	d16, [fp, #-180]
	vstr	d16, [fp, #-60]
	vldr	d16, [fp, #-172]
	vstr	d16, [fp, #-52]
	vldr	d17, [fp, #-60]
	vldr	d16, [fp, #-52]
	vsub.i32	d16, d17, d16
	vstr	d16, [fp, #-172]
	vldr	d16, [fp, #-180]
	vstr	d16, [fp, #-76]
	vldr	d16, [fp, #-164]
	vstr	d16, [fp, #-68]
	vldr	d17, [fp, #-76]
	vldr	d16, [fp, #-68]
	vsub.i32	d16, d17, d16
	vstr	d16, [fp, #-164]
	vldr	d16, [fp, #-172]
	vstr	d16, [fp, #-84]
	ldr	r3, [fp, #-236]
	str	r3, [fp, #-216]
	vldr	d16, [fp, #-84]
	ldr	r3, [fp, #-216]
	vmov.32	d7[0], r3
	vmul.i32	d16, d16, d7[0]
	vstr	d16, [fp, #-172]
	vldr	d16, [fp, #-164]
	vstr	d16, [fp, #-92]
	ldr	r3, [fp, #-240]
	str	r3, [fp, #-220]
	vldr	d16, [fp, #-92]
	ldr	r3, [fp, #-220]
	vmov.32	d6[0], r3
	vmul.i32	d16, d16, d6[0]
	vstr	d16, [fp, #-164]
	vldr	d16, [fp, #-204]
	vstr	d16, [fp, #-108]
	vldr	d16, [fp, #-172]
	vstr	d16, [fp, #-100]
	vldr	d17, [fp, #-108]
	vldr	d16, [fp, #-100]
	vmul.i32	d16, d17, d16
	vstr	d16, [fp, #-204]
	vldr	d16, [fp, #-196]
	vstr	d16, [fp, #-124]
	vldr	d16, [fp, #-164]
	vstr	d16, [fp, #-116]
	vldr	d17, [fp, #-124]
	vldr	d16, [fp, #-116]
	vmul.i32	d16, d17, d16
	vstr	d16, [fp, #-196]
	vldr	d17, [fp, #-204]
	vldr	d16, [fp, #-196]
	vstr	d17, [fp, #-140]
	vstr	d16, [fp, #-132]
	vldr	d17, [fp, #-140]
	vldr	d16, [fp, #-132]
	vadd.i32	d16, d17, d16
	vstr	d16, [fp, #-204]
	vldr	d16, [fp, #-204]
	vstr	d16, [fp, #-148]
	vldr	d16, [fp, #-148]
	vmov.32	r2, d16[0]
	vldr	d16, [fp, #-204]
	vstr	d16, [fp, #-156]
	vldr	d16, [fp, #-156]
	vmov.32	r3, d16[1]
	add	r3, r2, r3
	str	r3, [fp, #-224]
	ldr	r3, [fp, #-224]
	asr	r3, r3, #22
	str	r3, [fp, #-224]
	ldr	r3, [fp, #-276]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-252]
	add	r1, r3, #1
	str	r1, [fp, #-252]
	add	r3, r2, r3
	ldr	r2, [fp, #-224]
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [fp, #-256]
	add	r3, r3, #1
	str	r3, [fp, #-256]
.L3:
	ldr	r3, [fp, #-276]
	ldr	r2, [r3]	@ unaligned
	ldr	r3, [fp, #-256]
	cmp	r2, r3
	bhi	.L17
	ldr	r3, [fp, #-260]
	add	r3, r3, #1
	str	r3, [fp, #-260]
.L2:
	ldr	r3, [fp, #-276]
	ldr	r2, [r3, #4]	@ unaligned
	ldr	r3, [fp, #-260]
	cmp	r2, r3
	bhi	.L18
	nop
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	eors	r2, r3, r2
	beq	.L19
	bl	__stack_chk_fail
.L19:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L21:
	.align	3
.L20:
	.word	1
	.word	-1
	.word	2048
	.word	0
	.word	1157627904
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
	beq	.L23
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	puts
	mov	r3, #1
	b	.L24
.L23:
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
	bne	.L25
	mov	r3, #1
	b	.L24
.L25:
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
.L24:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
