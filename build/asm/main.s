	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	__umoddi3
	.globl	__moddi3
	.globl	__udivdi3
	.globl	__divdi3
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC2:
	.string	"\n"
	.align	2
.LC1:
	.string	"# of instruction retrieved:     \n"
	.text
	.align	2
	.globl	print_n_instruction_retrieved
	.type	print_n_instruction_retrieved, @function
print_n_instruction_retrieved:
	addi	sp,sp,-80
	sw	s0,72(sp)
	sw	s1,68(sp)
	sw	s2,64(sp)
	sw	s3,60(sp)
	sw	s4,56(sp)
	sw	s5,52(sp)
	sw	s6,48(sp)
	sw	ra,76(sp)
	call	get_n_instruction_retrieved
	lui	a5,%hi(.LC1)
	addi	a5,a5,%lo(.LC1)
	lw	t3,0(a5)
	lw	t1,4(a5)
	lw	a7,8(a5)
	lw	a6,12(a5)
	lw	a1,16(a5)
	lw	a2,20(a5)
	lw	a3,24(a5)
	lw	a4,28(a5)
	lhu	a5,32(a5)
	li	s0,-858992640
	li	s2,-858992640
	mv	s1,a0
	sw	t3,12(sp)
	sw	t1,16(sp)
	sw	a7,20(sp)
	sw	a6,24(sp)
	sw	a1,28(sp)
	sw	a2,32(sp)
	sw	a3,36(sp)
	sw	a4,40(sp)
	sh	a5,44(sp)
	addi	s6,sp,43
	li	s4,10
	li	s5,0
	li	s3,5
	addi	s0,s0,-819
	addi	s2,s2,-820
.L4:
	mv	a2,s4
	mv	a3,s5
	mv	a0,s1
	li	a1,0
	remu	a0,a0,a2
	add	a2,s4,s5
	sltu	a5,a2,s4
	add	a2,a2,a5
	remu	a2,a2,s3
	addi	s6,s6,-1
	sub	a2,s4,a2
	sgtu	a3,a2,s4
	sub	a3,s5,a3
	mul	a4,a2,s2
	mul	a3,a3,s0
	mulhu	a5,a2,s0
	add	a3,a3,a4
	mul	a2,a2,s0
	add	a3,a3,a5
	slli	a5,a3,31
	srli	a3,a3,1
	srli	a2,a2,1
	or	a2,a5,a2
	divu	a0,a0,a2
	slli	a5,s4,2
	srli	a2,s4,30
	slli	a4,s5,2
	add	a3,a5,s4
	or	a4,a2,a4
	add	a4,a4,s5
	sltu	a5,a3,a5
	add	a5,a5,a4
	addi	a0,a0,48
	mv	a4,s5
	slli	a5,a5,1
	srli	s5,a3,31
	sb	a0,1(s6)
	mv	a2,s4
	or	s5,s5,a5
	slli	s4,a3,1
	bne	a4,zero,.L6
	bleu	a2,s1,.L4
.L6:
	lui	s0,%hi(.LC2)
	addi	a1,s0,%lo(.LC2)
	li	a2,1
	li	a0,1
	# call write
	li a7, 64
	ecall
	addi	a1,sp,12
	li	a2,33
	li	a0,1
	# call write
	li a7, 64
	ecall
	addi	a1,s0,%lo(.LC2)
	li	a2,1
	li	a0,1
	# call write
	li a7, 64
	ecall
	lw	ra,76(sp)
	lw	s0,72(sp)
	lw	s1,68(sp)
	lw	s2,64(sp)
	lw	s3,60(sp)
	lw	s4,56(sp)
	lw	s5,52(sp)
	lw	s6,48(sp)
	addi	sp,sp,80
	jr	ra
	.size	print_n_instruction_retrieved, .-print_n_instruction_retrieved
	.section	.rodata.str1.4
	.align	2
.LC3:
	.string	"is palindrome?    # of cycles\n"
	.text
	.align	2
	.globl	print_result_header
	.type	print_result_header, @function
