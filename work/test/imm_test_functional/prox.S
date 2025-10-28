
prog.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <_start>:
   10074:	00a00093          	li	ra,10
   10078:	ffb08113          	addi	sp,ra,-5
   1007c:	07f00193          	li	gp,127
   10080:	06400213          	li	tp,100
   10084:	00822283          	lw	t0,8(tp) # 8 <_start-0x1006c>
   10088:	00c00313          	li	t1,12
   1008c:	000303e7          	jalr	t2,t1
   10090:	00100413          	li	s0,1
   10094:	00341493          	slli	s1,s0,0x3
   10098:	00145513          	srli	a0,s0,0x1
   1009c:	0c800593          	li	a1,200
   100a0:	0015a023          	sw	ra,0(a1)
   100a4:	00500613          	li	a2,5
   100a8:	00500693          	li	a3,5
   100ac:	00d60463          	beq	a2,a3,100b4 <label>
   100b0:	00000713          	li	a4,0

000100b4 <label>:
   100b4:	02a00793          	li	a5,42
   100b8:	0080086f          	jal	a6,100c0 <jal_label>
   100bc:	00000893          	li	a7,0

000100c0 <jal_label>:
   100c0:	07b00913          	li	s2,123
   100c4:	123459b7          	lui	s3,0x12345
   100c8:	12345a17          	auipc	s4,0x12345
