	.arch armv7-a
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"scale.c"
	.text
	.section	.rodata.cst4,"aM",%progbits,4
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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	vmov.f32	s8, #1.0e+0
	movw	r3, #:lower16:.LC0
	vmov	s9, r2
	ldr	r2, [r1, #4]	@ unaligned
	vldr.32	s10, .L16+16
	movt	r3, #:upper16:.LC0
	cmp	r2, #0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #28
	ldr	r3, [r3]
	str	r3, [sp, #20]
	mov	r3,#0
	vdiv.f32	s11, s8, s9
	vmul.f32	s11, s11, s10
	beq	.L1
	ldr	r3, [r1]	@ unaligned
	mov	ip, #0
	vldr	d21, .L16
	mov	r10, ip
	str	ip, [sp, #8]
	vldr	d20, .L16+8
	str	ip, [sp, #12]
	vcvt.u32.f32	s11, s11
	vmov	fp, s11	@ int
.L5:
	ldr	ip, [sp, #8]
	cmp	r3, #0
	ubfx	r7, ip, #0, #11
	rsb	r8, r7, #2048
	asr	r9, ip, #11
	beq	.L3
	mov	ip, #0
	add	r3, r10, #1
	mov	r2, ip
	str	r3, [sp]
	str	r7, [sp, #4]
.L4:
	ubfx	r3, ip, #0, #11
	str	r3, [sp, #16]
	add	r3, sp, #16
	ldr	r4, [r0]	@ unaligned
	vmov	d19, d20  @ v2si
	asr	r5, ip, #11
	vld1.32	{d17[]}, [r3]
	add	lr, sp, #4
	mla	r5, r9, r4, r5
	ldr	r3, [r0, #8]	@ unaligned
	vmls.i32	d19, d17, d21
	vld1.32	{d6[0]}, [lr]
	ldr	r7, [sp]
	add	ip, ip, fp
	add	r4, r4, r5
	mov	lr, r3
	vmov.i32	d16, #0  @ v2si
	vmov.32	d7[0], r8
	ldrb	r6, [lr, r4]!	@ zero_extendqisi2
	add	r4, r2, r10
	ldrb	r5, [r3, r5]!	@ zero_extendqisi2
	add	r7, r7, r2
	vmov	d18, d16  @ v2si
	add	r2, r2, #1
	vmul.i32	d17, d19, d6[0]
	ldrb	lr, [lr, #1]	@ zero_extendqisi2
	vmov.32	d16[0], r6
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	vmul.i32	d19, d19, d7[0]
	vmov.32	d18[0], r5
	vmov.32	d16[1], lr
	ldr	r5, [r1, #8]	@ unaligned
	vmov.32	d18[1], r3
	vmul.i32	d16, d17, d16
	vmla.i32	d16, d19, d18
	vmov.32	r3, d16[0]
	vmov.32	lr, d16[1]
	add	r3, r3, lr
	asr	r3, r3, #22
	strb	r3, [r4, r5]
	ldr	r3, [r1]	@ unaligned
	cmp	r3, r2
	bhi	.L4
	ldr	r2, [r1, #4]	@ unaligned
	mov	r10, r7
.L3:
	ldr	ip, [sp, #12]
	ldr	lr, [sp, #8]
	add	ip, ip, #1
	str	ip, [sp, #12]
	cmp	ip, r2
	add	lr, lr, fp
	str	lr, [sp, #8]
	bcc	.L5
.L1:
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	ldr	r2, [r3]
	ldr	r3, [sp, #20]
	eors	r2, r3, r2
	bne	.L15
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L15:
	bl	__stack_chk_fail
.L17:
	.align	3
.L16:
	.word	1
	.word	-1
	.word	2048
	.word	0
	.word	1157627904
	.size	scale, .-scale
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"Usage: ./scale input.simple output.simple 0.5\000"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #4
	push	{r4, r5, r6, lr}
	vpush.64	{d8}
	beq	.L19
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	puts
	mov	r4, #1
.L18:
	vldm	sp!, {d8}
	mov	r0, r4
	pop	{r4, r5, r6, pc}
.L19:
	mov	r3, r1
	ldr	r4, [r1, #4]
	ldr	r0, [r3, #12]
	mov	r1, #0
	ldr	r6, [r3, #8]
	bl	strtod
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	vmov	d8, r2, r3
	bl	SIMPLE_open
	subs	r4, r0, #0
	moveq	r4, #1
	beq	.L18
	ldr	r3, [r4, #4]	@ unaligned
	vcvt.f32.f64	s16, d8
	vmov	s14, r3	@ int
	ldr	r3, [r4]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s14
	vcvt.f32.u32	s15, s15
	vmul.f32	s14, s14, s16
	vmul.f32	s15, s15, s16
	vcvt.u32.f32	s14, s14
	vcvt.u32.f32	s15, s15
	vmov	r1, s14	@ int
	vmov	r0, s15	@ int
	bl	SIMPLE_new
	vmov	r2, s16
	mov	r5, r0
	mov	r1, r0
	mov	r0, r4
	bl	scale
	mov	r1, r6
	mov	r0, r5
	bl	SIMPLE_save
	mov	r3, r0
	mov	r0, r4
	mov	r4, r3
	bl	SIMPLE_destroy
	mov	r0, r5
	bl	SIMPLE_destroy
	b	.L18
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
