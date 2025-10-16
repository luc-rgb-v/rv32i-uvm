
prime_sort.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <main>:
   0:	fd010113          	addi	sp,sp,-48
   4:	01712623          	sw	s7,12(sp)
   8:	00001bb7          	lui	s7,0x1
   c:	01612823          	sw	s6,16(sp)
  10:	2ecbab03          	lw	s6,748(s7) # 12ec <__DATA_BEGIN__>
  14:	01512a23          	sw	s5,20(sp)
  18:	02912223          	sw	s1,36(sp)
  1c:	03212023          	sw	s2,32(sp)
  20:	01312e23          	sw	s3,28(sp)
  24:	01412c23          	sw	s4,24(sp)
  28:	01812423          	sw	s8,8(sp)
  2c:	02112623          	sw	ra,44(sp)
  30:	02812423          	sw	s0,40(sp)
  34:	80418a93          	addi	s5,gp,-2044 # 12f0 <primes>
  38:	000b0913          	mv	s2,s6
  3c:	00000c13          	li	s8,0
  40:	00200493          	li	s1,2
  44:	00300993          	li	s3,3
  48:	06500a13          	li	s4,101
  4c:	00200413          	li	s0,2
  50:	0099c863          	blt	s3,s1,60 <main+0x60>
  54:	0840006f          	j	d8 <main+0xd8>
  58:	1bc000ef          	jal	214 <__mulsi3>
  5c:	04a4ce63          	blt	s1,a0,b8 <main+0xb8>
  60:	00040593          	mv	a1,s0
  64:	00048513          	mv	a0,s1
  68:	254000ef          	jal	2bc <__modsi3>
  6c:	00140413          	addi	s0,s0,1
  70:	00050793          	mv	a5,a0
  74:	00040593          	mv	a1,s0
  78:	00040513          	mv	a0,s0
  7c:	fc079ee3          	bnez	a5,58 <main+0x58>
  80:	00148493          	addi	s1,s1,1
  84:	fd4494e3          	bne	s1,s4,4c <main+0x4c>
  88:	060c0663          	beqz	s8,f4 <main+0xf4>
  8c:	2f2ba623          	sw	s2,748(s7)
  90:	07205663          	blez	s2,fc <main+0xfc>
  94:	000a8593          	mv	a1,s5
  98:	190a8513          	addi	a0,s5,400
  9c:	00291613          	slli	a2,s2,0x2
  a0:	064000ef          	jal	104 <memcpy>
  a4:	00050793          	mv	a5,a0
  a8:	00090593          	mv	a1,s2
  ac:	00078513          	mv	a0,a5
  b0:	10c000ef          	jal	1bc <sort_desc>
  b4:	0000006f          	j	b4 <main+0xb4>
  b8:	00291793          	slli	a5,s2,0x2
  bc:	00fa87b3          	add	a5,s5,a5
  c0:	0097a023          	sw	s1,0(a5)
  c4:	00148493          	addi	s1,s1,1
  c8:	00190913          	addi	s2,s2,1
  cc:	00100c13          	li	s8,1
  d0:	f7449ee3          	bne	s1,s4,4c <main+0x4c>
  d4:	fb5ff06f          	j	88 <main+0x88>
  d8:	00291793          	slli	a5,s2,0x2
  dc:	00fa87b3          	add	a5,s5,a5
  e0:	0097a023          	sw	s1,0(a5)
  e4:	00190913          	addi	s2,s2,1
  e8:	00148493          	addi	s1,s1,1
  ec:	00100c13          	li	s8,1
  f0:	f5dff06f          	j	4c <main+0x4c>
  f4:	000b0913          	mv	s2,s6
  f8:	f9204ee3          	bgtz	s2,94 <main+0x94>
  fc:	99418793          	addi	a5,gp,-1644 # 1480 <sorted>
 100:	fa9ff06f          	j	a8 <main+0xa8>

00000104 <memcpy>:
 104:	02060063          	beqz	a2,124 <memcpy+0x20>
 108:	00c50633          	add	a2,a0,a2
 10c:	00050793          	mv	a5,a0
 110:	0005c703          	lbu	a4,0(a1)
 114:	00178793          	addi	a5,a5,1
 118:	00158593          	addi	a1,a1,1
 11c:	fee78fa3          	sb	a4,-1(a5)
 120:	fef618e3          	bne	a2,a5,110 <memcpy+0xc>
 124:	00008067          	ret