print_result_header:
	lui	a5,%hi(.LC3)
	addi	a5,a5,%lo(.LC3)
	lw	t5,0(a5)
	lw	t4,4(a5)
	lw	t3,8(a5)
	lw	t1,12(a5)
	lw	a7,16(a5)
	lw	a6,20(a5)
	lw	a3,24(a5)
	lhu	a4,28(a5)
	lbu	a5,30(a5)
	addi	sp,sp,-48
	mv	a1,sp
	li	a2,30
	li	a0,1
	sw	ra,44(sp)
	sw	t5,0(sp)
	sw	t4,4(sp)
	sw	t3,8(sp)
	sw	t1,12(sp)
	sw	a7,16(sp)
	sw	a6,20(sp)
	sw	a3,24(sp)
	sh	a4,28(sp)
	sb	a5,30(sp)
	# call write
	li a7, 64
	ecall
	lw	ra,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	print_result_header, .-print_result_header
	.section	.rodata.str1.4
	.align	2
.LC4:
	.string	"                             \n"
	.text
	.align	2
	.globl	print_result
	.type	print_result, @function
print_result:
	lui	a5,%hi(.LC4)
	addi	a5,a5,%lo(.LC4)
	lw	t5,12(a5)
	lw	t4,0(a5)
	lw	t3,4(a5)
	lw	t1,8(a5)
	lw	a7,16(a5)
	lw	a6,20(a5)
	lw	a3,24(a5)
	lhu	a4,28(a5)
	lbu	a5,30(a5)
	addi	sp,sp,-80
	snez	a0,a0
	sw	s0,72(sp)
	sw	s2,64(sp)
	sw	t5,12(sp)
	addi	a0,a0,48
	li	s0,-858992640
	li	s2,-858992640
	sw	s1,68(sp)
	sw	s3,60(sp)
	sw	s4,56(sp)
	sw	s5,52(sp)
	sw	s6,48(sp)
	sw	s7,44(sp)
	sw	ra,76(sp)
	mv	s1,a1
	mv	s6,a2
	sw	t4,0(sp)
	sw	t3,4(sp)
	sw	t1,8(sp)
	sw	a7,16(sp)
	sw	a6,20(sp)
	sw	a3,24(sp)
	sh	a4,28(sp)
	sb	a5,30(sp)
	sb	a0,13(sp)
	addi	s7,sp,28
	li	s4,10
	li	s5,0
	li	s3,5
	addi	s0,s0,-819
	addi	s2,s2,-820
.L19:
	mv	a2,s4
	mv	a3,s5
	mv	a0,s1
	mv	a1,s6
	remu	a0,a0,a2
	add	a5,s4,s5
	sltu	a4,a5,s4
	add	a5,a5,a4
	remu	a5,a5,s3
	addi	s7,s7,-1
	sub	a5,s4,a5
	sgtu	a3,a5,s4
	sub	a3,s5,a3
	mul	a2,a5,s2
	mul	a3,a3,s0
	mulhu	a4,a5,s0
	add	a3,a3,a2
	mul	a5,a5,s0
	add	a3,a3,a4
	slli	a2,a3,31
	srli	a3,a3,1
	srli	a5,a5,1
	or	a2,a2,a5
	divu	a0,a0,a2
	slli	a5,s4,2
	srli	a2,s4,30
	slli	a4,s5,2
	add	a3,a5,s4
	or	a4,a2,a4
	add	a4,a4,s5
	sltu	a5,a3,a5
	add	a5,a5,a4
	addi	a0,a0,48
	mv	a4,s5
	slli	a5,a5,1
	srli	s5,a3,31
	sb	a0,1(s7)
	mv	a2,s4
	or	s5,s5,a5
	slli	s4,a3,1
	bgtu	a4,s6,.L18
	bne	a4,s6,.L19
	bleu	a2,s1,.L19
