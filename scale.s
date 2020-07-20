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
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-64]
	vmul.f32	s15, s14, s15
	vcvt.s32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-56]
	ldr	r3, [r3, #4]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-64]
	vmul.f32	s15, s14, s15
	vcvt.s32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-40]
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f64.u32	d16, s15
	vldr.64	d17, .L6
	vmul.f64	d18, d16, d17
	ldr	r3, [fp, #-44]
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vdiv.f64	d16, d18, d17
	vmov.f64	d17, #5.0e-1
	vadd.f64	d16, d16, d17
	vcvt.s32.f64	s15, d16
	vmov	r3, s15	@ int
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-56]
	ldr	r3, [r3, #4]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f64.u32	d16, s15
	vldr.64	d17, .L6
	vmul.f64	d18, d16, d17
	ldr	r3, [fp, #-40]
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vdiv.f64	d16, d18, d17
	vmov.f64	d17, #5.0e-1
	vadd.f64	d16, d16, d17
	vcvt.s32.f64	s15, d16
	vmov	r3, s15	@ int
	str	r3, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-48]
	b	.L2
.L5:
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-32]
	mul	r3, r2, r3
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	asr	r3, r3, #11
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	lsl	r3, r3, #11
	ldr	r2, [fp, #-28]
	sub	r3, r2, r3
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L3
.L4:
	ldr	r3, [fp, #-52]
	ldr	r2, [fp, #-36]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	asr	r3, r3, #11
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	lsl	r3, r3, #11
	ldr	r2, [fp, #-16]
	sub	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-56]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	ldr	r1, [fp, #-24]
	mul	r1, r1, r3
	ldr	r3, [fp, #-12]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #2048
	mul	r3, r3, r2
	ldr	r2, [fp, #-20]
	rsb	r2, r2, #2048
	mul	r2, r2, r3
	ldr	r3, [fp, #-56]
	ldr	r1, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	mov	r0, r3
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	mul	r0, r3, r0
	ldr	r3, [fp, #-12]
	add	r3, r0, r3
	add	r3, r1, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #2048
	mul	r3, r3, r1
	ldr	r1, [fp, #-20]
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-56]
	ldr	r1, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	ldr	r0, [fp, #-24]
	mul	r0, r0, r3
	ldr	r3, [fp, #-12]
	add	r3, r0, r3
	add	r3, r3, #1
	add	r3, r1, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-8]
	mul	r3, r3, r1
	ldr	r1, [fp, #-20]
	rsb	r1, r1, #2048
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-56]
	ldr	r1, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	mov	r0, r3
	ldr	r3, [fp, #-56]
	ldr	r3, [r3]	@ unaligned
	mul	r0, r3, r0
	ldr	r3, [fp, #-12]
	add	r3, r0, r3
	add	r3, r3, #1
	add	r3, r1, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r3, [fp, #-8]
	mul	r3, r3, r1
	ldr	r1, [fp, #-20]
	mul	r3, r1, r3
	add	r3, r2, r3
	add	r3, r3, #2097152
	asr	r0, r3, #22
	ldr	r3, [fp, #-60]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-60]
	ldr	r3, [r3]	@ unaligned
	ldr	r1, [fp, #-48]
	mul	r1, r1, r3
	ldr	r3, [fp, #-52]
	add	r3, r1, r3
	add	r3, r2, r3
	uxtb	r2, r0
	strb	r2, [r3]
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
.L3:
	ldr	r3, [fp, #-60]
	ldr	r2, [r3]	@ unaligned
	ldr	r3, [fp, #-52]
	cmp	r2, r3
	bhi	.L4
	ldr	r3, [fp, #-48]
	add	r3, r3, #1
	str	r3, [fp, #-48]
.L2:
	ldr	r3, [fp, #-60]
	ldr	r2, [r3, #4]	@ unaligned
	ldr	r3, [fp, #-48]
	cmp	r2, r3
	bhi	.L5
	nop
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L7:
	.align	3
.L6:
	.word	0
	.word	1084227584
	.size	scale, .-scale
	.section	.rodata
	.align	2
.LC0:
	.word	2048
	.word	2048
	.word	2048
	.word	2048
	.align	2
.LC1:
	.word	__stack_chk_guard
	.text
	.align	2
	.global	scale_neon
	.syntax unified
	.arm
	.fpu neon
	.type	scale_neon, %function
scale_neon:
	@ args = 0, pretend = 0, frame = 776
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #776
	str	r0, [fp, #-768]
	str	r1, [fp, #-772]
	str	r2, [fp, #-776]	@ float
	movw	r3, #:lower16:.LC1
	movt	r3, #:upper16:.LC1
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3,#0
	ldr	r3, [fp, #-768]
	ldr	r3, [r3]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-776]
	vmul.f32	s15, s14, s15
	vcvt.s32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-752]
	ldr	r3, [fp, #-768]
	ldr	r3, [r3, #4]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f32.u32	s14, s15
	vldr.32	s15, [fp, #-776]
	vmul.f32	s15, s14, s15
	vcvt.s32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [fp, #-748]
	ldr	r3, [fp, #-768]
	ldr	r3, [r3]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f64.u32	d16, s15
	vldr.64	d17, .L27
	vmul.f64	d18, d16, d17
	ldr	r3, [fp, #-752]
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vdiv.f64	d16, d18, d17
	vmov.f64	d17, #5.0e-1
	vadd.f64	d16, d16, d17
	vcvt.s32.f64	s15, d16
	vmov	r3, s15	@ int
	str	r3, [fp, #-744]
	ldr	r3, [fp, #-768]
	ldr	r3, [r3, #4]	@ unaligned
	vmov	s15, r3	@ int
	vcvt.f64.u32	d16, s15
	vldr.64	d17, .L27
	vmul.f64	d18, d16, d17
	ldr	r3, [fp, #-748]
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vdiv.f64	d16, d18, d17
	vmov.f64	d17, #5.0e-1
	vadd.f64	d16, d16, d17
	vcvt.s32.f64	s15, d16
	vmov	r3, s15	@ int
	str	r3, [fp, #-740]
	movw	r3, #:lower16:.LC0
	movt	r3, #:upper16:.LC0
	sub	ip, fp, #236
	ldm	r3, {r0, r1, r2, r3}
	stm	ip, {r0, r1, r2, r3}
	sub	r3, fp, #236
	str	r3, [fp, #-708]
	ldr	r3, [fp, #-708]
	vld1.32	{d16-d17}, [r3]
	vstr	d16, [fp, #-692]
	vstr	d17, [fp, #-684]
	mov	r3, #0
	str	r3, [fp, #-736]
	mov	r3, #0
	str	r3, [fp, #-756]
	b	.L10
.L25:
	ldr	r3, [fp, #-756]
	ldr	r2, [fp, #-740]
	mul	r3, r2, r3
	str	r3, [fp, #-732]
	ldr	r3, [fp, #-732]
	asr	r3, r3, #11
	str	r3, [fp, #-728]
	ldr	r3, [fp, #-728]
	lsl	r3, r3, #11
	ldr	r2, [fp, #-732]
	sub	r3, r2, r3
	str	r3, [fp, #-724]
	mov	r3, #0
	str	r3, [fp, #-760]
	b	.L11
.L28:
	.align	3
.L27:
	.word	0
	.word	1084227584
.L24:
	ldr	r3, [fp, #-760]
	ldr	r2, [fp, #-744]
	mul	r3, r2, r3
	str	r3, [fp, #-720]
	ldr	r3, [fp, #-720]
	asr	r3, r3, #11
	str	r3, [fp, #-716]
	ldr	r3, [fp, #-716]
	lsl	r3, r3, #11
	ldr	r2, [fp, #-720]
	sub	r3, r2, r3
	str	r3, [fp, #-712]
	ldr	r3, [fp, #-768]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-768]
	ldr	r3, [r3]	@ unaligned
	ldr	r1, [fp, #-728]
	mul	r1, r1, r3
	ldr	r3, [fp, #-716]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-220]
	ldr	r3, [fp, #-768]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-728]
	add	r3, r3, #1
	mov	r1, r3
	ldr	r3, [fp, #-768]
	ldr	r3, [r3]	@ unaligned
	mul	r1, r3, r1
	ldr	r3, [fp, #-716]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-216]
	ldr	r3, [fp, #-768]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-768]
	ldr	r3, [r3]	@ unaligned
	ldr	r1, [fp, #-728]
	mul	r1, r1, r3
	ldr	r3, [fp, #-716]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-212]
	ldr	r3, [fp, #-768]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-728]
	add	r3, r3, #1
	mov	r1, r3
	ldr	r3, [fp, #-768]
	ldr	r3, [r3]	@ unaligned
	mul	r1, r3, r1
	ldr	r3, [fp, #-716]
	add	r3, r1, r3
	add	r3, r3, #1
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-208]
	ldr	r3, [fp, #-712]
	str	r3, [fp, #-244]
	ldr	r3, [fp, #-724]
	str	r3, [fp, #-240]
	sub	r3, fp, #220
	str	r3, [fp, #-696]
	ldr	r3, [fp, #-696]
	vld4.32	{d16, d18, d20, d22}, [r3]
	add	r3, r3, #32
	vld4.32	{d17, d19, d21, d23}, [r3]
	sub	r3, fp, #4
	sub	r3, r3, #72
	vstmia	r3, {d16-d23}
	sub	r3, fp, #4
	sub	r3, r3, #136
	sub	r2, fp, #4
	sub	r2, r2, #72
	vldmia	r2, {d16-d23}
	vstmia	r3, {d16-d23}
	sub	r3, fp, #244
	str	r3, [fp, #-700]
	ldr	r3, [fp, #-700]
	vld2.32	{d16-d19}, [r3]
	sub	r3, fp, #4
	sub	r3, r3, #72
	vst1.64	{d16-d19}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #168
	sub	r2, fp, #4
	sub	r2, r2, #72
	vld1.64	{d16-d19}, [r2:64]
	vst1.64	{d16-d19}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #168
	vld1.64	{d16-d17}, [r3:64]
	vldr	d18, [fp, #-692]
	vldr	d19, [fp, #-684]
	vstr	d18, [fp, #-292]
	vstr	d19, [fp, #-284]
	vstr	d16, [fp, #-276]
	vstr	d17, [fp, #-268]
	vldr	d16, [fp, #-692]
	vldr	d17, [fp, #-684]
	vstr	d16, [fp, #-260]
	vstr	d17, [fp, #-252]
	vldr	d20, [fp, #-292]
	vldr	d21, [fp, #-284]
	vldr	d18, [fp, #-276]
	vldr	d19, [fp, #-268]
	vldr	d16, [fp, #-260]
	vldr	d17, [fp, #-252]
	vmls.i32	q10, q9, q8
	vmov	q8, q10  @ v4si
	sub	r3, fp, #4
	sub	r3, r3, #200
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #168
	vldr	d16, [r3, #16]
	vldr	d17, [r3, #24]
	vldr	d18, [fp, #-692]
	vldr	d19, [fp, #-684]
	vstr	d18, [fp, #-340]
	vstr	d19, [fp, #-332]
	vstr	d16, [fp, #-324]
	vstr	d17, [fp, #-316]
	vldr	d16, [fp, #-692]
	vldr	d17, [fp, #-684]
	vstr	d16, [fp, #-308]
	vstr	d17, [fp, #-300]
	vldr	d20, [fp, #-340]
	vldr	d21, [fp, #-332]
	vldr	d18, [fp, #-324]
	vldr	d19, [fp, #-316]
	vldr	d16, [fp, #-308]
	vldr	d17, [fp, #-300]
	vmls.i32	q10, q9, q8
	vmov	q8, q10  @ v4si
	sub	r3, fp, #4
	sub	r3, r3, #200
	vstr	d16, [r3, #16]
	vstr	d17, [r3, #24]
	sub	r3, fp, #4
	sub	r3, r3, #136
	vld1.64	{d18-d19}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #200
	vld1.64	{d20-d21}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #200
	vldr	d16, [r3, #16]
	vldr	d17, [r3, #24]
	vstr	d20, [fp, #-372]
	vstr	d21, [fp, #-364]
	vstr	d16, [fp, #-356]
	vstr	d17, [fp, #-348]
	vldr	d20, [fp, #-372]
	vldr	d21, [fp, #-364]
	vldr	d16, [fp, #-356]
	vldr	d17, [fp, #-348]
	vmul.i32	q8, q10, q8
	vstr	d18, [fp, #-404]
	vstr	d19, [fp, #-396]
	vstr	d16, [fp, #-388]
	vstr	d17, [fp, #-380]
	vldr	d18, [fp, #-404]
	vldr	d19, [fp, #-396]
	vldr	d16, [fp, #-388]
	vldr	d17, [fp, #-380]
	vmul.i32	q8, q9, q8
	vstr	d16, [fp, #-676]
	vstr	d17, [fp, #-668]
	sub	r3, fp, #4
	sub	r3, r3, #136
	vldr	d18, [r3, #16]
	vldr	d19, [r3, #24]
	sub	r3, fp, #4
	sub	r3, r3, #200
	vld1.64	{d20-d21}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #168
	vldr	d16, [r3, #16]
	vldr	d17, [r3, #24]
	vstr	d20, [fp, #-436]
	vstr	d21, [fp, #-428]
	vstr	d16, [fp, #-420]
	vstr	d17, [fp, #-412]
	vldr	d20, [fp, #-436]
	vldr	d21, [fp, #-428]
	vldr	d16, [fp, #-420]
	vldr	d17, [fp, #-412]
	vmul.i32	q8, q10, q8
	vldr	d20, [fp, #-676]
	vldr	d21, [fp, #-668]
	vstr	d20, [fp, #-484]
	vstr	d21, [fp, #-476]
	vstr	d18, [fp, #-468]
	vstr	d19, [fp, #-460]
	vstr	d16, [fp, #-452]
	vstr	d17, [fp, #-444]
	vldr	d16, [fp, #-484]
	vldr	d17, [fp, #-476]
	vldr	d20, [fp, #-468]
	vldr	d21, [fp, #-460]
	vldr	d18, [fp, #-452]
	vldr	d19, [fp, #-444]
	vmla.i32	q8, q10, q9
	vstr	d16, [fp, #-676]
	vstr	d17, [fp, #-668]
	sub	r3, fp, #4
	sub	r3, r3, #136
	vldr	d18, [r3, #32]
	vldr	d19, [r3, #40]
	sub	r3, fp, #4
	sub	r3, r3, #168
	vld1.64	{d20-d21}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #200
	vldr	d16, [r3, #16]
	vldr	d17, [r3, #24]
	vstr	d20, [fp, #-516]
	vstr	d21, [fp, #-508]
	vstr	d16, [fp, #-500]
	vstr	d17, [fp, #-492]
	vldr	d20, [fp, #-516]
	vldr	d21, [fp, #-508]
	vldr	d16, [fp, #-500]
	vldr	d17, [fp, #-492]
	vmul.i32	q8, q10, q8
	vldr	d20, [fp, #-676]
	vldr	d21, [fp, #-668]
	vstr	d20, [fp, #-564]
	vstr	d21, [fp, #-556]
	vstr	d18, [fp, #-548]
	vstr	d19, [fp, #-540]
	vstr	d16, [fp, #-532]
	vstr	d17, [fp, #-524]
	vldr	d16, [fp, #-564]
	vldr	d17, [fp, #-556]
	vldr	d20, [fp, #-548]
	vldr	d21, [fp, #-540]
	vldr	d18, [fp, #-532]
	vldr	d19, [fp, #-524]
	vmla.i32	q8, q10, q9
	vstr	d16, [fp, #-676]
	vstr	d17, [fp, #-668]
	sub	r3, fp, #4
	sub	r3, r3, #136
	vldr	d18, [r3, #48]
	vldr	d19, [r3, #56]
	sub	r3, fp, #4
	sub	r3, r3, #168
	vld1.64	{d20-d21}, [r3:64]
	sub	r3, fp, #4
	sub	r3, r3, #168
	vldr	d16, [r3, #16]
	vldr	d17, [r3, #24]
	vstr	d20, [fp, #-596]
	vstr	d21, [fp, #-588]
	vstr	d16, [fp, #-580]
	vstr	d17, [fp, #-572]
	vldr	d20, [fp, #-596]
	vldr	d21, [fp, #-588]
	vldr	d16, [fp, #-580]
	vldr	d17, [fp, #-572]
	vmul.i32	q8, q10, q8
	vldr	d20, [fp, #-676]
	vldr	d21, [fp, #-668]
	vstr	d20, [fp, #-644]
	vstr	d21, [fp, #-636]
	vstr	d18, [fp, #-628]
	vstr	d19, [fp, #-620]
	vstr	d16, [fp, #-612]
	vstr	d17, [fp, #-604]
	vldr	d16, [fp, #-644]
	vldr	d17, [fp, #-636]
	vldr	d20, [fp, #-628]
	vldr	d21, [fp, #-620]
	vldr	d18, [fp, #-612]
	vldr	d19, [fp, #-604]
	vmla.i32	q8, q10, q9
	vstr	d16, [fp, #-676]
	vstr	d17, [fp, #-668]
	ldr	r3, [fp, #-772]
	ldr	r2, [r3, #8]	@ unaligned
	ldr	r3, [fp, #-772]
	ldr	r3, [r3]	@ unaligned
	ldr	r1, [fp, #-756]
	mul	r1, r1, r3
	ldr	r3, [fp, #-760]
	add	r3, r1, r3
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	str	r3, [fp, #-704]
	vldr	d16, [fp, #-676]
	vldr	d17, [fp, #-668]
	vstr	d16, [fp, #-660]
	vstr	d17, [fp, #-652]
	vldr	d16, [fp, #-660]
	vldr	d17, [fp, #-652]
	ldr	r3, [fp, #-704]
	vst1.32	{d16-d17}, [r3]
	nop
	ldr	r3, [fp, #-760]
	add	r3, r3, #1
	str	r3, [fp, #-760]
.L11:
	ldr	r3, [fp, #-772]
	ldr	r2, [r3]	@ unaligned
	ldr	r3, [fp, #-760]
	cmp	r2, r3
	bhi	.L24
	ldr	r3, [fp, #-756]
	add	r3, r3, #1
	str	r3, [fp, #-756]
.L10:
	ldr	r3, [fp, #-772]
	ldr	r2, [r3, #4]	@ unaligned
	ldr	r3, [fp, #-756]
	cmp	r2, r3
	bhi	.L25
	nop
	movw	r3, #:lower16:.LC1
	movt	r3, #:upper16:.LC1
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	eors	r2, r3, r2
	beq	.L26
	bl	__stack_chk_fail
.L26:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	scale_neon, .-scale_neon
	.section	.rodata
	.align	2
.LC2:
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
	beq	.L30
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	puts
	mov	r3, #1
	b	.L31
.L30:
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
	bne	.L32
	mov	r3, #1
	b	.L31
.L32:
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
.L31:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu1) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