00000128 <is_prime>:
 128:	00100793          	li	a5,1
 12c:	08a7d263          	bge	a5,a0,1b0 <is_prime+0x88>
 130:	00300713          	li	a4,3
 134:	08a75063          	bge	a4,a0,1b4 <is_prime+0x8c>
 138:	ff010113          	addi	sp,sp,-16
 13c:	00812423          	sw	s0,8(sp)
 140:	00912223          	sw	s1,4(sp)
 144:	00112623          	sw	ra,12(sp)
 148:	00050493          	mv	s1,a0
 14c:	00200413          	li	s0,2
 150:	00c0006f          	j	15c <is_prime+0x34>
 154:	0c0000ef          	jal	214 <__mulsi3>
 158:	02a4ce63          	blt	s1,a0,194 <is_prime+0x6c>
 15c:	00040593          	mv	a1,s0
 160:	00048513          	mv	a0,s1
 164:	158000ef          	jal	2bc <__modsi3>
 168:	00140413          	addi	s0,s0,1
 16c:	00050793          	mv	a5,a0
 170:	00040593          	mv	a1,s0
 174:	00040513          	mv	a0,s0
 178:	fc079ee3          	bnez	a5,154 <is_prime+0x2c>
 17c:	00c12083          	lw	ra,12(sp)
 180:	00812403          	lw	s0,8(sp)
 184:	00412483          	lw	s1,4(sp)
 188:	00078513          	mv	a0,a5
 18c:	01010113          	addi	sp,sp,16
 190:	00008067          	ret
 194:	00c12083          	lw	ra,12(sp)
 198:	00812403          	lw	s0,8(sp)
 19c:	00100793          	li	a5,1
 1a0:	00412483          	lw	s1,4(sp)
 1a4:	00078513          	mv	a0,a5
 1a8:	01010113          	addi	sp,sp,16
 1ac:	00008067          	ret
 1b0:	00000793          	li	a5,0
 1b4:	00078513          	mv	a0,a5
 1b8:	00008067          	ret

000001bc <sort_desc>:
 1bc:	00100813          	li	a6,1
 1c0:	04b85863          	bge	a6,a1,210 <sort_desc+0x54>
 1c4:	00259613          	slli	a2,a1,0x2
 1c8:	00c50633          	add	a2,a0,a2
 1cc:	00450793          	addi	a5,a0,4
 1d0:	02b85a63          	bge	a6,a1,204 <sort_desc+0x48>
 1d4:	ffc7a703          	lw	a4,-4(a5)
 1d8:	0007a683          	lw	a3,0(a5)
 1dc:	00d75663          	bge	a4,a3,1e8 <sort_desc+0x2c>
 1e0:	fed7ae23          	sw	a3,-4(a5)
 1e4:	00e7a023          	sw	a4,0(a5)
 1e8:	00478793          	addi	a5,a5,4
 1ec:	fec794e3          	bne	a5,a2,1d4 <sort_desc+0x18>
 1f0:	fff58593          	addi	a1,a1,-1
 1f4:	01058e63          	beq	a1,a6,210 <sort_desc+0x54>
 1f8:	ffc60613          	addi	a2,a2,-4
 1fc:	00450793          	addi	a5,a0,4
 200:	fcb84ae3          	blt	a6,a1,1d4 <sort_desc+0x18>
 204:	fff58593          	addi	a1,a1,-1
 208:	ffc60613          	addi	a2,a2,-4
 20c:	fc1ff06f          	j	1cc <sort_desc+0x10>
 210:	00008067          	ret

00000214 <__mulsi3>:
 214:	00050613          	mv	a2,a0
 218:	00000513          	li	a0,0
 21c:	0015f693          	andi	a3,a1,1
 220:	00068463          	beqz	a3,228 <__mulsi3+0x14>
 224:	00c50533          	add	a0,a0,a2
 228:	0015d593          	srli	a1,a1,0x1
 22c:	00161613          	slli	a2,a2,0x1
 230:	fe0596e3          	bnez	a1,21c <__mulsi3+0x8>
 234:	00008067          	ret

00000238 <__divsi3>:
 238:	06054063          	bltz	a0,298 <__umodsi3+0x10>
 23c:	0605c663          	bltz	a1,2a8 <__umodsi3+0x20>

00000240 <__hidden___udivsi3>:
 240:	00058613          	mv	a2,a1
 244:	00050593          	mv	a1,a0
 248:	fff00513          	li	a0,-1
 24c:	02060c63          	beqz	a2,284 <__hidden___udivsi3+0x44>
 250:	00100693          	li	a3,1
 254:	00b67a63          	bgeu	a2,a1,268 <__hidden___udivsi3+0x28>
 258:	00c05863          	blez	a2,268 <__hidden___udivsi3+0x28>
 25c:	00161613          	slli	a2,a2,0x1
 260:	00169693          	slli	a3,a3,0x1
 264:	feb66ae3          	bltu	a2,a1,258 <__hidden___udivsi3+0x18>
 268:	00000513          	li	a0,0
 26c:	00c5e663          	bltu	a1,a2,278 <__hidden___udivsi3+0x38>
 270:	40c585b3          	sub	a1,a1,a2
 274:	00d56533          	or	a0,a0,a3
 278:	0016d693          	srli	a3,a3,0x1
 27c:	00165613          	srli	a2,a2,0x1
 280:	fe0696e3          	bnez	a3,26c <__hidden___udivsi3+0x2c>
 284:	00008067          	ret