.L18:
	mv	a1,sp
	li	a2,30
	li	a0,1
	# call write
	li a7, 64
	ecall
	lw	ra,76(sp)
	lw	s0,72(sp)
	lw	s1,68(sp)
	lw	s2,64(sp)
	lw	s3,60(sp)
	lw	s4,56(sp)
	lw	s5,52(sp)
	lw	s6,48(sp)
	lw	s7,44(sp)
	addi	sp,sp,80
	jr	ra
	.size	print_result, .-print_result
	.align	2
	.globl	count_leading_zeros
	.type	count_leading_zeros, @function
count_leading_zeros:
	slli	a4,a1,31
	srli	a5,a0,1
	or	a5,a4,a5
	srli	a4,a1,1
	or	a1,a4,a1
	or	a0,a5,a0
	slli	a4,a1,30
	srli	a5,a0,2
	or	a5,a4,a5
	srli	a4,a1,2
	or	a4,a4,a1
	or	a0,a5,a0
	slli	a3,a4,28
	srli	a5,a0,4
	or	a5,a3,a5
	srli	a3,a4,4
	or	a3,a3,a4
	or	a4,a5,a0
	slli	a2,a3,24
	srli	a5,a4,8
	or	a5,a2,a5
	srli	a2,a3,8
	or	a2,a2,a3
	or	a5,a5,a4
	srli	a3,a5,16
	slli	a4,a2,16
	or	a3,a4,a3
	srli	a4,a2,16
	or	a4,a4,a2
	or	a3,a3,a5
	or	a3,a4,a3
	slli	a1,a4,31
	srli	a5,a3,1
	li	a2,1431654400
	addi	a2,a2,1365
	or	a5,a1,a5
	and	a5,a5,a2
	srli	a1,a4,1
	sub	a5,a3,a5
	and	a2,a1,a2
	sgtu	a3,a5,a3
	sub	a4,a4,a2
	sub	a4,a4,a3
	slli	a1,a4,30
	srli	a3,a5,2
	li	a2,858992640
	addi	a2,a2,819
	or	a3,a1,a3
	and	a3,a3,a2
	srli	a1,a4,2
	and	a5,a5,a2
	add	a5,a3,a5
	and	a1,a1,a2
	and	a4,a4,a2
	add	a4,a1,a4
	sltu	a3,a5,a3
	add	a3,a3,a4
	slli	a2,a3,28
	srli	a4,a5,4
	or	a4,a2,a4
	add	a5,a4,a5
	srli	a2,a3,4
	add	a2,a2,a3
	sltu	a4,a5,a4
	li	a3,252645376
	addi	a3,a3,-241
	add	a4,a4,a2
	and	a4,a4,a3
	and	a5,a5,a3
	slli	a2,a4,24
	srli	a3,a5,8
	or	a3,a2,a3
	add	a5,a3,a5
	srli	a2,a4,8
	add	a4,a2,a4
	sltu	a3,a5,a3
	add	a3,a3,a4
	slli	a2,a3,16
	srli	a4,a5,16
	or	a4,a2,a4
	add	a5,a4,a5
	srli	a2,a3,16
	sltu	a4,a5,a4
	add	a3,a2,a3
	add	a4,a4,a3
	add	a4,a4,a5
	andi	a4,a4,127
	li	a0,64
	sub	a0,a0,a4
	slli	a0,a0,16
	srli	a0,a0,16
	ret
	.size	count_leading_zeros, .-count_leading_zeros
	.align	2
	.globl	is_palindrome
	.type	is_palindrome, @function
