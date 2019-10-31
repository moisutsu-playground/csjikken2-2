	.file	1 "my_print_B_while.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-8
	sw	$fp,0($sp)
	move	$fp,$sp
$L2:
	li	$2,768			# 0x300
	sw	$0,0($2)
	li	$3,772			# 0x304
	li	$2,2			# 0x2
	sw	$2,0($3)
	li	$3,768			# 0x300
	li	$2,1			# 0x1
	sw	$2,0($3)
	j	$L2
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 4.2.0"