00000288 <__umodsi3>:
 288:	00008293          	mv	t0,ra
 28c:	fb5ff0ef          	jal	240 <__hidden___udivsi3>
 290:	00058513          	mv	a0,a1
 294:	00028067          	jr	t0
 298:	40a00533          	neg	a0,a0
 29c:	00b04863          	bgtz	a1,2ac <__umodsi3+0x24>
 2a0:	40b005b3          	neg	a1,a1
 2a4:	f9dff06f          	j	240 <__hidden___udivsi3>
 2a8:	40b005b3          	neg	a1,a1
 2ac:	00008293          	mv	t0,ra
 2b0:	f91ff0ef          	jal	240 <__hidden___udivsi3>
 2b4:	40a00533          	neg	a0,a0
 2b8:	00028067          	jr	t0

000002bc <__modsi3>:
 2bc:	00008293          	mv	t0,ra
 2c0:	0005ca63          	bltz	a1,2d4 <__modsi3+0x18>
 2c4:	00054c63          	bltz	a0,2dc <__modsi3+0x20>
 2c8:	f79ff0ef          	jal	240 <__hidden___udivsi3>
 2cc:	00058513          	mv	a0,a1
 2d0:	00028067          	jr	t0
 2d4:	40b005b3          	neg	a1,a1
 2d8:	fe0558e3          	bgez	a0,2c8 <__modsi3+0xc>
 2dc:	40a00533          	neg	a0,a0
 2e0:	f61ff0ef          	jal	240 <__hidden___udivsi3>
 2e4:	40b00533          	neg	a0,a1
 2e8:	00028067          	jr	t0

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	2029                	.insn	2, 0x2029
   8:	3531                	.insn	2, 0x3531
   a:	312e                	.insn	2, 0x312e
   c:	302e                	.insn	2, 0x302e
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	.insn	2, 0x1b41
   2:	0000                	.insn	2, 0x0000
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <main+0x14>
   c:	0011                	.insn	2, 0x0011
   e:	0000                	.insn	2, 0x0000
  10:	1004                	.insn	2, 0x1004
  12:	7205                	.insn	2, 0x7205
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	0031                	.insn	2, 0x0031

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	001c                	.insn	2, 0x001c
   2:	0000                	.insn	2, 0x0000
   4:	0002                	.insn	2, 0x0002
   6:	0000                	.insn	2, 0x0000
   8:	0000                	.insn	2, 0x0000
   a:	0004                	.insn	2, 0x0004
   c:	0000                	.insn	2, 0x0000
   e:	0000                	.insn	2, 0x0000
  10:	0214                	.insn	2, 0x0214
  12:	0000                	.insn	2, 0x0000
  14:	0024                	.insn	2, 0x0024
	...
  1e:	0000                	.insn	2, 0x0000
  20:	001c                	.insn	2, 0x001c
  22:	0000                	.insn	2, 0x0000
  24:	0002                	.insn	2, 0x0002
  26:	0031                	.insn	2, 0x0031
  28:	0000                	.insn	2, 0x0000
  2a:	0004                	.insn	2, 0x0004
  2c:	0000                	.insn	2, 0x0000
  2e:	0000                	.insn	2, 0x0000
  30:	0238                	.insn	2, 0x0238
  32:	0000                	.insn	2, 0x0000
  34:	00b4                	.insn	2, 0x00b4
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	002d                	.insn	2, 0x002d
   2:	0000                	.insn	2, 0x0000
   4:	0005                	.insn	2, 0x0005
   6:	0401                	.insn	2, 0x0401
   8:	0000                	.insn	2, 0x0000
   a:	0000                	.insn	2, 0x0000
   c:	0001                	.insn	2, 0x0001
   e:	0000                	.insn	2, 0x0000
  10:	1400                	.insn	2, 0x1400
  12:	0002                	.insn	2, 0x0002
  14:	2400                	.insn	2, 0x2400
  16:	0000                	.insn	2, 0x0000
  18:	0000                	.insn	2, 0x0000
  1a:	002d                	.insn	2, 0x002d
  1c:	0000                	.insn	2, 0x0000
  1e:	008c                	.insn	2, 0x008c
  20:	0000                	.insn	2, 0x0000
  22:	8001                	.insn	2, 0x8001
  24:	9802                	.insn	2, 0x9802
  26:	0000                	.insn	2, 0x0000
  28:	2f00                	.insn	2, 0x2f00
  2a:	0214                	.insn	2, 0x0214
  2c:	0000                	.insn	2, 0x0000
  2e:	0324                	.insn	2, 0x0324
  30:	5b00                	.insn	2, 0x5b00
  32:	0000                	.insn	2, 0x0000
  34:	0500                	.insn	2, 0x0500
  36:	0100                	.insn	2, 0x0100
  38:	2804                	.insn	2, 0x2804
  3a:	0000                	.insn	2, 0x0000
  3c:	0100                	.insn	2, 0x0100
  3e:	007a                	.insn	2, 0x007a
  40:	0000                	.insn	2, 0x0000
  42:	0238                	.insn	2, 0x0238
  44:	0000                	.insn	2, 0x0000
  46:	01b4                	.insn	2, 0x01b4
  48:	00a1                	.insn	2, 0x00a1
  4a:	0000                	.insn	2, 0x0000
  4c:	002d                	.insn	2, 0x002d
  4e:	0000                	.insn	2, 0x0000
  50:	008c                	.insn	2, 0x008c
  52:	0000                	.insn	2, 0x0000
  54:	8001                	.insn	2, 0x8001
  56:	cb02                	.insn	2, 0xcb02
  58:	0000                	.insn	2, 0x0000
  5a:	5d00                	.insn	2, 0x5d00
  5c:	0238                	.insn	2, 0x0238
  5e:	0000                	.insn	2, 0x0000
  60:	0184                	.insn	2, 0x0184
  62:	dd02                	.insn	2, 0xdd02
  64:	0000                	.insn	2, 0x0000
  66:	5d00                	.insn	2, 0x5d00
  68:	0240                	.insn	2, 0x0240
  6a:	0000                	.insn	2, 0x0000
  6c:	0248                	.insn	2, 0x0248
  6e:	00d4                	.insn	2, 0x00d4
  70:	0000                	.insn	2, 0x0000
  72:	405d                	.insn	2, 0x405d
  74:	0002                	.insn	2, 0x0002
  76:	4800                	.insn	2, 0x4800
  78:	e702                	.insn	2, 0xe702
  7a:	0000                	.insn	2, 0x0000
  7c:	5d00                	.insn	2, 0x5d00
  7e:	0288                	.insn	2, 0x0288
  80:	0000                	.insn	2, 0x0000
  82:	0210                	.insn	2, 0x0210
  84:	00f1                	.insn	2, 0x00f1
  86:	0000                	.insn	2, 0x0000
  88:	bc5d                	.insn	2, 0xbc5d
  8a:	0002                	.insn	2, 0x0002
  8c:	3000                	.insn	2, 0x3000
  8e:	0003                	.short	0x0003

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	1101                	.insn	2, 0x1101
   2:	1001                	.insn	2, 0x1001
   4:	12011117          	auipc	sp,0x12011
   8:	1b0e030f          	.insn	4, 0x1b0e030f
   c:	250e                	.insn	2, 0x250e
   e:	130e                	.insn	2, 0x130e
  10:	0005                	.insn	2, 0x0005
  12:	0200                	.insn	2, 0x0200
  14:	002e                	.insn	2, 0x002e
  16:	193f0e03          	lb	t3,403(t5)
  1a:	1549                	.insn	2, 0x1549
  1c:	0111                	.insn	2, 0x0111
  1e:	0f12                	.insn	2, 0x0f12
  20:	0000                	.insn	2, 0x0000
  22:	00003b03          	.insn	4, 0x3b03
  26:	0000                	.insn	2, 0x0000
  28:	1101                	.insn	2, 0x1101
  2a:	1001                	.insn	2, 0x1001
  2c:	12011117          	auipc	sp,0x12011
  30:	1b0e030f          	.insn	4, 0x1b0e030f
  34:	250e                	.insn	2, 0x250e
  36:	130e                	.insn	2, 0x130e
  38:	0005                	.insn	2, 0x0005
  3a:	0200                	.insn	2, 0x0200
  3c:	002e                	.insn	2, 0x002e
  3e:	193f0e03          	lb	t3,403(t5)
  42:	1549                	.insn	2, 0x1549
  44:	0111                	.insn	2, 0x0111
  46:	0f12                	.insn	2, 0x0f12
  48:	0000                	.insn	2, 0x0000
  4a:	00003b03          	.insn	4, 0x3b03
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0076                	.insn	2, 0x0076
   2:	0000                	.insn	2, 0x0000
   4:	0005                	.insn	2, 0x0005
   6:	0004                	.insn	2, 0x0004
   8:	002e                	.insn	2, 0x002e
   a:	0000                	.insn	2, 0x0000
   c:	0101                	.insn	2, 0x0101
   e:	fb01                	.insn	2, 0xfb01
  10:	0d0e                	.insn	2, 0x0d0e
  12:	0100                	.insn	2, 0x0100
  14:	0101                	.insn	2, 0x0101
  16:	0001                	.insn	2, 0x0001
  18:	0000                	.insn	2, 0x0000
  1a:	0001                	.insn	2, 0x0001
  1c:	0100                	.insn	2, 0x0100
  1e:	0101                	.insn	2, 0x0101
  20:	021f 0000 0000      	.insn	6, 0x021f
  26:	005f 0000 0102      	.insn	6, 0x01020000005f
  2c:	021f 020f 0083      	.insn	6, 0x0083020f021f
  32:	0000                	.insn	2, 0x0000
  34:	8301                	.insn	2, 0x8301
  36:	0000                	.insn	2, 0x0000
  38:	0100                	.insn	2, 0x0100
  3a:	0500                	.insn	2, 0x0500
  3c:	1402                	.insn	2, 0x1402
  3e:	0002                	.insn	2, 0x0002
  40:	0300                	.insn	2, 0x0300
  42:	0124                	.insn	2, 0x0124
  44:	04090103          	lb	sp,64(s2)
  48:	0100                	.insn	2, 0x0100
  4a:	04090203          	lb	tp,64(s2)
  4e:	0100                	.insn	2, 0x0100
  50:	04090103          	lb	sp,64(s2)
  54:	0100                	.insn	2, 0x0100
  56:	04090103          	lb	sp,64(s2)
  5a:	0100                	.insn	2, 0x0100
  5c:	04090203          	lb	tp,64(s2)
  60:	0100                	.insn	2, 0x0100
  62:	04090103          	lb	sp,64(s2)
  66:	0100                	.insn	2, 0x0100
  68:	04090103          	lb	sp,64(s2)
  6c:	0100                	.insn	2, 0x0100
  6e:	04090103          	lb	sp,64(s2)
  72:	0100                	.insn	2, 0x0100
  74:	0409                	.insn	2, 0x0409
  76:	0000                	.insn	2, 0x0000
  78:	0101                	.insn	2, 0x0101
  7a:	0000014f          	.insn	4, 0x014f
  7e:	0005                	.insn	2, 0x0005
  80:	0004                	.insn	2, 0x0004
  82:	002e                	.insn	2, 0x002e
  84:	0000                	.insn	2, 0x0000
  86:	0101                	.insn	2, 0x0101
  88:	fb01                	.insn	2, 0xfb01
  8a:	0d0e                	.insn	2, 0x0d0e
  8c:	0100                	.insn	2, 0x0100
  8e:	0101                	.insn	2, 0x0101
  90:	0001                	.insn	2, 0x0001
  92:	0000                	.insn	2, 0x0000
  94:	0001                	.insn	2, 0x0001
  96:	0100                	.insn	2, 0x0100
  98:	0101                	.insn	2, 0x0101
  9a:	021f 0000 0000      	.insn	6, 0x021f
  a0:	005f 0000 0102      	.insn	6, 0x01020000005f
  a6:	021f 020f 008c      	.insn	6, 0x008c020f021f
  ac:	0000                	.insn	2, 0x0000
  ae:	8c01                	.insn	2, 0x8c01
  b0:	0000                	.insn	2, 0x0000
  b2:	0100                	.insn	2, 0x0100
  b4:	0500                	.insn	2, 0x0500
  b6:	3802                	.insn	2, 0x3802
  b8:	0002                	.insn	2, 0x0002
  ba:	0300                	.insn	2, 0x0300
  bc:	00c4                	.insn	2, 0x00c4
  be:	0301                	.insn	2, 0x0301
  c0:	0901                	.insn	2, 0x0901
  c2:	0004                	.insn	2, 0x0004
  c4:	0301                	.insn	2, 0x0301
  c6:	0904                	.insn	2, 0x0904
  c8:	0004                	.insn	2, 0x0004
  ca:	0301                	.insn	2, 0x0301
  cc:	0901                	.insn	2, 0x0901
  ce:	0004                	.insn	2, 0x0004
  d0:	0301                	.insn	2, 0x0301
  d2:	0901                	.insn	2, 0x0901
  d4:	0004                	.insn	2, 0x0004
  d6:	0301                	.insn	2, 0x0301
  d8:	0901                	.insn	2, 0x0901
  da:	0004                	.insn	2, 0x0004
  dc:	0301                	.insn	2, 0x0301
  de:	0901                	.insn	2, 0x0901
  e0:	0004                	.insn	2, 0x0004
  e2:	0301                	.insn	2, 0x0301
  e4:	0901                	.insn	2, 0x0901
  e6:	0004                	.insn	2, 0x0004
  e8:	0301                	.insn	2, 0x0301
  ea:	0902                	.insn	2, 0x0902
  ec:	0004                	.insn	2, 0x0004
  ee:	0301                	.insn	2, 0x0301
  f0:	0901                	.insn	2, 0x0901
  f2:	0004                	.insn	2, 0x0004
  f4:	0301                	.insn	2, 0x0301
  f6:	0901                	.insn	2, 0x0901
  f8:	0004                	.insn	2, 0x0004
  fa:	0301                	.insn	2, 0x0301
  fc:	0901                	.insn	2, 0x0901
  fe:	0004                	.insn	2, 0x0004
 100:	0301                	.insn	2, 0x0301
 102:	0902                	.insn	2, 0x0902
 104:	0004                	.insn	2, 0x0004
 106:	0301                	.insn	2, 0x0301
 108:	0902                	.insn	2, 0x0902
 10a:	0004                	.insn	2, 0x0004
 10c:	0301                	.insn	2, 0x0301
 10e:	0901                	.insn	2, 0x0901
 110:	0004                	.insn	2, 0x0004
 112:	0301                	.insn	2, 0x0301
 114:	0901                	.insn	2, 0x0901
 116:	0004                	.insn	2, 0x0004
 118:	0301                	.insn	2, 0x0301
 11a:	0902                	.insn	2, 0x0902
 11c:	0004                	.insn	2, 0x0004
 11e:	0301                	.insn	2, 0x0301
 120:	0901                	.insn	2, 0x0901
 122:	0004                	.insn	2, 0x0004
 124:	0301                	.insn	2, 0x0301
 126:	0901                	.insn	2, 0x0901
 128:	0004                	.insn	2, 0x0004
 12a:	0301                	.insn	2, 0x0301
 12c:	0902                	.insn	2, 0x0902
 12e:	0004                	.insn	2, 0x0004
 130:	0301                	.insn	2, 0x0301
 132:	0906                	.insn	2, 0x0906
 134:	0004                	.insn	2, 0x0004
 136:	0301                	.insn	2, 0x0301
 138:	0901                	.insn	2, 0x0901
 13a:	0004                	.insn	2, 0x0004
 13c:	0301                	.insn	2, 0x0301
 13e:	0901                	.insn	2, 0x0901
 140:	0004                	.insn	2, 0x0004
 142:	0301                	.insn	2, 0x0301
 144:	0901                	.insn	2, 0x0901
 146:	0004                	.insn	2, 0x0004
 148:	0301                	.insn	2, 0x0301
 14a:	0905                	.insn	2, 0x0905
 14c:	0004                	.insn	2, 0x0004
 14e:	0301                	.insn	2, 0x0301
 150:	0902                	.insn	2, 0x0902
 152:	0004                	.insn	2, 0x0004
 154:	0301                	.insn	2, 0x0301
 156:	0902                	.insn	2, 0x0902
 158:	0004                	.insn	2, 0x0004
 15a:	0301                	.insn	2, 0x0301
 15c:	0901                	.insn	2, 0x0901
 15e:	0004                	.insn	2, 0x0004
 160:	0301                	.insn	2, 0x0301
 162:	0902                	.insn	2, 0x0902
 164:	0004                	.insn	2, 0x0004
 166:	0301                	.insn	2, 0x0301
 168:	0902                	.insn	2, 0x0902
 16a:	0004                	.insn	2, 0x0004
 16c:	0301                	.insn	2, 0x0301
 16e:	0901                	.insn	2, 0x0901
 170:	0004                	.insn	2, 0x0004
 172:	0301                	.insn	2, 0x0301
 174:	0901                	.insn	2, 0x0901
 176:	0004                	.insn	2, 0x0004
 178:	0301                	.insn	2, 0x0301
 17a:	0901                	.insn	2, 0x0901
 17c:	0004                	.insn	2, 0x0004
 17e:	0301                	.insn	2, 0x0301
 180:	0904                	.insn	2, 0x0904
 182:	0004                	.insn	2, 0x0004
 184:	0301                	.insn	2, 0x0301
 186:	0901                	.insn	2, 0x0901
 188:	0004                	.insn	2, 0x0004
 18a:	0301                	.insn	2, 0x0301
 18c:	0901                	.insn	2, 0x0901
 18e:	0004                	.insn	2, 0x0004
 190:	0301                	.insn	2, 0x0301
 192:	0902                	.insn	2, 0x0902
 194:	0004                	.insn	2, 0x0004
 196:	0301                	.insn	2, 0x0301
 198:	0901                	.insn	2, 0x0901
 19a:	0004                	.insn	2, 0x0004
 19c:	0301                	.insn	2, 0x0301
 19e:	0901                	.insn	2, 0x0901
 1a0:	0004                	.insn	2, 0x0004
 1a2:	0301                	.insn	2, 0x0301
 1a4:	0902                	.insn	2, 0x0902
 1a6:	0004                	.insn	2, 0x0004
 1a8:	0301                	.insn	2, 0x0301
 1aa:	0901                	.insn	2, 0x0901
 1ac:	0004                	.insn	2, 0x0004
 1ae:	0301                	.insn	2, 0x0301
 1b0:	0902                	.insn	2, 0x0902
 1b2:	0004                	.insn	2, 0x0004
 1b4:	0301                	.insn	2, 0x0301
 1b6:	0901                	.insn	2, 0x0901
 1b8:	0004                	.insn	2, 0x0004
 1ba:	0301                	.insn	2, 0x0301
 1bc:	0901                	.insn	2, 0x0901
 1be:	0004                	.insn	2, 0x0004
 1c0:	0301                	.insn	2, 0x0301
 1c2:	0901                	.insn	2, 0x0901
 1c4:	0004                	.insn	2, 0x0004
 1c6:	0901                	.insn	2, 0x0901
 1c8:	0004                	.insn	2, 0x0004
 1ca:	0100                	.insn	2, 0x0100
 1cc:	01                	.byte	0x01

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	2e2e                	.insn	2, 0x2e2e
   2:	2f2e2e2f          	.insn	4, 0x2f2e2e2f
   6:	2e2e                	.insn	2, 0x2e2e
   8:	2f2e2e2f          	.insn	4, 0x2f2e2e2f
   c:	2f636367          	.insn	4, 0x2f636367
  10:	696c                	.insn	2, 0x696c
  12:	6762                	.insn	2, 0x6762
  14:	632f6363          	bltu	t5,s2,63a <__modsi3+0x37e>
  18:	69666e6f          	jal	t3,666ae <__global_pointer$+0x64bc2>
  1c:	69722f67          	.insn	4, 0x69722f67
  20:	2f766373          	.insn	4, 0x2f766373
  24:	756d                	.insn	2, 0x756d
  26:	646c                	.insn	2, 0x646c
  28:	3369                	.insn	2, 0x3369
  2a:	532e                	.insn	2, 0x532e
  2c:	2f00                	.insn	2, 0x2f00
  2e:	6f68                	.insn	2, 0x6f68
  30:	656d                	.insn	2, 0x656d
  32:	63756c2f          	.insn	4, 0x63756c2f
  36:	7568                	.insn	2, 0x7568
  38:	7369722f          	.insn	4, 0x7369722f
  3c:	672d7663          	bgeu	s10,s2,6a8 <__modsi3+0x3ec>
  40:	756e                	.insn	2, 0x756e
  42:	742d                	.insn	2, 0x742d
  44:	636c6f6f          	jal	t5,c667a <__global_pointer$+0xc4b8e>
  48:	6168                	.insn	2, 0x6168
  4a:	6e69                	.insn	2, 0x6e69
  4c:	722d                	.insn	2, 0x722d
  4e:	3376                	.insn	2, 0x3376
  50:	6932                	.insn	2, 0x6932
  52:	6975622f          	.insn	4, 0x6975622f
  56:	646c                	.insn	2, 0x646c
  58:	6975622f          	.insn	4, 0x6975622f
  5c:	646c                	.insn	2, 0x646c
  5e:	672d                	.insn	2, 0x672d
  60:	6e2d6363          	bltu	s10,sp,746 <__modsi3+0x48a>
  64:	7765                	.insn	2, 0x7765
  66:	696c                	.insn	2, 0x696c
  68:	2d62                	.insn	2, 0x2d62
  6a:	67617473          	.insn	4, 0x67617473
  6e:	3265                	.insn	2, 0x3265
  70:	7369722f          	.insn	4, 0x7369722f
  74:	32337663          	bgeu	t1,gp,3a0 <__modsi3+0xe4>
  78:	752d                	.insn	2, 0x752d
  7a:	6b6e                	.insn	2, 0x6b6e
  7c:	6f6e                	.insn	2, 0x6f6e
  7e:	652d6e77          	.insn	4, 0x652d6e77
  82:	666c                	.insn	2, 0x666c
  84:	62696c2f          	.insn	4, 0x62696c2f
  88:	00636367          	.insn	4, 0x00636367
  8c:	20554e47          	.insn	4, 0x20554e47
  90:	5341                	.insn	2, 0x5341
  92:	3220                	.insn	2, 0x3220
  94:	342e                	.insn	2, 0x342e
  96:	0035                	.insn	2, 0x0035
  98:	5f5f 756d 736c      	.insn	6, 0x736c756d5f5f
  9e:	3369                	.insn	2, 0x3369
  a0:	2e00                	.insn	2, 0x2e00
  a2:	2f2e                	.insn	2, 0x2f2e
  a4:	2e2e                	.insn	2, 0x2e2e
  a6:	2f2e2e2f          	.insn	4, 0x2f2e2e2f
  aa:	2e2e                	.insn	2, 0x2e2e
  ac:	6363672f          	.insn	4, 0x6363672f
  b0:	62696c2f          	.insn	4, 0x62696c2f
  b4:	2f636367          	.insn	4, 0x2f636367
  b8:	666e6f63          	bltu	t3,t1,736 <__modsi3+0x47a>
  bc:	6769                	.insn	2, 0x6769
  be:	7369722f          	.insn	4, 0x7369722f
  c2:	642f7663          	bgeu	t5,sp,70e <__modsi3+0x452>
  c6:	7669                	.insn	2, 0x7669
  c8:	532e                	.insn	2, 0x532e
  ca:	5f00                	.insn	2, 0x5f00
  cc:	645f 7669 6973      	.insn	6, 0x69737669645f
  d2:	5f5f0033          	.insn	4, 0x5f5f0033
  d6:	6968                	.insn	2, 0x6968
  d8:	6464                	.insn	2, 0x6464
  da:	6e65                	.insn	2, 0x6e65
  dc:	5f5f 755f 6964      	.insn	6, 0x6964755f5f5f
  e2:	7376                	.insn	2, 0x7376
  e4:	3369                	.insn	2, 0x3369
  e6:	5f00                	.insn	2, 0x5f00
  e8:	755f 6f6d 7364      	.insn	6, 0x73646f6d755f
  ee:	3369                	.insn	2, 0x3369
  f0:	5f00                	.insn	2, 0x5f00
  f2:	6d5f 646f 6973      	.insn	6, 0x6973646f6d5f
  f8:	0033                	.short	0x0033

Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
   0:	6d6f682f          	.insn	4, 0x6d6f682f
   4:	2f65                	.insn	2, 0x2f65
   6:	756c                	.insn	2, 0x756c
   8:	2f756863          	bltu	a0,s7,2f8 <__modsi3+0x3c>
   c:	6972                	.insn	2, 0x6972
   e:	2d766373          	.insn	4, 0x2d766373
  12:	2d756e67          	.insn	4, 0x2d756e67
  16:	6f74                	.insn	2, 0x6f74
  18:	68636c6f          	jal	s8,3669e <__global_pointer$+0x34bb2>
  1c:	6961                	.insn	2, 0x6961
  1e:	2d6e                	.insn	2, 0x2d6e
  20:	7672                	.insn	2, 0x7672
  22:	2f693233          	.insn	4, 0x2f693233
  26:	7562                	.insn	2, 0x7562
  28:	6c69                	.insn	2, 0x6c69
  2a:	2f64                	.insn	2, 0x2f64
  2c:	7562                	.insn	2, 0x7562
  2e:	6c69                	.insn	2, 0x6c69
  30:	2d64                	.insn	2, 0x2d64
  32:	2d636367          	.insn	4, 0x2d636367
  36:	656e                	.insn	2, 0x656e
  38:	62696c77          	.insn	4, 0x62696c77
  3c:	732d                	.insn	2, 0x732d
  3e:	6174                	.insn	2, 0x6174
  40:	2f326567          	.insn	4, 0x2f326567
  44:	6972                	.insn	2, 0x6972
  46:	33766373          	.insn	4, 0x33766373
  4a:	2d32                	.insn	2, 0x2d32
  4c:	6e75                	.insn	2, 0x6e75
  4e:	776f6e6b          	.insn	4, 0x776f6e6b
  52:	2d6e                	.insn	2, 0x2d6e
  54:	6c65                	.insn	2, 0x6c65
  56:	2f66                	.insn	2, 0x2f66
  58:	696c                	.insn	2, 0x696c
  5a:	6762                	.insn	2, 0x6762
  5c:	2e006363          	bltu	zero,zero,342 <__modsi3+0x86>
  60:	2f2e                	.insn	2, 0x2f2e
  62:	2e2e                	.insn	2, 0x2e2e
  64:	2f2e2e2f          	.insn	4, 0x2f2e2e2f
  68:	2e2e                	.insn	2, 0x2e2e
  6a:	6363672f          	.insn	4, 0x6363672f
  6e:	62696c2f          	.insn	4, 0x62696c2f
  72:	2f636367          	.insn	4, 0x2f636367
  76:	666e6f63          	bltu	t3,t1,6f4 <__modsi3+0x438>
  7a:	6769                	.insn	2, 0x6769
  7c:	7369722f          	.insn	4, 0x7369722f
  80:	6d007663          	bgeu	zero,a6,74c <__modsi3+0x490>
  84:	6c75                	.insn	2, 0x6c75
  86:	6964                	.insn	2, 0x6964
  88:	00532e33          	slt	t3,t1,t0
  8c:	6964                	.insn	2, 0x6964
  8e:	2e76                	.insn	2, 0x2e76
  90:	0053                	.short	0x0053