is_palindrome:
	slli	a2,a1,31
	srli	a4,a0,1
	or	a2,a2,a4
	srli	a3,a1,1
	or	a3,a3,a1
	or	a2,a2,a0
	slli	a6,a3,30
	srli	a5,a2,2
	or	a5,a6,a5
	srli	a6,a3,2
	or	a3,a3,a6
	or	a2,a2,a5
	slli	a6,a3,28
	srli	a5,a2,4
	or	a5,a6,a5
	srli	a6,a3,4
	or	a3,a3,a6
	or	a2,a2,a5
	slli	a6,a3,24
	srli	a5,a2,8
	or	a5,a6,a5
	srli	a6,a3,8
	or	a3,a3,a6
	or	a2,a2,a5
	slli	a6,a3,16
	srli	a5,a2,16
	or	a5,a6,a5
	srli	a6,a3,16
	or	a3,a3,a6
	or	a2,a2,a5
	or	a2,a2,a3
	slli	a7,a3,31
	srli	a5,a2,1
	li	a6,1431654400
	addi	a6,a6,1365
	or	a5,a7,a5
	and	a5,a5,a6
	srli	a7,a3,1
	sub	a5,a2,a5
	and	a6,a7,a6
	sgtu	a2,a5,a2
	sub	a3,a3,a6
	sub	a3,a3,a2
	slli	a7,a3,30
	srli	a2,a5,2
	li	a6,858992640
	addi	a6,a6,819
	or	a2,a7,a2
	and	a2,a2,a6
	srli	a7,a3,2
	and	a5,a5,a6
	add	a5,a2,a5
	and	a7,a7,a6
	and	a3,a3,a6
	add	a3,a7,a3
	sltu	a2,a5,a2
	add	a2,a2,a3
	slli	a6,a2,28
	srli	a3,a5,4
	or	a3,a6,a3
	add	a5,a3,a5
	srli	a6,a2,4
	add	a6,a6,a2
	sltu	a3,a5,a3
	li	a2,252645376
	addi	a2,a2,-241
	add	a3,a3,a6
	and	a3,a3,a2
	and	a5,a5,a2
	slli	a6,a3,24
	srli	a2,a5,8
	or	a2,a6,a2
	add	a2,a5,a2
	srli	a6,a3,8
	add	a3,a3,a6
	sltu	a5,a2,a5
	add	a5,a5,a3
	slli	a6,a5,16
	srli	a3,a2,16
	or	a3,a6,a3
	add	a3,a2,a3
	srli	a6,a5,16
	add	a5,a5,a6
	sltu	a2,a3,a2
	add	a2,a2,a5
	add	a3,a3,a2
	andi	a3,a3,127
	li	a7,64
	sub	a7,a7,a3
	slli	a7,a7,16
	li	a5,64
	srli	a7,a7,16
	sub	a3,a5,a7
	sgtu	a5,a3,a5
	srli	a6,a3,1
	slli	a5,a5,31
	andi	a3,a3,1
	or	a6,a5,a6
	add	a6,a6,a3
	addi	a2,a6,-32
	blt	a2,zero,.L23
	srl	a2,a1,a2
	li	a5,0
.L24:
	slli	t6,a5,31
	srli	t5,a2,31
	srli	a3,a2,1
	slli	t1,a5,1
	li	t4,1431654400
	li	t3,-1431654400
	addi	t4,t4,1365
	addi	t3,t3,-1366
	or	a3,t6,a3
	or	t1,t5,t1
	srli	a5,a5,1
	slli	a2,a2,1
	and	a2,a2,t3
	and	t1,t1,t3
	and	a3,a3,t4
	and	a5,a5,t4
	or	a3,a3,a2
	or	a5,a5,t1
	slli	t6,a5,30
	srli	t5,a3,30
	srli	a2,a3,2
	slli	t1,a5,2
	li	t4,858992640
	li	t3,-858992640
	addi	t4,t4,819
	addi	t3,t3,-820
	or	a2,t6,a2
	or	t1,t5,t1
	srli	a5,a5,2
	slli	a3,a3,2
	and	a3,a3,t3
	and	t1,t1,t3
	and	a2,a2,t4
	and	a5,a5,t4
	or	a2,a2,a3
	or	a5,a5,t1
	slli	t6,a5,28
	srli	t5,a2,28
	srli	a3,a2,4
	slli	t1,a5,4
	li	t4,252645376
	li	t3,-252645376
	addi	t4,t4,-241
	addi	t3,t3,240
	or	a3,t6,a3
	or	t1,t5,t1
	srli	a5,a5,4
	slli	a2,a2,4
	and	a2,a2,t3
	and	t1,t1,t3
	and	a3,a3,t4
	and	a5,a5,t4
	or	a3,a3,a2
	or	a5,a5,t1
	slli	t6,a5,24
	srli	a2,a3,8
	srli	t5,a3,24
	slli	t1,a5,8
	li	t4,16711680
	li	t3,-16711680
	addi	t4,t4,255
	addi	t3,t3,-256
	or	a2,t6,a2
	srli	a5,a5,8
	or	t1,t5,t1
	slli	a3,a3,8
	and	a3,a3,t3
	and	t1,t1,t3
	and	a2,a2,t4
	and	a5,a5,t4
	or	a2,a2,a3
	or	a5,a5,t1
	slli	t1,a5,16
	srli	a3,a2,16
	or	a3,t1,a3
	li	t1,65536
	addi	t1,t1,-1
	srli	a5,a5,16
	add	a6,a6,a7
	and	a5,a5,t1
	and	a7,a3,t1
	li	t1,-65536
	and	t1,t1,a3
	slli	a2,a2,16
	addi	a3,a6,-32
	or	a2,a7,a2
	or	a5,a5,t1
	blt	a3,zero,.L25
	sll	a1,a0,a3
	li	a0,0
