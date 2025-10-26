
test_jump.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	00010117          	auipc	sp,0x10
   4:	00010113          	mv	sp,sp
   8:	024000ef          	jal	2c <main>
   c:	0000006f          	j	c <_start+0xc>

00000010 <func_target>:
  10:	ff010113          	addi	sp,sp,-16 # fff0 <result+0xff68>
  14:	00112623          	sw	ra,12(sp)
  18:	00812423          	sw	s0,8(sp)
  1c:	01010413          	addi	s0,sp,16
  20:	0aa00713          	li	a4,170
  24:	08e02423          	sw	a4,136(zero) # 88 <result>
  28:	0000006f          	j	28 <func_target+0x18>

0000002c <main>:
  2c:	fe010113          	addi	sp,sp,-32
  30:	00112e23          	sw	ra,28(sp)
  34:	00812c23          	sw	s0,24(sp)
  38:	02010413          	addi	s0,sp,32
  3c:	08002423          	sw	zero,136(zero) # 88 <result>
  40:	008000ef          	jal	48 <main+0x1c>
  44:	00100713          	li	a4,1
  48:	08e02423          	sw	a4,136(zero) # 88 <result>
  4c:	01100713          	li	a4,17
  50:	08e02423          	sw	a4,136(zero) # 88 <result>
  54:	01000793          	li	a5,16
  58:	fef42623          	sw	a5,-20(s0)
  5c:	fec42783          	lw	a5,-20(s0)
  60:	00078293          	mv	t0,a5
  64:	000280e7          	jalr	t0
  68:	05500713          	li	a4,85
  6c:	08e02423          	sw	a4,136(zero) # 88 <result>
  70:	fec42783          	lw	a5,-20(s0)
  74:	00078293          	mv	t0,a5
  78:	00028067          	jr	t0
  7c:	0ff00713          	li	a4,255
  80:	08e02423          	sw	a4,136(zero) # 88 <result>
  84:	0000006f          	j	84 <main+0x58>