.L26:
	blt	a3,zero,.L27
	srl	a0,a1,a3
	li	a1,0
.L28:
	blt	a3,zero,.L29
	srl	a3,a2,a3
	li	a2,0
	xor	a0,a0,a3
	xor	a1,a1,a2
	or	a0,a0,a1
	seqz	a0,a0
	ret
.L23:
	li	a3,31
	slli	a5,a1,1
	sub	a3,a3,a6
	sll	a5,a5,a3
	srl	a2,a0,a6
	or	a2,a5,a2
	srl	a5,a1,a6
	j	.L24
.L29:
	li	a3,31
	sub	a3,a3,a6
	slli	a4,a2,1
	sll	a4,a4,a3
	srl	a3,a5,a6
	or	a3,a4,a3
	srl	a2,a2,a6
	xor	a0,a0,a3
	xor	a1,a1,a2
	or	a0,a0,a1
	seqz	a0,a0
	ret
.L27:
	li	a7,31
	slli	a4,a1,1
	sub	a7,a7,a6
	sll	a4,a4,a7
	srl	a0,a0,a6
	or	a0,a4,a0
	srl	a1,a1,a6
	j	.L28
.L25:
	li	a7,31
	sub	a7,a7,a6
	srl	a4,a4,a7
	sll	a1,a1,a6
	or	a1,a4,a1
	sll	a0,a0,a6
	j	.L26
	.size	is_palindrome, .-is_palindrome
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lw	a7,0(a5)
	lw	a6,4(a5)
	lw	a0,8(a5)
	lw	a1,12(a5)
	lw	a2,16(a5)
	lw	a3,20(a5)
	lw	a4,24(a5)
	lw	a5,28(a5)
	addi	sp,sp,-112
	sw	ra,108(sp)
	sw	s0,104(sp)
	sw	s2,96(sp)
	sw	s3,92(sp)
	sw	s4,88(sp)
	sw	s5,84(sp)
	sw	s6,80(sp)
	sw	a7,32(sp)
	sw	a6,36(sp)
	sw	a0,40(sp)
	sw	a1,44(sp)
	sw	a2,48(sp)
	sw	a3,52(sp)
	sw	a4,56(sp)
	sw	a5,60(sp)
	sw	s1,100(sp)
	sw	s7,76(sp)
	sw	s8,72(sp)
	sw	s9,68(sp)
	sw	s10,64(sp)
	call	print_n_instruction_retrieved
	lui	a5,%hi(.LC3)
	addi	a5,a5,%lo(.LC3)
	lw	t5,0(a5)
	lw	t4,4(a5)
	lw	t3,8(a5)
	lw	t1,12(a5)
	lw	a7,16(a5)
	lw	a6,20(a5)
	lw	a3,24(a5)
	lhu	a4,28(a5)
	lbu	a5,30(a5)
	li	a2,30
	mv	a1,sp
	li	a0,1
	li	s0,-858992640
	li	s2,-858992640
	lui	s3,%hi(.LC4)
	sw	t5,0(sp)
	sw	t4,4(sp)
	sw	t3,8(sp)
	sw	t1,12(sp)
	sw	a7,16(sp)
	sw	a6,20(sp)
	sw	a3,24(sp)
	sh	a4,28(sp)
	sb	a5,30(sp)
	addi	s5,sp,32
	# call write
	li a7, 64
	ecall
	addi	s6,sp,64
	addi	s3,s3,%lo(.LC4)
	li	s4,5
	addi	s0,s0,-819
	addi	s2,s2,-820
.L37:
	call	get_n_csr_cycle
	mv	s8,a1
	mv	s1,a0
	lw	a1,4(s5)
	lw	a0,0(s5)
	addi	s10,sp,28
	call	is_palindrome
	mv	s7,a0
	call	get_n_csr_cycle
	lw	t5,12(s3)
	lw	t4,0(s3)
	lw	t3,4(s3)
	lw	t1,8(s3)
	lw	a7,16(s3)
	lw	a6,20(s3)
	lw	a2,24(s3)
	lhu	a3,28(s3)
	lbu	a4,30(s3)
	snez	a5,s7
	sub	s1,a0,s1
	sub	s9,a1,s8
	sgtu	a0,s1,a0
	sw	t5,12(sp)
	addi	a5,a5,48
	sub	s9,s9,a0
	sw	t4,0(sp)
	sw	t3,4(sp)
	sw	t1,8(sp)
	sw	a7,16(sp)
	sw	a6,20(sp)
	sw	a2,24(sp)
	sh	a3,28(sp)
	sb	a4,30(sp)
	sb	a5,13(sp)
	li	s7,10
	li	s8,0
.L41:
	mv	a2,s7
	mv	a3,s8
	mv	a0,s1
	mv	a1,s9
	remu	a0,a0,a2
	add	a2,s7,s8
	sltu	a5,a2,s7
	add	a2,a2,a5
	remu	a2,a2,s4
	addi	s10,s10,-1
	sub	a2,s7,a2
	sgtu	a3,a2,s7
	sub	a3,s8,a3
	mul	a4,a2,s2
	mul	a3,a3,s0
	mulhu	a5,a2,s0
	add	a3,a3,a4
	mul	a2,a2,s0
	add	a3,a3,a5
	slli	a5,a3,31
	srli	a3,a3,1
	srli	a2,a2,1
	or	a2,a5,a2
	divu	a0,a0,a2
	slli	a5,s7,2
	srli	a2,s7,30
	slli	a4,s8,2
	add	a3,a5,s7
	or	a4,a2,a4
	add	a4,a4,s8
	sltu	a5,a3,a5
	add	a5,a5,a4
	addi	a0,a0,48
	mv	a4,s8
	slli	a5,a5,1
	srli	s8,a3,31
	sb	a0,1(s10)
	mv	a2,s7
	or	s8,s8,a5
	slli	s7,a3,1
	bgtu	a4,s9,.L39
	bne	a4,s9,.L41
	bleu	a2,s1,.L41
.L39:
	li	a2,30
	mv	a1,sp
	li	a0,1
	addi	s5,s5,8
	# call write
	li a7, 64
	ecall
	bne	s5,s6,.L37
	lui	a1,%hi(.LC2)
	li	a2,1
	addi	a1,a1,%lo(.LC2)
	li	a0,1
	# call write
	li a7, 64
	ecall
	lw	ra,108(sp)
	lw	s0,104(sp)
	lw	s1,100(sp)
	lw	s2,96(sp)
	lw	s3,92(sp)
	lw	s4,88(sp)
	lw	s5,84(sp)
	lw	s6,80(sp)
	lw	s7,76(sp)
	lw	s8,72(sp)
	lw	s9,68(sp)
	lw	s10,64(sp)
	li	a0,0
	addi	sp,sp,112
	# exit program
	li a7, 93           # "exit" syscall
	add a0, x0, 0       # Use 0 return code
	ecall               # invoke syscall to terminate the program
	.size	main, .-main
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.word	0
	.word	0
	.word	1
	.word	0
	.word	3
	.word	3072
	.word	240
	.word	251658240
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"
