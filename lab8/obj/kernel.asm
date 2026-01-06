
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	7930a0ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0200066:	41d000ef          	jal	ra,ffffffffc0200c82 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	48658593          	addi	a1,a1,1158 # ffffffffc020b4f0 <etext>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	49e50513          	addi	a0,a0,1182 # ffffffffc020b510 <etext+0x20>
ffffffffc020007a:	0b0000ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020007e:	25c000ef          	jal	ra,ffffffffc02002da <print_kerninfo>
ffffffffc0200082:	04d000ef          	jal	ra,ffffffffc02008ce <dtb_init>
ffffffffc0200086:	280030ef          	jal	ra,ffffffffc0203306 <pmm_init>
ffffffffc020008a:	513000ef          	jal	ra,ffffffffc0200d9c <pic_init>
ffffffffc020008e:	51d000ef          	jal	ra,ffffffffc0200daa <idt_init>
ffffffffc0200092:	5a8010ef          	jal	ra,ffffffffc020163a <vmm_init>
ffffffffc0200096:	0d4070ef          	jal	ra,ffffffffc020716a <sched_init>
ffffffffc020009a:	62d060ef          	jal	ra,ffffffffc0206ec6 <proc_init>
ffffffffc020009e:	4ae000ef          	jal	ra,ffffffffc020054c <ide_init>
ffffffffc02000a2:	720050ef          	jal	ra,ffffffffc02057c2 <fs_init>
ffffffffc02000a6:	7de000ef          	jal	ra,ffffffffc0200884 <clock_init>
ffffffffc02000aa:	4f5000ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02000ae:	7e5060ef          	jal	ra,ffffffffc0207092 <cpu_idle>

ffffffffc02000b2 <strdup>:
ffffffffc02000b2:	1101                	addi	sp,sp,-32
ffffffffc02000b4:	ec06                	sd	ra,24(sp)
ffffffffc02000b6:	e822                	sd	s0,16(sp)
ffffffffc02000b8:	e426                	sd	s1,8(sp)
ffffffffc02000ba:	e04a                	sd	s2,0(sp)
ffffffffc02000bc:	892a                	mv	s2,a0
ffffffffc02000be:	6950a0ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc02000c2:	842a                	mv	s0,a0
ffffffffc02000c4:	0505                	addi	a0,a0,1
ffffffffc02000c6:	451010ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02000ca:	84aa                	mv	s1,a0
ffffffffc02000cc:	c901                	beqz	a0,ffffffffc02000dc <strdup+0x2a>
ffffffffc02000ce:	8622                	mv	a2,s0
ffffffffc02000d0:	85ca                	mv	a1,s2
ffffffffc02000d2:	9426                	add	s0,s0,s1
ffffffffc02000d4:	7730a0ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc02000d8:	00040023          	sb	zero,0(s0)
ffffffffc02000dc:	60e2                	ld	ra,24(sp)
ffffffffc02000de:	6442                	ld	s0,16(sp)
ffffffffc02000e0:	6902                	ld	s2,0(sp)
ffffffffc02000e2:	8526                	mv	a0,s1
ffffffffc02000e4:	64a2                	ld	s1,8(sp)
ffffffffc02000e6:	6105                	addi	sp,sp,32
ffffffffc02000e8:	8082                	ret

ffffffffc02000ea <cputch>:
ffffffffc02000ea:	1141                	addi	sp,sp,-16
ffffffffc02000ec:	e022                	sd	s0,0(sp)
ffffffffc02000ee:	e406                	sd	ra,8(sp)
ffffffffc02000f0:	842e                	mv	s0,a1
ffffffffc02000f2:	39f000ef          	jal	ra,ffffffffc0200c90 <cons_putc>
ffffffffc02000f6:	401c                	lw	a5,0(s0)
ffffffffc02000f8:	60a2                	ld	ra,8(sp)
ffffffffc02000fa:	2785                	addiw	a5,a5,1
ffffffffc02000fc:	c01c                	sw	a5,0(s0)
ffffffffc02000fe:	6402                	ld	s0,0(sp)
ffffffffc0200100:	0141                	addi	sp,sp,16
ffffffffc0200102:	8082                	ret

ffffffffc0200104 <vcprintf>:
ffffffffc0200104:	1101                	addi	sp,sp,-32
ffffffffc0200106:	872e                	mv	a4,a1
ffffffffc0200108:	75dd                	lui	a1,0xffff7
ffffffffc020010a:	86aa                	mv	a3,a0
ffffffffc020010c:	0070                	addi	a2,sp,12
ffffffffc020010e:	00000517          	auipc	a0,0x0
ffffffffc0200112:	fdc50513          	addi	a0,a0,-36 # ffffffffc02000ea <cputch>
ffffffffc0200116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020011a:	ec06                	sd	ra,24(sp)
ffffffffc020011c:	c602                	sw	zero,12(sp)
ffffffffc020011e:	7d10a0ef          	jal	ra,ffffffffc020b0ee <vprintfmt>
ffffffffc0200122:	60e2                	ld	ra,24(sp)
ffffffffc0200124:	4532                	lw	a0,12(sp)
ffffffffc0200126:	6105                	addi	sp,sp,32
ffffffffc0200128:	8082                	ret

ffffffffc020012a <cprintf>:
ffffffffc020012a:	711d                	addi	sp,sp,-96
ffffffffc020012c:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc0200130:	8e2a                	mv	t3,a0
ffffffffc0200132:	f42e                	sd	a1,40(sp)
ffffffffc0200134:	75dd                	lui	a1,0xffff7
ffffffffc0200136:	f832                	sd	a2,48(sp)
ffffffffc0200138:	fc36                	sd	a3,56(sp)
ffffffffc020013a:	e0ba                	sd	a4,64(sp)
ffffffffc020013c:	00000517          	auipc	a0,0x0
ffffffffc0200140:	fae50513          	addi	a0,a0,-82 # ffffffffc02000ea <cputch>
ffffffffc0200144:	0050                	addi	a2,sp,4
ffffffffc0200146:	871a                	mv	a4,t1
ffffffffc0200148:	86f2                	mv	a3,t3
ffffffffc020014a:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020014e:	ec06                	sd	ra,24(sp)
ffffffffc0200150:	e4be                	sd	a5,72(sp)
ffffffffc0200152:	e8c2                	sd	a6,80(sp)
ffffffffc0200154:	ecc6                	sd	a7,88(sp)
ffffffffc0200156:	e41a                	sd	t1,8(sp)
ffffffffc0200158:	c202                	sw	zero,4(sp)
ffffffffc020015a:	7950a0ef          	jal	ra,ffffffffc020b0ee <vprintfmt>
ffffffffc020015e:	60e2                	ld	ra,24(sp)
ffffffffc0200160:	4512                	lw	a0,4(sp)
ffffffffc0200162:	6125                	addi	sp,sp,96
ffffffffc0200164:	8082                	ret

ffffffffc0200166 <cputchar>:
ffffffffc0200166:	32b0006f          	j	ffffffffc0200c90 <cons_putc>

ffffffffc020016a <getchar>:
ffffffffc020016a:	1141                	addi	sp,sp,-16
ffffffffc020016c:	e406                	sd	ra,8(sp)
ffffffffc020016e:	377000ef          	jal	ra,ffffffffc0200ce4 <cons_getc>
ffffffffc0200172:	dd75                	beqz	a0,ffffffffc020016e <getchar+0x4>
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	0141                	addi	sp,sp,16
ffffffffc0200178:	8082                	ret

ffffffffc020017a <readline>:
ffffffffc020017a:	715d                	addi	sp,sp,-80
ffffffffc020017c:	e486                	sd	ra,72(sp)
ffffffffc020017e:	e0a6                	sd	s1,64(sp)
ffffffffc0200180:	fc4a                	sd	s2,56(sp)
ffffffffc0200182:	f84e                	sd	s3,48(sp)
ffffffffc0200184:	f452                	sd	s4,40(sp)
ffffffffc0200186:	f056                	sd	s5,32(sp)
ffffffffc0200188:	ec5a                	sd	s6,24(sp)
ffffffffc020018a:	e85e                	sd	s7,16(sp)
ffffffffc020018c:	c901                	beqz	a0,ffffffffc020019c <readline+0x22>
ffffffffc020018e:	85aa                	mv	a1,a0
ffffffffc0200190:	0000b517          	auipc	a0,0xb
ffffffffc0200194:	38850513          	addi	a0,a0,904 # ffffffffc020b518 <etext+0x28>
ffffffffc0200198:	f93ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020019c:	4481                	li	s1,0
ffffffffc020019e:	497d                	li	s2,31
ffffffffc02001a0:	49a1                	li	s3,8
ffffffffc02001a2:	4aa9                	li	s5,10
ffffffffc02001a4:	4b35                	li	s6,13
ffffffffc02001a6:	00091b97          	auipc	s7,0x91
ffffffffc02001aa:	ebab8b93          	addi	s7,s7,-326 # ffffffffc0291060 <buf>
ffffffffc02001ae:	3fe00a13          	li	s4,1022
ffffffffc02001b2:	fb9ff0ef          	jal	ra,ffffffffc020016a <getchar>
ffffffffc02001b6:	00054a63          	bltz	a0,ffffffffc02001ca <readline+0x50>
ffffffffc02001ba:	00a95a63          	bge	s2,a0,ffffffffc02001ce <readline+0x54>
ffffffffc02001be:	029a5263          	bge	s4,s1,ffffffffc02001e2 <readline+0x68>
ffffffffc02001c2:	fa9ff0ef          	jal	ra,ffffffffc020016a <getchar>
ffffffffc02001c6:	fe055ae3          	bgez	a0,ffffffffc02001ba <readline+0x40>
ffffffffc02001ca:	4501                	li	a0,0
ffffffffc02001cc:	a091                	j	ffffffffc0200210 <readline+0x96>
ffffffffc02001ce:	03351463          	bne	a0,s3,ffffffffc02001f6 <readline+0x7c>
ffffffffc02001d2:	e8a9                	bnez	s1,ffffffffc0200224 <readline+0xaa>
ffffffffc02001d4:	f97ff0ef          	jal	ra,ffffffffc020016a <getchar>
ffffffffc02001d8:	fe0549e3          	bltz	a0,ffffffffc02001ca <readline+0x50>
ffffffffc02001dc:	fea959e3          	bge	s2,a0,ffffffffc02001ce <readline+0x54>
ffffffffc02001e0:	4481                	li	s1,0
ffffffffc02001e2:	e42a                	sd	a0,8(sp)
ffffffffc02001e4:	f83ff0ef          	jal	ra,ffffffffc0200166 <cputchar>
ffffffffc02001e8:	6522                	ld	a0,8(sp)
ffffffffc02001ea:	009b87b3          	add	a5,s7,s1
ffffffffc02001ee:	2485                	addiw	s1,s1,1
ffffffffc02001f0:	00a78023          	sb	a0,0(a5)
ffffffffc02001f4:	bf7d                	j	ffffffffc02001b2 <readline+0x38>
ffffffffc02001f6:	01550463          	beq	a0,s5,ffffffffc02001fe <readline+0x84>
ffffffffc02001fa:	fb651ce3          	bne	a0,s6,ffffffffc02001b2 <readline+0x38>
ffffffffc02001fe:	f69ff0ef          	jal	ra,ffffffffc0200166 <cputchar>
ffffffffc0200202:	00091517          	auipc	a0,0x91
ffffffffc0200206:	e5e50513          	addi	a0,a0,-418 # ffffffffc0291060 <buf>
ffffffffc020020a:	94aa                	add	s1,s1,a0
ffffffffc020020c:	00048023          	sb	zero,0(s1)
ffffffffc0200210:	60a6                	ld	ra,72(sp)
ffffffffc0200212:	6486                	ld	s1,64(sp)
ffffffffc0200214:	7962                	ld	s2,56(sp)
ffffffffc0200216:	79c2                	ld	s3,48(sp)
ffffffffc0200218:	7a22                	ld	s4,40(sp)
ffffffffc020021a:	7a82                	ld	s5,32(sp)
ffffffffc020021c:	6b62                	ld	s6,24(sp)
ffffffffc020021e:	6bc2                	ld	s7,16(sp)
ffffffffc0200220:	6161                	addi	sp,sp,80
ffffffffc0200222:	8082                	ret
ffffffffc0200224:	4521                	li	a0,8
ffffffffc0200226:	f41ff0ef          	jal	ra,ffffffffc0200166 <cputchar>
ffffffffc020022a:	34fd                	addiw	s1,s1,-1
ffffffffc020022c:	b759                	j	ffffffffc02001b2 <readline+0x38>

ffffffffc020022e <__panic>:
ffffffffc020022e:	00096317          	auipc	t1,0x96
ffffffffc0200232:	63a30313          	addi	t1,t1,1594 # ffffffffc0296868 <is_panic>
ffffffffc0200236:	00033e03          	ld	t3,0(t1)
ffffffffc020023a:	715d                	addi	sp,sp,-80
ffffffffc020023c:	ec06                	sd	ra,24(sp)
ffffffffc020023e:	e822                	sd	s0,16(sp)
ffffffffc0200240:	f436                	sd	a3,40(sp)
ffffffffc0200242:	f83a                	sd	a4,48(sp)
ffffffffc0200244:	fc3e                	sd	a5,56(sp)
ffffffffc0200246:	e0c2                	sd	a6,64(sp)
ffffffffc0200248:	e4c6                	sd	a7,72(sp)
ffffffffc020024a:	020e1a63          	bnez	t3,ffffffffc020027e <__panic+0x50>
ffffffffc020024e:	4785                	li	a5,1
ffffffffc0200250:	00f33023          	sd	a5,0(t1)
ffffffffc0200254:	8432                	mv	s0,a2
ffffffffc0200256:	103c                	addi	a5,sp,40
ffffffffc0200258:	862e                	mv	a2,a1
ffffffffc020025a:	85aa                	mv	a1,a0
ffffffffc020025c:	0000b517          	auipc	a0,0xb
ffffffffc0200260:	2c450513          	addi	a0,a0,708 # ffffffffc020b520 <etext+0x30>
ffffffffc0200264:	e43e                	sd	a5,8(sp)
ffffffffc0200266:	ec5ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020026a:	65a2                	ld	a1,8(sp)
ffffffffc020026c:	8522                	mv	a0,s0
ffffffffc020026e:	e97ff0ef          	jal	ra,ffffffffc0200104 <vcprintf>
ffffffffc0200272:	0000d517          	auipc	a0,0xd
ffffffffc0200276:	a6e50513          	addi	a0,a0,-1426 # ffffffffc020cce0 <default_pmm_manager+0x520>
ffffffffc020027a:	eb1ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020027e:	4501                	li	a0,0
ffffffffc0200280:	4581                	li	a1,0
ffffffffc0200282:	4601                	li	a2,0
ffffffffc0200284:	48a1                	li	a7,8
ffffffffc0200286:	00000073          	ecall
ffffffffc020028a:	31b000ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020028e:	4501                	li	a0,0
ffffffffc0200290:	174000ef          	jal	ra,ffffffffc0200404 <kmonitor>
ffffffffc0200294:	bfed                	j	ffffffffc020028e <__panic+0x60>

ffffffffc0200296 <__warn>:
ffffffffc0200296:	715d                	addi	sp,sp,-80
ffffffffc0200298:	832e                	mv	t1,a1
ffffffffc020029a:	e822                	sd	s0,16(sp)
ffffffffc020029c:	85aa                	mv	a1,a0
ffffffffc020029e:	8432                	mv	s0,a2
ffffffffc02002a0:	fc3e                	sd	a5,56(sp)
ffffffffc02002a2:	861a                	mv	a2,t1
ffffffffc02002a4:	103c                	addi	a5,sp,40
ffffffffc02002a6:	0000b517          	auipc	a0,0xb
ffffffffc02002aa:	29a50513          	addi	a0,a0,666 # ffffffffc020b540 <etext+0x50>
ffffffffc02002ae:	ec06                	sd	ra,24(sp)
ffffffffc02002b0:	f436                	sd	a3,40(sp)
ffffffffc02002b2:	f83a                	sd	a4,48(sp)
ffffffffc02002b4:	e0c2                	sd	a6,64(sp)
ffffffffc02002b6:	e4c6                	sd	a7,72(sp)
ffffffffc02002b8:	e43e                	sd	a5,8(sp)
ffffffffc02002ba:	e71ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02002be:	65a2                	ld	a1,8(sp)
ffffffffc02002c0:	8522                	mv	a0,s0
ffffffffc02002c2:	e43ff0ef          	jal	ra,ffffffffc0200104 <vcprintf>
ffffffffc02002c6:	0000d517          	auipc	a0,0xd
ffffffffc02002ca:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020cce0 <default_pmm_manager+0x520>
ffffffffc02002ce:	e5dff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02002d2:	60e2                	ld	ra,24(sp)
ffffffffc02002d4:	6442                	ld	s0,16(sp)
ffffffffc02002d6:	6161                	addi	sp,sp,80
ffffffffc02002d8:	8082                	ret

ffffffffc02002da <print_kerninfo>:
ffffffffc02002da:	1141                	addi	sp,sp,-16
ffffffffc02002dc:	0000b517          	auipc	a0,0xb
ffffffffc02002e0:	28450513          	addi	a0,a0,644 # ffffffffc020b560 <etext+0x70>
ffffffffc02002e4:	e406                	sd	ra,8(sp)
ffffffffc02002e6:	e45ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02002ea:	00000597          	auipc	a1,0x0
ffffffffc02002ee:	d6058593          	addi	a1,a1,-672 # ffffffffc020004a <kern_init>
ffffffffc02002f2:	0000b517          	auipc	a0,0xb
ffffffffc02002f6:	28e50513          	addi	a0,a0,654 # ffffffffc020b580 <etext+0x90>
ffffffffc02002fa:	e31ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	1f258593          	addi	a1,a1,498 # ffffffffc020b4f0 <etext>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	29a50513          	addi	a0,a0,666 # ffffffffc020b5a0 <etext+0xb0>
ffffffffc020030e:	e1dff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200312:	00091597          	auipc	a1,0x91
ffffffffc0200316:	d4e58593          	addi	a1,a1,-690 # ffffffffc0291060 <buf>
ffffffffc020031a:	0000b517          	auipc	a0,0xb
ffffffffc020031e:	2a650513          	addi	a0,a0,678 # ffffffffc020b5c0 <etext+0xd0>
ffffffffc0200322:	e09ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200326:	00096597          	auipc	a1,0x96
ffffffffc020032a:	5ea58593          	addi	a1,a1,1514 # ffffffffc0296910 <end>
ffffffffc020032e:	0000b517          	auipc	a0,0xb
ffffffffc0200332:	2b250513          	addi	a0,a0,690 # ffffffffc020b5e0 <etext+0xf0>
ffffffffc0200336:	df5ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020033a:	00097597          	auipc	a1,0x97
ffffffffc020033e:	9d558593          	addi	a1,a1,-1579 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200342:	00000797          	auipc	a5,0x0
ffffffffc0200346:	d0878793          	addi	a5,a5,-760 # ffffffffc020004a <kern_init>
ffffffffc020034a:	40f587b3          	sub	a5,a1,a5
ffffffffc020034e:	43f7d593          	srai	a1,a5,0x3f
ffffffffc0200352:	60a2                	ld	ra,8(sp)
ffffffffc0200354:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200358:	95be                	add	a1,a1,a5
ffffffffc020035a:	85a9                	srai	a1,a1,0xa
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	2a450513          	addi	a0,a0,676 # ffffffffc020b600 <etext+0x110>
ffffffffc0200364:	0141                	addi	sp,sp,16
ffffffffc0200366:	b3d1                	j	ffffffffc020012a <cprintf>

ffffffffc0200368 <print_stackframe>:
ffffffffc0200368:	1141                	addi	sp,sp,-16
ffffffffc020036a:	0000b617          	auipc	a2,0xb
ffffffffc020036e:	2c660613          	addi	a2,a2,710 # ffffffffc020b630 <etext+0x140>
ffffffffc0200372:	04e00593          	li	a1,78
ffffffffc0200376:	0000b517          	auipc	a0,0xb
ffffffffc020037a:	2d250513          	addi	a0,a0,722 # ffffffffc020b648 <etext+0x158>
ffffffffc020037e:	e406                	sd	ra,8(sp)
ffffffffc0200380:	eafff0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0200384 <mon_help>:
ffffffffc0200384:	1141                	addi	sp,sp,-16
ffffffffc0200386:	0000b617          	auipc	a2,0xb
ffffffffc020038a:	2da60613          	addi	a2,a2,730 # ffffffffc020b660 <etext+0x170>
ffffffffc020038e:	0000b597          	auipc	a1,0xb
ffffffffc0200392:	2f258593          	addi	a1,a1,754 # ffffffffc020b680 <etext+0x190>
ffffffffc0200396:	0000b517          	auipc	a0,0xb
ffffffffc020039a:	2f250513          	addi	a0,a0,754 # ffffffffc020b688 <etext+0x198>
ffffffffc020039e:	e406                	sd	ra,8(sp)
ffffffffc02003a0:	d8bff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02003a4:	0000b617          	auipc	a2,0xb
ffffffffc02003a8:	2f460613          	addi	a2,a2,756 # ffffffffc020b698 <etext+0x1a8>
ffffffffc02003ac:	0000b597          	auipc	a1,0xb
ffffffffc02003b0:	31458593          	addi	a1,a1,788 # ffffffffc020b6c0 <etext+0x1d0>
ffffffffc02003b4:	0000b517          	auipc	a0,0xb
ffffffffc02003b8:	2d450513          	addi	a0,a0,724 # ffffffffc020b688 <etext+0x198>
ffffffffc02003bc:	d6fff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02003c0:	0000b617          	auipc	a2,0xb
ffffffffc02003c4:	31060613          	addi	a2,a2,784 # ffffffffc020b6d0 <etext+0x1e0>
ffffffffc02003c8:	0000b597          	auipc	a1,0xb
ffffffffc02003cc:	32858593          	addi	a1,a1,808 # ffffffffc020b6f0 <etext+0x200>
ffffffffc02003d0:	0000b517          	auipc	a0,0xb
ffffffffc02003d4:	2b850513          	addi	a0,a0,696 # ffffffffc020b688 <etext+0x198>
ffffffffc02003d8:	d53ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02003dc:	60a2                	ld	ra,8(sp)
ffffffffc02003de:	4501                	li	a0,0
ffffffffc02003e0:	0141                	addi	sp,sp,16
ffffffffc02003e2:	8082                	ret

ffffffffc02003e4 <mon_kerninfo>:
ffffffffc02003e4:	1141                	addi	sp,sp,-16
ffffffffc02003e6:	e406                	sd	ra,8(sp)
ffffffffc02003e8:	ef3ff0ef          	jal	ra,ffffffffc02002da <print_kerninfo>
ffffffffc02003ec:	60a2                	ld	ra,8(sp)
ffffffffc02003ee:	4501                	li	a0,0
ffffffffc02003f0:	0141                	addi	sp,sp,16
ffffffffc02003f2:	8082                	ret

ffffffffc02003f4 <mon_backtrace>:
ffffffffc02003f4:	1141                	addi	sp,sp,-16
ffffffffc02003f6:	e406                	sd	ra,8(sp)
ffffffffc02003f8:	f71ff0ef          	jal	ra,ffffffffc0200368 <print_stackframe>
ffffffffc02003fc:	60a2                	ld	ra,8(sp)
ffffffffc02003fe:	4501                	li	a0,0
ffffffffc0200400:	0141                	addi	sp,sp,16
ffffffffc0200402:	8082                	ret

ffffffffc0200404 <kmonitor>:
ffffffffc0200404:	7115                	addi	sp,sp,-224
ffffffffc0200406:	ed5e                	sd	s7,152(sp)
ffffffffc0200408:	8baa                	mv	s7,a0
ffffffffc020040a:	0000b517          	auipc	a0,0xb
ffffffffc020040e:	2f650513          	addi	a0,a0,758 # ffffffffc020b700 <etext+0x210>
ffffffffc0200412:	ed86                	sd	ra,216(sp)
ffffffffc0200414:	e9a2                	sd	s0,208(sp)
ffffffffc0200416:	e5a6                	sd	s1,200(sp)
ffffffffc0200418:	e1ca                	sd	s2,192(sp)
ffffffffc020041a:	fd4e                	sd	s3,184(sp)
ffffffffc020041c:	f952                	sd	s4,176(sp)
ffffffffc020041e:	f556                	sd	s5,168(sp)
ffffffffc0200420:	f15a                	sd	s6,160(sp)
ffffffffc0200422:	e962                	sd	s8,144(sp)
ffffffffc0200424:	e566                	sd	s9,136(sp)
ffffffffc0200426:	e16a                	sd	s10,128(sp)
ffffffffc0200428:	d03ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020042c:	0000b517          	auipc	a0,0xb
ffffffffc0200430:	2fc50513          	addi	a0,a0,764 # ffffffffc020b728 <etext+0x238>
ffffffffc0200434:	cf7ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200438:	000b8563          	beqz	s7,ffffffffc0200442 <kmonitor+0x3e>
ffffffffc020043c:	855e                	mv	a0,s7
ffffffffc020043e:	355000ef          	jal	ra,ffffffffc0200f92 <print_trapframe>
ffffffffc0200442:	0000bc17          	auipc	s8,0xb
ffffffffc0200446:	356c0c13          	addi	s8,s8,854 # ffffffffc020b798 <commands>
ffffffffc020044a:	0000b917          	auipc	s2,0xb
ffffffffc020044e:	30690913          	addi	s2,s2,774 # ffffffffc020b750 <etext+0x260>
ffffffffc0200452:	0000b497          	auipc	s1,0xb
ffffffffc0200456:	30648493          	addi	s1,s1,774 # ffffffffc020b758 <etext+0x268>
ffffffffc020045a:	49bd                	li	s3,15
ffffffffc020045c:	0000bb17          	auipc	s6,0xb
ffffffffc0200460:	304b0b13          	addi	s6,s6,772 # ffffffffc020b760 <etext+0x270>
ffffffffc0200464:	0000ba17          	auipc	s4,0xb
ffffffffc0200468:	21ca0a13          	addi	s4,s4,540 # ffffffffc020b680 <etext+0x190>
ffffffffc020046c:	4a8d                	li	s5,3
ffffffffc020046e:	854a                	mv	a0,s2
ffffffffc0200470:	d0bff0ef          	jal	ra,ffffffffc020017a <readline>
ffffffffc0200474:	842a                	mv	s0,a0
ffffffffc0200476:	dd65                	beqz	a0,ffffffffc020046e <kmonitor+0x6a>
ffffffffc0200478:	00054583          	lbu	a1,0(a0)
ffffffffc020047c:	4c81                	li	s9,0
ffffffffc020047e:	e1bd                	bnez	a1,ffffffffc02004e4 <kmonitor+0xe0>
ffffffffc0200480:	fe0c87e3          	beqz	s9,ffffffffc020046e <kmonitor+0x6a>
ffffffffc0200484:	6582                	ld	a1,0(sp)
ffffffffc0200486:	0000bd17          	auipc	s10,0xb
ffffffffc020048a:	312d0d13          	addi	s10,s10,786 # ffffffffc020b798 <commands>
ffffffffc020048e:	8552                	mv	a0,s4
ffffffffc0200490:	4401                	li	s0,0
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	3070a0ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc0200498:	c919                	beqz	a0,ffffffffc02004ae <kmonitor+0xaa>
ffffffffc020049a:	2405                	addiw	s0,s0,1
ffffffffc020049c:	0b540063          	beq	s0,s5,ffffffffc020053c <kmonitor+0x138>
ffffffffc02004a0:	000d3503          	ld	a0,0(s10)
ffffffffc02004a4:	6582                	ld	a1,0(sp)
ffffffffc02004a6:	0d61                	addi	s10,s10,24
ffffffffc02004a8:	2f30a0ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc02004ac:	f57d                	bnez	a0,ffffffffc020049a <kmonitor+0x96>
ffffffffc02004ae:	00141793          	slli	a5,s0,0x1
ffffffffc02004b2:	97a2                	add	a5,a5,s0
ffffffffc02004b4:	078e                	slli	a5,a5,0x3
ffffffffc02004b6:	97e2                	add	a5,a5,s8
ffffffffc02004b8:	6b9c                	ld	a5,16(a5)
ffffffffc02004ba:	865e                	mv	a2,s7
ffffffffc02004bc:	002c                	addi	a1,sp,8
ffffffffc02004be:	fffc851b          	addiw	a0,s9,-1
ffffffffc02004c2:	9782                	jalr	a5
ffffffffc02004c4:	fa0555e3          	bgez	a0,ffffffffc020046e <kmonitor+0x6a>
ffffffffc02004c8:	60ee                	ld	ra,216(sp)
ffffffffc02004ca:	644e                	ld	s0,208(sp)
ffffffffc02004cc:	64ae                	ld	s1,200(sp)
ffffffffc02004ce:	690e                	ld	s2,192(sp)
ffffffffc02004d0:	79ea                	ld	s3,184(sp)
ffffffffc02004d2:	7a4a                	ld	s4,176(sp)
ffffffffc02004d4:	7aaa                	ld	s5,168(sp)
ffffffffc02004d6:	7b0a                	ld	s6,160(sp)
ffffffffc02004d8:	6bea                	ld	s7,152(sp)
ffffffffc02004da:	6c4a                	ld	s8,144(sp)
ffffffffc02004dc:	6caa                	ld	s9,136(sp)
ffffffffc02004de:	6d0a                	ld	s10,128(sp)
ffffffffc02004e0:	612d                	addi	sp,sp,224
ffffffffc02004e2:	8082                	ret
ffffffffc02004e4:	8526                	mv	a0,s1
ffffffffc02004e6:	2f90a0ef          	jal	ra,ffffffffc020afde <strchr>
ffffffffc02004ea:	c901                	beqz	a0,ffffffffc02004fa <kmonitor+0xf6>
ffffffffc02004ec:	00144583          	lbu	a1,1(s0)
ffffffffc02004f0:	00040023          	sb	zero,0(s0)
ffffffffc02004f4:	0405                	addi	s0,s0,1
ffffffffc02004f6:	d5c9                	beqz	a1,ffffffffc0200480 <kmonitor+0x7c>
ffffffffc02004f8:	b7f5                	j	ffffffffc02004e4 <kmonitor+0xe0>
ffffffffc02004fa:	00044783          	lbu	a5,0(s0)
ffffffffc02004fe:	d3c9                	beqz	a5,ffffffffc0200480 <kmonitor+0x7c>
ffffffffc0200500:	033c8963          	beq	s9,s3,ffffffffc0200532 <kmonitor+0x12e>
ffffffffc0200504:	003c9793          	slli	a5,s9,0x3
ffffffffc0200508:	0118                	addi	a4,sp,128
ffffffffc020050a:	97ba                	add	a5,a5,a4
ffffffffc020050c:	f887b023          	sd	s0,-128(a5)
ffffffffc0200510:	00044583          	lbu	a1,0(s0)
ffffffffc0200514:	2c85                	addiw	s9,s9,1
ffffffffc0200516:	e591                	bnez	a1,ffffffffc0200522 <kmonitor+0x11e>
ffffffffc0200518:	b7b5                	j	ffffffffc0200484 <kmonitor+0x80>
ffffffffc020051a:	00144583          	lbu	a1,1(s0)
ffffffffc020051e:	0405                	addi	s0,s0,1
ffffffffc0200520:	d1a5                	beqz	a1,ffffffffc0200480 <kmonitor+0x7c>
ffffffffc0200522:	8526                	mv	a0,s1
ffffffffc0200524:	2bb0a0ef          	jal	ra,ffffffffc020afde <strchr>
ffffffffc0200528:	d96d                	beqz	a0,ffffffffc020051a <kmonitor+0x116>
ffffffffc020052a:	00044583          	lbu	a1,0(s0)
ffffffffc020052e:	d9a9                	beqz	a1,ffffffffc0200480 <kmonitor+0x7c>
ffffffffc0200530:	bf55                	j	ffffffffc02004e4 <kmonitor+0xe0>
ffffffffc0200532:	45c1                	li	a1,16
ffffffffc0200534:	855a                	mv	a0,s6
ffffffffc0200536:	bf5ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020053a:	b7e9                	j	ffffffffc0200504 <kmonitor+0x100>
ffffffffc020053c:	6582                	ld	a1,0(sp)
ffffffffc020053e:	0000b517          	auipc	a0,0xb
ffffffffc0200542:	24250513          	addi	a0,a0,578 # ffffffffc020b780 <etext+0x290>
ffffffffc0200546:	be5ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020054a:	b715                	j	ffffffffc020046e <kmonitor+0x6a>

ffffffffc020054c <ide_init>:
ffffffffc020054c:	1141                	addi	sp,sp,-16
ffffffffc020054e:	00091597          	auipc	a1,0x91
ffffffffc0200552:	f6258593          	addi	a1,a1,-158 # ffffffffc02914b0 <ide_devices+0x50>
ffffffffc0200556:	4505                	li	a0,1
ffffffffc0200558:	e022                	sd	s0,0(sp)
ffffffffc020055a:	00091797          	auipc	a5,0x91
ffffffffc020055e:	f007a323          	sw	zero,-250(a5) # ffffffffc0291460 <ide_devices>
ffffffffc0200562:	00091797          	auipc	a5,0x91
ffffffffc0200566:	f407a723          	sw	zero,-178(a5) # ffffffffc02914b0 <ide_devices+0x50>
ffffffffc020056a:	00091797          	auipc	a5,0x91
ffffffffc020056e:	f807ab23          	sw	zero,-106(a5) # ffffffffc0291500 <ide_devices+0xa0>
ffffffffc0200572:	00091797          	auipc	a5,0x91
ffffffffc0200576:	fc07af23          	sw	zero,-34(a5) # ffffffffc0291550 <ide_devices+0xf0>
ffffffffc020057a:	e406                	sd	ra,8(sp)
ffffffffc020057c:	00091417          	auipc	s0,0x91
ffffffffc0200580:	ee440413          	addi	s0,s0,-284 # ffffffffc0291460 <ide_devices>
ffffffffc0200584:	22c000ef          	jal	ra,ffffffffc02007b0 <ramdisk_init>
ffffffffc0200588:	483c                	lw	a5,80(s0)
ffffffffc020058a:	cf99                	beqz	a5,ffffffffc02005a8 <ide_init+0x5c>
ffffffffc020058c:	00091597          	auipc	a1,0x91
ffffffffc0200590:	f7458593          	addi	a1,a1,-140 # ffffffffc0291500 <ide_devices+0xa0>
ffffffffc0200594:	4509                	li	a0,2
ffffffffc0200596:	21a000ef          	jal	ra,ffffffffc02007b0 <ramdisk_init>
ffffffffc020059a:	0a042783          	lw	a5,160(s0)
ffffffffc020059e:	c785                	beqz	a5,ffffffffc02005c6 <ide_init+0x7a>
ffffffffc02005a0:	60a2                	ld	ra,8(sp)
ffffffffc02005a2:	6402                	ld	s0,0(sp)
ffffffffc02005a4:	0141                	addi	sp,sp,16
ffffffffc02005a6:	8082                	ret
ffffffffc02005a8:	0000b697          	auipc	a3,0xb
ffffffffc02005ac:	23868693          	addi	a3,a3,568 # ffffffffc020b7e0 <commands+0x48>
ffffffffc02005b0:	0000b617          	auipc	a2,0xb
ffffffffc02005b4:	24860613          	addi	a2,a2,584 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02005b8:	45c5                	li	a1,17
ffffffffc02005ba:	0000b517          	auipc	a0,0xb
ffffffffc02005be:	25650513          	addi	a0,a0,598 # ffffffffc020b810 <commands+0x78>
ffffffffc02005c2:	c6dff0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02005c6:	0000b697          	auipc	a3,0xb
ffffffffc02005ca:	26268693          	addi	a3,a3,610 # ffffffffc020b828 <commands+0x90>
ffffffffc02005ce:	0000b617          	auipc	a2,0xb
ffffffffc02005d2:	22a60613          	addi	a2,a2,554 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02005d6:	45d1                	li	a1,20
ffffffffc02005d8:	0000b517          	auipc	a0,0xb
ffffffffc02005dc:	23850513          	addi	a0,a0,568 # ffffffffc020b810 <commands+0x78>
ffffffffc02005e0:	c4fff0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02005e4 <ide_device_valid>:
ffffffffc02005e4:	478d                	li	a5,3
ffffffffc02005e6:	00a7ef63          	bltu	a5,a0,ffffffffc0200604 <ide_device_valid+0x20>
ffffffffc02005ea:	00251793          	slli	a5,a0,0x2
ffffffffc02005ee:	953e                	add	a0,a0,a5
ffffffffc02005f0:	0512                	slli	a0,a0,0x4
ffffffffc02005f2:	00091797          	auipc	a5,0x91
ffffffffc02005f6:	e6e78793          	addi	a5,a5,-402 # ffffffffc0291460 <ide_devices>
ffffffffc02005fa:	953e                	add	a0,a0,a5
ffffffffc02005fc:	4108                	lw	a0,0(a0)
ffffffffc02005fe:	00a03533          	snez	a0,a0
ffffffffc0200602:	8082                	ret
ffffffffc0200604:	4501                	li	a0,0
ffffffffc0200606:	8082                	ret

ffffffffc0200608 <ide_device_size>:
ffffffffc0200608:	478d                	li	a5,3
ffffffffc020060a:	02a7e163          	bltu	a5,a0,ffffffffc020062c <ide_device_size+0x24>
ffffffffc020060e:	00251793          	slli	a5,a0,0x2
ffffffffc0200612:	953e                	add	a0,a0,a5
ffffffffc0200614:	0512                	slli	a0,a0,0x4
ffffffffc0200616:	00091797          	auipc	a5,0x91
ffffffffc020061a:	e4a78793          	addi	a5,a5,-438 # ffffffffc0291460 <ide_devices>
ffffffffc020061e:	97aa                	add	a5,a5,a0
ffffffffc0200620:	4398                	lw	a4,0(a5)
ffffffffc0200622:	4501                	li	a0,0
ffffffffc0200624:	c709                	beqz	a4,ffffffffc020062e <ide_device_size+0x26>
ffffffffc0200626:	0087e503          	lwu	a0,8(a5)
ffffffffc020062a:	8082                	ret
ffffffffc020062c:	4501                	li	a0,0
ffffffffc020062e:	8082                	ret

ffffffffc0200630 <ide_read_secs>:
ffffffffc0200630:	1141                	addi	sp,sp,-16
ffffffffc0200632:	e406                	sd	ra,8(sp)
ffffffffc0200634:	08000793          	li	a5,128
ffffffffc0200638:	04d7e763          	bltu	a5,a3,ffffffffc0200686 <ide_read_secs+0x56>
ffffffffc020063c:	478d                	li	a5,3
ffffffffc020063e:	0005081b          	sext.w	a6,a0
ffffffffc0200642:	04a7e263          	bltu	a5,a0,ffffffffc0200686 <ide_read_secs+0x56>
ffffffffc0200646:	00281793          	slli	a5,a6,0x2
ffffffffc020064a:	97c2                	add	a5,a5,a6
ffffffffc020064c:	0792                	slli	a5,a5,0x4
ffffffffc020064e:	00091817          	auipc	a6,0x91
ffffffffc0200652:	e1280813          	addi	a6,a6,-494 # ffffffffc0291460 <ide_devices>
ffffffffc0200656:	97c2                	add	a5,a5,a6
ffffffffc0200658:	0007a883          	lw	a7,0(a5)
ffffffffc020065c:	02088563          	beqz	a7,ffffffffc0200686 <ide_read_secs+0x56>
ffffffffc0200660:	100008b7          	lui	a7,0x10000
ffffffffc0200664:	0515f163          	bgeu	a1,a7,ffffffffc02006a6 <ide_read_secs+0x76>
ffffffffc0200668:	1582                	slli	a1,a1,0x20
ffffffffc020066a:	9181                	srli	a1,a1,0x20
ffffffffc020066c:	00d58733          	add	a4,a1,a3
ffffffffc0200670:	02e8eb63          	bltu	a7,a4,ffffffffc02006a6 <ide_read_secs+0x76>
ffffffffc0200674:	00251713          	slli	a4,a0,0x2
ffffffffc0200678:	60a2                	ld	ra,8(sp)
ffffffffc020067a:	63bc                	ld	a5,64(a5)
ffffffffc020067c:	953a                	add	a0,a0,a4
ffffffffc020067e:	0512                	slli	a0,a0,0x4
ffffffffc0200680:	9542                	add	a0,a0,a6
ffffffffc0200682:	0141                	addi	sp,sp,16
ffffffffc0200684:	8782                	jr	a5
ffffffffc0200686:	0000b697          	auipc	a3,0xb
ffffffffc020068a:	1ba68693          	addi	a3,a3,442 # ffffffffc020b840 <commands+0xa8>
ffffffffc020068e:	0000b617          	auipc	a2,0xb
ffffffffc0200692:	16a60613          	addi	a2,a2,362 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0200696:	02200593          	li	a1,34
ffffffffc020069a:	0000b517          	auipc	a0,0xb
ffffffffc020069e:	17650513          	addi	a0,a0,374 # ffffffffc020b810 <commands+0x78>
ffffffffc02006a2:	b8dff0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02006a6:	0000b697          	auipc	a3,0xb
ffffffffc02006aa:	1c268693          	addi	a3,a3,450 # ffffffffc020b868 <commands+0xd0>
ffffffffc02006ae:	0000b617          	auipc	a2,0xb
ffffffffc02006b2:	14a60613          	addi	a2,a2,330 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02006b6:	02300593          	li	a1,35
ffffffffc02006ba:	0000b517          	auipc	a0,0xb
ffffffffc02006be:	15650513          	addi	a0,a0,342 # ffffffffc020b810 <commands+0x78>
ffffffffc02006c2:	b6dff0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02006c6 <ide_write_secs>:
ffffffffc02006c6:	1141                	addi	sp,sp,-16
ffffffffc02006c8:	e406                	sd	ra,8(sp)
ffffffffc02006ca:	08000793          	li	a5,128
ffffffffc02006ce:	04d7e763          	bltu	a5,a3,ffffffffc020071c <ide_write_secs+0x56>
ffffffffc02006d2:	478d                	li	a5,3
ffffffffc02006d4:	0005081b          	sext.w	a6,a0
ffffffffc02006d8:	04a7e263          	bltu	a5,a0,ffffffffc020071c <ide_write_secs+0x56>
ffffffffc02006dc:	00281793          	slli	a5,a6,0x2
ffffffffc02006e0:	97c2                	add	a5,a5,a6
ffffffffc02006e2:	0792                	slli	a5,a5,0x4
ffffffffc02006e4:	00091817          	auipc	a6,0x91
ffffffffc02006e8:	d7c80813          	addi	a6,a6,-644 # ffffffffc0291460 <ide_devices>
ffffffffc02006ec:	97c2                	add	a5,a5,a6
ffffffffc02006ee:	0007a883          	lw	a7,0(a5)
ffffffffc02006f2:	02088563          	beqz	a7,ffffffffc020071c <ide_write_secs+0x56>
ffffffffc02006f6:	100008b7          	lui	a7,0x10000
ffffffffc02006fa:	0515f163          	bgeu	a1,a7,ffffffffc020073c <ide_write_secs+0x76>
ffffffffc02006fe:	1582                	slli	a1,a1,0x20
ffffffffc0200700:	9181                	srli	a1,a1,0x20
ffffffffc0200702:	00d58733          	add	a4,a1,a3
ffffffffc0200706:	02e8eb63          	bltu	a7,a4,ffffffffc020073c <ide_write_secs+0x76>
ffffffffc020070a:	00251713          	slli	a4,a0,0x2
ffffffffc020070e:	60a2                	ld	ra,8(sp)
ffffffffc0200710:	67bc                	ld	a5,72(a5)
ffffffffc0200712:	953a                	add	a0,a0,a4
ffffffffc0200714:	0512                	slli	a0,a0,0x4
ffffffffc0200716:	9542                	add	a0,a0,a6
ffffffffc0200718:	0141                	addi	sp,sp,16
ffffffffc020071a:	8782                	jr	a5
ffffffffc020071c:	0000b697          	auipc	a3,0xb
ffffffffc0200720:	12468693          	addi	a3,a3,292 # ffffffffc020b840 <commands+0xa8>
ffffffffc0200724:	0000b617          	auipc	a2,0xb
ffffffffc0200728:	0d460613          	addi	a2,a2,212 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020072c:	02900593          	li	a1,41
ffffffffc0200730:	0000b517          	auipc	a0,0xb
ffffffffc0200734:	0e050513          	addi	a0,a0,224 # ffffffffc020b810 <commands+0x78>
ffffffffc0200738:	af7ff0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020073c:	0000b697          	auipc	a3,0xb
ffffffffc0200740:	12c68693          	addi	a3,a3,300 # ffffffffc020b868 <commands+0xd0>
ffffffffc0200744:	0000b617          	auipc	a2,0xb
ffffffffc0200748:	0b460613          	addi	a2,a2,180 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020074c:	02a00593          	li	a1,42
ffffffffc0200750:	0000b517          	auipc	a0,0xb
ffffffffc0200754:	0c050513          	addi	a0,a0,192 # ffffffffc020b810 <commands+0x78>
ffffffffc0200758:	ad7ff0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020075c <ramdisk_write>:
ffffffffc020075c:	00856703          	lwu	a4,8(a0)
ffffffffc0200760:	1141                	addi	sp,sp,-16
ffffffffc0200762:	e406                	sd	ra,8(sp)
ffffffffc0200764:	8f0d                	sub	a4,a4,a1
ffffffffc0200766:	87ae                	mv	a5,a1
ffffffffc0200768:	85b2                	mv	a1,a2
ffffffffc020076a:	00e6f363          	bgeu	a3,a4,ffffffffc0200770 <ramdisk_write+0x14>
ffffffffc020076e:	8736                	mv	a4,a3
ffffffffc0200770:	6908                	ld	a0,16(a0)
ffffffffc0200772:	07a6                	slli	a5,a5,0x9
ffffffffc0200774:	00971613          	slli	a2,a4,0x9
ffffffffc0200778:	953e                	add	a0,a0,a5
ffffffffc020077a:	0cd0a0ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc020077e:	60a2                	ld	ra,8(sp)
ffffffffc0200780:	4501                	li	a0,0
ffffffffc0200782:	0141                	addi	sp,sp,16
ffffffffc0200784:	8082                	ret

ffffffffc0200786 <ramdisk_read>:
ffffffffc0200786:	00856783          	lwu	a5,8(a0)
ffffffffc020078a:	1141                	addi	sp,sp,-16
ffffffffc020078c:	e406                	sd	ra,8(sp)
ffffffffc020078e:	8f8d                	sub	a5,a5,a1
ffffffffc0200790:	872a                	mv	a4,a0
ffffffffc0200792:	8532                	mv	a0,a2
ffffffffc0200794:	00f6f363          	bgeu	a3,a5,ffffffffc020079a <ramdisk_read+0x14>
ffffffffc0200798:	87b6                	mv	a5,a3
ffffffffc020079a:	6b18                	ld	a4,16(a4)
ffffffffc020079c:	05a6                	slli	a1,a1,0x9
ffffffffc020079e:	00979613          	slli	a2,a5,0x9
ffffffffc02007a2:	95ba                	add	a1,a1,a4
ffffffffc02007a4:	0a30a0ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc02007a8:	60a2                	ld	ra,8(sp)
ffffffffc02007aa:	4501                	li	a0,0
ffffffffc02007ac:	0141                	addi	sp,sp,16
ffffffffc02007ae:	8082                	ret

ffffffffc02007b0 <ramdisk_init>:
ffffffffc02007b0:	1101                	addi	sp,sp,-32
ffffffffc02007b2:	e822                	sd	s0,16(sp)
ffffffffc02007b4:	842e                	mv	s0,a1
ffffffffc02007b6:	e426                	sd	s1,8(sp)
ffffffffc02007b8:	05000613          	li	a2,80
ffffffffc02007bc:	84aa                	mv	s1,a0
ffffffffc02007be:	4581                	li	a1,0
ffffffffc02007c0:	8522                	mv	a0,s0
ffffffffc02007c2:	ec06                	sd	ra,24(sp)
ffffffffc02007c4:	e04a                	sd	s2,0(sp)
ffffffffc02007c6:	02f0a0ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc02007ca:	4785                	li	a5,1
ffffffffc02007cc:	06f48b63          	beq	s1,a5,ffffffffc0200842 <ramdisk_init+0x92>
ffffffffc02007d0:	4789                	li	a5,2
ffffffffc02007d2:	00091617          	auipc	a2,0x91
ffffffffc02007d6:	83e60613          	addi	a2,a2,-1986 # ffffffffc0291010 <arena>
ffffffffc02007da:	0001b917          	auipc	s2,0x1b
ffffffffc02007de:	53690913          	addi	s2,s2,1334 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc02007e2:	08f49563          	bne	s1,a5,ffffffffc020086c <ramdisk_init+0xbc>
ffffffffc02007e6:	06c90863          	beq	s2,a2,ffffffffc0200856 <ramdisk_init+0xa6>
ffffffffc02007ea:	412604b3          	sub	s1,a2,s2
ffffffffc02007ee:	86a6                	mv	a3,s1
ffffffffc02007f0:	85ca                	mv	a1,s2
ffffffffc02007f2:	167d                	addi	a2,a2,-1
ffffffffc02007f4:	0000b517          	auipc	a0,0xb
ffffffffc02007f8:	0cc50513          	addi	a0,a0,204 # ffffffffc020b8c0 <commands+0x128>
ffffffffc02007fc:	92fff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200800:	57fd                	li	a5,-1
ffffffffc0200802:	1782                	slli	a5,a5,0x20
ffffffffc0200804:	0785                	addi	a5,a5,1
ffffffffc0200806:	0094d49b          	srliw	s1,s1,0x9
ffffffffc020080a:	e01c                	sd	a5,0(s0)
ffffffffc020080c:	c404                	sw	s1,8(s0)
ffffffffc020080e:	01243823          	sd	s2,16(s0)
ffffffffc0200812:	02040513          	addi	a0,s0,32
ffffffffc0200816:	0000b597          	auipc	a1,0xb
ffffffffc020081a:	10258593          	addi	a1,a1,258 # ffffffffc020b918 <commands+0x180>
ffffffffc020081e:	76a0a0ef          	jal	ra,ffffffffc020af88 <strcpy>
ffffffffc0200822:	00000797          	auipc	a5,0x0
ffffffffc0200826:	f6478793          	addi	a5,a5,-156 # ffffffffc0200786 <ramdisk_read>
ffffffffc020082a:	e03c                	sd	a5,64(s0)
ffffffffc020082c:	00000797          	auipc	a5,0x0
ffffffffc0200830:	f3078793          	addi	a5,a5,-208 # ffffffffc020075c <ramdisk_write>
ffffffffc0200834:	60e2                	ld	ra,24(sp)
ffffffffc0200836:	e43c                	sd	a5,72(s0)
ffffffffc0200838:	6442                	ld	s0,16(sp)
ffffffffc020083a:	64a2                	ld	s1,8(sp)
ffffffffc020083c:	6902                	ld	s2,0(sp)
ffffffffc020083e:	6105                	addi	sp,sp,32
ffffffffc0200840:	8082                	ret
ffffffffc0200842:	0001b617          	auipc	a2,0x1b
ffffffffc0200846:	4ce60613          	addi	a2,a2,1230 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc020084a:	00013917          	auipc	s2,0x13
ffffffffc020084e:	7c690913          	addi	s2,s2,1990 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200852:	f8c91ce3          	bne	s2,a2,ffffffffc02007ea <ramdisk_init+0x3a>
ffffffffc0200856:	6442                	ld	s0,16(sp)
ffffffffc0200858:	60e2                	ld	ra,24(sp)
ffffffffc020085a:	64a2                	ld	s1,8(sp)
ffffffffc020085c:	6902                	ld	s2,0(sp)
ffffffffc020085e:	0000b517          	auipc	a0,0xb
ffffffffc0200862:	04a50513          	addi	a0,a0,74 # ffffffffc020b8a8 <commands+0x110>
ffffffffc0200866:	6105                	addi	sp,sp,32
ffffffffc0200868:	8c3ff06f          	j	ffffffffc020012a <cprintf>
ffffffffc020086c:	0000b617          	auipc	a2,0xb
ffffffffc0200870:	07c60613          	addi	a2,a2,124 # ffffffffc020b8e8 <commands+0x150>
ffffffffc0200874:	03200593          	li	a1,50
ffffffffc0200878:	0000b517          	auipc	a0,0xb
ffffffffc020087c:	08850513          	addi	a0,a0,136 # ffffffffc020b900 <commands+0x168>
ffffffffc0200880:	9afff0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0200884 <clock_init>:
ffffffffc0200884:	02000793          	li	a5,32
ffffffffc0200888:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc020088c:	c0102573          	rdtime	a0
ffffffffc0200890:	67e1                	lui	a5,0x18
ffffffffc0200892:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200896:	953e                	add	a0,a0,a5
ffffffffc0200898:	4581                	li	a1,0
ffffffffc020089a:	4601                	li	a2,0
ffffffffc020089c:	4881                	li	a7,0
ffffffffc020089e:	00000073          	ecall
ffffffffc02008a2:	0000b517          	auipc	a0,0xb
ffffffffc02008a6:	08650513          	addi	a0,a0,134 # ffffffffc020b928 <commands+0x190>
ffffffffc02008aa:	00096797          	auipc	a5,0x96
ffffffffc02008ae:	fc07b323          	sd	zero,-58(a5) # ffffffffc0296870 <ticks>
ffffffffc02008b2:	879ff06f          	j	ffffffffc020012a <cprintf>

ffffffffc02008b6 <clock_set_next_event>:
ffffffffc02008b6:	c0102573          	rdtime	a0
ffffffffc02008ba:	67e1                	lui	a5,0x18
ffffffffc02008bc:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc02008c0:	953e                	add	a0,a0,a5
ffffffffc02008c2:	4581                	li	a1,0
ffffffffc02008c4:	4601                	li	a2,0
ffffffffc02008c6:	4881                	li	a7,0
ffffffffc02008c8:	00000073          	ecall
ffffffffc02008cc:	8082                	ret

ffffffffc02008ce <dtb_init>:
ffffffffc02008ce:	7119                	addi	sp,sp,-128
ffffffffc02008d0:	0000b517          	auipc	a0,0xb
ffffffffc02008d4:	07850513          	addi	a0,a0,120 # ffffffffc020b948 <commands+0x1b0>
ffffffffc02008d8:	fc86                	sd	ra,120(sp)
ffffffffc02008da:	f8a2                	sd	s0,112(sp)
ffffffffc02008dc:	e8d2                	sd	s4,80(sp)
ffffffffc02008de:	f4a6                	sd	s1,104(sp)
ffffffffc02008e0:	f0ca                	sd	s2,96(sp)
ffffffffc02008e2:	ecce                	sd	s3,88(sp)
ffffffffc02008e4:	e4d6                	sd	s5,72(sp)
ffffffffc02008e6:	e0da                	sd	s6,64(sp)
ffffffffc02008e8:	fc5e                	sd	s7,56(sp)
ffffffffc02008ea:	f862                	sd	s8,48(sp)
ffffffffc02008ec:	f466                	sd	s9,40(sp)
ffffffffc02008ee:	f06a                	sd	s10,32(sp)
ffffffffc02008f0:	ec6e                	sd	s11,24(sp)
ffffffffc02008f2:	839ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02008f6:	00013597          	auipc	a1,0x13
ffffffffc02008fa:	70a5b583          	ld	a1,1802(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02008fe:	0000b517          	auipc	a0,0xb
ffffffffc0200902:	05a50513          	addi	a0,a0,90 # ffffffffc020b958 <commands+0x1c0>
ffffffffc0200906:	825ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020090a:	00013417          	auipc	s0,0x13
ffffffffc020090e:	6fe40413          	addi	s0,s0,1790 # ffffffffc0214008 <boot_dtb>
ffffffffc0200912:	600c                	ld	a1,0(s0)
ffffffffc0200914:	0000b517          	auipc	a0,0xb
ffffffffc0200918:	05450513          	addi	a0,a0,84 # ffffffffc020b968 <commands+0x1d0>
ffffffffc020091c:	80fff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200920:	00043a03          	ld	s4,0(s0)
ffffffffc0200924:	0000b517          	auipc	a0,0xb
ffffffffc0200928:	05c50513          	addi	a0,a0,92 # ffffffffc020b980 <commands+0x1e8>
ffffffffc020092c:	120a0463          	beqz	s4,ffffffffc0200a54 <dtb_init+0x186>
ffffffffc0200930:	57f5                	li	a5,-3
ffffffffc0200932:	07fa                	slli	a5,a5,0x1e
ffffffffc0200934:	00fa0733          	add	a4,s4,a5
ffffffffc0200938:	431c                	lw	a5,0(a4)
ffffffffc020093a:	00ff0637          	lui	a2,0xff0
ffffffffc020093e:	6b41                	lui	s6,0x10
ffffffffc0200940:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200944:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200948:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020094c:	0105959b          	slliw	a1,a1,0x10
ffffffffc0200950:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200954:	8df1                	and	a1,a1,a2
ffffffffc0200956:	8ec9                	or	a3,a3,a0
ffffffffc0200958:	0087979b          	slliw	a5,a5,0x8
ffffffffc020095c:	1b7d                	addi	s6,s6,-1
ffffffffc020095e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200962:	8dd5                	or	a1,a1,a3
ffffffffc0200964:	8ddd                	or	a1,a1,a5
ffffffffc0200966:	d00e07b7          	lui	a5,0xd00e0
ffffffffc020096a:	2581                	sext.w	a1,a1
ffffffffc020096c:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc0200970:	10f59263          	bne	a1,a5,ffffffffc0200a74 <dtb_init+0x1a6>
ffffffffc0200974:	471c                	lw	a5,8(a4)
ffffffffc0200976:	4754                	lw	a3,12(a4)
ffffffffc0200978:	4c81                	li	s9,0
ffffffffc020097a:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020097e:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200982:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200986:	0186d89b          	srliw	a7,a3,0x18
ffffffffc020098a:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020098e:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200992:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200996:	0106d69b          	srliw	a3,a3,0x10
ffffffffc020099a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020099e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02009a2:	8d71                	and	a0,a0,a2
ffffffffc02009a4:	01146433          	or	s0,s0,a7
ffffffffc02009a8:	0086969b          	slliw	a3,a3,0x8
ffffffffc02009ac:	010a6a33          	or	s4,s4,a6
ffffffffc02009b0:	8e6d                	and	a2,a2,a1
ffffffffc02009b2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02009b6:	8c49                	or	s0,s0,a0
ffffffffc02009b8:	0166f6b3          	and	a3,a3,s6
ffffffffc02009bc:	00ca6a33          	or	s4,s4,a2
ffffffffc02009c0:	0167f7b3          	and	a5,a5,s6
ffffffffc02009c4:	8c55                	or	s0,s0,a3
ffffffffc02009c6:	00fa6a33          	or	s4,s4,a5
ffffffffc02009ca:	1402                	slli	s0,s0,0x20
ffffffffc02009cc:	1a02                	slli	s4,s4,0x20
ffffffffc02009ce:	9001                	srli	s0,s0,0x20
ffffffffc02009d0:	020a5a13          	srli	s4,s4,0x20
ffffffffc02009d4:	943a                	add	s0,s0,a4
ffffffffc02009d6:	9a3a                	add	s4,s4,a4
ffffffffc02009d8:	00ff0c37          	lui	s8,0xff0
ffffffffc02009dc:	4b8d                	li	s7,3
ffffffffc02009de:	0000b917          	auipc	s2,0xb
ffffffffc02009e2:	ff290913          	addi	s2,s2,-14 # ffffffffc020b9d0 <commands+0x238>
ffffffffc02009e6:	49bd                	li	s3,15
ffffffffc02009e8:	4d91                	li	s11,4
ffffffffc02009ea:	4d05                	li	s10,1
ffffffffc02009ec:	0000b497          	auipc	s1,0xb
ffffffffc02009f0:	fdc48493          	addi	s1,s1,-36 # ffffffffc020b9c8 <commands+0x230>
ffffffffc02009f4:	000a2703          	lw	a4,0(s4)
ffffffffc02009f8:	004a0a93          	addi	s5,s4,4
ffffffffc02009fc:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200a00:	0187179b          	slliw	a5,a4,0x18
ffffffffc0200a04:	0187561b          	srliw	a2,a4,0x18
ffffffffc0200a08:	0106969b          	slliw	a3,a3,0x10
ffffffffc0200a0c:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200a10:	8fd1                	or	a5,a5,a2
ffffffffc0200a12:	0186f6b3          	and	a3,a3,s8
ffffffffc0200a16:	0087171b          	slliw	a4,a4,0x8
ffffffffc0200a1a:	8fd5                	or	a5,a5,a3
ffffffffc0200a1c:	00eb7733          	and	a4,s6,a4
ffffffffc0200a20:	8fd9                	or	a5,a5,a4
ffffffffc0200a22:	2781                	sext.w	a5,a5
ffffffffc0200a24:	09778e63          	beq	a5,s7,ffffffffc0200ac0 <dtb_init+0x1f2>
ffffffffc0200a28:	00fbea63          	bltu	s7,a5,ffffffffc0200a3c <dtb_init+0x16e>
ffffffffc0200a2c:	07a78863          	beq	a5,s10,ffffffffc0200a9c <dtb_init+0x1ce>
ffffffffc0200a30:	4709                	li	a4,2
ffffffffc0200a32:	00e79763          	bne	a5,a4,ffffffffc0200a40 <dtb_init+0x172>
ffffffffc0200a36:	4c81                	li	s9,0
ffffffffc0200a38:	8a56                	mv	s4,s5
ffffffffc0200a3a:	bf6d                	j	ffffffffc02009f4 <dtb_init+0x126>
ffffffffc0200a3c:	ffb78ee3          	beq	a5,s11,ffffffffc0200a38 <dtb_init+0x16a>
ffffffffc0200a40:	0000b517          	auipc	a0,0xb
ffffffffc0200a44:	00850513          	addi	a0,a0,8 # ffffffffc020ba48 <commands+0x2b0>
ffffffffc0200a48:	ee2ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200a4c:	0000b517          	auipc	a0,0xb
ffffffffc0200a50:	03450513          	addi	a0,a0,52 # ffffffffc020ba80 <commands+0x2e8>
ffffffffc0200a54:	7446                	ld	s0,112(sp)
ffffffffc0200a56:	70e6                	ld	ra,120(sp)
ffffffffc0200a58:	74a6                	ld	s1,104(sp)
ffffffffc0200a5a:	7906                	ld	s2,96(sp)
ffffffffc0200a5c:	69e6                	ld	s3,88(sp)
ffffffffc0200a5e:	6a46                	ld	s4,80(sp)
ffffffffc0200a60:	6aa6                	ld	s5,72(sp)
ffffffffc0200a62:	6b06                	ld	s6,64(sp)
ffffffffc0200a64:	7be2                	ld	s7,56(sp)
ffffffffc0200a66:	7c42                	ld	s8,48(sp)
ffffffffc0200a68:	7ca2                	ld	s9,40(sp)
ffffffffc0200a6a:	7d02                	ld	s10,32(sp)
ffffffffc0200a6c:	6de2                	ld	s11,24(sp)
ffffffffc0200a6e:	6109                	addi	sp,sp,128
ffffffffc0200a70:	ebaff06f          	j	ffffffffc020012a <cprintf>
ffffffffc0200a74:	7446                	ld	s0,112(sp)
ffffffffc0200a76:	70e6                	ld	ra,120(sp)
ffffffffc0200a78:	74a6                	ld	s1,104(sp)
ffffffffc0200a7a:	7906                	ld	s2,96(sp)
ffffffffc0200a7c:	69e6                	ld	s3,88(sp)
ffffffffc0200a7e:	6a46                	ld	s4,80(sp)
ffffffffc0200a80:	6aa6                	ld	s5,72(sp)
ffffffffc0200a82:	6b06                	ld	s6,64(sp)
ffffffffc0200a84:	7be2                	ld	s7,56(sp)
ffffffffc0200a86:	7c42                	ld	s8,48(sp)
ffffffffc0200a88:	7ca2                	ld	s9,40(sp)
ffffffffc0200a8a:	7d02                	ld	s10,32(sp)
ffffffffc0200a8c:	6de2                	ld	s11,24(sp)
ffffffffc0200a8e:	0000b517          	auipc	a0,0xb
ffffffffc0200a92:	f1250513          	addi	a0,a0,-238 # ffffffffc020b9a0 <commands+0x208>
ffffffffc0200a96:	6109                	addi	sp,sp,128
ffffffffc0200a98:	e92ff06f          	j	ffffffffc020012a <cprintf>
ffffffffc0200a9c:	8556                	mv	a0,s5
ffffffffc0200a9e:	4b40a0ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc0200aa2:	8a2a                	mv	s4,a0
ffffffffc0200aa4:	4619                	li	a2,6
ffffffffc0200aa6:	85a6                	mv	a1,s1
ffffffffc0200aa8:	8556                	mv	a0,s5
ffffffffc0200aaa:	2a01                	sext.w	s4,s4
ffffffffc0200aac:	50c0a0ef          	jal	ra,ffffffffc020afb8 <strncmp>
ffffffffc0200ab0:	e111                	bnez	a0,ffffffffc0200ab4 <dtb_init+0x1e6>
ffffffffc0200ab2:	4c85                	li	s9,1
ffffffffc0200ab4:	0a91                	addi	s5,s5,4
ffffffffc0200ab6:	9ad2                	add	s5,s5,s4
ffffffffc0200ab8:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200abc:	8a56                	mv	s4,s5
ffffffffc0200abe:	bf1d                	j	ffffffffc02009f4 <dtb_init+0x126>
ffffffffc0200ac0:	004a2783          	lw	a5,4(s4)
ffffffffc0200ac4:	00ca0693          	addi	a3,s4,12
ffffffffc0200ac8:	0087d71b          	srliw	a4,a5,0x8
ffffffffc0200acc:	01879a9b          	slliw	s5,a5,0x18
ffffffffc0200ad0:	0187d61b          	srliw	a2,a5,0x18
ffffffffc0200ad4:	0107171b          	slliw	a4,a4,0x10
ffffffffc0200ad8:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200adc:	00caeab3          	or	s5,s5,a2
ffffffffc0200ae0:	01877733          	and	a4,a4,s8
ffffffffc0200ae4:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200ae8:	00eaeab3          	or	s5,s5,a4
ffffffffc0200aec:	00fb77b3          	and	a5,s6,a5
ffffffffc0200af0:	00faeab3          	or	s5,s5,a5
ffffffffc0200af4:	2a81                	sext.w	s5,s5
ffffffffc0200af6:	000c9c63          	bnez	s9,ffffffffc0200b0e <dtb_init+0x240>
ffffffffc0200afa:	1a82                	slli	s5,s5,0x20
ffffffffc0200afc:	00368793          	addi	a5,a3,3
ffffffffc0200b00:	020ada93          	srli	s5,s5,0x20
ffffffffc0200b04:	9abe                	add	s5,s5,a5
ffffffffc0200b06:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200b0a:	8a56                	mv	s4,s5
ffffffffc0200b0c:	b5e5                	j	ffffffffc02009f4 <dtb_init+0x126>
ffffffffc0200b0e:	008a2783          	lw	a5,8(s4)
ffffffffc0200b12:	85ca                	mv	a1,s2
ffffffffc0200b14:	e436                	sd	a3,8(sp)
ffffffffc0200b16:	0087d51b          	srliw	a0,a5,0x8
ffffffffc0200b1a:	0187d61b          	srliw	a2,a5,0x18
ffffffffc0200b1e:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200b22:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200b26:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200b2a:	8f51                	or	a4,a4,a2
ffffffffc0200b2c:	01857533          	and	a0,a0,s8
ffffffffc0200b30:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200b34:	8d59                	or	a0,a0,a4
ffffffffc0200b36:	00fb77b3          	and	a5,s6,a5
ffffffffc0200b3a:	8d5d                	or	a0,a0,a5
ffffffffc0200b3c:	1502                	slli	a0,a0,0x20
ffffffffc0200b3e:	9101                	srli	a0,a0,0x20
ffffffffc0200b40:	9522                	add	a0,a0,s0
ffffffffc0200b42:	4580a0ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc0200b46:	66a2                	ld	a3,8(sp)
ffffffffc0200b48:	f94d                	bnez	a0,ffffffffc0200afa <dtb_init+0x22c>
ffffffffc0200b4a:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200afa <dtb_init+0x22c>
ffffffffc0200b4e:	00ca3783          	ld	a5,12(s4)
ffffffffc0200b52:	014a3703          	ld	a4,20(s4)
ffffffffc0200b56:	0000b517          	auipc	a0,0xb
ffffffffc0200b5a:	e8250513          	addi	a0,a0,-382 # ffffffffc020b9d8 <commands+0x240>
ffffffffc0200b5e:	4207d613          	srai	a2,a5,0x20
ffffffffc0200b62:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200b66:	42075593          	srai	a1,a4,0x20
ffffffffc0200b6a:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200b6e:	0186581b          	srliw	a6,a2,0x18
ffffffffc0200b72:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200b76:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200b7a:	0187d693          	srli	a3,a5,0x18
ffffffffc0200b7e:	01861f1b          	slliw	t5,a2,0x18
ffffffffc0200b82:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200b86:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200b8a:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200b8e:	010f6f33          	or	t5,t5,a6
ffffffffc0200b92:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200b96:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200b9a:	01837333          	and	t1,t1,s8
ffffffffc0200b9e:	01c46433          	or	s0,s0,t3
ffffffffc0200ba2:	0186f6b3          	and	a3,a3,s8
ffffffffc0200ba6:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200baa:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200bae:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200bb2:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200bb6:	8361                	srli	a4,a4,0x18
ffffffffc0200bb8:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200bbc:	0105d59b          	srliw	a1,a1,0x10
ffffffffc0200bc0:	01e6e6b3          	or	a3,a3,t5
ffffffffc0200bc4:	00cb7633          	and	a2,s6,a2
ffffffffc0200bc8:	0088181b          	slliw	a6,a6,0x8
ffffffffc0200bcc:	0085959b          	slliw	a1,a1,0x8
ffffffffc0200bd0:	00646433          	or	s0,s0,t1
ffffffffc0200bd4:	0187f7b3          	and	a5,a5,s8
ffffffffc0200bd8:	01fe6333          	or	t1,t3,t6
ffffffffc0200bdc:	01877c33          	and	s8,a4,s8
ffffffffc0200be0:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200be4:	011b78b3          	and	a7,s6,a7
ffffffffc0200be8:	005eeeb3          	or	t4,t4,t0
ffffffffc0200bec:	00c6e733          	or	a4,a3,a2
ffffffffc0200bf0:	006c6c33          	or	s8,s8,t1
ffffffffc0200bf4:	010b76b3          	and	a3,s6,a6
ffffffffc0200bf8:	00bb7b33          	and	s6,s6,a1
ffffffffc0200bfc:	01d7e7b3          	or	a5,a5,t4
ffffffffc0200c00:	016c6b33          	or	s6,s8,s6
ffffffffc0200c04:	01146433          	or	s0,s0,a7
ffffffffc0200c08:	8fd5                	or	a5,a5,a3
ffffffffc0200c0a:	1702                	slli	a4,a4,0x20
ffffffffc0200c0c:	1b02                	slli	s6,s6,0x20
ffffffffc0200c0e:	1782                	slli	a5,a5,0x20
ffffffffc0200c10:	9301                	srli	a4,a4,0x20
ffffffffc0200c12:	1402                	slli	s0,s0,0x20
ffffffffc0200c14:	020b5b13          	srli	s6,s6,0x20
ffffffffc0200c18:	0167eb33          	or	s6,a5,s6
ffffffffc0200c1c:	8c59                	or	s0,s0,a4
ffffffffc0200c1e:	d0cff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200c22:	85a2                	mv	a1,s0
ffffffffc0200c24:	0000b517          	auipc	a0,0xb
ffffffffc0200c28:	dd450513          	addi	a0,a0,-556 # ffffffffc020b9f8 <commands+0x260>
ffffffffc0200c2c:	cfeff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200c30:	014b5613          	srli	a2,s6,0x14
ffffffffc0200c34:	85da                	mv	a1,s6
ffffffffc0200c36:	0000b517          	auipc	a0,0xb
ffffffffc0200c3a:	dda50513          	addi	a0,a0,-550 # ffffffffc020ba10 <commands+0x278>
ffffffffc0200c3e:	cecff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200c42:	008b05b3          	add	a1,s6,s0
ffffffffc0200c46:	15fd                	addi	a1,a1,-1
ffffffffc0200c48:	0000b517          	auipc	a0,0xb
ffffffffc0200c4c:	de850513          	addi	a0,a0,-536 # ffffffffc020ba30 <commands+0x298>
ffffffffc0200c50:	cdaff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200c54:	0000b517          	auipc	a0,0xb
ffffffffc0200c58:	e2c50513          	addi	a0,a0,-468 # ffffffffc020ba80 <commands+0x2e8>
ffffffffc0200c5c:	00096797          	auipc	a5,0x96
ffffffffc0200c60:	c087be23          	sd	s0,-996(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200c64:	00096797          	auipc	a5,0x96
ffffffffc0200c68:	c167be23          	sd	s6,-996(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200c6c:	b3e5                	j	ffffffffc0200a54 <dtb_init+0x186>

ffffffffc0200c6e <get_memory_base>:
ffffffffc0200c6e:	00096517          	auipc	a0,0x96
ffffffffc0200c72:	c0a53503          	ld	a0,-1014(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <get_memory_size>:
ffffffffc0200c78:	00096517          	auipc	a0,0x96
ffffffffc0200c7c:	c0853503          	ld	a0,-1016(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200c80:	8082                	ret

ffffffffc0200c82 <cons_init>:
ffffffffc0200c82:	4501                	li	a0,0
ffffffffc0200c84:	4581                	li	a1,0
ffffffffc0200c86:	4601                	li	a2,0
ffffffffc0200c88:	4889                	li	a7,2
ffffffffc0200c8a:	00000073          	ecall
ffffffffc0200c8e:	8082                	ret

ffffffffc0200c90 <cons_putc>:
ffffffffc0200c90:	1101                	addi	sp,sp,-32
ffffffffc0200c92:	ec06                	sd	ra,24(sp)
ffffffffc0200c94:	100027f3          	csrr	a5,sstatus
ffffffffc0200c98:	8b89                	andi	a5,a5,2
ffffffffc0200c9a:	4701                	li	a4,0
ffffffffc0200c9c:	ef95                	bnez	a5,ffffffffc0200cd8 <cons_putc+0x48>
ffffffffc0200c9e:	47a1                	li	a5,8
ffffffffc0200ca0:	00f50b63          	beq	a0,a5,ffffffffc0200cb6 <cons_putc+0x26>
ffffffffc0200ca4:	4581                	li	a1,0
ffffffffc0200ca6:	4601                	li	a2,0
ffffffffc0200ca8:	4885                	li	a7,1
ffffffffc0200caa:	00000073          	ecall
ffffffffc0200cae:	e315                	bnez	a4,ffffffffc0200cd2 <cons_putc+0x42>
ffffffffc0200cb0:	60e2                	ld	ra,24(sp)
ffffffffc0200cb2:	6105                	addi	sp,sp,32
ffffffffc0200cb4:	8082                	ret
ffffffffc0200cb6:	4521                	li	a0,8
ffffffffc0200cb8:	4581                	li	a1,0
ffffffffc0200cba:	4601                	li	a2,0
ffffffffc0200cbc:	4885                	li	a7,1
ffffffffc0200cbe:	00000073          	ecall
ffffffffc0200cc2:	02000513          	li	a0,32
ffffffffc0200cc6:	00000073          	ecall
ffffffffc0200cca:	4521                	li	a0,8
ffffffffc0200ccc:	00000073          	ecall
ffffffffc0200cd0:	d365                	beqz	a4,ffffffffc0200cb0 <cons_putc+0x20>
ffffffffc0200cd2:	60e2                	ld	ra,24(sp)
ffffffffc0200cd4:	6105                	addi	sp,sp,32
ffffffffc0200cd6:	a0e1                	j	ffffffffc0200d9e <intr_enable>
ffffffffc0200cd8:	e42a                	sd	a0,8(sp)
ffffffffc0200cda:	0ca000ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0200cde:	6522                	ld	a0,8(sp)
ffffffffc0200ce0:	4705                	li	a4,1
ffffffffc0200ce2:	bf75                	j	ffffffffc0200c9e <cons_putc+0xe>

ffffffffc0200ce4 <cons_getc>:
ffffffffc0200ce4:	1101                	addi	sp,sp,-32
ffffffffc0200ce6:	ec06                	sd	ra,24(sp)
ffffffffc0200ce8:	100027f3          	csrr	a5,sstatus
ffffffffc0200cec:	8b89                	andi	a5,a5,2
ffffffffc0200cee:	4801                	li	a6,0
ffffffffc0200cf0:	e3d5                	bnez	a5,ffffffffc0200d94 <cons_getc+0xb0>
ffffffffc0200cf2:	00091697          	auipc	a3,0x91
ffffffffc0200cf6:	8ae68693          	addi	a3,a3,-1874 # ffffffffc02915a0 <cons>
ffffffffc0200cfa:	07f00713          	li	a4,127
ffffffffc0200cfe:	20000313          	li	t1,512
ffffffffc0200d02:	a021                	j	ffffffffc0200d0a <cons_getc+0x26>
ffffffffc0200d04:	0ff57513          	zext.b	a0,a0
ffffffffc0200d08:	ef91                	bnez	a5,ffffffffc0200d24 <cons_getc+0x40>
ffffffffc0200d0a:	4501                	li	a0,0
ffffffffc0200d0c:	4581                	li	a1,0
ffffffffc0200d0e:	4601                	li	a2,0
ffffffffc0200d10:	4889                	li	a7,2
ffffffffc0200d12:	00000073          	ecall
ffffffffc0200d16:	0005079b          	sext.w	a5,a0
ffffffffc0200d1a:	0207c763          	bltz	a5,ffffffffc0200d48 <cons_getc+0x64>
ffffffffc0200d1e:	fee793e3          	bne	a5,a4,ffffffffc0200d04 <cons_getc+0x20>
ffffffffc0200d22:	4521                	li	a0,8
ffffffffc0200d24:	2046a783          	lw	a5,516(a3)
ffffffffc0200d28:	02079613          	slli	a2,a5,0x20
ffffffffc0200d2c:	9201                	srli	a2,a2,0x20
ffffffffc0200d2e:	2785                	addiw	a5,a5,1
ffffffffc0200d30:	9636                	add	a2,a2,a3
ffffffffc0200d32:	20f6a223          	sw	a5,516(a3)
ffffffffc0200d36:	00a60023          	sb	a0,0(a2) # ff0000 <_binary_bin_sfs_img_size+0xf7ad00>
ffffffffc0200d3a:	fc6798e3          	bne	a5,t1,ffffffffc0200d0a <cons_getc+0x26>
ffffffffc0200d3e:	00091797          	auipc	a5,0x91
ffffffffc0200d42:	a607a323          	sw	zero,-1434(a5) # ffffffffc02917a4 <cons+0x204>
ffffffffc0200d46:	b7d1                	j	ffffffffc0200d0a <cons_getc+0x26>
ffffffffc0200d48:	2006a783          	lw	a5,512(a3)
ffffffffc0200d4c:	2046a703          	lw	a4,516(a3)
ffffffffc0200d50:	4501                	li	a0,0
ffffffffc0200d52:	00f70f63          	beq	a4,a5,ffffffffc0200d70 <cons_getc+0x8c>
ffffffffc0200d56:	0017861b          	addiw	a2,a5,1
ffffffffc0200d5a:	1782                	slli	a5,a5,0x20
ffffffffc0200d5c:	9381                	srli	a5,a5,0x20
ffffffffc0200d5e:	97b6                	add	a5,a5,a3
ffffffffc0200d60:	20c6a023          	sw	a2,512(a3)
ffffffffc0200d64:	20000713          	li	a4,512
ffffffffc0200d68:	0007c503          	lbu	a0,0(a5)
ffffffffc0200d6c:	00e60763          	beq	a2,a4,ffffffffc0200d7a <cons_getc+0x96>
ffffffffc0200d70:	00081b63          	bnez	a6,ffffffffc0200d86 <cons_getc+0xa2>
ffffffffc0200d74:	60e2                	ld	ra,24(sp)
ffffffffc0200d76:	6105                	addi	sp,sp,32
ffffffffc0200d78:	8082                	ret
ffffffffc0200d7a:	00091797          	auipc	a5,0x91
ffffffffc0200d7e:	a207a323          	sw	zero,-1498(a5) # ffffffffc02917a0 <cons+0x200>
ffffffffc0200d82:	fe0809e3          	beqz	a6,ffffffffc0200d74 <cons_getc+0x90>
ffffffffc0200d86:	e42a                	sd	a0,8(sp)
ffffffffc0200d88:	016000ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0200d8c:	60e2                	ld	ra,24(sp)
ffffffffc0200d8e:	6522                	ld	a0,8(sp)
ffffffffc0200d90:	6105                	addi	sp,sp,32
ffffffffc0200d92:	8082                	ret
ffffffffc0200d94:	010000ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0200d98:	4805                	li	a6,1
ffffffffc0200d9a:	bfa1                	j	ffffffffc0200cf2 <cons_getc+0xe>

ffffffffc0200d9c <pic_init>:
ffffffffc0200d9c:	8082                	ret

ffffffffc0200d9e <intr_enable>:
ffffffffc0200d9e:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200da2:	8082                	ret

ffffffffc0200da4 <intr_disable>:
ffffffffc0200da4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200da8:	8082                	ret

ffffffffc0200daa <idt_init>:
ffffffffc0200daa:	14005073          	csrwi	sscratch,0
ffffffffc0200dae:	00000797          	auipc	a5,0x0
ffffffffc0200db2:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e8 <__alltraps>
ffffffffc0200db6:	10579073          	csrw	stvec,a5
ffffffffc0200dba:	000407b7          	lui	a5,0x40
ffffffffc0200dbe:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dc2:	8082                	ret

ffffffffc0200dc4 <print_regs>:
ffffffffc0200dc4:	610c                	ld	a1,0(a0)
ffffffffc0200dc6:	1141                	addi	sp,sp,-16
ffffffffc0200dc8:	e022                	sd	s0,0(sp)
ffffffffc0200dca:	842a                	mv	s0,a0
ffffffffc0200dcc:	0000b517          	auipc	a0,0xb
ffffffffc0200dd0:	ccc50513          	addi	a0,a0,-820 # ffffffffc020ba98 <commands+0x300>
ffffffffc0200dd4:	e406                	sd	ra,8(sp)
ffffffffc0200dd6:	b54ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200dda:	640c                	ld	a1,8(s0)
ffffffffc0200ddc:	0000b517          	auipc	a0,0xb
ffffffffc0200de0:	cd450513          	addi	a0,a0,-812 # ffffffffc020bab0 <commands+0x318>
ffffffffc0200de4:	b46ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200de8:	680c                	ld	a1,16(s0)
ffffffffc0200dea:	0000b517          	auipc	a0,0xb
ffffffffc0200dee:	cde50513          	addi	a0,a0,-802 # ffffffffc020bac8 <commands+0x330>
ffffffffc0200df2:	b38ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200df6:	6c0c                	ld	a1,24(s0)
ffffffffc0200df8:	0000b517          	auipc	a0,0xb
ffffffffc0200dfc:	ce850513          	addi	a0,a0,-792 # ffffffffc020bae0 <commands+0x348>
ffffffffc0200e00:	b2aff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e04:	700c                	ld	a1,32(s0)
ffffffffc0200e06:	0000b517          	auipc	a0,0xb
ffffffffc0200e0a:	cf250513          	addi	a0,a0,-782 # ffffffffc020baf8 <commands+0x360>
ffffffffc0200e0e:	b1cff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e12:	740c                	ld	a1,40(s0)
ffffffffc0200e14:	0000b517          	auipc	a0,0xb
ffffffffc0200e18:	cfc50513          	addi	a0,a0,-772 # ffffffffc020bb10 <commands+0x378>
ffffffffc0200e1c:	b0eff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e20:	780c                	ld	a1,48(s0)
ffffffffc0200e22:	0000b517          	auipc	a0,0xb
ffffffffc0200e26:	d0650513          	addi	a0,a0,-762 # ffffffffc020bb28 <commands+0x390>
ffffffffc0200e2a:	b00ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e2e:	7c0c                	ld	a1,56(s0)
ffffffffc0200e30:	0000b517          	auipc	a0,0xb
ffffffffc0200e34:	d1050513          	addi	a0,a0,-752 # ffffffffc020bb40 <commands+0x3a8>
ffffffffc0200e38:	af2ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e3c:	602c                	ld	a1,64(s0)
ffffffffc0200e3e:	0000b517          	auipc	a0,0xb
ffffffffc0200e42:	d1a50513          	addi	a0,a0,-742 # ffffffffc020bb58 <commands+0x3c0>
ffffffffc0200e46:	ae4ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e4a:	642c                	ld	a1,72(s0)
ffffffffc0200e4c:	0000b517          	auipc	a0,0xb
ffffffffc0200e50:	d2450513          	addi	a0,a0,-732 # ffffffffc020bb70 <commands+0x3d8>
ffffffffc0200e54:	ad6ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e58:	682c                	ld	a1,80(s0)
ffffffffc0200e5a:	0000b517          	auipc	a0,0xb
ffffffffc0200e5e:	d2e50513          	addi	a0,a0,-722 # ffffffffc020bb88 <commands+0x3f0>
ffffffffc0200e62:	ac8ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e66:	6c2c                	ld	a1,88(s0)
ffffffffc0200e68:	0000b517          	auipc	a0,0xb
ffffffffc0200e6c:	d3850513          	addi	a0,a0,-712 # ffffffffc020bba0 <commands+0x408>
ffffffffc0200e70:	abaff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e74:	702c                	ld	a1,96(s0)
ffffffffc0200e76:	0000b517          	auipc	a0,0xb
ffffffffc0200e7a:	d4250513          	addi	a0,a0,-702 # ffffffffc020bbb8 <commands+0x420>
ffffffffc0200e7e:	aacff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e82:	742c                	ld	a1,104(s0)
ffffffffc0200e84:	0000b517          	auipc	a0,0xb
ffffffffc0200e88:	d4c50513          	addi	a0,a0,-692 # ffffffffc020bbd0 <commands+0x438>
ffffffffc0200e8c:	a9eff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e90:	782c                	ld	a1,112(s0)
ffffffffc0200e92:	0000b517          	auipc	a0,0xb
ffffffffc0200e96:	d5650513          	addi	a0,a0,-682 # ffffffffc020bbe8 <commands+0x450>
ffffffffc0200e9a:	a90ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200e9e:	7c2c                	ld	a1,120(s0)
ffffffffc0200ea0:	0000b517          	auipc	a0,0xb
ffffffffc0200ea4:	d6050513          	addi	a0,a0,-672 # ffffffffc020bc00 <commands+0x468>
ffffffffc0200ea8:	a82ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200eac:	604c                	ld	a1,128(s0)
ffffffffc0200eae:	0000b517          	auipc	a0,0xb
ffffffffc0200eb2:	d6a50513          	addi	a0,a0,-662 # ffffffffc020bc18 <commands+0x480>
ffffffffc0200eb6:	a74ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200eba:	644c                	ld	a1,136(s0)
ffffffffc0200ebc:	0000b517          	auipc	a0,0xb
ffffffffc0200ec0:	d7450513          	addi	a0,a0,-652 # ffffffffc020bc30 <commands+0x498>
ffffffffc0200ec4:	a66ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200ec8:	684c                	ld	a1,144(s0)
ffffffffc0200eca:	0000b517          	auipc	a0,0xb
ffffffffc0200ece:	d7e50513          	addi	a0,a0,-642 # ffffffffc020bc48 <commands+0x4b0>
ffffffffc0200ed2:	a58ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200ed6:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed8:	0000b517          	auipc	a0,0xb
ffffffffc0200edc:	d8850513          	addi	a0,a0,-632 # ffffffffc020bc60 <commands+0x4c8>
ffffffffc0200ee0:	a4aff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200ee4:	704c                	ld	a1,160(s0)
ffffffffc0200ee6:	0000b517          	auipc	a0,0xb
ffffffffc0200eea:	d9250513          	addi	a0,a0,-622 # ffffffffc020bc78 <commands+0x4e0>
ffffffffc0200eee:	a3cff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200ef2:	744c                	ld	a1,168(s0)
ffffffffc0200ef4:	0000b517          	auipc	a0,0xb
ffffffffc0200ef8:	d9c50513          	addi	a0,a0,-612 # ffffffffc020bc90 <commands+0x4f8>
ffffffffc0200efc:	a2eff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f00:	784c                	ld	a1,176(s0)
ffffffffc0200f02:	0000b517          	auipc	a0,0xb
ffffffffc0200f06:	da650513          	addi	a0,a0,-602 # ffffffffc020bca8 <commands+0x510>
ffffffffc0200f0a:	a20ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f0e:	7c4c                	ld	a1,184(s0)
ffffffffc0200f10:	0000b517          	auipc	a0,0xb
ffffffffc0200f14:	db050513          	addi	a0,a0,-592 # ffffffffc020bcc0 <commands+0x528>
ffffffffc0200f18:	a12ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f1c:	606c                	ld	a1,192(s0)
ffffffffc0200f1e:	0000b517          	auipc	a0,0xb
ffffffffc0200f22:	dba50513          	addi	a0,a0,-582 # ffffffffc020bcd8 <commands+0x540>
ffffffffc0200f26:	a04ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f2a:	646c                	ld	a1,200(s0)
ffffffffc0200f2c:	0000b517          	auipc	a0,0xb
ffffffffc0200f30:	dc450513          	addi	a0,a0,-572 # ffffffffc020bcf0 <commands+0x558>
ffffffffc0200f34:	9f6ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f38:	686c                	ld	a1,208(s0)
ffffffffc0200f3a:	0000b517          	auipc	a0,0xb
ffffffffc0200f3e:	dce50513          	addi	a0,a0,-562 # ffffffffc020bd08 <commands+0x570>
ffffffffc0200f42:	9e8ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f46:	6c6c                	ld	a1,216(s0)
ffffffffc0200f48:	0000b517          	auipc	a0,0xb
ffffffffc0200f4c:	dd850513          	addi	a0,a0,-552 # ffffffffc020bd20 <commands+0x588>
ffffffffc0200f50:	9daff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f54:	706c                	ld	a1,224(s0)
ffffffffc0200f56:	0000b517          	auipc	a0,0xb
ffffffffc0200f5a:	de250513          	addi	a0,a0,-542 # ffffffffc020bd38 <commands+0x5a0>
ffffffffc0200f5e:	9ccff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f62:	746c                	ld	a1,232(s0)
ffffffffc0200f64:	0000b517          	auipc	a0,0xb
ffffffffc0200f68:	dec50513          	addi	a0,a0,-532 # ffffffffc020bd50 <commands+0x5b8>
ffffffffc0200f6c:	9beff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f70:	786c                	ld	a1,240(s0)
ffffffffc0200f72:	0000b517          	auipc	a0,0xb
ffffffffc0200f76:	df650513          	addi	a0,a0,-522 # ffffffffc020bd68 <commands+0x5d0>
ffffffffc0200f7a:	9b0ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200f7e:	7c6c                	ld	a1,248(s0)
ffffffffc0200f80:	6402                	ld	s0,0(sp)
ffffffffc0200f82:	60a2                	ld	ra,8(sp)
ffffffffc0200f84:	0000b517          	auipc	a0,0xb
ffffffffc0200f88:	dfc50513          	addi	a0,a0,-516 # ffffffffc020bd80 <commands+0x5e8>
ffffffffc0200f8c:	0141                	addi	sp,sp,16
ffffffffc0200f8e:	99cff06f          	j	ffffffffc020012a <cprintf>

ffffffffc0200f92 <print_trapframe>:
ffffffffc0200f92:	1141                	addi	sp,sp,-16
ffffffffc0200f94:	e022                	sd	s0,0(sp)
ffffffffc0200f96:	85aa                	mv	a1,a0
ffffffffc0200f98:	842a                	mv	s0,a0
ffffffffc0200f9a:	0000b517          	auipc	a0,0xb
ffffffffc0200f9e:	dfe50513          	addi	a0,a0,-514 # ffffffffc020bd98 <commands+0x600>
ffffffffc0200fa2:	e406                	sd	ra,8(sp)
ffffffffc0200fa4:	986ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200fa8:	8522                	mv	a0,s0
ffffffffc0200faa:	e1bff0ef          	jal	ra,ffffffffc0200dc4 <print_regs>
ffffffffc0200fae:	10043583          	ld	a1,256(s0)
ffffffffc0200fb2:	0000b517          	auipc	a0,0xb
ffffffffc0200fb6:	dfe50513          	addi	a0,a0,-514 # ffffffffc020bdb0 <commands+0x618>
ffffffffc0200fba:	970ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200fbe:	10843583          	ld	a1,264(s0)
ffffffffc0200fc2:	0000b517          	auipc	a0,0xb
ffffffffc0200fc6:	e0650513          	addi	a0,a0,-506 # ffffffffc020bdc8 <commands+0x630>
ffffffffc0200fca:	960ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200fce:	11043583          	ld	a1,272(s0)
ffffffffc0200fd2:	0000b517          	auipc	a0,0xb
ffffffffc0200fd6:	e0e50513          	addi	a0,a0,-498 # ffffffffc020bde0 <commands+0x648>
ffffffffc0200fda:	950ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0200fde:	11843583          	ld	a1,280(s0)
ffffffffc0200fe2:	6402                	ld	s0,0(sp)
ffffffffc0200fe4:	60a2                	ld	ra,8(sp)
ffffffffc0200fe6:	0000b517          	auipc	a0,0xb
ffffffffc0200fea:	e0a50513          	addi	a0,a0,-502 # ffffffffc020bdf0 <commands+0x658>
ffffffffc0200fee:	0141                	addi	sp,sp,16
ffffffffc0200ff0:	93aff06f          	j	ffffffffc020012a <cprintf>

ffffffffc0200ff4 <interrupt_handler>:
ffffffffc0200ff4:	11853783          	ld	a5,280(a0)
ffffffffc0200ff8:	472d                	li	a4,11
ffffffffc0200ffa:	0786                	slli	a5,a5,0x1
ffffffffc0200ffc:	8385                	srli	a5,a5,0x1
ffffffffc0200ffe:	06f76c63          	bltu	a4,a5,ffffffffc0201076 <interrupt_handler+0x82>
ffffffffc0201002:	0000b717          	auipc	a4,0xb
ffffffffc0201006:	ea670713          	addi	a4,a4,-346 # ffffffffc020bea8 <commands+0x710>
ffffffffc020100a:	078a                	slli	a5,a5,0x2
ffffffffc020100c:	97ba                	add	a5,a5,a4
ffffffffc020100e:	439c                	lw	a5,0(a5)
ffffffffc0201010:	97ba                	add	a5,a5,a4
ffffffffc0201012:	8782                	jr	a5
ffffffffc0201014:	0000b517          	auipc	a0,0xb
ffffffffc0201018:	e5450513          	addi	a0,a0,-428 # ffffffffc020be68 <commands+0x6d0>
ffffffffc020101c:	90eff06f          	j	ffffffffc020012a <cprintf>
ffffffffc0201020:	0000b517          	auipc	a0,0xb
ffffffffc0201024:	e2850513          	addi	a0,a0,-472 # ffffffffc020be48 <commands+0x6b0>
ffffffffc0201028:	902ff06f          	j	ffffffffc020012a <cprintf>
ffffffffc020102c:	0000b517          	auipc	a0,0xb
ffffffffc0201030:	ddc50513          	addi	a0,a0,-548 # ffffffffc020be08 <commands+0x670>
ffffffffc0201034:	8f6ff06f          	j	ffffffffc020012a <cprintf>
ffffffffc0201038:	0000b517          	auipc	a0,0xb
ffffffffc020103c:	df050513          	addi	a0,a0,-528 # ffffffffc020be28 <commands+0x690>
ffffffffc0201040:	8eaff06f          	j	ffffffffc020012a <cprintf>
ffffffffc0201044:	1141                	addi	sp,sp,-16
ffffffffc0201046:	e406                	sd	ra,8(sp)
ffffffffc0201048:	86fff0ef          	jal	ra,ffffffffc02008b6 <clock_set_next_event>
ffffffffc020104c:	00096717          	auipc	a4,0x96
ffffffffc0201050:	82470713          	addi	a4,a4,-2012 # ffffffffc0296870 <ticks>
ffffffffc0201054:	631c                	ld	a5,0(a4)
ffffffffc0201056:	0785                	addi	a5,a5,1
ffffffffc0201058:	e31c                	sd	a5,0(a4)
ffffffffc020105a:	420060ef          	jal	ra,ffffffffc020747a <run_timer_list>
ffffffffc020105e:	c87ff0ef          	jal	ra,ffffffffc0200ce4 <cons_getc>
ffffffffc0201062:	60a2                	ld	ra,8(sp)
ffffffffc0201064:	0141                	addi	sp,sp,16
ffffffffc0201066:	6220706f          	j	ffffffffc0208688 <dev_stdin_write>
ffffffffc020106a:	0000b517          	auipc	a0,0xb
ffffffffc020106e:	e1e50513          	addi	a0,a0,-482 # ffffffffc020be88 <commands+0x6f0>
ffffffffc0201072:	8b8ff06f          	j	ffffffffc020012a <cprintf>
ffffffffc0201076:	bf31                	j	ffffffffc0200f92 <print_trapframe>

ffffffffc0201078 <exception_handler>:
ffffffffc0201078:	11853783          	ld	a5,280(a0)
ffffffffc020107c:	1141                	addi	sp,sp,-16
ffffffffc020107e:	e022                	sd	s0,0(sp)
ffffffffc0201080:	e406                	sd	ra,8(sp)
ffffffffc0201082:	473d                	li	a4,15
ffffffffc0201084:	842a                	mv	s0,a0
ffffffffc0201086:	0af76b63          	bltu	a4,a5,ffffffffc020113c <exception_handler+0xc4>
ffffffffc020108a:	0000b717          	auipc	a4,0xb
ffffffffc020108e:	fde70713          	addi	a4,a4,-34 # ffffffffc020c068 <commands+0x8d0>
ffffffffc0201092:	078a                	slli	a5,a5,0x2
ffffffffc0201094:	97ba                	add	a5,a5,a4
ffffffffc0201096:	439c                	lw	a5,0(a5)
ffffffffc0201098:	97ba                	add	a5,a5,a4
ffffffffc020109a:	8782                	jr	a5
ffffffffc020109c:	0000b517          	auipc	a0,0xb
ffffffffc02010a0:	f2450513          	addi	a0,a0,-220 # ffffffffc020bfc0 <commands+0x828>
ffffffffc02010a4:	886ff0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02010a8:	10843783          	ld	a5,264(s0)
ffffffffc02010ac:	60a2                	ld	ra,8(sp)
ffffffffc02010ae:	0791                	addi	a5,a5,4
ffffffffc02010b0:	10f43423          	sd	a5,264(s0)
ffffffffc02010b4:	6402                	ld	s0,0(sp)
ffffffffc02010b6:	0141                	addi	sp,sp,16
ffffffffc02010b8:	6c00606f          	j	ffffffffc0207778 <syscall>
ffffffffc02010bc:	0000b517          	auipc	a0,0xb
ffffffffc02010c0:	f2450513          	addi	a0,a0,-220 # ffffffffc020bfe0 <commands+0x848>
ffffffffc02010c4:	6402                	ld	s0,0(sp)
ffffffffc02010c6:	60a2                	ld	ra,8(sp)
ffffffffc02010c8:	0141                	addi	sp,sp,16
ffffffffc02010ca:	860ff06f          	j	ffffffffc020012a <cprintf>
ffffffffc02010ce:	0000b517          	auipc	a0,0xb
ffffffffc02010d2:	f3250513          	addi	a0,a0,-206 # ffffffffc020c000 <commands+0x868>
ffffffffc02010d6:	b7fd                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc02010d8:	0000b517          	auipc	a0,0xb
ffffffffc02010dc:	f4850513          	addi	a0,a0,-184 # ffffffffc020c020 <commands+0x888>
ffffffffc02010e0:	b7d5                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc02010e2:	0000b517          	auipc	a0,0xb
ffffffffc02010e6:	f5650513          	addi	a0,a0,-170 # ffffffffc020c038 <commands+0x8a0>
ffffffffc02010ea:	bfe9                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc02010ec:	0000b517          	auipc	a0,0xb
ffffffffc02010f0:	f6450513          	addi	a0,a0,-156 # ffffffffc020c050 <commands+0x8b8>
ffffffffc02010f4:	bfc1                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc02010f6:	0000b517          	auipc	a0,0xb
ffffffffc02010fa:	de250513          	addi	a0,a0,-542 # ffffffffc020bed8 <commands+0x740>
ffffffffc02010fe:	b7d9                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc0201100:	0000b517          	auipc	a0,0xb
ffffffffc0201104:	df850513          	addi	a0,a0,-520 # ffffffffc020bef8 <commands+0x760>
ffffffffc0201108:	bf75                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc020110a:	0000b517          	auipc	a0,0xb
ffffffffc020110e:	e0e50513          	addi	a0,a0,-498 # ffffffffc020bf18 <commands+0x780>
ffffffffc0201112:	bf4d                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc0201114:	0000b517          	auipc	a0,0xb
ffffffffc0201118:	e1c50513          	addi	a0,a0,-484 # ffffffffc020bf30 <commands+0x798>
ffffffffc020111c:	b765                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc020111e:	0000b517          	auipc	a0,0xb
ffffffffc0201122:	e2250513          	addi	a0,a0,-478 # ffffffffc020bf40 <commands+0x7a8>
ffffffffc0201126:	bf79                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc0201128:	0000b517          	auipc	a0,0xb
ffffffffc020112c:	e3850513          	addi	a0,a0,-456 # ffffffffc020bf60 <commands+0x7c8>
ffffffffc0201130:	bf51                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc0201132:	0000b517          	auipc	a0,0xb
ffffffffc0201136:	e7650513          	addi	a0,a0,-394 # ffffffffc020bfa8 <commands+0x810>
ffffffffc020113a:	b769                	j	ffffffffc02010c4 <exception_handler+0x4c>
ffffffffc020113c:	8522                	mv	a0,s0
ffffffffc020113e:	6402                	ld	s0,0(sp)
ffffffffc0201140:	60a2                	ld	ra,8(sp)
ffffffffc0201142:	0141                	addi	sp,sp,16
ffffffffc0201144:	b5b9                	j	ffffffffc0200f92 <print_trapframe>
ffffffffc0201146:	0000b617          	auipc	a2,0xb
ffffffffc020114a:	e3260613          	addi	a2,a2,-462 # ffffffffc020bf78 <commands+0x7e0>
ffffffffc020114e:	0b100593          	li	a1,177
ffffffffc0201152:	0000b517          	auipc	a0,0xb
ffffffffc0201156:	e3e50513          	addi	a0,a0,-450 # ffffffffc020bf90 <commands+0x7f8>
ffffffffc020115a:	8d4ff0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020115e <trap>:
ffffffffc020115e:	1101                	addi	sp,sp,-32
ffffffffc0201160:	e822                	sd	s0,16(sp)
ffffffffc0201162:	00095417          	auipc	s0,0x95
ffffffffc0201166:	75e40413          	addi	s0,s0,1886 # ffffffffc02968c0 <current>
ffffffffc020116a:	6018                	ld	a4,0(s0)
ffffffffc020116c:	ec06                	sd	ra,24(sp)
ffffffffc020116e:	e426                	sd	s1,8(sp)
ffffffffc0201170:	e04a                	sd	s2,0(sp)
ffffffffc0201172:	11853683          	ld	a3,280(a0)
ffffffffc0201176:	cf1d                	beqz	a4,ffffffffc02011b4 <trap+0x56>
ffffffffc0201178:	10053483          	ld	s1,256(a0)
ffffffffc020117c:	0a073903          	ld	s2,160(a4)
ffffffffc0201180:	f348                	sd	a0,160(a4)
ffffffffc0201182:	1004f493          	andi	s1,s1,256
ffffffffc0201186:	0206c463          	bltz	a3,ffffffffc02011ae <trap+0x50>
ffffffffc020118a:	eefff0ef          	jal	ra,ffffffffc0201078 <exception_handler>
ffffffffc020118e:	601c                	ld	a5,0(s0)
ffffffffc0201190:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc0201194:	e499                	bnez	s1,ffffffffc02011a2 <trap+0x44>
ffffffffc0201196:	0b07a703          	lw	a4,176(a5)
ffffffffc020119a:	8b05                	andi	a4,a4,1
ffffffffc020119c:	e329                	bnez	a4,ffffffffc02011de <trap+0x80>
ffffffffc020119e:	6f9c                	ld	a5,24(a5)
ffffffffc02011a0:	eb85                	bnez	a5,ffffffffc02011d0 <trap+0x72>
ffffffffc02011a2:	60e2                	ld	ra,24(sp)
ffffffffc02011a4:	6442                	ld	s0,16(sp)
ffffffffc02011a6:	64a2                	ld	s1,8(sp)
ffffffffc02011a8:	6902                	ld	s2,0(sp)
ffffffffc02011aa:	6105                	addi	sp,sp,32
ffffffffc02011ac:	8082                	ret
ffffffffc02011ae:	e47ff0ef          	jal	ra,ffffffffc0200ff4 <interrupt_handler>
ffffffffc02011b2:	bff1                	j	ffffffffc020118e <trap+0x30>
ffffffffc02011b4:	0006c863          	bltz	a3,ffffffffc02011c4 <trap+0x66>
ffffffffc02011b8:	6442                	ld	s0,16(sp)
ffffffffc02011ba:	60e2                	ld	ra,24(sp)
ffffffffc02011bc:	64a2                	ld	s1,8(sp)
ffffffffc02011be:	6902                	ld	s2,0(sp)
ffffffffc02011c0:	6105                	addi	sp,sp,32
ffffffffc02011c2:	bd5d                	j	ffffffffc0201078 <exception_handler>
ffffffffc02011c4:	6442                	ld	s0,16(sp)
ffffffffc02011c6:	60e2                	ld	ra,24(sp)
ffffffffc02011c8:	64a2                	ld	s1,8(sp)
ffffffffc02011ca:	6902                	ld	s2,0(sp)
ffffffffc02011cc:	6105                	addi	sp,sp,32
ffffffffc02011ce:	b51d                	j	ffffffffc0200ff4 <interrupt_handler>
ffffffffc02011d0:	6442                	ld	s0,16(sp)
ffffffffc02011d2:	60e2                	ld	ra,24(sp)
ffffffffc02011d4:	64a2                	ld	s1,8(sp)
ffffffffc02011d6:	6902                	ld	s2,0(sp)
ffffffffc02011d8:	6105                	addi	sp,sp,32
ffffffffc02011da:	0940606f          	j	ffffffffc020726e <schedule>
ffffffffc02011de:	555d                	li	a0,-9
ffffffffc02011e0:	6ab040ef          	jal	ra,ffffffffc020608a <do_exit>
ffffffffc02011e4:	601c                	ld	a5,0(s0)
ffffffffc02011e6:	bf65                	j	ffffffffc020119e <trap+0x40>

ffffffffc02011e8 <__alltraps>:
ffffffffc02011e8:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011ec:	00011463          	bnez	sp,ffffffffc02011f4 <__alltraps+0xc>
ffffffffc02011f0:	14002173          	csrr	sp,sscratch
ffffffffc02011f4:	712d                	addi	sp,sp,-288
ffffffffc02011f6:	e002                	sd	zero,0(sp)
ffffffffc02011f8:	e406                	sd	ra,8(sp)
ffffffffc02011fa:	ec0e                	sd	gp,24(sp)
ffffffffc02011fc:	f012                	sd	tp,32(sp)
ffffffffc02011fe:	f416                	sd	t0,40(sp)
ffffffffc0201200:	f81a                	sd	t1,48(sp)
ffffffffc0201202:	fc1e                	sd	t2,56(sp)
ffffffffc0201204:	e0a2                	sd	s0,64(sp)
ffffffffc0201206:	e4a6                	sd	s1,72(sp)
ffffffffc0201208:	e8aa                	sd	a0,80(sp)
ffffffffc020120a:	ecae                	sd	a1,88(sp)
ffffffffc020120c:	f0b2                	sd	a2,96(sp)
ffffffffc020120e:	f4b6                	sd	a3,104(sp)
ffffffffc0201210:	f8ba                	sd	a4,112(sp)
ffffffffc0201212:	fcbe                	sd	a5,120(sp)
ffffffffc0201214:	e142                	sd	a6,128(sp)
ffffffffc0201216:	e546                	sd	a7,136(sp)
ffffffffc0201218:	e94a                	sd	s2,144(sp)
ffffffffc020121a:	ed4e                	sd	s3,152(sp)
ffffffffc020121c:	f152                	sd	s4,160(sp)
ffffffffc020121e:	f556                	sd	s5,168(sp)
ffffffffc0201220:	f95a                	sd	s6,176(sp)
ffffffffc0201222:	fd5e                	sd	s7,184(sp)
ffffffffc0201224:	e1e2                	sd	s8,192(sp)
ffffffffc0201226:	e5e6                	sd	s9,200(sp)
ffffffffc0201228:	e9ea                	sd	s10,208(sp)
ffffffffc020122a:	edee                	sd	s11,216(sp)
ffffffffc020122c:	f1f2                	sd	t3,224(sp)
ffffffffc020122e:	f5f6                	sd	t4,232(sp)
ffffffffc0201230:	f9fa                	sd	t5,240(sp)
ffffffffc0201232:	fdfe                	sd	t6,248(sp)
ffffffffc0201234:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201238:	100024f3          	csrr	s1,sstatus
ffffffffc020123c:	14102973          	csrr	s2,sepc
ffffffffc0201240:	143029f3          	csrr	s3,stval
ffffffffc0201244:	14202a73          	csrr	s4,scause
ffffffffc0201248:	e822                	sd	s0,16(sp)
ffffffffc020124a:	e226                	sd	s1,256(sp)
ffffffffc020124c:	e64a                	sd	s2,264(sp)
ffffffffc020124e:	ea4e                	sd	s3,272(sp)
ffffffffc0201250:	ee52                	sd	s4,280(sp)
ffffffffc0201252:	850a                	mv	a0,sp
ffffffffc0201254:	f0bff0ef          	jal	ra,ffffffffc020115e <trap>

ffffffffc0201258 <__trapret>:
ffffffffc0201258:	6492                	ld	s1,256(sp)
ffffffffc020125a:	6932                	ld	s2,264(sp)
ffffffffc020125c:	1004f413          	andi	s0,s1,256
ffffffffc0201260:	e401                	bnez	s0,ffffffffc0201268 <__trapret+0x10>
ffffffffc0201262:	1200                	addi	s0,sp,288
ffffffffc0201264:	14041073          	csrw	sscratch,s0
ffffffffc0201268:	10049073          	csrw	sstatus,s1
ffffffffc020126c:	14191073          	csrw	sepc,s2
ffffffffc0201270:	60a2                	ld	ra,8(sp)
ffffffffc0201272:	61e2                	ld	gp,24(sp)
ffffffffc0201274:	7202                	ld	tp,32(sp)
ffffffffc0201276:	72a2                	ld	t0,40(sp)
ffffffffc0201278:	7342                	ld	t1,48(sp)
ffffffffc020127a:	73e2                	ld	t2,56(sp)
ffffffffc020127c:	6406                	ld	s0,64(sp)
ffffffffc020127e:	64a6                	ld	s1,72(sp)
ffffffffc0201280:	6546                	ld	a0,80(sp)
ffffffffc0201282:	65e6                	ld	a1,88(sp)
ffffffffc0201284:	7606                	ld	a2,96(sp)
ffffffffc0201286:	76a6                	ld	a3,104(sp)
ffffffffc0201288:	7746                	ld	a4,112(sp)
ffffffffc020128a:	77e6                	ld	a5,120(sp)
ffffffffc020128c:	680a                	ld	a6,128(sp)
ffffffffc020128e:	68aa                	ld	a7,136(sp)
ffffffffc0201290:	694a                	ld	s2,144(sp)
ffffffffc0201292:	69ea                	ld	s3,152(sp)
ffffffffc0201294:	7a0a                	ld	s4,160(sp)
ffffffffc0201296:	7aaa                	ld	s5,168(sp)
ffffffffc0201298:	7b4a                	ld	s6,176(sp)
ffffffffc020129a:	7bea                	ld	s7,184(sp)
ffffffffc020129c:	6c0e                	ld	s8,192(sp)
ffffffffc020129e:	6cae                	ld	s9,200(sp)
ffffffffc02012a0:	6d4e                	ld	s10,208(sp)
ffffffffc02012a2:	6dee                	ld	s11,216(sp)
ffffffffc02012a4:	7e0e                	ld	t3,224(sp)
ffffffffc02012a6:	7eae                	ld	t4,232(sp)
ffffffffc02012a8:	7f4e                	ld	t5,240(sp)
ffffffffc02012aa:	7fee                	ld	t6,248(sp)
ffffffffc02012ac:	6142                	ld	sp,16(sp)
ffffffffc02012ae:	10200073          	sret

ffffffffc02012b2 <forkrets>:
ffffffffc02012b2:	812a                	mv	sp,a0
ffffffffc02012b4:	b755                	j	ffffffffc0201258 <__trapret>

ffffffffc02012b6 <check_vma_overlap.part.0>:
ffffffffc02012b6:	1141                	addi	sp,sp,-16
ffffffffc02012b8:	0000b697          	auipc	a3,0xb
ffffffffc02012bc:	df068693          	addi	a3,a3,-528 # ffffffffc020c0a8 <commands+0x910>
ffffffffc02012c0:	0000a617          	auipc	a2,0xa
ffffffffc02012c4:	53860613          	addi	a2,a2,1336 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02012c8:	07400593          	li	a1,116
ffffffffc02012cc:	0000b517          	auipc	a0,0xb
ffffffffc02012d0:	dfc50513          	addi	a0,a0,-516 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02012d4:	e406                	sd	ra,8(sp)
ffffffffc02012d6:	f59fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02012da <mm_create>:
ffffffffc02012da:	1141                	addi	sp,sp,-16
ffffffffc02012dc:	05800513          	li	a0,88
ffffffffc02012e0:	e022                	sd	s0,0(sp)
ffffffffc02012e2:	e406                	sd	ra,8(sp)
ffffffffc02012e4:	233000ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02012e8:	842a                	mv	s0,a0
ffffffffc02012ea:	c115                	beqz	a0,ffffffffc020130e <mm_create+0x34>
ffffffffc02012ec:	e408                	sd	a0,8(s0)
ffffffffc02012ee:	e008                	sd	a0,0(s0)
ffffffffc02012f0:	00053823          	sd	zero,16(a0)
ffffffffc02012f4:	00053c23          	sd	zero,24(a0)
ffffffffc02012f8:	02052023          	sw	zero,32(a0)
ffffffffc02012fc:	02053423          	sd	zero,40(a0)
ffffffffc0201300:	02052823          	sw	zero,48(a0)
ffffffffc0201304:	4585                	li	a1,1
ffffffffc0201306:	03850513          	addi	a0,a0,56
ffffffffc020130a:	434030ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc020130e:	60a2                	ld	ra,8(sp)
ffffffffc0201310:	8522                	mv	a0,s0
ffffffffc0201312:	6402                	ld	s0,0(sp)
ffffffffc0201314:	0141                	addi	sp,sp,16
ffffffffc0201316:	8082                	ret

ffffffffc0201318 <find_vma>:
ffffffffc0201318:	86aa                	mv	a3,a0
ffffffffc020131a:	c505                	beqz	a0,ffffffffc0201342 <find_vma+0x2a>
ffffffffc020131c:	6908                	ld	a0,16(a0)
ffffffffc020131e:	c501                	beqz	a0,ffffffffc0201326 <find_vma+0xe>
ffffffffc0201320:	651c                	ld	a5,8(a0)
ffffffffc0201322:	02f5f263          	bgeu	a1,a5,ffffffffc0201346 <find_vma+0x2e>
ffffffffc0201326:	669c                	ld	a5,8(a3)
ffffffffc0201328:	00f68d63          	beq	a3,a5,ffffffffc0201342 <find_vma+0x2a>
ffffffffc020132c:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201330:	00e5e663          	bltu	a1,a4,ffffffffc020133c <find_vma+0x24>
ffffffffc0201334:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201338:	00e5ec63          	bltu	a1,a4,ffffffffc0201350 <find_vma+0x38>
ffffffffc020133c:	679c                	ld	a5,8(a5)
ffffffffc020133e:	fef697e3          	bne	a3,a5,ffffffffc020132c <find_vma+0x14>
ffffffffc0201342:	4501                	li	a0,0
ffffffffc0201344:	8082                	ret
ffffffffc0201346:	691c                	ld	a5,16(a0)
ffffffffc0201348:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201326 <find_vma+0xe>
ffffffffc020134c:	ea88                	sd	a0,16(a3)
ffffffffc020134e:	8082                	ret
ffffffffc0201350:	fe078513          	addi	a0,a5,-32
ffffffffc0201354:	ea88                	sd	a0,16(a3)
ffffffffc0201356:	8082                	ret

ffffffffc0201358 <insert_vma_struct>:
ffffffffc0201358:	6590                	ld	a2,8(a1)
ffffffffc020135a:	0105b803          	ld	a6,16(a1)
ffffffffc020135e:	1141                	addi	sp,sp,-16
ffffffffc0201360:	e406                	sd	ra,8(sp)
ffffffffc0201362:	87aa                	mv	a5,a0
ffffffffc0201364:	01066763          	bltu	a2,a6,ffffffffc0201372 <insert_vma_struct+0x1a>
ffffffffc0201368:	a085                	j	ffffffffc02013c8 <insert_vma_struct+0x70>
ffffffffc020136a:	fe87b703          	ld	a4,-24(a5)
ffffffffc020136e:	04e66863          	bltu	a2,a4,ffffffffc02013be <insert_vma_struct+0x66>
ffffffffc0201372:	86be                	mv	a3,a5
ffffffffc0201374:	679c                	ld	a5,8(a5)
ffffffffc0201376:	fef51ae3          	bne	a0,a5,ffffffffc020136a <insert_vma_struct+0x12>
ffffffffc020137a:	02a68463          	beq	a3,a0,ffffffffc02013a2 <insert_vma_struct+0x4a>
ffffffffc020137e:	ff06b703          	ld	a4,-16(a3)
ffffffffc0201382:	fe86b883          	ld	a7,-24(a3)
ffffffffc0201386:	08e8f163          	bgeu	a7,a4,ffffffffc0201408 <insert_vma_struct+0xb0>
ffffffffc020138a:	04e66f63          	bltu	a2,a4,ffffffffc02013e8 <insert_vma_struct+0x90>
ffffffffc020138e:	00f50a63          	beq	a0,a5,ffffffffc02013a2 <insert_vma_struct+0x4a>
ffffffffc0201392:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201396:	05076963          	bltu	a4,a6,ffffffffc02013e8 <insert_vma_struct+0x90>
ffffffffc020139a:	ff07b603          	ld	a2,-16(a5)
ffffffffc020139e:	02c77363          	bgeu	a4,a2,ffffffffc02013c4 <insert_vma_struct+0x6c>
ffffffffc02013a2:	5118                	lw	a4,32(a0)
ffffffffc02013a4:	e188                	sd	a0,0(a1)
ffffffffc02013a6:	02058613          	addi	a2,a1,32
ffffffffc02013aa:	e390                	sd	a2,0(a5)
ffffffffc02013ac:	e690                	sd	a2,8(a3)
ffffffffc02013ae:	60a2                	ld	ra,8(sp)
ffffffffc02013b0:	f59c                	sd	a5,40(a1)
ffffffffc02013b2:	f194                	sd	a3,32(a1)
ffffffffc02013b4:	0017079b          	addiw	a5,a4,1
ffffffffc02013b8:	d11c                	sw	a5,32(a0)
ffffffffc02013ba:	0141                	addi	sp,sp,16
ffffffffc02013bc:	8082                	ret
ffffffffc02013be:	fca690e3          	bne	a3,a0,ffffffffc020137e <insert_vma_struct+0x26>
ffffffffc02013c2:	bfd1                	j	ffffffffc0201396 <insert_vma_struct+0x3e>
ffffffffc02013c4:	ef3ff0ef          	jal	ra,ffffffffc02012b6 <check_vma_overlap.part.0>
ffffffffc02013c8:	0000b697          	auipc	a3,0xb
ffffffffc02013cc:	d1068693          	addi	a3,a3,-752 # ffffffffc020c0d8 <commands+0x940>
ffffffffc02013d0:	0000a617          	auipc	a2,0xa
ffffffffc02013d4:	42860613          	addi	a2,a2,1064 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02013d8:	07a00593          	li	a1,122
ffffffffc02013dc:	0000b517          	auipc	a0,0xb
ffffffffc02013e0:	cec50513          	addi	a0,a0,-788 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02013e4:	e4bfe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02013e8:	0000b697          	auipc	a3,0xb
ffffffffc02013ec:	d3068693          	addi	a3,a3,-720 # ffffffffc020c118 <commands+0x980>
ffffffffc02013f0:	0000a617          	auipc	a2,0xa
ffffffffc02013f4:	40860613          	addi	a2,a2,1032 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02013f8:	07300593          	li	a1,115
ffffffffc02013fc:	0000b517          	auipc	a0,0xb
ffffffffc0201400:	ccc50513          	addi	a0,a0,-820 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201404:	e2bfe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201408:	0000b697          	auipc	a3,0xb
ffffffffc020140c:	cf068693          	addi	a3,a3,-784 # ffffffffc020c0f8 <commands+0x960>
ffffffffc0201410:	0000a617          	auipc	a2,0xa
ffffffffc0201414:	3e860613          	addi	a2,a2,1000 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201418:	07200593          	li	a1,114
ffffffffc020141c:	0000b517          	auipc	a0,0xb
ffffffffc0201420:	cac50513          	addi	a0,a0,-852 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201424:	e0bfe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0201428 <mm_destroy>:
ffffffffc0201428:	591c                	lw	a5,48(a0)
ffffffffc020142a:	1141                	addi	sp,sp,-16
ffffffffc020142c:	e406                	sd	ra,8(sp)
ffffffffc020142e:	e022                	sd	s0,0(sp)
ffffffffc0201430:	e78d                	bnez	a5,ffffffffc020145a <mm_destroy+0x32>
ffffffffc0201432:	842a                	mv	s0,a0
ffffffffc0201434:	6508                	ld	a0,8(a0)
ffffffffc0201436:	00a40c63          	beq	s0,a0,ffffffffc020144e <mm_destroy+0x26>
ffffffffc020143a:	6118                	ld	a4,0(a0)
ffffffffc020143c:	651c                	ld	a5,8(a0)
ffffffffc020143e:	1501                	addi	a0,a0,-32
ffffffffc0201440:	e71c                	sd	a5,8(a4)
ffffffffc0201442:	e398                	sd	a4,0(a5)
ffffffffc0201444:	183000ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0201448:	6408                	ld	a0,8(s0)
ffffffffc020144a:	fea418e3          	bne	s0,a0,ffffffffc020143a <mm_destroy+0x12>
ffffffffc020144e:	8522                	mv	a0,s0
ffffffffc0201450:	6402                	ld	s0,0(sp)
ffffffffc0201452:	60a2                	ld	ra,8(sp)
ffffffffc0201454:	0141                	addi	sp,sp,16
ffffffffc0201456:	1710006f          	j	ffffffffc0201dc6 <kfree>
ffffffffc020145a:	0000b697          	auipc	a3,0xb
ffffffffc020145e:	cde68693          	addi	a3,a3,-802 # ffffffffc020c138 <commands+0x9a0>
ffffffffc0201462:	0000a617          	auipc	a2,0xa
ffffffffc0201466:	39660613          	addi	a2,a2,918 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020146a:	09e00593          	li	a1,158
ffffffffc020146e:	0000b517          	auipc	a0,0xb
ffffffffc0201472:	c5a50513          	addi	a0,a0,-934 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201476:	db9fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020147a <mm_map>:
ffffffffc020147a:	7139                	addi	sp,sp,-64
ffffffffc020147c:	f822                	sd	s0,48(sp)
ffffffffc020147e:	6405                	lui	s0,0x1
ffffffffc0201480:	147d                	addi	s0,s0,-1
ffffffffc0201482:	77fd                	lui	a5,0xfffff
ffffffffc0201484:	9622                	add	a2,a2,s0
ffffffffc0201486:	962e                	add	a2,a2,a1
ffffffffc0201488:	f426                	sd	s1,40(sp)
ffffffffc020148a:	fc06                	sd	ra,56(sp)
ffffffffc020148c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0201490:	f04a                	sd	s2,32(sp)
ffffffffc0201492:	ec4e                	sd	s3,24(sp)
ffffffffc0201494:	e852                	sd	s4,16(sp)
ffffffffc0201496:	e456                	sd	s5,8(sp)
ffffffffc0201498:	002005b7          	lui	a1,0x200
ffffffffc020149c:	00f67433          	and	s0,a2,a5
ffffffffc02014a0:	06b4e363          	bltu	s1,a1,ffffffffc0201506 <mm_map+0x8c>
ffffffffc02014a4:	0684f163          	bgeu	s1,s0,ffffffffc0201506 <mm_map+0x8c>
ffffffffc02014a8:	4785                	li	a5,1
ffffffffc02014aa:	07fe                	slli	a5,a5,0x1f
ffffffffc02014ac:	0487ed63          	bltu	a5,s0,ffffffffc0201506 <mm_map+0x8c>
ffffffffc02014b0:	89aa                	mv	s3,a0
ffffffffc02014b2:	cd21                	beqz	a0,ffffffffc020150a <mm_map+0x90>
ffffffffc02014b4:	85a6                	mv	a1,s1
ffffffffc02014b6:	8ab6                	mv	s5,a3
ffffffffc02014b8:	8a3a                	mv	s4,a4
ffffffffc02014ba:	e5fff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc02014be:	c501                	beqz	a0,ffffffffc02014c6 <mm_map+0x4c>
ffffffffc02014c0:	651c                	ld	a5,8(a0)
ffffffffc02014c2:	0487e263          	bltu	a5,s0,ffffffffc0201506 <mm_map+0x8c>
ffffffffc02014c6:	03000513          	li	a0,48
ffffffffc02014ca:	04d000ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02014ce:	892a                	mv	s2,a0
ffffffffc02014d0:	5571                	li	a0,-4
ffffffffc02014d2:	02090163          	beqz	s2,ffffffffc02014f4 <mm_map+0x7a>
ffffffffc02014d6:	854e                	mv	a0,s3
ffffffffc02014d8:	00993423          	sd	s1,8(s2)
ffffffffc02014dc:	00893823          	sd	s0,16(s2)
ffffffffc02014e0:	01592c23          	sw	s5,24(s2)
ffffffffc02014e4:	85ca                	mv	a1,s2
ffffffffc02014e6:	e73ff0ef          	jal	ra,ffffffffc0201358 <insert_vma_struct>
ffffffffc02014ea:	4501                	li	a0,0
ffffffffc02014ec:	000a0463          	beqz	s4,ffffffffc02014f4 <mm_map+0x7a>
ffffffffc02014f0:	012a3023          	sd	s2,0(s4)
ffffffffc02014f4:	70e2                	ld	ra,56(sp)
ffffffffc02014f6:	7442                	ld	s0,48(sp)
ffffffffc02014f8:	74a2                	ld	s1,40(sp)
ffffffffc02014fa:	7902                	ld	s2,32(sp)
ffffffffc02014fc:	69e2                	ld	s3,24(sp)
ffffffffc02014fe:	6a42                	ld	s4,16(sp)
ffffffffc0201500:	6aa2                	ld	s5,8(sp)
ffffffffc0201502:	6121                	addi	sp,sp,64
ffffffffc0201504:	8082                	ret
ffffffffc0201506:	5575                	li	a0,-3
ffffffffc0201508:	b7f5                	j	ffffffffc02014f4 <mm_map+0x7a>
ffffffffc020150a:	0000b697          	auipc	a3,0xb
ffffffffc020150e:	c4668693          	addi	a3,a3,-954 # ffffffffc020c150 <commands+0x9b8>
ffffffffc0201512:	0000a617          	auipc	a2,0xa
ffffffffc0201516:	2e660613          	addi	a2,a2,742 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020151a:	0b300593          	li	a1,179
ffffffffc020151e:	0000b517          	auipc	a0,0xb
ffffffffc0201522:	baa50513          	addi	a0,a0,-1110 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201526:	d09fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020152a <dup_mmap>:
ffffffffc020152a:	7139                	addi	sp,sp,-64
ffffffffc020152c:	fc06                	sd	ra,56(sp)
ffffffffc020152e:	f822                	sd	s0,48(sp)
ffffffffc0201530:	f426                	sd	s1,40(sp)
ffffffffc0201532:	f04a                	sd	s2,32(sp)
ffffffffc0201534:	ec4e                	sd	s3,24(sp)
ffffffffc0201536:	e852                	sd	s4,16(sp)
ffffffffc0201538:	e456                	sd	s5,8(sp)
ffffffffc020153a:	c52d                	beqz	a0,ffffffffc02015a4 <dup_mmap+0x7a>
ffffffffc020153c:	892a                	mv	s2,a0
ffffffffc020153e:	84ae                	mv	s1,a1
ffffffffc0201540:	842e                	mv	s0,a1
ffffffffc0201542:	e595                	bnez	a1,ffffffffc020156e <dup_mmap+0x44>
ffffffffc0201544:	a085                	j	ffffffffc02015a4 <dup_mmap+0x7a>
ffffffffc0201546:	854a                	mv	a0,s2
ffffffffc0201548:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc020154c:	0145b823          	sd	s4,16(a1)
ffffffffc0201550:	0135ac23          	sw	s3,24(a1)
ffffffffc0201554:	e05ff0ef          	jal	ra,ffffffffc0201358 <insert_vma_struct>
ffffffffc0201558:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc020155c:	fe843603          	ld	a2,-24(s0)
ffffffffc0201560:	6c8c                	ld	a1,24(s1)
ffffffffc0201562:	01893503          	ld	a0,24(s2)
ffffffffc0201566:	4701                	li	a4,0
ffffffffc0201568:	391020ef          	jal	ra,ffffffffc02040f8 <copy_range>
ffffffffc020156c:	e105                	bnez	a0,ffffffffc020158c <dup_mmap+0x62>
ffffffffc020156e:	6000                	ld	s0,0(s0)
ffffffffc0201570:	02848863          	beq	s1,s0,ffffffffc02015a0 <dup_mmap+0x76>
ffffffffc0201574:	03000513          	li	a0,48
ffffffffc0201578:	fe843a83          	ld	s5,-24(s0)
ffffffffc020157c:	ff043a03          	ld	s4,-16(s0)
ffffffffc0201580:	ff842983          	lw	s3,-8(s0)
ffffffffc0201584:	792000ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0201588:	85aa                	mv	a1,a0
ffffffffc020158a:	fd55                	bnez	a0,ffffffffc0201546 <dup_mmap+0x1c>
ffffffffc020158c:	5571                	li	a0,-4
ffffffffc020158e:	70e2                	ld	ra,56(sp)
ffffffffc0201590:	7442                	ld	s0,48(sp)
ffffffffc0201592:	74a2                	ld	s1,40(sp)
ffffffffc0201594:	7902                	ld	s2,32(sp)
ffffffffc0201596:	69e2                	ld	s3,24(sp)
ffffffffc0201598:	6a42                	ld	s4,16(sp)
ffffffffc020159a:	6aa2                	ld	s5,8(sp)
ffffffffc020159c:	6121                	addi	sp,sp,64
ffffffffc020159e:	8082                	ret
ffffffffc02015a0:	4501                	li	a0,0
ffffffffc02015a2:	b7f5                	j	ffffffffc020158e <dup_mmap+0x64>
ffffffffc02015a4:	0000b697          	auipc	a3,0xb
ffffffffc02015a8:	bbc68693          	addi	a3,a3,-1092 # ffffffffc020c160 <commands+0x9c8>
ffffffffc02015ac:	0000a617          	auipc	a2,0xa
ffffffffc02015b0:	24c60613          	addi	a2,a2,588 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02015b4:	0cf00593          	li	a1,207
ffffffffc02015b8:	0000b517          	auipc	a0,0xb
ffffffffc02015bc:	b1050513          	addi	a0,a0,-1264 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02015c0:	c6ffe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02015c4 <exit_mmap>:
ffffffffc02015c4:	1101                	addi	sp,sp,-32
ffffffffc02015c6:	ec06                	sd	ra,24(sp)
ffffffffc02015c8:	e822                	sd	s0,16(sp)
ffffffffc02015ca:	e426                	sd	s1,8(sp)
ffffffffc02015cc:	e04a                	sd	s2,0(sp)
ffffffffc02015ce:	c531                	beqz	a0,ffffffffc020161a <exit_mmap+0x56>
ffffffffc02015d0:	591c                	lw	a5,48(a0)
ffffffffc02015d2:	84aa                	mv	s1,a0
ffffffffc02015d4:	e3b9                	bnez	a5,ffffffffc020161a <exit_mmap+0x56>
ffffffffc02015d6:	6500                	ld	s0,8(a0)
ffffffffc02015d8:	01853903          	ld	s2,24(a0)
ffffffffc02015dc:	02850663          	beq	a0,s0,ffffffffc0201608 <exit_mmap+0x44>
ffffffffc02015e0:	ff043603          	ld	a2,-16(s0)
ffffffffc02015e4:	fe843583          	ld	a1,-24(s0)
ffffffffc02015e8:	854a                	mv	a0,s2
ffffffffc02015ea:	7b2010ef          	jal	ra,ffffffffc0202d9c <unmap_range>
ffffffffc02015ee:	6400                	ld	s0,8(s0)
ffffffffc02015f0:	fe8498e3          	bne	s1,s0,ffffffffc02015e0 <exit_mmap+0x1c>
ffffffffc02015f4:	6400                	ld	s0,8(s0)
ffffffffc02015f6:	00848c63          	beq	s1,s0,ffffffffc020160e <exit_mmap+0x4a>
ffffffffc02015fa:	ff043603          	ld	a2,-16(s0)
ffffffffc02015fe:	fe843583          	ld	a1,-24(s0)
ffffffffc0201602:	854a                	mv	a0,s2
ffffffffc0201604:	0df010ef          	jal	ra,ffffffffc0202ee2 <exit_range>
ffffffffc0201608:	6400                	ld	s0,8(s0)
ffffffffc020160a:	fe8498e3          	bne	s1,s0,ffffffffc02015fa <exit_mmap+0x36>
ffffffffc020160e:	60e2                	ld	ra,24(sp)
ffffffffc0201610:	6442                	ld	s0,16(sp)
ffffffffc0201612:	64a2                	ld	s1,8(sp)
ffffffffc0201614:	6902                	ld	s2,0(sp)
ffffffffc0201616:	6105                	addi	sp,sp,32
ffffffffc0201618:	8082                	ret
ffffffffc020161a:	0000b697          	auipc	a3,0xb
ffffffffc020161e:	b6668693          	addi	a3,a3,-1178 # ffffffffc020c180 <commands+0x9e8>
ffffffffc0201622:	0000a617          	auipc	a2,0xa
ffffffffc0201626:	1d660613          	addi	a2,a2,470 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020162a:	0e800593          	li	a1,232
ffffffffc020162e:	0000b517          	auipc	a0,0xb
ffffffffc0201632:	a9a50513          	addi	a0,a0,-1382 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201636:	bf9fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020163a <vmm_init>:
ffffffffc020163a:	7139                	addi	sp,sp,-64
ffffffffc020163c:	05800513          	li	a0,88
ffffffffc0201640:	fc06                	sd	ra,56(sp)
ffffffffc0201642:	f822                	sd	s0,48(sp)
ffffffffc0201644:	f426                	sd	s1,40(sp)
ffffffffc0201646:	f04a                	sd	s2,32(sp)
ffffffffc0201648:	ec4e                	sd	s3,24(sp)
ffffffffc020164a:	e852                	sd	s4,16(sp)
ffffffffc020164c:	e456                	sd	s5,8(sp)
ffffffffc020164e:	6c8000ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0201652:	2e050963          	beqz	a0,ffffffffc0201944 <vmm_init+0x30a>
ffffffffc0201656:	e508                	sd	a0,8(a0)
ffffffffc0201658:	e108                	sd	a0,0(a0)
ffffffffc020165a:	00053823          	sd	zero,16(a0)
ffffffffc020165e:	00053c23          	sd	zero,24(a0)
ffffffffc0201662:	02052023          	sw	zero,32(a0)
ffffffffc0201666:	02053423          	sd	zero,40(a0)
ffffffffc020166a:	02052823          	sw	zero,48(a0)
ffffffffc020166e:	84aa                	mv	s1,a0
ffffffffc0201670:	4585                	li	a1,1
ffffffffc0201672:	03850513          	addi	a0,a0,56
ffffffffc0201676:	0c8030ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc020167a:	03200413          	li	s0,50
ffffffffc020167e:	a811                	j	ffffffffc0201692 <vmm_init+0x58>
ffffffffc0201680:	e500                	sd	s0,8(a0)
ffffffffc0201682:	e91c                	sd	a5,16(a0)
ffffffffc0201684:	00052c23          	sw	zero,24(a0)
ffffffffc0201688:	146d                	addi	s0,s0,-5
ffffffffc020168a:	8526                	mv	a0,s1
ffffffffc020168c:	ccdff0ef          	jal	ra,ffffffffc0201358 <insert_vma_struct>
ffffffffc0201690:	c80d                	beqz	s0,ffffffffc02016c2 <vmm_init+0x88>
ffffffffc0201692:	03000513          	li	a0,48
ffffffffc0201696:	680000ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020169a:	85aa                	mv	a1,a0
ffffffffc020169c:	00240793          	addi	a5,s0,2
ffffffffc02016a0:	f165                	bnez	a0,ffffffffc0201680 <vmm_init+0x46>
ffffffffc02016a2:	0000b697          	auipc	a3,0xb
ffffffffc02016a6:	c7668693          	addi	a3,a3,-906 # ffffffffc020c318 <commands+0xb80>
ffffffffc02016aa:	0000a617          	auipc	a2,0xa
ffffffffc02016ae:	14e60613          	addi	a2,a2,334 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02016b2:	12c00593          	li	a1,300
ffffffffc02016b6:	0000b517          	auipc	a0,0xb
ffffffffc02016ba:	a1250513          	addi	a0,a0,-1518 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02016be:	b71fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02016c2:	03700413          	li	s0,55
ffffffffc02016c6:	1f900913          	li	s2,505
ffffffffc02016ca:	a819                	j	ffffffffc02016e0 <vmm_init+0xa6>
ffffffffc02016cc:	e500                	sd	s0,8(a0)
ffffffffc02016ce:	e91c                	sd	a5,16(a0)
ffffffffc02016d0:	00052c23          	sw	zero,24(a0)
ffffffffc02016d4:	0415                	addi	s0,s0,5
ffffffffc02016d6:	8526                	mv	a0,s1
ffffffffc02016d8:	c81ff0ef          	jal	ra,ffffffffc0201358 <insert_vma_struct>
ffffffffc02016dc:	03240a63          	beq	s0,s2,ffffffffc0201710 <vmm_init+0xd6>
ffffffffc02016e0:	03000513          	li	a0,48
ffffffffc02016e4:	632000ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02016e8:	85aa                	mv	a1,a0
ffffffffc02016ea:	00240793          	addi	a5,s0,2
ffffffffc02016ee:	fd79                	bnez	a0,ffffffffc02016cc <vmm_init+0x92>
ffffffffc02016f0:	0000b697          	auipc	a3,0xb
ffffffffc02016f4:	c2868693          	addi	a3,a3,-984 # ffffffffc020c318 <commands+0xb80>
ffffffffc02016f8:	0000a617          	auipc	a2,0xa
ffffffffc02016fc:	10060613          	addi	a2,a2,256 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201700:	13300593          	li	a1,307
ffffffffc0201704:	0000b517          	auipc	a0,0xb
ffffffffc0201708:	9c450513          	addi	a0,a0,-1596 # ffffffffc020c0c8 <commands+0x930>
ffffffffc020170c:	b23fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201710:	649c                	ld	a5,8(s1)
ffffffffc0201712:	471d                	li	a4,7
ffffffffc0201714:	1fb00593          	li	a1,507
ffffffffc0201718:	16f48663          	beq	s1,a5,ffffffffc0201884 <vmm_init+0x24a>
ffffffffc020171c:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc0201720:	ffe70693          	addi	a3,a4,-2
ffffffffc0201724:	10d61063          	bne	a2,a3,ffffffffc0201824 <vmm_init+0x1ea>
ffffffffc0201728:	ff07b683          	ld	a3,-16(a5)
ffffffffc020172c:	0ed71c63          	bne	a4,a3,ffffffffc0201824 <vmm_init+0x1ea>
ffffffffc0201730:	0715                	addi	a4,a4,5
ffffffffc0201732:	679c                	ld	a5,8(a5)
ffffffffc0201734:	feb712e3          	bne	a4,a1,ffffffffc0201718 <vmm_init+0xde>
ffffffffc0201738:	4a1d                	li	s4,7
ffffffffc020173a:	4415                	li	s0,5
ffffffffc020173c:	1f900a93          	li	s5,505
ffffffffc0201740:	85a2                	mv	a1,s0
ffffffffc0201742:	8526                	mv	a0,s1
ffffffffc0201744:	bd5ff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc0201748:	892a                	mv	s2,a0
ffffffffc020174a:	16050d63          	beqz	a0,ffffffffc02018c4 <vmm_init+0x28a>
ffffffffc020174e:	00140593          	addi	a1,s0,1
ffffffffc0201752:	8526                	mv	a0,s1
ffffffffc0201754:	bc5ff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc0201758:	89aa                	mv	s3,a0
ffffffffc020175a:	14050563          	beqz	a0,ffffffffc02018a4 <vmm_init+0x26a>
ffffffffc020175e:	85d2                	mv	a1,s4
ffffffffc0201760:	8526                	mv	a0,s1
ffffffffc0201762:	bb7ff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc0201766:	16051f63          	bnez	a0,ffffffffc02018e4 <vmm_init+0x2aa>
ffffffffc020176a:	00340593          	addi	a1,s0,3
ffffffffc020176e:	8526                	mv	a0,s1
ffffffffc0201770:	ba9ff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc0201774:	1a051863          	bnez	a0,ffffffffc0201924 <vmm_init+0x2ea>
ffffffffc0201778:	00440593          	addi	a1,s0,4
ffffffffc020177c:	8526                	mv	a0,s1
ffffffffc020177e:	b9bff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc0201782:	18051163          	bnez	a0,ffffffffc0201904 <vmm_init+0x2ca>
ffffffffc0201786:	00893783          	ld	a5,8(s2)
ffffffffc020178a:	0a879d63          	bne	a5,s0,ffffffffc0201844 <vmm_init+0x20a>
ffffffffc020178e:	01093783          	ld	a5,16(s2)
ffffffffc0201792:	0b479963          	bne	a5,s4,ffffffffc0201844 <vmm_init+0x20a>
ffffffffc0201796:	0089b783          	ld	a5,8(s3)
ffffffffc020179a:	0c879563          	bne	a5,s0,ffffffffc0201864 <vmm_init+0x22a>
ffffffffc020179e:	0109b783          	ld	a5,16(s3)
ffffffffc02017a2:	0d479163          	bne	a5,s4,ffffffffc0201864 <vmm_init+0x22a>
ffffffffc02017a6:	0415                	addi	s0,s0,5
ffffffffc02017a8:	0a15                	addi	s4,s4,5
ffffffffc02017aa:	f9541be3          	bne	s0,s5,ffffffffc0201740 <vmm_init+0x106>
ffffffffc02017ae:	4411                	li	s0,4
ffffffffc02017b0:	597d                	li	s2,-1
ffffffffc02017b2:	85a2                	mv	a1,s0
ffffffffc02017b4:	8526                	mv	a0,s1
ffffffffc02017b6:	b63ff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc02017ba:	0004059b          	sext.w	a1,s0
ffffffffc02017be:	c90d                	beqz	a0,ffffffffc02017f0 <vmm_init+0x1b6>
ffffffffc02017c0:	6914                	ld	a3,16(a0)
ffffffffc02017c2:	6510                	ld	a2,8(a0)
ffffffffc02017c4:	0000b517          	auipc	a0,0xb
ffffffffc02017c8:	adc50513          	addi	a0,a0,-1316 # ffffffffc020c2a0 <commands+0xb08>
ffffffffc02017cc:	95ffe0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02017d0:	0000b697          	auipc	a3,0xb
ffffffffc02017d4:	af868693          	addi	a3,a3,-1288 # ffffffffc020c2c8 <commands+0xb30>
ffffffffc02017d8:	0000a617          	auipc	a2,0xa
ffffffffc02017dc:	02060613          	addi	a2,a2,32 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02017e0:	15900593          	li	a1,345
ffffffffc02017e4:	0000b517          	auipc	a0,0xb
ffffffffc02017e8:	8e450513          	addi	a0,a0,-1820 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02017ec:	a43fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02017f0:	147d                	addi	s0,s0,-1
ffffffffc02017f2:	fd2410e3          	bne	s0,s2,ffffffffc02017b2 <vmm_init+0x178>
ffffffffc02017f6:	8526                	mv	a0,s1
ffffffffc02017f8:	c31ff0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc02017fc:	0000b517          	auipc	a0,0xb
ffffffffc0201800:	ae450513          	addi	a0,a0,-1308 # ffffffffc020c2e0 <commands+0xb48>
ffffffffc0201804:	927fe0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0201808:	7442                	ld	s0,48(sp)
ffffffffc020180a:	70e2                	ld	ra,56(sp)
ffffffffc020180c:	74a2                	ld	s1,40(sp)
ffffffffc020180e:	7902                	ld	s2,32(sp)
ffffffffc0201810:	69e2                	ld	s3,24(sp)
ffffffffc0201812:	6a42                	ld	s4,16(sp)
ffffffffc0201814:	6aa2                	ld	s5,8(sp)
ffffffffc0201816:	0000b517          	auipc	a0,0xb
ffffffffc020181a:	aea50513          	addi	a0,a0,-1302 # ffffffffc020c300 <commands+0xb68>
ffffffffc020181e:	6121                	addi	sp,sp,64
ffffffffc0201820:	90bfe06f          	j	ffffffffc020012a <cprintf>
ffffffffc0201824:	0000b697          	auipc	a3,0xb
ffffffffc0201828:	99468693          	addi	a3,a3,-1644 # ffffffffc020c1b8 <commands+0xa20>
ffffffffc020182c:	0000a617          	auipc	a2,0xa
ffffffffc0201830:	fcc60613          	addi	a2,a2,-52 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201834:	13d00593          	li	a1,317
ffffffffc0201838:	0000b517          	auipc	a0,0xb
ffffffffc020183c:	89050513          	addi	a0,a0,-1904 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201840:	9effe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201844:	0000b697          	auipc	a3,0xb
ffffffffc0201848:	9fc68693          	addi	a3,a3,-1540 # ffffffffc020c240 <commands+0xaa8>
ffffffffc020184c:	0000a617          	auipc	a2,0xa
ffffffffc0201850:	fac60613          	addi	a2,a2,-84 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201854:	14e00593          	li	a1,334
ffffffffc0201858:	0000b517          	auipc	a0,0xb
ffffffffc020185c:	87050513          	addi	a0,a0,-1936 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201860:	9cffe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201864:	0000b697          	auipc	a3,0xb
ffffffffc0201868:	a0c68693          	addi	a3,a3,-1524 # ffffffffc020c270 <commands+0xad8>
ffffffffc020186c:	0000a617          	auipc	a2,0xa
ffffffffc0201870:	f8c60613          	addi	a2,a2,-116 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201874:	14f00593          	li	a1,335
ffffffffc0201878:	0000b517          	auipc	a0,0xb
ffffffffc020187c:	85050513          	addi	a0,a0,-1968 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201880:	9affe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201884:	0000b697          	auipc	a3,0xb
ffffffffc0201888:	91c68693          	addi	a3,a3,-1764 # ffffffffc020c1a0 <commands+0xa08>
ffffffffc020188c:	0000a617          	auipc	a2,0xa
ffffffffc0201890:	f6c60613          	addi	a2,a2,-148 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201894:	13b00593          	li	a1,315
ffffffffc0201898:	0000b517          	auipc	a0,0xb
ffffffffc020189c:	83050513          	addi	a0,a0,-2000 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02018a0:	98ffe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02018a4:	0000b697          	auipc	a3,0xb
ffffffffc02018a8:	95c68693          	addi	a3,a3,-1700 # ffffffffc020c200 <commands+0xa68>
ffffffffc02018ac:	0000a617          	auipc	a2,0xa
ffffffffc02018b0:	f4c60613          	addi	a2,a2,-180 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02018b4:	14600593          	li	a1,326
ffffffffc02018b8:	0000b517          	auipc	a0,0xb
ffffffffc02018bc:	81050513          	addi	a0,a0,-2032 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02018c0:	96ffe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02018c4:	0000b697          	auipc	a3,0xb
ffffffffc02018c8:	92c68693          	addi	a3,a3,-1748 # ffffffffc020c1f0 <commands+0xa58>
ffffffffc02018cc:	0000a617          	auipc	a2,0xa
ffffffffc02018d0:	f2c60613          	addi	a2,a2,-212 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02018d4:	14400593          	li	a1,324
ffffffffc02018d8:	0000a517          	auipc	a0,0xa
ffffffffc02018dc:	7f050513          	addi	a0,a0,2032 # ffffffffc020c0c8 <commands+0x930>
ffffffffc02018e0:	94ffe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02018e4:	0000b697          	auipc	a3,0xb
ffffffffc02018e8:	92c68693          	addi	a3,a3,-1748 # ffffffffc020c210 <commands+0xa78>
ffffffffc02018ec:	0000a617          	auipc	a2,0xa
ffffffffc02018f0:	f0c60613          	addi	a2,a2,-244 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02018f4:	14800593          	li	a1,328
ffffffffc02018f8:	0000a517          	auipc	a0,0xa
ffffffffc02018fc:	7d050513          	addi	a0,a0,2000 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201900:	92ffe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201904:	0000b697          	auipc	a3,0xb
ffffffffc0201908:	92c68693          	addi	a3,a3,-1748 # ffffffffc020c230 <commands+0xa98>
ffffffffc020190c:	0000a617          	auipc	a2,0xa
ffffffffc0201910:	eec60613          	addi	a2,a2,-276 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201914:	14c00593          	li	a1,332
ffffffffc0201918:	0000a517          	auipc	a0,0xa
ffffffffc020191c:	7b050513          	addi	a0,a0,1968 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201920:	90ffe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201924:	0000b697          	auipc	a3,0xb
ffffffffc0201928:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c220 <commands+0xa88>
ffffffffc020192c:	0000a617          	auipc	a2,0xa
ffffffffc0201930:	ecc60613          	addi	a2,a2,-308 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201934:	14a00593          	li	a1,330
ffffffffc0201938:	0000a517          	auipc	a0,0xa
ffffffffc020193c:	79050513          	addi	a0,a0,1936 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201940:	8effe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201944:	0000b697          	auipc	a3,0xb
ffffffffc0201948:	80c68693          	addi	a3,a3,-2036 # ffffffffc020c150 <commands+0x9b8>
ffffffffc020194c:	0000a617          	auipc	a2,0xa
ffffffffc0201950:	eac60613          	addi	a2,a2,-340 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201954:	12400593          	li	a1,292
ffffffffc0201958:	0000a517          	auipc	a0,0xa
ffffffffc020195c:	77050513          	addi	a0,a0,1904 # ffffffffc020c0c8 <commands+0x930>
ffffffffc0201960:	8cffe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0201964 <user_mem_check>:
ffffffffc0201964:	7179                	addi	sp,sp,-48
ffffffffc0201966:	f022                	sd	s0,32(sp)
ffffffffc0201968:	f406                	sd	ra,40(sp)
ffffffffc020196a:	ec26                	sd	s1,24(sp)
ffffffffc020196c:	e84a                	sd	s2,16(sp)
ffffffffc020196e:	e44e                	sd	s3,8(sp)
ffffffffc0201970:	e052                	sd	s4,0(sp)
ffffffffc0201972:	842e                	mv	s0,a1
ffffffffc0201974:	c135                	beqz	a0,ffffffffc02019d8 <user_mem_check+0x74>
ffffffffc0201976:	002007b7          	lui	a5,0x200
ffffffffc020197a:	04f5e663          	bltu	a1,a5,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc020197e:	00c584b3          	add	s1,a1,a2
ffffffffc0201982:	0495f263          	bgeu	a1,s1,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc0201986:	4785                	li	a5,1
ffffffffc0201988:	07fe                	slli	a5,a5,0x1f
ffffffffc020198a:	0297ee63          	bltu	a5,s1,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc020198e:	892a                	mv	s2,a0
ffffffffc0201990:	89b6                	mv	s3,a3
ffffffffc0201992:	6a05                	lui	s4,0x1
ffffffffc0201994:	a821                	j	ffffffffc02019ac <user_mem_check+0x48>
ffffffffc0201996:	0027f693          	andi	a3,a5,2
ffffffffc020199a:	9752                	add	a4,a4,s4
ffffffffc020199c:	8ba1                	andi	a5,a5,8
ffffffffc020199e:	c685                	beqz	a3,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc02019a0:	c399                	beqz	a5,ffffffffc02019a6 <user_mem_check+0x42>
ffffffffc02019a2:	02e46263          	bltu	s0,a4,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc02019a6:	6900                	ld	s0,16(a0)
ffffffffc02019a8:	04947663          	bgeu	s0,s1,ffffffffc02019f4 <user_mem_check+0x90>
ffffffffc02019ac:	85a2                	mv	a1,s0
ffffffffc02019ae:	854a                	mv	a0,s2
ffffffffc02019b0:	969ff0ef          	jal	ra,ffffffffc0201318 <find_vma>
ffffffffc02019b4:	c909                	beqz	a0,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc02019b6:	6518                	ld	a4,8(a0)
ffffffffc02019b8:	00e46763          	bltu	s0,a4,ffffffffc02019c6 <user_mem_check+0x62>
ffffffffc02019bc:	4d1c                	lw	a5,24(a0)
ffffffffc02019be:	fc099ce3          	bnez	s3,ffffffffc0201996 <user_mem_check+0x32>
ffffffffc02019c2:	8b85                	andi	a5,a5,1
ffffffffc02019c4:	f3ed                	bnez	a5,ffffffffc02019a6 <user_mem_check+0x42>
ffffffffc02019c6:	4501                	li	a0,0
ffffffffc02019c8:	70a2                	ld	ra,40(sp)
ffffffffc02019ca:	7402                	ld	s0,32(sp)
ffffffffc02019cc:	64e2                	ld	s1,24(sp)
ffffffffc02019ce:	6942                	ld	s2,16(sp)
ffffffffc02019d0:	69a2                	ld	s3,8(sp)
ffffffffc02019d2:	6a02                	ld	s4,0(sp)
ffffffffc02019d4:	6145                	addi	sp,sp,48
ffffffffc02019d6:	8082                	ret
ffffffffc02019d8:	c02007b7          	lui	a5,0xc0200
ffffffffc02019dc:	4501                	li	a0,0
ffffffffc02019de:	fef5e5e3          	bltu	a1,a5,ffffffffc02019c8 <user_mem_check+0x64>
ffffffffc02019e2:	962e                	add	a2,a2,a1
ffffffffc02019e4:	fec5f2e3          	bgeu	a1,a2,ffffffffc02019c8 <user_mem_check+0x64>
ffffffffc02019e8:	c8000537          	lui	a0,0xc8000
ffffffffc02019ec:	0505                	addi	a0,a0,1
ffffffffc02019ee:	00a63533          	sltu	a0,a2,a0
ffffffffc02019f2:	bfd9                	j	ffffffffc02019c8 <user_mem_check+0x64>
ffffffffc02019f4:	4505                	li	a0,1
ffffffffc02019f6:	bfc9                	j	ffffffffc02019c8 <user_mem_check+0x64>

ffffffffc02019f8 <copy_from_user>:
ffffffffc02019f8:	1101                	addi	sp,sp,-32
ffffffffc02019fa:	e822                	sd	s0,16(sp)
ffffffffc02019fc:	e426                	sd	s1,8(sp)
ffffffffc02019fe:	8432                	mv	s0,a2
ffffffffc0201a00:	84b6                	mv	s1,a3
ffffffffc0201a02:	e04a                	sd	s2,0(sp)
ffffffffc0201a04:	86ba                	mv	a3,a4
ffffffffc0201a06:	892e                	mv	s2,a1
ffffffffc0201a08:	8626                	mv	a2,s1
ffffffffc0201a0a:	85a2                	mv	a1,s0
ffffffffc0201a0c:	ec06                	sd	ra,24(sp)
ffffffffc0201a0e:	f57ff0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc0201a12:	c519                	beqz	a0,ffffffffc0201a20 <copy_from_user+0x28>
ffffffffc0201a14:	8626                	mv	a2,s1
ffffffffc0201a16:	85a2                	mv	a1,s0
ffffffffc0201a18:	854a                	mv	a0,s2
ffffffffc0201a1a:	62c090ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0201a1e:	4505                	li	a0,1
ffffffffc0201a20:	60e2                	ld	ra,24(sp)
ffffffffc0201a22:	6442                	ld	s0,16(sp)
ffffffffc0201a24:	64a2                	ld	s1,8(sp)
ffffffffc0201a26:	6902                	ld	s2,0(sp)
ffffffffc0201a28:	6105                	addi	sp,sp,32
ffffffffc0201a2a:	8082                	ret

ffffffffc0201a2c <copy_to_user>:
ffffffffc0201a2c:	1101                	addi	sp,sp,-32
ffffffffc0201a2e:	e822                	sd	s0,16(sp)
ffffffffc0201a30:	8436                	mv	s0,a3
ffffffffc0201a32:	e04a                	sd	s2,0(sp)
ffffffffc0201a34:	4685                	li	a3,1
ffffffffc0201a36:	8932                	mv	s2,a2
ffffffffc0201a38:	8622                	mv	a2,s0
ffffffffc0201a3a:	e426                	sd	s1,8(sp)
ffffffffc0201a3c:	ec06                	sd	ra,24(sp)
ffffffffc0201a3e:	84ae                	mv	s1,a1
ffffffffc0201a40:	f25ff0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc0201a44:	c519                	beqz	a0,ffffffffc0201a52 <copy_to_user+0x26>
ffffffffc0201a46:	8622                	mv	a2,s0
ffffffffc0201a48:	85ca                	mv	a1,s2
ffffffffc0201a4a:	8526                	mv	a0,s1
ffffffffc0201a4c:	5fa090ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0201a50:	4505                	li	a0,1
ffffffffc0201a52:	60e2                	ld	ra,24(sp)
ffffffffc0201a54:	6442                	ld	s0,16(sp)
ffffffffc0201a56:	64a2                	ld	s1,8(sp)
ffffffffc0201a58:	6902                	ld	s2,0(sp)
ffffffffc0201a5a:	6105                	addi	sp,sp,32
ffffffffc0201a5c:	8082                	ret

ffffffffc0201a5e <copy_string>:
ffffffffc0201a5e:	7139                	addi	sp,sp,-64
ffffffffc0201a60:	ec4e                	sd	s3,24(sp)
ffffffffc0201a62:	6985                	lui	s3,0x1
ffffffffc0201a64:	99b2                	add	s3,s3,a2
ffffffffc0201a66:	77fd                	lui	a5,0xfffff
ffffffffc0201a68:	00f9f9b3          	and	s3,s3,a5
ffffffffc0201a6c:	f426                	sd	s1,40(sp)
ffffffffc0201a6e:	f04a                	sd	s2,32(sp)
ffffffffc0201a70:	e852                	sd	s4,16(sp)
ffffffffc0201a72:	e456                	sd	s5,8(sp)
ffffffffc0201a74:	fc06                	sd	ra,56(sp)
ffffffffc0201a76:	f822                	sd	s0,48(sp)
ffffffffc0201a78:	84b2                	mv	s1,a2
ffffffffc0201a7a:	8aaa                	mv	s5,a0
ffffffffc0201a7c:	8a2e                	mv	s4,a1
ffffffffc0201a7e:	8936                	mv	s2,a3
ffffffffc0201a80:	40c989b3          	sub	s3,s3,a2
ffffffffc0201a84:	a015                	j	ffffffffc0201aa8 <copy_string+0x4a>
ffffffffc0201a86:	4e6090ef          	jal	ra,ffffffffc020af6c <strnlen>
ffffffffc0201a8a:	87aa                	mv	a5,a0
ffffffffc0201a8c:	85a6                	mv	a1,s1
ffffffffc0201a8e:	8552                	mv	a0,s4
ffffffffc0201a90:	8622                	mv	a2,s0
ffffffffc0201a92:	0487e363          	bltu	a5,s0,ffffffffc0201ad8 <copy_string+0x7a>
ffffffffc0201a96:	0329f763          	bgeu	s3,s2,ffffffffc0201ac4 <copy_string+0x66>
ffffffffc0201a9a:	5ac090ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0201a9e:	9a22                	add	s4,s4,s0
ffffffffc0201aa0:	94a2                	add	s1,s1,s0
ffffffffc0201aa2:	40890933          	sub	s2,s2,s0
ffffffffc0201aa6:	6985                	lui	s3,0x1
ffffffffc0201aa8:	4681                	li	a3,0
ffffffffc0201aaa:	85a6                	mv	a1,s1
ffffffffc0201aac:	8556                	mv	a0,s5
ffffffffc0201aae:	844a                	mv	s0,s2
ffffffffc0201ab0:	0129f363          	bgeu	s3,s2,ffffffffc0201ab6 <copy_string+0x58>
ffffffffc0201ab4:	844e                	mv	s0,s3
ffffffffc0201ab6:	8622                	mv	a2,s0
ffffffffc0201ab8:	eadff0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc0201abc:	87aa                	mv	a5,a0
ffffffffc0201abe:	85a2                	mv	a1,s0
ffffffffc0201ac0:	8526                	mv	a0,s1
ffffffffc0201ac2:	f3f1                	bnez	a5,ffffffffc0201a86 <copy_string+0x28>
ffffffffc0201ac4:	4501                	li	a0,0
ffffffffc0201ac6:	70e2                	ld	ra,56(sp)
ffffffffc0201ac8:	7442                	ld	s0,48(sp)
ffffffffc0201aca:	74a2                	ld	s1,40(sp)
ffffffffc0201acc:	7902                	ld	s2,32(sp)
ffffffffc0201ace:	69e2                	ld	s3,24(sp)
ffffffffc0201ad0:	6a42                	ld	s4,16(sp)
ffffffffc0201ad2:	6aa2                	ld	s5,8(sp)
ffffffffc0201ad4:	6121                	addi	sp,sp,64
ffffffffc0201ad6:	8082                	ret
ffffffffc0201ad8:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc0201adc:	56a090ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0201ae0:	4505                	li	a0,1
ffffffffc0201ae2:	b7d5                	j	ffffffffc0201ac6 <copy_string+0x68>

ffffffffc0201ae4 <slob_free>:
ffffffffc0201ae4:	c94d                	beqz	a0,ffffffffc0201b96 <slob_free+0xb2>
ffffffffc0201ae6:	1141                	addi	sp,sp,-16
ffffffffc0201ae8:	e022                	sd	s0,0(sp)
ffffffffc0201aea:	e406                	sd	ra,8(sp)
ffffffffc0201aec:	842a                	mv	s0,a0
ffffffffc0201aee:	e9c1                	bnez	a1,ffffffffc0201b7e <slob_free+0x9a>
ffffffffc0201af0:	100027f3          	csrr	a5,sstatus
ffffffffc0201af4:	8b89                	andi	a5,a5,2
ffffffffc0201af6:	4501                	li	a0,0
ffffffffc0201af8:	ebd9                	bnez	a5,ffffffffc0201b8e <slob_free+0xaa>
ffffffffc0201afa:	0008f617          	auipc	a2,0x8f
ffffffffc0201afe:	55660613          	addi	a2,a2,1366 # ffffffffc0291050 <slobfree>
ffffffffc0201b02:	621c                	ld	a5,0(a2)
ffffffffc0201b04:	873e                	mv	a4,a5
ffffffffc0201b06:	679c                	ld	a5,8(a5)
ffffffffc0201b08:	02877a63          	bgeu	a4,s0,ffffffffc0201b3c <slob_free+0x58>
ffffffffc0201b0c:	00f46463          	bltu	s0,a5,ffffffffc0201b14 <slob_free+0x30>
ffffffffc0201b10:	fef76ae3          	bltu	a4,a5,ffffffffc0201b04 <slob_free+0x20>
ffffffffc0201b14:	400c                	lw	a1,0(s0)
ffffffffc0201b16:	00459693          	slli	a3,a1,0x4
ffffffffc0201b1a:	96a2                	add	a3,a3,s0
ffffffffc0201b1c:	02d78a63          	beq	a5,a3,ffffffffc0201b50 <slob_free+0x6c>
ffffffffc0201b20:	4314                	lw	a3,0(a4)
ffffffffc0201b22:	e41c                	sd	a5,8(s0)
ffffffffc0201b24:	00469793          	slli	a5,a3,0x4
ffffffffc0201b28:	97ba                	add	a5,a5,a4
ffffffffc0201b2a:	02f40e63          	beq	s0,a5,ffffffffc0201b66 <slob_free+0x82>
ffffffffc0201b2e:	e700                	sd	s0,8(a4)
ffffffffc0201b30:	e218                	sd	a4,0(a2)
ffffffffc0201b32:	e129                	bnez	a0,ffffffffc0201b74 <slob_free+0x90>
ffffffffc0201b34:	60a2                	ld	ra,8(sp)
ffffffffc0201b36:	6402                	ld	s0,0(sp)
ffffffffc0201b38:	0141                	addi	sp,sp,16
ffffffffc0201b3a:	8082                	ret
ffffffffc0201b3c:	fcf764e3          	bltu	a4,a5,ffffffffc0201b04 <slob_free+0x20>
ffffffffc0201b40:	fcf472e3          	bgeu	s0,a5,ffffffffc0201b04 <slob_free+0x20>
ffffffffc0201b44:	400c                	lw	a1,0(s0)
ffffffffc0201b46:	00459693          	slli	a3,a1,0x4
ffffffffc0201b4a:	96a2                	add	a3,a3,s0
ffffffffc0201b4c:	fcd79ae3          	bne	a5,a3,ffffffffc0201b20 <slob_free+0x3c>
ffffffffc0201b50:	4394                	lw	a3,0(a5)
ffffffffc0201b52:	679c                	ld	a5,8(a5)
ffffffffc0201b54:	9db5                	addw	a1,a1,a3
ffffffffc0201b56:	c00c                	sw	a1,0(s0)
ffffffffc0201b58:	4314                	lw	a3,0(a4)
ffffffffc0201b5a:	e41c                	sd	a5,8(s0)
ffffffffc0201b5c:	00469793          	slli	a5,a3,0x4
ffffffffc0201b60:	97ba                	add	a5,a5,a4
ffffffffc0201b62:	fcf416e3          	bne	s0,a5,ffffffffc0201b2e <slob_free+0x4a>
ffffffffc0201b66:	401c                	lw	a5,0(s0)
ffffffffc0201b68:	640c                	ld	a1,8(s0)
ffffffffc0201b6a:	e218                	sd	a4,0(a2)
ffffffffc0201b6c:	9ebd                	addw	a3,a3,a5
ffffffffc0201b6e:	c314                	sw	a3,0(a4)
ffffffffc0201b70:	e70c                	sd	a1,8(a4)
ffffffffc0201b72:	d169                	beqz	a0,ffffffffc0201b34 <slob_free+0x50>
ffffffffc0201b74:	6402                	ld	s0,0(sp)
ffffffffc0201b76:	60a2                	ld	ra,8(sp)
ffffffffc0201b78:	0141                	addi	sp,sp,16
ffffffffc0201b7a:	a24ff06f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc0201b7e:	25bd                	addiw	a1,a1,15
ffffffffc0201b80:	8191                	srli	a1,a1,0x4
ffffffffc0201b82:	c10c                	sw	a1,0(a0)
ffffffffc0201b84:	100027f3          	csrr	a5,sstatus
ffffffffc0201b88:	8b89                	andi	a5,a5,2
ffffffffc0201b8a:	4501                	li	a0,0
ffffffffc0201b8c:	d7bd                	beqz	a5,ffffffffc0201afa <slob_free+0x16>
ffffffffc0201b8e:	a16ff0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0201b92:	4505                	li	a0,1
ffffffffc0201b94:	b79d                	j	ffffffffc0201afa <slob_free+0x16>
ffffffffc0201b96:	8082                	ret

ffffffffc0201b98 <__slob_get_free_pages.constprop.0>:
ffffffffc0201b98:	4785                	li	a5,1
ffffffffc0201b9a:	1141                	addi	sp,sp,-16
ffffffffc0201b9c:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201ba0:	e406                	sd	ra,8(sp)
ffffffffc0201ba2:	601000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0201ba6:	c91d                	beqz	a0,ffffffffc0201bdc <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201ba8:	00095697          	auipc	a3,0x95
ffffffffc0201bac:	d006b683          	ld	a3,-768(a3) # ffffffffc02968a8 <pages>
ffffffffc0201bb0:	8d15                	sub	a0,a0,a3
ffffffffc0201bb2:	8519                	srai	a0,a0,0x6
ffffffffc0201bb4:	0000e697          	auipc	a3,0xe
ffffffffc0201bb8:	b2c6b683          	ld	a3,-1236(a3) # ffffffffc020f6e0 <nbase>
ffffffffc0201bbc:	9536                	add	a0,a0,a3
ffffffffc0201bbe:	00c51793          	slli	a5,a0,0xc
ffffffffc0201bc2:	83b1                	srli	a5,a5,0xc
ffffffffc0201bc4:	00095717          	auipc	a4,0x95
ffffffffc0201bc8:	cdc73703          	ld	a4,-804(a4) # ffffffffc02968a0 <npage>
ffffffffc0201bcc:	0532                	slli	a0,a0,0xc
ffffffffc0201bce:	00e7fa63          	bgeu	a5,a4,ffffffffc0201be2 <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201bd2:	00095697          	auipc	a3,0x95
ffffffffc0201bd6:	ce66b683          	ld	a3,-794(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201bda:	9536                	add	a0,a0,a3
ffffffffc0201bdc:	60a2                	ld	ra,8(sp)
ffffffffc0201bde:	0141                	addi	sp,sp,16
ffffffffc0201be0:	8082                	ret
ffffffffc0201be2:	86aa                	mv	a3,a0
ffffffffc0201be4:	0000a617          	auipc	a2,0xa
ffffffffc0201be8:	74460613          	addi	a2,a2,1860 # ffffffffc020c328 <commands+0xb90>
ffffffffc0201bec:	07100593          	li	a1,113
ffffffffc0201bf0:	0000a517          	auipc	a0,0xa
ffffffffc0201bf4:	76050513          	addi	a0,a0,1888 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0201bf8:	e36fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0201bfc <slob_alloc.constprop.0>:
ffffffffc0201bfc:	1101                	addi	sp,sp,-32
ffffffffc0201bfe:	ec06                	sd	ra,24(sp)
ffffffffc0201c00:	e822                	sd	s0,16(sp)
ffffffffc0201c02:	e426                	sd	s1,8(sp)
ffffffffc0201c04:	e04a                	sd	s2,0(sp)
ffffffffc0201c06:	01050713          	addi	a4,a0,16
ffffffffc0201c0a:	6785                	lui	a5,0x1
ffffffffc0201c0c:	0cf77363          	bgeu	a4,a5,ffffffffc0201cd2 <slob_alloc.constprop.0+0xd6>
ffffffffc0201c10:	00f50493          	addi	s1,a0,15
ffffffffc0201c14:	8091                	srli	s1,s1,0x4
ffffffffc0201c16:	2481                	sext.w	s1,s1
ffffffffc0201c18:	10002673          	csrr	a2,sstatus
ffffffffc0201c1c:	8a09                	andi	a2,a2,2
ffffffffc0201c1e:	e25d                	bnez	a2,ffffffffc0201cc4 <slob_alloc.constprop.0+0xc8>
ffffffffc0201c20:	0008f917          	auipc	s2,0x8f
ffffffffc0201c24:	43090913          	addi	s2,s2,1072 # ffffffffc0291050 <slobfree>
ffffffffc0201c28:	00093683          	ld	a3,0(s2)
ffffffffc0201c2c:	669c                	ld	a5,8(a3)
ffffffffc0201c2e:	4398                	lw	a4,0(a5)
ffffffffc0201c30:	08975e63          	bge	a4,s1,ffffffffc0201ccc <slob_alloc.constprop.0+0xd0>
ffffffffc0201c34:	00f68b63          	beq	a3,a5,ffffffffc0201c4a <slob_alloc.constprop.0+0x4e>
ffffffffc0201c38:	6780                	ld	s0,8(a5)
ffffffffc0201c3a:	4018                	lw	a4,0(s0)
ffffffffc0201c3c:	02975a63          	bge	a4,s1,ffffffffc0201c70 <slob_alloc.constprop.0+0x74>
ffffffffc0201c40:	00093683          	ld	a3,0(s2)
ffffffffc0201c44:	87a2                	mv	a5,s0
ffffffffc0201c46:	fef699e3          	bne	a3,a5,ffffffffc0201c38 <slob_alloc.constprop.0+0x3c>
ffffffffc0201c4a:	ee31                	bnez	a2,ffffffffc0201ca6 <slob_alloc.constprop.0+0xaa>
ffffffffc0201c4c:	4501                	li	a0,0
ffffffffc0201c4e:	f4bff0ef          	jal	ra,ffffffffc0201b98 <__slob_get_free_pages.constprop.0>
ffffffffc0201c52:	842a                	mv	s0,a0
ffffffffc0201c54:	cd05                	beqz	a0,ffffffffc0201c8c <slob_alloc.constprop.0+0x90>
ffffffffc0201c56:	6585                	lui	a1,0x1
ffffffffc0201c58:	e8dff0ef          	jal	ra,ffffffffc0201ae4 <slob_free>
ffffffffc0201c5c:	10002673          	csrr	a2,sstatus
ffffffffc0201c60:	8a09                	andi	a2,a2,2
ffffffffc0201c62:	ee05                	bnez	a2,ffffffffc0201c9a <slob_alloc.constprop.0+0x9e>
ffffffffc0201c64:	00093783          	ld	a5,0(s2)
ffffffffc0201c68:	6780                	ld	s0,8(a5)
ffffffffc0201c6a:	4018                	lw	a4,0(s0)
ffffffffc0201c6c:	fc974ae3          	blt	a4,s1,ffffffffc0201c40 <slob_alloc.constprop.0+0x44>
ffffffffc0201c70:	04e48763          	beq	s1,a4,ffffffffc0201cbe <slob_alloc.constprop.0+0xc2>
ffffffffc0201c74:	00449693          	slli	a3,s1,0x4
ffffffffc0201c78:	96a2                	add	a3,a3,s0
ffffffffc0201c7a:	e794                	sd	a3,8(a5)
ffffffffc0201c7c:	640c                	ld	a1,8(s0)
ffffffffc0201c7e:	9f05                	subw	a4,a4,s1
ffffffffc0201c80:	c298                	sw	a4,0(a3)
ffffffffc0201c82:	e68c                	sd	a1,8(a3)
ffffffffc0201c84:	c004                	sw	s1,0(s0)
ffffffffc0201c86:	00f93023          	sd	a5,0(s2)
ffffffffc0201c8a:	e20d                	bnez	a2,ffffffffc0201cac <slob_alloc.constprop.0+0xb0>
ffffffffc0201c8c:	60e2                	ld	ra,24(sp)
ffffffffc0201c8e:	8522                	mv	a0,s0
ffffffffc0201c90:	6442                	ld	s0,16(sp)
ffffffffc0201c92:	64a2                	ld	s1,8(sp)
ffffffffc0201c94:	6902                	ld	s2,0(sp)
ffffffffc0201c96:	6105                	addi	sp,sp,32
ffffffffc0201c98:	8082                	ret
ffffffffc0201c9a:	90aff0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0201c9e:	00093783          	ld	a5,0(s2)
ffffffffc0201ca2:	4605                	li	a2,1
ffffffffc0201ca4:	b7d1                	j	ffffffffc0201c68 <slob_alloc.constprop.0+0x6c>
ffffffffc0201ca6:	8f8ff0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0201caa:	b74d                	j	ffffffffc0201c4c <slob_alloc.constprop.0+0x50>
ffffffffc0201cac:	8f2ff0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0201cb0:	60e2                	ld	ra,24(sp)
ffffffffc0201cb2:	8522                	mv	a0,s0
ffffffffc0201cb4:	6442                	ld	s0,16(sp)
ffffffffc0201cb6:	64a2                	ld	s1,8(sp)
ffffffffc0201cb8:	6902                	ld	s2,0(sp)
ffffffffc0201cba:	6105                	addi	sp,sp,32
ffffffffc0201cbc:	8082                	ret
ffffffffc0201cbe:	6418                	ld	a4,8(s0)
ffffffffc0201cc0:	e798                	sd	a4,8(a5)
ffffffffc0201cc2:	b7d1                	j	ffffffffc0201c86 <slob_alloc.constprop.0+0x8a>
ffffffffc0201cc4:	8e0ff0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0201cc8:	4605                	li	a2,1
ffffffffc0201cca:	bf99                	j	ffffffffc0201c20 <slob_alloc.constprop.0+0x24>
ffffffffc0201ccc:	843e                	mv	s0,a5
ffffffffc0201cce:	87b6                	mv	a5,a3
ffffffffc0201cd0:	b745                	j	ffffffffc0201c70 <slob_alloc.constprop.0+0x74>
ffffffffc0201cd2:	0000a697          	auipc	a3,0xa
ffffffffc0201cd6:	68e68693          	addi	a3,a3,1678 # ffffffffc020c360 <commands+0xbc8>
ffffffffc0201cda:	0000a617          	auipc	a2,0xa
ffffffffc0201cde:	b1e60613          	addi	a2,a2,-1250 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0201ce2:	06300593          	li	a1,99
ffffffffc0201ce6:	0000a517          	auipc	a0,0xa
ffffffffc0201cea:	69a50513          	addi	a0,a0,1690 # ffffffffc020c380 <commands+0xbe8>
ffffffffc0201cee:	d40fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0201cf2 <kmalloc_init>:
ffffffffc0201cf2:	1141                	addi	sp,sp,-16
ffffffffc0201cf4:	0000a517          	auipc	a0,0xa
ffffffffc0201cf8:	6a450513          	addi	a0,a0,1700 # ffffffffc020c398 <commands+0xc00>
ffffffffc0201cfc:	e406                	sd	ra,8(sp)
ffffffffc0201cfe:	c2cfe0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0201d02:	60a2                	ld	ra,8(sp)
ffffffffc0201d04:	0000a517          	auipc	a0,0xa
ffffffffc0201d08:	6ac50513          	addi	a0,a0,1708 # ffffffffc020c3b0 <commands+0xc18>
ffffffffc0201d0c:	0141                	addi	sp,sp,16
ffffffffc0201d0e:	c1cfe06f          	j	ffffffffc020012a <cprintf>

ffffffffc0201d12 <kallocated>:
ffffffffc0201d12:	4501                	li	a0,0
ffffffffc0201d14:	8082                	ret

ffffffffc0201d16 <kmalloc>:
ffffffffc0201d16:	1101                	addi	sp,sp,-32
ffffffffc0201d18:	e04a                	sd	s2,0(sp)
ffffffffc0201d1a:	6905                	lui	s2,0x1
ffffffffc0201d1c:	e822                	sd	s0,16(sp)
ffffffffc0201d1e:	ec06                	sd	ra,24(sp)
ffffffffc0201d20:	e426                	sd	s1,8(sp)
ffffffffc0201d22:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201d26:	842a                	mv	s0,a0
ffffffffc0201d28:	04a7f963          	bgeu	a5,a0,ffffffffc0201d7a <kmalloc+0x64>
ffffffffc0201d2c:	4561                	li	a0,24
ffffffffc0201d2e:	ecfff0ef          	jal	ra,ffffffffc0201bfc <slob_alloc.constprop.0>
ffffffffc0201d32:	84aa                	mv	s1,a0
ffffffffc0201d34:	c929                	beqz	a0,ffffffffc0201d86 <kmalloc+0x70>
ffffffffc0201d36:	0004079b          	sext.w	a5,s0
ffffffffc0201d3a:	4501                	li	a0,0
ffffffffc0201d3c:	00f95763          	bge	s2,a5,ffffffffc0201d4a <kmalloc+0x34>
ffffffffc0201d40:	6705                	lui	a4,0x1
ffffffffc0201d42:	8785                	srai	a5,a5,0x1
ffffffffc0201d44:	2505                	addiw	a0,a0,1
ffffffffc0201d46:	fef74ee3          	blt	a4,a5,ffffffffc0201d42 <kmalloc+0x2c>
ffffffffc0201d4a:	c088                	sw	a0,0(s1)
ffffffffc0201d4c:	e4dff0ef          	jal	ra,ffffffffc0201b98 <__slob_get_free_pages.constprop.0>
ffffffffc0201d50:	e488                	sd	a0,8(s1)
ffffffffc0201d52:	842a                	mv	s0,a0
ffffffffc0201d54:	c525                	beqz	a0,ffffffffc0201dbc <kmalloc+0xa6>
ffffffffc0201d56:	100027f3          	csrr	a5,sstatus
ffffffffc0201d5a:	8b89                	andi	a5,a5,2
ffffffffc0201d5c:	ef8d                	bnez	a5,ffffffffc0201d96 <kmalloc+0x80>
ffffffffc0201d5e:	00095797          	auipc	a5,0x95
ffffffffc0201d62:	b2a78793          	addi	a5,a5,-1238 # ffffffffc0296888 <bigblocks>
ffffffffc0201d66:	6398                	ld	a4,0(a5)
ffffffffc0201d68:	e384                	sd	s1,0(a5)
ffffffffc0201d6a:	e898                	sd	a4,16(s1)
ffffffffc0201d6c:	60e2                	ld	ra,24(sp)
ffffffffc0201d6e:	8522                	mv	a0,s0
ffffffffc0201d70:	6442                	ld	s0,16(sp)
ffffffffc0201d72:	64a2                	ld	s1,8(sp)
ffffffffc0201d74:	6902                	ld	s2,0(sp)
ffffffffc0201d76:	6105                	addi	sp,sp,32
ffffffffc0201d78:	8082                	ret
ffffffffc0201d7a:	0541                	addi	a0,a0,16
ffffffffc0201d7c:	e81ff0ef          	jal	ra,ffffffffc0201bfc <slob_alloc.constprop.0>
ffffffffc0201d80:	01050413          	addi	s0,a0,16
ffffffffc0201d84:	f565                	bnez	a0,ffffffffc0201d6c <kmalloc+0x56>
ffffffffc0201d86:	4401                	li	s0,0
ffffffffc0201d88:	60e2                	ld	ra,24(sp)
ffffffffc0201d8a:	8522                	mv	a0,s0
ffffffffc0201d8c:	6442                	ld	s0,16(sp)
ffffffffc0201d8e:	64a2                	ld	s1,8(sp)
ffffffffc0201d90:	6902                	ld	s2,0(sp)
ffffffffc0201d92:	6105                	addi	sp,sp,32
ffffffffc0201d94:	8082                	ret
ffffffffc0201d96:	80eff0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0201d9a:	00095797          	auipc	a5,0x95
ffffffffc0201d9e:	aee78793          	addi	a5,a5,-1298 # ffffffffc0296888 <bigblocks>
ffffffffc0201da2:	6398                	ld	a4,0(a5)
ffffffffc0201da4:	e384                	sd	s1,0(a5)
ffffffffc0201da6:	e898                	sd	a4,16(s1)
ffffffffc0201da8:	ff7fe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0201dac:	6480                	ld	s0,8(s1)
ffffffffc0201dae:	60e2                	ld	ra,24(sp)
ffffffffc0201db0:	64a2                	ld	s1,8(sp)
ffffffffc0201db2:	8522                	mv	a0,s0
ffffffffc0201db4:	6442                	ld	s0,16(sp)
ffffffffc0201db6:	6902                	ld	s2,0(sp)
ffffffffc0201db8:	6105                	addi	sp,sp,32
ffffffffc0201dba:	8082                	ret
ffffffffc0201dbc:	45e1                	li	a1,24
ffffffffc0201dbe:	8526                	mv	a0,s1
ffffffffc0201dc0:	d25ff0ef          	jal	ra,ffffffffc0201ae4 <slob_free>
ffffffffc0201dc4:	b765                	j	ffffffffc0201d6c <kmalloc+0x56>

ffffffffc0201dc6 <kfree>:
ffffffffc0201dc6:	c169                	beqz	a0,ffffffffc0201e88 <kfree+0xc2>
ffffffffc0201dc8:	1101                	addi	sp,sp,-32
ffffffffc0201dca:	e822                	sd	s0,16(sp)
ffffffffc0201dcc:	ec06                	sd	ra,24(sp)
ffffffffc0201dce:	e426                	sd	s1,8(sp)
ffffffffc0201dd0:	03451793          	slli	a5,a0,0x34
ffffffffc0201dd4:	842a                	mv	s0,a0
ffffffffc0201dd6:	e3d9                	bnez	a5,ffffffffc0201e5c <kfree+0x96>
ffffffffc0201dd8:	100027f3          	csrr	a5,sstatus
ffffffffc0201ddc:	8b89                	andi	a5,a5,2
ffffffffc0201dde:	e7d9                	bnez	a5,ffffffffc0201e6c <kfree+0xa6>
ffffffffc0201de0:	00095797          	auipc	a5,0x95
ffffffffc0201de4:	aa87b783          	ld	a5,-1368(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0201de8:	4601                	li	a2,0
ffffffffc0201dea:	cbad                	beqz	a5,ffffffffc0201e5c <kfree+0x96>
ffffffffc0201dec:	00095697          	auipc	a3,0x95
ffffffffc0201df0:	a9c68693          	addi	a3,a3,-1380 # ffffffffc0296888 <bigblocks>
ffffffffc0201df4:	a021                	j	ffffffffc0201dfc <kfree+0x36>
ffffffffc0201df6:	01048693          	addi	a3,s1,16
ffffffffc0201dfa:	c3a5                	beqz	a5,ffffffffc0201e5a <kfree+0x94>
ffffffffc0201dfc:	6798                	ld	a4,8(a5)
ffffffffc0201dfe:	84be                	mv	s1,a5
ffffffffc0201e00:	6b9c                	ld	a5,16(a5)
ffffffffc0201e02:	fe871ae3          	bne	a4,s0,ffffffffc0201df6 <kfree+0x30>
ffffffffc0201e06:	e29c                	sd	a5,0(a3)
ffffffffc0201e08:	ee2d                	bnez	a2,ffffffffc0201e82 <kfree+0xbc>
ffffffffc0201e0a:	c02007b7          	lui	a5,0xc0200
ffffffffc0201e0e:	4098                	lw	a4,0(s1)
ffffffffc0201e10:	08f46963          	bltu	s0,a5,ffffffffc0201ea2 <kfree+0xdc>
ffffffffc0201e14:	00095697          	auipc	a3,0x95
ffffffffc0201e18:	aa46b683          	ld	a3,-1372(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e1c:	8c15                	sub	s0,s0,a3
ffffffffc0201e1e:	8031                	srli	s0,s0,0xc
ffffffffc0201e20:	00095797          	auipc	a5,0x95
ffffffffc0201e24:	a807b783          	ld	a5,-1408(a5) # ffffffffc02968a0 <npage>
ffffffffc0201e28:	06f47163          	bgeu	s0,a5,ffffffffc0201e8a <kfree+0xc4>
ffffffffc0201e2c:	0000e517          	auipc	a0,0xe
ffffffffc0201e30:	8b453503          	ld	a0,-1868(a0) # ffffffffc020f6e0 <nbase>
ffffffffc0201e34:	8c09                	sub	s0,s0,a0
ffffffffc0201e36:	041a                	slli	s0,s0,0x6
ffffffffc0201e38:	00095517          	auipc	a0,0x95
ffffffffc0201e3c:	a7053503          	ld	a0,-1424(a0) # ffffffffc02968a8 <pages>
ffffffffc0201e40:	4585                	li	a1,1
ffffffffc0201e42:	9522                	add	a0,a0,s0
ffffffffc0201e44:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201e48:	399000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0201e4c:	6442                	ld	s0,16(sp)
ffffffffc0201e4e:	60e2                	ld	ra,24(sp)
ffffffffc0201e50:	8526                	mv	a0,s1
ffffffffc0201e52:	64a2                	ld	s1,8(sp)
ffffffffc0201e54:	45e1                	li	a1,24
ffffffffc0201e56:	6105                	addi	sp,sp,32
ffffffffc0201e58:	b171                	j	ffffffffc0201ae4 <slob_free>
ffffffffc0201e5a:	e20d                	bnez	a2,ffffffffc0201e7c <kfree+0xb6>
ffffffffc0201e5c:	ff040513          	addi	a0,s0,-16
ffffffffc0201e60:	6442                	ld	s0,16(sp)
ffffffffc0201e62:	60e2                	ld	ra,24(sp)
ffffffffc0201e64:	64a2                	ld	s1,8(sp)
ffffffffc0201e66:	4581                	li	a1,0
ffffffffc0201e68:	6105                	addi	sp,sp,32
ffffffffc0201e6a:	b9ad                	j	ffffffffc0201ae4 <slob_free>
ffffffffc0201e6c:	f39fe0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0201e70:	00095797          	auipc	a5,0x95
ffffffffc0201e74:	a187b783          	ld	a5,-1512(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0201e78:	4605                	li	a2,1
ffffffffc0201e7a:	fbad                	bnez	a5,ffffffffc0201dec <kfree+0x26>
ffffffffc0201e7c:	f23fe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0201e80:	bff1                	j	ffffffffc0201e5c <kfree+0x96>
ffffffffc0201e82:	f1dfe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0201e86:	b751                	j	ffffffffc0201e0a <kfree+0x44>
ffffffffc0201e88:	8082                	ret
ffffffffc0201e8a:	0000a617          	auipc	a2,0xa
ffffffffc0201e8e:	56e60613          	addi	a2,a2,1390 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc0201e92:	06900593          	li	a1,105
ffffffffc0201e96:	0000a517          	auipc	a0,0xa
ffffffffc0201e9a:	4ba50513          	addi	a0,a0,1210 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0201e9e:	b90fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0201ea2:	86a2                	mv	a3,s0
ffffffffc0201ea4:	0000a617          	auipc	a2,0xa
ffffffffc0201ea8:	52c60613          	addi	a2,a2,1324 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0201eac:	07700593          	li	a1,119
ffffffffc0201eb0:	0000a517          	auipc	a0,0xa
ffffffffc0201eb4:	4a050513          	addi	a0,a0,1184 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0201eb8:	b76fe0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0201ebc <default_init>:
ffffffffc0201ebc:	00090797          	auipc	a5,0x90
ffffffffc0201ec0:	8ec78793          	addi	a5,a5,-1812 # ffffffffc02917a8 <free_area>
ffffffffc0201ec4:	e79c                	sd	a5,8(a5)
ffffffffc0201ec6:	e39c                	sd	a5,0(a5)
ffffffffc0201ec8:	0007a823          	sw	zero,16(a5)
ffffffffc0201ecc:	8082                	ret

ffffffffc0201ece <default_nr_free_pages>:
ffffffffc0201ece:	00090517          	auipc	a0,0x90
ffffffffc0201ed2:	8ea56503          	lwu	a0,-1814(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc0201ed6:	8082                	ret

ffffffffc0201ed8 <default_check>:
ffffffffc0201ed8:	715d                	addi	sp,sp,-80
ffffffffc0201eda:	e0a2                	sd	s0,64(sp)
ffffffffc0201edc:	00090417          	auipc	s0,0x90
ffffffffc0201ee0:	8cc40413          	addi	s0,s0,-1844 # ffffffffc02917a8 <free_area>
ffffffffc0201ee4:	641c                	ld	a5,8(s0)
ffffffffc0201ee6:	e486                	sd	ra,72(sp)
ffffffffc0201ee8:	fc26                	sd	s1,56(sp)
ffffffffc0201eea:	f84a                	sd	s2,48(sp)
ffffffffc0201eec:	f44e                	sd	s3,40(sp)
ffffffffc0201eee:	f052                	sd	s4,32(sp)
ffffffffc0201ef0:	ec56                	sd	s5,24(sp)
ffffffffc0201ef2:	e85a                	sd	s6,16(sp)
ffffffffc0201ef4:	e45e                	sd	s7,8(sp)
ffffffffc0201ef6:	e062                	sd	s8,0(sp)
ffffffffc0201ef8:	2a878d63          	beq	a5,s0,ffffffffc02021b2 <default_check+0x2da>
ffffffffc0201efc:	4481                	li	s1,0
ffffffffc0201efe:	4901                	li	s2,0
ffffffffc0201f00:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201f04:	8b09                	andi	a4,a4,2
ffffffffc0201f06:	2a070a63          	beqz	a4,ffffffffc02021ba <default_check+0x2e2>
ffffffffc0201f0a:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201f0e:	679c                	ld	a5,8(a5)
ffffffffc0201f10:	2905                	addiw	s2,s2,1
ffffffffc0201f12:	9cb9                	addw	s1,s1,a4
ffffffffc0201f14:	fe8796e3          	bne	a5,s0,ffffffffc0201f00 <default_check+0x28>
ffffffffc0201f18:	89a6                	mv	s3,s1
ffffffffc0201f1a:	307000ef          	jal	ra,ffffffffc0202a20 <nr_free_pages>
ffffffffc0201f1e:	6f351e63          	bne	a0,s3,ffffffffc020261a <default_check+0x742>
ffffffffc0201f22:	4505                	li	a0,1
ffffffffc0201f24:	27f000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0201f28:	8aaa                	mv	s5,a0
ffffffffc0201f2a:	42050863          	beqz	a0,ffffffffc020235a <default_check+0x482>
ffffffffc0201f2e:	4505                	li	a0,1
ffffffffc0201f30:	273000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0201f34:	89aa                	mv	s3,a0
ffffffffc0201f36:	70050263          	beqz	a0,ffffffffc020263a <default_check+0x762>
ffffffffc0201f3a:	4505                	li	a0,1
ffffffffc0201f3c:	267000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0201f40:	8a2a                	mv	s4,a0
ffffffffc0201f42:	48050c63          	beqz	a0,ffffffffc02023da <default_check+0x502>
ffffffffc0201f46:	293a8a63          	beq	s5,s3,ffffffffc02021da <default_check+0x302>
ffffffffc0201f4a:	28aa8863          	beq	s5,a0,ffffffffc02021da <default_check+0x302>
ffffffffc0201f4e:	28a98663          	beq	s3,a0,ffffffffc02021da <default_check+0x302>
ffffffffc0201f52:	000aa783          	lw	a5,0(s5)
ffffffffc0201f56:	2a079263          	bnez	a5,ffffffffc02021fa <default_check+0x322>
ffffffffc0201f5a:	0009a783          	lw	a5,0(s3) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0201f5e:	28079e63          	bnez	a5,ffffffffc02021fa <default_check+0x322>
ffffffffc0201f62:	411c                	lw	a5,0(a0)
ffffffffc0201f64:	28079b63          	bnez	a5,ffffffffc02021fa <default_check+0x322>
ffffffffc0201f68:	00095797          	auipc	a5,0x95
ffffffffc0201f6c:	9407b783          	ld	a5,-1728(a5) # ffffffffc02968a8 <pages>
ffffffffc0201f70:	40fa8733          	sub	a4,s5,a5
ffffffffc0201f74:	0000d617          	auipc	a2,0xd
ffffffffc0201f78:	76c63603          	ld	a2,1900(a2) # ffffffffc020f6e0 <nbase>
ffffffffc0201f7c:	8719                	srai	a4,a4,0x6
ffffffffc0201f7e:	9732                	add	a4,a4,a2
ffffffffc0201f80:	00095697          	auipc	a3,0x95
ffffffffc0201f84:	9206b683          	ld	a3,-1760(a3) # ffffffffc02968a0 <npage>
ffffffffc0201f88:	06b2                	slli	a3,a3,0xc
ffffffffc0201f8a:	0732                	slli	a4,a4,0xc
ffffffffc0201f8c:	28d77763          	bgeu	a4,a3,ffffffffc020221a <default_check+0x342>
ffffffffc0201f90:	40f98733          	sub	a4,s3,a5
ffffffffc0201f94:	8719                	srai	a4,a4,0x6
ffffffffc0201f96:	9732                	add	a4,a4,a2
ffffffffc0201f98:	0732                	slli	a4,a4,0xc
ffffffffc0201f9a:	4cd77063          	bgeu	a4,a3,ffffffffc020245a <default_check+0x582>
ffffffffc0201f9e:	40f507b3          	sub	a5,a0,a5
ffffffffc0201fa2:	8799                	srai	a5,a5,0x6
ffffffffc0201fa4:	97b2                	add	a5,a5,a2
ffffffffc0201fa6:	07b2                	slli	a5,a5,0xc
ffffffffc0201fa8:	30d7f963          	bgeu	a5,a3,ffffffffc02022ba <default_check+0x3e2>
ffffffffc0201fac:	4505                	li	a0,1
ffffffffc0201fae:	00043c03          	ld	s8,0(s0)
ffffffffc0201fb2:	00843b83          	ld	s7,8(s0)
ffffffffc0201fb6:	01042b03          	lw	s6,16(s0)
ffffffffc0201fba:	e400                	sd	s0,8(s0)
ffffffffc0201fbc:	e000                	sd	s0,0(s0)
ffffffffc0201fbe:	0008f797          	auipc	a5,0x8f
ffffffffc0201fc2:	7e07ad23          	sw	zero,2042(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc0201fc6:	1dd000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0201fca:	2c051863          	bnez	a0,ffffffffc020229a <default_check+0x3c2>
ffffffffc0201fce:	4585                	li	a1,1
ffffffffc0201fd0:	8556                	mv	a0,s5
ffffffffc0201fd2:	20f000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0201fd6:	4585                	li	a1,1
ffffffffc0201fd8:	854e                	mv	a0,s3
ffffffffc0201fda:	207000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0201fde:	4585                	li	a1,1
ffffffffc0201fe0:	8552                	mv	a0,s4
ffffffffc0201fe2:	1ff000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0201fe6:	4818                	lw	a4,16(s0)
ffffffffc0201fe8:	478d                	li	a5,3
ffffffffc0201fea:	28f71863          	bne	a4,a5,ffffffffc020227a <default_check+0x3a2>
ffffffffc0201fee:	4505                	li	a0,1
ffffffffc0201ff0:	1b3000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0201ff4:	89aa                	mv	s3,a0
ffffffffc0201ff6:	26050263          	beqz	a0,ffffffffc020225a <default_check+0x382>
ffffffffc0201ffa:	4505                	li	a0,1
ffffffffc0201ffc:	1a7000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0202000:	8aaa                	mv	s5,a0
ffffffffc0202002:	3a050c63          	beqz	a0,ffffffffc02023ba <default_check+0x4e2>
ffffffffc0202006:	4505                	li	a0,1
ffffffffc0202008:	19b000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc020200c:	8a2a                	mv	s4,a0
ffffffffc020200e:	38050663          	beqz	a0,ffffffffc020239a <default_check+0x4c2>
ffffffffc0202012:	4505                	li	a0,1
ffffffffc0202014:	18f000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0202018:	36051163          	bnez	a0,ffffffffc020237a <default_check+0x4a2>
ffffffffc020201c:	4585                	li	a1,1
ffffffffc020201e:	854e                	mv	a0,s3
ffffffffc0202020:	1c1000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0202024:	641c                	ld	a5,8(s0)
ffffffffc0202026:	20878a63          	beq	a5,s0,ffffffffc020223a <default_check+0x362>
ffffffffc020202a:	4505                	li	a0,1
ffffffffc020202c:	177000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0202030:	30a99563          	bne	s3,a0,ffffffffc020233a <default_check+0x462>
ffffffffc0202034:	4505                	li	a0,1
ffffffffc0202036:	16d000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc020203a:	2e051063          	bnez	a0,ffffffffc020231a <default_check+0x442>
ffffffffc020203e:	481c                	lw	a5,16(s0)
ffffffffc0202040:	2a079d63          	bnez	a5,ffffffffc02022fa <default_check+0x422>
ffffffffc0202044:	854e                	mv	a0,s3
ffffffffc0202046:	4585                	li	a1,1
ffffffffc0202048:	01843023          	sd	s8,0(s0)
ffffffffc020204c:	01743423          	sd	s7,8(s0)
ffffffffc0202050:	01642823          	sw	s6,16(s0)
ffffffffc0202054:	18d000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0202058:	4585                	li	a1,1
ffffffffc020205a:	8556                	mv	a0,s5
ffffffffc020205c:	185000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0202060:	4585                	li	a1,1
ffffffffc0202062:	8552                	mv	a0,s4
ffffffffc0202064:	17d000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0202068:	4515                	li	a0,5
ffffffffc020206a:	139000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc020206e:	89aa                	mv	s3,a0
ffffffffc0202070:	26050563          	beqz	a0,ffffffffc02022da <default_check+0x402>
ffffffffc0202074:	651c                	ld	a5,8(a0)
ffffffffc0202076:	8385                	srli	a5,a5,0x1
ffffffffc0202078:	8b85                	andi	a5,a5,1
ffffffffc020207a:	54079063          	bnez	a5,ffffffffc02025ba <default_check+0x6e2>
ffffffffc020207e:	4505                	li	a0,1
ffffffffc0202080:	00043b03          	ld	s6,0(s0)
ffffffffc0202084:	00843a83          	ld	s5,8(s0)
ffffffffc0202088:	e000                	sd	s0,0(s0)
ffffffffc020208a:	e400                	sd	s0,8(s0)
ffffffffc020208c:	117000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0202090:	50051563          	bnez	a0,ffffffffc020259a <default_check+0x6c2>
ffffffffc0202094:	08098a13          	addi	s4,s3,128
ffffffffc0202098:	8552                	mv	a0,s4
ffffffffc020209a:	458d                	li	a1,3
ffffffffc020209c:	01042b83          	lw	s7,16(s0)
ffffffffc02020a0:	0008f797          	auipc	a5,0x8f
ffffffffc02020a4:	7007ac23          	sw	zero,1816(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02020a8:	139000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc02020ac:	4511                	li	a0,4
ffffffffc02020ae:	0f5000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc02020b2:	4c051463          	bnez	a0,ffffffffc020257a <default_check+0x6a2>
ffffffffc02020b6:	0889b783          	ld	a5,136(s3)
ffffffffc02020ba:	8385                	srli	a5,a5,0x1
ffffffffc02020bc:	8b85                	andi	a5,a5,1
ffffffffc02020be:	48078e63          	beqz	a5,ffffffffc020255a <default_check+0x682>
ffffffffc02020c2:	0909a703          	lw	a4,144(s3)
ffffffffc02020c6:	478d                	li	a5,3
ffffffffc02020c8:	48f71963          	bne	a4,a5,ffffffffc020255a <default_check+0x682>
ffffffffc02020cc:	450d                	li	a0,3
ffffffffc02020ce:	0d5000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc02020d2:	8c2a                	mv	s8,a0
ffffffffc02020d4:	46050363          	beqz	a0,ffffffffc020253a <default_check+0x662>
ffffffffc02020d8:	4505                	li	a0,1
ffffffffc02020da:	0c9000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc02020de:	42051e63          	bnez	a0,ffffffffc020251a <default_check+0x642>
ffffffffc02020e2:	418a1c63          	bne	s4,s8,ffffffffc02024fa <default_check+0x622>
ffffffffc02020e6:	4585                	li	a1,1
ffffffffc02020e8:	854e                	mv	a0,s3
ffffffffc02020ea:	0f7000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc02020ee:	458d                	li	a1,3
ffffffffc02020f0:	8552                	mv	a0,s4
ffffffffc02020f2:	0ef000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc02020f6:	0089b783          	ld	a5,8(s3)
ffffffffc02020fa:	04098c13          	addi	s8,s3,64
ffffffffc02020fe:	8385                	srli	a5,a5,0x1
ffffffffc0202100:	8b85                	andi	a5,a5,1
ffffffffc0202102:	3c078c63          	beqz	a5,ffffffffc02024da <default_check+0x602>
ffffffffc0202106:	0109a703          	lw	a4,16(s3)
ffffffffc020210a:	4785                	li	a5,1
ffffffffc020210c:	3cf71763          	bne	a4,a5,ffffffffc02024da <default_check+0x602>
ffffffffc0202110:	008a3783          	ld	a5,8(s4) # 1008 <_binary_bin_swap_img_size-0x6cf8>
ffffffffc0202114:	8385                	srli	a5,a5,0x1
ffffffffc0202116:	8b85                	andi	a5,a5,1
ffffffffc0202118:	3a078163          	beqz	a5,ffffffffc02024ba <default_check+0x5e2>
ffffffffc020211c:	010a2703          	lw	a4,16(s4)
ffffffffc0202120:	478d                	li	a5,3
ffffffffc0202122:	38f71c63          	bne	a4,a5,ffffffffc02024ba <default_check+0x5e2>
ffffffffc0202126:	4505                	li	a0,1
ffffffffc0202128:	07b000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc020212c:	36a99763          	bne	s3,a0,ffffffffc020249a <default_check+0x5c2>
ffffffffc0202130:	4585                	li	a1,1
ffffffffc0202132:	0af000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0202136:	4509                	li	a0,2
ffffffffc0202138:	06b000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc020213c:	32aa1f63          	bne	s4,a0,ffffffffc020247a <default_check+0x5a2>
ffffffffc0202140:	4589                	li	a1,2
ffffffffc0202142:	09f000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0202146:	4585                	li	a1,1
ffffffffc0202148:	8562                	mv	a0,s8
ffffffffc020214a:	097000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc020214e:	4515                	li	a0,5
ffffffffc0202150:	053000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0202154:	89aa                	mv	s3,a0
ffffffffc0202156:	48050263          	beqz	a0,ffffffffc02025da <default_check+0x702>
ffffffffc020215a:	4505                	li	a0,1
ffffffffc020215c:	047000ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0202160:	2c051d63          	bnez	a0,ffffffffc020243a <default_check+0x562>
ffffffffc0202164:	481c                	lw	a5,16(s0)
ffffffffc0202166:	2a079a63          	bnez	a5,ffffffffc020241a <default_check+0x542>
ffffffffc020216a:	4595                	li	a1,5
ffffffffc020216c:	854e                	mv	a0,s3
ffffffffc020216e:	01742823          	sw	s7,16(s0)
ffffffffc0202172:	01643023          	sd	s6,0(s0)
ffffffffc0202176:	01543423          	sd	s5,8(s0)
ffffffffc020217a:	067000ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc020217e:	641c                	ld	a5,8(s0)
ffffffffc0202180:	00878963          	beq	a5,s0,ffffffffc0202192 <default_check+0x2ba>
ffffffffc0202184:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202188:	679c                	ld	a5,8(a5)
ffffffffc020218a:	397d                	addiw	s2,s2,-1
ffffffffc020218c:	9c99                	subw	s1,s1,a4
ffffffffc020218e:	fe879be3          	bne	a5,s0,ffffffffc0202184 <default_check+0x2ac>
ffffffffc0202192:	26091463          	bnez	s2,ffffffffc02023fa <default_check+0x522>
ffffffffc0202196:	46049263          	bnez	s1,ffffffffc02025fa <default_check+0x722>
ffffffffc020219a:	60a6                	ld	ra,72(sp)
ffffffffc020219c:	6406                	ld	s0,64(sp)
ffffffffc020219e:	74e2                	ld	s1,56(sp)
ffffffffc02021a0:	7942                	ld	s2,48(sp)
ffffffffc02021a2:	79a2                	ld	s3,40(sp)
ffffffffc02021a4:	7a02                	ld	s4,32(sp)
ffffffffc02021a6:	6ae2                	ld	s5,24(sp)
ffffffffc02021a8:	6b42                	ld	s6,16(sp)
ffffffffc02021aa:	6ba2                	ld	s7,8(sp)
ffffffffc02021ac:	6c02                	ld	s8,0(sp)
ffffffffc02021ae:	6161                	addi	sp,sp,80
ffffffffc02021b0:	8082                	ret
ffffffffc02021b2:	4981                	li	s3,0
ffffffffc02021b4:	4481                	li	s1,0
ffffffffc02021b6:	4901                	li	s2,0
ffffffffc02021b8:	b38d                	j	ffffffffc0201f1a <default_check+0x42>
ffffffffc02021ba:	0000a697          	auipc	a3,0xa
ffffffffc02021be:	25e68693          	addi	a3,a3,606 # ffffffffc020c418 <commands+0xc80>
ffffffffc02021c2:	00009617          	auipc	a2,0x9
ffffffffc02021c6:	63660613          	addi	a2,a2,1590 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02021ca:	0ef00593          	li	a1,239
ffffffffc02021ce:	0000a517          	auipc	a0,0xa
ffffffffc02021d2:	25a50513          	addi	a0,a0,602 # ffffffffc020c428 <commands+0xc90>
ffffffffc02021d6:	858fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02021da:	0000a697          	auipc	a3,0xa
ffffffffc02021de:	2e668693          	addi	a3,a3,742 # ffffffffc020c4c0 <commands+0xd28>
ffffffffc02021e2:	00009617          	auipc	a2,0x9
ffffffffc02021e6:	61660613          	addi	a2,a2,1558 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02021ea:	0bc00593          	li	a1,188
ffffffffc02021ee:	0000a517          	auipc	a0,0xa
ffffffffc02021f2:	23a50513          	addi	a0,a0,570 # ffffffffc020c428 <commands+0xc90>
ffffffffc02021f6:	838fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02021fa:	0000a697          	auipc	a3,0xa
ffffffffc02021fe:	2ee68693          	addi	a3,a3,750 # ffffffffc020c4e8 <commands+0xd50>
ffffffffc0202202:	00009617          	auipc	a2,0x9
ffffffffc0202206:	5f660613          	addi	a2,a2,1526 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020220a:	0bd00593          	li	a1,189
ffffffffc020220e:	0000a517          	auipc	a0,0xa
ffffffffc0202212:	21a50513          	addi	a0,a0,538 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202216:	818fe0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020221a:	0000a697          	auipc	a3,0xa
ffffffffc020221e:	30e68693          	addi	a3,a3,782 # ffffffffc020c528 <commands+0xd90>
ffffffffc0202222:	00009617          	auipc	a2,0x9
ffffffffc0202226:	5d660613          	addi	a2,a2,1494 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020222a:	0bf00593          	li	a1,191
ffffffffc020222e:	0000a517          	auipc	a0,0xa
ffffffffc0202232:	1fa50513          	addi	a0,a0,506 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202236:	ff9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020223a:	0000a697          	auipc	a3,0xa
ffffffffc020223e:	37668693          	addi	a3,a3,886 # ffffffffc020c5b0 <commands+0xe18>
ffffffffc0202242:	00009617          	auipc	a2,0x9
ffffffffc0202246:	5b660613          	addi	a2,a2,1462 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020224a:	0d800593          	li	a1,216
ffffffffc020224e:	0000a517          	auipc	a0,0xa
ffffffffc0202252:	1da50513          	addi	a0,a0,474 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202256:	fd9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020225a:	0000a697          	auipc	a3,0xa
ffffffffc020225e:	20668693          	addi	a3,a3,518 # ffffffffc020c460 <commands+0xcc8>
ffffffffc0202262:	00009617          	auipc	a2,0x9
ffffffffc0202266:	59660613          	addi	a2,a2,1430 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020226a:	0d100593          	li	a1,209
ffffffffc020226e:	0000a517          	auipc	a0,0xa
ffffffffc0202272:	1ba50513          	addi	a0,a0,442 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202276:	fb9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020227a:	0000a697          	auipc	a3,0xa
ffffffffc020227e:	32668693          	addi	a3,a3,806 # ffffffffc020c5a0 <commands+0xe08>
ffffffffc0202282:	00009617          	auipc	a2,0x9
ffffffffc0202286:	57660613          	addi	a2,a2,1398 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020228a:	0cf00593          	li	a1,207
ffffffffc020228e:	0000a517          	auipc	a0,0xa
ffffffffc0202292:	19a50513          	addi	a0,a0,410 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202296:	f99fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020229a:	0000a697          	auipc	a3,0xa
ffffffffc020229e:	2ee68693          	addi	a3,a3,750 # ffffffffc020c588 <commands+0xdf0>
ffffffffc02022a2:	00009617          	auipc	a2,0x9
ffffffffc02022a6:	55660613          	addi	a2,a2,1366 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02022aa:	0ca00593          	li	a1,202
ffffffffc02022ae:	0000a517          	auipc	a0,0xa
ffffffffc02022b2:	17a50513          	addi	a0,a0,378 # ffffffffc020c428 <commands+0xc90>
ffffffffc02022b6:	f79fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02022ba:	0000a697          	auipc	a3,0xa
ffffffffc02022be:	2ae68693          	addi	a3,a3,686 # ffffffffc020c568 <commands+0xdd0>
ffffffffc02022c2:	00009617          	auipc	a2,0x9
ffffffffc02022c6:	53660613          	addi	a2,a2,1334 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02022ca:	0c100593          	li	a1,193
ffffffffc02022ce:	0000a517          	auipc	a0,0xa
ffffffffc02022d2:	15a50513          	addi	a0,a0,346 # ffffffffc020c428 <commands+0xc90>
ffffffffc02022d6:	f59fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02022da:	0000a697          	auipc	a3,0xa
ffffffffc02022de:	31e68693          	addi	a3,a3,798 # ffffffffc020c5f8 <commands+0xe60>
ffffffffc02022e2:	00009617          	auipc	a2,0x9
ffffffffc02022e6:	51660613          	addi	a2,a2,1302 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02022ea:	0f700593          	li	a1,247
ffffffffc02022ee:	0000a517          	auipc	a0,0xa
ffffffffc02022f2:	13a50513          	addi	a0,a0,314 # ffffffffc020c428 <commands+0xc90>
ffffffffc02022f6:	f39fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02022fa:	0000a697          	auipc	a3,0xa
ffffffffc02022fe:	2ee68693          	addi	a3,a3,750 # ffffffffc020c5e8 <commands+0xe50>
ffffffffc0202302:	00009617          	auipc	a2,0x9
ffffffffc0202306:	4f660613          	addi	a2,a2,1270 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020230a:	0de00593          	li	a1,222
ffffffffc020230e:	0000a517          	auipc	a0,0xa
ffffffffc0202312:	11a50513          	addi	a0,a0,282 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202316:	f19fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020231a:	0000a697          	auipc	a3,0xa
ffffffffc020231e:	26e68693          	addi	a3,a3,622 # ffffffffc020c588 <commands+0xdf0>
ffffffffc0202322:	00009617          	auipc	a2,0x9
ffffffffc0202326:	4d660613          	addi	a2,a2,1238 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020232a:	0dc00593          	li	a1,220
ffffffffc020232e:	0000a517          	auipc	a0,0xa
ffffffffc0202332:	0fa50513          	addi	a0,a0,250 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202336:	ef9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020233a:	0000a697          	auipc	a3,0xa
ffffffffc020233e:	28e68693          	addi	a3,a3,654 # ffffffffc020c5c8 <commands+0xe30>
ffffffffc0202342:	00009617          	auipc	a2,0x9
ffffffffc0202346:	4b660613          	addi	a2,a2,1206 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020234a:	0db00593          	li	a1,219
ffffffffc020234e:	0000a517          	auipc	a0,0xa
ffffffffc0202352:	0da50513          	addi	a0,a0,218 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202356:	ed9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020235a:	0000a697          	auipc	a3,0xa
ffffffffc020235e:	10668693          	addi	a3,a3,262 # ffffffffc020c460 <commands+0xcc8>
ffffffffc0202362:	00009617          	auipc	a2,0x9
ffffffffc0202366:	49660613          	addi	a2,a2,1174 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020236a:	0b800593          	li	a1,184
ffffffffc020236e:	0000a517          	auipc	a0,0xa
ffffffffc0202372:	0ba50513          	addi	a0,a0,186 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202376:	eb9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020237a:	0000a697          	auipc	a3,0xa
ffffffffc020237e:	20e68693          	addi	a3,a3,526 # ffffffffc020c588 <commands+0xdf0>
ffffffffc0202382:	00009617          	auipc	a2,0x9
ffffffffc0202386:	47660613          	addi	a2,a2,1142 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020238a:	0d500593          	li	a1,213
ffffffffc020238e:	0000a517          	auipc	a0,0xa
ffffffffc0202392:	09a50513          	addi	a0,a0,154 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202396:	e99fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020239a:	0000a697          	auipc	a3,0xa
ffffffffc020239e:	10668693          	addi	a3,a3,262 # ffffffffc020c4a0 <commands+0xd08>
ffffffffc02023a2:	00009617          	auipc	a2,0x9
ffffffffc02023a6:	45660613          	addi	a2,a2,1110 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02023aa:	0d300593          	li	a1,211
ffffffffc02023ae:	0000a517          	auipc	a0,0xa
ffffffffc02023b2:	07a50513          	addi	a0,a0,122 # ffffffffc020c428 <commands+0xc90>
ffffffffc02023b6:	e79fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02023ba:	0000a697          	auipc	a3,0xa
ffffffffc02023be:	0c668693          	addi	a3,a3,198 # ffffffffc020c480 <commands+0xce8>
ffffffffc02023c2:	00009617          	auipc	a2,0x9
ffffffffc02023c6:	43660613          	addi	a2,a2,1078 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02023ca:	0d200593          	li	a1,210
ffffffffc02023ce:	0000a517          	auipc	a0,0xa
ffffffffc02023d2:	05a50513          	addi	a0,a0,90 # ffffffffc020c428 <commands+0xc90>
ffffffffc02023d6:	e59fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02023da:	0000a697          	auipc	a3,0xa
ffffffffc02023de:	0c668693          	addi	a3,a3,198 # ffffffffc020c4a0 <commands+0xd08>
ffffffffc02023e2:	00009617          	auipc	a2,0x9
ffffffffc02023e6:	41660613          	addi	a2,a2,1046 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02023ea:	0ba00593          	li	a1,186
ffffffffc02023ee:	0000a517          	auipc	a0,0xa
ffffffffc02023f2:	03a50513          	addi	a0,a0,58 # ffffffffc020c428 <commands+0xc90>
ffffffffc02023f6:	e39fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02023fa:	0000a697          	auipc	a3,0xa
ffffffffc02023fe:	34e68693          	addi	a3,a3,846 # ffffffffc020c748 <commands+0xfb0>
ffffffffc0202402:	00009617          	auipc	a2,0x9
ffffffffc0202406:	3f660613          	addi	a2,a2,1014 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020240a:	12400593          	li	a1,292
ffffffffc020240e:	0000a517          	auipc	a0,0xa
ffffffffc0202412:	01a50513          	addi	a0,a0,26 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202416:	e19fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020241a:	0000a697          	auipc	a3,0xa
ffffffffc020241e:	1ce68693          	addi	a3,a3,462 # ffffffffc020c5e8 <commands+0xe50>
ffffffffc0202422:	00009617          	auipc	a2,0x9
ffffffffc0202426:	3d660613          	addi	a2,a2,982 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020242a:	11900593          	li	a1,281
ffffffffc020242e:	0000a517          	auipc	a0,0xa
ffffffffc0202432:	ffa50513          	addi	a0,a0,-6 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202436:	df9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020243a:	0000a697          	auipc	a3,0xa
ffffffffc020243e:	14e68693          	addi	a3,a3,334 # ffffffffc020c588 <commands+0xdf0>
ffffffffc0202442:	00009617          	auipc	a2,0x9
ffffffffc0202446:	3b660613          	addi	a2,a2,950 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020244a:	11700593          	li	a1,279
ffffffffc020244e:	0000a517          	auipc	a0,0xa
ffffffffc0202452:	fda50513          	addi	a0,a0,-38 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202456:	dd9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020245a:	0000a697          	auipc	a3,0xa
ffffffffc020245e:	0ee68693          	addi	a3,a3,238 # ffffffffc020c548 <commands+0xdb0>
ffffffffc0202462:	00009617          	auipc	a2,0x9
ffffffffc0202466:	39660613          	addi	a2,a2,918 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020246a:	0c000593          	li	a1,192
ffffffffc020246e:	0000a517          	auipc	a0,0xa
ffffffffc0202472:	fba50513          	addi	a0,a0,-70 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202476:	db9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020247a:	0000a697          	auipc	a3,0xa
ffffffffc020247e:	28e68693          	addi	a3,a3,654 # ffffffffc020c708 <commands+0xf70>
ffffffffc0202482:	00009617          	auipc	a2,0x9
ffffffffc0202486:	37660613          	addi	a2,a2,886 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020248a:	11100593          	li	a1,273
ffffffffc020248e:	0000a517          	auipc	a0,0xa
ffffffffc0202492:	f9a50513          	addi	a0,a0,-102 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202496:	d99fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020249a:	0000a697          	auipc	a3,0xa
ffffffffc020249e:	24e68693          	addi	a3,a3,590 # ffffffffc020c6e8 <commands+0xf50>
ffffffffc02024a2:	00009617          	auipc	a2,0x9
ffffffffc02024a6:	35660613          	addi	a2,a2,854 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02024aa:	10f00593          	li	a1,271
ffffffffc02024ae:	0000a517          	auipc	a0,0xa
ffffffffc02024b2:	f7a50513          	addi	a0,a0,-134 # ffffffffc020c428 <commands+0xc90>
ffffffffc02024b6:	d79fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02024ba:	0000a697          	auipc	a3,0xa
ffffffffc02024be:	20668693          	addi	a3,a3,518 # ffffffffc020c6c0 <commands+0xf28>
ffffffffc02024c2:	00009617          	auipc	a2,0x9
ffffffffc02024c6:	33660613          	addi	a2,a2,822 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02024ca:	10d00593          	li	a1,269
ffffffffc02024ce:	0000a517          	auipc	a0,0xa
ffffffffc02024d2:	f5a50513          	addi	a0,a0,-166 # ffffffffc020c428 <commands+0xc90>
ffffffffc02024d6:	d59fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02024da:	0000a697          	auipc	a3,0xa
ffffffffc02024de:	1be68693          	addi	a3,a3,446 # ffffffffc020c698 <commands+0xf00>
ffffffffc02024e2:	00009617          	auipc	a2,0x9
ffffffffc02024e6:	31660613          	addi	a2,a2,790 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02024ea:	10c00593          	li	a1,268
ffffffffc02024ee:	0000a517          	auipc	a0,0xa
ffffffffc02024f2:	f3a50513          	addi	a0,a0,-198 # ffffffffc020c428 <commands+0xc90>
ffffffffc02024f6:	d39fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02024fa:	0000a697          	auipc	a3,0xa
ffffffffc02024fe:	18e68693          	addi	a3,a3,398 # ffffffffc020c688 <commands+0xef0>
ffffffffc0202502:	00009617          	auipc	a2,0x9
ffffffffc0202506:	2f660613          	addi	a2,a2,758 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020250a:	10700593          	li	a1,263
ffffffffc020250e:	0000a517          	auipc	a0,0xa
ffffffffc0202512:	f1a50513          	addi	a0,a0,-230 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202516:	d19fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020251a:	0000a697          	auipc	a3,0xa
ffffffffc020251e:	06e68693          	addi	a3,a3,110 # ffffffffc020c588 <commands+0xdf0>
ffffffffc0202522:	00009617          	auipc	a2,0x9
ffffffffc0202526:	2d660613          	addi	a2,a2,726 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020252a:	10600593          	li	a1,262
ffffffffc020252e:	0000a517          	auipc	a0,0xa
ffffffffc0202532:	efa50513          	addi	a0,a0,-262 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202536:	cf9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020253a:	0000a697          	auipc	a3,0xa
ffffffffc020253e:	12e68693          	addi	a3,a3,302 # ffffffffc020c668 <commands+0xed0>
ffffffffc0202542:	00009617          	auipc	a2,0x9
ffffffffc0202546:	2b660613          	addi	a2,a2,694 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020254a:	10500593          	li	a1,261
ffffffffc020254e:	0000a517          	auipc	a0,0xa
ffffffffc0202552:	eda50513          	addi	a0,a0,-294 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202556:	cd9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020255a:	0000a697          	auipc	a3,0xa
ffffffffc020255e:	0de68693          	addi	a3,a3,222 # ffffffffc020c638 <commands+0xea0>
ffffffffc0202562:	00009617          	auipc	a2,0x9
ffffffffc0202566:	29660613          	addi	a2,a2,662 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020256a:	10400593          	li	a1,260
ffffffffc020256e:	0000a517          	auipc	a0,0xa
ffffffffc0202572:	eba50513          	addi	a0,a0,-326 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202576:	cb9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020257a:	0000a697          	auipc	a3,0xa
ffffffffc020257e:	0a668693          	addi	a3,a3,166 # ffffffffc020c620 <commands+0xe88>
ffffffffc0202582:	00009617          	auipc	a2,0x9
ffffffffc0202586:	27660613          	addi	a2,a2,630 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020258a:	10300593          	li	a1,259
ffffffffc020258e:	0000a517          	auipc	a0,0xa
ffffffffc0202592:	e9a50513          	addi	a0,a0,-358 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202596:	c99fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020259a:	0000a697          	auipc	a3,0xa
ffffffffc020259e:	fee68693          	addi	a3,a3,-18 # ffffffffc020c588 <commands+0xdf0>
ffffffffc02025a2:	00009617          	auipc	a2,0x9
ffffffffc02025a6:	25660613          	addi	a2,a2,598 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02025aa:	0fd00593          	li	a1,253
ffffffffc02025ae:	0000a517          	auipc	a0,0xa
ffffffffc02025b2:	e7a50513          	addi	a0,a0,-390 # ffffffffc020c428 <commands+0xc90>
ffffffffc02025b6:	c79fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02025ba:	0000a697          	auipc	a3,0xa
ffffffffc02025be:	04e68693          	addi	a3,a3,78 # ffffffffc020c608 <commands+0xe70>
ffffffffc02025c2:	00009617          	auipc	a2,0x9
ffffffffc02025c6:	23660613          	addi	a2,a2,566 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02025ca:	0f800593          	li	a1,248
ffffffffc02025ce:	0000a517          	auipc	a0,0xa
ffffffffc02025d2:	e5a50513          	addi	a0,a0,-422 # ffffffffc020c428 <commands+0xc90>
ffffffffc02025d6:	c59fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02025da:	0000a697          	auipc	a3,0xa
ffffffffc02025de:	14e68693          	addi	a3,a3,334 # ffffffffc020c728 <commands+0xf90>
ffffffffc02025e2:	00009617          	auipc	a2,0x9
ffffffffc02025e6:	21660613          	addi	a2,a2,534 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02025ea:	11600593          	li	a1,278
ffffffffc02025ee:	0000a517          	auipc	a0,0xa
ffffffffc02025f2:	e3a50513          	addi	a0,a0,-454 # ffffffffc020c428 <commands+0xc90>
ffffffffc02025f6:	c39fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02025fa:	0000a697          	auipc	a3,0xa
ffffffffc02025fe:	15e68693          	addi	a3,a3,350 # ffffffffc020c758 <commands+0xfc0>
ffffffffc0202602:	00009617          	auipc	a2,0x9
ffffffffc0202606:	1f660613          	addi	a2,a2,502 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020260a:	12500593          	li	a1,293
ffffffffc020260e:	0000a517          	auipc	a0,0xa
ffffffffc0202612:	e1a50513          	addi	a0,a0,-486 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202616:	c19fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020261a:	0000a697          	auipc	a3,0xa
ffffffffc020261e:	e2668693          	addi	a3,a3,-474 # ffffffffc020c440 <commands+0xca8>
ffffffffc0202622:	00009617          	auipc	a2,0x9
ffffffffc0202626:	1d660613          	addi	a2,a2,470 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020262a:	0f200593          	li	a1,242
ffffffffc020262e:	0000a517          	auipc	a0,0xa
ffffffffc0202632:	dfa50513          	addi	a0,a0,-518 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202636:	bf9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020263a:	0000a697          	auipc	a3,0xa
ffffffffc020263e:	e4668693          	addi	a3,a3,-442 # ffffffffc020c480 <commands+0xce8>
ffffffffc0202642:	00009617          	auipc	a2,0x9
ffffffffc0202646:	1b660613          	addi	a2,a2,438 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020264a:	0b900593          	li	a1,185
ffffffffc020264e:	0000a517          	auipc	a0,0xa
ffffffffc0202652:	dda50513          	addi	a0,a0,-550 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202656:	bd9fd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020265a <default_free_pages>:
ffffffffc020265a:	1141                	addi	sp,sp,-16
ffffffffc020265c:	e406                	sd	ra,8(sp)
ffffffffc020265e:	14058463          	beqz	a1,ffffffffc02027a6 <default_free_pages+0x14c>
ffffffffc0202662:	00659693          	slli	a3,a1,0x6
ffffffffc0202666:	96aa                	add	a3,a3,a0
ffffffffc0202668:	87aa                	mv	a5,a0
ffffffffc020266a:	02d50263          	beq	a0,a3,ffffffffc020268e <default_free_pages+0x34>
ffffffffc020266e:	6798                	ld	a4,8(a5)
ffffffffc0202670:	8b05                	andi	a4,a4,1
ffffffffc0202672:	10071a63          	bnez	a4,ffffffffc0202786 <default_free_pages+0x12c>
ffffffffc0202676:	6798                	ld	a4,8(a5)
ffffffffc0202678:	8b09                	andi	a4,a4,2
ffffffffc020267a:	10071663          	bnez	a4,ffffffffc0202786 <default_free_pages+0x12c>
ffffffffc020267e:	0007b423          	sd	zero,8(a5)
ffffffffc0202682:	0007a023          	sw	zero,0(a5)
ffffffffc0202686:	04078793          	addi	a5,a5,64
ffffffffc020268a:	fed792e3          	bne	a5,a3,ffffffffc020266e <default_free_pages+0x14>
ffffffffc020268e:	2581                	sext.w	a1,a1
ffffffffc0202690:	c90c                	sw	a1,16(a0)
ffffffffc0202692:	00850893          	addi	a7,a0,8
ffffffffc0202696:	4789                	li	a5,2
ffffffffc0202698:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc020269c:	0008f697          	auipc	a3,0x8f
ffffffffc02026a0:	10c68693          	addi	a3,a3,268 # ffffffffc02917a8 <free_area>
ffffffffc02026a4:	4a98                	lw	a4,16(a3)
ffffffffc02026a6:	669c                	ld	a5,8(a3)
ffffffffc02026a8:	01850613          	addi	a2,a0,24
ffffffffc02026ac:	9db9                	addw	a1,a1,a4
ffffffffc02026ae:	ca8c                	sw	a1,16(a3)
ffffffffc02026b0:	0ad78463          	beq	a5,a3,ffffffffc0202758 <default_free_pages+0xfe>
ffffffffc02026b4:	fe878713          	addi	a4,a5,-24
ffffffffc02026b8:	0006b803          	ld	a6,0(a3)
ffffffffc02026bc:	4581                	li	a1,0
ffffffffc02026be:	00e56a63          	bltu	a0,a4,ffffffffc02026d2 <default_free_pages+0x78>
ffffffffc02026c2:	6798                	ld	a4,8(a5)
ffffffffc02026c4:	04d70c63          	beq	a4,a3,ffffffffc020271c <default_free_pages+0xc2>
ffffffffc02026c8:	87ba                	mv	a5,a4
ffffffffc02026ca:	fe878713          	addi	a4,a5,-24
ffffffffc02026ce:	fee57ae3          	bgeu	a0,a4,ffffffffc02026c2 <default_free_pages+0x68>
ffffffffc02026d2:	c199                	beqz	a1,ffffffffc02026d8 <default_free_pages+0x7e>
ffffffffc02026d4:	0106b023          	sd	a6,0(a3)
ffffffffc02026d8:	6398                	ld	a4,0(a5)
ffffffffc02026da:	e390                	sd	a2,0(a5)
ffffffffc02026dc:	e710                	sd	a2,8(a4)
ffffffffc02026de:	f11c                	sd	a5,32(a0)
ffffffffc02026e0:	ed18                	sd	a4,24(a0)
ffffffffc02026e2:	00d70d63          	beq	a4,a3,ffffffffc02026fc <default_free_pages+0xa2>
ffffffffc02026e6:	ff872583          	lw	a1,-8(a4) # ff8 <_binary_bin_swap_img_size-0x6d08>
ffffffffc02026ea:	fe870613          	addi	a2,a4,-24
ffffffffc02026ee:	02059813          	slli	a6,a1,0x20
ffffffffc02026f2:	01a85793          	srli	a5,a6,0x1a
ffffffffc02026f6:	97b2                	add	a5,a5,a2
ffffffffc02026f8:	02f50c63          	beq	a0,a5,ffffffffc0202730 <default_free_pages+0xd6>
ffffffffc02026fc:	711c                	ld	a5,32(a0)
ffffffffc02026fe:	00d78c63          	beq	a5,a3,ffffffffc0202716 <default_free_pages+0xbc>
ffffffffc0202702:	4910                	lw	a2,16(a0)
ffffffffc0202704:	fe878693          	addi	a3,a5,-24
ffffffffc0202708:	02061593          	slli	a1,a2,0x20
ffffffffc020270c:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0202710:	972a                	add	a4,a4,a0
ffffffffc0202712:	04e68a63          	beq	a3,a4,ffffffffc0202766 <default_free_pages+0x10c>
ffffffffc0202716:	60a2                	ld	ra,8(sp)
ffffffffc0202718:	0141                	addi	sp,sp,16
ffffffffc020271a:	8082                	ret
ffffffffc020271c:	e790                	sd	a2,8(a5)
ffffffffc020271e:	f114                	sd	a3,32(a0)
ffffffffc0202720:	6798                	ld	a4,8(a5)
ffffffffc0202722:	ed1c                	sd	a5,24(a0)
ffffffffc0202724:	02d70763          	beq	a4,a3,ffffffffc0202752 <default_free_pages+0xf8>
ffffffffc0202728:	8832                	mv	a6,a2
ffffffffc020272a:	4585                	li	a1,1
ffffffffc020272c:	87ba                	mv	a5,a4
ffffffffc020272e:	bf71                	j	ffffffffc02026ca <default_free_pages+0x70>
ffffffffc0202730:	491c                	lw	a5,16(a0)
ffffffffc0202732:	9dbd                	addw	a1,a1,a5
ffffffffc0202734:	feb72c23          	sw	a1,-8(a4)
ffffffffc0202738:	57f5                	li	a5,-3
ffffffffc020273a:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc020273e:	01853803          	ld	a6,24(a0)
ffffffffc0202742:	710c                	ld	a1,32(a0)
ffffffffc0202744:	8532                	mv	a0,a2
ffffffffc0202746:	00b83423          	sd	a1,8(a6)
ffffffffc020274a:	671c                	ld	a5,8(a4)
ffffffffc020274c:	0105b023          	sd	a6,0(a1) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202750:	b77d                	j	ffffffffc02026fe <default_free_pages+0xa4>
ffffffffc0202752:	e290                	sd	a2,0(a3)
ffffffffc0202754:	873e                	mv	a4,a5
ffffffffc0202756:	bf41                	j	ffffffffc02026e6 <default_free_pages+0x8c>
ffffffffc0202758:	60a2                	ld	ra,8(sp)
ffffffffc020275a:	e390                	sd	a2,0(a5)
ffffffffc020275c:	e790                	sd	a2,8(a5)
ffffffffc020275e:	f11c                	sd	a5,32(a0)
ffffffffc0202760:	ed1c                	sd	a5,24(a0)
ffffffffc0202762:	0141                	addi	sp,sp,16
ffffffffc0202764:	8082                	ret
ffffffffc0202766:	ff87a703          	lw	a4,-8(a5)
ffffffffc020276a:	ff078693          	addi	a3,a5,-16
ffffffffc020276e:	9e39                	addw	a2,a2,a4
ffffffffc0202770:	c910                	sw	a2,16(a0)
ffffffffc0202772:	5775                	li	a4,-3
ffffffffc0202774:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0202778:	6398                	ld	a4,0(a5)
ffffffffc020277a:	679c                	ld	a5,8(a5)
ffffffffc020277c:	60a2                	ld	ra,8(sp)
ffffffffc020277e:	e71c                	sd	a5,8(a4)
ffffffffc0202780:	e398                	sd	a4,0(a5)
ffffffffc0202782:	0141                	addi	sp,sp,16
ffffffffc0202784:	8082                	ret
ffffffffc0202786:	0000a697          	auipc	a3,0xa
ffffffffc020278a:	fea68693          	addi	a3,a3,-22 # ffffffffc020c770 <commands+0xfd8>
ffffffffc020278e:	00009617          	auipc	a2,0x9
ffffffffc0202792:	06a60613          	addi	a2,a2,106 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0202796:	08200593          	li	a1,130
ffffffffc020279a:	0000a517          	auipc	a0,0xa
ffffffffc020279e:	c8e50513          	addi	a0,a0,-882 # ffffffffc020c428 <commands+0xc90>
ffffffffc02027a2:	a8dfd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02027a6:	0000a697          	auipc	a3,0xa
ffffffffc02027aa:	fc268693          	addi	a3,a3,-62 # ffffffffc020c768 <commands+0xfd0>
ffffffffc02027ae:	00009617          	auipc	a2,0x9
ffffffffc02027b2:	04a60613          	addi	a2,a2,74 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02027b6:	07f00593          	li	a1,127
ffffffffc02027ba:	0000a517          	auipc	a0,0xa
ffffffffc02027be:	c6e50513          	addi	a0,a0,-914 # ffffffffc020c428 <commands+0xc90>
ffffffffc02027c2:	a6dfd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02027c6 <default_alloc_pages>:
ffffffffc02027c6:	c941                	beqz	a0,ffffffffc0202856 <default_alloc_pages+0x90>
ffffffffc02027c8:	0008f597          	auipc	a1,0x8f
ffffffffc02027cc:	fe058593          	addi	a1,a1,-32 # ffffffffc02917a8 <free_area>
ffffffffc02027d0:	0105a803          	lw	a6,16(a1)
ffffffffc02027d4:	872a                	mv	a4,a0
ffffffffc02027d6:	02081793          	slli	a5,a6,0x20
ffffffffc02027da:	9381                	srli	a5,a5,0x20
ffffffffc02027dc:	00a7ee63          	bltu	a5,a0,ffffffffc02027f8 <default_alloc_pages+0x32>
ffffffffc02027e0:	87ae                	mv	a5,a1
ffffffffc02027e2:	a801                	j	ffffffffc02027f2 <default_alloc_pages+0x2c>
ffffffffc02027e4:	ff87a683          	lw	a3,-8(a5)
ffffffffc02027e8:	02069613          	slli	a2,a3,0x20
ffffffffc02027ec:	9201                	srli	a2,a2,0x20
ffffffffc02027ee:	00e67763          	bgeu	a2,a4,ffffffffc02027fc <default_alloc_pages+0x36>
ffffffffc02027f2:	679c                	ld	a5,8(a5)
ffffffffc02027f4:	feb798e3          	bne	a5,a1,ffffffffc02027e4 <default_alloc_pages+0x1e>
ffffffffc02027f8:	4501                	li	a0,0
ffffffffc02027fa:	8082                	ret
ffffffffc02027fc:	0007b883          	ld	a7,0(a5)
ffffffffc0202800:	0087b303          	ld	t1,8(a5)
ffffffffc0202804:	fe878513          	addi	a0,a5,-24
ffffffffc0202808:	00070e1b          	sext.w	t3,a4
ffffffffc020280c:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0202810:	01133023          	sd	a7,0(t1)
ffffffffc0202814:	02c77863          	bgeu	a4,a2,ffffffffc0202844 <default_alloc_pages+0x7e>
ffffffffc0202818:	071a                	slli	a4,a4,0x6
ffffffffc020281a:	972a                	add	a4,a4,a0
ffffffffc020281c:	41c686bb          	subw	a3,a3,t3
ffffffffc0202820:	cb14                	sw	a3,16(a4)
ffffffffc0202822:	00870613          	addi	a2,a4,8
ffffffffc0202826:	4689                	li	a3,2
ffffffffc0202828:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc020282c:	0088b683          	ld	a3,8(a7)
ffffffffc0202830:	01870613          	addi	a2,a4,24
ffffffffc0202834:	0105a803          	lw	a6,16(a1)
ffffffffc0202838:	e290                	sd	a2,0(a3)
ffffffffc020283a:	00c8b423          	sd	a2,8(a7)
ffffffffc020283e:	f314                	sd	a3,32(a4)
ffffffffc0202840:	01173c23          	sd	a7,24(a4)
ffffffffc0202844:	41c8083b          	subw	a6,a6,t3
ffffffffc0202848:	0105a823          	sw	a6,16(a1)
ffffffffc020284c:	5775                	li	a4,-3
ffffffffc020284e:	17c1                	addi	a5,a5,-16
ffffffffc0202850:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0202854:	8082                	ret
ffffffffc0202856:	1141                	addi	sp,sp,-16
ffffffffc0202858:	0000a697          	auipc	a3,0xa
ffffffffc020285c:	f1068693          	addi	a3,a3,-240 # ffffffffc020c768 <commands+0xfd0>
ffffffffc0202860:	00009617          	auipc	a2,0x9
ffffffffc0202864:	f9860613          	addi	a2,a2,-104 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0202868:	06100593          	li	a1,97
ffffffffc020286c:	0000a517          	auipc	a0,0xa
ffffffffc0202870:	bbc50513          	addi	a0,a0,-1092 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202874:	e406                	sd	ra,8(sp)
ffffffffc0202876:	9b9fd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020287a <default_init_memmap>:
ffffffffc020287a:	1141                	addi	sp,sp,-16
ffffffffc020287c:	e406                	sd	ra,8(sp)
ffffffffc020287e:	c5f1                	beqz	a1,ffffffffc020294a <default_init_memmap+0xd0>
ffffffffc0202880:	00659693          	slli	a3,a1,0x6
ffffffffc0202884:	96aa                	add	a3,a3,a0
ffffffffc0202886:	87aa                	mv	a5,a0
ffffffffc0202888:	00d50f63          	beq	a0,a3,ffffffffc02028a6 <default_init_memmap+0x2c>
ffffffffc020288c:	6798                	ld	a4,8(a5)
ffffffffc020288e:	8b05                	andi	a4,a4,1
ffffffffc0202890:	cf49                	beqz	a4,ffffffffc020292a <default_init_memmap+0xb0>
ffffffffc0202892:	0007a823          	sw	zero,16(a5)
ffffffffc0202896:	0007b423          	sd	zero,8(a5)
ffffffffc020289a:	0007a023          	sw	zero,0(a5)
ffffffffc020289e:	04078793          	addi	a5,a5,64
ffffffffc02028a2:	fed795e3          	bne	a5,a3,ffffffffc020288c <default_init_memmap+0x12>
ffffffffc02028a6:	2581                	sext.w	a1,a1
ffffffffc02028a8:	c90c                	sw	a1,16(a0)
ffffffffc02028aa:	4789                	li	a5,2
ffffffffc02028ac:	00850713          	addi	a4,a0,8
ffffffffc02028b0:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc02028b4:	0008f697          	auipc	a3,0x8f
ffffffffc02028b8:	ef468693          	addi	a3,a3,-268 # ffffffffc02917a8 <free_area>
ffffffffc02028bc:	4a98                	lw	a4,16(a3)
ffffffffc02028be:	669c                	ld	a5,8(a3)
ffffffffc02028c0:	01850613          	addi	a2,a0,24
ffffffffc02028c4:	9db9                	addw	a1,a1,a4
ffffffffc02028c6:	ca8c                	sw	a1,16(a3)
ffffffffc02028c8:	04d78a63          	beq	a5,a3,ffffffffc020291c <default_init_memmap+0xa2>
ffffffffc02028cc:	fe878713          	addi	a4,a5,-24
ffffffffc02028d0:	0006b803          	ld	a6,0(a3)
ffffffffc02028d4:	4581                	li	a1,0
ffffffffc02028d6:	00e56a63          	bltu	a0,a4,ffffffffc02028ea <default_init_memmap+0x70>
ffffffffc02028da:	6798                	ld	a4,8(a5)
ffffffffc02028dc:	02d70263          	beq	a4,a3,ffffffffc0202900 <default_init_memmap+0x86>
ffffffffc02028e0:	87ba                	mv	a5,a4
ffffffffc02028e2:	fe878713          	addi	a4,a5,-24
ffffffffc02028e6:	fee57ae3          	bgeu	a0,a4,ffffffffc02028da <default_init_memmap+0x60>
ffffffffc02028ea:	c199                	beqz	a1,ffffffffc02028f0 <default_init_memmap+0x76>
ffffffffc02028ec:	0106b023          	sd	a6,0(a3)
ffffffffc02028f0:	6398                	ld	a4,0(a5)
ffffffffc02028f2:	60a2                	ld	ra,8(sp)
ffffffffc02028f4:	e390                	sd	a2,0(a5)
ffffffffc02028f6:	e710                	sd	a2,8(a4)
ffffffffc02028f8:	f11c                	sd	a5,32(a0)
ffffffffc02028fa:	ed18                	sd	a4,24(a0)
ffffffffc02028fc:	0141                	addi	sp,sp,16
ffffffffc02028fe:	8082                	ret
ffffffffc0202900:	e790                	sd	a2,8(a5)
ffffffffc0202902:	f114                	sd	a3,32(a0)
ffffffffc0202904:	6798                	ld	a4,8(a5)
ffffffffc0202906:	ed1c                	sd	a5,24(a0)
ffffffffc0202908:	00d70663          	beq	a4,a3,ffffffffc0202914 <default_init_memmap+0x9a>
ffffffffc020290c:	8832                	mv	a6,a2
ffffffffc020290e:	4585                	li	a1,1
ffffffffc0202910:	87ba                	mv	a5,a4
ffffffffc0202912:	bfc1                	j	ffffffffc02028e2 <default_init_memmap+0x68>
ffffffffc0202914:	60a2                	ld	ra,8(sp)
ffffffffc0202916:	e290                	sd	a2,0(a3)
ffffffffc0202918:	0141                	addi	sp,sp,16
ffffffffc020291a:	8082                	ret
ffffffffc020291c:	60a2                	ld	ra,8(sp)
ffffffffc020291e:	e390                	sd	a2,0(a5)
ffffffffc0202920:	e790                	sd	a2,8(a5)
ffffffffc0202922:	f11c                	sd	a5,32(a0)
ffffffffc0202924:	ed1c                	sd	a5,24(a0)
ffffffffc0202926:	0141                	addi	sp,sp,16
ffffffffc0202928:	8082                	ret
ffffffffc020292a:	0000a697          	auipc	a3,0xa
ffffffffc020292e:	e6e68693          	addi	a3,a3,-402 # ffffffffc020c798 <commands+0x1000>
ffffffffc0202932:	00009617          	auipc	a2,0x9
ffffffffc0202936:	ec660613          	addi	a2,a2,-314 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020293a:	04800593          	li	a1,72
ffffffffc020293e:	0000a517          	auipc	a0,0xa
ffffffffc0202942:	aea50513          	addi	a0,a0,-1302 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202946:	8e9fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020294a:	0000a697          	auipc	a3,0xa
ffffffffc020294e:	e1e68693          	addi	a3,a3,-482 # ffffffffc020c768 <commands+0xfd0>
ffffffffc0202952:	00009617          	auipc	a2,0x9
ffffffffc0202956:	ea660613          	addi	a2,a2,-346 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020295a:	04500593          	li	a1,69
ffffffffc020295e:	0000a517          	auipc	a0,0xa
ffffffffc0202962:	aca50513          	addi	a0,a0,-1334 # ffffffffc020c428 <commands+0xc90>
ffffffffc0202966:	8c9fd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020296a <pa2page.part.0>:
ffffffffc020296a:	1141                	addi	sp,sp,-16
ffffffffc020296c:	0000a617          	auipc	a2,0xa
ffffffffc0202970:	a8c60613          	addi	a2,a2,-1396 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc0202974:	06900593          	li	a1,105
ffffffffc0202978:	0000a517          	auipc	a0,0xa
ffffffffc020297c:	9d850513          	addi	a0,a0,-1576 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0202980:	e406                	sd	ra,8(sp)
ffffffffc0202982:	8adfd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0202986 <pte2page.part.0>:
ffffffffc0202986:	1141                	addi	sp,sp,-16
ffffffffc0202988:	0000a617          	auipc	a2,0xa
ffffffffc020298c:	e7060613          	addi	a2,a2,-400 # ffffffffc020c7f8 <default_pmm_manager+0x38>
ffffffffc0202990:	07f00593          	li	a1,127
ffffffffc0202994:	0000a517          	auipc	a0,0xa
ffffffffc0202998:	9bc50513          	addi	a0,a0,-1604 # ffffffffc020c350 <commands+0xbb8>
ffffffffc020299c:	e406                	sd	ra,8(sp)
ffffffffc020299e:	891fd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02029a2 <alloc_pages>:
ffffffffc02029a2:	100027f3          	csrr	a5,sstatus
ffffffffc02029a6:	8b89                	andi	a5,a5,2
ffffffffc02029a8:	e799                	bnez	a5,ffffffffc02029b6 <alloc_pages+0x14>
ffffffffc02029aa:	00094797          	auipc	a5,0x94
ffffffffc02029ae:	f067b783          	ld	a5,-250(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029b2:	6f9c                	ld	a5,24(a5)
ffffffffc02029b4:	8782                	jr	a5
ffffffffc02029b6:	1141                	addi	sp,sp,-16
ffffffffc02029b8:	e406                	sd	ra,8(sp)
ffffffffc02029ba:	e022                	sd	s0,0(sp)
ffffffffc02029bc:	842a                	mv	s0,a0
ffffffffc02029be:	be6fe0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02029c2:	00094797          	auipc	a5,0x94
ffffffffc02029c6:	eee7b783          	ld	a5,-274(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029ca:	6f9c                	ld	a5,24(a5)
ffffffffc02029cc:	8522                	mv	a0,s0
ffffffffc02029ce:	9782                	jalr	a5
ffffffffc02029d0:	842a                	mv	s0,a0
ffffffffc02029d2:	bccfe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02029d6:	60a2                	ld	ra,8(sp)
ffffffffc02029d8:	8522                	mv	a0,s0
ffffffffc02029da:	6402                	ld	s0,0(sp)
ffffffffc02029dc:	0141                	addi	sp,sp,16
ffffffffc02029de:	8082                	ret

ffffffffc02029e0 <free_pages>:
ffffffffc02029e0:	100027f3          	csrr	a5,sstatus
ffffffffc02029e4:	8b89                	andi	a5,a5,2
ffffffffc02029e6:	e799                	bnez	a5,ffffffffc02029f4 <free_pages+0x14>
ffffffffc02029e8:	00094797          	auipc	a5,0x94
ffffffffc02029ec:	ec87b783          	ld	a5,-312(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029f0:	739c                	ld	a5,32(a5)
ffffffffc02029f2:	8782                	jr	a5
ffffffffc02029f4:	1101                	addi	sp,sp,-32
ffffffffc02029f6:	ec06                	sd	ra,24(sp)
ffffffffc02029f8:	e822                	sd	s0,16(sp)
ffffffffc02029fa:	e426                	sd	s1,8(sp)
ffffffffc02029fc:	842a                	mv	s0,a0
ffffffffc02029fe:	84ae                	mv	s1,a1
ffffffffc0202a00:	ba4fe0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0202a04:	00094797          	auipc	a5,0x94
ffffffffc0202a08:	eac7b783          	ld	a5,-340(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a0c:	739c                	ld	a5,32(a5)
ffffffffc0202a0e:	85a6                	mv	a1,s1
ffffffffc0202a10:	8522                	mv	a0,s0
ffffffffc0202a12:	9782                	jalr	a5
ffffffffc0202a14:	6442                	ld	s0,16(sp)
ffffffffc0202a16:	60e2                	ld	ra,24(sp)
ffffffffc0202a18:	64a2                	ld	s1,8(sp)
ffffffffc0202a1a:	6105                	addi	sp,sp,32
ffffffffc0202a1c:	b82fe06f          	j	ffffffffc0200d9e <intr_enable>

ffffffffc0202a20 <nr_free_pages>:
ffffffffc0202a20:	100027f3          	csrr	a5,sstatus
ffffffffc0202a24:	8b89                	andi	a5,a5,2
ffffffffc0202a26:	e799                	bnez	a5,ffffffffc0202a34 <nr_free_pages+0x14>
ffffffffc0202a28:	00094797          	auipc	a5,0x94
ffffffffc0202a2c:	e887b783          	ld	a5,-376(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a30:	779c                	ld	a5,40(a5)
ffffffffc0202a32:	8782                	jr	a5
ffffffffc0202a34:	1141                	addi	sp,sp,-16
ffffffffc0202a36:	e406                	sd	ra,8(sp)
ffffffffc0202a38:	e022                	sd	s0,0(sp)
ffffffffc0202a3a:	b6afe0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0202a3e:	00094797          	auipc	a5,0x94
ffffffffc0202a42:	e727b783          	ld	a5,-398(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a46:	779c                	ld	a5,40(a5)
ffffffffc0202a48:	9782                	jalr	a5
ffffffffc0202a4a:	842a                	mv	s0,a0
ffffffffc0202a4c:	b52fe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0202a50:	60a2                	ld	ra,8(sp)
ffffffffc0202a52:	8522                	mv	a0,s0
ffffffffc0202a54:	6402                	ld	s0,0(sp)
ffffffffc0202a56:	0141                	addi	sp,sp,16
ffffffffc0202a58:	8082                	ret

ffffffffc0202a5a <get_pte>:
ffffffffc0202a5a:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202a5e:	1ff7f793          	andi	a5,a5,511
ffffffffc0202a62:	7139                	addi	sp,sp,-64
ffffffffc0202a64:	078e                	slli	a5,a5,0x3
ffffffffc0202a66:	f426                	sd	s1,40(sp)
ffffffffc0202a68:	00f504b3          	add	s1,a0,a5
ffffffffc0202a6c:	6094                	ld	a3,0(s1)
ffffffffc0202a6e:	f04a                	sd	s2,32(sp)
ffffffffc0202a70:	ec4e                	sd	s3,24(sp)
ffffffffc0202a72:	e852                	sd	s4,16(sp)
ffffffffc0202a74:	fc06                	sd	ra,56(sp)
ffffffffc0202a76:	f822                	sd	s0,48(sp)
ffffffffc0202a78:	e456                	sd	s5,8(sp)
ffffffffc0202a7a:	e05a                	sd	s6,0(sp)
ffffffffc0202a7c:	0016f793          	andi	a5,a3,1
ffffffffc0202a80:	892e                	mv	s2,a1
ffffffffc0202a82:	8a32                	mv	s4,a2
ffffffffc0202a84:	00094997          	auipc	s3,0x94
ffffffffc0202a88:	e1c98993          	addi	s3,s3,-484 # ffffffffc02968a0 <npage>
ffffffffc0202a8c:	efbd                	bnez	a5,ffffffffc0202b0a <get_pte+0xb0>
ffffffffc0202a8e:	14060c63          	beqz	a2,ffffffffc0202be6 <get_pte+0x18c>
ffffffffc0202a92:	100027f3          	csrr	a5,sstatus
ffffffffc0202a96:	8b89                	andi	a5,a5,2
ffffffffc0202a98:	14079963          	bnez	a5,ffffffffc0202bea <get_pte+0x190>
ffffffffc0202a9c:	00094797          	auipc	a5,0x94
ffffffffc0202aa0:	e147b783          	ld	a5,-492(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202aa4:	6f9c                	ld	a5,24(a5)
ffffffffc0202aa6:	4505                	li	a0,1
ffffffffc0202aa8:	9782                	jalr	a5
ffffffffc0202aaa:	842a                	mv	s0,a0
ffffffffc0202aac:	12040d63          	beqz	s0,ffffffffc0202be6 <get_pte+0x18c>
ffffffffc0202ab0:	00094b17          	auipc	s6,0x94
ffffffffc0202ab4:	df8b0b13          	addi	s6,s6,-520 # ffffffffc02968a8 <pages>
ffffffffc0202ab8:	000b3503          	ld	a0,0(s6)
ffffffffc0202abc:	00080ab7          	lui	s5,0x80
ffffffffc0202ac0:	00094997          	auipc	s3,0x94
ffffffffc0202ac4:	de098993          	addi	s3,s3,-544 # ffffffffc02968a0 <npage>
ffffffffc0202ac8:	40a40533          	sub	a0,s0,a0
ffffffffc0202acc:	8519                	srai	a0,a0,0x6
ffffffffc0202ace:	9556                	add	a0,a0,s5
ffffffffc0202ad0:	0009b703          	ld	a4,0(s3)
ffffffffc0202ad4:	00c51793          	slli	a5,a0,0xc
ffffffffc0202ad8:	4685                	li	a3,1
ffffffffc0202ada:	c014                	sw	a3,0(s0)
ffffffffc0202adc:	83b1                	srli	a5,a5,0xc
ffffffffc0202ade:	0532                	slli	a0,a0,0xc
ffffffffc0202ae0:	16e7f763          	bgeu	a5,a4,ffffffffc0202c4e <get_pte+0x1f4>
ffffffffc0202ae4:	00094797          	auipc	a5,0x94
ffffffffc0202ae8:	dd47b783          	ld	a5,-556(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202aec:	6605                	lui	a2,0x1
ffffffffc0202aee:	4581                	li	a1,0
ffffffffc0202af0:	953e                	add	a0,a0,a5
ffffffffc0202af2:	502080ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0202af6:	000b3683          	ld	a3,0(s6)
ffffffffc0202afa:	40d406b3          	sub	a3,s0,a3
ffffffffc0202afe:	8699                	srai	a3,a3,0x6
ffffffffc0202b00:	96d6                	add	a3,a3,s5
ffffffffc0202b02:	06aa                	slli	a3,a3,0xa
ffffffffc0202b04:	0116e693          	ori	a3,a3,17
ffffffffc0202b08:	e094                	sd	a3,0(s1)
ffffffffc0202b0a:	77fd                	lui	a5,0xfffff
ffffffffc0202b0c:	068a                	slli	a3,a3,0x2
ffffffffc0202b0e:	0009b703          	ld	a4,0(s3)
ffffffffc0202b12:	8efd                	and	a3,a3,a5
ffffffffc0202b14:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202b18:	10e7ff63          	bgeu	a5,a4,ffffffffc0202c36 <get_pte+0x1dc>
ffffffffc0202b1c:	00094a97          	auipc	s5,0x94
ffffffffc0202b20:	d9ca8a93          	addi	s5,s5,-612 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202b24:	000ab403          	ld	s0,0(s5)
ffffffffc0202b28:	01595793          	srli	a5,s2,0x15
ffffffffc0202b2c:	1ff7f793          	andi	a5,a5,511
ffffffffc0202b30:	96a2                	add	a3,a3,s0
ffffffffc0202b32:	00379413          	slli	s0,a5,0x3
ffffffffc0202b36:	9436                	add	s0,s0,a3
ffffffffc0202b38:	6014                	ld	a3,0(s0)
ffffffffc0202b3a:	0016f793          	andi	a5,a3,1
ffffffffc0202b3e:	ebad                	bnez	a5,ffffffffc0202bb0 <get_pte+0x156>
ffffffffc0202b40:	0a0a0363          	beqz	s4,ffffffffc0202be6 <get_pte+0x18c>
ffffffffc0202b44:	100027f3          	csrr	a5,sstatus
ffffffffc0202b48:	8b89                	andi	a5,a5,2
ffffffffc0202b4a:	efcd                	bnez	a5,ffffffffc0202c04 <get_pte+0x1aa>
ffffffffc0202b4c:	00094797          	auipc	a5,0x94
ffffffffc0202b50:	d647b783          	ld	a5,-668(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b54:	6f9c                	ld	a5,24(a5)
ffffffffc0202b56:	4505                	li	a0,1
ffffffffc0202b58:	9782                	jalr	a5
ffffffffc0202b5a:	84aa                	mv	s1,a0
ffffffffc0202b5c:	c4c9                	beqz	s1,ffffffffc0202be6 <get_pte+0x18c>
ffffffffc0202b5e:	00094b17          	auipc	s6,0x94
ffffffffc0202b62:	d4ab0b13          	addi	s6,s6,-694 # ffffffffc02968a8 <pages>
ffffffffc0202b66:	000b3503          	ld	a0,0(s6)
ffffffffc0202b6a:	00080a37          	lui	s4,0x80
ffffffffc0202b6e:	0009b703          	ld	a4,0(s3)
ffffffffc0202b72:	40a48533          	sub	a0,s1,a0
ffffffffc0202b76:	8519                	srai	a0,a0,0x6
ffffffffc0202b78:	9552                	add	a0,a0,s4
ffffffffc0202b7a:	00c51793          	slli	a5,a0,0xc
ffffffffc0202b7e:	4685                	li	a3,1
ffffffffc0202b80:	c094                	sw	a3,0(s1)
ffffffffc0202b82:	83b1                	srli	a5,a5,0xc
ffffffffc0202b84:	0532                	slli	a0,a0,0xc
ffffffffc0202b86:	0ee7f163          	bgeu	a5,a4,ffffffffc0202c68 <get_pte+0x20e>
ffffffffc0202b8a:	000ab783          	ld	a5,0(s5)
ffffffffc0202b8e:	6605                	lui	a2,0x1
ffffffffc0202b90:	4581                	li	a1,0
ffffffffc0202b92:	953e                	add	a0,a0,a5
ffffffffc0202b94:	460080ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0202b98:	000b3683          	ld	a3,0(s6)
ffffffffc0202b9c:	40d486b3          	sub	a3,s1,a3
ffffffffc0202ba0:	8699                	srai	a3,a3,0x6
ffffffffc0202ba2:	96d2                	add	a3,a3,s4
ffffffffc0202ba4:	06aa                	slli	a3,a3,0xa
ffffffffc0202ba6:	0116e693          	ori	a3,a3,17
ffffffffc0202baa:	e014                	sd	a3,0(s0)
ffffffffc0202bac:	0009b703          	ld	a4,0(s3)
ffffffffc0202bb0:	068a                	slli	a3,a3,0x2
ffffffffc0202bb2:	757d                	lui	a0,0xfffff
ffffffffc0202bb4:	8ee9                	and	a3,a3,a0
ffffffffc0202bb6:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202bba:	06e7f263          	bgeu	a5,a4,ffffffffc0202c1e <get_pte+0x1c4>
ffffffffc0202bbe:	000ab503          	ld	a0,0(s5)
ffffffffc0202bc2:	00c95913          	srli	s2,s2,0xc
ffffffffc0202bc6:	1ff97913          	andi	s2,s2,511
ffffffffc0202bca:	96aa                	add	a3,a3,a0
ffffffffc0202bcc:	00391513          	slli	a0,s2,0x3
ffffffffc0202bd0:	9536                	add	a0,a0,a3
ffffffffc0202bd2:	70e2                	ld	ra,56(sp)
ffffffffc0202bd4:	7442                	ld	s0,48(sp)
ffffffffc0202bd6:	74a2                	ld	s1,40(sp)
ffffffffc0202bd8:	7902                	ld	s2,32(sp)
ffffffffc0202bda:	69e2                	ld	s3,24(sp)
ffffffffc0202bdc:	6a42                	ld	s4,16(sp)
ffffffffc0202bde:	6aa2                	ld	s5,8(sp)
ffffffffc0202be0:	6b02                	ld	s6,0(sp)
ffffffffc0202be2:	6121                	addi	sp,sp,64
ffffffffc0202be4:	8082                	ret
ffffffffc0202be6:	4501                	li	a0,0
ffffffffc0202be8:	b7ed                	j	ffffffffc0202bd2 <get_pte+0x178>
ffffffffc0202bea:	9bafe0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0202bee:	00094797          	auipc	a5,0x94
ffffffffc0202bf2:	cc27b783          	ld	a5,-830(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202bf6:	6f9c                	ld	a5,24(a5)
ffffffffc0202bf8:	4505                	li	a0,1
ffffffffc0202bfa:	9782                	jalr	a5
ffffffffc0202bfc:	842a                	mv	s0,a0
ffffffffc0202bfe:	9a0fe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0202c02:	b56d                	j	ffffffffc0202aac <get_pte+0x52>
ffffffffc0202c04:	9a0fe0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0202c08:	00094797          	auipc	a5,0x94
ffffffffc0202c0c:	ca87b783          	ld	a5,-856(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202c10:	6f9c                	ld	a5,24(a5)
ffffffffc0202c12:	4505                	li	a0,1
ffffffffc0202c14:	9782                	jalr	a5
ffffffffc0202c16:	84aa                	mv	s1,a0
ffffffffc0202c18:	986fe0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0202c1c:	b781                	j	ffffffffc0202b5c <get_pte+0x102>
ffffffffc0202c1e:	00009617          	auipc	a2,0x9
ffffffffc0202c22:	70a60613          	addi	a2,a2,1802 # ffffffffc020c328 <commands+0xb90>
ffffffffc0202c26:	13200593          	li	a1,306
ffffffffc0202c2a:	0000a517          	auipc	a0,0xa
ffffffffc0202c2e:	bf650513          	addi	a0,a0,-1034 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202c32:	dfcfd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0202c36:	00009617          	auipc	a2,0x9
ffffffffc0202c3a:	6f260613          	addi	a2,a2,1778 # ffffffffc020c328 <commands+0xb90>
ffffffffc0202c3e:	12500593          	li	a1,293
ffffffffc0202c42:	0000a517          	auipc	a0,0xa
ffffffffc0202c46:	bde50513          	addi	a0,a0,-1058 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202c4a:	de4fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0202c4e:	86aa                	mv	a3,a0
ffffffffc0202c50:	00009617          	auipc	a2,0x9
ffffffffc0202c54:	6d860613          	addi	a2,a2,1752 # ffffffffc020c328 <commands+0xb90>
ffffffffc0202c58:	12100593          	li	a1,289
ffffffffc0202c5c:	0000a517          	auipc	a0,0xa
ffffffffc0202c60:	bc450513          	addi	a0,a0,-1084 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202c64:	dcafd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0202c68:	86aa                	mv	a3,a0
ffffffffc0202c6a:	00009617          	auipc	a2,0x9
ffffffffc0202c6e:	6be60613          	addi	a2,a2,1726 # ffffffffc020c328 <commands+0xb90>
ffffffffc0202c72:	12f00593          	li	a1,303
ffffffffc0202c76:	0000a517          	auipc	a0,0xa
ffffffffc0202c7a:	baa50513          	addi	a0,a0,-1110 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202c7e:	db0fd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0202c82 <boot_map_segment>:
ffffffffc0202c82:	6785                	lui	a5,0x1
ffffffffc0202c84:	7139                	addi	sp,sp,-64
ffffffffc0202c86:	00d5c833          	xor	a6,a1,a3
ffffffffc0202c8a:	17fd                	addi	a5,a5,-1
ffffffffc0202c8c:	fc06                	sd	ra,56(sp)
ffffffffc0202c8e:	f822                	sd	s0,48(sp)
ffffffffc0202c90:	f426                	sd	s1,40(sp)
ffffffffc0202c92:	f04a                	sd	s2,32(sp)
ffffffffc0202c94:	ec4e                	sd	s3,24(sp)
ffffffffc0202c96:	e852                	sd	s4,16(sp)
ffffffffc0202c98:	e456                	sd	s5,8(sp)
ffffffffc0202c9a:	00f87833          	and	a6,a6,a5
ffffffffc0202c9e:	08081563          	bnez	a6,ffffffffc0202d28 <boot_map_segment+0xa6>
ffffffffc0202ca2:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202ca6:	963e                	add	a2,a2,a5
ffffffffc0202ca8:	94b2                	add	s1,s1,a2
ffffffffc0202caa:	797d                	lui	s2,0xfffff
ffffffffc0202cac:	80b1                	srli	s1,s1,0xc
ffffffffc0202cae:	0125f5b3          	and	a1,a1,s2
ffffffffc0202cb2:	0126f6b3          	and	a3,a3,s2
ffffffffc0202cb6:	c0a1                	beqz	s1,ffffffffc0202cf6 <boot_map_segment+0x74>
ffffffffc0202cb8:	00176713          	ori	a4,a4,1
ffffffffc0202cbc:	04b2                	slli	s1,s1,0xc
ffffffffc0202cbe:	02071993          	slli	s3,a4,0x20
ffffffffc0202cc2:	8a2a                	mv	s4,a0
ffffffffc0202cc4:	842e                	mv	s0,a1
ffffffffc0202cc6:	94ae                	add	s1,s1,a1
ffffffffc0202cc8:	40b68933          	sub	s2,a3,a1
ffffffffc0202ccc:	0209d993          	srli	s3,s3,0x20
ffffffffc0202cd0:	6a85                	lui	s5,0x1
ffffffffc0202cd2:	4605                	li	a2,1
ffffffffc0202cd4:	85a2                	mv	a1,s0
ffffffffc0202cd6:	8552                	mv	a0,s4
ffffffffc0202cd8:	d83ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0202cdc:	008907b3          	add	a5,s2,s0
ffffffffc0202ce0:	c505                	beqz	a0,ffffffffc0202d08 <boot_map_segment+0x86>
ffffffffc0202ce2:	83b1                	srli	a5,a5,0xc
ffffffffc0202ce4:	07aa                	slli	a5,a5,0xa
ffffffffc0202ce6:	0137e7b3          	or	a5,a5,s3
ffffffffc0202cea:	0017e793          	ori	a5,a5,1
ffffffffc0202cee:	e11c                	sd	a5,0(a0)
ffffffffc0202cf0:	9456                	add	s0,s0,s5
ffffffffc0202cf2:	fe8490e3          	bne	s1,s0,ffffffffc0202cd2 <boot_map_segment+0x50>
ffffffffc0202cf6:	70e2                	ld	ra,56(sp)
ffffffffc0202cf8:	7442                	ld	s0,48(sp)
ffffffffc0202cfa:	74a2                	ld	s1,40(sp)
ffffffffc0202cfc:	7902                	ld	s2,32(sp)
ffffffffc0202cfe:	69e2                	ld	s3,24(sp)
ffffffffc0202d00:	6a42                	ld	s4,16(sp)
ffffffffc0202d02:	6aa2                	ld	s5,8(sp)
ffffffffc0202d04:	6121                	addi	sp,sp,64
ffffffffc0202d06:	8082                	ret
ffffffffc0202d08:	0000a697          	auipc	a3,0xa
ffffffffc0202d0c:	b4068693          	addi	a3,a3,-1216 # ffffffffc020c848 <default_pmm_manager+0x88>
ffffffffc0202d10:	00009617          	auipc	a2,0x9
ffffffffc0202d14:	ae860613          	addi	a2,a2,-1304 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0202d18:	09c00593          	li	a1,156
ffffffffc0202d1c:	0000a517          	auipc	a0,0xa
ffffffffc0202d20:	b0450513          	addi	a0,a0,-1276 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202d24:	d0afd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0202d28:	0000a697          	auipc	a3,0xa
ffffffffc0202d2c:	b0868693          	addi	a3,a3,-1272 # ffffffffc020c830 <default_pmm_manager+0x70>
ffffffffc0202d30:	00009617          	auipc	a2,0x9
ffffffffc0202d34:	ac860613          	addi	a2,a2,-1336 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0202d38:	09500593          	li	a1,149
ffffffffc0202d3c:	0000a517          	auipc	a0,0xa
ffffffffc0202d40:	ae450513          	addi	a0,a0,-1308 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202d44:	ceafd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0202d48 <get_page>:
ffffffffc0202d48:	1141                	addi	sp,sp,-16
ffffffffc0202d4a:	e022                	sd	s0,0(sp)
ffffffffc0202d4c:	8432                	mv	s0,a2
ffffffffc0202d4e:	4601                	li	a2,0
ffffffffc0202d50:	e406                	sd	ra,8(sp)
ffffffffc0202d52:	d09ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0202d56:	c011                	beqz	s0,ffffffffc0202d5a <get_page+0x12>
ffffffffc0202d58:	e008                	sd	a0,0(s0)
ffffffffc0202d5a:	c511                	beqz	a0,ffffffffc0202d66 <get_page+0x1e>
ffffffffc0202d5c:	611c                	ld	a5,0(a0)
ffffffffc0202d5e:	4501                	li	a0,0
ffffffffc0202d60:	0017f713          	andi	a4,a5,1
ffffffffc0202d64:	e709                	bnez	a4,ffffffffc0202d6e <get_page+0x26>
ffffffffc0202d66:	60a2                	ld	ra,8(sp)
ffffffffc0202d68:	6402                	ld	s0,0(sp)
ffffffffc0202d6a:	0141                	addi	sp,sp,16
ffffffffc0202d6c:	8082                	ret
ffffffffc0202d6e:	078a                	slli	a5,a5,0x2
ffffffffc0202d70:	83b1                	srli	a5,a5,0xc
ffffffffc0202d72:	00094717          	auipc	a4,0x94
ffffffffc0202d76:	b2e73703          	ld	a4,-1234(a4) # ffffffffc02968a0 <npage>
ffffffffc0202d7a:	00e7ff63          	bgeu	a5,a4,ffffffffc0202d98 <get_page+0x50>
ffffffffc0202d7e:	60a2                	ld	ra,8(sp)
ffffffffc0202d80:	6402                	ld	s0,0(sp)
ffffffffc0202d82:	fff80537          	lui	a0,0xfff80
ffffffffc0202d86:	97aa                	add	a5,a5,a0
ffffffffc0202d88:	079a                	slli	a5,a5,0x6
ffffffffc0202d8a:	00094517          	auipc	a0,0x94
ffffffffc0202d8e:	b1e53503          	ld	a0,-1250(a0) # ffffffffc02968a8 <pages>
ffffffffc0202d92:	953e                	add	a0,a0,a5
ffffffffc0202d94:	0141                	addi	sp,sp,16
ffffffffc0202d96:	8082                	ret
ffffffffc0202d98:	bd3ff0ef          	jal	ra,ffffffffc020296a <pa2page.part.0>

ffffffffc0202d9c <unmap_range>:
ffffffffc0202d9c:	7159                	addi	sp,sp,-112
ffffffffc0202d9e:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202da2:	f486                	sd	ra,104(sp)
ffffffffc0202da4:	f0a2                	sd	s0,96(sp)
ffffffffc0202da6:	eca6                	sd	s1,88(sp)
ffffffffc0202da8:	e8ca                	sd	s2,80(sp)
ffffffffc0202daa:	e4ce                	sd	s3,72(sp)
ffffffffc0202dac:	e0d2                	sd	s4,64(sp)
ffffffffc0202dae:	fc56                	sd	s5,56(sp)
ffffffffc0202db0:	f85a                	sd	s6,48(sp)
ffffffffc0202db2:	f45e                	sd	s7,40(sp)
ffffffffc0202db4:	f062                	sd	s8,32(sp)
ffffffffc0202db6:	ec66                	sd	s9,24(sp)
ffffffffc0202db8:	e86a                	sd	s10,16(sp)
ffffffffc0202dba:	17d2                	slli	a5,a5,0x34
ffffffffc0202dbc:	e3ed                	bnez	a5,ffffffffc0202e9e <unmap_range+0x102>
ffffffffc0202dbe:	002007b7          	lui	a5,0x200
ffffffffc0202dc2:	842e                	mv	s0,a1
ffffffffc0202dc4:	0ef5ed63          	bltu	a1,a5,ffffffffc0202ebe <unmap_range+0x122>
ffffffffc0202dc8:	8932                	mv	s2,a2
ffffffffc0202dca:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202ebe <unmap_range+0x122>
ffffffffc0202dce:	4785                	li	a5,1
ffffffffc0202dd0:	07fe                	slli	a5,a5,0x1f
ffffffffc0202dd2:	0ec7e663          	bltu	a5,a2,ffffffffc0202ebe <unmap_range+0x122>
ffffffffc0202dd6:	89aa                	mv	s3,a0
ffffffffc0202dd8:	6a05                	lui	s4,0x1
ffffffffc0202dda:	00094c97          	auipc	s9,0x94
ffffffffc0202dde:	ac6c8c93          	addi	s9,s9,-1338 # ffffffffc02968a0 <npage>
ffffffffc0202de2:	00094c17          	auipc	s8,0x94
ffffffffc0202de6:	ac6c0c13          	addi	s8,s8,-1338 # ffffffffc02968a8 <pages>
ffffffffc0202dea:	fff80bb7          	lui	s7,0xfff80
ffffffffc0202dee:	00094d17          	auipc	s10,0x94
ffffffffc0202df2:	ac2d0d13          	addi	s10,s10,-1342 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202df6:	00200b37          	lui	s6,0x200
ffffffffc0202dfa:	ffe00ab7          	lui	s5,0xffe00
ffffffffc0202dfe:	4601                	li	a2,0
ffffffffc0202e00:	85a2                	mv	a1,s0
ffffffffc0202e02:	854e                	mv	a0,s3
ffffffffc0202e04:	c57ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0202e08:	84aa                	mv	s1,a0
ffffffffc0202e0a:	cd29                	beqz	a0,ffffffffc0202e64 <unmap_range+0xc8>
ffffffffc0202e0c:	611c                	ld	a5,0(a0)
ffffffffc0202e0e:	e395                	bnez	a5,ffffffffc0202e32 <unmap_range+0x96>
ffffffffc0202e10:	9452                	add	s0,s0,s4
ffffffffc0202e12:	ff2466e3          	bltu	s0,s2,ffffffffc0202dfe <unmap_range+0x62>
ffffffffc0202e16:	70a6                	ld	ra,104(sp)
ffffffffc0202e18:	7406                	ld	s0,96(sp)
ffffffffc0202e1a:	64e6                	ld	s1,88(sp)
ffffffffc0202e1c:	6946                	ld	s2,80(sp)
ffffffffc0202e1e:	69a6                	ld	s3,72(sp)
ffffffffc0202e20:	6a06                	ld	s4,64(sp)
ffffffffc0202e22:	7ae2                	ld	s5,56(sp)
ffffffffc0202e24:	7b42                	ld	s6,48(sp)
ffffffffc0202e26:	7ba2                	ld	s7,40(sp)
ffffffffc0202e28:	7c02                	ld	s8,32(sp)
ffffffffc0202e2a:	6ce2                	ld	s9,24(sp)
ffffffffc0202e2c:	6d42                	ld	s10,16(sp)
ffffffffc0202e2e:	6165                	addi	sp,sp,112
ffffffffc0202e30:	8082                	ret
ffffffffc0202e32:	0017f713          	andi	a4,a5,1
ffffffffc0202e36:	df69                	beqz	a4,ffffffffc0202e10 <unmap_range+0x74>
ffffffffc0202e38:	000cb703          	ld	a4,0(s9)
ffffffffc0202e3c:	078a                	slli	a5,a5,0x2
ffffffffc0202e3e:	83b1                	srli	a5,a5,0xc
ffffffffc0202e40:	08e7ff63          	bgeu	a5,a4,ffffffffc0202ede <unmap_range+0x142>
ffffffffc0202e44:	000c3503          	ld	a0,0(s8)
ffffffffc0202e48:	97de                	add	a5,a5,s7
ffffffffc0202e4a:	079a                	slli	a5,a5,0x6
ffffffffc0202e4c:	953e                	add	a0,a0,a5
ffffffffc0202e4e:	411c                	lw	a5,0(a0)
ffffffffc0202e50:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202e54:	c118                	sw	a4,0(a0)
ffffffffc0202e56:	cf11                	beqz	a4,ffffffffc0202e72 <unmap_range+0xd6>
ffffffffc0202e58:	0004b023          	sd	zero,0(s1)
ffffffffc0202e5c:	12040073          	sfence.vma	s0
ffffffffc0202e60:	9452                	add	s0,s0,s4
ffffffffc0202e62:	bf45                	j	ffffffffc0202e12 <unmap_range+0x76>
ffffffffc0202e64:	945a                	add	s0,s0,s6
ffffffffc0202e66:	01547433          	and	s0,s0,s5
ffffffffc0202e6a:	d455                	beqz	s0,ffffffffc0202e16 <unmap_range+0x7a>
ffffffffc0202e6c:	f92469e3          	bltu	s0,s2,ffffffffc0202dfe <unmap_range+0x62>
ffffffffc0202e70:	b75d                	j	ffffffffc0202e16 <unmap_range+0x7a>
ffffffffc0202e72:	100027f3          	csrr	a5,sstatus
ffffffffc0202e76:	8b89                	andi	a5,a5,2
ffffffffc0202e78:	e799                	bnez	a5,ffffffffc0202e86 <unmap_range+0xea>
ffffffffc0202e7a:	000d3783          	ld	a5,0(s10)
ffffffffc0202e7e:	4585                	li	a1,1
ffffffffc0202e80:	739c                	ld	a5,32(a5)
ffffffffc0202e82:	9782                	jalr	a5
ffffffffc0202e84:	bfd1                	j	ffffffffc0202e58 <unmap_range+0xbc>
ffffffffc0202e86:	e42a                	sd	a0,8(sp)
ffffffffc0202e88:	f1dfd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0202e8c:	000d3783          	ld	a5,0(s10)
ffffffffc0202e90:	6522                	ld	a0,8(sp)
ffffffffc0202e92:	4585                	li	a1,1
ffffffffc0202e94:	739c                	ld	a5,32(a5)
ffffffffc0202e96:	9782                	jalr	a5
ffffffffc0202e98:	f07fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0202e9c:	bf75                	j	ffffffffc0202e58 <unmap_range+0xbc>
ffffffffc0202e9e:	0000a697          	auipc	a3,0xa
ffffffffc0202ea2:	9ba68693          	addi	a3,a3,-1606 # ffffffffc020c858 <default_pmm_manager+0x98>
ffffffffc0202ea6:	00009617          	auipc	a2,0x9
ffffffffc0202eaa:	95260613          	addi	a2,a2,-1710 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0202eae:	15a00593          	li	a1,346
ffffffffc0202eb2:	0000a517          	auipc	a0,0xa
ffffffffc0202eb6:	96e50513          	addi	a0,a0,-1682 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202eba:	b74fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0202ebe:	0000a697          	auipc	a3,0xa
ffffffffc0202ec2:	9ca68693          	addi	a3,a3,-1590 # ffffffffc020c888 <default_pmm_manager+0xc8>
ffffffffc0202ec6:	00009617          	auipc	a2,0x9
ffffffffc0202eca:	93260613          	addi	a2,a2,-1742 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0202ece:	15b00593          	li	a1,347
ffffffffc0202ed2:	0000a517          	auipc	a0,0xa
ffffffffc0202ed6:	94e50513          	addi	a0,a0,-1714 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0202eda:	b54fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0202ede:	a8dff0ef          	jal	ra,ffffffffc020296a <pa2page.part.0>

ffffffffc0202ee2 <exit_range>:
ffffffffc0202ee2:	7119                	addi	sp,sp,-128
ffffffffc0202ee4:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202ee8:	fc86                	sd	ra,120(sp)
ffffffffc0202eea:	f8a2                	sd	s0,112(sp)
ffffffffc0202eec:	f4a6                	sd	s1,104(sp)
ffffffffc0202eee:	f0ca                	sd	s2,96(sp)
ffffffffc0202ef0:	ecce                	sd	s3,88(sp)
ffffffffc0202ef2:	e8d2                	sd	s4,80(sp)
ffffffffc0202ef4:	e4d6                	sd	s5,72(sp)
ffffffffc0202ef6:	e0da                	sd	s6,64(sp)
ffffffffc0202ef8:	fc5e                	sd	s7,56(sp)
ffffffffc0202efa:	f862                	sd	s8,48(sp)
ffffffffc0202efc:	f466                	sd	s9,40(sp)
ffffffffc0202efe:	f06a                	sd	s10,32(sp)
ffffffffc0202f00:	ec6e                	sd	s11,24(sp)
ffffffffc0202f02:	17d2                	slli	a5,a5,0x34
ffffffffc0202f04:	20079a63          	bnez	a5,ffffffffc0203118 <exit_range+0x236>
ffffffffc0202f08:	002007b7          	lui	a5,0x200
ffffffffc0202f0c:	24f5e463          	bltu	a1,a5,ffffffffc0203154 <exit_range+0x272>
ffffffffc0202f10:	8ab2                	mv	s5,a2
ffffffffc0202f12:	24c5f163          	bgeu	a1,a2,ffffffffc0203154 <exit_range+0x272>
ffffffffc0202f16:	4785                	li	a5,1
ffffffffc0202f18:	07fe                	slli	a5,a5,0x1f
ffffffffc0202f1a:	22c7ed63          	bltu	a5,a2,ffffffffc0203154 <exit_range+0x272>
ffffffffc0202f1e:	c00009b7          	lui	s3,0xc0000
ffffffffc0202f22:	0135f9b3          	and	s3,a1,s3
ffffffffc0202f26:	ffe00937          	lui	s2,0xffe00
ffffffffc0202f2a:	400007b7          	lui	a5,0x40000
ffffffffc0202f2e:	5cfd                	li	s9,-1
ffffffffc0202f30:	8c2a                	mv	s8,a0
ffffffffc0202f32:	0125f933          	and	s2,a1,s2
ffffffffc0202f36:	99be                	add	s3,s3,a5
ffffffffc0202f38:	00094d17          	auipc	s10,0x94
ffffffffc0202f3c:	968d0d13          	addi	s10,s10,-1688 # ffffffffc02968a0 <npage>
ffffffffc0202f40:	00ccdc93          	srli	s9,s9,0xc
ffffffffc0202f44:	00094717          	auipc	a4,0x94
ffffffffc0202f48:	96470713          	addi	a4,a4,-1692 # ffffffffc02968a8 <pages>
ffffffffc0202f4c:	00094d97          	auipc	s11,0x94
ffffffffc0202f50:	964d8d93          	addi	s11,s11,-1692 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202f54:	c0000437          	lui	s0,0xc0000
ffffffffc0202f58:	944e                	add	s0,s0,s3
ffffffffc0202f5a:	8079                	srli	s0,s0,0x1e
ffffffffc0202f5c:	1ff47413          	andi	s0,s0,511
ffffffffc0202f60:	040e                	slli	s0,s0,0x3
ffffffffc0202f62:	9462                	add	s0,s0,s8
ffffffffc0202f64:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202f68:	001a7793          	andi	a5,s4,1
ffffffffc0202f6c:	eb99                	bnez	a5,ffffffffc0202f82 <exit_range+0xa0>
ffffffffc0202f6e:	12098463          	beqz	s3,ffffffffc0203096 <exit_range+0x1b4>
ffffffffc0202f72:	400007b7          	lui	a5,0x40000
ffffffffc0202f76:	97ce                	add	a5,a5,s3
ffffffffc0202f78:	894e                	mv	s2,s3
ffffffffc0202f7a:	1159fe63          	bgeu	s3,s5,ffffffffc0203096 <exit_range+0x1b4>
ffffffffc0202f7e:	89be                	mv	s3,a5
ffffffffc0202f80:	bfd1                	j	ffffffffc0202f54 <exit_range+0x72>
ffffffffc0202f82:	000d3783          	ld	a5,0(s10)
ffffffffc0202f86:	0a0a                	slli	s4,s4,0x2
ffffffffc0202f88:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202f8c:	1cfa7263          	bgeu	s4,a5,ffffffffc0203150 <exit_range+0x26e>
ffffffffc0202f90:	fff80637          	lui	a2,0xfff80
ffffffffc0202f94:	9652                	add	a2,a2,s4
ffffffffc0202f96:	000806b7          	lui	a3,0x80
ffffffffc0202f9a:	96b2                	add	a3,a3,a2
ffffffffc0202f9c:	0196f5b3          	and	a1,a3,s9
ffffffffc0202fa0:	061a                	slli	a2,a2,0x6
ffffffffc0202fa2:	06b2                	slli	a3,a3,0xc
ffffffffc0202fa4:	18f5fa63          	bgeu	a1,a5,ffffffffc0203138 <exit_range+0x256>
ffffffffc0202fa8:	00094817          	auipc	a6,0x94
ffffffffc0202fac:	91080813          	addi	a6,a6,-1776 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202fb0:	00083b03          	ld	s6,0(a6)
ffffffffc0202fb4:	4b85                	li	s7,1
ffffffffc0202fb6:	fff80e37          	lui	t3,0xfff80
ffffffffc0202fba:	9b36                	add	s6,s6,a3
ffffffffc0202fbc:	00080337          	lui	t1,0x80
ffffffffc0202fc0:	6885                	lui	a7,0x1
ffffffffc0202fc2:	a819                	j	ffffffffc0202fd8 <exit_range+0xf6>
ffffffffc0202fc4:	4b81                	li	s7,0
ffffffffc0202fc6:	002007b7          	lui	a5,0x200
ffffffffc0202fca:	993e                	add	s2,s2,a5
ffffffffc0202fcc:	08090c63          	beqz	s2,ffffffffc0203064 <exit_range+0x182>
ffffffffc0202fd0:	09397a63          	bgeu	s2,s3,ffffffffc0203064 <exit_range+0x182>
ffffffffc0202fd4:	0f597063          	bgeu	s2,s5,ffffffffc02030b4 <exit_range+0x1d2>
ffffffffc0202fd8:	01595493          	srli	s1,s2,0x15
ffffffffc0202fdc:	1ff4f493          	andi	s1,s1,511
ffffffffc0202fe0:	048e                	slli	s1,s1,0x3
ffffffffc0202fe2:	94da                	add	s1,s1,s6
ffffffffc0202fe4:	609c                	ld	a5,0(s1)
ffffffffc0202fe6:	0017f693          	andi	a3,a5,1
ffffffffc0202fea:	dee9                	beqz	a3,ffffffffc0202fc4 <exit_range+0xe2>
ffffffffc0202fec:	000d3583          	ld	a1,0(s10)
ffffffffc0202ff0:	078a                	slli	a5,a5,0x2
ffffffffc0202ff2:	83b1                	srli	a5,a5,0xc
ffffffffc0202ff4:	14b7fe63          	bgeu	a5,a1,ffffffffc0203150 <exit_range+0x26e>
ffffffffc0202ff8:	97f2                	add	a5,a5,t3
ffffffffc0202ffa:	006786b3          	add	a3,a5,t1
ffffffffc0202ffe:	0196feb3          	and	t4,a3,s9
ffffffffc0203002:	00679513          	slli	a0,a5,0x6
ffffffffc0203006:	06b2                	slli	a3,a3,0xc
ffffffffc0203008:	12bef863          	bgeu	t4,a1,ffffffffc0203138 <exit_range+0x256>
ffffffffc020300c:	00083783          	ld	a5,0(a6)
ffffffffc0203010:	96be                	add	a3,a3,a5
ffffffffc0203012:	011685b3          	add	a1,a3,a7
ffffffffc0203016:	629c                	ld	a5,0(a3)
ffffffffc0203018:	8b85                	andi	a5,a5,1
ffffffffc020301a:	f7d5                	bnez	a5,ffffffffc0202fc6 <exit_range+0xe4>
ffffffffc020301c:	06a1                	addi	a3,a3,8
ffffffffc020301e:	fed59ce3          	bne	a1,a3,ffffffffc0203016 <exit_range+0x134>
ffffffffc0203022:	631c                	ld	a5,0(a4)
ffffffffc0203024:	953e                	add	a0,a0,a5
ffffffffc0203026:	100027f3          	csrr	a5,sstatus
ffffffffc020302a:	8b89                	andi	a5,a5,2
ffffffffc020302c:	e7d9                	bnez	a5,ffffffffc02030ba <exit_range+0x1d8>
ffffffffc020302e:	000db783          	ld	a5,0(s11)
ffffffffc0203032:	4585                	li	a1,1
ffffffffc0203034:	e032                	sd	a2,0(sp)
ffffffffc0203036:	739c                	ld	a5,32(a5)
ffffffffc0203038:	9782                	jalr	a5
ffffffffc020303a:	6602                	ld	a2,0(sp)
ffffffffc020303c:	00094817          	auipc	a6,0x94
ffffffffc0203040:	87c80813          	addi	a6,a6,-1924 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0203044:	fff80e37          	lui	t3,0xfff80
ffffffffc0203048:	00080337          	lui	t1,0x80
ffffffffc020304c:	6885                	lui	a7,0x1
ffffffffc020304e:	00094717          	auipc	a4,0x94
ffffffffc0203052:	85a70713          	addi	a4,a4,-1958 # ffffffffc02968a8 <pages>
ffffffffc0203056:	0004b023          	sd	zero,0(s1)
ffffffffc020305a:	002007b7          	lui	a5,0x200
ffffffffc020305e:	993e                	add	s2,s2,a5
ffffffffc0203060:	f60918e3          	bnez	s2,ffffffffc0202fd0 <exit_range+0xee>
ffffffffc0203064:	f00b85e3          	beqz	s7,ffffffffc0202f6e <exit_range+0x8c>
ffffffffc0203068:	000d3783          	ld	a5,0(s10)
ffffffffc020306c:	0efa7263          	bgeu	s4,a5,ffffffffc0203150 <exit_range+0x26e>
ffffffffc0203070:	6308                	ld	a0,0(a4)
ffffffffc0203072:	9532                	add	a0,a0,a2
ffffffffc0203074:	100027f3          	csrr	a5,sstatus
ffffffffc0203078:	8b89                	andi	a5,a5,2
ffffffffc020307a:	efad                	bnez	a5,ffffffffc02030f4 <exit_range+0x212>
ffffffffc020307c:	000db783          	ld	a5,0(s11)
ffffffffc0203080:	4585                	li	a1,1
ffffffffc0203082:	739c                	ld	a5,32(a5)
ffffffffc0203084:	9782                	jalr	a5
ffffffffc0203086:	00094717          	auipc	a4,0x94
ffffffffc020308a:	82270713          	addi	a4,a4,-2014 # ffffffffc02968a8 <pages>
ffffffffc020308e:	00043023          	sd	zero,0(s0)
ffffffffc0203092:	ee0990e3          	bnez	s3,ffffffffc0202f72 <exit_range+0x90>
ffffffffc0203096:	70e6                	ld	ra,120(sp)
ffffffffc0203098:	7446                	ld	s0,112(sp)
ffffffffc020309a:	74a6                	ld	s1,104(sp)
ffffffffc020309c:	7906                	ld	s2,96(sp)
ffffffffc020309e:	69e6                	ld	s3,88(sp)
ffffffffc02030a0:	6a46                	ld	s4,80(sp)
ffffffffc02030a2:	6aa6                	ld	s5,72(sp)
ffffffffc02030a4:	6b06                	ld	s6,64(sp)
ffffffffc02030a6:	7be2                	ld	s7,56(sp)
ffffffffc02030a8:	7c42                	ld	s8,48(sp)
ffffffffc02030aa:	7ca2                	ld	s9,40(sp)
ffffffffc02030ac:	7d02                	ld	s10,32(sp)
ffffffffc02030ae:	6de2                	ld	s11,24(sp)
ffffffffc02030b0:	6109                	addi	sp,sp,128
ffffffffc02030b2:	8082                	ret
ffffffffc02030b4:	ea0b8fe3          	beqz	s7,ffffffffc0202f72 <exit_range+0x90>
ffffffffc02030b8:	bf45                	j	ffffffffc0203068 <exit_range+0x186>
ffffffffc02030ba:	e032                	sd	a2,0(sp)
ffffffffc02030bc:	e42a                	sd	a0,8(sp)
ffffffffc02030be:	ce7fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02030c2:	000db783          	ld	a5,0(s11)
ffffffffc02030c6:	6522                	ld	a0,8(sp)
ffffffffc02030c8:	4585                	li	a1,1
ffffffffc02030ca:	739c                	ld	a5,32(a5)
ffffffffc02030cc:	9782                	jalr	a5
ffffffffc02030ce:	cd1fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02030d2:	6602                	ld	a2,0(sp)
ffffffffc02030d4:	00093717          	auipc	a4,0x93
ffffffffc02030d8:	7d470713          	addi	a4,a4,2004 # ffffffffc02968a8 <pages>
ffffffffc02030dc:	6885                	lui	a7,0x1
ffffffffc02030de:	00080337          	lui	t1,0x80
ffffffffc02030e2:	fff80e37          	lui	t3,0xfff80
ffffffffc02030e6:	00093817          	auipc	a6,0x93
ffffffffc02030ea:	7d280813          	addi	a6,a6,2002 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02030ee:	0004b023          	sd	zero,0(s1)
ffffffffc02030f2:	b7a5                	j	ffffffffc020305a <exit_range+0x178>
ffffffffc02030f4:	e02a                	sd	a0,0(sp)
ffffffffc02030f6:	caffd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02030fa:	000db783          	ld	a5,0(s11)
ffffffffc02030fe:	6502                	ld	a0,0(sp)
ffffffffc0203100:	4585                	li	a1,1
ffffffffc0203102:	739c                	ld	a5,32(a5)
ffffffffc0203104:	9782                	jalr	a5
ffffffffc0203106:	c99fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc020310a:	00093717          	auipc	a4,0x93
ffffffffc020310e:	79e70713          	addi	a4,a4,1950 # ffffffffc02968a8 <pages>
ffffffffc0203112:	00043023          	sd	zero,0(s0)
ffffffffc0203116:	bfb5                	j	ffffffffc0203092 <exit_range+0x1b0>
ffffffffc0203118:	00009697          	auipc	a3,0x9
ffffffffc020311c:	74068693          	addi	a3,a3,1856 # ffffffffc020c858 <default_pmm_manager+0x98>
ffffffffc0203120:	00008617          	auipc	a2,0x8
ffffffffc0203124:	6d860613          	addi	a2,a2,1752 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203128:	16f00593          	li	a1,367
ffffffffc020312c:	00009517          	auipc	a0,0x9
ffffffffc0203130:	6f450513          	addi	a0,a0,1780 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203134:	8fafd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203138:	00009617          	auipc	a2,0x9
ffffffffc020313c:	1f060613          	addi	a2,a2,496 # ffffffffc020c328 <commands+0xb90>
ffffffffc0203140:	07100593          	li	a1,113
ffffffffc0203144:	00009517          	auipc	a0,0x9
ffffffffc0203148:	20c50513          	addi	a0,a0,524 # ffffffffc020c350 <commands+0xbb8>
ffffffffc020314c:	8e2fd0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203150:	81bff0ef          	jal	ra,ffffffffc020296a <pa2page.part.0>
ffffffffc0203154:	00009697          	auipc	a3,0x9
ffffffffc0203158:	73468693          	addi	a3,a3,1844 # ffffffffc020c888 <default_pmm_manager+0xc8>
ffffffffc020315c:	00008617          	auipc	a2,0x8
ffffffffc0203160:	69c60613          	addi	a2,a2,1692 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203164:	17000593          	li	a1,368
ffffffffc0203168:	00009517          	auipc	a0,0x9
ffffffffc020316c:	6b850513          	addi	a0,a0,1720 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203170:	8befd0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0203174 <page_remove>:
ffffffffc0203174:	7179                	addi	sp,sp,-48
ffffffffc0203176:	4601                	li	a2,0
ffffffffc0203178:	ec26                	sd	s1,24(sp)
ffffffffc020317a:	f406                	sd	ra,40(sp)
ffffffffc020317c:	f022                	sd	s0,32(sp)
ffffffffc020317e:	84ae                	mv	s1,a1
ffffffffc0203180:	8dbff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0203184:	c511                	beqz	a0,ffffffffc0203190 <page_remove+0x1c>
ffffffffc0203186:	611c                	ld	a5,0(a0)
ffffffffc0203188:	842a                	mv	s0,a0
ffffffffc020318a:	0017f713          	andi	a4,a5,1
ffffffffc020318e:	e711                	bnez	a4,ffffffffc020319a <page_remove+0x26>
ffffffffc0203190:	70a2                	ld	ra,40(sp)
ffffffffc0203192:	7402                	ld	s0,32(sp)
ffffffffc0203194:	64e2                	ld	s1,24(sp)
ffffffffc0203196:	6145                	addi	sp,sp,48
ffffffffc0203198:	8082                	ret
ffffffffc020319a:	078a                	slli	a5,a5,0x2
ffffffffc020319c:	83b1                	srli	a5,a5,0xc
ffffffffc020319e:	00093717          	auipc	a4,0x93
ffffffffc02031a2:	70273703          	ld	a4,1794(a4) # ffffffffc02968a0 <npage>
ffffffffc02031a6:	06e7f363          	bgeu	a5,a4,ffffffffc020320c <page_remove+0x98>
ffffffffc02031aa:	fff80537          	lui	a0,0xfff80
ffffffffc02031ae:	97aa                	add	a5,a5,a0
ffffffffc02031b0:	079a                	slli	a5,a5,0x6
ffffffffc02031b2:	00093517          	auipc	a0,0x93
ffffffffc02031b6:	6f653503          	ld	a0,1782(a0) # ffffffffc02968a8 <pages>
ffffffffc02031ba:	953e                	add	a0,a0,a5
ffffffffc02031bc:	411c                	lw	a5,0(a0)
ffffffffc02031be:	fff7871b          	addiw	a4,a5,-1
ffffffffc02031c2:	c118                	sw	a4,0(a0)
ffffffffc02031c4:	cb11                	beqz	a4,ffffffffc02031d8 <page_remove+0x64>
ffffffffc02031c6:	00043023          	sd	zero,0(s0)
ffffffffc02031ca:	12048073          	sfence.vma	s1
ffffffffc02031ce:	70a2                	ld	ra,40(sp)
ffffffffc02031d0:	7402                	ld	s0,32(sp)
ffffffffc02031d2:	64e2                	ld	s1,24(sp)
ffffffffc02031d4:	6145                	addi	sp,sp,48
ffffffffc02031d6:	8082                	ret
ffffffffc02031d8:	100027f3          	csrr	a5,sstatus
ffffffffc02031dc:	8b89                	andi	a5,a5,2
ffffffffc02031de:	eb89                	bnez	a5,ffffffffc02031f0 <page_remove+0x7c>
ffffffffc02031e0:	00093797          	auipc	a5,0x93
ffffffffc02031e4:	6d07b783          	ld	a5,1744(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02031e8:	739c                	ld	a5,32(a5)
ffffffffc02031ea:	4585                	li	a1,1
ffffffffc02031ec:	9782                	jalr	a5
ffffffffc02031ee:	bfe1                	j	ffffffffc02031c6 <page_remove+0x52>
ffffffffc02031f0:	e42a                	sd	a0,8(sp)
ffffffffc02031f2:	bb3fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02031f6:	00093797          	auipc	a5,0x93
ffffffffc02031fa:	6ba7b783          	ld	a5,1722(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02031fe:	739c                	ld	a5,32(a5)
ffffffffc0203200:	6522                	ld	a0,8(sp)
ffffffffc0203202:	4585                	li	a1,1
ffffffffc0203204:	9782                	jalr	a5
ffffffffc0203206:	b99fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc020320a:	bf75                	j	ffffffffc02031c6 <page_remove+0x52>
ffffffffc020320c:	f5eff0ef          	jal	ra,ffffffffc020296a <pa2page.part.0>

ffffffffc0203210 <page_insert>:
ffffffffc0203210:	7139                	addi	sp,sp,-64
ffffffffc0203212:	e852                	sd	s4,16(sp)
ffffffffc0203214:	8a32                	mv	s4,a2
ffffffffc0203216:	f822                	sd	s0,48(sp)
ffffffffc0203218:	4605                	li	a2,1
ffffffffc020321a:	842e                	mv	s0,a1
ffffffffc020321c:	85d2                	mv	a1,s4
ffffffffc020321e:	f426                	sd	s1,40(sp)
ffffffffc0203220:	fc06                	sd	ra,56(sp)
ffffffffc0203222:	f04a                	sd	s2,32(sp)
ffffffffc0203224:	ec4e                	sd	s3,24(sp)
ffffffffc0203226:	e456                	sd	s5,8(sp)
ffffffffc0203228:	84b6                	mv	s1,a3
ffffffffc020322a:	831ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc020322e:	c961                	beqz	a0,ffffffffc02032fe <page_insert+0xee>
ffffffffc0203230:	4014                	lw	a3,0(s0)
ffffffffc0203232:	611c                	ld	a5,0(a0)
ffffffffc0203234:	89aa                	mv	s3,a0
ffffffffc0203236:	0016871b          	addiw	a4,a3,1
ffffffffc020323a:	c018                	sw	a4,0(s0)
ffffffffc020323c:	0017f713          	andi	a4,a5,1
ffffffffc0203240:	ef05                	bnez	a4,ffffffffc0203278 <page_insert+0x68>
ffffffffc0203242:	00093717          	auipc	a4,0x93
ffffffffc0203246:	66673703          	ld	a4,1638(a4) # ffffffffc02968a8 <pages>
ffffffffc020324a:	8c19                	sub	s0,s0,a4
ffffffffc020324c:	000807b7          	lui	a5,0x80
ffffffffc0203250:	8419                	srai	s0,s0,0x6
ffffffffc0203252:	943e                	add	s0,s0,a5
ffffffffc0203254:	042a                	slli	s0,s0,0xa
ffffffffc0203256:	8cc1                	or	s1,s1,s0
ffffffffc0203258:	0014e493          	ori	s1,s1,1
ffffffffc020325c:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0203260:	120a0073          	sfence.vma	s4
ffffffffc0203264:	4501                	li	a0,0
ffffffffc0203266:	70e2                	ld	ra,56(sp)
ffffffffc0203268:	7442                	ld	s0,48(sp)
ffffffffc020326a:	74a2                	ld	s1,40(sp)
ffffffffc020326c:	7902                	ld	s2,32(sp)
ffffffffc020326e:	69e2                	ld	s3,24(sp)
ffffffffc0203270:	6a42                	ld	s4,16(sp)
ffffffffc0203272:	6aa2                	ld	s5,8(sp)
ffffffffc0203274:	6121                	addi	sp,sp,64
ffffffffc0203276:	8082                	ret
ffffffffc0203278:	078a                	slli	a5,a5,0x2
ffffffffc020327a:	83b1                	srli	a5,a5,0xc
ffffffffc020327c:	00093717          	auipc	a4,0x93
ffffffffc0203280:	62473703          	ld	a4,1572(a4) # ffffffffc02968a0 <npage>
ffffffffc0203284:	06e7ff63          	bgeu	a5,a4,ffffffffc0203302 <page_insert+0xf2>
ffffffffc0203288:	00093a97          	auipc	s5,0x93
ffffffffc020328c:	620a8a93          	addi	s5,s5,1568 # ffffffffc02968a8 <pages>
ffffffffc0203290:	000ab703          	ld	a4,0(s5)
ffffffffc0203294:	fff80937          	lui	s2,0xfff80
ffffffffc0203298:	993e                	add	s2,s2,a5
ffffffffc020329a:	091a                	slli	s2,s2,0x6
ffffffffc020329c:	993a                	add	s2,s2,a4
ffffffffc020329e:	01240c63          	beq	s0,s2,ffffffffc02032b6 <page_insert+0xa6>
ffffffffc02032a2:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc02032a6:	fff7869b          	addiw	a3,a5,-1
ffffffffc02032aa:	00d92023          	sw	a3,0(s2)
ffffffffc02032ae:	c691                	beqz	a3,ffffffffc02032ba <page_insert+0xaa>
ffffffffc02032b0:	120a0073          	sfence.vma	s4
ffffffffc02032b4:	bf59                	j	ffffffffc020324a <page_insert+0x3a>
ffffffffc02032b6:	c014                	sw	a3,0(s0)
ffffffffc02032b8:	bf49                	j	ffffffffc020324a <page_insert+0x3a>
ffffffffc02032ba:	100027f3          	csrr	a5,sstatus
ffffffffc02032be:	8b89                	andi	a5,a5,2
ffffffffc02032c0:	ef91                	bnez	a5,ffffffffc02032dc <page_insert+0xcc>
ffffffffc02032c2:	00093797          	auipc	a5,0x93
ffffffffc02032c6:	5ee7b783          	ld	a5,1518(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02032ca:	739c                	ld	a5,32(a5)
ffffffffc02032cc:	4585                	li	a1,1
ffffffffc02032ce:	854a                	mv	a0,s2
ffffffffc02032d0:	9782                	jalr	a5
ffffffffc02032d2:	000ab703          	ld	a4,0(s5)
ffffffffc02032d6:	120a0073          	sfence.vma	s4
ffffffffc02032da:	bf85                	j	ffffffffc020324a <page_insert+0x3a>
ffffffffc02032dc:	ac9fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02032e0:	00093797          	auipc	a5,0x93
ffffffffc02032e4:	5d07b783          	ld	a5,1488(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02032e8:	739c                	ld	a5,32(a5)
ffffffffc02032ea:	4585                	li	a1,1
ffffffffc02032ec:	854a                	mv	a0,s2
ffffffffc02032ee:	9782                	jalr	a5
ffffffffc02032f0:	aaffd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02032f4:	000ab703          	ld	a4,0(s5)
ffffffffc02032f8:	120a0073          	sfence.vma	s4
ffffffffc02032fc:	b7b9                	j	ffffffffc020324a <page_insert+0x3a>
ffffffffc02032fe:	5571                	li	a0,-4
ffffffffc0203300:	b79d                	j	ffffffffc0203266 <page_insert+0x56>
ffffffffc0203302:	e68ff0ef          	jal	ra,ffffffffc020296a <pa2page.part.0>

ffffffffc0203306 <pmm_init>:
ffffffffc0203306:	00009797          	auipc	a5,0x9
ffffffffc020330a:	4ba78793          	addi	a5,a5,1210 # ffffffffc020c7c0 <default_pmm_manager>
ffffffffc020330e:	638c                	ld	a1,0(a5)
ffffffffc0203310:	7159                	addi	sp,sp,-112
ffffffffc0203312:	f85a                	sd	s6,48(sp)
ffffffffc0203314:	00009517          	auipc	a0,0x9
ffffffffc0203318:	58c50513          	addi	a0,a0,1420 # ffffffffc020c8a0 <default_pmm_manager+0xe0>
ffffffffc020331c:	00093b17          	auipc	s6,0x93
ffffffffc0203320:	594b0b13          	addi	s6,s6,1428 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203324:	f486                	sd	ra,104(sp)
ffffffffc0203326:	e8ca                	sd	s2,80(sp)
ffffffffc0203328:	e4ce                	sd	s3,72(sp)
ffffffffc020332a:	f0a2                	sd	s0,96(sp)
ffffffffc020332c:	eca6                	sd	s1,88(sp)
ffffffffc020332e:	e0d2                	sd	s4,64(sp)
ffffffffc0203330:	fc56                	sd	s5,56(sp)
ffffffffc0203332:	f45e                	sd	s7,40(sp)
ffffffffc0203334:	f062                	sd	s8,32(sp)
ffffffffc0203336:	ec66                	sd	s9,24(sp)
ffffffffc0203338:	00fb3023          	sd	a5,0(s6)
ffffffffc020333c:	deffc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0203340:	000b3783          	ld	a5,0(s6)
ffffffffc0203344:	00093997          	auipc	s3,0x93
ffffffffc0203348:	57498993          	addi	s3,s3,1396 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020334c:	679c                	ld	a5,8(a5)
ffffffffc020334e:	9782                	jalr	a5
ffffffffc0203350:	57f5                	li	a5,-3
ffffffffc0203352:	07fa                	slli	a5,a5,0x1e
ffffffffc0203354:	00f9b023          	sd	a5,0(s3)
ffffffffc0203358:	917fd0ef          	jal	ra,ffffffffc0200c6e <get_memory_base>
ffffffffc020335c:	892a                	mv	s2,a0
ffffffffc020335e:	91bfd0ef          	jal	ra,ffffffffc0200c78 <get_memory_size>
ffffffffc0203362:	280502e3          	beqz	a0,ffffffffc0203de6 <pmm_init+0xae0>
ffffffffc0203366:	84aa                	mv	s1,a0
ffffffffc0203368:	00009517          	auipc	a0,0x9
ffffffffc020336c:	57050513          	addi	a0,a0,1392 # ffffffffc020c8d8 <default_pmm_manager+0x118>
ffffffffc0203370:	dbbfc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0203374:	00990433          	add	s0,s2,s1
ffffffffc0203378:	fff40693          	addi	a3,s0,-1
ffffffffc020337c:	864a                	mv	a2,s2
ffffffffc020337e:	85a6                	mv	a1,s1
ffffffffc0203380:	00009517          	auipc	a0,0x9
ffffffffc0203384:	57050513          	addi	a0,a0,1392 # ffffffffc020c8f0 <default_pmm_manager+0x130>
ffffffffc0203388:	da3fc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020338c:	c8000737          	lui	a4,0xc8000
ffffffffc0203390:	87a2                	mv	a5,s0
ffffffffc0203392:	5e876e63          	bltu	a4,s0,ffffffffc020398e <pmm_init+0x688>
ffffffffc0203396:	757d                	lui	a0,0xfffff
ffffffffc0203398:	00094617          	auipc	a2,0x94
ffffffffc020339c:	57760613          	addi	a2,a2,1399 # ffffffffc029790f <end+0xfff>
ffffffffc02033a0:	8e69                	and	a2,a2,a0
ffffffffc02033a2:	00093497          	auipc	s1,0x93
ffffffffc02033a6:	4fe48493          	addi	s1,s1,1278 # ffffffffc02968a0 <npage>
ffffffffc02033aa:	00c7d513          	srli	a0,a5,0xc
ffffffffc02033ae:	00093b97          	auipc	s7,0x93
ffffffffc02033b2:	4fab8b93          	addi	s7,s7,1274 # ffffffffc02968a8 <pages>
ffffffffc02033b6:	e088                	sd	a0,0(s1)
ffffffffc02033b8:	00cbb023          	sd	a2,0(s7)
ffffffffc02033bc:	000807b7          	lui	a5,0x80
ffffffffc02033c0:	86b2                	mv	a3,a2
ffffffffc02033c2:	02f50863          	beq	a0,a5,ffffffffc02033f2 <pmm_init+0xec>
ffffffffc02033c6:	4781                	li	a5,0
ffffffffc02033c8:	4585                	li	a1,1
ffffffffc02033ca:	fff806b7          	lui	a3,0xfff80
ffffffffc02033ce:	00679513          	slli	a0,a5,0x6
ffffffffc02033d2:	9532                	add	a0,a0,a2
ffffffffc02033d4:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc02033d8:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc02033dc:	6088                	ld	a0,0(s1)
ffffffffc02033de:	0785                	addi	a5,a5,1
ffffffffc02033e0:	000bb603          	ld	a2,0(s7)
ffffffffc02033e4:	00d50733          	add	a4,a0,a3
ffffffffc02033e8:	fee7e3e3          	bltu	a5,a4,ffffffffc02033ce <pmm_init+0xc8>
ffffffffc02033ec:	071a                	slli	a4,a4,0x6
ffffffffc02033ee:	00e606b3          	add	a3,a2,a4
ffffffffc02033f2:	c02007b7          	lui	a5,0xc0200
ffffffffc02033f6:	3af6eae3          	bltu	a3,a5,ffffffffc0203faa <pmm_init+0xca4>
ffffffffc02033fa:	0009b583          	ld	a1,0(s3)
ffffffffc02033fe:	77fd                	lui	a5,0xfffff
ffffffffc0203400:	8c7d                	and	s0,s0,a5
ffffffffc0203402:	8e8d                	sub	a3,a3,a1
ffffffffc0203404:	5e86e363          	bltu	a3,s0,ffffffffc02039ea <pmm_init+0x6e4>
ffffffffc0203408:	00009517          	auipc	a0,0x9
ffffffffc020340c:	51050513          	addi	a0,a0,1296 # ffffffffc020c918 <default_pmm_manager+0x158>
ffffffffc0203410:	d1bfc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0203414:	000b3783          	ld	a5,0(s6)
ffffffffc0203418:	7b9c                	ld	a5,48(a5)
ffffffffc020341a:	9782                	jalr	a5
ffffffffc020341c:	00009517          	auipc	a0,0x9
ffffffffc0203420:	51450513          	addi	a0,a0,1300 # ffffffffc020c930 <default_pmm_manager+0x170>
ffffffffc0203424:	d07fc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0203428:	100027f3          	csrr	a5,sstatus
ffffffffc020342c:	8b89                	andi	a5,a5,2
ffffffffc020342e:	5a079363          	bnez	a5,ffffffffc02039d4 <pmm_init+0x6ce>
ffffffffc0203432:	000b3783          	ld	a5,0(s6)
ffffffffc0203436:	4505                	li	a0,1
ffffffffc0203438:	6f9c                	ld	a5,24(a5)
ffffffffc020343a:	9782                	jalr	a5
ffffffffc020343c:	842a                	mv	s0,a0
ffffffffc020343e:	180408e3          	beqz	s0,ffffffffc0203dce <pmm_init+0xac8>
ffffffffc0203442:	000bb683          	ld	a3,0(s7)
ffffffffc0203446:	5a7d                	li	s4,-1
ffffffffc0203448:	6098                	ld	a4,0(s1)
ffffffffc020344a:	40d406b3          	sub	a3,s0,a3
ffffffffc020344e:	8699                	srai	a3,a3,0x6
ffffffffc0203450:	00080437          	lui	s0,0x80
ffffffffc0203454:	96a2                	add	a3,a3,s0
ffffffffc0203456:	00ca5793          	srli	a5,s4,0xc
ffffffffc020345a:	8ff5                	and	a5,a5,a3
ffffffffc020345c:	06b2                	slli	a3,a3,0xc
ffffffffc020345e:	30e7fde3          	bgeu	a5,a4,ffffffffc0203f78 <pmm_init+0xc72>
ffffffffc0203462:	0009b403          	ld	s0,0(s3)
ffffffffc0203466:	6605                	lui	a2,0x1
ffffffffc0203468:	4581                	li	a1,0
ffffffffc020346a:	9436                	add	s0,s0,a3
ffffffffc020346c:	8522                	mv	a0,s0
ffffffffc020346e:	387070ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0203472:	0009b683          	ld	a3,0(s3)
ffffffffc0203476:	77fd                	lui	a5,0xfffff
ffffffffc0203478:	00009917          	auipc	s2,0x9
ffffffffc020347c:	07790913          	addi	s2,s2,119 # ffffffffc020c4ef <commands+0xd57>
ffffffffc0203480:	00f97933          	and	s2,s2,a5
ffffffffc0203484:	c0200ab7          	lui	s5,0xc0200
ffffffffc0203488:	3fe00637          	lui	a2,0x3fe00
ffffffffc020348c:	964a                	add	a2,a2,s2
ffffffffc020348e:	4729                	li	a4,10
ffffffffc0203490:	40da86b3          	sub	a3,s5,a3
ffffffffc0203494:	c02005b7          	lui	a1,0xc0200
ffffffffc0203498:	8522                	mv	a0,s0
ffffffffc020349a:	fe8ff0ef          	jal	ra,ffffffffc0202c82 <boot_map_segment>
ffffffffc020349e:	c8000637          	lui	a2,0xc8000
ffffffffc02034a2:	41260633          	sub	a2,a2,s2
ffffffffc02034a6:	3f596ce3          	bltu	s2,s5,ffffffffc020409e <pmm_init+0xd98>
ffffffffc02034aa:	0009b683          	ld	a3,0(s3)
ffffffffc02034ae:	85ca                	mv	a1,s2
ffffffffc02034b0:	4719                	li	a4,6
ffffffffc02034b2:	40d906b3          	sub	a3,s2,a3
ffffffffc02034b6:	8522                	mv	a0,s0
ffffffffc02034b8:	00093917          	auipc	s2,0x93
ffffffffc02034bc:	3e090913          	addi	s2,s2,992 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc02034c0:	fc2ff0ef          	jal	ra,ffffffffc0202c82 <boot_map_segment>
ffffffffc02034c4:	00893023          	sd	s0,0(s2)
ffffffffc02034c8:	2d5464e3          	bltu	s0,s5,ffffffffc0203f90 <pmm_init+0xc8a>
ffffffffc02034cc:	0009b783          	ld	a5,0(s3)
ffffffffc02034d0:	1a7e                	slli	s4,s4,0x3f
ffffffffc02034d2:	8c1d                	sub	s0,s0,a5
ffffffffc02034d4:	00c45793          	srli	a5,s0,0xc
ffffffffc02034d8:	00093717          	auipc	a4,0x93
ffffffffc02034dc:	3a873c23          	sd	s0,952(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02034e0:	0147ea33          	or	s4,a5,s4
ffffffffc02034e4:	180a1073          	csrw	satp,s4
ffffffffc02034e8:	12000073          	sfence.vma
ffffffffc02034ec:	00009517          	auipc	a0,0x9
ffffffffc02034f0:	48450513          	addi	a0,a0,1156 # ffffffffc020c970 <default_pmm_manager+0x1b0>
ffffffffc02034f4:	c37fc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02034f8:	0000e717          	auipc	a4,0xe
ffffffffc02034fc:	b0870713          	addi	a4,a4,-1272 # ffffffffc0211000 <bootstack>
ffffffffc0203500:	0000e797          	auipc	a5,0xe
ffffffffc0203504:	b0078793          	addi	a5,a5,-1280 # ffffffffc0211000 <bootstack>
ffffffffc0203508:	5cf70d63          	beq	a4,a5,ffffffffc0203ae2 <pmm_init+0x7dc>
ffffffffc020350c:	100027f3          	csrr	a5,sstatus
ffffffffc0203510:	8b89                	andi	a5,a5,2
ffffffffc0203512:	4a079763          	bnez	a5,ffffffffc02039c0 <pmm_init+0x6ba>
ffffffffc0203516:	000b3783          	ld	a5,0(s6)
ffffffffc020351a:	779c                	ld	a5,40(a5)
ffffffffc020351c:	9782                	jalr	a5
ffffffffc020351e:	842a                	mv	s0,a0
ffffffffc0203520:	6098                	ld	a4,0(s1)
ffffffffc0203522:	c80007b7          	lui	a5,0xc8000
ffffffffc0203526:	83b1                	srli	a5,a5,0xc
ffffffffc0203528:	08e7e3e3          	bltu	a5,a4,ffffffffc0203dae <pmm_init+0xaa8>
ffffffffc020352c:	00093503          	ld	a0,0(s2)
ffffffffc0203530:	04050fe3          	beqz	a0,ffffffffc0203d8e <pmm_init+0xa88>
ffffffffc0203534:	03451793          	slli	a5,a0,0x34
ffffffffc0203538:	04079be3          	bnez	a5,ffffffffc0203d8e <pmm_init+0xa88>
ffffffffc020353c:	4601                	li	a2,0
ffffffffc020353e:	4581                	li	a1,0
ffffffffc0203540:	809ff0ef          	jal	ra,ffffffffc0202d48 <get_page>
ffffffffc0203544:	2e0511e3          	bnez	a0,ffffffffc0204026 <pmm_init+0xd20>
ffffffffc0203548:	100027f3          	csrr	a5,sstatus
ffffffffc020354c:	8b89                	andi	a5,a5,2
ffffffffc020354e:	44079e63          	bnez	a5,ffffffffc02039aa <pmm_init+0x6a4>
ffffffffc0203552:	000b3783          	ld	a5,0(s6)
ffffffffc0203556:	4505                	li	a0,1
ffffffffc0203558:	6f9c                	ld	a5,24(a5)
ffffffffc020355a:	9782                	jalr	a5
ffffffffc020355c:	8a2a                	mv	s4,a0
ffffffffc020355e:	00093503          	ld	a0,0(s2)
ffffffffc0203562:	4681                	li	a3,0
ffffffffc0203564:	4601                	li	a2,0
ffffffffc0203566:	85d2                	mv	a1,s4
ffffffffc0203568:	ca9ff0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc020356c:	26051be3          	bnez	a0,ffffffffc0203fe2 <pmm_init+0xcdc>
ffffffffc0203570:	00093503          	ld	a0,0(s2)
ffffffffc0203574:	4601                	li	a2,0
ffffffffc0203576:	4581                	li	a1,0
ffffffffc0203578:	ce2ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc020357c:	280505e3          	beqz	a0,ffffffffc0204006 <pmm_init+0xd00>
ffffffffc0203580:	611c                	ld	a5,0(a0)
ffffffffc0203582:	0017f713          	andi	a4,a5,1
ffffffffc0203586:	26070ee3          	beqz	a4,ffffffffc0204002 <pmm_init+0xcfc>
ffffffffc020358a:	6098                	ld	a4,0(s1)
ffffffffc020358c:	078a                	slli	a5,a5,0x2
ffffffffc020358e:	83b1                	srli	a5,a5,0xc
ffffffffc0203590:	62e7f363          	bgeu	a5,a4,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc0203594:	000bb683          	ld	a3,0(s7)
ffffffffc0203598:	fff80637          	lui	a2,0xfff80
ffffffffc020359c:	97b2                	add	a5,a5,a2
ffffffffc020359e:	079a                	slli	a5,a5,0x6
ffffffffc02035a0:	97b6                	add	a5,a5,a3
ffffffffc02035a2:	2afa12e3          	bne	s4,a5,ffffffffc0204046 <pmm_init+0xd40>
ffffffffc02035a6:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc02035aa:	4785                	li	a5,1
ffffffffc02035ac:	2cf699e3          	bne	a3,a5,ffffffffc020407e <pmm_init+0xd78>
ffffffffc02035b0:	00093503          	ld	a0,0(s2)
ffffffffc02035b4:	77fd                	lui	a5,0xfffff
ffffffffc02035b6:	6114                	ld	a3,0(a0)
ffffffffc02035b8:	068a                	slli	a3,a3,0x2
ffffffffc02035ba:	8efd                	and	a3,a3,a5
ffffffffc02035bc:	00c6d613          	srli	a2,a3,0xc
ffffffffc02035c0:	2ae673e3          	bgeu	a2,a4,ffffffffc0204066 <pmm_init+0xd60>
ffffffffc02035c4:	0009bc03          	ld	s8,0(s3)
ffffffffc02035c8:	96e2                	add	a3,a3,s8
ffffffffc02035ca:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc02035ce:	0a8a                	slli	s5,s5,0x2
ffffffffc02035d0:	00fafab3          	and	s5,s5,a5
ffffffffc02035d4:	00cad793          	srli	a5,s5,0xc
ffffffffc02035d8:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203e3e <pmm_init+0xb38>
ffffffffc02035dc:	4601                	li	a2,0
ffffffffc02035de:	6585                	lui	a1,0x1
ffffffffc02035e0:	9ae2                	add	s5,s5,s8
ffffffffc02035e2:	c78ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc02035e6:	0aa1                	addi	s5,s5,8
ffffffffc02035e8:	03551be3          	bne	a0,s5,ffffffffc0203e1e <pmm_init+0xb18>
ffffffffc02035ec:	100027f3          	csrr	a5,sstatus
ffffffffc02035f0:	8b89                	andi	a5,a5,2
ffffffffc02035f2:	3a079163          	bnez	a5,ffffffffc0203994 <pmm_init+0x68e>
ffffffffc02035f6:	000b3783          	ld	a5,0(s6)
ffffffffc02035fa:	4505                	li	a0,1
ffffffffc02035fc:	6f9c                	ld	a5,24(a5)
ffffffffc02035fe:	9782                	jalr	a5
ffffffffc0203600:	8c2a                	mv	s8,a0
ffffffffc0203602:	00093503          	ld	a0,0(s2)
ffffffffc0203606:	46d1                	li	a3,20
ffffffffc0203608:	6605                	lui	a2,0x1
ffffffffc020360a:	85e2                	mv	a1,s8
ffffffffc020360c:	c05ff0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc0203610:	1a0519e3          	bnez	a0,ffffffffc0203fc2 <pmm_init+0xcbc>
ffffffffc0203614:	00093503          	ld	a0,0(s2)
ffffffffc0203618:	4601                	li	a2,0
ffffffffc020361a:	6585                	lui	a1,0x1
ffffffffc020361c:	c3eff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0203620:	10050ce3          	beqz	a0,ffffffffc0203f38 <pmm_init+0xc32>
ffffffffc0203624:	611c                	ld	a5,0(a0)
ffffffffc0203626:	0107f713          	andi	a4,a5,16
ffffffffc020362a:	0e0707e3          	beqz	a4,ffffffffc0203f18 <pmm_init+0xc12>
ffffffffc020362e:	8b91                	andi	a5,a5,4
ffffffffc0203630:	0c0784e3          	beqz	a5,ffffffffc0203ef8 <pmm_init+0xbf2>
ffffffffc0203634:	00093503          	ld	a0,0(s2)
ffffffffc0203638:	611c                	ld	a5,0(a0)
ffffffffc020363a:	8bc1                	andi	a5,a5,16
ffffffffc020363c:	08078ee3          	beqz	a5,ffffffffc0203ed8 <pmm_init+0xbd2>
ffffffffc0203640:	000c2703          	lw	a4,0(s8)
ffffffffc0203644:	4785                	li	a5,1
ffffffffc0203646:	06f719e3          	bne	a4,a5,ffffffffc0203eb8 <pmm_init+0xbb2>
ffffffffc020364a:	4681                	li	a3,0
ffffffffc020364c:	6605                	lui	a2,0x1
ffffffffc020364e:	85d2                	mv	a1,s4
ffffffffc0203650:	bc1ff0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc0203654:	040512e3          	bnez	a0,ffffffffc0203e98 <pmm_init+0xb92>
ffffffffc0203658:	000a2703          	lw	a4,0(s4)
ffffffffc020365c:	4789                	li	a5,2
ffffffffc020365e:	00f71de3          	bne	a4,a5,ffffffffc0203e78 <pmm_init+0xb72>
ffffffffc0203662:	000c2783          	lw	a5,0(s8)
ffffffffc0203666:	7e079963          	bnez	a5,ffffffffc0203e58 <pmm_init+0xb52>
ffffffffc020366a:	00093503          	ld	a0,0(s2)
ffffffffc020366e:	4601                	li	a2,0
ffffffffc0203670:	6585                	lui	a1,0x1
ffffffffc0203672:	be8ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0203676:	54050263          	beqz	a0,ffffffffc0203bba <pmm_init+0x8b4>
ffffffffc020367a:	6118                	ld	a4,0(a0)
ffffffffc020367c:	00177793          	andi	a5,a4,1
ffffffffc0203680:	180781e3          	beqz	a5,ffffffffc0204002 <pmm_init+0xcfc>
ffffffffc0203684:	6094                	ld	a3,0(s1)
ffffffffc0203686:	00271793          	slli	a5,a4,0x2
ffffffffc020368a:	83b1                	srli	a5,a5,0xc
ffffffffc020368c:	52d7f563          	bgeu	a5,a3,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc0203690:	000bb683          	ld	a3,0(s7)
ffffffffc0203694:	fff80ab7          	lui	s5,0xfff80
ffffffffc0203698:	97d6                	add	a5,a5,s5
ffffffffc020369a:	079a                	slli	a5,a5,0x6
ffffffffc020369c:	97b6                	add	a5,a5,a3
ffffffffc020369e:	58fa1e63          	bne	s4,a5,ffffffffc0203c3a <pmm_init+0x934>
ffffffffc02036a2:	8b41                	andi	a4,a4,16
ffffffffc02036a4:	56071b63          	bnez	a4,ffffffffc0203c1a <pmm_init+0x914>
ffffffffc02036a8:	00093503          	ld	a0,0(s2)
ffffffffc02036ac:	4581                	li	a1,0
ffffffffc02036ae:	ac7ff0ef          	jal	ra,ffffffffc0203174 <page_remove>
ffffffffc02036b2:	000a2c83          	lw	s9,0(s4)
ffffffffc02036b6:	4785                	li	a5,1
ffffffffc02036b8:	5cfc9163          	bne	s9,a5,ffffffffc0203c7a <pmm_init+0x974>
ffffffffc02036bc:	000c2783          	lw	a5,0(s8)
ffffffffc02036c0:	58079d63          	bnez	a5,ffffffffc0203c5a <pmm_init+0x954>
ffffffffc02036c4:	00093503          	ld	a0,0(s2)
ffffffffc02036c8:	6585                	lui	a1,0x1
ffffffffc02036ca:	aabff0ef          	jal	ra,ffffffffc0203174 <page_remove>
ffffffffc02036ce:	000a2783          	lw	a5,0(s4)
ffffffffc02036d2:	200793e3          	bnez	a5,ffffffffc02040d8 <pmm_init+0xdd2>
ffffffffc02036d6:	000c2783          	lw	a5,0(s8)
ffffffffc02036da:	1c079fe3          	bnez	a5,ffffffffc02040b8 <pmm_init+0xdb2>
ffffffffc02036de:	00093a03          	ld	s4,0(s2)
ffffffffc02036e2:	608c                	ld	a1,0(s1)
ffffffffc02036e4:	000a3683          	ld	a3,0(s4)
ffffffffc02036e8:	068a                	slli	a3,a3,0x2
ffffffffc02036ea:	82b1                	srli	a3,a3,0xc
ffffffffc02036ec:	4cb6f563          	bgeu	a3,a1,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc02036f0:	000bb503          	ld	a0,0(s7)
ffffffffc02036f4:	96d6                	add	a3,a3,s5
ffffffffc02036f6:	069a                	slli	a3,a3,0x6
ffffffffc02036f8:	00d507b3          	add	a5,a0,a3
ffffffffc02036fc:	439c                	lw	a5,0(a5)
ffffffffc02036fe:	4f979e63          	bne	a5,s9,ffffffffc0203bfa <pmm_init+0x8f4>
ffffffffc0203702:	8699                	srai	a3,a3,0x6
ffffffffc0203704:	00080637          	lui	a2,0x80
ffffffffc0203708:	96b2                	add	a3,a3,a2
ffffffffc020370a:	00c69713          	slli	a4,a3,0xc
ffffffffc020370e:	8331                	srli	a4,a4,0xc
ffffffffc0203710:	06b2                	slli	a3,a3,0xc
ffffffffc0203712:	06b773e3          	bgeu	a4,a1,ffffffffc0203f78 <pmm_init+0xc72>
ffffffffc0203716:	0009b703          	ld	a4,0(s3)
ffffffffc020371a:	96ba                	add	a3,a3,a4
ffffffffc020371c:	629c                	ld	a5,0(a3)
ffffffffc020371e:	078a                	slli	a5,a5,0x2
ffffffffc0203720:	83b1                	srli	a5,a5,0xc
ffffffffc0203722:	48b7fa63          	bgeu	a5,a1,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc0203726:	8f91                	sub	a5,a5,a2
ffffffffc0203728:	079a                	slli	a5,a5,0x6
ffffffffc020372a:	953e                	add	a0,a0,a5
ffffffffc020372c:	100027f3          	csrr	a5,sstatus
ffffffffc0203730:	8b89                	andi	a5,a5,2
ffffffffc0203732:	32079463          	bnez	a5,ffffffffc0203a5a <pmm_init+0x754>
ffffffffc0203736:	000b3783          	ld	a5,0(s6)
ffffffffc020373a:	4585                	li	a1,1
ffffffffc020373c:	739c                	ld	a5,32(a5)
ffffffffc020373e:	9782                	jalr	a5
ffffffffc0203740:	000a3783          	ld	a5,0(s4)
ffffffffc0203744:	6098                	ld	a4,0(s1)
ffffffffc0203746:	078a                	slli	a5,a5,0x2
ffffffffc0203748:	83b1                	srli	a5,a5,0xc
ffffffffc020374a:	46e7f663          	bgeu	a5,a4,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc020374e:	000bb503          	ld	a0,0(s7)
ffffffffc0203752:	fff80737          	lui	a4,0xfff80
ffffffffc0203756:	97ba                	add	a5,a5,a4
ffffffffc0203758:	079a                	slli	a5,a5,0x6
ffffffffc020375a:	953e                	add	a0,a0,a5
ffffffffc020375c:	100027f3          	csrr	a5,sstatus
ffffffffc0203760:	8b89                	andi	a5,a5,2
ffffffffc0203762:	2e079063          	bnez	a5,ffffffffc0203a42 <pmm_init+0x73c>
ffffffffc0203766:	000b3783          	ld	a5,0(s6)
ffffffffc020376a:	4585                	li	a1,1
ffffffffc020376c:	739c                	ld	a5,32(a5)
ffffffffc020376e:	9782                	jalr	a5
ffffffffc0203770:	00093783          	ld	a5,0(s2)
ffffffffc0203774:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203778:	12000073          	sfence.vma
ffffffffc020377c:	100027f3          	csrr	a5,sstatus
ffffffffc0203780:	8b89                	andi	a5,a5,2
ffffffffc0203782:	2a079663          	bnez	a5,ffffffffc0203a2e <pmm_init+0x728>
ffffffffc0203786:	000b3783          	ld	a5,0(s6)
ffffffffc020378a:	779c                	ld	a5,40(a5)
ffffffffc020378c:	9782                	jalr	a5
ffffffffc020378e:	8a2a                	mv	s4,a0
ffffffffc0203790:	7d441463          	bne	s0,s4,ffffffffc0203f58 <pmm_init+0xc52>
ffffffffc0203794:	00009517          	auipc	a0,0x9
ffffffffc0203798:	53450513          	addi	a0,a0,1332 # ffffffffc020ccc8 <default_pmm_manager+0x508>
ffffffffc020379c:	98ffc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02037a0:	100027f3          	csrr	a5,sstatus
ffffffffc02037a4:	8b89                	andi	a5,a5,2
ffffffffc02037a6:	26079a63          	bnez	a5,ffffffffc0203a1a <pmm_init+0x714>
ffffffffc02037aa:	000b3783          	ld	a5,0(s6)
ffffffffc02037ae:	779c                	ld	a5,40(a5)
ffffffffc02037b0:	9782                	jalr	a5
ffffffffc02037b2:	8c2a                	mv	s8,a0
ffffffffc02037b4:	6098                	ld	a4,0(s1)
ffffffffc02037b6:	c0200437          	lui	s0,0xc0200
ffffffffc02037ba:	7afd                	lui	s5,0xfffff
ffffffffc02037bc:	00c71793          	slli	a5,a4,0xc
ffffffffc02037c0:	6a05                	lui	s4,0x1
ffffffffc02037c2:	02f47c63          	bgeu	s0,a5,ffffffffc02037fa <pmm_init+0x4f4>
ffffffffc02037c6:	00c45793          	srli	a5,s0,0xc
ffffffffc02037ca:	00093503          	ld	a0,0(s2)
ffffffffc02037ce:	3ae7f763          	bgeu	a5,a4,ffffffffc0203b7c <pmm_init+0x876>
ffffffffc02037d2:	0009b583          	ld	a1,0(s3)
ffffffffc02037d6:	4601                	li	a2,0
ffffffffc02037d8:	95a2                	add	a1,a1,s0
ffffffffc02037da:	a80ff0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc02037de:	36050f63          	beqz	a0,ffffffffc0203b5c <pmm_init+0x856>
ffffffffc02037e2:	611c                	ld	a5,0(a0)
ffffffffc02037e4:	078a                	slli	a5,a5,0x2
ffffffffc02037e6:	0157f7b3          	and	a5,a5,s5
ffffffffc02037ea:	3a879663          	bne	a5,s0,ffffffffc0203b96 <pmm_init+0x890>
ffffffffc02037ee:	6098                	ld	a4,0(s1)
ffffffffc02037f0:	9452                	add	s0,s0,s4
ffffffffc02037f2:	00c71793          	slli	a5,a4,0xc
ffffffffc02037f6:	fcf468e3          	bltu	s0,a5,ffffffffc02037c6 <pmm_init+0x4c0>
ffffffffc02037fa:	00093783          	ld	a5,0(s2)
ffffffffc02037fe:	639c                	ld	a5,0(a5)
ffffffffc0203800:	48079d63          	bnez	a5,ffffffffc0203c9a <pmm_init+0x994>
ffffffffc0203804:	100027f3          	csrr	a5,sstatus
ffffffffc0203808:	8b89                	andi	a5,a5,2
ffffffffc020380a:	26079463          	bnez	a5,ffffffffc0203a72 <pmm_init+0x76c>
ffffffffc020380e:	000b3783          	ld	a5,0(s6)
ffffffffc0203812:	4505                	li	a0,1
ffffffffc0203814:	6f9c                	ld	a5,24(a5)
ffffffffc0203816:	9782                	jalr	a5
ffffffffc0203818:	8a2a                	mv	s4,a0
ffffffffc020381a:	00093503          	ld	a0,0(s2)
ffffffffc020381e:	4699                	li	a3,6
ffffffffc0203820:	10000613          	li	a2,256
ffffffffc0203824:	85d2                	mv	a1,s4
ffffffffc0203826:	9ebff0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc020382a:	4a051863          	bnez	a0,ffffffffc0203cda <pmm_init+0x9d4>
ffffffffc020382e:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203832:	4785                	li	a5,1
ffffffffc0203834:	48f71363          	bne	a4,a5,ffffffffc0203cba <pmm_init+0x9b4>
ffffffffc0203838:	00093503          	ld	a0,0(s2)
ffffffffc020383c:	6405                	lui	s0,0x1
ffffffffc020383e:	4699                	li	a3,6
ffffffffc0203840:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc0203844:	85d2                	mv	a1,s4
ffffffffc0203846:	9cbff0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc020384a:	38051863          	bnez	a0,ffffffffc0203bda <pmm_init+0x8d4>
ffffffffc020384e:	000a2703          	lw	a4,0(s4)
ffffffffc0203852:	4789                	li	a5,2
ffffffffc0203854:	4ef71363          	bne	a4,a5,ffffffffc0203d3a <pmm_init+0xa34>
ffffffffc0203858:	00009597          	auipc	a1,0x9
ffffffffc020385c:	5b858593          	addi	a1,a1,1464 # ffffffffc020ce10 <default_pmm_manager+0x650>
ffffffffc0203860:	10000513          	li	a0,256
ffffffffc0203864:	724070ef          	jal	ra,ffffffffc020af88 <strcpy>
ffffffffc0203868:	10040593          	addi	a1,s0,256
ffffffffc020386c:	10000513          	li	a0,256
ffffffffc0203870:	72a070ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc0203874:	4a051363          	bnez	a0,ffffffffc0203d1a <pmm_init+0xa14>
ffffffffc0203878:	000bb683          	ld	a3,0(s7)
ffffffffc020387c:	00080737          	lui	a4,0x80
ffffffffc0203880:	547d                	li	s0,-1
ffffffffc0203882:	40da06b3          	sub	a3,s4,a3
ffffffffc0203886:	8699                	srai	a3,a3,0x6
ffffffffc0203888:	609c                	ld	a5,0(s1)
ffffffffc020388a:	96ba                	add	a3,a3,a4
ffffffffc020388c:	8031                	srli	s0,s0,0xc
ffffffffc020388e:	0086f733          	and	a4,a3,s0
ffffffffc0203892:	06b2                	slli	a3,a3,0xc
ffffffffc0203894:	6ef77263          	bgeu	a4,a5,ffffffffc0203f78 <pmm_init+0xc72>
ffffffffc0203898:	0009b783          	ld	a5,0(s3)
ffffffffc020389c:	10000513          	li	a0,256
ffffffffc02038a0:	96be                	add	a3,a3,a5
ffffffffc02038a2:	10068023          	sb	zero,256(a3)
ffffffffc02038a6:	6ac070ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc02038aa:	44051863          	bnez	a0,ffffffffc0203cfa <pmm_init+0x9f4>
ffffffffc02038ae:	00093a83          	ld	s5,0(s2)
ffffffffc02038b2:	609c                	ld	a5,0(s1)
ffffffffc02038b4:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc02038b8:	068a                	slli	a3,a3,0x2
ffffffffc02038ba:	82b1                	srli	a3,a3,0xc
ffffffffc02038bc:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc02038c0:	8c75                	and	s0,s0,a3
ffffffffc02038c2:	06b2                	slli	a3,a3,0xc
ffffffffc02038c4:	6af47a63          	bgeu	s0,a5,ffffffffc0203f78 <pmm_init+0xc72>
ffffffffc02038c8:	0009b403          	ld	s0,0(s3)
ffffffffc02038cc:	9436                	add	s0,s0,a3
ffffffffc02038ce:	100027f3          	csrr	a5,sstatus
ffffffffc02038d2:	8b89                	andi	a5,a5,2
ffffffffc02038d4:	1e079c63          	bnez	a5,ffffffffc0203acc <pmm_init+0x7c6>
ffffffffc02038d8:	000b3783          	ld	a5,0(s6)
ffffffffc02038dc:	4585                	li	a1,1
ffffffffc02038de:	8552                	mv	a0,s4
ffffffffc02038e0:	739c                	ld	a5,32(a5)
ffffffffc02038e2:	9782                	jalr	a5
ffffffffc02038e4:	601c                	ld	a5,0(s0)
ffffffffc02038e6:	6098                	ld	a4,0(s1)
ffffffffc02038e8:	078a                	slli	a5,a5,0x2
ffffffffc02038ea:	83b1                	srli	a5,a5,0xc
ffffffffc02038ec:	2ce7f563          	bgeu	a5,a4,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc02038f0:	000bb503          	ld	a0,0(s7)
ffffffffc02038f4:	fff80737          	lui	a4,0xfff80
ffffffffc02038f8:	97ba                	add	a5,a5,a4
ffffffffc02038fa:	079a                	slli	a5,a5,0x6
ffffffffc02038fc:	953e                	add	a0,a0,a5
ffffffffc02038fe:	100027f3          	csrr	a5,sstatus
ffffffffc0203902:	8b89                	andi	a5,a5,2
ffffffffc0203904:	1a079863          	bnez	a5,ffffffffc0203ab4 <pmm_init+0x7ae>
ffffffffc0203908:	000b3783          	ld	a5,0(s6)
ffffffffc020390c:	4585                	li	a1,1
ffffffffc020390e:	739c                	ld	a5,32(a5)
ffffffffc0203910:	9782                	jalr	a5
ffffffffc0203912:	000ab783          	ld	a5,0(s5)
ffffffffc0203916:	6098                	ld	a4,0(s1)
ffffffffc0203918:	078a                	slli	a5,a5,0x2
ffffffffc020391a:	83b1                	srli	a5,a5,0xc
ffffffffc020391c:	28e7fd63          	bgeu	a5,a4,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc0203920:	000bb503          	ld	a0,0(s7)
ffffffffc0203924:	fff80737          	lui	a4,0xfff80
ffffffffc0203928:	97ba                	add	a5,a5,a4
ffffffffc020392a:	079a                	slli	a5,a5,0x6
ffffffffc020392c:	953e                	add	a0,a0,a5
ffffffffc020392e:	100027f3          	csrr	a5,sstatus
ffffffffc0203932:	8b89                	andi	a5,a5,2
ffffffffc0203934:	16079463          	bnez	a5,ffffffffc0203a9c <pmm_init+0x796>
ffffffffc0203938:	000b3783          	ld	a5,0(s6)
ffffffffc020393c:	4585                	li	a1,1
ffffffffc020393e:	739c                	ld	a5,32(a5)
ffffffffc0203940:	9782                	jalr	a5
ffffffffc0203942:	00093783          	ld	a5,0(s2)
ffffffffc0203946:	0007b023          	sd	zero,0(a5)
ffffffffc020394a:	12000073          	sfence.vma
ffffffffc020394e:	100027f3          	csrr	a5,sstatus
ffffffffc0203952:	8b89                	andi	a5,a5,2
ffffffffc0203954:	12079a63          	bnez	a5,ffffffffc0203a88 <pmm_init+0x782>
ffffffffc0203958:	000b3783          	ld	a5,0(s6)
ffffffffc020395c:	779c                	ld	a5,40(a5)
ffffffffc020395e:	9782                	jalr	a5
ffffffffc0203960:	842a                	mv	s0,a0
ffffffffc0203962:	488c1e63          	bne	s8,s0,ffffffffc0203dfe <pmm_init+0xaf8>
ffffffffc0203966:	00009517          	auipc	a0,0x9
ffffffffc020396a:	52250513          	addi	a0,a0,1314 # ffffffffc020ce88 <default_pmm_manager+0x6c8>
ffffffffc020396e:	fbcfc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0203972:	7406                	ld	s0,96(sp)
ffffffffc0203974:	70a6                	ld	ra,104(sp)
ffffffffc0203976:	64e6                	ld	s1,88(sp)
ffffffffc0203978:	6946                	ld	s2,80(sp)
ffffffffc020397a:	69a6                	ld	s3,72(sp)
ffffffffc020397c:	6a06                	ld	s4,64(sp)
ffffffffc020397e:	7ae2                	ld	s5,56(sp)
ffffffffc0203980:	7b42                	ld	s6,48(sp)
ffffffffc0203982:	7ba2                	ld	s7,40(sp)
ffffffffc0203984:	7c02                	ld	s8,32(sp)
ffffffffc0203986:	6ce2                	ld	s9,24(sp)
ffffffffc0203988:	6165                	addi	sp,sp,112
ffffffffc020398a:	b68fe06f          	j	ffffffffc0201cf2 <kmalloc_init>
ffffffffc020398e:	c80007b7          	lui	a5,0xc8000
ffffffffc0203992:	b411                	j	ffffffffc0203396 <pmm_init+0x90>
ffffffffc0203994:	c10fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203998:	000b3783          	ld	a5,0(s6)
ffffffffc020399c:	4505                	li	a0,1
ffffffffc020399e:	6f9c                	ld	a5,24(a5)
ffffffffc02039a0:	9782                	jalr	a5
ffffffffc02039a2:	8c2a                	mv	s8,a0
ffffffffc02039a4:	bfafd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02039a8:	b9a9                	j	ffffffffc0203602 <pmm_init+0x2fc>
ffffffffc02039aa:	bfafd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02039ae:	000b3783          	ld	a5,0(s6)
ffffffffc02039b2:	4505                	li	a0,1
ffffffffc02039b4:	6f9c                	ld	a5,24(a5)
ffffffffc02039b6:	9782                	jalr	a5
ffffffffc02039b8:	8a2a                	mv	s4,a0
ffffffffc02039ba:	be4fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02039be:	b645                	j	ffffffffc020355e <pmm_init+0x258>
ffffffffc02039c0:	be4fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02039c4:	000b3783          	ld	a5,0(s6)
ffffffffc02039c8:	779c                	ld	a5,40(a5)
ffffffffc02039ca:	9782                	jalr	a5
ffffffffc02039cc:	842a                	mv	s0,a0
ffffffffc02039ce:	bd0fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02039d2:	b6b9                	j	ffffffffc0203520 <pmm_init+0x21a>
ffffffffc02039d4:	bd0fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02039d8:	000b3783          	ld	a5,0(s6)
ffffffffc02039dc:	4505                	li	a0,1
ffffffffc02039de:	6f9c                	ld	a5,24(a5)
ffffffffc02039e0:	9782                	jalr	a5
ffffffffc02039e2:	842a                	mv	s0,a0
ffffffffc02039e4:	bbafd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02039e8:	bc99                	j	ffffffffc020343e <pmm_init+0x138>
ffffffffc02039ea:	6705                	lui	a4,0x1
ffffffffc02039ec:	177d                	addi	a4,a4,-1
ffffffffc02039ee:	96ba                	add	a3,a3,a4
ffffffffc02039f0:	8ff5                	and	a5,a5,a3
ffffffffc02039f2:	00c7d713          	srli	a4,a5,0xc
ffffffffc02039f6:	1ca77063          	bgeu	a4,a0,ffffffffc0203bb6 <pmm_init+0x8b0>
ffffffffc02039fa:	000b3683          	ld	a3,0(s6)
ffffffffc02039fe:	fff80537          	lui	a0,0xfff80
ffffffffc0203a02:	972a                	add	a4,a4,a0
ffffffffc0203a04:	6a94                	ld	a3,16(a3)
ffffffffc0203a06:	8c1d                	sub	s0,s0,a5
ffffffffc0203a08:	00671513          	slli	a0,a4,0x6
ffffffffc0203a0c:	00c45593          	srli	a1,s0,0xc
ffffffffc0203a10:	9532                	add	a0,a0,a2
ffffffffc0203a12:	9682                	jalr	a3
ffffffffc0203a14:	0009b583          	ld	a1,0(s3)
ffffffffc0203a18:	bac5                	j	ffffffffc0203408 <pmm_init+0x102>
ffffffffc0203a1a:	b8afd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203a1e:	000b3783          	ld	a5,0(s6)
ffffffffc0203a22:	779c                	ld	a5,40(a5)
ffffffffc0203a24:	9782                	jalr	a5
ffffffffc0203a26:	8c2a                	mv	s8,a0
ffffffffc0203a28:	b76fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203a2c:	b361                	j	ffffffffc02037b4 <pmm_init+0x4ae>
ffffffffc0203a2e:	b76fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203a32:	000b3783          	ld	a5,0(s6)
ffffffffc0203a36:	779c                	ld	a5,40(a5)
ffffffffc0203a38:	9782                	jalr	a5
ffffffffc0203a3a:	8a2a                	mv	s4,a0
ffffffffc0203a3c:	b62fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203a40:	bb81                	j	ffffffffc0203790 <pmm_init+0x48a>
ffffffffc0203a42:	e42a                	sd	a0,8(sp)
ffffffffc0203a44:	b60fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203a48:	000b3783          	ld	a5,0(s6)
ffffffffc0203a4c:	6522                	ld	a0,8(sp)
ffffffffc0203a4e:	4585                	li	a1,1
ffffffffc0203a50:	739c                	ld	a5,32(a5)
ffffffffc0203a52:	9782                	jalr	a5
ffffffffc0203a54:	b4afd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203a58:	bb21                	j	ffffffffc0203770 <pmm_init+0x46a>
ffffffffc0203a5a:	e42a                	sd	a0,8(sp)
ffffffffc0203a5c:	b48fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203a60:	000b3783          	ld	a5,0(s6)
ffffffffc0203a64:	6522                	ld	a0,8(sp)
ffffffffc0203a66:	4585                	li	a1,1
ffffffffc0203a68:	739c                	ld	a5,32(a5)
ffffffffc0203a6a:	9782                	jalr	a5
ffffffffc0203a6c:	b32fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203a70:	b9c1                	j	ffffffffc0203740 <pmm_init+0x43a>
ffffffffc0203a72:	b32fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203a76:	000b3783          	ld	a5,0(s6)
ffffffffc0203a7a:	4505                	li	a0,1
ffffffffc0203a7c:	6f9c                	ld	a5,24(a5)
ffffffffc0203a7e:	9782                	jalr	a5
ffffffffc0203a80:	8a2a                	mv	s4,a0
ffffffffc0203a82:	b1cfd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203a86:	bb51                	j	ffffffffc020381a <pmm_init+0x514>
ffffffffc0203a88:	b1cfd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203a8c:	000b3783          	ld	a5,0(s6)
ffffffffc0203a90:	779c                	ld	a5,40(a5)
ffffffffc0203a92:	9782                	jalr	a5
ffffffffc0203a94:	842a                	mv	s0,a0
ffffffffc0203a96:	b08fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203a9a:	b5e1                	j	ffffffffc0203962 <pmm_init+0x65c>
ffffffffc0203a9c:	e42a                	sd	a0,8(sp)
ffffffffc0203a9e:	b06fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203aa2:	000b3783          	ld	a5,0(s6)
ffffffffc0203aa6:	6522                	ld	a0,8(sp)
ffffffffc0203aa8:	4585                	li	a1,1
ffffffffc0203aaa:	739c                	ld	a5,32(a5)
ffffffffc0203aac:	9782                	jalr	a5
ffffffffc0203aae:	af0fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203ab2:	bd41                	j	ffffffffc0203942 <pmm_init+0x63c>
ffffffffc0203ab4:	e42a                	sd	a0,8(sp)
ffffffffc0203ab6:	aeefd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203aba:	000b3783          	ld	a5,0(s6)
ffffffffc0203abe:	6522                	ld	a0,8(sp)
ffffffffc0203ac0:	4585                	li	a1,1
ffffffffc0203ac2:	739c                	ld	a5,32(a5)
ffffffffc0203ac4:	9782                	jalr	a5
ffffffffc0203ac6:	ad8fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203aca:	b5a1                	j	ffffffffc0203912 <pmm_init+0x60c>
ffffffffc0203acc:	ad8fd0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0203ad0:	000b3783          	ld	a5,0(s6)
ffffffffc0203ad4:	4585                	li	a1,1
ffffffffc0203ad6:	8552                	mv	a0,s4
ffffffffc0203ad8:	739c                	ld	a5,32(a5)
ffffffffc0203ada:	9782                	jalr	a5
ffffffffc0203adc:	ac2fd0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0203ae0:	b511                	j	ffffffffc02038e4 <pmm_init+0x5de>
ffffffffc0203ae2:	0000f417          	auipc	s0,0xf
ffffffffc0203ae6:	51e40413          	addi	s0,s0,1310 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203aea:	0000f797          	auipc	a5,0xf
ffffffffc0203aee:	51678793          	addi	a5,a5,1302 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203af2:	a0f41de3          	bne	s0,a5,ffffffffc020350c <pmm_init+0x206>
ffffffffc0203af6:	4581                	li	a1,0
ffffffffc0203af8:	6605                	lui	a2,0x1
ffffffffc0203afa:	8522                	mv	a0,s0
ffffffffc0203afc:	4f8070ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0203b00:	0000c597          	auipc	a1,0xc
ffffffffc0203b04:	50058593          	addi	a1,a1,1280 # ffffffffc0210000 <bootstackguard>
ffffffffc0203b08:	0000d797          	auipc	a5,0xd
ffffffffc0203b0c:	4e078ba3          	sb	zero,1271(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc0203b10:	0000c797          	auipc	a5,0xc
ffffffffc0203b14:	4e078823          	sb	zero,1264(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc0203b18:	00093503          	ld	a0,0(s2)
ffffffffc0203b1c:	2555ec63          	bltu	a1,s5,ffffffffc0203d74 <pmm_init+0xa6e>
ffffffffc0203b20:	0009b683          	ld	a3,0(s3)
ffffffffc0203b24:	4701                	li	a4,0
ffffffffc0203b26:	6605                	lui	a2,0x1
ffffffffc0203b28:	40d586b3          	sub	a3,a1,a3
ffffffffc0203b2c:	956ff0ef          	jal	ra,ffffffffc0202c82 <boot_map_segment>
ffffffffc0203b30:	00093503          	ld	a0,0(s2)
ffffffffc0203b34:	23546363          	bltu	s0,s5,ffffffffc0203d5a <pmm_init+0xa54>
ffffffffc0203b38:	0009b683          	ld	a3,0(s3)
ffffffffc0203b3c:	4701                	li	a4,0
ffffffffc0203b3e:	6605                	lui	a2,0x1
ffffffffc0203b40:	40d406b3          	sub	a3,s0,a3
ffffffffc0203b44:	85a2                	mv	a1,s0
ffffffffc0203b46:	93cff0ef          	jal	ra,ffffffffc0202c82 <boot_map_segment>
ffffffffc0203b4a:	12000073          	sfence.vma
ffffffffc0203b4e:	00009517          	auipc	a0,0x9
ffffffffc0203b52:	e4a50513          	addi	a0,a0,-438 # ffffffffc020c998 <default_pmm_manager+0x1d8>
ffffffffc0203b56:	dd4fc0ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0203b5a:	ba4d                	j	ffffffffc020350c <pmm_init+0x206>
ffffffffc0203b5c:	00009697          	auipc	a3,0x9
ffffffffc0203b60:	18c68693          	addi	a3,a3,396 # ffffffffc020cce8 <default_pmm_manager+0x528>
ffffffffc0203b64:	00008617          	auipc	a2,0x8
ffffffffc0203b68:	c9460613          	addi	a2,a2,-876 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203b6c:	28d00593          	li	a1,653
ffffffffc0203b70:	00009517          	auipc	a0,0x9
ffffffffc0203b74:	cb050513          	addi	a0,a0,-848 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203b78:	eb6fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203b7c:	86a2                	mv	a3,s0
ffffffffc0203b7e:	00008617          	auipc	a2,0x8
ffffffffc0203b82:	7aa60613          	addi	a2,a2,1962 # ffffffffc020c328 <commands+0xb90>
ffffffffc0203b86:	28d00593          	li	a1,653
ffffffffc0203b8a:	00009517          	auipc	a0,0x9
ffffffffc0203b8e:	c9650513          	addi	a0,a0,-874 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203b92:	e9cfc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203b96:	00009697          	auipc	a3,0x9
ffffffffc0203b9a:	19268693          	addi	a3,a3,402 # ffffffffc020cd28 <default_pmm_manager+0x568>
ffffffffc0203b9e:	00008617          	auipc	a2,0x8
ffffffffc0203ba2:	c5a60613          	addi	a2,a2,-934 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203ba6:	28e00593          	li	a1,654
ffffffffc0203baa:	00009517          	auipc	a0,0x9
ffffffffc0203bae:	c7650513          	addi	a0,a0,-906 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203bb2:	e7cfc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203bb6:	db5fe0ef          	jal	ra,ffffffffc020296a <pa2page.part.0>
ffffffffc0203bba:	00009697          	auipc	a3,0x9
ffffffffc0203bbe:	f9668693          	addi	a3,a3,-106 # ffffffffc020cb50 <default_pmm_manager+0x390>
ffffffffc0203bc2:	00008617          	auipc	a2,0x8
ffffffffc0203bc6:	c3660613          	addi	a2,a2,-970 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203bca:	26a00593          	li	a1,618
ffffffffc0203bce:	00009517          	auipc	a0,0x9
ffffffffc0203bd2:	c5250513          	addi	a0,a0,-942 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203bd6:	e58fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203bda:	00009697          	auipc	a3,0x9
ffffffffc0203bde:	1d668693          	addi	a3,a3,470 # ffffffffc020cdb0 <default_pmm_manager+0x5f0>
ffffffffc0203be2:	00008617          	auipc	a2,0x8
ffffffffc0203be6:	c1660613          	addi	a2,a2,-1002 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203bea:	29700593          	li	a1,663
ffffffffc0203bee:	00009517          	auipc	a0,0x9
ffffffffc0203bf2:	c3250513          	addi	a0,a0,-974 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203bf6:	e38fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203bfa:	00009697          	auipc	a3,0x9
ffffffffc0203bfe:	07668693          	addi	a3,a3,118 # ffffffffc020cc70 <default_pmm_manager+0x4b0>
ffffffffc0203c02:	00008617          	auipc	a2,0x8
ffffffffc0203c06:	bf660613          	addi	a2,a2,-1034 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203c0a:	27600593          	li	a1,630
ffffffffc0203c0e:	00009517          	auipc	a0,0x9
ffffffffc0203c12:	c1250513          	addi	a0,a0,-1006 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203c16:	e18fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203c1a:	00009697          	auipc	a3,0x9
ffffffffc0203c1e:	02668693          	addi	a3,a3,38 # ffffffffc020cc40 <default_pmm_manager+0x480>
ffffffffc0203c22:	00008617          	auipc	a2,0x8
ffffffffc0203c26:	bd660613          	addi	a2,a2,-1066 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203c2a:	26c00593          	li	a1,620
ffffffffc0203c2e:	00009517          	auipc	a0,0x9
ffffffffc0203c32:	bf250513          	addi	a0,a0,-1038 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203c36:	df8fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203c3a:	00009697          	auipc	a3,0x9
ffffffffc0203c3e:	e7668693          	addi	a3,a3,-394 # ffffffffc020cab0 <default_pmm_manager+0x2f0>
ffffffffc0203c42:	00008617          	auipc	a2,0x8
ffffffffc0203c46:	bb660613          	addi	a2,a2,-1098 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203c4a:	26b00593          	li	a1,619
ffffffffc0203c4e:	00009517          	auipc	a0,0x9
ffffffffc0203c52:	bd250513          	addi	a0,a0,-1070 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203c56:	dd8fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203c5a:	00009697          	auipc	a3,0x9
ffffffffc0203c5e:	fce68693          	addi	a3,a3,-50 # ffffffffc020cc28 <default_pmm_manager+0x468>
ffffffffc0203c62:	00008617          	auipc	a2,0x8
ffffffffc0203c66:	b9660613          	addi	a2,a2,-1130 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203c6a:	27000593          	li	a1,624
ffffffffc0203c6e:	00009517          	auipc	a0,0x9
ffffffffc0203c72:	bb250513          	addi	a0,a0,-1102 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203c76:	db8fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203c7a:	00009697          	auipc	a3,0x9
ffffffffc0203c7e:	e4e68693          	addi	a3,a3,-434 # ffffffffc020cac8 <default_pmm_manager+0x308>
ffffffffc0203c82:	00008617          	auipc	a2,0x8
ffffffffc0203c86:	b7660613          	addi	a2,a2,-1162 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203c8a:	26f00593          	li	a1,623
ffffffffc0203c8e:	00009517          	auipc	a0,0x9
ffffffffc0203c92:	b9250513          	addi	a0,a0,-1134 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203c96:	d98fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203c9a:	00009697          	auipc	a3,0x9
ffffffffc0203c9e:	0a668693          	addi	a3,a3,166 # ffffffffc020cd40 <default_pmm_manager+0x580>
ffffffffc0203ca2:	00008617          	auipc	a2,0x8
ffffffffc0203ca6:	b5660613          	addi	a2,a2,-1194 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203caa:	29100593          	li	a1,657
ffffffffc0203cae:	00009517          	auipc	a0,0x9
ffffffffc0203cb2:	b7250513          	addi	a0,a0,-1166 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203cb6:	d78fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203cba:	00009697          	auipc	a3,0x9
ffffffffc0203cbe:	0de68693          	addi	a3,a3,222 # ffffffffc020cd98 <default_pmm_manager+0x5d8>
ffffffffc0203cc2:	00008617          	auipc	a2,0x8
ffffffffc0203cc6:	b3660613          	addi	a2,a2,-1226 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203cca:	29600593          	li	a1,662
ffffffffc0203cce:	00009517          	auipc	a0,0x9
ffffffffc0203cd2:	b5250513          	addi	a0,a0,-1198 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203cd6:	d58fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203cda:	00009697          	auipc	a3,0x9
ffffffffc0203cde:	07e68693          	addi	a3,a3,126 # ffffffffc020cd58 <default_pmm_manager+0x598>
ffffffffc0203ce2:	00008617          	auipc	a2,0x8
ffffffffc0203ce6:	b1660613          	addi	a2,a2,-1258 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203cea:	29500593          	li	a1,661
ffffffffc0203cee:	00009517          	auipc	a0,0x9
ffffffffc0203cf2:	b3250513          	addi	a0,a0,-1230 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203cf6:	d38fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203cfa:	00009697          	auipc	a3,0x9
ffffffffc0203cfe:	16668693          	addi	a3,a3,358 # ffffffffc020ce60 <default_pmm_manager+0x6a0>
ffffffffc0203d02:	00008617          	auipc	a2,0x8
ffffffffc0203d06:	af660613          	addi	a2,a2,-1290 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203d0a:	29f00593          	li	a1,671
ffffffffc0203d0e:	00009517          	auipc	a0,0x9
ffffffffc0203d12:	b1250513          	addi	a0,a0,-1262 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203d16:	d18fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203d1a:	00009697          	auipc	a3,0x9
ffffffffc0203d1e:	10e68693          	addi	a3,a3,270 # ffffffffc020ce28 <default_pmm_manager+0x668>
ffffffffc0203d22:	00008617          	auipc	a2,0x8
ffffffffc0203d26:	ad660613          	addi	a2,a2,-1322 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203d2a:	29c00593          	li	a1,668
ffffffffc0203d2e:	00009517          	auipc	a0,0x9
ffffffffc0203d32:	af250513          	addi	a0,a0,-1294 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203d36:	cf8fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203d3a:	00009697          	auipc	a3,0x9
ffffffffc0203d3e:	0be68693          	addi	a3,a3,190 # ffffffffc020cdf8 <default_pmm_manager+0x638>
ffffffffc0203d42:	00008617          	auipc	a2,0x8
ffffffffc0203d46:	ab660613          	addi	a2,a2,-1354 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203d4a:	29800593          	li	a1,664
ffffffffc0203d4e:	00009517          	auipc	a0,0x9
ffffffffc0203d52:	ad250513          	addi	a0,a0,-1326 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203d56:	cd8fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203d5a:	86a2                	mv	a3,s0
ffffffffc0203d5c:	00008617          	auipc	a2,0x8
ffffffffc0203d60:	67460613          	addi	a2,a2,1652 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0203d64:	0dc00593          	li	a1,220
ffffffffc0203d68:	00009517          	auipc	a0,0x9
ffffffffc0203d6c:	ab850513          	addi	a0,a0,-1352 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203d70:	cbefc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203d74:	86ae                	mv	a3,a1
ffffffffc0203d76:	00008617          	auipc	a2,0x8
ffffffffc0203d7a:	65a60613          	addi	a2,a2,1626 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0203d7e:	0db00593          	li	a1,219
ffffffffc0203d82:	00009517          	auipc	a0,0x9
ffffffffc0203d86:	a9e50513          	addi	a0,a0,-1378 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203d8a:	ca4fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203d8e:	00009697          	auipc	a3,0x9
ffffffffc0203d92:	c5268693          	addi	a3,a3,-942 # ffffffffc020c9e0 <default_pmm_manager+0x220>
ffffffffc0203d96:	00008617          	auipc	a2,0x8
ffffffffc0203d9a:	a6260613          	addi	a2,a2,-1438 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203d9e:	24f00593          	li	a1,591
ffffffffc0203da2:	00009517          	auipc	a0,0x9
ffffffffc0203da6:	a7e50513          	addi	a0,a0,-1410 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203daa:	c84fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203dae:	00009697          	auipc	a3,0x9
ffffffffc0203db2:	c1268693          	addi	a3,a3,-1006 # ffffffffc020c9c0 <default_pmm_manager+0x200>
ffffffffc0203db6:	00008617          	auipc	a2,0x8
ffffffffc0203dba:	a4260613          	addi	a2,a2,-1470 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203dbe:	24e00593          	li	a1,590
ffffffffc0203dc2:	00009517          	auipc	a0,0x9
ffffffffc0203dc6:	a5e50513          	addi	a0,a0,-1442 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203dca:	c64fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203dce:	00009617          	auipc	a2,0x9
ffffffffc0203dd2:	b8260613          	addi	a2,a2,-1150 # ffffffffc020c950 <default_pmm_manager+0x190>
ffffffffc0203dd6:	0aa00593          	li	a1,170
ffffffffc0203dda:	00009517          	auipc	a0,0x9
ffffffffc0203dde:	a4650513          	addi	a0,a0,-1466 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203de2:	c4cfc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203de6:	00009617          	auipc	a2,0x9
ffffffffc0203dea:	ad260613          	addi	a2,a2,-1326 # ffffffffc020c8b8 <default_pmm_manager+0xf8>
ffffffffc0203dee:	06500593          	li	a1,101
ffffffffc0203df2:	00009517          	auipc	a0,0x9
ffffffffc0203df6:	a2e50513          	addi	a0,a0,-1490 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203dfa:	c34fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203dfe:	00009697          	auipc	a3,0x9
ffffffffc0203e02:	ea268693          	addi	a3,a3,-350 # ffffffffc020cca0 <default_pmm_manager+0x4e0>
ffffffffc0203e06:	00008617          	auipc	a2,0x8
ffffffffc0203e0a:	9f260613          	addi	a2,a2,-1550 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203e0e:	2a800593          	li	a1,680
ffffffffc0203e12:	00009517          	auipc	a0,0x9
ffffffffc0203e16:	a0e50513          	addi	a0,a0,-1522 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203e1a:	c14fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203e1e:	00009697          	auipc	a3,0x9
ffffffffc0203e22:	cc268693          	addi	a3,a3,-830 # ffffffffc020cae0 <default_pmm_manager+0x320>
ffffffffc0203e26:	00008617          	auipc	a2,0x8
ffffffffc0203e2a:	9d260613          	addi	a2,a2,-1582 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203e2e:	25d00593          	li	a1,605
ffffffffc0203e32:	00009517          	auipc	a0,0x9
ffffffffc0203e36:	9ee50513          	addi	a0,a0,-1554 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203e3a:	bf4fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203e3e:	86d6                	mv	a3,s5
ffffffffc0203e40:	00008617          	auipc	a2,0x8
ffffffffc0203e44:	4e860613          	addi	a2,a2,1256 # ffffffffc020c328 <commands+0xb90>
ffffffffc0203e48:	25c00593          	li	a1,604
ffffffffc0203e4c:	00009517          	auipc	a0,0x9
ffffffffc0203e50:	9d450513          	addi	a0,a0,-1580 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203e54:	bdafc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203e58:	00009697          	auipc	a3,0x9
ffffffffc0203e5c:	dd068693          	addi	a3,a3,-560 # ffffffffc020cc28 <default_pmm_manager+0x468>
ffffffffc0203e60:	00008617          	auipc	a2,0x8
ffffffffc0203e64:	99860613          	addi	a2,a2,-1640 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203e68:	26900593          	li	a1,617
ffffffffc0203e6c:	00009517          	auipc	a0,0x9
ffffffffc0203e70:	9b450513          	addi	a0,a0,-1612 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203e74:	bbafc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203e78:	00009697          	auipc	a3,0x9
ffffffffc0203e7c:	d9868693          	addi	a3,a3,-616 # ffffffffc020cc10 <default_pmm_manager+0x450>
ffffffffc0203e80:	00008617          	auipc	a2,0x8
ffffffffc0203e84:	97860613          	addi	a2,a2,-1672 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203e88:	26800593          	li	a1,616
ffffffffc0203e8c:	00009517          	auipc	a0,0x9
ffffffffc0203e90:	99450513          	addi	a0,a0,-1644 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203e94:	b9afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203e98:	00009697          	auipc	a3,0x9
ffffffffc0203e9c:	d4868693          	addi	a3,a3,-696 # ffffffffc020cbe0 <default_pmm_manager+0x420>
ffffffffc0203ea0:	00008617          	auipc	a2,0x8
ffffffffc0203ea4:	95860613          	addi	a2,a2,-1704 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203ea8:	26700593          	li	a1,615
ffffffffc0203eac:	00009517          	auipc	a0,0x9
ffffffffc0203eb0:	97450513          	addi	a0,a0,-1676 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203eb4:	b7afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203eb8:	00009697          	auipc	a3,0x9
ffffffffc0203ebc:	d1068693          	addi	a3,a3,-752 # ffffffffc020cbc8 <default_pmm_manager+0x408>
ffffffffc0203ec0:	00008617          	auipc	a2,0x8
ffffffffc0203ec4:	93860613          	addi	a2,a2,-1736 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203ec8:	26500593          	li	a1,613
ffffffffc0203ecc:	00009517          	auipc	a0,0x9
ffffffffc0203ed0:	95450513          	addi	a0,a0,-1708 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203ed4:	b5afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203ed8:	00009697          	auipc	a3,0x9
ffffffffc0203edc:	cd068693          	addi	a3,a3,-816 # ffffffffc020cba8 <default_pmm_manager+0x3e8>
ffffffffc0203ee0:	00008617          	auipc	a2,0x8
ffffffffc0203ee4:	91860613          	addi	a2,a2,-1768 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203ee8:	26400593          	li	a1,612
ffffffffc0203eec:	00009517          	auipc	a0,0x9
ffffffffc0203ef0:	93450513          	addi	a0,a0,-1740 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203ef4:	b3afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203ef8:	00009697          	auipc	a3,0x9
ffffffffc0203efc:	ca068693          	addi	a3,a3,-864 # ffffffffc020cb98 <default_pmm_manager+0x3d8>
ffffffffc0203f00:	00008617          	auipc	a2,0x8
ffffffffc0203f04:	8f860613          	addi	a2,a2,-1800 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203f08:	26300593          	li	a1,611
ffffffffc0203f0c:	00009517          	auipc	a0,0x9
ffffffffc0203f10:	91450513          	addi	a0,a0,-1772 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203f14:	b1afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203f18:	00009697          	auipc	a3,0x9
ffffffffc0203f1c:	c7068693          	addi	a3,a3,-912 # ffffffffc020cb88 <default_pmm_manager+0x3c8>
ffffffffc0203f20:	00008617          	auipc	a2,0x8
ffffffffc0203f24:	8d860613          	addi	a2,a2,-1832 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203f28:	26200593          	li	a1,610
ffffffffc0203f2c:	00009517          	auipc	a0,0x9
ffffffffc0203f30:	8f450513          	addi	a0,a0,-1804 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203f34:	afafc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203f38:	00009697          	auipc	a3,0x9
ffffffffc0203f3c:	c1868693          	addi	a3,a3,-1000 # ffffffffc020cb50 <default_pmm_manager+0x390>
ffffffffc0203f40:	00008617          	auipc	a2,0x8
ffffffffc0203f44:	8b860613          	addi	a2,a2,-1864 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203f48:	26100593          	li	a1,609
ffffffffc0203f4c:	00009517          	auipc	a0,0x9
ffffffffc0203f50:	8d450513          	addi	a0,a0,-1836 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203f54:	adafc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203f58:	00009697          	auipc	a3,0x9
ffffffffc0203f5c:	d4868693          	addi	a3,a3,-696 # ffffffffc020cca0 <default_pmm_manager+0x4e0>
ffffffffc0203f60:	00008617          	auipc	a2,0x8
ffffffffc0203f64:	89860613          	addi	a2,a2,-1896 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203f68:	27e00593          	li	a1,638
ffffffffc0203f6c:	00009517          	auipc	a0,0x9
ffffffffc0203f70:	8b450513          	addi	a0,a0,-1868 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203f74:	abafc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203f78:	00008617          	auipc	a2,0x8
ffffffffc0203f7c:	3b060613          	addi	a2,a2,944 # ffffffffc020c328 <commands+0xb90>
ffffffffc0203f80:	07100593          	li	a1,113
ffffffffc0203f84:	00008517          	auipc	a0,0x8
ffffffffc0203f88:	3cc50513          	addi	a0,a0,972 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0203f8c:	aa2fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203f90:	86a2                	mv	a3,s0
ffffffffc0203f92:	00008617          	auipc	a2,0x8
ffffffffc0203f96:	43e60613          	addi	a2,a2,1086 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0203f9a:	0ca00593          	li	a1,202
ffffffffc0203f9e:	00009517          	auipc	a0,0x9
ffffffffc0203fa2:	88250513          	addi	a0,a0,-1918 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203fa6:	a88fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203faa:	00008617          	auipc	a2,0x8
ffffffffc0203fae:	42660613          	addi	a2,a2,1062 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0203fb2:	08100593          	li	a1,129
ffffffffc0203fb6:	00009517          	auipc	a0,0x9
ffffffffc0203fba:	86a50513          	addi	a0,a0,-1942 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203fbe:	a70fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203fc2:	00009697          	auipc	a3,0x9
ffffffffc0203fc6:	b4e68693          	addi	a3,a3,-1202 # ffffffffc020cb10 <default_pmm_manager+0x350>
ffffffffc0203fca:	00008617          	auipc	a2,0x8
ffffffffc0203fce:	82e60613          	addi	a2,a2,-2002 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203fd2:	26000593          	li	a1,608
ffffffffc0203fd6:	00009517          	auipc	a0,0x9
ffffffffc0203fda:	84a50513          	addi	a0,a0,-1974 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203fde:	a50fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0203fe2:	00009697          	auipc	a3,0x9
ffffffffc0203fe6:	a6e68693          	addi	a3,a3,-1426 # ffffffffc020ca50 <default_pmm_manager+0x290>
ffffffffc0203fea:	00008617          	auipc	a2,0x8
ffffffffc0203fee:	80e60613          	addi	a2,a2,-2034 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0203ff2:	25400593          	li	a1,596
ffffffffc0203ff6:	00009517          	auipc	a0,0x9
ffffffffc0203ffa:	82a50513          	addi	a0,a0,-2006 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0203ffe:	a30fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204002:	985fe0ef          	jal	ra,ffffffffc0202986 <pte2page.part.0>
ffffffffc0204006:	00009697          	auipc	a3,0x9
ffffffffc020400a:	a7a68693          	addi	a3,a3,-1414 # ffffffffc020ca80 <default_pmm_manager+0x2c0>
ffffffffc020400e:	00007617          	auipc	a2,0x7
ffffffffc0204012:	7ea60613          	addi	a2,a2,2026 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204016:	25700593          	li	a1,599
ffffffffc020401a:	00009517          	auipc	a0,0x9
ffffffffc020401e:	80650513          	addi	a0,a0,-2042 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0204022:	a0cfc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204026:	00009697          	auipc	a3,0x9
ffffffffc020402a:	9fa68693          	addi	a3,a3,-1542 # ffffffffc020ca20 <default_pmm_manager+0x260>
ffffffffc020402e:	00007617          	auipc	a2,0x7
ffffffffc0204032:	7ca60613          	addi	a2,a2,1994 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204036:	25000593          	li	a1,592
ffffffffc020403a:	00008517          	auipc	a0,0x8
ffffffffc020403e:	7e650513          	addi	a0,a0,2022 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0204042:	9ecfc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204046:	00009697          	auipc	a3,0x9
ffffffffc020404a:	a6a68693          	addi	a3,a3,-1430 # ffffffffc020cab0 <default_pmm_manager+0x2f0>
ffffffffc020404e:	00007617          	auipc	a2,0x7
ffffffffc0204052:	7aa60613          	addi	a2,a2,1962 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204056:	25800593          	li	a1,600
ffffffffc020405a:	00008517          	auipc	a0,0x8
ffffffffc020405e:	7c650513          	addi	a0,a0,1990 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0204062:	9ccfc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204066:	00008617          	auipc	a2,0x8
ffffffffc020406a:	2c260613          	addi	a2,a2,706 # ffffffffc020c328 <commands+0xb90>
ffffffffc020406e:	25b00593          	li	a1,603
ffffffffc0204072:	00008517          	auipc	a0,0x8
ffffffffc0204076:	7ae50513          	addi	a0,a0,1966 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc020407a:	9b4fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020407e:	00009697          	auipc	a3,0x9
ffffffffc0204082:	a4a68693          	addi	a3,a3,-1462 # ffffffffc020cac8 <default_pmm_manager+0x308>
ffffffffc0204086:	00007617          	auipc	a2,0x7
ffffffffc020408a:	77260613          	addi	a2,a2,1906 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020408e:	25900593          	li	a1,601
ffffffffc0204092:	00008517          	auipc	a0,0x8
ffffffffc0204096:	78e50513          	addi	a0,a0,1934 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc020409a:	994fc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020409e:	86ca                	mv	a3,s2
ffffffffc02040a0:	00008617          	auipc	a2,0x8
ffffffffc02040a4:	33060613          	addi	a2,a2,816 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc02040a8:	0c600593          	li	a1,198
ffffffffc02040ac:	00008517          	auipc	a0,0x8
ffffffffc02040b0:	77450513          	addi	a0,a0,1908 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc02040b4:	97afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02040b8:	00009697          	auipc	a3,0x9
ffffffffc02040bc:	b7068693          	addi	a3,a3,-1168 # ffffffffc020cc28 <default_pmm_manager+0x468>
ffffffffc02040c0:	00007617          	auipc	a2,0x7
ffffffffc02040c4:	73860613          	addi	a2,a2,1848 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02040c8:	27400593          	li	a1,628
ffffffffc02040cc:	00008517          	auipc	a0,0x8
ffffffffc02040d0:	75450513          	addi	a0,a0,1876 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc02040d4:	95afc0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02040d8:	00009697          	auipc	a3,0x9
ffffffffc02040dc:	b8068693          	addi	a3,a3,-1152 # ffffffffc020cc58 <default_pmm_manager+0x498>
ffffffffc02040e0:	00007617          	auipc	a2,0x7
ffffffffc02040e4:	71860613          	addi	a2,a2,1816 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02040e8:	27300593          	li	a1,627
ffffffffc02040ec:	00008517          	auipc	a0,0x8
ffffffffc02040f0:	73450513          	addi	a0,a0,1844 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc02040f4:	93afc0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02040f8 <copy_range>:
ffffffffc02040f8:	7159                	addi	sp,sp,-112
ffffffffc02040fa:	00d667b3          	or	a5,a2,a3
ffffffffc02040fe:	f486                	sd	ra,104(sp)
ffffffffc0204100:	f0a2                	sd	s0,96(sp)
ffffffffc0204102:	eca6                	sd	s1,88(sp)
ffffffffc0204104:	e8ca                	sd	s2,80(sp)
ffffffffc0204106:	e4ce                	sd	s3,72(sp)
ffffffffc0204108:	e0d2                	sd	s4,64(sp)
ffffffffc020410a:	fc56                	sd	s5,56(sp)
ffffffffc020410c:	f85a                	sd	s6,48(sp)
ffffffffc020410e:	f45e                	sd	s7,40(sp)
ffffffffc0204110:	f062                	sd	s8,32(sp)
ffffffffc0204112:	ec66                	sd	s9,24(sp)
ffffffffc0204114:	e86a                	sd	s10,16(sp)
ffffffffc0204116:	e46e                	sd	s11,8(sp)
ffffffffc0204118:	17d2                	slli	a5,a5,0x34
ffffffffc020411a:	20079f63          	bnez	a5,ffffffffc0204338 <copy_range+0x240>
ffffffffc020411e:	002007b7          	lui	a5,0x200
ffffffffc0204122:	8432                	mv	s0,a2
ffffffffc0204124:	1af66263          	bltu	a2,a5,ffffffffc02042c8 <copy_range+0x1d0>
ffffffffc0204128:	8936                	mv	s2,a3
ffffffffc020412a:	18d67f63          	bgeu	a2,a3,ffffffffc02042c8 <copy_range+0x1d0>
ffffffffc020412e:	4785                	li	a5,1
ffffffffc0204130:	07fe                	slli	a5,a5,0x1f
ffffffffc0204132:	18d7eb63          	bltu	a5,a3,ffffffffc02042c8 <copy_range+0x1d0>
ffffffffc0204136:	5b7d                	li	s6,-1
ffffffffc0204138:	8aaa                	mv	s5,a0
ffffffffc020413a:	89ae                	mv	s3,a1
ffffffffc020413c:	6a05                	lui	s4,0x1
ffffffffc020413e:	00092c17          	auipc	s8,0x92
ffffffffc0204142:	762c0c13          	addi	s8,s8,1890 # ffffffffc02968a0 <npage>
ffffffffc0204146:	00092b97          	auipc	s7,0x92
ffffffffc020414a:	762b8b93          	addi	s7,s7,1890 # ffffffffc02968a8 <pages>
ffffffffc020414e:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0204152:	00092c97          	auipc	s9,0x92
ffffffffc0204156:	75ec8c93          	addi	s9,s9,1886 # ffffffffc02968b0 <pmm_manager>
ffffffffc020415a:	4601                	li	a2,0
ffffffffc020415c:	85a2                	mv	a1,s0
ffffffffc020415e:	854e                	mv	a0,s3
ffffffffc0204160:	8fbfe0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc0204164:	84aa                	mv	s1,a0
ffffffffc0204166:	0e050c63          	beqz	a0,ffffffffc020425e <copy_range+0x166>
ffffffffc020416a:	611c                	ld	a5,0(a0)
ffffffffc020416c:	8b85                	andi	a5,a5,1
ffffffffc020416e:	e785                	bnez	a5,ffffffffc0204196 <copy_range+0x9e>
ffffffffc0204170:	9452                	add	s0,s0,s4
ffffffffc0204172:	ff2464e3          	bltu	s0,s2,ffffffffc020415a <copy_range+0x62>
ffffffffc0204176:	4501                	li	a0,0
ffffffffc0204178:	70a6                	ld	ra,104(sp)
ffffffffc020417a:	7406                	ld	s0,96(sp)
ffffffffc020417c:	64e6                	ld	s1,88(sp)
ffffffffc020417e:	6946                	ld	s2,80(sp)
ffffffffc0204180:	69a6                	ld	s3,72(sp)
ffffffffc0204182:	6a06                	ld	s4,64(sp)
ffffffffc0204184:	7ae2                	ld	s5,56(sp)
ffffffffc0204186:	7b42                	ld	s6,48(sp)
ffffffffc0204188:	7ba2                	ld	s7,40(sp)
ffffffffc020418a:	7c02                	ld	s8,32(sp)
ffffffffc020418c:	6ce2                	ld	s9,24(sp)
ffffffffc020418e:	6d42                	ld	s10,16(sp)
ffffffffc0204190:	6da2                	ld	s11,8(sp)
ffffffffc0204192:	6165                	addi	sp,sp,112
ffffffffc0204194:	8082                	ret
ffffffffc0204196:	4605                	li	a2,1
ffffffffc0204198:	85a2                	mv	a1,s0
ffffffffc020419a:	8556                	mv	a0,s5
ffffffffc020419c:	8bffe0ef          	jal	ra,ffffffffc0202a5a <get_pte>
ffffffffc02041a0:	c56d                	beqz	a0,ffffffffc020428a <copy_range+0x192>
ffffffffc02041a2:	609c                	ld	a5,0(s1)
ffffffffc02041a4:	0017f713          	andi	a4,a5,1
ffffffffc02041a8:	01f7f493          	andi	s1,a5,31
ffffffffc02041ac:	16070a63          	beqz	a4,ffffffffc0204320 <copy_range+0x228>
ffffffffc02041b0:	000c3683          	ld	a3,0(s8)
ffffffffc02041b4:	078a                	slli	a5,a5,0x2
ffffffffc02041b6:	00c7d713          	srli	a4,a5,0xc
ffffffffc02041ba:	14d77763          	bgeu	a4,a3,ffffffffc0204308 <copy_range+0x210>
ffffffffc02041be:	000bb783          	ld	a5,0(s7)
ffffffffc02041c2:	fff806b7          	lui	a3,0xfff80
ffffffffc02041c6:	9736                	add	a4,a4,a3
ffffffffc02041c8:	071a                	slli	a4,a4,0x6
ffffffffc02041ca:	00e78db3          	add	s11,a5,a4
ffffffffc02041ce:	10002773          	csrr	a4,sstatus
ffffffffc02041d2:	8b09                	andi	a4,a4,2
ffffffffc02041d4:	e345                	bnez	a4,ffffffffc0204274 <copy_range+0x17c>
ffffffffc02041d6:	000cb703          	ld	a4,0(s9)
ffffffffc02041da:	4505                	li	a0,1
ffffffffc02041dc:	6f18                	ld	a4,24(a4)
ffffffffc02041de:	9702                	jalr	a4
ffffffffc02041e0:	8d2a                	mv	s10,a0
ffffffffc02041e2:	0c0d8363          	beqz	s11,ffffffffc02042a8 <copy_range+0x1b0>
ffffffffc02041e6:	100d0163          	beqz	s10,ffffffffc02042e8 <copy_range+0x1f0>
ffffffffc02041ea:	000bb703          	ld	a4,0(s7)
ffffffffc02041ee:	000805b7          	lui	a1,0x80
ffffffffc02041f2:	000c3603          	ld	a2,0(s8)
ffffffffc02041f6:	40ed86b3          	sub	a3,s11,a4
ffffffffc02041fa:	8699                	srai	a3,a3,0x6
ffffffffc02041fc:	96ae                	add	a3,a3,a1
ffffffffc02041fe:	0166f7b3          	and	a5,a3,s6
ffffffffc0204202:	06b2                	slli	a3,a3,0xc
ffffffffc0204204:	08c7f663          	bgeu	a5,a2,ffffffffc0204290 <copy_range+0x198>
ffffffffc0204208:	40ed07b3          	sub	a5,s10,a4
ffffffffc020420c:	00092717          	auipc	a4,0x92
ffffffffc0204210:	6ac70713          	addi	a4,a4,1708 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0204214:	6308                	ld	a0,0(a4)
ffffffffc0204216:	8799                	srai	a5,a5,0x6
ffffffffc0204218:	97ae                	add	a5,a5,a1
ffffffffc020421a:	0167f733          	and	a4,a5,s6
ffffffffc020421e:	00a685b3          	add	a1,a3,a0
ffffffffc0204222:	07b2                	slli	a5,a5,0xc
ffffffffc0204224:	06c77563          	bgeu	a4,a2,ffffffffc020428e <copy_range+0x196>
ffffffffc0204228:	6605                	lui	a2,0x1
ffffffffc020422a:	953e                	add	a0,a0,a5
ffffffffc020422c:	61b060ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0204230:	86a6                	mv	a3,s1
ffffffffc0204232:	8622                	mv	a2,s0
ffffffffc0204234:	85ea                	mv	a1,s10
ffffffffc0204236:	8556                	mv	a0,s5
ffffffffc0204238:	fd9fe0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc020423c:	d915                	beqz	a0,ffffffffc0204170 <copy_range+0x78>
ffffffffc020423e:	00009697          	auipc	a3,0x9
ffffffffc0204242:	c8a68693          	addi	a3,a3,-886 # ffffffffc020cec8 <default_pmm_manager+0x708>
ffffffffc0204246:	00007617          	auipc	a2,0x7
ffffffffc020424a:	5b260613          	addi	a2,a2,1458 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020424e:	1ec00593          	li	a1,492
ffffffffc0204252:	00008517          	auipc	a0,0x8
ffffffffc0204256:	5ce50513          	addi	a0,a0,1486 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc020425a:	fd5fb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020425e:	00200637          	lui	a2,0x200
ffffffffc0204262:	9432                	add	s0,s0,a2
ffffffffc0204264:	ffe00637          	lui	a2,0xffe00
ffffffffc0204268:	8c71                	and	s0,s0,a2
ffffffffc020426a:	f00406e3          	beqz	s0,ffffffffc0204176 <copy_range+0x7e>
ffffffffc020426e:	ef2466e3          	bltu	s0,s2,ffffffffc020415a <copy_range+0x62>
ffffffffc0204272:	b711                	j	ffffffffc0204176 <copy_range+0x7e>
ffffffffc0204274:	b31fc0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0204278:	000cb703          	ld	a4,0(s9)
ffffffffc020427c:	4505                	li	a0,1
ffffffffc020427e:	6f18                	ld	a4,24(a4)
ffffffffc0204280:	9702                	jalr	a4
ffffffffc0204282:	8d2a                	mv	s10,a0
ffffffffc0204284:	b1bfc0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0204288:	bfa9                	j	ffffffffc02041e2 <copy_range+0xea>
ffffffffc020428a:	5571                	li	a0,-4
ffffffffc020428c:	b5f5                	j	ffffffffc0204178 <copy_range+0x80>
ffffffffc020428e:	86be                	mv	a3,a5
ffffffffc0204290:	00008617          	auipc	a2,0x8
ffffffffc0204294:	09860613          	addi	a2,a2,152 # ffffffffc020c328 <commands+0xb90>
ffffffffc0204298:	07100593          	li	a1,113
ffffffffc020429c:	00008517          	auipc	a0,0x8
ffffffffc02042a0:	0b450513          	addi	a0,a0,180 # ffffffffc020c350 <commands+0xbb8>
ffffffffc02042a4:	f8bfb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02042a8:	00009697          	auipc	a3,0x9
ffffffffc02042ac:	c0068693          	addi	a3,a3,-1024 # ffffffffc020cea8 <default_pmm_manager+0x6e8>
ffffffffc02042b0:	00007617          	auipc	a2,0x7
ffffffffc02042b4:	54860613          	addi	a2,a2,1352 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02042b8:	1ce00593          	li	a1,462
ffffffffc02042bc:	00008517          	auipc	a0,0x8
ffffffffc02042c0:	56450513          	addi	a0,a0,1380 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc02042c4:	f6bfb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02042c8:	00008697          	auipc	a3,0x8
ffffffffc02042cc:	5c068693          	addi	a3,a3,1472 # ffffffffc020c888 <default_pmm_manager+0xc8>
ffffffffc02042d0:	00007617          	auipc	a2,0x7
ffffffffc02042d4:	52860613          	addi	a2,a2,1320 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02042d8:	1b600593          	li	a1,438
ffffffffc02042dc:	00008517          	auipc	a0,0x8
ffffffffc02042e0:	54450513          	addi	a0,a0,1348 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc02042e4:	f4bfb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02042e8:	00009697          	auipc	a3,0x9
ffffffffc02042ec:	bd068693          	addi	a3,a3,-1072 # ffffffffc020ceb8 <default_pmm_manager+0x6f8>
ffffffffc02042f0:	00007617          	auipc	a2,0x7
ffffffffc02042f4:	50860613          	addi	a2,a2,1288 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02042f8:	1cf00593          	li	a1,463
ffffffffc02042fc:	00008517          	auipc	a0,0x8
ffffffffc0204300:	52450513          	addi	a0,a0,1316 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0204304:	f2bfb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204308:	00008617          	auipc	a2,0x8
ffffffffc020430c:	0f060613          	addi	a2,a2,240 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc0204310:	06900593          	li	a1,105
ffffffffc0204314:	00008517          	auipc	a0,0x8
ffffffffc0204318:	03c50513          	addi	a0,a0,60 # ffffffffc020c350 <commands+0xbb8>
ffffffffc020431c:	f13fb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204320:	00008617          	auipc	a2,0x8
ffffffffc0204324:	4d860613          	addi	a2,a2,1240 # ffffffffc020c7f8 <default_pmm_manager+0x38>
ffffffffc0204328:	07f00593          	li	a1,127
ffffffffc020432c:	00008517          	auipc	a0,0x8
ffffffffc0204330:	02450513          	addi	a0,a0,36 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0204334:	efbfb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204338:	00008697          	auipc	a3,0x8
ffffffffc020433c:	52068693          	addi	a3,a3,1312 # ffffffffc020c858 <default_pmm_manager+0x98>
ffffffffc0204340:	00007617          	auipc	a2,0x7
ffffffffc0204344:	4b860613          	addi	a2,a2,1208 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204348:	1b500593          	li	a1,437
ffffffffc020434c:	00008517          	auipc	a0,0x8
ffffffffc0204350:	4d450513          	addi	a0,a0,1236 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0204354:	edbfb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204358 <pgdir_alloc_page>:
ffffffffc0204358:	7179                	addi	sp,sp,-48
ffffffffc020435a:	ec26                	sd	s1,24(sp)
ffffffffc020435c:	e84a                	sd	s2,16(sp)
ffffffffc020435e:	e052                	sd	s4,0(sp)
ffffffffc0204360:	f406                	sd	ra,40(sp)
ffffffffc0204362:	f022                	sd	s0,32(sp)
ffffffffc0204364:	e44e                	sd	s3,8(sp)
ffffffffc0204366:	8a2a                	mv	s4,a0
ffffffffc0204368:	84ae                	mv	s1,a1
ffffffffc020436a:	8932                	mv	s2,a2
ffffffffc020436c:	100027f3          	csrr	a5,sstatus
ffffffffc0204370:	8b89                	andi	a5,a5,2
ffffffffc0204372:	00092997          	auipc	s3,0x92
ffffffffc0204376:	53e98993          	addi	s3,s3,1342 # ffffffffc02968b0 <pmm_manager>
ffffffffc020437a:	ef8d                	bnez	a5,ffffffffc02043b4 <pgdir_alloc_page+0x5c>
ffffffffc020437c:	0009b783          	ld	a5,0(s3)
ffffffffc0204380:	4505                	li	a0,1
ffffffffc0204382:	6f9c                	ld	a5,24(a5)
ffffffffc0204384:	9782                	jalr	a5
ffffffffc0204386:	842a                	mv	s0,a0
ffffffffc0204388:	cc09                	beqz	s0,ffffffffc02043a2 <pgdir_alloc_page+0x4a>
ffffffffc020438a:	86ca                	mv	a3,s2
ffffffffc020438c:	8626                	mv	a2,s1
ffffffffc020438e:	85a2                	mv	a1,s0
ffffffffc0204390:	8552                	mv	a0,s4
ffffffffc0204392:	e7ffe0ef          	jal	ra,ffffffffc0203210 <page_insert>
ffffffffc0204396:	e915                	bnez	a0,ffffffffc02043ca <pgdir_alloc_page+0x72>
ffffffffc0204398:	4018                	lw	a4,0(s0)
ffffffffc020439a:	fc04                	sd	s1,56(s0)
ffffffffc020439c:	4785                	li	a5,1
ffffffffc020439e:	04f71e63          	bne	a4,a5,ffffffffc02043fa <pgdir_alloc_page+0xa2>
ffffffffc02043a2:	70a2                	ld	ra,40(sp)
ffffffffc02043a4:	8522                	mv	a0,s0
ffffffffc02043a6:	7402                	ld	s0,32(sp)
ffffffffc02043a8:	64e2                	ld	s1,24(sp)
ffffffffc02043aa:	6942                	ld	s2,16(sp)
ffffffffc02043ac:	69a2                	ld	s3,8(sp)
ffffffffc02043ae:	6a02                	ld	s4,0(sp)
ffffffffc02043b0:	6145                	addi	sp,sp,48
ffffffffc02043b2:	8082                	ret
ffffffffc02043b4:	9f1fc0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02043b8:	0009b783          	ld	a5,0(s3)
ffffffffc02043bc:	4505                	li	a0,1
ffffffffc02043be:	6f9c                	ld	a5,24(a5)
ffffffffc02043c0:	9782                	jalr	a5
ffffffffc02043c2:	842a                	mv	s0,a0
ffffffffc02043c4:	9dbfc0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02043c8:	b7c1                	j	ffffffffc0204388 <pgdir_alloc_page+0x30>
ffffffffc02043ca:	100027f3          	csrr	a5,sstatus
ffffffffc02043ce:	8b89                	andi	a5,a5,2
ffffffffc02043d0:	eb89                	bnez	a5,ffffffffc02043e2 <pgdir_alloc_page+0x8a>
ffffffffc02043d2:	0009b783          	ld	a5,0(s3)
ffffffffc02043d6:	8522                	mv	a0,s0
ffffffffc02043d8:	4585                	li	a1,1
ffffffffc02043da:	739c                	ld	a5,32(a5)
ffffffffc02043dc:	4401                	li	s0,0
ffffffffc02043de:	9782                	jalr	a5
ffffffffc02043e0:	b7c9                	j	ffffffffc02043a2 <pgdir_alloc_page+0x4a>
ffffffffc02043e2:	9c3fc0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02043e6:	0009b783          	ld	a5,0(s3)
ffffffffc02043ea:	8522                	mv	a0,s0
ffffffffc02043ec:	4585                	li	a1,1
ffffffffc02043ee:	739c                	ld	a5,32(a5)
ffffffffc02043f0:	4401                	li	s0,0
ffffffffc02043f2:	9782                	jalr	a5
ffffffffc02043f4:	9abfc0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02043f8:	b76d                	j	ffffffffc02043a2 <pgdir_alloc_page+0x4a>
ffffffffc02043fa:	00009697          	auipc	a3,0x9
ffffffffc02043fe:	ade68693          	addi	a3,a3,-1314 # ffffffffc020ced8 <default_pmm_manager+0x718>
ffffffffc0204402:	00007617          	auipc	a2,0x7
ffffffffc0204406:	3f660613          	addi	a2,a2,1014 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020440a:	23500593          	li	a1,565
ffffffffc020440e:	00008517          	auipc	a0,0x8
ffffffffc0204412:	41250513          	addi	a0,a0,1042 # ffffffffc020c820 <default_pmm_manager+0x60>
ffffffffc0204416:	e19fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020441a <wait_queue_init>:
ffffffffc020441a:	e508                	sd	a0,8(a0)
ffffffffc020441c:	e108                	sd	a0,0(a0)
ffffffffc020441e:	8082                	ret

ffffffffc0204420 <wait_queue_del>:
ffffffffc0204420:	7198                	ld	a4,32(a1)
ffffffffc0204422:	01858793          	addi	a5,a1,24 # 80018 <_binary_bin_sfs_img_size+0xad18>
ffffffffc0204426:	00e78b63          	beq	a5,a4,ffffffffc020443c <wait_queue_del+0x1c>
ffffffffc020442a:	6994                	ld	a3,16(a1)
ffffffffc020442c:	00a69863          	bne	a3,a0,ffffffffc020443c <wait_queue_del+0x1c>
ffffffffc0204430:	6d94                	ld	a3,24(a1)
ffffffffc0204432:	e698                	sd	a4,8(a3)
ffffffffc0204434:	e314                	sd	a3,0(a4)
ffffffffc0204436:	f19c                	sd	a5,32(a1)
ffffffffc0204438:	ed9c                	sd	a5,24(a1)
ffffffffc020443a:	8082                	ret
ffffffffc020443c:	1141                	addi	sp,sp,-16
ffffffffc020443e:	00009697          	auipc	a3,0x9
ffffffffc0204442:	b0268693          	addi	a3,a3,-1278 # ffffffffc020cf40 <default_pmm_manager+0x780>
ffffffffc0204446:	00007617          	auipc	a2,0x7
ffffffffc020444a:	3b260613          	addi	a2,a2,946 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020444e:	45f1                	li	a1,28
ffffffffc0204450:	00009517          	auipc	a0,0x9
ffffffffc0204454:	ad850513          	addi	a0,a0,-1320 # ffffffffc020cf28 <default_pmm_manager+0x768>
ffffffffc0204458:	e406                	sd	ra,8(sp)
ffffffffc020445a:	dd5fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020445e <wait_queue_first>:
ffffffffc020445e:	651c                	ld	a5,8(a0)
ffffffffc0204460:	00f50563          	beq	a0,a5,ffffffffc020446a <wait_queue_first+0xc>
ffffffffc0204464:	fe878513          	addi	a0,a5,-24 # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0204468:	8082                	ret
ffffffffc020446a:	4501                	li	a0,0
ffffffffc020446c:	8082                	ret

ffffffffc020446e <wait_queue_empty>:
ffffffffc020446e:	651c                	ld	a5,8(a0)
ffffffffc0204470:	40a78533          	sub	a0,a5,a0
ffffffffc0204474:	00153513          	seqz	a0,a0
ffffffffc0204478:	8082                	ret

ffffffffc020447a <wait_in_queue>:
ffffffffc020447a:	711c                	ld	a5,32(a0)
ffffffffc020447c:	0561                	addi	a0,a0,24
ffffffffc020447e:	40a78533          	sub	a0,a5,a0
ffffffffc0204482:	00a03533          	snez	a0,a0
ffffffffc0204486:	8082                	ret

ffffffffc0204488 <wakeup_wait>:
ffffffffc0204488:	e689                	bnez	a3,ffffffffc0204492 <wakeup_wait+0xa>
ffffffffc020448a:	6188                	ld	a0,0(a1)
ffffffffc020448c:	c590                	sw	a2,8(a1)
ffffffffc020448e:	52f0206f          	j	ffffffffc02071bc <wakeup_proc>
ffffffffc0204492:	7198                	ld	a4,32(a1)
ffffffffc0204494:	01858793          	addi	a5,a1,24
ffffffffc0204498:	00e78e63          	beq	a5,a4,ffffffffc02044b4 <wakeup_wait+0x2c>
ffffffffc020449c:	6994                	ld	a3,16(a1)
ffffffffc020449e:	00d51b63          	bne	a0,a3,ffffffffc02044b4 <wakeup_wait+0x2c>
ffffffffc02044a2:	6d94                	ld	a3,24(a1)
ffffffffc02044a4:	6188                	ld	a0,0(a1)
ffffffffc02044a6:	e698                	sd	a4,8(a3)
ffffffffc02044a8:	e314                	sd	a3,0(a4)
ffffffffc02044aa:	f19c                	sd	a5,32(a1)
ffffffffc02044ac:	ed9c                	sd	a5,24(a1)
ffffffffc02044ae:	c590                	sw	a2,8(a1)
ffffffffc02044b0:	50d0206f          	j	ffffffffc02071bc <wakeup_proc>
ffffffffc02044b4:	1141                	addi	sp,sp,-16
ffffffffc02044b6:	00009697          	auipc	a3,0x9
ffffffffc02044ba:	a8a68693          	addi	a3,a3,-1398 # ffffffffc020cf40 <default_pmm_manager+0x780>
ffffffffc02044be:	00007617          	auipc	a2,0x7
ffffffffc02044c2:	33a60613          	addi	a2,a2,826 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02044c6:	45f1                	li	a1,28
ffffffffc02044c8:	00009517          	auipc	a0,0x9
ffffffffc02044cc:	a6050513          	addi	a0,a0,-1440 # ffffffffc020cf28 <default_pmm_manager+0x768>
ffffffffc02044d0:	e406                	sd	ra,8(sp)
ffffffffc02044d2:	d5dfb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02044d6 <wakeup_queue>:
ffffffffc02044d6:	651c                	ld	a5,8(a0)
ffffffffc02044d8:	0ca78563          	beq	a5,a0,ffffffffc02045a2 <wakeup_queue+0xcc>
ffffffffc02044dc:	1101                	addi	sp,sp,-32
ffffffffc02044de:	e822                	sd	s0,16(sp)
ffffffffc02044e0:	e426                	sd	s1,8(sp)
ffffffffc02044e2:	e04a                	sd	s2,0(sp)
ffffffffc02044e4:	ec06                	sd	ra,24(sp)
ffffffffc02044e6:	84aa                	mv	s1,a0
ffffffffc02044e8:	892e                	mv	s2,a1
ffffffffc02044ea:	fe878413          	addi	s0,a5,-24
ffffffffc02044ee:	e23d                	bnez	a2,ffffffffc0204554 <wakeup_queue+0x7e>
ffffffffc02044f0:	6008                	ld	a0,0(s0)
ffffffffc02044f2:	01242423          	sw	s2,8(s0)
ffffffffc02044f6:	4c7020ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc02044fa:	701c                	ld	a5,32(s0)
ffffffffc02044fc:	01840713          	addi	a4,s0,24
ffffffffc0204500:	02e78463          	beq	a5,a4,ffffffffc0204528 <wakeup_queue+0x52>
ffffffffc0204504:	6818                	ld	a4,16(s0)
ffffffffc0204506:	02e49163          	bne	s1,a4,ffffffffc0204528 <wakeup_queue+0x52>
ffffffffc020450a:	02f48f63          	beq	s1,a5,ffffffffc0204548 <wakeup_queue+0x72>
ffffffffc020450e:	fe87b503          	ld	a0,-24(a5)
ffffffffc0204512:	ff27a823          	sw	s2,-16(a5)
ffffffffc0204516:	fe878413          	addi	s0,a5,-24
ffffffffc020451a:	4a3020ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc020451e:	701c                	ld	a5,32(s0)
ffffffffc0204520:	01840713          	addi	a4,s0,24
ffffffffc0204524:	fee790e3          	bne	a5,a4,ffffffffc0204504 <wakeup_queue+0x2e>
ffffffffc0204528:	00009697          	auipc	a3,0x9
ffffffffc020452c:	a1868693          	addi	a3,a3,-1512 # ffffffffc020cf40 <default_pmm_manager+0x780>
ffffffffc0204530:	00007617          	auipc	a2,0x7
ffffffffc0204534:	2c860613          	addi	a2,a2,712 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204538:	02200593          	li	a1,34
ffffffffc020453c:	00009517          	auipc	a0,0x9
ffffffffc0204540:	9ec50513          	addi	a0,a0,-1556 # ffffffffc020cf28 <default_pmm_manager+0x768>
ffffffffc0204544:	cebfb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204548:	60e2                	ld	ra,24(sp)
ffffffffc020454a:	6442                	ld	s0,16(sp)
ffffffffc020454c:	64a2                	ld	s1,8(sp)
ffffffffc020454e:	6902                	ld	s2,0(sp)
ffffffffc0204550:	6105                	addi	sp,sp,32
ffffffffc0204552:	8082                	ret
ffffffffc0204554:	6798                	ld	a4,8(a5)
ffffffffc0204556:	02f70763          	beq	a4,a5,ffffffffc0204584 <wakeup_queue+0xae>
ffffffffc020455a:	6814                	ld	a3,16(s0)
ffffffffc020455c:	02d49463          	bne	s1,a3,ffffffffc0204584 <wakeup_queue+0xae>
ffffffffc0204560:	6c14                	ld	a3,24(s0)
ffffffffc0204562:	6008                	ld	a0,0(s0)
ffffffffc0204564:	e698                	sd	a4,8(a3)
ffffffffc0204566:	e314                	sd	a3,0(a4)
ffffffffc0204568:	f01c                	sd	a5,32(s0)
ffffffffc020456a:	ec1c                	sd	a5,24(s0)
ffffffffc020456c:	01242423          	sw	s2,8(s0)
ffffffffc0204570:	44d020ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc0204574:	6480                	ld	s0,8(s1)
ffffffffc0204576:	fc8489e3          	beq	s1,s0,ffffffffc0204548 <wakeup_queue+0x72>
ffffffffc020457a:	6418                	ld	a4,8(s0)
ffffffffc020457c:	87a2                	mv	a5,s0
ffffffffc020457e:	1421                	addi	s0,s0,-24
ffffffffc0204580:	fce79de3          	bne	a5,a4,ffffffffc020455a <wakeup_queue+0x84>
ffffffffc0204584:	00009697          	auipc	a3,0x9
ffffffffc0204588:	9bc68693          	addi	a3,a3,-1604 # ffffffffc020cf40 <default_pmm_manager+0x780>
ffffffffc020458c:	00007617          	auipc	a2,0x7
ffffffffc0204590:	26c60613          	addi	a2,a2,620 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204594:	45f1                	li	a1,28
ffffffffc0204596:	00009517          	auipc	a0,0x9
ffffffffc020459a:	99250513          	addi	a0,a0,-1646 # ffffffffc020cf28 <default_pmm_manager+0x768>
ffffffffc020459e:	c91fb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02045a2:	8082                	ret

ffffffffc02045a4 <wait_current_set>:
ffffffffc02045a4:	00092797          	auipc	a5,0x92
ffffffffc02045a8:	31c7b783          	ld	a5,796(a5) # ffffffffc02968c0 <current>
ffffffffc02045ac:	c39d                	beqz	a5,ffffffffc02045d2 <wait_current_set+0x2e>
ffffffffc02045ae:	01858713          	addi	a4,a1,24
ffffffffc02045b2:	800006b7          	lui	a3,0x80000
ffffffffc02045b6:	ed98                	sd	a4,24(a1)
ffffffffc02045b8:	e19c                	sd	a5,0(a1)
ffffffffc02045ba:	c594                	sw	a3,8(a1)
ffffffffc02045bc:	4685                	li	a3,1
ffffffffc02045be:	c394                	sw	a3,0(a5)
ffffffffc02045c0:	0ec7a623          	sw	a2,236(a5)
ffffffffc02045c4:	611c                	ld	a5,0(a0)
ffffffffc02045c6:	e988                	sd	a0,16(a1)
ffffffffc02045c8:	e118                	sd	a4,0(a0)
ffffffffc02045ca:	e798                	sd	a4,8(a5)
ffffffffc02045cc:	f188                	sd	a0,32(a1)
ffffffffc02045ce:	ed9c                	sd	a5,24(a1)
ffffffffc02045d0:	8082                	ret
ffffffffc02045d2:	1141                	addi	sp,sp,-16
ffffffffc02045d4:	00009697          	auipc	a3,0x9
ffffffffc02045d8:	9ac68693          	addi	a3,a3,-1620 # ffffffffc020cf80 <default_pmm_manager+0x7c0>
ffffffffc02045dc:	00007617          	auipc	a2,0x7
ffffffffc02045e0:	21c60613          	addi	a2,a2,540 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02045e4:	07400593          	li	a1,116
ffffffffc02045e8:	00009517          	auipc	a0,0x9
ffffffffc02045ec:	94050513          	addi	a0,a0,-1728 # ffffffffc020cf28 <default_pmm_manager+0x768>
ffffffffc02045f0:	e406                	sd	ra,8(sp)
ffffffffc02045f2:	c3dfb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02045f6 <__down.constprop.0>:
ffffffffc02045f6:	715d                	addi	sp,sp,-80
ffffffffc02045f8:	e0a2                	sd	s0,64(sp)
ffffffffc02045fa:	e486                	sd	ra,72(sp)
ffffffffc02045fc:	fc26                	sd	s1,56(sp)
ffffffffc02045fe:	842a                	mv	s0,a0
ffffffffc0204600:	100027f3          	csrr	a5,sstatus
ffffffffc0204604:	8b89                	andi	a5,a5,2
ffffffffc0204606:	ebb1                	bnez	a5,ffffffffc020465a <__down.constprop.0+0x64>
ffffffffc0204608:	411c                	lw	a5,0(a0)
ffffffffc020460a:	00f05a63          	blez	a5,ffffffffc020461e <__down.constprop.0+0x28>
ffffffffc020460e:	37fd                	addiw	a5,a5,-1
ffffffffc0204610:	c11c                	sw	a5,0(a0)
ffffffffc0204612:	4501                	li	a0,0
ffffffffc0204614:	60a6                	ld	ra,72(sp)
ffffffffc0204616:	6406                	ld	s0,64(sp)
ffffffffc0204618:	74e2                	ld	s1,56(sp)
ffffffffc020461a:	6161                	addi	sp,sp,80
ffffffffc020461c:	8082                	ret
ffffffffc020461e:	00850413          	addi	s0,a0,8
ffffffffc0204622:	0024                	addi	s1,sp,8
ffffffffc0204624:	10000613          	li	a2,256
ffffffffc0204628:	85a6                	mv	a1,s1
ffffffffc020462a:	8522                	mv	a0,s0
ffffffffc020462c:	f79ff0ef          	jal	ra,ffffffffc02045a4 <wait_current_set>
ffffffffc0204630:	43f020ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc0204634:	100027f3          	csrr	a5,sstatus
ffffffffc0204638:	8b89                	andi	a5,a5,2
ffffffffc020463a:	efb9                	bnez	a5,ffffffffc0204698 <__down.constprop.0+0xa2>
ffffffffc020463c:	8526                	mv	a0,s1
ffffffffc020463e:	e3dff0ef          	jal	ra,ffffffffc020447a <wait_in_queue>
ffffffffc0204642:	e531                	bnez	a0,ffffffffc020468e <__down.constprop.0+0x98>
ffffffffc0204644:	4542                	lw	a0,16(sp)
ffffffffc0204646:	10000793          	li	a5,256
ffffffffc020464a:	fcf515e3          	bne	a0,a5,ffffffffc0204614 <__down.constprop.0+0x1e>
ffffffffc020464e:	60a6                	ld	ra,72(sp)
ffffffffc0204650:	6406                	ld	s0,64(sp)
ffffffffc0204652:	74e2                	ld	s1,56(sp)
ffffffffc0204654:	4501                	li	a0,0
ffffffffc0204656:	6161                	addi	sp,sp,80
ffffffffc0204658:	8082                	ret
ffffffffc020465a:	f4afc0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020465e:	401c                	lw	a5,0(s0)
ffffffffc0204660:	00f05c63          	blez	a5,ffffffffc0204678 <__down.constprop.0+0x82>
ffffffffc0204664:	37fd                	addiw	a5,a5,-1
ffffffffc0204666:	c01c                	sw	a5,0(s0)
ffffffffc0204668:	f36fc0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc020466c:	60a6                	ld	ra,72(sp)
ffffffffc020466e:	6406                	ld	s0,64(sp)
ffffffffc0204670:	74e2                	ld	s1,56(sp)
ffffffffc0204672:	4501                	li	a0,0
ffffffffc0204674:	6161                	addi	sp,sp,80
ffffffffc0204676:	8082                	ret
ffffffffc0204678:	0421                	addi	s0,s0,8
ffffffffc020467a:	0024                	addi	s1,sp,8
ffffffffc020467c:	10000613          	li	a2,256
ffffffffc0204680:	85a6                	mv	a1,s1
ffffffffc0204682:	8522                	mv	a0,s0
ffffffffc0204684:	f21ff0ef          	jal	ra,ffffffffc02045a4 <wait_current_set>
ffffffffc0204688:	f16fc0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc020468c:	b755                	j	ffffffffc0204630 <__down.constprop.0+0x3a>
ffffffffc020468e:	85a6                	mv	a1,s1
ffffffffc0204690:	8522                	mv	a0,s0
ffffffffc0204692:	d8fff0ef          	jal	ra,ffffffffc0204420 <wait_queue_del>
ffffffffc0204696:	b77d                	j	ffffffffc0204644 <__down.constprop.0+0x4e>
ffffffffc0204698:	f0cfc0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020469c:	8526                	mv	a0,s1
ffffffffc020469e:	dddff0ef          	jal	ra,ffffffffc020447a <wait_in_queue>
ffffffffc02046a2:	e501                	bnez	a0,ffffffffc02046aa <__down.constprop.0+0xb4>
ffffffffc02046a4:	efafc0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02046a8:	bf71                	j	ffffffffc0204644 <__down.constprop.0+0x4e>
ffffffffc02046aa:	85a6                	mv	a1,s1
ffffffffc02046ac:	8522                	mv	a0,s0
ffffffffc02046ae:	d73ff0ef          	jal	ra,ffffffffc0204420 <wait_queue_del>
ffffffffc02046b2:	bfcd                	j	ffffffffc02046a4 <__down.constprop.0+0xae>

ffffffffc02046b4 <__up.constprop.0>:
ffffffffc02046b4:	1101                	addi	sp,sp,-32
ffffffffc02046b6:	e822                	sd	s0,16(sp)
ffffffffc02046b8:	ec06                	sd	ra,24(sp)
ffffffffc02046ba:	e426                	sd	s1,8(sp)
ffffffffc02046bc:	e04a                	sd	s2,0(sp)
ffffffffc02046be:	842a                	mv	s0,a0
ffffffffc02046c0:	100027f3          	csrr	a5,sstatus
ffffffffc02046c4:	8b89                	andi	a5,a5,2
ffffffffc02046c6:	4901                	li	s2,0
ffffffffc02046c8:	eba1                	bnez	a5,ffffffffc0204718 <__up.constprop.0+0x64>
ffffffffc02046ca:	00840493          	addi	s1,s0,8
ffffffffc02046ce:	8526                	mv	a0,s1
ffffffffc02046d0:	d8fff0ef          	jal	ra,ffffffffc020445e <wait_queue_first>
ffffffffc02046d4:	85aa                	mv	a1,a0
ffffffffc02046d6:	cd0d                	beqz	a0,ffffffffc0204710 <__up.constprop.0+0x5c>
ffffffffc02046d8:	6118                	ld	a4,0(a0)
ffffffffc02046da:	10000793          	li	a5,256
ffffffffc02046de:	0ec72703          	lw	a4,236(a4)
ffffffffc02046e2:	02f71f63          	bne	a4,a5,ffffffffc0204720 <__up.constprop.0+0x6c>
ffffffffc02046e6:	4685                	li	a3,1
ffffffffc02046e8:	10000613          	li	a2,256
ffffffffc02046ec:	8526                	mv	a0,s1
ffffffffc02046ee:	d9bff0ef          	jal	ra,ffffffffc0204488 <wakeup_wait>
ffffffffc02046f2:	00091863          	bnez	s2,ffffffffc0204702 <__up.constprop.0+0x4e>
ffffffffc02046f6:	60e2                	ld	ra,24(sp)
ffffffffc02046f8:	6442                	ld	s0,16(sp)
ffffffffc02046fa:	64a2                	ld	s1,8(sp)
ffffffffc02046fc:	6902                	ld	s2,0(sp)
ffffffffc02046fe:	6105                	addi	sp,sp,32
ffffffffc0204700:	8082                	ret
ffffffffc0204702:	6442                	ld	s0,16(sp)
ffffffffc0204704:	60e2                	ld	ra,24(sp)
ffffffffc0204706:	64a2                	ld	s1,8(sp)
ffffffffc0204708:	6902                	ld	s2,0(sp)
ffffffffc020470a:	6105                	addi	sp,sp,32
ffffffffc020470c:	e92fc06f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc0204710:	401c                	lw	a5,0(s0)
ffffffffc0204712:	2785                	addiw	a5,a5,1
ffffffffc0204714:	c01c                	sw	a5,0(s0)
ffffffffc0204716:	bff1                	j	ffffffffc02046f2 <__up.constprop.0+0x3e>
ffffffffc0204718:	e8cfc0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020471c:	4905                	li	s2,1
ffffffffc020471e:	b775                	j	ffffffffc02046ca <__up.constprop.0+0x16>
ffffffffc0204720:	00009697          	auipc	a3,0x9
ffffffffc0204724:	87068693          	addi	a3,a3,-1936 # ffffffffc020cf90 <default_pmm_manager+0x7d0>
ffffffffc0204728:	00007617          	auipc	a2,0x7
ffffffffc020472c:	0d060613          	addi	a2,a2,208 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204730:	45e5                	li	a1,25
ffffffffc0204732:	00009517          	auipc	a0,0x9
ffffffffc0204736:	88650513          	addi	a0,a0,-1914 # ffffffffc020cfb8 <default_pmm_manager+0x7f8>
ffffffffc020473a:	af5fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020473e <sem_init>:
ffffffffc020473e:	c10c                	sw	a1,0(a0)
ffffffffc0204740:	0521                	addi	a0,a0,8
ffffffffc0204742:	cd9ff06f          	j	ffffffffc020441a <wait_queue_init>

ffffffffc0204746 <up>:
ffffffffc0204746:	f6fff06f          	j	ffffffffc02046b4 <__up.constprop.0>

ffffffffc020474a <down>:
ffffffffc020474a:	1141                	addi	sp,sp,-16
ffffffffc020474c:	e406                	sd	ra,8(sp)
ffffffffc020474e:	ea9ff0ef          	jal	ra,ffffffffc02045f6 <__down.constprop.0>
ffffffffc0204752:	2501                	sext.w	a0,a0
ffffffffc0204754:	e501                	bnez	a0,ffffffffc020475c <down+0x12>
ffffffffc0204756:	60a2                	ld	ra,8(sp)
ffffffffc0204758:	0141                	addi	sp,sp,16
ffffffffc020475a:	8082                	ret
ffffffffc020475c:	00009697          	auipc	a3,0x9
ffffffffc0204760:	86c68693          	addi	a3,a3,-1940 # ffffffffc020cfc8 <default_pmm_manager+0x808>
ffffffffc0204764:	00007617          	auipc	a2,0x7
ffffffffc0204768:	09460613          	addi	a2,a2,148 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020476c:	04000593          	li	a1,64
ffffffffc0204770:	00009517          	auipc	a0,0x9
ffffffffc0204774:	84850513          	addi	a0,a0,-1976 # ffffffffc020cfb8 <default_pmm_manager+0x7f8>
ffffffffc0204778:	ab7fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020477c <copy_path>:
ffffffffc020477c:	7139                	addi	sp,sp,-64
ffffffffc020477e:	f04a                	sd	s2,32(sp)
ffffffffc0204780:	00092917          	auipc	s2,0x92
ffffffffc0204784:	14090913          	addi	s2,s2,320 # ffffffffc02968c0 <current>
ffffffffc0204788:	00093703          	ld	a4,0(s2)
ffffffffc020478c:	ec4e                	sd	s3,24(sp)
ffffffffc020478e:	89aa                	mv	s3,a0
ffffffffc0204790:	6505                	lui	a0,0x1
ffffffffc0204792:	f426                	sd	s1,40(sp)
ffffffffc0204794:	e852                	sd	s4,16(sp)
ffffffffc0204796:	fc06                	sd	ra,56(sp)
ffffffffc0204798:	f822                	sd	s0,48(sp)
ffffffffc020479a:	e456                	sd	s5,8(sp)
ffffffffc020479c:	02873a03          	ld	s4,40(a4)
ffffffffc02047a0:	84ae                	mv	s1,a1
ffffffffc02047a2:	d74fd0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02047a6:	c141                	beqz	a0,ffffffffc0204826 <copy_path+0xaa>
ffffffffc02047a8:	842a                	mv	s0,a0
ffffffffc02047aa:	040a0563          	beqz	s4,ffffffffc02047f4 <copy_path+0x78>
ffffffffc02047ae:	038a0a93          	addi	s5,s4,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc02047b2:	8556                	mv	a0,s5
ffffffffc02047b4:	f97ff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc02047b8:	00093783          	ld	a5,0(s2)
ffffffffc02047bc:	cba1                	beqz	a5,ffffffffc020480c <copy_path+0x90>
ffffffffc02047be:	43dc                	lw	a5,4(a5)
ffffffffc02047c0:	6685                	lui	a3,0x1
ffffffffc02047c2:	8626                	mv	a2,s1
ffffffffc02047c4:	04fa2823          	sw	a5,80(s4)
ffffffffc02047c8:	85a2                	mv	a1,s0
ffffffffc02047ca:	8552                	mv	a0,s4
ffffffffc02047cc:	a92fd0ef          	jal	ra,ffffffffc0201a5e <copy_string>
ffffffffc02047d0:	c529                	beqz	a0,ffffffffc020481a <copy_path+0x9e>
ffffffffc02047d2:	8556                	mv	a0,s5
ffffffffc02047d4:	f73ff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc02047d8:	040a2823          	sw	zero,80(s4)
ffffffffc02047dc:	0089b023          	sd	s0,0(s3)
ffffffffc02047e0:	4501                	li	a0,0
ffffffffc02047e2:	70e2                	ld	ra,56(sp)
ffffffffc02047e4:	7442                	ld	s0,48(sp)
ffffffffc02047e6:	74a2                	ld	s1,40(sp)
ffffffffc02047e8:	7902                	ld	s2,32(sp)
ffffffffc02047ea:	69e2                	ld	s3,24(sp)
ffffffffc02047ec:	6a42                	ld	s4,16(sp)
ffffffffc02047ee:	6aa2                	ld	s5,8(sp)
ffffffffc02047f0:	6121                	addi	sp,sp,64
ffffffffc02047f2:	8082                	ret
ffffffffc02047f4:	85aa                	mv	a1,a0
ffffffffc02047f6:	6685                	lui	a3,0x1
ffffffffc02047f8:	8626                	mv	a2,s1
ffffffffc02047fa:	4501                	li	a0,0
ffffffffc02047fc:	a62fd0ef          	jal	ra,ffffffffc0201a5e <copy_string>
ffffffffc0204800:	fd71                	bnez	a0,ffffffffc02047dc <copy_path+0x60>
ffffffffc0204802:	8522                	mv	a0,s0
ffffffffc0204804:	dc2fd0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0204808:	5575                	li	a0,-3
ffffffffc020480a:	bfe1                	j	ffffffffc02047e2 <copy_path+0x66>
ffffffffc020480c:	6685                	lui	a3,0x1
ffffffffc020480e:	8626                	mv	a2,s1
ffffffffc0204810:	85a2                	mv	a1,s0
ffffffffc0204812:	8552                	mv	a0,s4
ffffffffc0204814:	a4afd0ef          	jal	ra,ffffffffc0201a5e <copy_string>
ffffffffc0204818:	fd4d                	bnez	a0,ffffffffc02047d2 <copy_path+0x56>
ffffffffc020481a:	8556                	mv	a0,s5
ffffffffc020481c:	f2bff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204820:	040a2823          	sw	zero,80(s4)
ffffffffc0204824:	bff9                	j	ffffffffc0204802 <copy_path+0x86>
ffffffffc0204826:	5571                	li	a0,-4
ffffffffc0204828:	bf6d                	j	ffffffffc02047e2 <copy_path+0x66>

ffffffffc020482a <sysfile_open>:
ffffffffc020482a:	7179                	addi	sp,sp,-48
ffffffffc020482c:	872a                	mv	a4,a0
ffffffffc020482e:	ec26                	sd	s1,24(sp)
ffffffffc0204830:	0028                	addi	a0,sp,8
ffffffffc0204832:	84ae                	mv	s1,a1
ffffffffc0204834:	85ba                	mv	a1,a4
ffffffffc0204836:	f022                	sd	s0,32(sp)
ffffffffc0204838:	f406                	sd	ra,40(sp)
ffffffffc020483a:	f43ff0ef          	jal	ra,ffffffffc020477c <copy_path>
ffffffffc020483e:	842a                	mv	s0,a0
ffffffffc0204840:	e909                	bnez	a0,ffffffffc0204852 <sysfile_open+0x28>
ffffffffc0204842:	6522                	ld	a0,8(sp)
ffffffffc0204844:	85a6                	mv	a1,s1
ffffffffc0204846:	7ba000ef          	jal	ra,ffffffffc0205000 <file_open>
ffffffffc020484a:	842a                	mv	s0,a0
ffffffffc020484c:	6522                	ld	a0,8(sp)
ffffffffc020484e:	d78fd0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0204852:	70a2                	ld	ra,40(sp)
ffffffffc0204854:	8522                	mv	a0,s0
ffffffffc0204856:	7402                	ld	s0,32(sp)
ffffffffc0204858:	64e2                	ld	s1,24(sp)
ffffffffc020485a:	6145                	addi	sp,sp,48
ffffffffc020485c:	8082                	ret

ffffffffc020485e <sysfile_close>:
ffffffffc020485e:	0a10006f          	j	ffffffffc02050fe <file_close>

ffffffffc0204862 <sysfile_read>:
ffffffffc0204862:	7159                	addi	sp,sp,-112
ffffffffc0204864:	f0a2                	sd	s0,96(sp)
ffffffffc0204866:	f486                	sd	ra,104(sp)
ffffffffc0204868:	eca6                	sd	s1,88(sp)
ffffffffc020486a:	e8ca                	sd	s2,80(sp)
ffffffffc020486c:	e4ce                	sd	s3,72(sp)
ffffffffc020486e:	e0d2                	sd	s4,64(sp)
ffffffffc0204870:	fc56                	sd	s5,56(sp)
ffffffffc0204872:	f85a                	sd	s6,48(sp)
ffffffffc0204874:	f45e                	sd	s7,40(sp)
ffffffffc0204876:	f062                	sd	s8,32(sp)
ffffffffc0204878:	ec66                	sd	s9,24(sp)
ffffffffc020487a:	4401                	li	s0,0
ffffffffc020487c:	ee19                	bnez	a2,ffffffffc020489a <sysfile_read+0x38>
ffffffffc020487e:	70a6                	ld	ra,104(sp)
ffffffffc0204880:	8522                	mv	a0,s0
ffffffffc0204882:	7406                	ld	s0,96(sp)
ffffffffc0204884:	64e6                	ld	s1,88(sp)
ffffffffc0204886:	6946                	ld	s2,80(sp)
ffffffffc0204888:	69a6                	ld	s3,72(sp)
ffffffffc020488a:	6a06                	ld	s4,64(sp)
ffffffffc020488c:	7ae2                	ld	s5,56(sp)
ffffffffc020488e:	7b42                	ld	s6,48(sp)
ffffffffc0204890:	7ba2                	ld	s7,40(sp)
ffffffffc0204892:	7c02                	ld	s8,32(sp)
ffffffffc0204894:	6ce2                	ld	s9,24(sp)
ffffffffc0204896:	6165                	addi	sp,sp,112
ffffffffc0204898:	8082                	ret
ffffffffc020489a:	00092c97          	auipc	s9,0x92
ffffffffc020489e:	026c8c93          	addi	s9,s9,38 # ffffffffc02968c0 <current>
ffffffffc02048a2:	000cb783          	ld	a5,0(s9)
ffffffffc02048a6:	84b2                	mv	s1,a2
ffffffffc02048a8:	8b2e                	mv	s6,a1
ffffffffc02048aa:	4601                	li	a2,0
ffffffffc02048ac:	4585                	li	a1,1
ffffffffc02048ae:	0287b903          	ld	s2,40(a5)
ffffffffc02048b2:	8aaa                	mv	s5,a0
ffffffffc02048b4:	6f8000ef          	jal	ra,ffffffffc0204fac <file_testfd>
ffffffffc02048b8:	c959                	beqz	a0,ffffffffc020494e <sysfile_read+0xec>
ffffffffc02048ba:	6505                	lui	a0,0x1
ffffffffc02048bc:	c5afd0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02048c0:	89aa                	mv	s3,a0
ffffffffc02048c2:	c941                	beqz	a0,ffffffffc0204952 <sysfile_read+0xf0>
ffffffffc02048c4:	4b81                	li	s7,0
ffffffffc02048c6:	6a05                	lui	s4,0x1
ffffffffc02048c8:	03890c13          	addi	s8,s2,56
ffffffffc02048cc:	0744ec63          	bltu	s1,s4,ffffffffc0204944 <sysfile_read+0xe2>
ffffffffc02048d0:	e452                	sd	s4,8(sp)
ffffffffc02048d2:	6605                	lui	a2,0x1
ffffffffc02048d4:	0034                	addi	a3,sp,8
ffffffffc02048d6:	85ce                	mv	a1,s3
ffffffffc02048d8:	8556                	mv	a0,s5
ffffffffc02048da:	07b000ef          	jal	ra,ffffffffc0205154 <file_read>
ffffffffc02048de:	66a2                	ld	a3,8(sp)
ffffffffc02048e0:	842a                	mv	s0,a0
ffffffffc02048e2:	ca9d                	beqz	a3,ffffffffc0204918 <sysfile_read+0xb6>
ffffffffc02048e4:	00090c63          	beqz	s2,ffffffffc02048fc <sysfile_read+0x9a>
ffffffffc02048e8:	8562                	mv	a0,s8
ffffffffc02048ea:	e61ff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc02048ee:	000cb783          	ld	a5,0(s9)
ffffffffc02048f2:	cfa1                	beqz	a5,ffffffffc020494a <sysfile_read+0xe8>
ffffffffc02048f4:	43dc                	lw	a5,4(a5)
ffffffffc02048f6:	66a2                	ld	a3,8(sp)
ffffffffc02048f8:	04f92823          	sw	a5,80(s2)
ffffffffc02048fc:	864e                	mv	a2,s3
ffffffffc02048fe:	85da                	mv	a1,s6
ffffffffc0204900:	854a                	mv	a0,s2
ffffffffc0204902:	92afd0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0204906:	c50d                	beqz	a0,ffffffffc0204930 <sysfile_read+0xce>
ffffffffc0204908:	67a2                	ld	a5,8(sp)
ffffffffc020490a:	04f4e663          	bltu	s1,a5,ffffffffc0204956 <sysfile_read+0xf4>
ffffffffc020490e:	9b3e                	add	s6,s6,a5
ffffffffc0204910:	8c9d                	sub	s1,s1,a5
ffffffffc0204912:	9bbe                	add	s7,s7,a5
ffffffffc0204914:	02091263          	bnez	s2,ffffffffc0204938 <sysfile_read+0xd6>
ffffffffc0204918:	e401                	bnez	s0,ffffffffc0204920 <sysfile_read+0xbe>
ffffffffc020491a:	67a2                	ld	a5,8(sp)
ffffffffc020491c:	c391                	beqz	a5,ffffffffc0204920 <sysfile_read+0xbe>
ffffffffc020491e:	f4dd                	bnez	s1,ffffffffc02048cc <sysfile_read+0x6a>
ffffffffc0204920:	854e                	mv	a0,s3
ffffffffc0204922:	ca4fd0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0204926:	f40b8ce3          	beqz	s7,ffffffffc020487e <sysfile_read+0x1c>
ffffffffc020492a:	000b841b          	sext.w	s0,s7
ffffffffc020492e:	bf81                	j	ffffffffc020487e <sysfile_read+0x1c>
ffffffffc0204930:	e011                	bnez	s0,ffffffffc0204934 <sysfile_read+0xd2>
ffffffffc0204932:	5475                	li	s0,-3
ffffffffc0204934:	fe0906e3          	beqz	s2,ffffffffc0204920 <sysfile_read+0xbe>
ffffffffc0204938:	8562                	mv	a0,s8
ffffffffc020493a:	e0dff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020493e:	04092823          	sw	zero,80(s2)
ffffffffc0204942:	bfd9                	j	ffffffffc0204918 <sysfile_read+0xb6>
ffffffffc0204944:	e426                	sd	s1,8(sp)
ffffffffc0204946:	8626                	mv	a2,s1
ffffffffc0204948:	b771                	j	ffffffffc02048d4 <sysfile_read+0x72>
ffffffffc020494a:	66a2                	ld	a3,8(sp)
ffffffffc020494c:	bf45                	j	ffffffffc02048fc <sysfile_read+0x9a>
ffffffffc020494e:	5475                	li	s0,-3
ffffffffc0204950:	b73d                	j	ffffffffc020487e <sysfile_read+0x1c>
ffffffffc0204952:	5471                	li	s0,-4
ffffffffc0204954:	b72d                	j	ffffffffc020487e <sysfile_read+0x1c>
ffffffffc0204956:	00008697          	auipc	a3,0x8
ffffffffc020495a:	68268693          	addi	a3,a3,1666 # ffffffffc020cfd8 <default_pmm_manager+0x818>
ffffffffc020495e:	00007617          	auipc	a2,0x7
ffffffffc0204962:	e9a60613          	addi	a2,a2,-358 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204966:	05500593          	li	a1,85
ffffffffc020496a:	00008517          	auipc	a0,0x8
ffffffffc020496e:	67e50513          	addi	a0,a0,1662 # ffffffffc020cfe8 <default_pmm_manager+0x828>
ffffffffc0204972:	8bdfb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204976 <sysfile_write>:
ffffffffc0204976:	7159                	addi	sp,sp,-112
ffffffffc0204978:	e8ca                	sd	s2,80(sp)
ffffffffc020497a:	f486                	sd	ra,104(sp)
ffffffffc020497c:	f0a2                	sd	s0,96(sp)
ffffffffc020497e:	eca6                	sd	s1,88(sp)
ffffffffc0204980:	e4ce                	sd	s3,72(sp)
ffffffffc0204982:	e0d2                	sd	s4,64(sp)
ffffffffc0204984:	fc56                	sd	s5,56(sp)
ffffffffc0204986:	f85a                	sd	s6,48(sp)
ffffffffc0204988:	f45e                	sd	s7,40(sp)
ffffffffc020498a:	f062                	sd	s8,32(sp)
ffffffffc020498c:	ec66                	sd	s9,24(sp)
ffffffffc020498e:	4901                	li	s2,0
ffffffffc0204990:	ee19                	bnez	a2,ffffffffc02049ae <sysfile_write+0x38>
ffffffffc0204992:	70a6                	ld	ra,104(sp)
ffffffffc0204994:	7406                	ld	s0,96(sp)
ffffffffc0204996:	64e6                	ld	s1,88(sp)
ffffffffc0204998:	69a6                	ld	s3,72(sp)
ffffffffc020499a:	6a06                	ld	s4,64(sp)
ffffffffc020499c:	7ae2                	ld	s5,56(sp)
ffffffffc020499e:	7b42                	ld	s6,48(sp)
ffffffffc02049a0:	7ba2                	ld	s7,40(sp)
ffffffffc02049a2:	7c02                	ld	s8,32(sp)
ffffffffc02049a4:	6ce2                	ld	s9,24(sp)
ffffffffc02049a6:	854a                	mv	a0,s2
ffffffffc02049a8:	6946                	ld	s2,80(sp)
ffffffffc02049aa:	6165                	addi	sp,sp,112
ffffffffc02049ac:	8082                	ret
ffffffffc02049ae:	00092c17          	auipc	s8,0x92
ffffffffc02049b2:	f12c0c13          	addi	s8,s8,-238 # ffffffffc02968c0 <current>
ffffffffc02049b6:	000c3783          	ld	a5,0(s8)
ffffffffc02049ba:	8432                	mv	s0,a2
ffffffffc02049bc:	89ae                	mv	s3,a1
ffffffffc02049be:	4605                	li	a2,1
ffffffffc02049c0:	4581                	li	a1,0
ffffffffc02049c2:	7784                	ld	s1,40(a5)
ffffffffc02049c4:	8baa                	mv	s7,a0
ffffffffc02049c6:	5e6000ef          	jal	ra,ffffffffc0204fac <file_testfd>
ffffffffc02049ca:	cd59                	beqz	a0,ffffffffc0204a68 <sysfile_write+0xf2>
ffffffffc02049cc:	6505                	lui	a0,0x1
ffffffffc02049ce:	b48fd0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02049d2:	8a2a                	mv	s4,a0
ffffffffc02049d4:	cd41                	beqz	a0,ffffffffc0204a6c <sysfile_write+0xf6>
ffffffffc02049d6:	4c81                	li	s9,0
ffffffffc02049d8:	6a85                	lui	s5,0x1
ffffffffc02049da:	03848b13          	addi	s6,s1,56
ffffffffc02049de:	05546a63          	bltu	s0,s5,ffffffffc0204a32 <sysfile_write+0xbc>
ffffffffc02049e2:	e456                	sd	s5,8(sp)
ffffffffc02049e4:	c8a9                	beqz	s1,ffffffffc0204a36 <sysfile_write+0xc0>
ffffffffc02049e6:	855a                	mv	a0,s6
ffffffffc02049e8:	d63ff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc02049ec:	000c3783          	ld	a5,0(s8)
ffffffffc02049f0:	c399                	beqz	a5,ffffffffc02049f6 <sysfile_write+0x80>
ffffffffc02049f2:	43dc                	lw	a5,4(a5)
ffffffffc02049f4:	c8bc                	sw	a5,80(s1)
ffffffffc02049f6:	66a2                	ld	a3,8(sp)
ffffffffc02049f8:	4701                	li	a4,0
ffffffffc02049fa:	864e                	mv	a2,s3
ffffffffc02049fc:	85d2                	mv	a1,s4
ffffffffc02049fe:	8526                	mv	a0,s1
ffffffffc0204a00:	ff9fc0ef          	jal	ra,ffffffffc02019f8 <copy_from_user>
ffffffffc0204a04:	c139                	beqz	a0,ffffffffc0204a4a <sysfile_write+0xd4>
ffffffffc0204a06:	855a                	mv	a0,s6
ffffffffc0204a08:	d3fff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204a0c:	0404a823          	sw	zero,80(s1)
ffffffffc0204a10:	6622                	ld	a2,8(sp)
ffffffffc0204a12:	0034                	addi	a3,sp,8
ffffffffc0204a14:	85d2                	mv	a1,s4
ffffffffc0204a16:	855e                	mv	a0,s7
ffffffffc0204a18:	023000ef          	jal	ra,ffffffffc020523a <file_write>
ffffffffc0204a1c:	67a2                	ld	a5,8(sp)
ffffffffc0204a1e:	892a                	mv	s2,a0
ffffffffc0204a20:	ef85                	bnez	a5,ffffffffc0204a58 <sysfile_write+0xe2>
ffffffffc0204a22:	8552                	mv	a0,s4
ffffffffc0204a24:	ba2fd0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0204a28:	f60c85e3          	beqz	s9,ffffffffc0204992 <sysfile_write+0x1c>
ffffffffc0204a2c:	000c891b          	sext.w	s2,s9
ffffffffc0204a30:	b78d                	j	ffffffffc0204992 <sysfile_write+0x1c>
ffffffffc0204a32:	e422                	sd	s0,8(sp)
ffffffffc0204a34:	f8cd                	bnez	s1,ffffffffc02049e6 <sysfile_write+0x70>
ffffffffc0204a36:	66a2                	ld	a3,8(sp)
ffffffffc0204a38:	4701                	li	a4,0
ffffffffc0204a3a:	864e                	mv	a2,s3
ffffffffc0204a3c:	85d2                	mv	a1,s4
ffffffffc0204a3e:	4501                	li	a0,0
ffffffffc0204a40:	fb9fc0ef          	jal	ra,ffffffffc02019f8 <copy_from_user>
ffffffffc0204a44:	f571                	bnez	a0,ffffffffc0204a10 <sysfile_write+0x9a>
ffffffffc0204a46:	5975                	li	s2,-3
ffffffffc0204a48:	bfe9                	j	ffffffffc0204a22 <sysfile_write+0xac>
ffffffffc0204a4a:	855a                	mv	a0,s6
ffffffffc0204a4c:	cfbff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204a50:	5975                	li	s2,-3
ffffffffc0204a52:	0404a823          	sw	zero,80(s1)
ffffffffc0204a56:	b7f1                	j	ffffffffc0204a22 <sysfile_write+0xac>
ffffffffc0204a58:	00f46c63          	bltu	s0,a5,ffffffffc0204a70 <sysfile_write+0xfa>
ffffffffc0204a5c:	99be                	add	s3,s3,a5
ffffffffc0204a5e:	8c1d                	sub	s0,s0,a5
ffffffffc0204a60:	9cbe                	add	s9,s9,a5
ffffffffc0204a62:	f161                	bnez	a0,ffffffffc0204a22 <sysfile_write+0xac>
ffffffffc0204a64:	fc2d                	bnez	s0,ffffffffc02049de <sysfile_write+0x68>
ffffffffc0204a66:	bf75                	j	ffffffffc0204a22 <sysfile_write+0xac>
ffffffffc0204a68:	5975                	li	s2,-3
ffffffffc0204a6a:	b725                	j	ffffffffc0204992 <sysfile_write+0x1c>
ffffffffc0204a6c:	5971                	li	s2,-4
ffffffffc0204a6e:	b715                	j	ffffffffc0204992 <sysfile_write+0x1c>
ffffffffc0204a70:	00008697          	auipc	a3,0x8
ffffffffc0204a74:	56868693          	addi	a3,a3,1384 # ffffffffc020cfd8 <default_pmm_manager+0x818>
ffffffffc0204a78:	00007617          	auipc	a2,0x7
ffffffffc0204a7c:	d8060613          	addi	a2,a2,-640 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204a80:	08a00593          	li	a1,138
ffffffffc0204a84:	00008517          	auipc	a0,0x8
ffffffffc0204a88:	56450513          	addi	a0,a0,1380 # ffffffffc020cfe8 <default_pmm_manager+0x828>
ffffffffc0204a8c:	fa2fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204a90 <sysfile_seek>:
ffffffffc0204a90:	0910006f          	j	ffffffffc0205320 <file_seek>

ffffffffc0204a94 <sysfile_fstat>:
ffffffffc0204a94:	715d                	addi	sp,sp,-80
ffffffffc0204a96:	f44e                	sd	s3,40(sp)
ffffffffc0204a98:	00092997          	auipc	s3,0x92
ffffffffc0204a9c:	e2898993          	addi	s3,s3,-472 # ffffffffc02968c0 <current>
ffffffffc0204aa0:	0009b703          	ld	a4,0(s3)
ffffffffc0204aa4:	fc26                	sd	s1,56(sp)
ffffffffc0204aa6:	84ae                	mv	s1,a1
ffffffffc0204aa8:	858a                	mv	a1,sp
ffffffffc0204aaa:	e0a2                	sd	s0,64(sp)
ffffffffc0204aac:	f84a                	sd	s2,48(sp)
ffffffffc0204aae:	e486                	sd	ra,72(sp)
ffffffffc0204ab0:	02873903          	ld	s2,40(a4)
ffffffffc0204ab4:	f052                	sd	s4,32(sp)
ffffffffc0204ab6:	18b000ef          	jal	ra,ffffffffc0205440 <file_fstat>
ffffffffc0204aba:	842a                	mv	s0,a0
ffffffffc0204abc:	e91d                	bnez	a0,ffffffffc0204af2 <sysfile_fstat+0x5e>
ffffffffc0204abe:	04090363          	beqz	s2,ffffffffc0204b04 <sysfile_fstat+0x70>
ffffffffc0204ac2:	03890a13          	addi	s4,s2,56
ffffffffc0204ac6:	8552                	mv	a0,s4
ffffffffc0204ac8:	c83ff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0204acc:	0009b783          	ld	a5,0(s3)
ffffffffc0204ad0:	c3b9                	beqz	a5,ffffffffc0204b16 <sysfile_fstat+0x82>
ffffffffc0204ad2:	43dc                	lw	a5,4(a5)
ffffffffc0204ad4:	02000693          	li	a3,32
ffffffffc0204ad8:	860a                	mv	a2,sp
ffffffffc0204ada:	04f92823          	sw	a5,80(s2)
ffffffffc0204ade:	85a6                	mv	a1,s1
ffffffffc0204ae0:	854a                	mv	a0,s2
ffffffffc0204ae2:	f4bfc0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0204ae6:	c121                	beqz	a0,ffffffffc0204b26 <sysfile_fstat+0x92>
ffffffffc0204ae8:	8552                	mv	a0,s4
ffffffffc0204aea:	c5dff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204aee:	04092823          	sw	zero,80(s2)
ffffffffc0204af2:	60a6                	ld	ra,72(sp)
ffffffffc0204af4:	8522                	mv	a0,s0
ffffffffc0204af6:	6406                	ld	s0,64(sp)
ffffffffc0204af8:	74e2                	ld	s1,56(sp)
ffffffffc0204afa:	7942                	ld	s2,48(sp)
ffffffffc0204afc:	79a2                	ld	s3,40(sp)
ffffffffc0204afe:	7a02                	ld	s4,32(sp)
ffffffffc0204b00:	6161                	addi	sp,sp,80
ffffffffc0204b02:	8082                	ret
ffffffffc0204b04:	02000693          	li	a3,32
ffffffffc0204b08:	860a                	mv	a2,sp
ffffffffc0204b0a:	85a6                	mv	a1,s1
ffffffffc0204b0c:	f21fc0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0204b10:	f16d                	bnez	a0,ffffffffc0204af2 <sysfile_fstat+0x5e>
ffffffffc0204b12:	5475                	li	s0,-3
ffffffffc0204b14:	bff9                	j	ffffffffc0204af2 <sysfile_fstat+0x5e>
ffffffffc0204b16:	02000693          	li	a3,32
ffffffffc0204b1a:	860a                	mv	a2,sp
ffffffffc0204b1c:	85a6                	mv	a1,s1
ffffffffc0204b1e:	854a                	mv	a0,s2
ffffffffc0204b20:	f0dfc0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0204b24:	f171                	bnez	a0,ffffffffc0204ae8 <sysfile_fstat+0x54>
ffffffffc0204b26:	8552                	mv	a0,s4
ffffffffc0204b28:	c1fff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204b2c:	5475                	li	s0,-3
ffffffffc0204b2e:	04092823          	sw	zero,80(s2)
ffffffffc0204b32:	b7c1                	j	ffffffffc0204af2 <sysfile_fstat+0x5e>

ffffffffc0204b34 <sysfile_fsync>:
ffffffffc0204b34:	1cd0006f          	j	ffffffffc0205500 <file_fsync>

ffffffffc0204b38 <sysfile_getcwd>:
ffffffffc0204b38:	715d                	addi	sp,sp,-80
ffffffffc0204b3a:	f44e                	sd	s3,40(sp)
ffffffffc0204b3c:	00092997          	auipc	s3,0x92
ffffffffc0204b40:	d8498993          	addi	s3,s3,-636 # ffffffffc02968c0 <current>
ffffffffc0204b44:	0009b783          	ld	a5,0(s3)
ffffffffc0204b48:	f84a                	sd	s2,48(sp)
ffffffffc0204b4a:	e486                	sd	ra,72(sp)
ffffffffc0204b4c:	e0a2                	sd	s0,64(sp)
ffffffffc0204b4e:	fc26                	sd	s1,56(sp)
ffffffffc0204b50:	f052                	sd	s4,32(sp)
ffffffffc0204b52:	0287b903          	ld	s2,40(a5)
ffffffffc0204b56:	cda9                	beqz	a1,ffffffffc0204bb0 <sysfile_getcwd+0x78>
ffffffffc0204b58:	842e                	mv	s0,a1
ffffffffc0204b5a:	84aa                	mv	s1,a0
ffffffffc0204b5c:	04090363          	beqz	s2,ffffffffc0204ba2 <sysfile_getcwd+0x6a>
ffffffffc0204b60:	03890a13          	addi	s4,s2,56
ffffffffc0204b64:	8552                	mv	a0,s4
ffffffffc0204b66:	be5ff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0204b6a:	0009b783          	ld	a5,0(s3)
ffffffffc0204b6e:	c781                	beqz	a5,ffffffffc0204b76 <sysfile_getcwd+0x3e>
ffffffffc0204b70:	43dc                	lw	a5,4(a5)
ffffffffc0204b72:	04f92823          	sw	a5,80(s2)
ffffffffc0204b76:	4685                	li	a3,1
ffffffffc0204b78:	8622                	mv	a2,s0
ffffffffc0204b7a:	85a6                	mv	a1,s1
ffffffffc0204b7c:	854a                	mv	a0,s2
ffffffffc0204b7e:	de7fc0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc0204b82:	e90d                	bnez	a0,ffffffffc0204bb4 <sysfile_getcwd+0x7c>
ffffffffc0204b84:	5475                	li	s0,-3
ffffffffc0204b86:	8552                	mv	a0,s4
ffffffffc0204b88:	bbfff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204b8c:	04092823          	sw	zero,80(s2)
ffffffffc0204b90:	60a6                	ld	ra,72(sp)
ffffffffc0204b92:	8522                	mv	a0,s0
ffffffffc0204b94:	6406                	ld	s0,64(sp)
ffffffffc0204b96:	74e2                	ld	s1,56(sp)
ffffffffc0204b98:	7942                	ld	s2,48(sp)
ffffffffc0204b9a:	79a2                	ld	s3,40(sp)
ffffffffc0204b9c:	7a02                	ld	s4,32(sp)
ffffffffc0204b9e:	6161                	addi	sp,sp,80
ffffffffc0204ba0:	8082                	ret
ffffffffc0204ba2:	862e                	mv	a2,a1
ffffffffc0204ba4:	4685                	li	a3,1
ffffffffc0204ba6:	85aa                	mv	a1,a0
ffffffffc0204ba8:	4501                	li	a0,0
ffffffffc0204baa:	dbbfc0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc0204bae:	ed09                	bnez	a0,ffffffffc0204bc8 <sysfile_getcwd+0x90>
ffffffffc0204bb0:	5475                	li	s0,-3
ffffffffc0204bb2:	bff9                	j	ffffffffc0204b90 <sysfile_getcwd+0x58>
ffffffffc0204bb4:	8622                	mv	a2,s0
ffffffffc0204bb6:	4681                	li	a3,0
ffffffffc0204bb8:	85a6                	mv	a1,s1
ffffffffc0204bba:	850a                	mv	a0,sp
ffffffffc0204bbc:	371000ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc0204bc0:	13c030ef          	jal	ra,ffffffffc0207cfc <vfs_getcwd>
ffffffffc0204bc4:	842a                	mv	s0,a0
ffffffffc0204bc6:	b7c1                	j	ffffffffc0204b86 <sysfile_getcwd+0x4e>
ffffffffc0204bc8:	8622                	mv	a2,s0
ffffffffc0204bca:	4681                	li	a3,0
ffffffffc0204bcc:	85a6                	mv	a1,s1
ffffffffc0204bce:	850a                	mv	a0,sp
ffffffffc0204bd0:	35d000ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc0204bd4:	128030ef          	jal	ra,ffffffffc0207cfc <vfs_getcwd>
ffffffffc0204bd8:	842a                	mv	s0,a0
ffffffffc0204bda:	bf5d                	j	ffffffffc0204b90 <sysfile_getcwd+0x58>

ffffffffc0204bdc <sysfile_getdirentry>:
ffffffffc0204bdc:	7139                	addi	sp,sp,-64
ffffffffc0204bde:	e852                	sd	s4,16(sp)
ffffffffc0204be0:	00092a17          	auipc	s4,0x92
ffffffffc0204be4:	ce0a0a13          	addi	s4,s4,-800 # ffffffffc02968c0 <current>
ffffffffc0204be8:	000a3703          	ld	a4,0(s4)
ffffffffc0204bec:	ec4e                	sd	s3,24(sp)
ffffffffc0204bee:	89aa                	mv	s3,a0
ffffffffc0204bf0:	10800513          	li	a0,264
ffffffffc0204bf4:	f426                	sd	s1,40(sp)
ffffffffc0204bf6:	f04a                	sd	s2,32(sp)
ffffffffc0204bf8:	fc06                	sd	ra,56(sp)
ffffffffc0204bfa:	f822                	sd	s0,48(sp)
ffffffffc0204bfc:	e456                	sd	s5,8(sp)
ffffffffc0204bfe:	7704                	ld	s1,40(a4)
ffffffffc0204c00:	892e                	mv	s2,a1
ffffffffc0204c02:	914fd0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0204c06:	c169                	beqz	a0,ffffffffc0204cc8 <sysfile_getdirentry+0xec>
ffffffffc0204c08:	842a                	mv	s0,a0
ffffffffc0204c0a:	c8c1                	beqz	s1,ffffffffc0204c9a <sysfile_getdirentry+0xbe>
ffffffffc0204c0c:	03848a93          	addi	s5,s1,56
ffffffffc0204c10:	8556                	mv	a0,s5
ffffffffc0204c12:	b39ff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0204c16:	000a3783          	ld	a5,0(s4)
ffffffffc0204c1a:	c399                	beqz	a5,ffffffffc0204c20 <sysfile_getdirentry+0x44>
ffffffffc0204c1c:	43dc                	lw	a5,4(a5)
ffffffffc0204c1e:	c8bc                	sw	a5,80(s1)
ffffffffc0204c20:	4705                	li	a4,1
ffffffffc0204c22:	46a1                	li	a3,8
ffffffffc0204c24:	864a                	mv	a2,s2
ffffffffc0204c26:	85a2                	mv	a1,s0
ffffffffc0204c28:	8526                	mv	a0,s1
ffffffffc0204c2a:	dcffc0ef          	jal	ra,ffffffffc02019f8 <copy_from_user>
ffffffffc0204c2e:	e505                	bnez	a0,ffffffffc0204c56 <sysfile_getdirentry+0x7a>
ffffffffc0204c30:	8556                	mv	a0,s5
ffffffffc0204c32:	b15ff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204c36:	59f5                	li	s3,-3
ffffffffc0204c38:	0404a823          	sw	zero,80(s1)
ffffffffc0204c3c:	8522                	mv	a0,s0
ffffffffc0204c3e:	988fd0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0204c42:	70e2                	ld	ra,56(sp)
ffffffffc0204c44:	7442                	ld	s0,48(sp)
ffffffffc0204c46:	74a2                	ld	s1,40(sp)
ffffffffc0204c48:	7902                	ld	s2,32(sp)
ffffffffc0204c4a:	6a42                	ld	s4,16(sp)
ffffffffc0204c4c:	6aa2                	ld	s5,8(sp)
ffffffffc0204c4e:	854e                	mv	a0,s3
ffffffffc0204c50:	69e2                	ld	s3,24(sp)
ffffffffc0204c52:	6121                	addi	sp,sp,64
ffffffffc0204c54:	8082                	ret
ffffffffc0204c56:	8556                	mv	a0,s5
ffffffffc0204c58:	aefff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204c5c:	854e                	mv	a0,s3
ffffffffc0204c5e:	85a2                	mv	a1,s0
ffffffffc0204c60:	0404a823          	sw	zero,80(s1)
ffffffffc0204c64:	14b000ef          	jal	ra,ffffffffc02055ae <file_getdirentry>
ffffffffc0204c68:	89aa                	mv	s3,a0
ffffffffc0204c6a:	f969                	bnez	a0,ffffffffc0204c3c <sysfile_getdirentry+0x60>
ffffffffc0204c6c:	8556                	mv	a0,s5
ffffffffc0204c6e:	addff0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0204c72:	000a3783          	ld	a5,0(s4)
ffffffffc0204c76:	c399                	beqz	a5,ffffffffc0204c7c <sysfile_getdirentry+0xa0>
ffffffffc0204c78:	43dc                	lw	a5,4(a5)
ffffffffc0204c7a:	c8bc                	sw	a5,80(s1)
ffffffffc0204c7c:	10800693          	li	a3,264
ffffffffc0204c80:	8622                	mv	a2,s0
ffffffffc0204c82:	85ca                	mv	a1,s2
ffffffffc0204c84:	8526                	mv	a0,s1
ffffffffc0204c86:	da7fc0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0204c8a:	e111                	bnez	a0,ffffffffc0204c8e <sysfile_getdirentry+0xb2>
ffffffffc0204c8c:	59f5                	li	s3,-3
ffffffffc0204c8e:	8556                	mv	a0,s5
ffffffffc0204c90:	ab7ff0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0204c94:	0404a823          	sw	zero,80(s1)
ffffffffc0204c98:	b755                	j	ffffffffc0204c3c <sysfile_getdirentry+0x60>
ffffffffc0204c9a:	85aa                	mv	a1,a0
ffffffffc0204c9c:	4705                	li	a4,1
ffffffffc0204c9e:	46a1                	li	a3,8
ffffffffc0204ca0:	864a                	mv	a2,s2
ffffffffc0204ca2:	4501                	li	a0,0
ffffffffc0204ca4:	d55fc0ef          	jal	ra,ffffffffc02019f8 <copy_from_user>
ffffffffc0204ca8:	cd11                	beqz	a0,ffffffffc0204cc4 <sysfile_getdirentry+0xe8>
ffffffffc0204caa:	854e                	mv	a0,s3
ffffffffc0204cac:	85a2                	mv	a1,s0
ffffffffc0204cae:	101000ef          	jal	ra,ffffffffc02055ae <file_getdirentry>
ffffffffc0204cb2:	89aa                	mv	s3,a0
ffffffffc0204cb4:	f541                	bnez	a0,ffffffffc0204c3c <sysfile_getdirentry+0x60>
ffffffffc0204cb6:	10800693          	li	a3,264
ffffffffc0204cba:	8622                	mv	a2,s0
ffffffffc0204cbc:	85ca                	mv	a1,s2
ffffffffc0204cbe:	d6ffc0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0204cc2:	fd2d                	bnez	a0,ffffffffc0204c3c <sysfile_getdirentry+0x60>
ffffffffc0204cc4:	59f5                	li	s3,-3
ffffffffc0204cc6:	bf9d                	j	ffffffffc0204c3c <sysfile_getdirentry+0x60>
ffffffffc0204cc8:	59f1                	li	s3,-4
ffffffffc0204cca:	bfa5                	j	ffffffffc0204c42 <sysfile_getdirentry+0x66>

ffffffffc0204ccc <sysfile_dup>:
ffffffffc0204ccc:	1c90006f          	j	ffffffffc0205694 <file_dup>

ffffffffc0204cd0 <get_fd_array.part.0>:
ffffffffc0204cd0:	1141                	addi	sp,sp,-16
ffffffffc0204cd2:	00008697          	auipc	a3,0x8
ffffffffc0204cd6:	32e68693          	addi	a3,a3,814 # ffffffffc020d000 <default_pmm_manager+0x840>
ffffffffc0204cda:	00007617          	auipc	a2,0x7
ffffffffc0204cde:	b1e60613          	addi	a2,a2,-1250 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204ce2:	45d1                	li	a1,20
ffffffffc0204ce4:	00008517          	auipc	a0,0x8
ffffffffc0204ce8:	34c50513          	addi	a0,a0,844 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204cec:	e406                	sd	ra,8(sp)
ffffffffc0204cee:	d40fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204cf2 <fd_array_alloc>:
ffffffffc0204cf2:	00092797          	auipc	a5,0x92
ffffffffc0204cf6:	bce7b783          	ld	a5,-1074(a5) # ffffffffc02968c0 <current>
ffffffffc0204cfa:	1487b783          	ld	a5,328(a5)
ffffffffc0204cfe:	1141                	addi	sp,sp,-16
ffffffffc0204d00:	e406                	sd	ra,8(sp)
ffffffffc0204d02:	c3a5                	beqz	a5,ffffffffc0204d62 <fd_array_alloc+0x70>
ffffffffc0204d04:	4b98                	lw	a4,16(a5)
ffffffffc0204d06:	04e05e63          	blez	a4,ffffffffc0204d62 <fd_array_alloc+0x70>
ffffffffc0204d0a:	775d                	lui	a4,0xffff7
ffffffffc0204d0c:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204d10:	679c                	ld	a5,8(a5)
ffffffffc0204d12:	02e50863          	beq	a0,a4,ffffffffc0204d42 <fd_array_alloc+0x50>
ffffffffc0204d16:	04700713          	li	a4,71
ffffffffc0204d1a:	04a76263          	bltu	a4,a0,ffffffffc0204d5e <fd_array_alloc+0x6c>
ffffffffc0204d1e:	00351713          	slli	a4,a0,0x3
ffffffffc0204d22:	40a70533          	sub	a0,a4,a0
ffffffffc0204d26:	050e                	slli	a0,a0,0x3
ffffffffc0204d28:	97aa                	add	a5,a5,a0
ffffffffc0204d2a:	4398                	lw	a4,0(a5)
ffffffffc0204d2c:	e71d                	bnez	a4,ffffffffc0204d5a <fd_array_alloc+0x68>
ffffffffc0204d2e:	5b88                	lw	a0,48(a5)
ffffffffc0204d30:	e91d                	bnez	a0,ffffffffc0204d66 <fd_array_alloc+0x74>
ffffffffc0204d32:	4705                	li	a4,1
ffffffffc0204d34:	c398                	sw	a4,0(a5)
ffffffffc0204d36:	0207b423          	sd	zero,40(a5)
ffffffffc0204d3a:	e19c                	sd	a5,0(a1)
ffffffffc0204d3c:	60a2                	ld	ra,8(sp)
ffffffffc0204d3e:	0141                	addi	sp,sp,16
ffffffffc0204d40:	8082                	ret
ffffffffc0204d42:	6685                	lui	a3,0x1
ffffffffc0204d44:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204d48:	96be                	add	a3,a3,a5
ffffffffc0204d4a:	4398                	lw	a4,0(a5)
ffffffffc0204d4c:	d36d                	beqz	a4,ffffffffc0204d2e <fd_array_alloc+0x3c>
ffffffffc0204d4e:	03878793          	addi	a5,a5,56
ffffffffc0204d52:	fef69ce3          	bne	a3,a5,ffffffffc0204d4a <fd_array_alloc+0x58>
ffffffffc0204d56:	5529                	li	a0,-22
ffffffffc0204d58:	b7d5                	j	ffffffffc0204d3c <fd_array_alloc+0x4a>
ffffffffc0204d5a:	5545                	li	a0,-15
ffffffffc0204d5c:	b7c5                	j	ffffffffc0204d3c <fd_array_alloc+0x4a>
ffffffffc0204d5e:	5575                	li	a0,-3
ffffffffc0204d60:	bff1                	j	ffffffffc0204d3c <fd_array_alloc+0x4a>
ffffffffc0204d62:	f6fff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>
ffffffffc0204d66:	00008697          	auipc	a3,0x8
ffffffffc0204d6a:	2da68693          	addi	a3,a3,730 # ffffffffc020d040 <default_pmm_manager+0x880>
ffffffffc0204d6e:	00007617          	auipc	a2,0x7
ffffffffc0204d72:	a8a60613          	addi	a2,a2,-1398 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204d76:	03b00593          	li	a1,59
ffffffffc0204d7a:	00008517          	auipc	a0,0x8
ffffffffc0204d7e:	2b650513          	addi	a0,a0,694 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204d82:	cacfb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204d86 <fd_array_free>:
ffffffffc0204d86:	411c                	lw	a5,0(a0)
ffffffffc0204d88:	1141                	addi	sp,sp,-16
ffffffffc0204d8a:	e022                	sd	s0,0(sp)
ffffffffc0204d8c:	e406                	sd	ra,8(sp)
ffffffffc0204d8e:	4705                	li	a4,1
ffffffffc0204d90:	842a                	mv	s0,a0
ffffffffc0204d92:	04e78063          	beq	a5,a4,ffffffffc0204dd2 <fd_array_free+0x4c>
ffffffffc0204d96:	470d                	li	a4,3
ffffffffc0204d98:	04e79563          	bne	a5,a4,ffffffffc0204de2 <fd_array_free+0x5c>
ffffffffc0204d9c:	591c                	lw	a5,48(a0)
ffffffffc0204d9e:	c38d                	beqz	a5,ffffffffc0204dc0 <fd_array_free+0x3a>
ffffffffc0204da0:	00008697          	auipc	a3,0x8
ffffffffc0204da4:	2a068693          	addi	a3,a3,672 # ffffffffc020d040 <default_pmm_manager+0x880>
ffffffffc0204da8:	00007617          	auipc	a2,0x7
ffffffffc0204dac:	a5060613          	addi	a2,a2,-1456 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204db0:	04500593          	li	a1,69
ffffffffc0204db4:	00008517          	auipc	a0,0x8
ffffffffc0204db8:	27c50513          	addi	a0,a0,636 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204dbc:	c72fb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204dc0:	7408                	ld	a0,40(s0)
ffffffffc0204dc2:	394030ef          	jal	ra,ffffffffc0208156 <vfs_close>
ffffffffc0204dc6:	60a2                	ld	ra,8(sp)
ffffffffc0204dc8:	00042023          	sw	zero,0(s0)
ffffffffc0204dcc:	6402                	ld	s0,0(sp)
ffffffffc0204dce:	0141                	addi	sp,sp,16
ffffffffc0204dd0:	8082                	ret
ffffffffc0204dd2:	591c                	lw	a5,48(a0)
ffffffffc0204dd4:	f7f1                	bnez	a5,ffffffffc0204da0 <fd_array_free+0x1a>
ffffffffc0204dd6:	60a2                	ld	ra,8(sp)
ffffffffc0204dd8:	00042023          	sw	zero,0(s0)
ffffffffc0204ddc:	6402                	ld	s0,0(sp)
ffffffffc0204dde:	0141                	addi	sp,sp,16
ffffffffc0204de0:	8082                	ret
ffffffffc0204de2:	00008697          	auipc	a3,0x8
ffffffffc0204de6:	29668693          	addi	a3,a3,662 # ffffffffc020d078 <default_pmm_manager+0x8b8>
ffffffffc0204dea:	00007617          	auipc	a2,0x7
ffffffffc0204dee:	a0e60613          	addi	a2,a2,-1522 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204df2:	04400593          	li	a1,68
ffffffffc0204df6:	00008517          	auipc	a0,0x8
ffffffffc0204dfa:	23a50513          	addi	a0,a0,570 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204dfe:	c30fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204e02 <fd_array_release>:
ffffffffc0204e02:	4118                	lw	a4,0(a0)
ffffffffc0204e04:	1141                	addi	sp,sp,-16
ffffffffc0204e06:	e406                	sd	ra,8(sp)
ffffffffc0204e08:	4685                	li	a3,1
ffffffffc0204e0a:	3779                	addiw	a4,a4,-2
ffffffffc0204e0c:	04e6e063          	bltu	a3,a4,ffffffffc0204e4c <fd_array_release+0x4a>
ffffffffc0204e10:	5918                	lw	a4,48(a0)
ffffffffc0204e12:	00e05d63          	blez	a4,ffffffffc0204e2c <fd_array_release+0x2a>
ffffffffc0204e16:	fff7069b          	addiw	a3,a4,-1
ffffffffc0204e1a:	d914                	sw	a3,48(a0)
ffffffffc0204e1c:	c681                	beqz	a3,ffffffffc0204e24 <fd_array_release+0x22>
ffffffffc0204e1e:	60a2                	ld	ra,8(sp)
ffffffffc0204e20:	0141                	addi	sp,sp,16
ffffffffc0204e22:	8082                	ret
ffffffffc0204e24:	60a2                	ld	ra,8(sp)
ffffffffc0204e26:	0141                	addi	sp,sp,16
ffffffffc0204e28:	f5fff06f          	j	ffffffffc0204d86 <fd_array_free>
ffffffffc0204e2c:	00008697          	auipc	a3,0x8
ffffffffc0204e30:	2bc68693          	addi	a3,a3,700 # ffffffffc020d0e8 <default_pmm_manager+0x928>
ffffffffc0204e34:	00007617          	auipc	a2,0x7
ffffffffc0204e38:	9c460613          	addi	a2,a2,-1596 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204e3c:	05600593          	li	a1,86
ffffffffc0204e40:	00008517          	auipc	a0,0x8
ffffffffc0204e44:	1f050513          	addi	a0,a0,496 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204e48:	be6fb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204e4c:	00008697          	auipc	a3,0x8
ffffffffc0204e50:	26468693          	addi	a3,a3,612 # ffffffffc020d0b0 <default_pmm_manager+0x8f0>
ffffffffc0204e54:	00007617          	auipc	a2,0x7
ffffffffc0204e58:	9a460613          	addi	a2,a2,-1628 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204e5c:	05500593          	li	a1,85
ffffffffc0204e60:	00008517          	auipc	a0,0x8
ffffffffc0204e64:	1d050513          	addi	a0,a0,464 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204e68:	bc6fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204e6c <fd_array_open.part.0>:
ffffffffc0204e6c:	1141                	addi	sp,sp,-16
ffffffffc0204e6e:	00008697          	auipc	a3,0x8
ffffffffc0204e72:	29268693          	addi	a3,a3,658 # ffffffffc020d100 <default_pmm_manager+0x940>
ffffffffc0204e76:	00007617          	auipc	a2,0x7
ffffffffc0204e7a:	98260613          	addi	a2,a2,-1662 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204e7e:	05f00593          	li	a1,95
ffffffffc0204e82:	00008517          	auipc	a0,0x8
ffffffffc0204e86:	1ae50513          	addi	a0,a0,430 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204e8a:	e406                	sd	ra,8(sp)
ffffffffc0204e8c:	ba2fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204e90 <fd_array_init>:
ffffffffc0204e90:	4781                	li	a5,0
ffffffffc0204e92:	04800713          	li	a4,72
ffffffffc0204e96:	cd1c                	sw	a5,24(a0)
ffffffffc0204e98:	02052823          	sw	zero,48(a0)
ffffffffc0204e9c:	00052023          	sw	zero,0(a0)
ffffffffc0204ea0:	2785                	addiw	a5,a5,1
ffffffffc0204ea2:	03850513          	addi	a0,a0,56
ffffffffc0204ea6:	fee798e3          	bne	a5,a4,ffffffffc0204e96 <fd_array_init+0x6>
ffffffffc0204eaa:	8082                	ret

ffffffffc0204eac <fd_array_close>:
ffffffffc0204eac:	4118                	lw	a4,0(a0)
ffffffffc0204eae:	1141                	addi	sp,sp,-16
ffffffffc0204eb0:	e406                	sd	ra,8(sp)
ffffffffc0204eb2:	e022                	sd	s0,0(sp)
ffffffffc0204eb4:	4789                	li	a5,2
ffffffffc0204eb6:	04f71a63          	bne	a4,a5,ffffffffc0204f0a <fd_array_close+0x5e>
ffffffffc0204eba:	591c                	lw	a5,48(a0)
ffffffffc0204ebc:	842a                	mv	s0,a0
ffffffffc0204ebe:	02f05663          	blez	a5,ffffffffc0204eea <fd_array_close+0x3e>
ffffffffc0204ec2:	37fd                	addiw	a5,a5,-1
ffffffffc0204ec4:	470d                	li	a4,3
ffffffffc0204ec6:	c118                	sw	a4,0(a0)
ffffffffc0204ec8:	d91c                	sw	a5,48(a0)
ffffffffc0204eca:	0007871b          	sext.w	a4,a5
ffffffffc0204ece:	c709                	beqz	a4,ffffffffc0204ed8 <fd_array_close+0x2c>
ffffffffc0204ed0:	60a2                	ld	ra,8(sp)
ffffffffc0204ed2:	6402                	ld	s0,0(sp)
ffffffffc0204ed4:	0141                	addi	sp,sp,16
ffffffffc0204ed6:	8082                	ret
ffffffffc0204ed8:	7508                	ld	a0,40(a0)
ffffffffc0204eda:	27c030ef          	jal	ra,ffffffffc0208156 <vfs_close>
ffffffffc0204ede:	60a2                	ld	ra,8(sp)
ffffffffc0204ee0:	00042023          	sw	zero,0(s0)
ffffffffc0204ee4:	6402                	ld	s0,0(sp)
ffffffffc0204ee6:	0141                	addi	sp,sp,16
ffffffffc0204ee8:	8082                	ret
ffffffffc0204eea:	00008697          	auipc	a3,0x8
ffffffffc0204eee:	1fe68693          	addi	a3,a3,510 # ffffffffc020d0e8 <default_pmm_manager+0x928>
ffffffffc0204ef2:	00007617          	auipc	a2,0x7
ffffffffc0204ef6:	90660613          	addi	a2,a2,-1786 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204efa:	06800593          	li	a1,104
ffffffffc0204efe:	00008517          	auipc	a0,0x8
ffffffffc0204f02:	13250513          	addi	a0,a0,306 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204f06:	b28fb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204f0a:	00008697          	auipc	a3,0x8
ffffffffc0204f0e:	14e68693          	addi	a3,a3,334 # ffffffffc020d058 <default_pmm_manager+0x898>
ffffffffc0204f12:	00007617          	auipc	a2,0x7
ffffffffc0204f16:	8e660613          	addi	a2,a2,-1818 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204f1a:	06700593          	li	a1,103
ffffffffc0204f1e:	00008517          	auipc	a0,0x8
ffffffffc0204f22:	11250513          	addi	a0,a0,274 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204f26:	b08fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0204f2a <fd_array_dup>:
ffffffffc0204f2a:	7179                	addi	sp,sp,-48
ffffffffc0204f2c:	e84a                	sd	s2,16(sp)
ffffffffc0204f2e:	00052903          	lw	s2,0(a0)
ffffffffc0204f32:	f406                	sd	ra,40(sp)
ffffffffc0204f34:	f022                	sd	s0,32(sp)
ffffffffc0204f36:	ec26                	sd	s1,24(sp)
ffffffffc0204f38:	e44e                	sd	s3,8(sp)
ffffffffc0204f3a:	4785                	li	a5,1
ffffffffc0204f3c:	04f91663          	bne	s2,a5,ffffffffc0204f88 <fd_array_dup+0x5e>
ffffffffc0204f40:	0005a983          	lw	s3,0(a1)
ffffffffc0204f44:	4789                	li	a5,2
ffffffffc0204f46:	04f99163          	bne	s3,a5,ffffffffc0204f88 <fd_array_dup+0x5e>
ffffffffc0204f4a:	7584                	ld	s1,40(a1)
ffffffffc0204f4c:	699c                	ld	a5,16(a1)
ffffffffc0204f4e:	7194                	ld	a3,32(a1)
ffffffffc0204f50:	6598                	ld	a4,8(a1)
ffffffffc0204f52:	842a                	mv	s0,a0
ffffffffc0204f54:	e91c                	sd	a5,16(a0)
ffffffffc0204f56:	f114                	sd	a3,32(a0)
ffffffffc0204f58:	e518                	sd	a4,8(a0)
ffffffffc0204f5a:	8526                	mv	a0,s1
ffffffffc0204f5c:	294030ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0204f60:	8526                	mv	a0,s1
ffffffffc0204f62:	29a030ef          	jal	ra,ffffffffc02081fc <inode_open_inc>
ffffffffc0204f66:	401c                	lw	a5,0(s0)
ffffffffc0204f68:	f404                	sd	s1,40(s0)
ffffffffc0204f6a:	03279f63          	bne	a5,s2,ffffffffc0204fa8 <fd_array_dup+0x7e>
ffffffffc0204f6e:	cc8d                	beqz	s1,ffffffffc0204fa8 <fd_array_dup+0x7e>
ffffffffc0204f70:	581c                	lw	a5,48(s0)
ffffffffc0204f72:	01342023          	sw	s3,0(s0)
ffffffffc0204f76:	70a2                	ld	ra,40(sp)
ffffffffc0204f78:	2785                	addiw	a5,a5,1
ffffffffc0204f7a:	d81c                	sw	a5,48(s0)
ffffffffc0204f7c:	7402                	ld	s0,32(sp)
ffffffffc0204f7e:	64e2                	ld	s1,24(sp)
ffffffffc0204f80:	6942                	ld	s2,16(sp)
ffffffffc0204f82:	69a2                	ld	s3,8(sp)
ffffffffc0204f84:	6145                	addi	sp,sp,48
ffffffffc0204f86:	8082                	ret
ffffffffc0204f88:	00008697          	auipc	a3,0x8
ffffffffc0204f8c:	1a868693          	addi	a3,a3,424 # ffffffffc020d130 <default_pmm_manager+0x970>
ffffffffc0204f90:	00007617          	auipc	a2,0x7
ffffffffc0204f94:	86860613          	addi	a2,a2,-1944 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0204f98:	07300593          	li	a1,115
ffffffffc0204f9c:	00008517          	auipc	a0,0x8
ffffffffc0204fa0:	09450513          	addi	a0,a0,148 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0204fa4:	a8afb0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0204fa8:	ec5ff0ef          	jal	ra,ffffffffc0204e6c <fd_array_open.part.0>

ffffffffc0204fac <file_testfd>:
ffffffffc0204fac:	04700793          	li	a5,71
ffffffffc0204fb0:	04a7e263          	bltu	a5,a0,ffffffffc0204ff4 <file_testfd+0x48>
ffffffffc0204fb4:	00092797          	auipc	a5,0x92
ffffffffc0204fb8:	90c7b783          	ld	a5,-1780(a5) # ffffffffc02968c0 <current>
ffffffffc0204fbc:	1487b783          	ld	a5,328(a5)
ffffffffc0204fc0:	cf85                	beqz	a5,ffffffffc0204ff8 <file_testfd+0x4c>
ffffffffc0204fc2:	4b98                	lw	a4,16(a5)
ffffffffc0204fc4:	02e05a63          	blez	a4,ffffffffc0204ff8 <file_testfd+0x4c>
ffffffffc0204fc8:	6798                	ld	a4,8(a5)
ffffffffc0204fca:	00351793          	slli	a5,a0,0x3
ffffffffc0204fce:	8f89                	sub	a5,a5,a0
ffffffffc0204fd0:	078e                	slli	a5,a5,0x3
ffffffffc0204fd2:	97ba                	add	a5,a5,a4
ffffffffc0204fd4:	4394                	lw	a3,0(a5)
ffffffffc0204fd6:	4709                	li	a4,2
ffffffffc0204fd8:	00e69e63          	bne	a3,a4,ffffffffc0204ff4 <file_testfd+0x48>
ffffffffc0204fdc:	4f98                	lw	a4,24(a5)
ffffffffc0204fde:	00a71b63          	bne	a4,a0,ffffffffc0204ff4 <file_testfd+0x48>
ffffffffc0204fe2:	c199                	beqz	a1,ffffffffc0204fe8 <file_testfd+0x3c>
ffffffffc0204fe4:	6788                	ld	a0,8(a5)
ffffffffc0204fe6:	c901                	beqz	a0,ffffffffc0204ff6 <file_testfd+0x4a>
ffffffffc0204fe8:	4505                	li	a0,1
ffffffffc0204fea:	c611                	beqz	a2,ffffffffc0204ff6 <file_testfd+0x4a>
ffffffffc0204fec:	6b88                	ld	a0,16(a5)
ffffffffc0204fee:	00a03533          	snez	a0,a0
ffffffffc0204ff2:	8082                	ret
ffffffffc0204ff4:	4501                	li	a0,0
ffffffffc0204ff6:	8082                	ret
ffffffffc0204ff8:	1141                	addi	sp,sp,-16
ffffffffc0204ffa:	e406                	sd	ra,8(sp)
ffffffffc0204ffc:	cd5ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>

ffffffffc0205000 <file_open>:
ffffffffc0205000:	711d                	addi	sp,sp,-96
ffffffffc0205002:	ec86                	sd	ra,88(sp)
ffffffffc0205004:	e8a2                	sd	s0,80(sp)
ffffffffc0205006:	e4a6                	sd	s1,72(sp)
ffffffffc0205008:	e0ca                	sd	s2,64(sp)
ffffffffc020500a:	fc4e                	sd	s3,56(sp)
ffffffffc020500c:	f852                	sd	s4,48(sp)
ffffffffc020500e:	0035f793          	andi	a5,a1,3
ffffffffc0205012:	470d                	li	a4,3
ffffffffc0205014:	0ce78163          	beq	a5,a4,ffffffffc02050d6 <file_open+0xd6>
ffffffffc0205018:	078e                	slli	a5,a5,0x3
ffffffffc020501a:	00008717          	auipc	a4,0x8
ffffffffc020501e:	38670713          	addi	a4,a4,902 # ffffffffc020d3a0 <CSWTCH.79>
ffffffffc0205022:	892a                	mv	s2,a0
ffffffffc0205024:	00008697          	auipc	a3,0x8
ffffffffc0205028:	36468693          	addi	a3,a3,868 # ffffffffc020d388 <CSWTCH.78>
ffffffffc020502c:	755d                	lui	a0,0xffff7
ffffffffc020502e:	96be                	add	a3,a3,a5
ffffffffc0205030:	84ae                	mv	s1,a1
ffffffffc0205032:	97ba                	add	a5,a5,a4
ffffffffc0205034:	858a                	mv	a1,sp
ffffffffc0205036:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020503a:	0006ba03          	ld	s4,0(a3)
ffffffffc020503e:	0007b983          	ld	s3,0(a5)
ffffffffc0205042:	cb1ff0ef          	jal	ra,ffffffffc0204cf2 <fd_array_alloc>
ffffffffc0205046:	842a                	mv	s0,a0
ffffffffc0205048:	c911                	beqz	a0,ffffffffc020505c <file_open+0x5c>
ffffffffc020504a:	60e6                	ld	ra,88(sp)
ffffffffc020504c:	8522                	mv	a0,s0
ffffffffc020504e:	6446                	ld	s0,80(sp)
ffffffffc0205050:	64a6                	ld	s1,72(sp)
ffffffffc0205052:	6906                	ld	s2,64(sp)
ffffffffc0205054:	79e2                	ld	s3,56(sp)
ffffffffc0205056:	7a42                	ld	s4,48(sp)
ffffffffc0205058:	6125                	addi	sp,sp,96
ffffffffc020505a:	8082                	ret
ffffffffc020505c:	0030                	addi	a2,sp,8
ffffffffc020505e:	85a6                	mv	a1,s1
ffffffffc0205060:	854a                	mv	a0,s2
ffffffffc0205062:	74f020ef          	jal	ra,ffffffffc0207fb0 <vfs_open>
ffffffffc0205066:	842a                	mv	s0,a0
ffffffffc0205068:	e13d                	bnez	a0,ffffffffc02050ce <file_open+0xce>
ffffffffc020506a:	6782                	ld	a5,0(sp)
ffffffffc020506c:	0204f493          	andi	s1,s1,32
ffffffffc0205070:	6422                	ld	s0,8(sp)
ffffffffc0205072:	0207b023          	sd	zero,32(a5)
ffffffffc0205076:	c885                	beqz	s1,ffffffffc02050a6 <file_open+0xa6>
ffffffffc0205078:	c03d                	beqz	s0,ffffffffc02050de <file_open+0xde>
ffffffffc020507a:	783c                	ld	a5,112(s0)
ffffffffc020507c:	c3ad                	beqz	a5,ffffffffc02050de <file_open+0xde>
ffffffffc020507e:	779c                	ld	a5,40(a5)
ffffffffc0205080:	cfb9                	beqz	a5,ffffffffc02050de <file_open+0xde>
ffffffffc0205082:	8522                	mv	a0,s0
ffffffffc0205084:	00008597          	auipc	a1,0x8
ffffffffc0205088:	13458593          	addi	a1,a1,308 # ffffffffc020d1b8 <default_pmm_manager+0x9f8>
ffffffffc020508c:	17c030ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0205090:	783c                	ld	a5,112(s0)
ffffffffc0205092:	6522                	ld	a0,8(sp)
ffffffffc0205094:	080c                	addi	a1,sp,16
ffffffffc0205096:	779c                	ld	a5,40(a5)
ffffffffc0205098:	9782                	jalr	a5
ffffffffc020509a:	842a                	mv	s0,a0
ffffffffc020509c:	e515                	bnez	a0,ffffffffc02050c8 <file_open+0xc8>
ffffffffc020509e:	6782                	ld	a5,0(sp)
ffffffffc02050a0:	7722                	ld	a4,40(sp)
ffffffffc02050a2:	6422                	ld	s0,8(sp)
ffffffffc02050a4:	f398                	sd	a4,32(a5)
ffffffffc02050a6:	4394                	lw	a3,0(a5)
ffffffffc02050a8:	f780                	sd	s0,40(a5)
ffffffffc02050aa:	0147b423          	sd	s4,8(a5)
ffffffffc02050ae:	0137b823          	sd	s3,16(a5)
ffffffffc02050b2:	4705                	li	a4,1
ffffffffc02050b4:	02e69363          	bne	a3,a4,ffffffffc02050da <file_open+0xda>
ffffffffc02050b8:	c00d                	beqz	s0,ffffffffc02050da <file_open+0xda>
ffffffffc02050ba:	5b98                	lw	a4,48(a5)
ffffffffc02050bc:	4689                	li	a3,2
ffffffffc02050be:	4f80                	lw	s0,24(a5)
ffffffffc02050c0:	2705                	addiw	a4,a4,1
ffffffffc02050c2:	c394                	sw	a3,0(a5)
ffffffffc02050c4:	db98                	sw	a4,48(a5)
ffffffffc02050c6:	b751                	j	ffffffffc020504a <file_open+0x4a>
ffffffffc02050c8:	6522                	ld	a0,8(sp)
ffffffffc02050ca:	08c030ef          	jal	ra,ffffffffc0208156 <vfs_close>
ffffffffc02050ce:	6502                	ld	a0,0(sp)
ffffffffc02050d0:	cb7ff0ef          	jal	ra,ffffffffc0204d86 <fd_array_free>
ffffffffc02050d4:	bf9d                	j	ffffffffc020504a <file_open+0x4a>
ffffffffc02050d6:	5475                	li	s0,-3
ffffffffc02050d8:	bf8d                	j	ffffffffc020504a <file_open+0x4a>
ffffffffc02050da:	d93ff0ef          	jal	ra,ffffffffc0204e6c <fd_array_open.part.0>
ffffffffc02050de:	00008697          	auipc	a3,0x8
ffffffffc02050e2:	08a68693          	addi	a3,a3,138 # ffffffffc020d168 <default_pmm_manager+0x9a8>
ffffffffc02050e6:	00006617          	auipc	a2,0x6
ffffffffc02050ea:	71260613          	addi	a2,a2,1810 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02050ee:	0b500593          	li	a1,181
ffffffffc02050f2:	00008517          	auipc	a0,0x8
ffffffffc02050f6:	f3e50513          	addi	a0,a0,-194 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc02050fa:	934fb0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02050fe <file_close>:
ffffffffc02050fe:	04700713          	li	a4,71
ffffffffc0205102:	04a76563          	bltu	a4,a0,ffffffffc020514c <file_close+0x4e>
ffffffffc0205106:	00091717          	auipc	a4,0x91
ffffffffc020510a:	7ba73703          	ld	a4,1978(a4) # ffffffffc02968c0 <current>
ffffffffc020510e:	14873703          	ld	a4,328(a4)
ffffffffc0205112:	1141                	addi	sp,sp,-16
ffffffffc0205114:	e406                	sd	ra,8(sp)
ffffffffc0205116:	cf0d                	beqz	a4,ffffffffc0205150 <file_close+0x52>
ffffffffc0205118:	4b14                	lw	a3,16(a4)
ffffffffc020511a:	02d05b63          	blez	a3,ffffffffc0205150 <file_close+0x52>
ffffffffc020511e:	6718                	ld	a4,8(a4)
ffffffffc0205120:	87aa                	mv	a5,a0
ffffffffc0205122:	050e                	slli	a0,a0,0x3
ffffffffc0205124:	8d1d                	sub	a0,a0,a5
ffffffffc0205126:	050e                	slli	a0,a0,0x3
ffffffffc0205128:	953a                	add	a0,a0,a4
ffffffffc020512a:	4114                	lw	a3,0(a0)
ffffffffc020512c:	4709                	li	a4,2
ffffffffc020512e:	00e69b63          	bne	a3,a4,ffffffffc0205144 <file_close+0x46>
ffffffffc0205132:	4d18                	lw	a4,24(a0)
ffffffffc0205134:	00f71863          	bne	a4,a5,ffffffffc0205144 <file_close+0x46>
ffffffffc0205138:	d75ff0ef          	jal	ra,ffffffffc0204eac <fd_array_close>
ffffffffc020513c:	60a2                	ld	ra,8(sp)
ffffffffc020513e:	4501                	li	a0,0
ffffffffc0205140:	0141                	addi	sp,sp,16
ffffffffc0205142:	8082                	ret
ffffffffc0205144:	60a2                	ld	ra,8(sp)
ffffffffc0205146:	5575                	li	a0,-3
ffffffffc0205148:	0141                	addi	sp,sp,16
ffffffffc020514a:	8082                	ret
ffffffffc020514c:	5575                	li	a0,-3
ffffffffc020514e:	8082                	ret
ffffffffc0205150:	b81ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>

ffffffffc0205154 <file_read>:
ffffffffc0205154:	715d                	addi	sp,sp,-80
ffffffffc0205156:	e486                	sd	ra,72(sp)
ffffffffc0205158:	e0a2                	sd	s0,64(sp)
ffffffffc020515a:	fc26                	sd	s1,56(sp)
ffffffffc020515c:	f84a                	sd	s2,48(sp)
ffffffffc020515e:	f44e                	sd	s3,40(sp)
ffffffffc0205160:	f052                	sd	s4,32(sp)
ffffffffc0205162:	0006b023          	sd	zero,0(a3)
ffffffffc0205166:	04700793          	li	a5,71
ffffffffc020516a:	0aa7e463          	bltu	a5,a0,ffffffffc0205212 <file_read+0xbe>
ffffffffc020516e:	00091797          	auipc	a5,0x91
ffffffffc0205172:	7527b783          	ld	a5,1874(a5) # ffffffffc02968c0 <current>
ffffffffc0205176:	1487b783          	ld	a5,328(a5)
ffffffffc020517a:	cfd1                	beqz	a5,ffffffffc0205216 <file_read+0xc2>
ffffffffc020517c:	4b98                	lw	a4,16(a5)
ffffffffc020517e:	08e05c63          	blez	a4,ffffffffc0205216 <file_read+0xc2>
ffffffffc0205182:	6780                	ld	s0,8(a5)
ffffffffc0205184:	00351793          	slli	a5,a0,0x3
ffffffffc0205188:	8f89                	sub	a5,a5,a0
ffffffffc020518a:	078e                	slli	a5,a5,0x3
ffffffffc020518c:	943e                	add	s0,s0,a5
ffffffffc020518e:	00042983          	lw	s3,0(s0)
ffffffffc0205192:	4789                	li	a5,2
ffffffffc0205194:	06f99f63          	bne	s3,a5,ffffffffc0205212 <file_read+0xbe>
ffffffffc0205198:	4c1c                	lw	a5,24(s0)
ffffffffc020519a:	06a79c63          	bne	a5,a0,ffffffffc0205212 <file_read+0xbe>
ffffffffc020519e:	641c                	ld	a5,8(s0)
ffffffffc02051a0:	cbad                	beqz	a5,ffffffffc0205212 <file_read+0xbe>
ffffffffc02051a2:	581c                	lw	a5,48(s0)
ffffffffc02051a4:	8a36                	mv	s4,a3
ffffffffc02051a6:	7014                	ld	a3,32(s0)
ffffffffc02051a8:	2785                	addiw	a5,a5,1
ffffffffc02051aa:	850a                	mv	a0,sp
ffffffffc02051ac:	d81c                	sw	a5,48(s0)
ffffffffc02051ae:	57e000ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc02051b2:	02843903          	ld	s2,40(s0)
ffffffffc02051b6:	84aa                	mv	s1,a0
ffffffffc02051b8:	06090163          	beqz	s2,ffffffffc020521a <file_read+0xc6>
ffffffffc02051bc:	07093783          	ld	a5,112(s2)
ffffffffc02051c0:	cfa9                	beqz	a5,ffffffffc020521a <file_read+0xc6>
ffffffffc02051c2:	6f9c                	ld	a5,24(a5)
ffffffffc02051c4:	cbb9                	beqz	a5,ffffffffc020521a <file_read+0xc6>
ffffffffc02051c6:	00008597          	auipc	a1,0x8
ffffffffc02051ca:	04a58593          	addi	a1,a1,74 # ffffffffc020d210 <default_pmm_manager+0xa50>
ffffffffc02051ce:	854a                	mv	a0,s2
ffffffffc02051d0:	038030ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02051d4:	07093783          	ld	a5,112(s2)
ffffffffc02051d8:	7408                	ld	a0,40(s0)
ffffffffc02051da:	85a6                	mv	a1,s1
ffffffffc02051dc:	6f9c                	ld	a5,24(a5)
ffffffffc02051de:	9782                	jalr	a5
ffffffffc02051e0:	689c                	ld	a5,16(s1)
ffffffffc02051e2:	6c94                	ld	a3,24(s1)
ffffffffc02051e4:	4018                	lw	a4,0(s0)
ffffffffc02051e6:	84aa                	mv	s1,a0
ffffffffc02051e8:	8f95                	sub	a5,a5,a3
ffffffffc02051ea:	03370063          	beq	a4,s3,ffffffffc020520a <file_read+0xb6>
ffffffffc02051ee:	00fa3023          	sd	a5,0(s4)
ffffffffc02051f2:	8522                	mv	a0,s0
ffffffffc02051f4:	c0fff0ef          	jal	ra,ffffffffc0204e02 <fd_array_release>
ffffffffc02051f8:	60a6                	ld	ra,72(sp)
ffffffffc02051fa:	6406                	ld	s0,64(sp)
ffffffffc02051fc:	7942                	ld	s2,48(sp)
ffffffffc02051fe:	79a2                	ld	s3,40(sp)
ffffffffc0205200:	7a02                	ld	s4,32(sp)
ffffffffc0205202:	8526                	mv	a0,s1
ffffffffc0205204:	74e2                	ld	s1,56(sp)
ffffffffc0205206:	6161                	addi	sp,sp,80
ffffffffc0205208:	8082                	ret
ffffffffc020520a:	7018                	ld	a4,32(s0)
ffffffffc020520c:	973e                	add	a4,a4,a5
ffffffffc020520e:	f018                	sd	a4,32(s0)
ffffffffc0205210:	bff9                	j	ffffffffc02051ee <file_read+0x9a>
ffffffffc0205212:	54f5                	li	s1,-3
ffffffffc0205214:	b7d5                	j	ffffffffc02051f8 <file_read+0xa4>
ffffffffc0205216:	abbff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>
ffffffffc020521a:	00008697          	auipc	a3,0x8
ffffffffc020521e:	fa668693          	addi	a3,a3,-90 # ffffffffc020d1c0 <default_pmm_manager+0xa00>
ffffffffc0205222:	00006617          	auipc	a2,0x6
ffffffffc0205226:	5d660613          	addi	a2,a2,1494 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020522a:	0de00593          	li	a1,222
ffffffffc020522e:	00008517          	auipc	a0,0x8
ffffffffc0205232:	e0250513          	addi	a0,a0,-510 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc0205236:	ff9fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020523a <file_write>:
ffffffffc020523a:	715d                	addi	sp,sp,-80
ffffffffc020523c:	e486                	sd	ra,72(sp)
ffffffffc020523e:	e0a2                	sd	s0,64(sp)
ffffffffc0205240:	fc26                	sd	s1,56(sp)
ffffffffc0205242:	f84a                	sd	s2,48(sp)
ffffffffc0205244:	f44e                	sd	s3,40(sp)
ffffffffc0205246:	f052                	sd	s4,32(sp)
ffffffffc0205248:	0006b023          	sd	zero,0(a3)
ffffffffc020524c:	04700793          	li	a5,71
ffffffffc0205250:	0aa7e463          	bltu	a5,a0,ffffffffc02052f8 <file_write+0xbe>
ffffffffc0205254:	00091797          	auipc	a5,0x91
ffffffffc0205258:	66c7b783          	ld	a5,1644(a5) # ffffffffc02968c0 <current>
ffffffffc020525c:	1487b783          	ld	a5,328(a5)
ffffffffc0205260:	cfd1                	beqz	a5,ffffffffc02052fc <file_write+0xc2>
ffffffffc0205262:	4b98                	lw	a4,16(a5)
ffffffffc0205264:	08e05c63          	blez	a4,ffffffffc02052fc <file_write+0xc2>
ffffffffc0205268:	6780                	ld	s0,8(a5)
ffffffffc020526a:	00351793          	slli	a5,a0,0x3
ffffffffc020526e:	8f89                	sub	a5,a5,a0
ffffffffc0205270:	078e                	slli	a5,a5,0x3
ffffffffc0205272:	943e                	add	s0,s0,a5
ffffffffc0205274:	00042983          	lw	s3,0(s0)
ffffffffc0205278:	4789                	li	a5,2
ffffffffc020527a:	06f99f63          	bne	s3,a5,ffffffffc02052f8 <file_write+0xbe>
ffffffffc020527e:	4c1c                	lw	a5,24(s0)
ffffffffc0205280:	06a79c63          	bne	a5,a0,ffffffffc02052f8 <file_write+0xbe>
ffffffffc0205284:	681c                	ld	a5,16(s0)
ffffffffc0205286:	cbad                	beqz	a5,ffffffffc02052f8 <file_write+0xbe>
ffffffffc0205288:	581c                	lw	a5,48(s0)
ffffffffc020528a:	8a36                	mv	s4,a3
ffffffffc020528c:	7014                	ld	a3,32(s0)
ffffffffc020528e:	2785                	addiw	a5,a5,1
ffffffffc0205290:	850a                	mv	a0,sp
ffffffffc0205292:	d81c                	sw	a5,48(s0)
ffffffffc0205294:	498000ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc0205298:	02843903          	ld	s2,40(s0)
ffffffffc020529c:	84aa                	mv	s1,a0
ffffffffc020529e:	06090163          	beqz	s2,ffffffffc0205300 <file_write+0xc6>
ffffffffc02052a2:	07093783          	ld	a5,112(s2)
ffffffffc02052a6:	cfa9                	beqz	a5,ffffffffc0205300 <file_write+0xc6>
ffffffffc02052a8:	739c                	ld	a5,32(a5)
ffffffffc02052aa:	cbb9                	beqz	a5,ffffffffc0205300 <file_write+0xc6>
ffffffffc02052ac:	00008597          	auipc	a1,0x8
ffffffffc02052b0:	fbc58593          	addi	a1,a1,-68 # ffffffffc020d268 <default_pmm_manager+0xaa8>
ffffffffc02052b4:	854a                	mv	a0,s2
ffffffffc02052b6:	753020ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02052ba:	07093783          	ld	a5,112(s2)
ffffffffc02052be:	7408                	ld	a0,40(s0)
ffffffffc02052c0:	85a6                	mv	a1,s1
ffffffffc02052c2:	739c                	ld	a5,32(a5)
ffffffffc02052c4:	9782                	jalr	a5
ffffffffc02052c6:	689c                	ld	a5,16(s1)
ffffffffc02052c8:	6c94                	ld	a3,24(s1)
ffffffffc02052ca:	4018                	lw	a4,0(s0)
ffffffffc02052cc:	84aa                	mv	s1,a0
ffffffffc02052ce:	8f95                	sub	a5,a5,a3
ffffffffc02052d0:	03370063          	beq	a4,s3,ffffffffc02052f0 <file_write+0xb6>
ffffffffc02052d4:	00fa3023          	sd	a5,0(s4)
ffffffffc02052d8:	8522                	mv	a0,s0
ffffffffc02052da:	b29ff0ef          	jal	ra,ffffffffc0204e02 <fd_array_release>
ffffffffc02052de:	60a6                	ld	ra,72(sp)
ffffffffc02052e0:	6406                	ld	s0,64(sp)
ffffffffc02052e2:	7942                	ld	s2,48(sp)
ffffffffc02052e4:	79a2                	ld	s3,40(sp)
ffffffffc02052e6:	7a02                	ld	s4,32(sp)
ffffffffc02052e8:	8526                	mv	a0,s1
ffffffffc02052ea:	74e2                	ld	s1,56(sp)
ffffffffc02052ec:	6161                	addi	sp,sp,80
ffffffffc02052ee:	8082                	ret
ffffffffc02052f0:	7018                	ld	a4,32(s0)
ffffffffc02052f2:	973e                	add	a4,a4,a5
ffffffffc02052f4:	f018                	sd	a4,32(s0)
ffffffffc02052f6:	bff9                	j	ffffffffc02052d4 <file_write+0x9a>
ffffffffc02052f8:	54f5                	li	s1,-3
ffffffffc02052fa:	b7d5                	j	ffffffffc02052de <file_write+0xa4>
ffffffffc02052fc:	9d5ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>
ffffffffc0205300:	00008697          	auipc	a3,0x8
ffffffffc0205304:	f1868693          	addi	a3,a3,-232 # ffffffffc020d218 <default_pmm_manager+0xa58>
ffffffffc0205308:	00006617          	auipc	a2,0x6
ffffffffc020530c:	4f060613          	addi	a2,a2,1264 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0205310:	0f800593          	li	a1,248
ffffffffc0205314:	00008517          	auipc	a0,0x8
ffffffffc0205318:	d1c50513          	addi	a0,a0,-740 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc020531c:	f13fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0205320 <file_seek>:
ffffffffc0205320:	7139                	addi	sp,sp,-64
ffffffffc0205322:	fc06                	sd	ra,56(sp)
ffffffffc0205324:	f822                	sd	s0,48(sp)
ffffffffc0205326:	f426                	sd	s1,40(sp)
ffffffffc0205328:	f04a                	sd	s2,32(sp)
ffffffffc020532a:	04700793          	li	a5,71
ffffffffc020532e:	08a7e863          	bltu	a5,a0,ffffffffc02053be <file_seek+0x9e>
ffffffffc0205332:	00091797          	auipc	a5,0x91
ffffffffc0205336:	58e7b783          	ld	a5,1422(a5) # ffffffffc02968c0 <current>
ffffffffc020533a:	1487b783          	ld	a5,328(a5)
ffffffffc020533e:	cfdd                	beqz	a5,ffffffffc02053fc <file_seek+0xdc>
ffffffffc0205340:	4b98                	lw	a4,16(a5)
ffffffffc0205342:	0ae05d63          	blez	a4,ffffffffc02053fc <file_seek+0xdc>
ffffffffc0205346:	6780                	ld	s0,8(a5)
ffffffffc0205348:	00351793          	slli	a5,a0,0x3
ffffffffc020534c:	8f89                	sub	a5,a5,a0
ffffffffc020534e:	078e                	slli	a5,a5,0x3
ffffffffc0205350:	943e                	add	s0,s0,a5
ffffffffc0205352:	4018                	lw	a4,0(s0)
ffffffffc0205354:	4789                	li	a5,2
ffffffffc0205356:	06f71463          	bne	a4,a5,ffffffffc02053be <file_seek+0x9e>
ffffffffc020535a:	4c1c                	lw	a5,24(s0)
ffffffffc020535c:	06a79163          	bne	a5,a0,ffffffffc02053be <file_seek+0x9e>
ffffffffc0205360:	581c                	lw	a5,48(s0)
ffffffffc0205362:	4685                	li	a3,1
ffffffffc0205364:	892e                	mv	s2,a1
ffffffffc0205366:	2785                	addiw	a5,a5,1
ffffffffc0205368:	d81c                	sw	a5,48(s0)
ffffffffc020536a:	02d60063          	beq	a2,a3,ffffffffc020538a <file_seek+0x6a>
ffffffffc020536e:	06e60063          	beq	a2,a4,ffffffffc02053ce <file_seek+0xae>
ffffffffc0205372:	54f5                	li	s1,-3
ffffffffc0205374:	ce11                	beqz	a2,ffffffffc0205390 <file_seek+0x70>
ffffffffc0205376:	8522                	mv	a0,s0
ffffffffc0205378:	a8bff0ef          	jal	ra,ffffffffc0204e02 <fd_array_release>
ffffffffc020537c:	70e2                	ld	ra,56(sp)
ffffffffc020537e:	7442                	ld	s0,48(sp)
ffffffffc0205380:	7902                	ld	s2,32(sp)
ffffffffc0205382:	8526                	mv	a0,s1
ffffffffc0205384:	74a2                	ld	s1,40(sp)
ffffffffc0205386:	6121                	addi	sp,sp,64
ffffffffc0205388:	8082                	ret
ffffffffc020538a:	701c                	ld	a5,32(s0)
ffffffffc020538c:	00f58933          	add	s2,a1,a5
ffffffffc0205390:	7404                	ld	s1,40(s0)
ffffffffc0205392:	c4bd                	beqz	s1,ffffffffc0205400 <file_seek+0xe0>
ffffffffc0205394:	78bc                	ld	a5,112(s1)
ffffffffc0205396:	c7ad                	beqz	a5,ffffffffc0205400 <file_seek+0xe0>
ffffffffc0205398:	6fbc                	ld	a5,88(a5)
ffffffffc020539a:	c3bd                	beqz	a5,ffffffffc0205400 <file_seek+0xe0>
ffffffffc020539c:	8526                	mv	a0,s1
ffffffffc020539e:	00008597          	auipc	a1,0x8
ffffffffc02053a2:	f2258593          	addi	a1,a1,-222 # ffffffffc020d2c0 <default_pmm_manager+0xb00>
ffffffffc02053a6:	663020ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02053aa:	78bc                	ld	a5,112(s1)
ffffffffc02053ac:	7408                	ld	a0,40(s0)
ffffffffc02053ae:	85ca                	mv	a1,s2
ffffffffc02053b0:	6fbc                	ld	a5,88(a5)
ffffffffc02053b2:	9782                	jalr	a5
ffffffffc02053b4:	84aa                	mv	s1,a0
ffffffffc02053b6:	f161                	bnez	a0,ffffffffc0205376 <file_seek+0x56>
ffffffffc02053b8:	03243023          	sd	s2,32(s0)
ffffffffc02053bc:	bf6d                	j	ffffffffc0205376 <file_seek+0x56>
ffffffffc02053be:	70e2                	ld	ra,56(sp)
ffffffffc02053c0:	7442                	ld	s0,48(sp)
ffffffffc02053c2:	54f5                	li	s1,-3
ffffffffc02053c4:	7902                	ld	s2,32(sp)
ffffffffc02053c6:	8526                	mv	a0,s1
ffffffffc02053c8:	74a2                	ld	s1,40(sp)
ffffffffc02053ca:	6121                	addi	sp,sp,64
ffffffffc02053cc:	8082                	ret
ffffffffc02053ce:	7404                	ld	s1,40(s0)
ffffffffc02053d0:	c8a1                	beqz	s1,ffffffffc0205420 <file_seek+0x100>
ffffffffc02053d2:	78bc                	ld	a5,112(s1)
ffffffffc02053d4:	c7b1                	beqz	a5,ffffffffc0205420 <file_seek+0x100>
ffffffffc02053d6:	779c                	ld	a5,40(a5)
ffffffffc02053d8:	c7a1                	beqz	a5,ffffffffc0205420 <file_seek+0x100>
ffffffffc02053da:	8526                	mv	a0,s1
ffffffffc02053dc:	00008597          	auipc	a1,0x8
ffffffffc02053e0:	ddc58593          	addi	a1,a1,-548 # ffffffffc020d1b8 <default_pmm_manager+0x9f8>
ffffffffc02053e4:	625020ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02053e8:	78bc                	ld	a5,112(s1)
ffffffffc02053ea:	7408                	ld	a0,40(s0)
ffffffffc02053ec:	858a                	mv	a1,sp
ffffffffc02053ee:	779c                	ld	a5,40(a5)
ffffffffc02053f0:	9782                	jalr	a5
ffffffffc02053f2:	84aa                	mv	s1,a0
ffffffffc02053f4:	f149                	bnez	a0,ffffffffc0205376 <file_seek+0x56>
ffffffffc02053f6:	67e2                	ld	a5,24(sp)
ffffffffc02053f8:	993e                	add	s2,s2,a5
ffffffffc02053fa:	bf59                	j	ffffffffc0205390 <file_seek+0x70>
ffffffffc02053fc:	8d5ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>
ffffffffc0205400:	00008697          	auipc	a3,0x8
ffffffffc0205404:	e7068693          	addi	a3,a3,-400 # ffffffffc020d270 <default_pmm_manager+0xab0>
ffffffffc0205408:	00006617          	auipc	a2,0x6
ffffffffc020540c:	3f060613          	addi	a2,a2,1008 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0205410:	11a00593          	li	a1,282
ffffffffc0205414:	00008517          	auipc	a0,0x8
ffffffffc0205418:	c1c50513          	addi	a0,a0,-996 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc020541c:	e13fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0205420:	00008697          	auipc	a3,0x8
ffffffffc0205424:	d4868693          	addi	a3,a3,-696 # ffffffffc020d168 <default_pmm_manager+0x9a8>
ffffffffc0205428:	00006617          	auipc	a2,0x6
ffffffffc020542c:	3d060613          	addi	a2,a2,976 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0205430:	11200593          	li	a1,274
ffffffffc0205434:	00008517          	auipc	a0,0x8
ffffffffc0205438:	bfc50513          	addi	a0,a0,-1028 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc020543c:	df3fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0205440 <file_fstat>:
ffffffffc0205440:	1101                	addi	sp,sp,-32
ffffffffc0205442:	ec06                	sd	ra,24(sp)
ffffffffc0205444:	e822                	sd	s0,16(sp)
ffffffffc0205446:	e426                	sd	s1,8(sp)
ffffffffc0205448:	e04a                	sd	s2,0(sp)
ffffffffc020544a:	04700793          	li	a5,71
ffffffffc020544e:	06a7ef63          	bltu	a5,a0,ffffffffc02054cc <file_fstat+0x8c>
ffffffffc0205452:	00091797          	auipc	a5,0x91
ffffffffc0205456:	46e7b783          	ld	a5,1134(a5) # ffffffffc02968c0 <current>
ffffffffc020545a:	1487b783          	ld	a5,328(a5)
ffffffffc020545e:	cfd9                	beqz	a5,ffffffffc02054fc <file_fstat+0xbc>
ffffffffc0205460:	4b98                	lw	a4,16(a5)
ffffffffc0205462:	08e05d63          	blez	a4,ffffffffc02054fc <file_fstat+0xbc>
ffffffffc0205466:	6780                	ld	s0,8(a5)
ffffffffc0205468:	00351793          	slli	a5,a0,0x3
ffffffffc020546c:	8f89                	sub	a5,a5,a0
ffffffffc020546e:	078e                	slli	a5,a5,0x3
ffffffffc0205470:	943e                	add	s0,s0,a5
ffffffffc0205472:	4018                	lw	a4,0(s0)
ffffffffc0205474:	4789                	li	a5,2
ffffffffc0205476:	04f71b63          	bne	a4,a5,ffffffffc02054cc <file_fstat+0x8c>
ffffffffc020547a:	4c1c                	lw	a5,24(s0)
ffffffffc020547c:	04a79863          	bne	a5,a0,ffffffffc02054cc <file_fstat+0x8c>
ffffffffc0205480:	581c                	lw	a5,48(s0)
ffffffffc0205482:	02843903          	ld	s2,40(s0)
ffffffffc0205486:	2785                	addiw	a5,a5,1
ffffffffc0205488:	d81c                	sw	a5,48(s0)
ffffffffc020548a:	04090963          	beqz	s2,ffffffffc02054dc <file_fstat+0x9c>
ffffffffc020548e:	07093783          	ld	a5,112(s2)
ffffffffc0205492:	c7a9                	beqz	a5,ffffffffc02054dc <file_fstat+0x9c>
ffffffffc0205494:	779c                	ld	a5,40(a5)
ffffffffc0205496:	c3b9                	beqz	a5,ffffffffc02054dc <file_fstat+0x9c>
ffffffffc0205498:	84ae                	mv	s1,a1
ffffffffc020549a:	854a                	mv	a0,s2
ffffffffc020549c:	00008597          	auipc	a1,0x8
ffffffffc02054a0:	d1c58593          	addi	a1,a1,-740 # ffffffffc020d1b8 <default_pmm_manager+0x9f8>
ffffffffc02054a4:	565020ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02054a8:	07093783          	ld	a5,112(s2)
ffffffffc02054ac:	7408                	ld	a0,40(s0)
ffffffffc02054ae:	85a6                	mv	a1,s1
ffffffffc02054b0:	779c                	ld	a5,40(a5)
ffffffffc02054b2:	9782                	jalr	a5
ffffffffc02054b4:	87aa                	mv	a5,a0
ffffffffc02054b6:	8522                	mv	a0,s0
ffffffffc02054b8:	843e                	mv	s0,a5
ffffffffc02054ba:	949ff0ef          	jal	ra,ffffffffc0204e02 <fd_array_release>
ffffffffc02054be:	60e2                	ld	ra,24(sp)
ffffffffc02054c0:	8522                	mv	a0,s0
ffffffffc02054c2:	6442                	ld	s0,16(sp)
ffffffffc02054c4:	64a2                	ld	s1,8(sp)
ffffffffc02054c6:	6902                	ld	s2,0(sp)
ffffffffc02054c8:	6105                	addi	sp,sp,32
ffffffffc02054ca:	8082                	ret
ffffffffc02054cc:	5475                	li	s0,-3
ffffffffc02054ce:	60e2                	ld	ra,24(sp)
ffffffffc02054d0:	8522                	mv	a0,s0
ffffffffc02054d2:	6442                	ld	s0,16(sp)
ffffffffc02054d4:	64a2                	ld	s1,8(sp)
ffffffffc02054d6:	6902                	ld	s2,0(sp)
ffffffffc02054d8:	6105                	addi	sp,sp,32
ffffffffc02054da:	8082                	ret
ffffffffc02054dc:	00008697          	auipc	a3,0x8
ffffffffc02054e0:	c8c68693          	addi	a3,a3,-884 # ffffffffc020d168 <default_pmm_manager+0x9a8>
ffffffffc02054e4:	00006617          	auipc	a2,0x6
ffffffffc02054e8:	31460613          	addi	a2,a2,788 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02054ec:	12c00593          	li	a1,300
ffffffffc02054f0:	00008517          	auipc	a0,0x8
ffffffffc02054f4:	b4050513          	addi	a0,a0,-1216 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc02054f8:	d37fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02054fc:	fd4ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>

ffffffffc0205500 <file_fsync>:
ffffffffc0205500:	1101                	addi	sp,sp,-32
ffffffffc0205502:	ec06                	sd	ra,24(sp)
ffffffffc0205504:	e822                	sd	s0,16(sp)
ffffffffc0205506:	e426                	sd	s1,8(sp)
ffffffffc0205508:	04700793          	li	a5,71
ffffffffc020550c:	06a7e863          	bltu	a5,a0,ffffffffc020557c <file_fsync+0x7c>
ffffffffc0205510:	00091797          	auipc	a5,0x91
ffffffffc0205514:	3b07b783          	ld	a5,944(a5) # ffffffffc02968c0 <current>
ffffffffc0205518:	1487b783          	ld	a5,328(a5)
ffffffffc020551c:	c7d9                	beqz	a5,ffffffffc02055aa <file_fsync+0xaa>
ffffffffc020551e:	4b98                	lw	a4,16(a5)
ffffffffc0205520:	08e05563          	blez	a4,ffffffffc02055aa <file_fsync+0xaa>
ffffffffc0205524:	6780                	ld	s0,8(a5)
ffffffffc0205526:	00351793          	slli	a5,a0,0x3
ffffffffc020552a:	8f89                	sub	a5,a5,a0
ffffffffc020552c:	078e                	slli	a5,a5,0x3
ffffffffc020552e:	943e                	add	s0,s0,a5
ffffffffc0205530:	4018                	lw	a4,0(s0)
ffffffffc0205532:	4789                	li	a5,2
ffffffffc0205534:	04f71463          	bne	a4,a5,ffffffffc020557c <file_fsync+0x7c>
ffffffffc0205538:	4c1c                	lw	a5,24(s0)
ffffffffc020553a:	04a79163          	bne	a5,a0,ffffffffc020557c <file_fsync+0x7c>
ffffffffc020553e:	581c                	lw	a5,48(s0)
ffffffffc0205540:	7404                	ld	s1,40(s0)
ffffffffc0205542:	2785                	addiw	a5,a5,1
ffffffffc0205544:	d81c                	sw	a5,48(s0)
ffffffffc0205546:	c0b1                	beqz	s1,ffffffffc020558a <file_fsync+0x8a>
ffffffffc0205548:	78bc                	ld	a5,112(s1)
ffffffffc020554a:	c3a1                	beqz	a5,ffffffffc020558a <file_fsync+0x8a>
ffffffffc020554c:	7b9c                	ld	a5,48(a5)
ffffffffc020554e:	cf95                	beqz	a5,ffffffffc020558a <file_fsync+0x8a>
ffffffffc0205550:	00008597          	auipc	a1,0x8
ffffffffc0205554:	dc858593          	addi	a1,a1,-568 # ffffffffc020d318 <default_pmm_manager+0xb58>
ffffffffc0205558:	8526                	mv	a0,s1
ffffffffc020555a:	4af020ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc020555e:	78bc                	ld	a5,112(s1)
ffffffffc0205560:	7408                	ld	a0,40(s0)
ffffffffc0205562:	7b9c                	ld	a5,48(a5)
ffffffffc0205564:	9782                	jalr	a5
ffffffffc0205566:	87aa                	mv	a5,a0
ffffffffc0205568:	8522                	mv	a0,s0
ffffffffc020556a:	843e                	mv	s0,a5
ffffffffc020556c:	897ff0ef          	jal	ra,ffffffffc0204e02 <fd_array_release>
ffffffffc0205570:	60e2                	ld	ra,24(sp)
ffffffffc0205572:	8522                	mv	a0,s0
ffffffffc0205574:	6442                	ld	s0,16(sp)
ffffffffc0205576:	64a2                	ld	s1,8(sp)
ffffffffc0205578:	6105                	addi	sp,sp,32
ffffffffc020557a:	8082                	ret
ffffffffc020557c:	5475                	li	s0,-3
ffffffffc020557e:	60e2                	ld	ra,24(sp)
ffffffffc0205580:	8522                	mv	a0,s0
ffffffffc0205582:	6442                	ld	s0,16(sp)
ffffffffc0205584:	64a2                	ld	s1,8(sp)
ffffffffc0205586:	6105                	addi	sp,sp,32
ffffffffc0205588:	8082                	ret
ffffffffc020558a:	00008697          	auipc	a3,0x8
ffffffffc020558e:	d3e68693          	addi	a3,a3,-706 # ffffffffc020d2c8 <default_pmm_manager+0xb08>
ffffffffc0205592:	00006617          	auipc	a2,0x6
ffffffffc0205596:	26660613          	addi	a2,a2,614 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020559a:	13a00593          	li	a1,314
ffffffffc020559e:	00008517          	auipc	a0,0x8
ffffffffc02055a2:	a9250513          	addi	a0,a0,-1390 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc02055a6:	c89fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02055aa:	f26ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>

ffffffffc02055ae <file_getdirentry>:
ffffffffc02055ae:	715d                	addi	sp,sp,-80
ffffffffc02055b0:	e486                	sd	ra,72(sp)
ffffffffc02055b2:	e0a2                	sd	s0,64(sp)
ffffffffc02055b4:	fc26                	sd	s1,56(sp)
ffffffffc02055b6:	f84a                	sd	s2,48(sp)
ffffffffc02055b8:	f44e                	sd	s3,40(sp)
ffffffffc02055ba:	04700793          	li	a5,71
ffffffffc02055be:	0aa7e063          	bltu	a5,a0,ffffffffc020565e <file_getdirentry+0xb0>
ffffffffc02055c2:	00091797          	auipc	a5,0x91
ffffffffc02055c6:	2fe7b783          	ld	a5,766(a5) # ffffffffc02968c0 <current>
ffffffffc02055ca:	1487b783          	ld	a5,328(a5)
ffffffffc02055ce:	c3e9                	beqz	a5,ffffffffc0205690 <file_getdirentry+0xe2>
ffffffffc02055d0:	4b98                	lw	a4,16(a5)
ffffffffc02055d2:	0ae05f63          	blez	a4,ffffffffc0205690 <file_getdirentry+0xe2>
ffffffffc02055d6:	6780                	ld	s0,8(a5)
ffffffffc02055d8:	00351793          	slli	a5,a0,0x3
ffffffffc02055dc:	8f89                	sub	a5,a5,a0
ffffffffc02055de:	078e                	slli	a5,a5,0x3
ffffffffc02055e0:	943e                	add	s0,s0,a5
ffffffffc02055e2:	4018                	lw	a4,0(s0)
ffffffffc02055e4:	4789                	li	a5,2
ffffffffc02055e6:	06f71c63          	bne	a4,a5,ffffffffc020565e <file_getdirentry+0xb0>
ffffffffc02055ea:	4c1c                	lw	a5,24(s0)
ffffffffc02055ec:	06a79963          	bne	a5,a0,ffffffffc020565e <file_getdirentry+0xb0>
ffffffffc02055f0:	581c                	lw	a5,48(s0)
ffffffffc02055f2:	6194                	ld	a3,0(a1)
ffffffffc02055f4:	84ae                	mv	s1,a1
ffffffffc02055f6:	2785                	addiw	a5,a5,1
ffffffffc02055f8:	10000613          	li	a2,256
ffffffffc02055fc:	d81c                	sw	a5,48(s0)
ffffffffc02055fe:	05a1                	addi	a1,a1,8
ffffffffc0205600:	850a                	mv	a0,sp
ffffffffc0205602:	12a000ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc0205606:	02843983          	ld	s3,40(s0)
ffffffffc020560a:	892a                	mv	s2,a0
ffffffffc020560c:	06098263          	beqz	s3,ffffffffc0205670 <file_getdirentry+0xc2>
ffffffffc0205610:	0709b783          	ld	a5,112(s3)
ffffffffc0205614:	cfb1                	beqz	a5,ffffffffc0205670 <file_getdirentry+0xc2>
ffffffffc0205616:	63bc                	ld	a5,64(a5)
ffffffffc0205618:	cfa1                	beqz	a5,ffffffffc0205670 <file_getdirentry+0xc2>
ffffffffc020561a:	854e                	mv	a0,s3
ffffffffc020561c:	00008597          	auipc	a1,0x8
ffffffffc0205620:	d5c58593          	addi	a1,a1,-676 # ffffffffc020d378 <default_pmm_manager+0xbb8>
ffffffffc0205624:	3e5020ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0205628:	0709b783          	ld	a5,112(s3)
ffffffffc020562c:	7408                	ld	a0,40(s0)
ffffffffc020562e:	85ca                	mv	a1,s2
ffffffffc0205630:	63bc                	ld	a5,64(a5)
ffffffffc0205632:	9782                	jalr	a5
ffffffffc0205634:	89aa                	mv	s3,a0
ffffffffc0205636:	e909                	bnez	a0,ffffffffc0205648 <file_getdirentry+0x9a>
ffffffffc0205638:	609c                	ld	a5,0(s1)
ffffffffc020563a:	01093683          	ld	a3,16(s2)
ffffffffc020563e:	01893703          	ld	a4,24(s2)
ffffffffc0205642:	97b6                	add	a5,a5,a3
ffffffffc0205644:	8f99                	sub	a5,a5,a4
ffffffffc0205646:	e09c                	sd	a5,0(s1)
ffffffffc0205648:	8522                	mv	a0,s0
ffffffffc020564a:	fb8ff0ef          	jal	ra,ffffffffc0204e02 <fd_array_release>
ffffffffc020564e:	60a6                	ld	ra,72(sp)
ffffffffc0205650:	6406                	ld	s0,64(sp)
ffffffffc0205652:	74e2                	ld	s1,56(sp)
ffffffffc0205654:	7942                	ld	s2,48(sp)
ffffffffc0205656:	854e                	mv	a0,s3
ffffffffc0205658:	79a2                	ld	s3,40(sp)
ffffffffc020565a:	6161                	addi	sp,sp,80
ffffffffc020565c:	8082                	ret
ffffffffc020565e:	60a6                	ld	ra,72(sp)
ffffffffc0205660:	6406                	ld	s0,64(sp)
ffffffffc0205662:	59f5                	li	s3,-3
ffffffffc0205664:	74e2                	ld	s1,56(sp)
ffffffffc0205666:	7942                	ld	s2,48(sp)
ffffffffc0205668:	854e                	mv	a0,s3
ffffffffc020566a:	79a2                	ld	s3,40(sp)
ffffffffc020566c:	6161                	addi	sp,sp,80
ffffffffc020566e:	8082                	ret
ffffffffc0205670:	00008697          	auipc	a3,0x8
ffffffffc0205674:	cb068693          	addi	a3,a3,-848 # ffffffffc020d320 <default_pmm_manager+0xb60>
ffffffffc0205678:	00006617          	auipc	a2,0x6
ffffffffc020567c:	18060613          	addi	a2,a2,384 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0205680:	14a00593          	li	a1,330
ffffffffc0205684:	00008517          	auipc	a0,0x8
ffffffffc0205688:	9ac50513          	addi	a0,a0,-1620 # ffffffffc020d030 <default_pmm_manager+0x870>
ffffffffc020568c:	ba3fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0205690:	e40ff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>

ffffffffc0205694 <file_dup>:
ffffffffc0205694:	04700713          	li	a4,71
ffffffffc0205698:	06a76463          	bltu	a4,a0,ffffffffc0205700 <file_dup+0x6c>
ffffffffc020569c:	00091717          	auipc	a4,0x91
ffffffffc02056a0:	22473703          	ld	a4,548(a4) # ffffffffc02968c0 <current>
ffffffffc02056a4:	14873703          	ld	a4,328(a4)
ffffffffc02056a8:	1101                	addi	sp,sp,-32
ffffffffc02056aa:	ec06                	sd	ra,24(sp)
ffffffffc02056ac:	e822                	sd	s0,16(sp)
ffffffffc02056ae:	cb39                	beqz	a4,ffffffffc0205704 <file_dup+0x70>
ffffffffc02056b0:	4b14                	lw	a3,16(a4)
ffffffffc02056b2:	04d05963          	blez	a3,ffffffffc0205704 <file_dup+0x70>
ffffffffc02056b6:	6700                	ld	s0,8(a4)
ffffffffc02056b8:	00351713          	slli	a4,a0,0x3
ffffffffc02056bc:	8f09                	sub	a4,a4,a0
ffffffffc02056be:	070e                	slli	a4,a4,0x3
ffffffffc02056c0:	943a                	add	s0,s0,a4
ffffffffc02056c2:	4014                	lw	a3,0(s0)
ffffffffc02056c4:	4709                	li	a4,2
ffffffffc02056c6:	02e69863          	bne	a3,a4,ffffffffc02056f6 <file_dup+0x62>
ffffffffc02056ca:	4c18                	lw	a4,24(s0)
ffffffffc02056cc:	02a71563          	bne	a4,a0,ffffffffc02056f6 <file_dup+0x62>
ffffffffc02056d0:	852e                	mv	a0,a1
ffffffffc02056d2:	002c                	addi	a1,sp,8
ffffffffc02056d4:	e1eff0ef          	jal	ra,ffffffffc0204cf2 <fd_array_alloc>
ffffffffc02056d8:	c509                	beqz	a0,ffffffffc02056e2 <file_dup+0x4e>
ffffffffc02056da:	60e2                	ld	ra,24(sp)
ffffffffc02056dc:	6442                	ld	s0,16(sp)
ffffffffc02056de:	6105                	addi	sp,sp,32
ffffffffc02056e0:	8082                	ret
ffffffffc02056e2:	6522                	ld	a0,8(sp)
ffffffffc02056e4:	85a2                	mv	a1,s0
ffffffffc02056e6:	845ff0ef          	jal	ra,ffffffffc0204f2a <fd_array_dup>
ffffffffc02056ea:	67a2                	ld	a5,8(sp)
ffffffffc02056ec:	60e2                	ld	ra,24(sp)
ffffffffc02056ee:	6442                	ld	s0,16(sp)
ffffffffc02056f0:	4f88                	lw	a0,24(a5)
ffffffffc02056f2:	6105                	addi	sp,sp,32
ffffffffc02056f4:	8082                	ret
ffffffffc02056f6:	60e2                	ld	ra,24(sp)
ffffffffc02056f8:	6442                	ld	s0,16(sp)
ffffffffc02056fa:	5575                	li	a0,-3
ffffffffc02056fc:	6105                	addi	sp,sp,32
ffffffffc02056fe:	8082                	ret
ffffffffc0205700:	5575                	li	a0,-3
ffffffffc0205702:	8082                	ret
ffffffffc0205704:	dccff0ef          	jal	ra,ffffffffc0204cd0 <get_fd_array.part.0>

ffffffffc0205708 <iobuf_skip.part.0>:
ffffffffc0205708:	1141                	addi	sp,sp,-16
ffffffffc020570a:	00008697          	auipc	a3,0x8
ffffffffc020570e:	cae68693          	addi	a3,a3,-850 # ffffffffc020d3b8 <CSWTCH.79+0x18>
ffffffffc0205712:	00006617          	auipc	a2,0x6
ffffffffc0205716:	0e660613          	addi	a2,a2,230 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020571a:	04a00593          	li	a1,74
ffffffffc020571e:	00008517          	auipc	a0,0x8
ffffffffc0205722:	cb250513          	addi	a0,a0,-846 # ffffffffc020d3d0 <CSWTCH.79+0x30>
ffffffffc0205726:	e406                	sd	ra,8(sp)
ffffffffc0205728:	b07fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020572c <iobuf_init>:
ffffffffc020572c:	e10c                	sd	a1,0(a0)
ffffffffc020572e:	e514                	sd	a3,8(a0)
ffffffffc0205730:	ed10                	sd	a2,24(a0)
ffffffffc0205732:	e910                	sd	a2,16(a0)
ffffffffc0205734:	8082                	ret

ffffffffc0205736 <iobuf_move>:
ffffffffc0205736:	7179                	addi	sp,sp,-48
ffffffffc0205738:	ec26                	sd	s1,24(sp)
ffffffffc020573a:	6d04                	ld	s1,24(a0)
ffffffffc020573c:	f022                	sd	s0,32(sp)
ffffffffc020573e:	e84a                	sd	s2,16(sp)
ffffffffc0205740:	e44e                	sd	s3,8(sp)
ffffffffc0205742:	f406                	sd	ra,40(sp)
ffffffffc0205744:	842a                	mv	s0,a0
ffffffffc0205746:	8932                	mv	s2,a2
ffffffffc0205748:	852e                	mv	a0,a1
ffffffffc020574a:	89ba                	mv	s3,a4
ffffffffc020574c:	00967363          	bgeu	a2,s1,ffffffffc0205752 <iobuf_move+0x1c>
ffffffffc0205750:	84b2                	mv	s1,a2
ffffffffc0205752:	c495                	beqz	s1,ffffffffc020577e <iobuf_move+0x48>
ffffffffc0205754:	600c                	ld	a1,0(s0)
ffffffffc0205756:	c681                	beqz	a3,ffffffffc020575e <iobuf_move+0x28>
ffffffffc0205758:	87ae                	mv	a5,a1
ffffffffc020575a:	85aa                	mv	a1,a0
ffffffffc020575c:	853e                	mv	a0,a5
ffffffffc020575e:	8626                	mv	a2,s1
ffffffffc0205760:	0a7050ef          	jal	ra,ffffffffc020b006 <memmove>
ffffffffc0205764:	6c1c                	ld	a5,24(s0)
ffffffffc0205766:	0297ea63          	bltu	a5,s1,ffffffffc020579a <iobuf_move+0x64>
ffffffffc020576a:	6014                	ld	a3,0(s0)
ffffffffc020576c:	6418                	ld	a4,8(s0)
ffffffffc020576e:	8f85                	sub	a5,a5,s1
ffffffffc0205770:	96a6                	add	a3,a3,s1
ffffffffc0205772:	9726                	add	a4,a4,s1
ffffffffc0205774:	e014                	sd	a3,0(s0)
ffffffffc0205776:	e418                	sd	a4,8(s0)
ffffffffc0205778:	ec1c                	sd	a5,24(s0)
ffffffffc020577a:	40990933          	sub	s2,s2,s1
ffffffffc020577e:	00098463          	beqz	s3,ffffffffc0205786 <iobuf_move+0x50>
ffffffffc0205782:	0099b023          	sd	s1,0(s3)
ffffffffc0205786:	4501                	li	a0,0
ffffffffc0205788:	00091b63          	bnez	s2,ffffffffc020579e <iobuf_move+0x68>
ffffffffc020578c:	70a2                	ld	ra,40(sp)
ffffffffc020578e:	7402                	ld	s0,32(sp)
ffffffffc0205790:	64e2                	ld	s1,24(sp)
ffffffffc0205792:	6942                	ld	s2,16(sp)
ffffffffc0205794:	69a2                	ld	s3,8(sp)
ffffffffc0205796:	6145                	addi	sp,sp,48
ffffffffc0205798:	8082                	ret
ffffffffc020579a:	f6fff0ef          	jal	ra,ffffffffc0205708 <iobuf_skip.part.0>
ffffffffc020579e:	5571                	li	a0,-4
ffffffffc02057a0:	b7f5                	j	ffffffffc020578c <iobuf_move+0x56>

ffffffffc02057a2 <iobuf_skip>:
ffffffffc02057a2:	6d1c                	ld	a5,24(a0)
ffffffffc02057a4:	00b7eb63          	bltu	a5,a1,ffffffffc02057ba <iobuf_skip+0x18>
ffffffffc02057a8:	6114                	ld	a3,0(a0)
ffffffffc02057aa:	6518                	ld	a4,8(a0)
ffffffffc02057ac:	8f8d                	sub	a5,a5,a1
ffffffffc02057ae:	96ae                	add	a3,a3,a1
ffffffffc02057b0:	95ba                	add	a1,a1,a4
ffffffffc02057b2:	e114                	sd	a3,0(a0)
ffffffffc02057b4:	e50c                	sd	a1,8(a0)
ffffffffc02057b6:	ed1c                	sd	a5,24(a0)
ffffffffc02057b8:	8082                	ret
ffffffffc02057ba:	1141                	addi	sp,sp,-16
ffffffffc02057bc:	e406                	sd	ra,8(sp)
ffffffffc02057be:	f4bff0ef          	jal	ra,ffffffffc0205708 <iobuf_skip.part.0>

ffffffffc02057c2 <fs_init>:
ffffffffc02057c2:	1141                	addi	sp,sp,-16
ffffffffc02057c4:	e406                	sd	ra,8(sp)
ffffffffc02057c6:	461020ef          	jal	ra,ffffffffc0208426 <vfs_init>
ffffffffc02057ca:	698030ef          	jal	ra,ffffffffc0208e62 <dev_init>
ffffffffc02057ce:	60a2                	ld	ra,8(sp)
ffffffffc02057d0:	0141                	addi	sp,sp,16
ffffffffc02057d2:	6d00306f          	j	ffffffffc0208ea2 <sfs_init>

ffffffffc02057d6 <fs_cleanup>:
ffffffffc02057d6:	18a0206f          	j	ffffffffc0207960 <vfs_cleanup>

ffffffffc02057da <lock_files>:
ffffffffc02057da:	0561                	addi	a0,a0,24
ffffffffc02057dc:	f6ffe06f          	j	ffffffffc020474a <down>

ffffffffc02057e0 <unlock_files>:
ffffffffc02057e0:	0561                	addi	a0,a0,24
ffffffffc02057e2:	f65fe06f          	j	ffffffffc0204746 <up>

ffffffffc02057e6 <files_create>:
ffffffffc02057e6:	1141                	addi	sp,sp,-16
ffffffffc02057e8:	6505                	lui	a0,0x1
ffffffffc02057ea:	e022                	sd	s0,0(sp)
ffffffffc02057ec:	e406                	sd	ra,8(sp)
ffffffffc02057ee:	d28fc0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02057f2:	842a                	mv	s0,a0
ffffffffc02057f4:	cd19                	beqz	a0,ffffffffc0205812 <files_create+0x2c>
ffffffffc02057f6:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc02057fa:	00043023          	sd	zero,0(s0)
ffffffffc02057fe:	0561                	addi	a0,a0,24
ffffffffc0205800:	e41c                	sd	a5,8(s0)
ffffffffc0205802:	00042823          	sw	zero,16(s0)
ffffffffc0205806:	4585                	li	a1,1
ffffffffc0205808:	f37fe0ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc020580c:	6408                	ld	a0,8(s0)
ffffffffc020580e:	e82ff0ef          	jal	ra,ffffffffc0204e90 <fd_array_init>
ffffffffc0205812:	60a2                	ld	ra,8(sp)
ffffffffc0205814:	8522                	mv	a0,s0
ffffffffc0205816:	6402                	ld	s0,0(sp)
ffffffffc0205818:	0141                	addi	sp,sp,16
ffffffffc020581a:	8082                	ret

ffffffffc020581c <files_destroy>:
ffffffffc020581c:	7179                	addi	sp,sp,-48
ffffffffc020581e:	f406                	sd	ra,40(sp)
ffffffffc0205820:	f022                	sd	s0,32(sp)
ffffffffc0205822:	ec26                	sd	s1,24(sp)
ffffffffc0205824:	e84a                	sd	s2,16(sp)
ffffffffc0205826:	e44e                	sd	s3,8(sp)
ffffffffc0205828:	c52d                	beqz	a0,ffffffffc0205892 <files_destroy+0x76>
ffffffffc020582a:	491c                	lw	a5,16(a0)
ffffffffc020582c:	89aa                	mv	s3,a0
ffffffffc020582e:	e3b5                	bnez	a5,ffffffffc0205892 <files_destroy+0x76>
ffffffffc0205830:	6108                	ld	a0,0(a0)
ffffffffc0205832:	c119                	beqz	a0,ffffffffc0205838 <files_destroy+0x1c>
ffffffffc0205834:	28b020ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0205838:	0089b403          	ld	s0,8(s3)
ffffffffc020583c:	6485                	lui	s1,0x1
ffffffffc020583e:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205842:	94a2                	add	s1,s1,s0
ffffffffc0205844:	4909                	li	s2,2
ffffffffc0205846:	401c                	lw	a5,0(s0)
ffffffffc0205848:	03278063          	beq	a5,s2,ffffffffc0205868 <files_destroy+0x4c>
ffffffffc020584c:	e39d                	bnez	a5,ffffffffc0205872 <files_destroy+0x56>
ffffffffc020584e:	03840413          	addi	s0,s0,56
ffffffffc0205852:	fe849ae3          	bne	s1,s0,ffffffffc0205846 <files_destroy+0x2a>
ffffffffc0205856:	7402                	ld	s0,32(sp)
ffffffffc0205858:	70a2                	ld	ra,40(sp)
ffffffffc020585a:	64e2                	ld	s1,24(sp)
ffffffffc020585c:	6942                	ld	s2,16(sp)
ffffffffc020585e:	854e                	mv	a0,s3
ffffffffc0205860:	69a2                	ld	s3,8(sp)
ffffffffc0205862:	6145                	addi	sp,sp,48
ffffffffc0205864:	d62fc06f          	j	ffffffffc0201dc6 <kfree>
ffffffffc0205868:	8522                	mv	a0,s0
ffffffffc020586a:	e42ff0ef          	jal	ra,ffffffffc0204eac <fd_array_close>
ffffffffc020586e:	401c                	lw	a5,0(s0)
ffffffffc0205870:	bff1                	j	ffffffffc020584c <files_destroy+0x30>
ffffffffc0205872:	00008697          	auipc	a3,0x8
ffffffffc0205876:	bae68693          	addi	a3,a3,-1106 # ffffffffc020d420 <CSWTCH.79+0x80>
ffffffffc020587a:	00006617          	auipc	a2,0x6
ffffffffc020587e:	f7e60613          	addi	a2,a2,-130 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0205882:	03d00593          	li	a1,61
ffffffffc0205886:	00008517          	auipc	a0,0x8
ffffffffc020588a:	b8a50513          	addi	a0,a0,-1142 # ffffffffc020d410 <CSWTCH.79+0x70>
ffffffffc020588e:	9a1fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0205892:	00008697          	auipc	a3,0x8
ffffffffc0205896:	b4e68693          	addi	a3,a3,-1202 # ffffffffc020d3e0 <CSWTCH.79+0x40>
ffffffffc020589a:	00006617          	auipc	a2,0x6
ffffffffc020589e:	f5e60613          	addi	a2,a2,-162 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02058a2:	03300593          	li	a1,51
ffffffffc02058a6:	00008517          	auipc	a0,0x8
ffffffffc02058aa:	b6a50513          	addi	a0,a0,-1174 # ffffffffc020d410 <CSWTCH.79+0x70>
ffffffffc02058ae:	981fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02058b2 <files_closeall>:
ffffffffc02058b2:	1101                	addi	sp,sp,-32
ffffffffc02058b4:	ec06                	sd	ra,24(sp)
ffffffffc02058b6:	e822                	sd	s0,16(sp)
ffffffffc02058b8:	e426                	sd	s1,8(sp)
ffffffffc02058ba:	e04a                	sd	s2,0(sp)
ffffffffc02058bc:	c129                	beqz	a0,ffffffffc02058fe <files_closeall+0x4c>
ffffffffc02058be:	491c                	lw	a5,16(a0)
ffffffffc02058c0:	02f05f63          	blez	a5,ffffffffc02058fe <files_closeall+0x4c>
ffffffffc02058c4:	6504                	ld	s1,8(a0)
ffffffffc02058c6:	6785                	lui	a5,0x1
ffffffffc02058c8:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02058cc:	07048413          	addi	s0,s1,112
ffffffffc02058d0:	4909                	li	s2,2
ffffffffc02058d2:	94be                	add	s1,s1,a5
ffffffffc02058d4:	a029                	j	ffffffffc02058de <files_closeall+0x2c>
ffffffffc02058d6:	03840413          	addi	s0,s0,56
ffffffffc02058da:	00848c63          	beq	s1,s0,ffffffffc02058f2 <files_closeall+0x40>
ffffffffc02058de:	401c                	lw	a5,0(s0)
ffffffffc02058e0:	ff279be3          	bne	a5,s2,ffffffffc02058d6 <files_closeall+0x24>
ffffffffc02058e4:	8522                	mv	a0,s0
ffffffffc02058e6:	03840413          	addi	s0,s0,56
ffffffffc02058ea:	dc2ff0ef          	jal	ra,ffffffffc0204eac <fd_array_close>
ffffffffc02058ee:	fe8498e3          	bne	s1,s0,ffffffffc02058de <files_closeall+0x2c>
ffffffffc02058f2:	60e2                	ld	ra,24(sp)
ffffffffc02058f4:	6442                	ld	s0,16(sp)
ffffffffc02058f6:	64a2                	ld	s1,8(sp)
ffffffffc02058f8:	6902                	ld	s2,0(sp)
ffffffffc02058fa:	6105                	addi	sp,sp,32
ffffffffc02058fc:	8082                	ret
ffffffffc02058fe:	00007697          	auipc	a3,0x7
ffffffffc0205902:	70268693          	addi	a3,a3,1794 # ffffffffc020d000 <default_pmm_manager+0x840>
ffffffffc0205906:	00006617          	auipc	a2,0x6
ffffffffc020590a:	ef260613          	addi	a2,a2,-270 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020590e:	04500593          	li	a1,69
ffffffffc0205912:	00008517          	auipc	a0,0x8
ffffffffc0205916:	afe50513          	addi	a0,a0,-1282 # ffffffffc020d410 <CSWTCH.79+0x70>
ffffffffc020591a:	915fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020591e <dup_files>:
ffffffffc020591e:	7179                	addi	sp,sp,-48
ffffffffc0205920:	f406                	sd	ra,40(sp)
ffffffffc0205922:	f022                	sd	s0,32(sp)
ffffffffc0205924:	ec26                	sd	s1,24(sp)
ffffffffc0205926:	e84a                	sd	s2,16(sp)
ffffffffc0205928:	e44e                	sd	s3,8(sp)
ffffffffc020592a:	e052                	sd	s4,0(sp)
ffffffffc020592c:	c52d                	beqz	a0,ffffffffc0205996 <dup_files+0x78>
ffffffffc020592e:	842e                	mv	s0,a1
ffffffffc0205930:	c1bd                	beqz	a1,ffffffffc0205996 <dup_files+0x78>
ffffffffc0205932:	491c                	lw	a5,16(a0)
ffffffffc0205934:	84aa                	mv	s1,a0
ffffffffc0205936:	e3c1                	bnez	a5,ffffffffc02059b6 <dup_files+0x98>
ffffffffc0205938:	499c                	lw	a5,16(a1)
ffffffffc020593a:	06f05e63          	blez	a5,ffffffffc02059b6 <dup_files+0x98>
ffffffffc020593e:	6188                	ld	a0,0(a1)
ffffffffc0205940:	e088                	sd	a0,0(s1)
ffffffffc0205942:	c119                	beqz	a0,ffffffffc0205948 <dup_files+0x2a>
ffffffffc0205944:	0ad020ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0205948:	6400                	ld	s0,8(s0)
ffffffffc020594a:	6905                	lui	s2,0x1
ffffffffc020594c:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205950:	6484                	ld	s1,8(s1)
ffffffffc0205952:	9922                	add	s2,s2,s0
ffffffffc0205954:	4989                	li	s3,2
ffffffffc0205956:	4a05                	li	s4,1
ffffffffc0205958:	a039                	j	ffffffffc0205966 <dup_files+0x48>
ffffffffc020595a:	03840413          	addi	s0,s0,56
ffffffffc020595e:	03848493          	addi	s1,s1,56
ffffffffc0205962:	02890163          	beq	s2,s0,ffffffffc0205984 <dup_files+0x66>
ffffffffc0205966:	401c                	lw	a5,0(s0)
ffffffffc0205968:	ff3799e3          	bne	a5,s3,ffffffffc020595a <dup_files+0x3c>
ffffffffc020596c:	0144a023          	sw	s4,0(s1)
ffffffffc0205970:	85a2                	mv	a1,s0
ffffffffc0205972:	8526                	mv	a0,s1
ffffffffc0205974:	03840413          	addi	s0,s0,56
ffffffffc0205978:	db2ff0ef          	jal	ra,ffffffffc0204f2a <fd_array_dup>
ffffffffc020597c:	03848493          	addi	s1,s1,56
ffffffffc0205980:	fe8913e3          	bne	s2,s0,ffffffffc0205966 <dup_files+0x48>
ffffffffc0205984:	70a2                	ld	ra,40(sp)
ffffffffc0205986:	7402                	ld	s0,32(sp)
ffffffffc0205988:	64e2                	ld	s1,24(sp)
ffffffffc020598a:	6942                	ld	s2,16(sp)
ffffffffc020598c:	69a2                	ld	s3,8(sp)
ffffffffc020598e:	6a02                	ld	s4,0(sp)
ffffffffc0205990:	4501                	li	a0,0
ffffffffc0205992:	6145                	addi	sp,sp,48
ffffffffc0205994:	8082                	ret
ffffffffc0205996:	00006697          	auipc	a3,0x6
ffffffffc020599a:	7ca68693          	addi	a3,a3,1994 # ffffffffc020c160 <commands+0x9c8>
ffffffffc020599e:	00006617          	auipc	a2,0x6
ffffffffc02059a2:	e5a60613          	addi	a2,a2,-422 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02059a6:	05300593          	li	a1,83
ffffffffc02059aa:	00008517          	auipc	a0,0x8
ffffffffc02059ae:	a6650513          	addi	a0,a0,-1434 # ffffffffc020d410 <CSWTCH.79+0x70>
ffffffffc02059b2:	87dfa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02059b6:	00008697          	auipc	a3,0x8
ffffffffc02059ba:	a8268693          	addi	a3,a3,-1406 # ffffffffc020d438 <CSWTCH.79+0x98>
ffffffffc02059be:	00006617          	auipc	a2,0x6
ffffffffc02059c2:	e3a60613          	addi	a2,a2,-454 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02059c6:	05400593          	li	a1,84
ffffffffc02059ca:	00008517          	auipc	a0,0x8
ffffffffc02059ce:	a4650513          	addi	a0,a0,-1466 # ffffffffc020d410 <CSWTCH.79+0x70>
ffffffffc02059d2:	85dfa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02059d6 <kernel_thread_entry>:
ffffffffc02059d6:	8526                	mv	a0,s1
ffffffffc02059d8:	9402                	jalr	s0
ffffffffc02059da:	6b0000ef          	jal	ra,ffffffffc020608a <do_exit>

ffffffffc02059de <switch_to>:
ffffffffc02059de:	00153023          	sd	ra,0(a0)
ffffffffc02059e2:	00253423          	sd	sp,8(a0)
ffffffffc02059e6:	e900                	sd	s0,16(a0)
ffffffffc02059e8:	ed04                	sd	s1,24(a0)
ffffffffc02059ea:	03253023          	sd	s2,32(a0)
ffffffffc02059ee:	03353423          	sd	s3,40(a0)
ffffffffc02059f2:	03453823          	sd	s4,48(a0)
ffffffffc02059f6:	03553c23          	sd	s5,56(a0)
ffffffffc02059fa:	05653023          	sd	s6,64(a0)
ffffffffc02059fe:	05753423          	sd	s7,72(a0)
ffffffffc0205a02:	05853823          	sd	s8,80(a0)
ffffffffc0205a06:	05953c23          	sd	s9,88(a0)
ffffffffc0205a0a:	07a53023          	sd	s10,96(a0)
ffffffffc0205a0e:	07b53423          	sd	s11,104(a0)
ffffffffc0205a12:	0005b083          	ld	ra,0(a1)
ffffffffc0205a16:	0085b103          	ld	sp,8(a1)
ffffffffc0205a1a:	6980                	ld	s0,16(a1)
ffffffffc0205a1c:	6d84                	ld	s1,24(a1)
ffffffffc0205a1e:	0205b903          	ld	s2,32(a1)
ffffffffc0205a22:	0285b983          	ld	s3,40(a1)
ffffffffc0205a26:	0305ba03          	ld	s4,48(a1)
ffffffffc0205a2a:	0385ba83          	ld	s5,56(a1)
ffffffffc0205a2e:	0405bb03          	ld	s6,64(a1)
ffffffffc0205a32:	0485bb83          	ld	s7,72(a1)
ffffffffc0205a36:	0505bc03          	ld	s8,80(a1)
ffffffffc0205a3a:	0585bc83          	ld	s9,88(a1)
ffffffffc0205a3e:	0605bd03          	ld	s10,96(a1)
ffffffffc0205a42:	0685bd83          	ld	s11,104(a1)
ffffffffc0205a46:	8082                	ret

ffffffffc0205a48 <alloc_proc>:
ffffffffc0205a48:	1141                	addi	sp,sp,-16
ffffffffc0205a4a:	15000513          	li	a0,336
ffffffffc0205a4e:	e022                	sd	s0,0(sp)
ffffffffc0205a50:	e406                	sd	ra,8(sp)
ffffffffc0205a52:	ac4fc0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0205a56:	842a                	mv	s0,a0
ffffffffc0205a58:	c151                	beqz	a0,ffffffffc0205adc <alloc_proc+0x94>
ffffffffc0205a5a:	57fd                	li	a5,-1
ffffffffc0205a5c:	1782                	slli	a5,a5,0x20
ffffffffc0205a5e:	e11c                	sd	a5,0(a0)
ffffffffc0205a60:	07000613          	li	a2,112
ffffffffc0205a64:	4581                	li	a1,0
ffffffffc0205a66:	00052423          	sw	zero,8(a0)
ffffffffc0205a6a:	00053823          	sd	zero,16(a0)
ffffffffc0205a6e:	00053c23          	sd	zero,24(a0)
ffffffffc0205a72:	02053023          	sd	zero,32(a0)
ffffffffc0205a76:	02053423          	sd	zero,40(a0)
ffffffffc0205a7a:	03050513          	addi	a0,a0,48
ffffffffc0205a7e:	576050ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0205a82:	00091797          	auipc	a5,0x91
ffffffffc0205a86:	e0e7b783          	ld	a5,-498(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205a8a:	f45c                	sd	a5,168(s0)
ffffffffc0205a8c:	0a043023          	sd	zero,160(s0)
ffffffffc0205a90:	0a042823          	sw	zero,176(s0)
ffffffffc0205a94:	0e042423          	sw	zero,232(s0)
ffffffffc0205a98:	463d                	li	a2,15
ffffffffc0205a9a:	4581                	li	a1,0
ffffffffc0205a9c:	0b440513          	addi	a0,s0,180
ffffffffc0205aa0:	554050ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0205aa4:	11040793          	addi	a5,s0,272
ffffffffc0205aa8:	0e042623          	sw	zero,236(s0)
ffffffffc0205aac:	0e043c23          	sd	zero,248(s0)
ffffffffc0205ab0:	10043023          	sd	zero,256(s0)
ffffffffc0205ab4:	0e043823          	sd	zero,240(s0)
ffffffffc0205ab8:	10043423          	sd	zero,264(s0)
ffffffffc0205abc:	10f43c23          	sd	a5,280(s0)
ffffffffc0205ac0:	10f43823          	sd	a5,272(s0)
ffffffffc0205ac4:	12042023          	sw	zero,288(s0)
ffffffffc0205ac8:	12043423          	sd	zero,296(s0)
ffffffffc0205acc:	12043823          	sd	zero,304(s0)
ffffffffc0205ad0:	12043c23          	sd	zero,312(s0)
ffffffffc0205ad4:	14043023          	sd	zero,320(s0)
ffffffffc0205ad8:	14043423          	sd	zero,328(s0)
ffffffffc0205adc:	60a2                	ld	ra,8(sp)
ffffffffc0205ade:	8522                	mv	a0,s0
ffffffffc0205ae0:	6402                	ld	s0,0(sp)
ffffffffc0205ae2:	0141                	addi	sp,sp,16
ffffffffc0205ae4:	8082                	ret

ffffffffc0205ae6 <forkret>:
ffffffffc0205ae6:	00091797          	auipc	a5,0x91
ffffffffc0205aea:	dda7b783          	ld	a5,-550(a5) # ffffffffc02968c0 <current>
ffffffffc0205aee:	73c8                	ld	a0,160(a5)
ffffffffc0205af0:	fc2fb06f          	j	ffffffffc02012b2 <forkrets>

ffffffffc0205af4 <put_pgdir.isra.0>:
ffffffffc0205af4:	1141                	addi	sp,sp,-16
ffffffffc0205af6:	e406                	sd	ra,8(sp)
ffffffffc0205af8:	c02007b7          	lui	a5,0xc0200
ffffffffc0205afc:	02f56e63          	bltu	a0,a5,ffffffffc0205b38 <put_pgdir.isra.0+0x44>
ffffffffc0205b00:	00091697          	auipc	a3,0x91
ffffffffc0205b04:	db86b683          	ld	a3,-584(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205b08:	8d15                	sub	a0,a0,a3
ffffffffc0205b0a:	8131                	srli	a0,a0,0xc
ffffffffc0205b0c:	00091797          	auipc	a5,0x91
ffffffffc0205b10:	d947b783          	ld	a5,-620(a5) # ffffffffc02968a0 <npage>
ffffffffc0205b14:	02f57f63          	bgeu	a0,a5,ffffffffc0205b52 <put_pgdir.isra.0+0x5e>
ffffffffc0205b18:	0000a697          	auipc	a3,0xa
ffffffffc0205b1c:	bc86b683          	ld	a3,-1080(a3) # ffffffffc020f6e0 <nbase>
ffffffffc0205b20:	60a2                	ld	ra,8(sp)
ffffffffc0205b22:	8d15                	sub	a0,a0,a3
ffffffffc0205b24:	00091797          	auipc	a5,0x91
ffffffffc0205b28:	d847b783          	ld	a5,-636(a5) # ffffffffc02968a8 <pages>
ffffffffc0205b2c:	051a                	slli	a0,a0,0x6
ffffffffc0205b2e:	4585                	li	a1,1
ffffffffc0205b30:	953e                	add	a0,a0,a5
ffffffffc0205b32:	0141                	addi	sp,sp,16
ffffffffc0205b34:	eadfc06f          	j	ffffffffc02029e0 <free_pages>
ffffffffc0205b38:	86aa                	mv	a3,a0
ffffffffc0205b3a:	00007617          	auipc	a2,0x7
ffffffffc0205b3e:	89660613          	addi	a2,a2,-1898 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0205b42:	07700593          	li	a1,119
ffffffffc0205b46:	00007517          	auipc	a0,0x7
ffffffffc0205b4a:	80a50513          	addi	a0,a0,-2038 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0205b4e:	ee0fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0205b52:	00007617          	auipc	a2,0x7
ffffffffc0205b56:	8a660613          	addi	a2,a2,-1882 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc0205b5a:	06900593          	li	a1,105
ffffffffc0205b5e:	00006517          	auipc	a0,0x6
ffffffffc0205b62:	7f250513          	addi	a0,a0,2034 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0205b66:	ec8fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0205b6a <proc_run>:
ffffffffc0205b6a:	7179                	addi	sp,sp,-48
ffffffffc0205b6c:	f026                	sd	s1,32(sp)
ffffffffc0205b6e:	00091497          	auipc	s1,0x91
ffffffffc0205b72:	d5248493          	addi	s1,s1,-686 # ffffffffc02968c0 <current>
ffffffffc0205b76:	6098                	ld	a4,0(s1)
ffffffffc0205b78:	f406                	sd	ra,40(sp)
ffffffffc0205b7a:	ec4a                	sd	s2,24(sp)
ffffffffc0205b7c:	02a70963          	beq	a4,a0,ffffffffc0205bae <proc_run+0x44>
ffffffffc0205b80:	100027f3          	csrr	a5,sstatus
ffffffffc0205b84:	8b89                	andi	a5,a5,2
ffffffffc0205b86:	4901                	li	s2,0
ffffffffc0205b88:	ef95                	bnez	a5,ffffffffc0205bc4 <proc_run+0x5a>
ffffffffc0205b8a:	755c                	ld	a5,168(a0)
ffffffffc0205b8c:	56fd                	li	a3,-1
ffffffffc0205b8e:	16fe                	slli	a3,a3,0x3f
ffffffffc0205b90:	83b1                	srli	a5,a5,0xc
ffffffffc0205b92:	e088                	sd	a0,0(s1)
ffffffffc0205b94:	8fd5                	or	a5,a5,a3
ffffffffc0205b96:	18079073          	csrw	satp,a5
ffffffffc0205b9a:	12000073          	sfence.vma
ffffffffc0205b9e:	03050593          	addi	a1,a0,48
ffffffffc0205ba2:	03070513          	addi	a0,a4,48
ffffffffc0205ba6:	e39ff0ef          	jal	ra,ffffffffc02059de <switch_to>
ffffffffc0205baa:	00091763          	bnez	s2,ffffffffc0205bb8 <proc_run+0x4e>
ffffffffc0205bae:	70a2                	ld	ra,40(sp)
ffffffffc0205bb0:	7482                	ld	s1,32(sp)
ffffffffc0205bb2:	6962                	ld	s2,24(sp)
ffffffffc0205bb4:	6145                	addi	sp,sp,48
ffffffffc0205bb6:	8082                	ret
ffffffffc0205bb8:	70a2                	ld	ra,40(sp)
ffffffffc0205bba:	7482                	ld	s1,32(sp)
ffffffffc0205bbc:	6962                	ld	s2,24(sp)
ffffffffc0205bbe:	6145                	addi	sp,sp,48
ffffffffc0205bc0:	9defb06f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc0205bc4:	e42a                	sd	a0,8(sp)
ffffffffc0205bc6:	9defb0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0205bca:	6098                	ld	a4,0(s1)
ffffffffc0205bcc:	6522                	ld	a0,8(sp)
ffffffffc0205bce:	4905                	li	s2,1
ffffffffc0205bd0:	bf6d                	j	ffffffffc0205b8a <proc_run+0x20>

ffffffffc0205bd2 <do_fork>:
ffffffffc0205bd2:	7119                	addi	sp,sp,-128
ffffffffc0205bd4:	f4a6                	sd	s1,104(sp)
ffffffffc0205bd6:	00091497          	auipc	s1,0x91
ffffffffc0205bda:	d0248493          	addi	s1,s1,-766 # ffffffffc02968d8 <nr_process>
ffffffffc0205bde:	4098                	lw	a4,0(s1)
ffffffffc0205be0:	fc86                	sd	ra,120(sp)
ffffffffc0205be2:	f8a2                	sd	s0,112(sp)
ffffffffc0205be4:	f0ca                	sd	s2,96(sp)
ffffffffc0205be6:	ecce                	sd	s3,88(sp)
ffffffffc0205be8:	e8d2                	sd	s4,80(sp)
ffffffffc0205bea:	e4d6                	sd	s5,72(sp)
ffffffffc0205bec:	e0da                	sd	s6,64(sp)
ffffffffc0205bee:	fc5e                	sd	s7,56(sp)
ffffffffc0205bf0:	f862                	sd	s8,48(sp)
ffffffffc0205bf2:	f466                	sd	s9,40(sp)
ffffffffc0205bf4:	f06a                	sd	s10,32(sp)
ffffffffc0205bf6:	ec6e                	sd	s11,24(sp)
ffffffffc0205bf8:	6785                	lui	a5,0x1
ffffffffc0205bfa:	38f75263          	bge	a4,a5,ffffffffc0205f7e <do_fork+0x3ac>
ffffffffc0205bfe:	89aa                	mv	s3,a0
ffffffffc0205c00:	8a2e                	mv	s4,a1
ffffffffc0205c02:	8932                	mv	s2,a2
ffffffffc0205c04:	e45ff0ef          	jal	ra,ffffffffc0205a48 <alloc_proc>
ffffffffc0205c08:	842a                	mv	s0,a0
ffffffffc0205c0a:	38050a63          	beqz	a0,ffffffffc0205f9e <do_fork+0x3cc>
ffffffffc0205c0e:	00091b97          	auipc	s7,0x91
ffffffffc0205c12:	cb2b8b93          	addi	s7,s7,-846 # ffffffffc02968c0 <current>
ffffffffc0205c16:	000bb783          	ld	a5,0(s7)
ffffffffc0205c1a:	4509                	li	a0,2
ffffffffc0205c1c:	f01c                	sd	a5,32(s0)
ffffffffc0205c1e:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_bin_swap_img_size-0x6c14>
ffffffffc0205c22:	d81fc0ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0205c26:	34050563          	beqz	a0,ffffffffc0205f70 <do_fork+0x39e>
ffffffffc0205c2a:	00091d17          	auipc	s10,0x91
ffffffffc0205c2e:	c7ed0d13          	addi	s10,s10,-898 # ffffffffc02968a8 <pages>
ffffffffc0205c32:	000d3683          	ld	a3,0(s10)
ffffffffc0205c36:	00091d97          	auipc	s11,0x91
ffffffffc0205c3a:	c6ad8d93          	addi	s11,s11,-918 # ffffffffc02968a0 <npage>
ffffffffc0205c3e:	0000ac97          	auipc	s9,0xa
ffffffffc0205c42:	aa2cbc83          	ld	s9,-1374(s9) # ffffffffc020f6e0 <nbase>
ffffffffc0205c46:	40d506b3          	sub	a3,a0,a3
ffffffffc0205c4a:	8699                	srai	a3,a3,0x6
ffffffffc0205c4c:	5afd                	li	s5,-1
ffffffffc0205c4e:	000db783          	ld	a5,0(s11)
ffffffffc0205c52:	96e6                	add	a3,a3,s9
ffffffffc0205c54:	00cada93          	srli	s5,s5,0xc
ffffffffc0205c58:	0156f733          	and	a4,a3,s5
ffffffffc0205c5c:	06b2                	slli	a3,a3,0xc
ffffffffc0205c5e:	34f77e63          	bgeu	a4,a5,ffffffffc0205fba <do_fork+0x3e8>
ffffffffc0205c62:	000bb603          	ld	a2,0(s7)
ffffffffc0205c66:	00091c17          	auipc	s8,0x91
ffffffffc0205c6a:	c52c0c13          	addi	s8,s8,-942 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205c6e:	000c3783          	ld	a5,0(s8)
ffffffffc0205c72:	02863b03          	ld	s6,40(a2)
ffffffffc0205c76:	96be                	add	a3,a3,a5
ffffffffc0205c78:	e814                	sd	a3,16(s0)
ffffffffc0205c7a:	020b0963          	beqz	s6,ffffffffc0205cac <do_fork+0xda>
ffffffffc0205c7e:	1009f793          	andi	a5,s3,256
ffffffffc0205c82:	10078963          	beqz	a5,ffffffffc0205d94 <do_fork+0x1c2>
ffffffffc0205c86:	030b2783          	lw	a5,48(s6)
ffffffffc0205c8a:	018b3683          	ld	a3,24(s6)
ffffffffc0205c8e:	c0200637          	lui	a2,0xc0200
ffffffffc0205c92:	2785                	addiw	a5,a5,1
ffffffffc0205c94:	02fb2823          	sw	a5,48(s6)
ffffffffc0205c98:	03643423          	sd	s6,40(s0)
ffffffffc0205c9c:	36c6e363          	bltu	a3,a2,ffffffffc0206002 <do_fork+0x430>
ffffffffc0205ca0:	000c3783          	ld	a5,0(s8)
ffffffffc0205ca4:	000bb603          	ld	a2,0(s7)
ffffffffc0205ca8:	8e9d                	sub	a3,a3,a5
ffffffffc0205caa:	f454                	sd	a3,168(s0)
ffffffffc0205cac:	14863b03          	ld	s6,328(a2) # ffffffffc0200148 <cprintf+0x1e>
ffffffffc0205cb0:	360b0563          	beqz	s6,ffffffffc020601a <do_fork+0x448>
ffffffffc0205cb4:	00b9d993          	srli	s3,s3,0xb
ffffffffc0205cb8:	0019f993          	andi	s3,s3,1
ffffffffc0205cbc:	14098e63          	beqz	s3,ffffffffc0205e18 <do_fork+0x246>
ffffffffc0205cc0:	010b2783          	lw	a5,16(s6)
ffffffffc0205cc4:	6818                	ld	a4,16(s0)
ffffffffc0205cc6:	864a                	mv	a2,s2
ffffffffc0205cc8:	2785                	addiw	a5,a5,1
ffffffffc0205cca:	00fb2823          	sw	a5,16(s6)
ffffffffc0205cce:	6789                	lui	a5,0x2
ffffffffc0205cd0:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205cd4:	973e                	add	a4,a4,a5
ffffffffc0205cd6:	15643423          	sd	s6,328(s0)
ffffffffc0205cda:	f058                	sd	a4,160(s0)
ffffffffc0205cdc:	87ba                	mv	a5,a4
ffffffffc0205cde:	12090893          	addi	a7,s2,288
ffffffffc0205ce2:	00063803          	ld	a6,0(a2)
ffffffffc0205ce6:	6608                	ld	a0,8(a2)
ffffffffc0205ce8:	6a0c                	ld	a1,16(a2)
ffffffffc0205cea:	6e14                	ld	a3,24(a2)
ffffffffc0205cec:	0107b023          	sd	a6,0(a5)
ffffffffc0205cf0:	e788                	sd	a0,8(a5)
ffffffffc0205cf2:	eb8c                	sd	a1,16(a5)
ffffffffc0205cf4:	ef94                	sd	a3,24(a5)
ffffffffc0205cf6:	02060613          	addi	a2,a2,32
ffffffffc0205cfa:	02078793          	addi	a5,a5,32
ffffffffc0205cfe:	ff1612e3          	bne	a2,a7,ffffffffc0205ce2 <do_fork+0x110>
ffffffffc0205d02:	04073823          	sd	zero,80(a4)
ffffffffc0205d06:	160a0463          	beqz	s4,ffffffffc0205e6e <do_fork+0x29c>
ffffffffc0205d0a:	0008b817          	auipc	a6,0x8b
ffffffffc0205d0e:	34e80813          	addi	a6,a6,846 # ffffffffc0291058 <last_pid.1>
ffffffffc0205d12:	00082783          	lw	a5,0(a6)
ffffffffc0205d16:	01473823          	sd	s4,16(a4)
ffffffffc0205d1a:	00000697          	auipc	a3,0x0
ffffffffc0205d1e:	dcc68693          	addi	a3,a3,-564 # ffffffffc0205ae6 <forkret>
ffffffffc0205d22:	0017851b          	addiw	a0,a5,1
ffffffffc0205d26:	f814                	sd	a3,48(s0)
ffffffffc0205d28:	fc18                	sd	a4,56(s0)
ffffffffc0205d2a:	00a82023          	sw	a0,0(a6)
ffffffffc0205d2e:	6789                	lui	a5,0x2
ffffffffc0205d30:	20f55f63          	bge	a0,a5,ffffffffc0205f4e <do_fork+0x37c>
ffffffffc0205d34:	0008b317          	auipc	t1,0x8b
ffffffffc0205d38:	32830313          	addi	t1,t1,808 # ffffffffc029105c <next_safe.0>
ffffffffc0205d3c:	00032783          	lw	a5,0(t1)
ffffffffc0205d40:	00090917          	auipc	s2,0x90
ffffffffc0205d44:	a8090913          	addi	s2,s2,-1408 # ffffffffc02957c0 <proc_list>
ffffffffc0205d48:	12f54d63          	blt	a0,a5,ffffffffc0205e82 <do_fork+0x2b0>
ffffffffc0205d4c:	00090917          	auipc	s2,0x90
ffffffffc0205d50:	a7490913          	addi	s2,s2,-1420 # ffffffffc02957c0 <proc_list>
ffffffffc0205d54:	00893e03          	ld	t3,8(s2)
ffffffffc0205d58:	6789                	lui	a5,0x2
ffffffffc0205d5a:	00f32023          	sw	a5,0(t1)
ffffffffc0205d5e:	86aa                	mv	a3,a0
ffffffffc0205d60:	4581                	li	a1,0
ffffffffc0205d62:	6e89                	lui	t4,0x2
ffffffffc0205d64:	232e0f63          	beq	t3,s2,ffffffffc0205fa2 <do_fork+0x3d0>
ffffffffc0205d68:	88ae                	mv	a7,a1
ffffffffc0205d6a:	87f2                	mv	a5,t3
ffffffffc0205d6c:	6609                	lui	a2,0x2
ffffffffc0205d6e:	a811                	j	ffffffffc0205d82 <do_fork+0x1b0>
ffffffffc0205d70:	00e6d663          	bge	a3,a4,ffffffffc0205d7c <do_fork+0x1aa>
ffffffffc0205d74:	00c75463          	bge	a4,a2,ffffffffc0205d7c <do_fork+0x1aa>
ffffffffc0205d78:	863a                	mv	a2,a4
ffffffffc0205d7a:	4885                	li	a7,1
ffffffffc0205d7c:	679c                	ld	a5,8(a5)
ffffffffc0205d7e:	0f278a63          	beq	a5,s2,ffffffffc0205e72 <do_fork+0x2a0>
ffffffffc0205d82:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205d86:	fed715e3          	bne	a4,a3,ffffffffc0205d70 <do_fork+0x19e>
ffffffffc0205d8a:	2685                	addiw	a3,a3,1
ffffffffc0205d8c:	1cc6dd63          	bge	a3,a2,ffffffffc0205f66 <do_fork+0x394>
ffffffffc0205d90:	4585                	li	a1,1
ffffffffc0205d92:	b7ed                	j	ffffffffc0205d7c <do_fork+0x1aa>
ffffffffc0205d94:	d46fb0ef          	jal	ra,ffffffffc02012da <mm_create>
ffffffffc0205d98:	e02a                	sd	a0,0(sp)
ffffffffc0205d9a:	20050963          	beqz	a0,ffffffffc0205fac <do_fork+0x3da>
ffffffffc0205d9e:	4505                	li	a0,1
ffffffffc0205da0:	c03fc0ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0205da4:	16050763          	beqz	a0,ffffffffc0205f12 <do_fork+0x340>
ffffffffc0205da8:	000d3683          	ld	a3,0(s10)
ffffffffc0205dac:	000db783          	ld	a5,0(s11)
ffffffffc0205db0:	40d506b3          	sub	a3,a0,a3
ffffffffc0205db4:	8699                	srai	a3,a3,0x6
ffffffffc0205db6:	96e6                	add	a3,a3,s9
ffffffffc0205db8:	0156fab3          	and	s5,a3,s5
ffffffffc0205dbc:	06b2                	slli	a3,a3,0xc
ffffffffc0205dbe:	1efafe63          	bgeu	s5,a5,ffffffffc0205fba <do_fork+0x3e8>
ffffffffc0205dc2:	000c3a83          	ld	s5,0(s8)
ffffffffc0205dc6:	6605                	lui	a2,0x1
ffffffffc0205dc8:	00091597          	auipc	a1,0x91
ffffffffc0205dcc:	ad05b583          	ld	a1,-1328(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205dd0:	9ab6                	add	s5,s5,a3
ffffffffc0205dd2:	8556                	mv	a0,s5
ffffffffc0205dd4:	272050ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0205dd8:	6702                	ld	a4,0(sp)
ffffffffc0205dda:	038b0793          	addi	a5,s6,56
ffffffffc0205dde:	853e                	mv	a0,a5
ffffffffc0205de0:	01573c23          	sd	s5,24(a4)
ffffffffc0205de4:	e43e                	sd	a5,8(sp)
ffffffffc0205de6:	965fe0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0205dea:	000bb683          	ld	a3,0(s7)
ffffffffc0205dee:	67a2                	ld	a5,8(sp)
ffffffffc0205df0:	c681                	beqz	a3,ffffffffc0205df8 <do_fork+0x226>
ffffffffc0205df2:	42d4                	lw	a3,4(a3)
ffffffffc0205df4:	04db2823          	sw	a3,80(s6)
ffffffffc0205df8:	6502                	ld	a0,0(sp)
ffffffffc0205dfa:	85da                	mv	a1,s6
ffffffffc0205dfc:	e43e                	sd	a5,8(sp)
ffffffffc0205dfe:	f2cfb0ef          	jal	ra,ffffffffc020152a <dup_mmap>
ffffffffc0205e02:	67a2                	ld	a5,8(sp)
ffffffffc0205e04:	8aaa                	mv	s5,a0
ffffffffc0205e06:	853e                	mv	a0,a5
ffffffffc0205e08:	93ffe0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0205e0c:	040b2823          	sw	zero,80(s6)
ffffffffc0205e10:	160a9c63          	bnez	s5,ffffffffc0205f88 <do_fork+0x3b6>
ffffffffc0205e14:	6b02                	ld	s6,0(sp)
ffffffffc0205e16:	bd85                	j	ffffffffc0205c86 <do_fork+0xb4>
ffffffffc0205e18:	9cfff0ef          	jal	ra,ffffffffc02057e6 <files_create>
ffffffffc0205e1c:	89aa                	mv	s3,a0
ffffffffc0205e1e:	18050c63          	beqz	a0,ffffffffc0205fb6 <do_fork+0x3e4>
ffffffffc0205e22:	85da                	mv	a1,s6
ffffffffc0205e24:	afbff0ef          	jal	ra,ffffffffc020591e <dup_files>
ffffffffc0205e28:	8aaa                	mv	s5,a0
ffffffffc0205e2a:	8b4e                	mv	s6,s3
ffffffffc0205e2c:	e8050ae3          	beqz	a0,ffffffffc0205cc0 <do_fork+0xee>
ffffffffc0205e30:	854e                	mv	a0,s3
ffffffffc0205e32:	9ebff0ef          	jal	ra,ffffffffc020581c <files_destroy>
ffffffffc0205e36:	14843503          	ld	a0,328(s0)
ffffffffc0205e3a:	c519                	beqz	a0,ffffffffc0205e48 <do_fork+0x276>
ffffffffc0205e3c:	491c                	lw	a5,16(a0)
ffffffffc0205e3e:	fff7869b          	addiw	a3,a5,-1
ffffffffc0205e42:	c914                	sw	a3,16(a0)
ffffffffc0205e44:	12068f63          	beqz	a3,ffffffffc0205f82 <do_fork+0x3b0>
ffffffffc0205e48:	7404                	ld	s1,40(s0)
ffffffffc0205e4a:	c8e1                	beqz	s1,ffffffffc0205f1a <do_fork+0x348>
ffffffffc0205e4c:	589c                	lw	a5,48(s1)
ffffffffc0205e4e:	02043423          	sd	zero,40(s0)
ffffffffc0205e52:	fff7869b          	addiw	a3,a5,-1
ffffffffc0205e56:	d894                	sw	a3,48(s1)
ffffffffc0205e58:	e2e9                	bnez	a3,ffffffffc0205f1a <do_fork+0x348>
ffffffffc0205e5a:	8526                	mv	a0,s1
ffffffffc0205e5c:	f68fb0ef          	jal	ra,ffffffffc02015c4 <exit_mmap>
ffffffffc0205e60:	6c88                	ld	a0,24(s1)
ffffffffc0205e62:	c93ff0ef          	jal	ra,ffffffffc0205af4 <put_pgdir.isra.0>
ffffffffc0205e66:	8526                	mv	a0,s1
ffffffffc0205e68:	dc0fb0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc0205e6c:	a07d                	j	ffffffffc0205f1a <do_fork+0x348>
ffffffffc0205e6e:	8a3a                	mv	s4,a4
ffffffffc0205e70:	bd69                	j	ffffffffc0205d0a <do_fork+0x138>
ffffffffc0205e72:	c581                	beqz	a1,ffffffffc0205e7a <do_fork+0x2a8>
ffffffffc0205e74:	00d82023          	sw	a3,0(a6)
ffffffffc0205e78:	8536                	mv	a0,a3
ffffffffc0205e7a:	00088463          	beqz	a7,ffffffffc0205e82 <do_fork+0x2b0>
ffffffffc0205e7e:	00c32023          	sw	a2,0(t1)
ffffffffc0205e82:	c048                	sw	a0,4(s0)
ffffffffc0205e84:	100027f3          	csrr	a5,sstatus
ffffffffc0205e88:	8b89                	andi	a5,a5,2
ffffffffc0205e8a:	4981                	li	s3,0
ffffffffc0205e8c:	0e079463          	bnez	a5,ffffffffc0205f74 <do_fork+0x3a2>
ffffffffc0205e90:	45a9                	li	a1,10
ffffffffc0205e92:	2501                	sext.w	a0,a0
ffffffffc0205e94:	646050ef          	jal	ra,ffffffffc020b4da <hash32>
ffffffffc0205e98:	02051793          	slli	a5,a0,0x20
ffffffffc0205e9c:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205ea0:	0008c797          	auipc	a5,0x8c
ffffffffc0205ea4:	92078793          	addi	a5,a5,-1760 # ffffffffc02917c0 <hash_list>
ffffffffc0205ea8:	953e                	add	a0,a0,a5
ffffffffc0205eaa:	650c                	ld	a1,8(a0)
ffffffffc0205eac:	7014                	ld	a3,32(s0)
ffffffffc0205eae:	0d840793          	addi	a5,s0,216
ffffffffc0205eb2:	e19c                	sd	a5,0(a1)
ffffffffc0205eb4:	00893603          	ld	a2,8(s2)
ffffffffc0205eb8:	e51c                	sd	a5,8(a0)
ffffffffc0205eba:	7af8                	ld	a4,240(a3)
ffffffffc0205ebc:	0c840793          	addi	a5,s0,200
ffffffffc0205ec0:	f06c                	sd	a1,224(s0)
ffffffffc0205ec2:	ec68                	sd	a0,216(s0)
ffffffffc0205ec4:	e21c                	sd	a5,0(a2)
ffffffffc0205ec6:	00f93423          	sd	a5,8(s2)
ffffffffc0205eca:	e870                	sd	a2,208(s0)
ffffffffc0205ecc:	0d243423          	sd	s2,200(s0)
ffffffffc0205ed0:	0e043c23          	sd	zero,248(s0)
ffffffffc0205ed4:	10e43023          	sd	a4,256(s0)
ffffffffc0205ed8:	c311                	beqz	a4,ffffffffc0205edc <do_fork+0x30a>
ffffffffc0205eda:	ff60                	sd	s0,248(a4)
ffffffffc0205edc:	409c                	lw	a5,0(s1)
ffffffffc0205ede:	fae0                	sd	s0,240(a3)
ffffffffc0205ee0:	2785                	addiw	a5,a5,1
ffffffffc0205ee2:	c09c                	sw	a5,0(s1)
ffffffffc0205ee4:	06099e63          	bnez	s3,ffffffffc0205f60 <do_fork+0x38e>
ffffffffc0205ee8:	8522                	mv	a0,s0
ffffffffc0205eea:	2d2010ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc0205eee:	00442a83          	lw	s5,4(s0)
ffffffffc0205ef2:	70e6                	ld	ra,120(sp)
ffffffffc0205ef4:	7446                	ld	s0,112(sp)
ffffffffc0205ef6:	74a6                	ld	s1,104(sp)
ffffffffc0205ef8:	7906                	ld	s2,96(sp)
ffffffffc0205efa:	69e6                	ld	s3,88(sp)
ffffffffc0205efc:	6a46                	ld	s4,80(sp)
ffffffffc0205efe:	6b06                	ld	s6,64(sp)
ffffffffc0205f00:	7be2                	ld	s7,56(sp)
ffffffffc0205f02:	7c42                	ld	s8,48(sp)
ffffffffc0205f04:	7ca2                	ld	s9,40(sp)
ffffffffc0205f06:	7d02                	ld	s10,32(sp)
ffffffffc0205f08:	6de2                	ld	s11,24(sp)
ffffffffc0205f0a:	8556                	mv	a0,s5
ffffffffc0205f0c:	6aa6                	ld	s5,72(sp)
ffffffffc0205f0e:	6109                	addi	sp,sp,128
ffffffffc0205f10:	8082                	ret
ffffffffc0205f12:	6502                	ld	a0,0(sp)
ffffffffc0205f14:	5af1                	li	s5,-4
ffffffffc0205f16:	d12fb0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc0205f1a:	6814                	ld	a3,16(s0)
ffffffffc0205f1c:	c02007b7          	lui	a5,0xc0200
ffffffffc0205f20:	0cf6e563          	bltu	a3,a5,ffffffffc0205fea <do_fork+0x418>
ffffffffc0205f24:	000c3703          	ld	a4,0(s8)
ffffffffc0205f28:	000db783          	ld	a5,0(s11)
ffffffffc0205f2c:	8e99                	sub	a3,a3,a4
ffffffffc0205f2e:	82b1                	srli	a3,a3,0xc
ffffffffc0205f30:	0af6f163          	bgeu	a3,a5,ffffffffc0205fd2 <do_fork+0x400>
ffffffffc0205f34:	000d3503          	ld	a0,0(s10)
ffffffffc0205f38:	419686b3          	sub	a3,a3,s9
ffffffffc0205f3c:	069a                	slli	a3,a3,0x6
ffffffffc0205f3e:	4589                	li	a1,2
ffffffffc0205f40:	9536                	add	a0,a0,a3
ffffffffc0205f42:	a9ffc0ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0205f46:	8522                	mv	a0,s0
ffffffffc0205f48:	e7ffb0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0205f4c:	b75d                	j	ffffffffc0205ef2 <do_fork+0x320>
ffffffffc0205f4e:	4785                	li	a5,1
ffffffffc0205f50:	00f82023          	sw	a5,0(a6)
ffffffffc0205f54:	4505                	li	a0,1
ffffffffc0205f56:	0008b317          	auipc	t1,0x8b
ffffffffc0205f5a:	10630313          	addi	t1,t1,262 # ffffffffc029105c <next_safe.0>
ffffffffc0205f5e:	b3fd                	j	ffffffffc0205d4c <do_fork+0x17a>
ffffffffc0205f60:	e3ffa0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0205f64:	b751                	j	ffffffffc0205ee8 <do_fork+0x316>
ffffffffc0205f66:	01d6c363          	blt	a3,t4,ffffffffc0205f6c <do_fork+0x39a>
ffffffffc0205f6a:	4685                	li	a3,1
ffffffffc0205f6c:	4585                	li	a1,1
ffffffffc0205f6e:	bbdd                	j	ffffffffc0205d64 <do_fork+0x192>
ffffffffc0205f70:	5af1                	li	s5,-4
ffffffffc0205f72:	bfd1                	j	ffffffffc0205f46 <do_fork+0x374>
ffffffffc0205f74:	e31fa0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0205f78:	4048                	lw	a0,4(s0)
ffffffffc0205f7a:	4985                	li	s3,1
ffffffffc0205f7c:	bf11                	j	ffffffffc0205e90 <do_fork+0x2be>
ffffffffc0205f7e:	5aed                	li	s5,-5
ffffffffc0205f80:	bf8d                	j	ffffffffc0205ef2 <do_fork+0x320>
ffffffffc0205f82:	89bff0ef          	jal	ra,ffffffffc020581c <files_destroy>
ffffffffc0205f86:	b5c9                	j	ffffffffc0205e48 <do_fork+0x276>
ffffffffc0205f88:	6482                	ld	s1,0(sp)
ffffffffc0205f8a:	8526                	mv	a0,s1
ffffffffc0205f8c:	e38fb0ef          	jal	ra,ffffffffc02015c4 <exit_mmap>
ffffffffc0205f90:	6c88                	ld	a0,24(s1)
ffffffffc0205f92:	b63ff0ef          	jal	ra,ffffffffc0205af4 <put_pgdir.isra.0>
ffffffffc0205f96:	8526                	mv	a0,s1
ffffffffc0205f98:	c90fb0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc0205f9c:	bfbd                	j	ffffffffc0205f1a <do_fork+0x348>
ffffffffc0205f9e:	5af1                	li	s5,-4
ffffffffc0205fa0:	bf89                	j	ffffffffc0205ef2 <do_fork+0x320>
ffffffffc0205fa2:	c599                	beqz	a1,ffffffffc0205fb0 <do_fork+0x3de>
ffffffffc0205fa4:	00d82023          	sw	a3,0(a6)
ffffffffc0205fa8:	8536                	mv	a0,a3
ffffffffc0205faa:	bde1                	j	ffffffffc0205e82 <do_fork+0x2b0>
ffffffffc0205fac:	5af1                	li	s5,-4
ffffffffc0205fae:	b7b5                	j	ffffffffc0205f1a <do_fork+0x348>
ffffffffc0205fb0:	00082503          	lw	a0,0(a6)
ffffffffc0205fb4:	b5f9                	j	ffffffffc0205e82 <do_fork+0x2b0>
ffffffffc0205fb6:	5af1                	li	s5,-4
ffffffffc0205fb8:	bdbd                	j	ffffffffc0205e36 <do_fork+0x264>
ffffffffc0205fba:	00006617          	auipc	a2,0x6
ffffffffc0205fbe:	36e60613          	addi	a2,a2,878 # ffffffffc020c328 <commands+0xb90>
ffffffffc0205fc2:	07100593          	li	a1,113
ffffffffc0205fc6:	00006517          	auipc	a0,0x6
ffffffffc0205fca:	38a50513          	addi	a0,a0,906 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0205fce:	a60fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0205fd2:	00006617          	auipc	a2,0x6
ffffffffc0205fd6:	42660613          	addi	a2,a2,1062 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc0205fda:	06900593          	li	a1,105
ffffffffc0205fde:	00006517          	auipc	a0,0x6
ffffffffc0205fe2:	37250513          	addi	a0,a0,882 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0205fe6:	a48fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0205fea:	00006617          	auipc	a2,0x6
ffffffffc0205fee:	3e660613          	addi	a2,a2,998 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0205ff2:	07700593          	li	a1,119
ffffffffc0205ff6:	00006517          	auipc	a0,0x6
ffffffffc0205ffa:	35a50513          	addi	a0,a0,858 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0205ffe:	a30fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206002:	00006617          	auipc	a2,0x6
ffffffffc0206006:	3ce60613          	addi	a2,a2,974 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc020600a:	1b100593          	li	a1,433
ffffffffc020600e:	00007517          	auipc	a0,0x7
ffffffffc0206012:	45a50513          	addi	a0,a0,1114 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206016:	a18fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020601a:	00007697          	auipc	a3,0x7
ffffffffc020601e:	46668693          	addi	a3,a3,1126 # ffffffffc020d480 <CSWTCH.79+0xe0>
ffffffffc0206022:	00005617          	auipc	a2,0x5
ffffffffc0206026:	7d660613          	addi	a2,a2,2006 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020602a:	1d100593          	li	a1,465
ffffffffc020602e:	00007517          	auipc	a0,0x7
ffffffffc0206032:	43a50513          	addi	a0,a0,1082 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206036:	9f8fa0ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020603a <kernel_thread>:
ffffffffc020603a:	7129                	addi	sp,sp,-320
ffffffffc020603c:	fa22                	sd	s0,304(sp)
ffffffffc020603e:	f626                	sd	s1,296(sp)
ffffffffc0206040:	f24a                	sd	s2,288(sp)
ffffffffc0206042:	84ae                	mv	s1,a1
ffffffffc0206044:	892a                	mv	s2,a0
ffffffffc0206046:	8432                	mv	s0,a2
ffffffffc0206048:	4581                	li	a1,0
ffffffffc020604a:	12000613          	li	a2,288
ffffffffc020604e:	850a                	mv	a0,sp
ffffffffc0206050:	fe06                	sd	ra,312(sp)
ffffffffc0206052:	7a3040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206056:	e0ca                	sd	s2,64(sp)
ffffffffc0206058:	e4a6                	sd	s1,72(sp)
ffffffffc020605a:	100027f3          	csrr	a5,sstatus
ffffffffc020605e:	edd7f793          	andi	a5,a5,-291
ffffffffc0206062:	1207e793          	ori	a5,a5,288
ffffffffc0206066:	e23e                	sd	a5,256(sp)
ffffffffc0206068:	860a                	mv	a2,sp
ffffffffc020606a:	10046513          	ori	a0,s0,256
ffffffffc020606e:	00000797          	auipc	a5,0x0
ffffffffc0206072:	96878793          	addi	a5,a5,-1688 # ffffffffc02059d6 <kernel_thread_entry>
ffffffffc0206076:	4581                	li	a1,0
ffffffffc0206078:	e63e                	sd	a5,264(sp)
ffffffffc020607a:	b59ff0ef          	jal	ra,ffffffffc0205bd2 <do_fork>
ffffffffc020607e:	70f2                	ld	ra,312(sp)
ffffffffc0206080:	7452                	ld	s0,304(sp)
ffffffffc0206082:	74b2                	ld	s1,296(sp)
ffffffffc0206084:	7912                	ld	s2,288(sp)
ffffffffc0206086:	6131                	addi	sp,sp,320
ffffffffc0206088:	8082                	ret

ffffffffc020608a <do_exit>:
ffffffffc020608a:	7179                	addi	sp,sp,-48
ffffffffc020608c:	f022                	sd	s0,32(sp)
ffffffffc020608e:	00091417          	auipc	s0,0x91
ffffffffc0206092:	83240413          	addi	s0,s0,-1998 # ffffffffc02968c0 <current>
ffffffffc0206096:	601c                	ld	a5,0(s0)
ffffffffc0206098:	f406                	sd	ra,40(sp)
ffffffffc020609a:	ec26                	sd	s1,24(sp)
ffffffffc020609c:	e84a                	sd	s2,16(sp)
ffffffffc020609e:	e44e                	sd	s3,8(sp)
ffffffffc02060a0:	e052                	sd	s4,0(sp)
ffffffffc02060a2:	00091717          	auipc	a4,0x91
ffffffffc02060a6:	82673703          	ld	a4,-2010(a4) # ffffffffc02968c8 <idleproc>
ffffffffc02060aa:	0ee78763          	beq	a5,a4,ffffffffc0206198 <do_exit+0x10e>
ffffffffc02060ae:	00091497          	auipc	s1,0x91
ffffffffc02060b2:	82248493          	addi	s1,s1,-2014 # ffffffffc02968d0 <initproc>
ffffffffc02060b6:	6098                	ld	a4,0(s1)
ffffffffc02060b8:	10e78763          	beq	a5,a4,ffffffffc02061c6 <do_exit+0x13c>
ffffffffc02060bc:	0287b983          	ld	s3,40(a5)
ffffffffc02060c0:	892a                	mv	s2,a0
ffffffffc02060c2:	02098e63          	beqz	s3,ffffffffc02060fe <do_exit+0x74>
ffffffffc02060c6:	00090797          	auipc	a5,0x90
ffffffffc02060ca:	7ca7b783          	ld	a5,1994(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02060ce:	577d                	li	a4,-1
ffffffffc02060d0:	177e                	slli	a4,a4,0x3f
ffffffffc02060d2:	83b1                	srli	a5,a5,0xc
ffffffffc02060d4:	8fd9                	or	a5,a5,a4
ffffffffc02060d6:	18079073          	csrw	satp,a5
ffffffffc02060da:	0309a783          	lw	a5,48(s3)
ffffffffc02060de:	fff7871b          	addiw	a4,a5,-1
ffffffffc02060e2:	02e9a823          	sw	a4,48(s3)
ffffffffc02060e6:	c769                	beqz	a4,ffffffffc02061b0 <do_exit+0x126>
ffffffffc02060e8:	601c                	ld	a5,0(s0)
ffffffffc02060ea:	1487b503          	ld	a0,328(a5)
ffffffffc02060ee:	0207b423          	sd	zero,40(a5)
ffffffffc02060f2:	c511                	beqz	a0,ffffffffc02060fe <do_exit+0x74>
ffffffffc02060f4:	491c                	lw	a5,16(a0)
ffffffffc02060f6:	fff7871b          	addiw	a4,a5,-1
ffffffffc02060fa:	c918                	sw	a4,16(a0)
ffffffffc02060fc:	cb59                	beqz	a4,ffffffffc0206192 <do_exit+0x108>
ffffffffc02060fe:	601c                	ld	a5,0(s0)
ffffffffc0206100:	470d                	li	a4,3
ffffffffc0206102:	c398                	sw	a4,0(a5)
ffffffffc0206104:	0f27a423          	sw	s2,232(a5)
ffffffffc0206108:	100027f3          	csrr	a5,sstatus
ffffffffc020610c:	8b89                	andi	a5,a5,2
ffffffffc020610e:	4a01                	li	s4,0
ffffffffc0206110:	e7f9                	bnez	a5,ffffffffc02061de <do_exit+0x154>
ffffffffc0206112:	6018                	ld	a4,0(s0)
ffffffffc0206114:	800007b7          	lui	a5,0x80000
ffffffffc0206118:	0785                	addi	a5,a5,1
ffffffffc020611a:	7308                	ld	a0,32(a4)
ffffffffc020611c:	0ec52703          	lw	a4,236(a0)
ffffffffc0206120:	0cf70363          	beq	a4,a5,ffffffffc02061e6 <do_exit+0x15c>
ffffffffc0206124:	6018                	ld	a4,0(s0)
ffffffffc0206126:	7b7c                	ld	a5,240(a4)
ffffffffc0206128:	c3a1                	beqz	a5,ffffffffc0206168 <do_exit+0xde>
ffffffffc020612a:	800009b7          	lui	s3,0x80000
ffffffffc020612e:	490d                	li	s2,3
ffffffffc0206130:	0985                	addi	s3,s3,1
ffffffffc0206132:	a021                	j	ffffffffc020613a <do_exit+0xb0>
ffffffffc0206134:	6018                	ld	a4,0(s0)
ffffffffc0206136:	7b7c                	ld	a5,240(a4)
ffffffffc0206138:	cb85                	beqz	a5,ffffffffc0206168 <do_exit+0xde>
ffffffffc020613a:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc020613e:	6088                	ld	a0,0(s1)
ffffffffc0206140:	fb74                	sd	a3,240(a4)
ffffffffc0206142:	7978                	ld	a4,240(a0)
ffffffffc0206144:	0e07bc23          	sd	zero,248(a5)
ffffffffc0206148:	10e7b023          	sd	a4,256(a5)
ffffffffc020614c:	c311                	beqz	a4,ffffffffc0206150 <do_exit+0xc6>
ffffffffc020614e:	ff7c                	sd	a5,248(a4)
ffffffffc0206150:	4398                	lw	a4,0(a5)
ffffffffc0206152:	f388                	sd	a0,32(a5)
ffffffffc0206154:	f97c                	sd	a5,240(a0)
ffffffffc0206156:	fd271fe3          	bne	a4,s2,ffffffffc0206134 <do_exit+0xaa>
ffffffffc020615a:	0ec52783          	lw	a5,236(a0)
ffffffffc020615e:	fd379be3          	bne	a5,s3,ffffffffc0206134 <do_exit+0xaa>
ffffffffc0206162:	05a010ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc0206166:	b7f9                	j	ffffffffc0206134 <do_exit+0xaa>
ffffffffc0206168:	020a1263          	bnez	s4,ffffffffc020618c <do_exit+0x102>
ffffffffc020616c:	102010ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc0206170:	601c                	ld	a5,0(s0)
ffffffffc0206172:	00007617          	auipc	a2,0x7
ffffffffc0206176:	34660613          	addi	a2,a2,838 # ffffffffc020d4b8 <CSWTCH.79+0x118>
ffffffffc020617a:	2a800593          	li	a1,680
ffffffffc020617e:	43d4                	lw	a3,4(a5)
ffffffffc0206180:	00007517          	auipc	a0,0x7
ffffffffc0206184:	2e850513          	addi	a0,a0,744 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206188:	8a6fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020618c:	c13fa0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0206190:	bff1                	j	ffffffffc020616c <do_exit+0xe2>
ffffffffc0206192:	e8aff0ef          	jal	ra,ffffffffc020581c <files_destroy>
ffffffffc0206196:	b7a5                	j	ffffffffc02060fe <do_exit+0x74>
ffffffffc0206198:	00007617          	auipc	a2,0x7
ffffffffc020619c:	30060613          	addi	a2,a2,768 # ffffffffc020d498 <CSWTCH.79+0xf8>
ffffffffc02061a0:	27300593          	li	a1,627
ffffffffc02061a4:	00007517          	auipc	a0,0x7
ffffffffc02061a8:	2c450513          	addi	a0,a0,708 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc02061ac:	882fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02061b0:	854e                	mv	a0,s3
ffffffffc02061b2:	c12fb0ef          	jal	ra,ffffffffc02015c4 <exit_mmap>
ffffffffc02061b6:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc02061ba:	93bff0ef          	jal	ra,ffffffffc0205af4 <put_pgdir.isra.0>
ffffffffc02061be:	854e                	mv	a0,s3
ffffffffc02061c0:	a68fb0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc02061c4:	b715                	j	ffffffffc02060e8 <do_exit+0x5e>
ffffffffc02061c6:	00007617          	auipc	a2,0x7
ffffffffc02061ca:	2e260613          	addi	a2,a2,738 # ffffffffc020d4a8 <CSWTCH.79+0x108>
ffffffffc02061ce:	27700593          	li	a1,631
ffffffffc02061d2:	00007517          	auipc	a0,0x7
ffffffffc02061d6:	29650513          	addi	a0,a0,662 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc02061da:	854fa0ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02061de:	bc7fa0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02061e2:	4a05                	li	s4,1
ffffffffc02061e4:	b73d                	j	ffffffffc0206112 <do_exit+0x88>
ffffffffc02061e6:	7d7000ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc02061ea:	bf2d                	j	ffffffffc0206124 <do_exit+0x9a>

ffffffffc02061ec <do_wait.part.0>:
ffffffffc02061ec:	715d                	addi	sp,sp,-80
ffffffffc02061ee:	f84a                	sd	s2,48(sp)
ffffffffc02061f0:	f44e                	sd	s3,40(sp)
ffffffffc02061f2:	80000937          	lui	s2,0x80000
ffffffffc02061f6:	6989                	lui	s3,0x2
ffffffffc02061f8:	fc26                	sd	s1,56(sp)
ffffffffc02061fa:	f052                	sd	s4,32(sp)
ffffffffc02061fc:	ec56                	sd	s5,24(sp)
ffffffffc02061fe:	e85a                	sd	s6,16(sp)
ffffffffc0206200:	e45e                	sd	s7,8(sp)
ffffffffc0206202:	e486                	sd	ra,72(sp)
ffffffffc0206204:	e0a2                	sd	s0,64(sp)
ffffffffc0206206:	84aa                	mv	s1,a0
ffffffffc0206208:	8a2e                	mv	s4,a1
ffffffffc020620a:	00090b97          	auipc	s7,0x90
ffffffffc020620e:	6b6b8b93          	addi	s7,s7,1718 # ffffffffc02968c0 <current>
ffffffffc0206212:	00050b1b          	sext.w	s6,a0
ffffffffc0206216:	fff50a9b          	addiw	s5,a0,-1
ffffffffc020621a:	19f9                	addi	s3,s3,-2
ffffffffc020621c:	0905                	addi	s2,s2,1
ffffffffc020621e:	ccbd                	beqz	s1,ffffffffc020629c <do_wait.part.0+0xb0>
ffffffffc0206220:	0359e863          	bltu	s3,s5,ffffffffc0206250 <do_wait.part.0+0x64>
ffffffffc0206224:	45a9                	li	a1,10
ffffffffc0206226:	855a                	mv	a0,s6
ffffffffc0206228:	2b2050ef          	jal	ra,ffffffffc020b4da <hash32>
ffffffffc020622c:	02051793          	slli	a5,a0,0x20
ffffffffc0206230:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206234:	0008b797          	auipc	a5,0x8b
ffffffffc0206238:	58c78793          	addi	a5,a5,1420 # ffffffffc02917c0 <hash_list>
ffffffffc020623c:	953e                	add	a0,a0,a5
ffffffffc020623e:	842a                	mv	s0,a0
ffffffffc0206240:	a029                	j	ffffffffc020624a <do_wait.part.0+0x5e>
ffffffffc0206242:	f2c42783          	lw	a5,-212(s0)
ffffffffc0206246:	02978163          	beq	a5,s1,ffffffffc0206268 <do_wait.part.0+0x7c>
ffffffffc020624a:	6400                	ld	s0,8(s0)
ffffffffc020624c:	fe851be3          	bne	a0,s0,ffffffffc0206242 <do_wait.part.0+0x56>
ffffffffc0206250:	5579                	li	a0,-2
ffffffffc0206252:	60a6                	ld	ra,72(sp)
ffffffffc0206254:	6406                	ld	s0,64(sp)
ffffffffc0206256:	74e2                	ld	s1,56(sp)
ffffffffc0206258:	7942                	ld	s2,48(sp)
ffffffffc020625a:	79a2                	ld	s3,40(sp)
ffffffffc020625c:	7a02                	ld	s4,32(sp)
ffffffffc020625e:	6ae2                	ld	s5,24(sp)
ffffffffc0206260:	6b42                	ld	s6,16(sp)
ffffffffc0206262:	6ba2                	ld	s7,8(sp)
ffffffffc0206264:	6161                	addi	sp,sp,80
ffffffffc0206266:	8082                	ret
ffffffffc0206268:	000bb683          	ld	a3,0(s7)
ffffffffc020626c:	f4843783          	ld	a5,-184(s0)
ffffffffc0206270:	fed790e3          	bne	a5,a3,ffffffffc0206250 <do_wait.part.0+0x64>
ffffffffc0206274:	f2842703          	lw	a4,-216(s0)
ffffffffc0206278:	478d                	li	a5,3
ffffffffc020627a:	0ef70b63          	beq	a4,a5,ffffffffc0206370 <do_wait.part.0+0x184>
ffffffffc020627e:	4785                	li	a5,1
ffffffffc0206280:	c29c                	sw	a5,0(a3)
ffffffffc0206282:	0f26a623          	sw	s2,236(a3)
ffffffffc0206286:	7e9000ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc020628a:	000bb783          	ld	a5,0(s7)
ffffffffc020628e:	0b07a783          	lw	a5,176(a5)
ffffffffc0206292:	8b85                	andi	a5,a5,1
ffffffffc0206294:	d7c9                	beqz	a5,ffffffffc020621e <do_wait.part.0+0x32>
ffffffffc0206296:	555d                	li	a0,-9
ffffffffc0206298:	df3ff0ef          	jal	ra,ffffffffc020608a <do_exit>
ffffffffc020629c:	000bb683          	ld	a3,0(s7)
ffffffffc02062a0:	7ae0                	ld	s0,240(a3)
ffffffffc02062a2:	d45d                	beqz	s0,ffffffffc0206250 <do_wait.part.0+0x64>
ffffffffc02062a4:	470d                	li	a4,3
ffffffffc02062a6:	a021                	j	ffffffffc02062ae <do_wait.part.0+0xc2>
ffffffffc02062a8:	10043403          	ld	s0,256(s0)
ffffffffc02062ac:	d869                	beqz	s0,ffffffffc020627e <do_wait.part.0+0x92>
ffffffffc02062ae:	401c                	lw	a5,0(s0)
ffffffffc02062b0:	fee79ce3          	bne	a5,a4,ffffffffc02062a8 <do_wait.part.0+0xbc>
ffffffffc02062b4:	00090797          	auipc	a5,0x90
ffffffffc02062b8:	6147b783          	ld	a5,1556(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02062bc:	0c878963          	beq	a5,s0,ffffffffc020638e <do_wait.part.0+0x1a2>
ffffffffc02062c0:	00090797          	auipc	a5,0x90
ffffffffc02062c4:	6107b783          	ld	a5,1552(a5) # ffffffffc02968d0 <initproc>
ffffffffc02062c8:	0cf40363          	beq	s0,a5,ffffffffc020638e <do_wait.part.0+0x1a2>
ffffffffc02062cc:	000a0663          	beqz	s4,ffffffffc02062d8 <do_wait.part.0+0xec>
ffffffffc02062d0:	0e842783          	lw	a5,232(s0)
ffffffffc02062d4:	00fa2023          	sw	a5,0(s4)
ffffffffc02062d8:	100027f3          	csrr	a5,sstatus
ffffffffc02062dc:	8b89                	andi	a5,a5,2
ffffffffc02062de:	4581                	li	a1,0
ffffffffc02062e0:	e7c1                	bnez	a5,ffffffffc0206368 <do_wait.part.0+0x17c>
ffffffffc02062e2:	6c70                	ld	a2,216(s0)
ffffffffc02062e4:	7074                	ld	a3,224(s0)
ffffffffc02062e6:	10043703          	ld	a4,256(s0)
ffffffffc02062ea:	7c7c                	ld	a5,248(s0)
ffffffffc02062ec:	e614                	sd	a3,8(a2)
ffffffffc02062ee:	e290                	sd	a2,0(a3)
ffffffffc02062f0:	6470                	ld	a2,200(s0)
ffffffffc02062f2:	6874                	ld	a3,208(s0)
ffffffffc02062f4:	e614                	sd	a3,8(a2)
ffffffffc02062f6:	e290                	sd	a2,0(a3)
ffffffffc02062f8:	c319                	beqz	a4,ffffffffc02062fe <do_wait.part.0+0x112>
ffffffffc02062fa:	ff7c                	sd	a5,248(a4)
ffffffffc02062fc:	7c7c                	ld	a5,248(s0)
ffffffffc02062fe:	c3b5                	beqz	a5,ffffffffc0206362 <do_wait.part.0+0x176>
ffffffffc0206300:	10e7b023          	sd	a4,256(a5)
ffffffffc0206304:	00090717          	auipc	a4,0x90
ffffffffc0206308:	5d470713          	addi	a4,a4,1492 # ffffffffc02968d8 <nr_process>
ffffffffc020630c:	431c                	lw	a5,0(a4)
ffffffffc020630e:	37fd                	addiw	a5,a5,-1
ffffffffc0206310:	c31c                	sw	a5,0(a4)
ffffffffc0206312:	e5a9                	bnez	a1,ffffffffc020635c <do_wait.part.0+0x170>
ffffffffc0206314:	6814                	ld	a3,16(s0)
ffffffffc0206316:	c02007b7          	lui	a5,0xc0200
ffffffffc020631a:	04f6ee63          	bltu	a3,a5,ffffffffc0206376 <do_wait.part.0+0x18a>
ffffffffc020631e:	00090797          	auipc	a5,0x90
ffffffffc0206322:	59a7b783          	ld	a5,1434(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206326:	8e9d                	sub	a3,a3,a5
ffffffffc0206328:	82b1                	srli	a3,a3,0xc
ffffffffc020632a:	00090797          	auipc	a5,0x90
ffffffffc020632e:	5767b783          	ld	a5,1398(a5) # ffffffffc02968a0 <npage>
ffffffffc0206332:	06f6fa63          	bgeu	a3,a5,ffffffffc02063a6 <do_wait.part.0+0x1ba>
ffffffffc0206336:	00009517          	auipc	a0,0x9
ffffffffc020633a:	3aa53503          	ld	a0,938(a0) # ffffffffc020f6e0 <nbase>
ffffffffc020633e:	8e89                	sub	a3,a3,a0
ffffffffc0206340:	069a                	slli	a3,a3,0x6
ffffffffc0206342:	00090517          	auipc	a0,0x90
ffffffffc0206346:	56653503          	ld	a0,1382(a0) # ffffffffc02968a8 <pages>
ffffffffc020634a:	9536                	add	a0,a0,a3
ffffffffc020634c:	4589                	li	a1,2
ffffffffc020634e:	e92fc0ef          	jal	ra,ffffffffc02029e0 <free_pages>
ffffffffc0206352:	8522                	mv	a0,s0
ffffffffc0206354:	a73fb0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0206358:	4501                	li	a0,0
ffffffffc020635a:	bde5                	j	ffffffffc0206252 <do_wait.part.0+0x66>
ffffffffc020635c:	a43fa0ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0206360:	bf55                	j	ffffffffc0206314 <do_wait.part.0+0x128>
ffffffffc0206362:	701c                	ld	a5,32(s0)
ffffffffc0206364:	fbf8                	sd	a4,240(a5)
ffffffffc0206366:	bf79                	j	ffffffffc0206304 <do_wait.part.0+0x118>
ffffffffc0206368:	a3dfa0ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020636c:	4585                	li	a1,1
ffffffffc020636e:	bf95                	j	ffffffffc02062e2 <do_wait.part.0+0xf6>
ffffffffc0206370:	f2840413          	addi	s0,s0,-216
ffffffffc0206374:	b781                	j	ffffffffc02062b4 <do_wait.part.0+0xc8>
ffffffffc0206376:	00006617          	auipc	a2,0x6
ffffffffc020637a:	05a60613          	addi	a2,a2,90 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc020637e:	07700593          	li	a1,119
ffffffffc0206382:	00006517          	auipc	a0,0x6
ffffffffc0206386:	fce50513          	addi	a0,a0,-50 # ffffffffc020c350 <commands+0xbb8>
ffffffffc020638a:	ea5f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020638e:	00007617          	auipc	a2,0x7
ffffffffc0206392:	14a60613          	addi	a2,a2,330 # ffffffffc020d4d8 <CSWTCH.79+0x138>
ffffffffc0206396:	45300593          	li	a1,1107
ffffffffc020639a:	00007517          	auipc	a0,0x7
ffffffffc020639e:	0ce50513          	addi	a0,a0,206 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc02063a2:	e8df90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02063a6:	00006617          	auipc	a2,0x6
ffffffffc02063aa:	05260613          	addi	a2,a2,82 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc02063ae:	06900593          	li	a1,105
ffffffffc02063b2:	00006517          	auipc	a0,0x6
ffffffffc02063b6:	f9e50513          	addi	a0,a0,-98 # ffffffffc020c350 <commands+0xbb8>
ffffffffc02063ba:	e75f90ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02063be <init_main>:
ffffffffc02063be:	1141                	addi	sp,sp,-16
ffffffffc02063c0:	00007517          	auipc	a0,0x7
ffffffffc02063c4:	13850513          	addi	a0,a0,312 # ffffffffc020d4f8 <CSWTCH.79+0x158>
ffffffffc02063c8:	e406                	sd	ra,8(sp)
ffffffffc02063ca:	076020ef          	jal	ra,ffffffffc0208440 <vfs_set_bootfs>
ffffffffc02063ce:	e179                	bnez	a0,ffffffffc0206494 <init_main+0xd6>
ffffffffc02063d0:	e50fc0ef          	jal	ra,ffffffffc0202a20 <nr_free_pages>
ffffffffc02063d4:	93ffb0ef          	jal	ra,ffffffffc0201d12 <kallocated>
ffffffffc02063d8:	4601                	li	a2,0
ffffffffc02063da:	4581                	li	a1,0
ffffffffc02063dc:	00001517          	auipc	a0,0x1
ffffffffc02063e0:	98c50513          	addi	a0,a0,-1652 # ffffffffc0206d68 <user_main>
ffffffffc02063e4:	c57ff0ef          	jal	ra,ffffffffc020603a <kernel_thread>
ffffffffc02063e8:	00a04563          	bgtz	a0,ffffffffc02063f2 <init_main+0x34>
ffffffffc02063ec:	a841                	j	ffffffffc020647c <init_main+0xbe>
ffffffffc02063ee:	681000ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc02063f2:	4581                	li	a1,0
ffffffffc02063f4:	4501                	li	a0,0
ffffffffc02063f6:	df7ff0ef          	jal	ra,ffffffffc02061ec <do_wait.part.0>
ffffffffc02063fa:	d975                	beqz	a0,ffffffffc02063ee <init_main+0x30>
ffffffffc02063fc:	bdaff0ef          	jal	ra,ffffffffc02057d6 <fs_cleanup>
ffffffffc0206400:	00007517          	auipc	a0,0x7
ffffffffc0206404:	14050513          	addi	a0,a0,320 # ffffffffc020d540 <CSWTCH.79+0x1a0>
ffffffffc0206408:	d23f90ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc020640c:	00090797          	auipc	a5,0x90
ffffffffc0206410:	4c47b783          	ld	a5,1220(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206414:	7bf8                	ld	a4,240(a5)
ffffffffc0206416:	e339                	bnez	a4,ffffffffc020645c <init_main+0x9e>
ffffffffc0206418:	7ff8                	ld	a4,248(a5)
ffffffffc020641a:	e329                	bnez	a4,ffffffffc020645c <init_main+0x9e>
ffffffffc020641c:	1007b703          	ld	a4,256(a5)
ffffffffc0206420:	ef15                	bnez	a4,ffffffffc020645c <init_main+0x9e>
ffffffffc0206422:	00090697          	auipc	a3,0x90
ffffffffc0206426:	4b66a683          	lw	a3,1206(a3) # ffffffffc02968d8 <nr_process>
ffffffffc020642a:	4709                	li	a4,2
ffffffffc020642c:	0ce69163          	bne	a3,a4,ffffffffc02064ee <init_main+0x130>
ffffffffc0206430:	0008f717          	auipc	a4,0x8f
ffffffffc0206434:	39070713          	addi	a4,a4,912 # ffffffffc02957c0 <proc_list>
ffffffffc0206438:	6714                	ld	a3,8(a4)
ffffffffc020643a:	0c878793          	addi	a5,a5,200
ffffffffc020643e:	08d79863          	bne	a5,a3,ffffffffc02064ce <init_main+0x110>
ffffffffc0206442:	6318                	ld	a4,0(a4)
ffffffffc0206444:	06e79563          	bne	a5,a4,ffffffffc02064ae <init_main+0xf0>
ffffffffc0206448:	00007517          	auipc	a0,0x7
ffffffffc020644c:	1e050513          	addi	a0,a0,480 # ffffffffc020d628 <CSWTCH.79+0x288>
ffffffffc0206450:	cdbf90ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0206454:	60a2                	ld	ra,8(sp)
ffffffffc0206456:	4501                	li	a0,0
ffffffffc0206458:	0141                	addi	sp,sp,16
ffffffffc020645a:	8082                	ret
ffffffffc020645c:	00007697          	auipc	a3,0x7
ffffffffc0206460:	10c68693          	addi	a3,a3,268 # ffffffffc020d568 <CSWTCH.79+0x1c8>
ffffffffc0206464:	00005617          	auipc	a2,0x5
ffffffffc0206468:	39460613          	addi	a2,a2,916 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020646c:	4c900593          	li	a1,1225
ffffffffc0206470:	00007517          	auipc	a0,0x7
ffffffffc0206474:	ff850513          	addi	a0,a0,-8 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206478:	db7f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020647c:	00007617          	auipc	a2,0x7
ffffffffc0206480:	0a460613          	addi	a2,a2,164 # ffffffffc020d520 <CSWTCH.79+0x180>
ffffffffc0206484:	4bc00593          	li	a1,1212
ffffffffc0206488:	00007517          	auipc	a0,0x7
ffffffffc020648c:	fe050513          	addi	a0,a0,-32 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206490:	d9ff90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206494:	86aa                	mv	a3,a0
ffffffffc0206496:	00007617          	auipc	a2,0x7
ffffffffc020649a:	06a60613          	addi	a2,a2,106 # ffffffffc020d500 <CSWTCH.79+0x160>
ffffffffc020649e:	4b400593          	li	a1,1204
ffffffffc02064a2:	00007517          	auipc	a0,0x7
ffffffffc02064a6:	fc650513          	addi	a0,a0,-58 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc02064aa:	d85f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02064ae:	00007697          	auipc	a3,0x7
ffffffffc02064b2:	14a68693          	addi	a3,a3,330 # ffffffffc020d5f8 <CSWTCH.79+0x258>
ffffffffc02064b6:	00005617          	auipc	a2,0x5
ffffffffc02064ba:	34260613          	addi	a2,a2,834 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02064be:	4cc00593          	li	a1,1228
ffffffffc02064c2:	00007517          	auipc	a0,0x7
ffffffffc02064c6:	fa650513          	addi	a0,a0,-90 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc02064ca:	d65f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02064ce:	00007697          	auipc	a3,0x7
ffffffffc02064d2:	0fa68693          	addi	a3,a3,250 # ffffffffc020d5c8 <CSWTCH.79+0x228>
ffffffffc02064d6:	00005617          	auipc	a2,0x5
ffffffffc02064da:	32260613          	addi	a2,a2,802 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02064de:	4cb00593          	li	a1,1227
ffffffffc02064e2:	00007517          	auipc	a0,0x7
ffffffffc02064e6:	f8650513          	addi	a0,a0,-122 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc02064ea:	d45f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02064ee:	00007697          	auipc	a3,0x7
ffffffffc02064f2:	0ca68693          	addi	a3,a3,202 # ffffffffc020d5b8 <CSWTCH.79+0x218>
ffffffffc02064f6:	00005617          	auipc	a2,0x5
ffffffffc02064fa:	30260613          	addi	a2,a2,770 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02064fe:	4ca00593          	li	a1,1226
ffffffffc0206502:	00007517          	auipc	a0,0x7
ffffffffc0206506:	f6650513          	addi	a0,a0,-154 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc020650a:	d25f90ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020650e <do_execve>:
ffffffffc020650e:	ca010113          	addi	sp,sp,-864
ffffffffc0206512:	33413823          	sd	s4,816(sp)
ffffffffc0206516:	00090a17          	auipc	s4,0x90
ffffffffc020651a:	3aaa0a13          	addi	s4,s4,938 # ffffffffc02968c0 <current>
ffffffffc020651e:	000a3683          	ld	a3,0(s4)
ffffffffc0206522:	35213023          	sd	s2,832(sp)
ffffffffc0206526:	fff5891b          	addiw	s2,a1,-1
ffffffffc020652a:	31813823          	sd	s8,784(sp)
ffffffffc020652e:	34113c23          	sd	ra,856(sp)
ffffffffc0206532:	34813823          	sd	s0,848(sp)
ffffffffc0206536:	34913423          	sd	s1,840(sp)
ffffffffc020653a:	33313c23          	sd	s3,824(sp)
ffffffffc020653e:	33513423          	sd	s5,808(sp)
ffffffffc0206542:	33613023          	sd	s6,800(sp)
ffffffffc0206546:	31713c23          	sd	s7,792(sp)
ffffffffc020654a:	31913423          	sd	s9,776(sp)
ffffffffc020654e:	31a13023          	sd	s10,768(sp)
ffffffffc0206552:	2fb13c23          	sd	s11,760(sp)
ffffffffc0206556:	0009071b          	sext.w	a4,s2
ffffffffc020655a:	47fd                	li	a5,31
ffffffffc020655c:	0286bc03          	ld	s8,40(a3)
ffffffffc0206560:	64e7e263          	bltu	a5,a4,ffffffffc0206ba4 <do_execve+0x696>
ffffffffc0206564:	842e                	mv	s0,a1
ffffffffc0206566:	84aa                	mv	s1,a0
ffffffffc0206568:	8cb2                	mv	s9,a2
ffffffffc020656a:	4581                	li	a1,0
ffffffffc020656c:	4641                	li	a2,16
ffffffffc020656e:	10a8                	addi	a0,sp,104
ffffffffc0206570:	285040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206574:	000c0c63          	beqz	s8,ffffffffc020658c <do_execve+0x7e>
ffffffffc0206578:	038c0513          	addi	a0,s8,56
ffffffffc020657c:	9cefe0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0206580:	000a3783          	ld	a5,0(s4)
ffffffffc0206584:	c781                	beqz	a5,ffffffffc020658c <do_execve+0x7e>
ffffffffc0206586:	43dc                	lw	a5,4(a5)
ffffffffc0206588:	04fc2823          	sw	a5,80(s8)
ffffffffc020658c:	34048263          	beqz	s1,ffffffffc02068d0 <do_execve+0x3c2>
ffffffffc0206590:	46c1                	li	a3,16
ffffffffc0206592:	8626                	mv	a2,s1
ffffffffc0206594:	10ac                	addi	a1,sp,104
ffffffffc0206596:	8562                	mv	a0,s8
ffffffffc0206598:	cc6fb0ef          	jal	ra,ffffffffc0201a5e <copy_string>
ffffffffc020659c:	70050d63          	beqz	a0,ffffffffc0206cb6 <do_execve+0x7a8>
ffffffffc02065a0:	00341b13          	slli	s6,s0,0x3
ffffffffc02065a4:	4681                	li	a3,0
ffffffffc02065a6:	865a                	mv	a2,s6
ffffffffc02065a8:	85e6                	mv	a1,s9
ffffffffc02065aa:	8562                	mv	a0,s8
ffffffffc02065ac:	bb8fb0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc02065b0:	8ae6                	mv	s5,s9
ffffffffc02065b2:	6e050e63          	beqz	a0,ffffffffc0206cae <do_execve+0x7a0>
ffffffffc02065b6:	0f010b93          	addi	s7,sp,240
ffffffffc02065ba:	4481                	li	s1,0
ffffffffc02065bc:	a011                	j	ffffffffc02065c0 <do_execve+0xb2>
ffffffffc02065be:	84be                	mv	s1,a5
ffffffffc02065c0:	6505                	lui	a0,0x1
ffffffffc02065c2:	f54fb0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02065c6:	89aa                	mv	s3,a0
ffffffffc02065c8:	20050763          	beqz	a0,ffffffffc02067d6 <do_execve+0x2c8>
ffffffffc02065cc:	000ab603          	ld	a2,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc02065d0:	85aa                	mv	a1,a0
ffffffffc02065d2:	6685                	lui	a3,0x1
ffffffffc02065d4:	8562                	mv	a0,s8
ffffffffc02065d6:	c88fb0ef          	jal	ra,ffffffffc0201a5e <copy_string>
ffffffffc02065da:	26050c63          	beqz	a0,ffffffffc0206852 <do_execve+0x344>
ffffffffc02065de:	013bb023          	sd	s3,0(s7)
ffffffffc02065e2:	0014879b          	addiw	a5,s1,1
ffffffffc02065e6:	0ba1                	addi	s7,s7,8
ffffffffc02065e8:	0aa1                	addi	s5,s5,8
ffffffffc02065ea:	fcf41ae3          	bne	s0,a5,ffffffffc02065be <do_execve+0xb0>
ffffffffc02065ee:	000cb983          	ld	s3,0(s9)
ffffffffc02065f2:	140c0f63          	beqz	s8,ffffffffc0206750 <do_execve+0x242>
ffffffffc02065f6:	038c0513          	addi	a0,s8,56
ffffffffc02065fa:	94cfe0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc02065fe:	000a3783          	ld	a5,0(s4)
ffffffffc0206602:	040c2823          	sw	zero,80(s8)
ffffffffc0206606:	1487b503          	ld	a0,328(a5)
ffffffffc020660a:	aa8ff0ef          	jal	ra,ffffffffc02058b2 <files_closeall>
ffffffffc020660e:	854e                	mv	a0,s3
ffffffffc0206610:	4581                	li	a1,0
ffffffffc0206612:	a18fe0ef          	jal	ra,ffffffffc020482a <sysfile_open>
ffffffffc0206616:	89aa                	mv	s3,a0
ffffffffc0206618:	18054863          	bltz	a0,ffffffffc02067a8 <do_execve+0x29a>
ffffffffc020661c:	00090797          	auipc	a5,0x90
ffffffffc0206620:	2747b783          	ld	a5,628(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206624:	577d                	li	a4,-1
ffffffffc0206626:	177e                	slli	a4,a4,0x3f
ffffffffc0206628:	83b1                	srli	a5,a5,0xc
ffffffffc020662a:	8fd9                	or	a5,a5,a4
ffffffffc020662c:	18079073          	csrw	satp,a5
ffffffffc0206630:	030c2783          	lw	a5,48(s8)
ffffffffc0206634:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206638:	02ec2823          	sw	a4,48(s8)
ffffffffc020663c:	42070b63          	beqz	a4,ffffffffc0206a72 <do_execve+0x564>
ffffffffc0206640:	000a3783          	ld	a5,0(s4)
ffffffffc0206644:	0207b423          	sd	zero,40(a5)
ffffffffc0206648:	c93fa0ef          	jal	ra,ffffffffc02012da <mm_create>
ffffffffc020664c:	8aaa                	mv	s5,a0
ffffffffc020664e:	12050f63          	beqz	a0,ffffffffc020678c <do_execve+0x27e>
ffffffffc0206652:	4505                	li	a0,1
ffffffffc0206654:	b4efc0ef          	jal	ra,ffffffffc02029a2 <alloc_pages>
ffffffffc0206658:	66050963          	beqz	a0,ffffffffc0206cca <do_execve+0x7bc>
ffffffffc020665c:	00090c97          	auipc	s9,0x90
ffffffffc0206660:	24cc8c93          	addi	s9,s9,588 # ffffffffc02968a8 <pages>
ffffffffc0206664:	000cb683          	ld	a3,0(s9)
ffffffffc0206668:	00009717          	auipc	a4,0x9
ffffffffc020666c:	07873703          	ld	a4,120(a4) # ffffffffc020f6e0 <nbase>
ffffffffc0206670:	00090d17          	auipc	s10,0x90
ffffffffc0206674:	230d0d13          	addi	s10,s10,560 # ffffffffc02968a0 <npage>
ffffffffc0206678:	40d506b3          	sub	a3,a0,a3
ffffffffc020667c:	8699                	srai	a3,a3,0x6
ffffffffc020667e:	96ba                	add	a3,a3,a4
ffffffffc0206680:	f03a                	sd	a4,32(sp)
ffffffffc0206682:	000d3783          	ld	a5,0(s10)
ffffffffc0206686:	577d                	li	a4,-1
ffffffffc0206688:	8331                	srli	a4,a4,0xc
ffffffffc020668a:	e83a                	sd	a4,16(sp)
ffffffffc020668c:	8f75                	and	a4,a4,a3
ffffffffc020668e:	06b2                	slli	a3,a3,0xc
ffffffffc0206690:	66f77563          	bgeu	a4,a5,ffffffffc0206cfa <do_execve+0x7ec>
ffffffffc0206694:	00090797          	auipc	a5,0x90
ffffffffc0206698:	22478793          	addi	a5,a5,548 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020669c:	0007bb83          	ld	s7,0(a5)
ffffffffc02066a0:	6605                	lui	a2,0x1
ffffffffc02066a2:	00090597          	auipc	a1,0x90
ffffffffc02066a6:	1f65b583          	ld	a1,502(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc02066aa:	9bb6                	add	s7,s7,a3
ffffffffc02066ac:	855e                	mv	a0,s7
ffffffffc02066ae:	199040ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc02066b2:	4601                	li	a2,0
ffffffffc02066b4:	017abc23          	sd	s7,24(s5)
ffffffffc02066b8:	4581                	li	a1,0
ffffffffc02066ba:	854e                	mv	a0,s3
ffffffffc02066bc:	bd4fe0ef          	jal	ra,ffffffffc0204a90 <sysfile_seek>
ffffffffc02066c0:	8daa                	mv	s11,a0
ffffffffc02066c2:	18051e63          	bnez	a0,ffffffffc020685e <do_execve+0x350>
ffffffffc02066c6:	04000613          	li	a2,64
ffffffffc02066ca:	190c                	addi	a1,sp,176
ffffffffc02066cc:	854e                	mv	a0,s3
ffffffffc02066ce:	994fe0ef          	jal	ra,ffffffffc0204862 <sysfile_read>
ffffffffc02066d2:	04000793          	li	a5,64
ffffffffc02066d6:	20f51963          	bne	a0,a5,ffffffffc02068e8 <do_execve+0x3da>
ffffffffc02066da:	574a                	lw	a4,176(sp)
ffffffffc02066dc:	464c47b7          	lui	a5,0x464c4
ffffffffc02066e0:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc02066e4:	16f71c63          	bne	a4,a5,ffffffffc020685c <do_execve+0x34e>
ffffffffc02066e8:	0e815783          	lhu	a5,232(sp)
ffffffffc02066ec:	e882                	sd	zero,80(sp)
ffffffffc02066ee:	ec02                	sd	zero,24(sp)
ffffffffc02066f0:	22078863          	beqz	a5,ffffffffc0206920 <do_execve+0x412>
ffffffffc02066f4:	fc5a                	sd	s6,56(sp)
ffffffffc02066f6:	eca6                	sd	s1,88(sp)
ffffffffc02066f8:	e0a2                	sd	s0,64(sp)
ffffffffc02066fa:	c6ca                	sw	s2,76(sp)
ffffffffc02066fc:	0e615783          	lhu	a5,230(sp)
ffffffffc0206700:	6746                	ld	a4,80(sp)
ffffffffc0206702:	65ce                	ld	a1,208(sp)
ffffffffc0206704:	4601                	li	a2,0
ffffffffc0206706:	02e787b3          	mul	a5,a5,a4
ffffffffc020670a:	854e                	mv	a0,s3
ffffffffc020670c:	95be                	add	a1,a1,a5
ffffffffc020670e:	b82fe0ef          	jal	ra,ffffffffc0204a90 <sysfile_seek>
ffffffffc0206712:	892a                	mv	s2,a0
ffffffffc0206714:	36051a63          	bnez	a0,ffffffffc0206a88 <do_execve+0x57a>
ffffffffc0206718:	03800613          	li	a2,56
ffffffffc020671c:	18ac                	addi	a1,sp,120
ffffffffc020671e:	854e                	mv	a0,s3
ffffffffc0206720:	942fe0ef          	jal	ra,ffffffffc0204862 <sysfile_read>
ffffffffc0206724:	03800793          	li	a5,56
ffffffffc0206728:	1cf50c63          	beq	a0,a5,ffffffffc0206900 <do_execve+0x3f2>
ffffffffc020672c:	7b62                	ld	s6,56(sp)
ffffffffc020672e:	6406                	ld	s0,64(sp)
ffffffffc0206730:	4936                	lw	s2,76(sp)
ffffffffc0206732:	87aa                	mv	a5,a0
ffffffffc0206734:	00054363          	bltz	a0,ffffffffc020673a <do_execve+0x22c>
ffffffffc0206738:	57fd                	li	a5,-1
ffffffffc020673a:	1902                	slli	s2,s2,0x20
ffffffffc020673c:	00078d9b          	sext.w	s11,a5
ffffffffc0206740:	0e010b93          	addi	s7,sp,224
ffffffffc0206744:	02095913          	srli	s2,s2,0x20
ffffffffc0206748:	8556                	mv	a0,s5
ffffffffc020674a:	e7bfa0ef          	jal	ra,ffffffffc02015c4 <exit_mmap>
ffffffffc020674e:	aa29                	j	ffffffffc0206868 <do_execve+0x35a>
ffffffffc0206750:	000a3783          	ld	a5,0(s4)
ffffffffc0206754:	1487b503          	ld	a0,328(a5)
ffffffffc0206758:	95aff0ef          	jal	ra,ffffffffc02058b2 <files_closeall>
ffffffffc020675c:	854e                	mv	a0,s3
ffffffffc020675e:	4581                	li	a1,0
ffffffffc0206760:	8cafe0ef          	jal	ra,ffffffffc020482a <sysfile_open>
ffffffffc0206764:	89aa                	mv	s3,a0
ffffffffc0206766:	04054163          	bltz	a0,ffffffffc02067a8 <do_execve+0x29a>
ffffffffc020676a:	000a3783          	ld	a5,0(s4)
ffffffffc020676e:	779c                	ld	a5,40(a5)
ffffffffc0206770:	ec078ce3          	beqz	a5,ffffffffc0206648 <do_execve+0x13a>
ffffffffc0206774:	00007617          	auipc	a2,0x7
ffffffffc0206778:	ee460613          	addi	a2,a2,-284 # ffffffffc020d658 <CSWTCH.79+0x2b8>
ffffffffc020677c:	2db00593          	li	a1,731
ffffffffc0206780:	00007517          	auipc	a0,0x7
ffffffffc0206784:	ce850513          	addi	a0,a0,-792 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206788:	aa7f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020678c:	854e                	mv	a0,s3
ffffffffc020678e:	8d0fe0ef          	jal	ra,ffffffffc020485e <sysfile_close>
ffffffffc0206792:	00090797          	auipc	a5,0x90
ffffffffc0206796:	0fe7b783          	ld	a5,254(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc020679a:	577d                	li	a4,-1
ffffffffc020679c:	177e                	slli	a4,a4,0x3f
ffffffffc020679e:	83b1                	srli	a5,a5,0xc
ffffffffc02067a0:	8fd9                	or	a5,a5,a4
ffffffffc02067a2:	18079073          	csrw	satp,a5
ffffffffc02067a6:	59f1                	li	s3,-4
ffffffffc02067a8:	1902                	slli	s2,s2,0x20
ffffffffc02067aa:	0e010b93          	addi	s7,sp,224
ffffffffc02067ae:	02095913          	srli	s2,s2,0x20
ffffffffc02067b2:	147d                	addi	s0,s0,-1
ffffffffc02067b4:	040e                	slli	s0,s0,0x3
ffffffffc02067b6:	016b84b3          	add	s1,s7,s6
ffffffffc02067ba:	090e                	slli	s2,s2,0x3
ffffffffc02067bc:	199c                	addi	a5,sp,240
ffffffffc02067be:	943e                	add	s0,s0,a5
ffffffffc02067c0:	412484b3          	sub	s1,s1,s2
ffffffffc02067c4:	6008                	ld	a0,0(s0)
ffffffffc02067c6:	1461                	addi	s0,s0,-8
ffffffffc02067c8:	dfefb0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc02067cc:	fe941ce3          	bne	s0,s1,ffffffffc02067c4 <do_execve+0x2b6>
ffffffffc02067d0:	854e                	mv	a0,s3
ffffffffc02067d2:	8b9ff0ef          	jal	ra,ffffffffc020608a <do_exit>
ffffffffc02067d6:	5971                	li	s2,-4
ffffffffc02067d8:	c49d                	beqz	s1,ffffffffc0206806 <do_execve+0x2f8>
ffffffffc02067da:	00349713          	slli	a4,s1,0x3
ffffffffc02067de:	fff48413          	addi	s0,s1,-1
ffffffffc02067e2:	119c                	addi	a5,sp,224
ffffffffc02067e4:	34fd                	addiw	s1,s1,-1
ffffffffc02067e6:	97ba                	add	a5,a5,a4
ffffffffc02067e8:	02049713          	slli	a4,s1,0x20
ffffffffc02067ec:	01d75493          	srli	s1,a4,0x1d
ffffffffc02067f0:	040e                	slli	s0,s0,0x3
ffffffffc02067f2:	1998                	addi	a4,sp,240
ffffffffc02067f4:	943a                	add	s0,s0,a4
ffffffffc02067f6:	409784b3          	sub	s1,a5,s1
ffffffffc02067fa:	6008                	ld	a0,0(s0)
ffffffffc02067fc:	1461                	addi	s0,s0,-8
ffffffffc02067fe:	dc8fb0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0206802:	fe849ce3          	bne	s1,s0,ffffffffc02067fa <do_execve+0x2ec>
ffffffffc0206806:	000c0863          	beqz	s8,ffffffffc0206816 <do_execve+0x308>
ffffffffc020680a:	038c0513          	addi	a0,s8,56
ffffffffc020680e:	f39fd0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0206812:	040c2823          	sw	zero,80(s8)
ffffffffc0206816:	35813083          	ld	ra,856(sp)
ffffffffc020681a:	35013403          	ld	s0,848(sp)
ffffffffc020681e:	34813483          	ld	s1,840(sp)
ffffffffc0206822:	33813983          	ld	s3,824(sp)
ffffffffc0206826:	33013a03          	ld	s4,816(sp)
ffffffffc020682a:	32813a83          	ld	s5,808(sp)
ffffffffc020682e:	32013b03          	ld	s6,800(sp)
ffffffffc0206832:	31813b83          	ld	s7,792(sp)
ffffffffc0206836:	31013c03          	ld	s8,784(sp)
ffffffffc020683a:	30813c83          	ld	s9,776(sp)
ffffffffc020683e:	30013d03          	ld	s10,768(sp)
ffffffffc0206842:	2f813d83          	ld	s11,760(sp)
ffffffffc0206846:	854a                	mv	a0,s2
ffffffffc0206848:	34013903          	ld	s2,832(sp)
ffffffffc020684c:	36010113          	addi	sp,sp,864
ffffffffc0206850:	8082                	ret
ffffffffc0206852:	854e                	mv	a0,s3
ffffffffc0206854:	d72fb0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0206858:	5975                	li	s2,-3
ffffffffc020685a:	bfbd                	j	ffffffffc02067d8 <do_execve+0x2ca>
ffffffffc020685c:	5de1                	li	s11,-8
ffffffffc020685e:	1902                	slli	s2,s2,0x20
ffffffffc0206860:	0e010b93          	addi	s7,sp,224
ffffffffc0206864:	02095913          	srli	s2,s2,0x20
ffffffffc0206868:	018ab503          	ld	a0,24(s5)
ffffffffc020686c:	a88ff0ef          	jal	ra,ffffffffc0205af4 <put_pgdir.isra.0>
ffffffffc0206870:	8556                	mv	a0,s5
ffffffffc0206872:	bb7fa0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc0206876:	854e                	mv	a0,s3
ffffffffc0206878:	fe7fd0ef          	jal	ra,ffffffffc020485e <sysfile_close>
ffffffffc020687c:	00090717          	auipc	a4,0x90
ffffffffc0206880:	01473703          	ld	a4,20(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206884:	56fd                	li	a3,-1
ffffffffc0206886:	16fe                	slli	a3,a3,0x3f
ffffffffc0206888:	8331                	srli	a4,a4,0xc
ffffffffc020688a:	8f55                	or	a4,a4,a3
ffffffffc020688c:	18071073          	csrw	satp,a4
ffffffffc0206890:	480d9163          	bnez	s11,ffffffffc0206d12 <do_execve+0x804>
ffffffffc0206894:	147d                	addi	s0,s0,-1
ffffffffc0206896:	040e                	slli	s0,s0,0x3
ffffffffc0206898:	9b5e                	add	s6,s6,s7
ffffffffc020689a:	090e                	slli	s2,s2,0x3
ffffffffc020689c:	199c                	addi	a5,sp,240
ffffffffc020689e:	943e                	add	s0,s0,a5
ffffffffc02068a0:	412b0b33          	sub	s6,s6,s2
ffffffffc02068a4:	6008                	ld	a0,0(s0)
ffffffffc02068a6:	1461                	addi	s0,s0,-8
ffffffffc02068a8:	d1efb0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc02068ac:	fe8b1ce3          	bne	s6,s0,ffffffffc02068a4 <do_execve+0x396>
ffffffffc02068b0:	000a3403          	ld	s0,0(s4)
ffffffffc02068b4:	4641                	li	a2,16
ffffffffc02068b6:	4581                	li	a1,0
ffffffffc02068b8:	0b440413          	addi	s0,s0,180
ffffffffc02068bc:	8522                	mv	a0,s0
ffffffffc02068be:	736040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc02068c2:	463d                	li	a2,15
ffffffffc02068c4:	10ac                	addi	a1,sp,104
ffffffffc02068c6:	8522                	mv	a0,s0
ffffffffc02068c8:	77e040ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc02068cc:	4901                	li	s2,0
ffffffffc02068ce:	b7a1                	j	ffffffffc0206816 <do_execve+0x308>
ffffffffc02068d0:	000a3783          	ld	a5,0(s4)
ffffffffc02068d4:	00007617          	auipc	a2,0x7
ffffffffc02068d8:	d7460613          	addi	a2,a2,-652 # ffffffffc020d648 <CSWTCH.79+0x2a8>
ffffffffc02068dc:	45c1                	li	a1,16
ffffffffc02068de:	43d4                	lw	a3,4(a5)
ffffffffc02068e0:	10a8                	addi	a0,sp,104
ffffffffc02068e2:	3ab040ef          	jal	ra,ffffffffc020b48c <snprintf>
ffffffffc02068e6:	b96d                	j	ffffffffc02065a0 <do_execve+0x92>
ffffffffc02068e8:	87aa                	mv	a5,a0
ffffffffc02068ea:	00054363          	bltz	a0,ffffffffc02068f0 <do_execve+0x3e2>
ffffffffc02068ee:	57fd                	li	a5,-1
ffffffffc02068f0:	1902                	slli	s2,s2,0x20
ffffffffc02068f2:	00078d9b          	sext.w	s11,a5
ffffffffc02068f6:	0e010b93          	addi	s7,sp,224
ffffffffc02068fa:	02095913          	srli	s2,s2,0x20
ffffffffc02068fe:	b7ad                	j	ffffffffc0206868 <do_execve+0x35a>
ffffffffc0206900:	57e6                	lw	a5,120(sp)
ffffffffc0206902:	4705                	li	a4,1
ffffffffc0206904:	18e78c63          	beq	a5,a4,ffffffffc0206a9c <do_execve+0x58e>
ffffffffc0206908:	67c6                	ld	a5,80(sp)
ffffffffc020690a:	0e815703          	lhu	a4,232(sp)
ffffffffc020690e:	0785                	addi	a5,a5,1
ffffffffc0206910:	e8be                	sd	a5,80(sp)
ffffffffc0206912:	2781                	sext.w	a5,a5
ffffffffc0206914:	dee7c4e3          	blt	a5,a4,ffffffffc02066fc <do_execve+0x1ee>
ffffffffc0206918:	7b62                	ld	s6,56(sp)
ffffffffc020691a:	64e6                	ld	s1,88(sp)
ffffffffc020691c:	6406                	ld	s0,64(sp)
ffffffffc020691e:	4936                	lw	s2,76(sp)
ffffffffc0206920:	4701                	li	a4,0
ffffffffc0206922:	46ad                	li	a3,11
ffffffffc0206924:	00100637          	lui	a2,0x100
ffffffffc0206928:	7ff005b7          	lui	a1,0x7ff00
ffffffffc020692c:	8556                	mv	a0,s5
ffffffffc020692e:	b4dfa0ef          	jal	ra,ffffffffc020147a <mm_map>
ffffffffc0206932:	8daa                	mv	s11,a0
ffffffffc0206934:	36051563          	bnez	a0,ffffffffc0206c9e <do_execve+0x790>
ffffffffc0206938:	7ffffbb7          	lui	s7,0x7ffff
ffffffffc020693c:	7cfd                	lui	s9,0xfffff
ffffffffc020693e:	7fffbc37          	lui	s8,0x7fffb
ffffffffc0206942:	018ab503          	ld	a0,24(s5)
ffffffffc0206946:	467d                	li	a2,31
ffffffffc0206948:	85de                	mv	a1,s7
ffffffffc020694a:	a0ffd0ef          	jal	ra,ffffffffc0204358 <pgdir_alloc_page>
ffffffffc020694e:	3e050d63          	beqz	a0,ffffffffc0206d48 <do_execve+0x83a>
ffffffffc0206952:	9be6                	add	s7,s7,s9
ffffffffc0206954:	ff8b97e3          	bne	s7,s8,ffffffffc0206942 <do_execve+0x434>
ffffffffc0206958:	030aa703          	lw	a4,48(s5)
ffffffffc020695c:	000a3603          	ld	a2,0(s4)
ffffffffc0206960:	018ab683          	ld	a3,24(s5)
ffffffffc0206964:	2705                	addiw	a4,a4,1
ffffffffc0206966:	02eaa823          	sw	a4,48(s5)
ffffffffc020696a:	03563423          	sd	s5,40(a2) # 100028 <_binary_bin_sfs_img_size+0x8ad28>
ffffffffc020696e:	c0200737          	lui	a4,0xc0200
ffffffffc0206972:	3ae6ef63          	bltu	a3,a4,ffffffffc0206d30 <do_execve+0x822>
ffffffffc0206976:	00090797          	auipc	a5,0x90
ffffffffc020697a:	f4278793          	addi	a5,a5,-190 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020697e:	6398                	ld	a4,0(a5)
ffffffffc0206980:	8e99                	sub	a3,a3,a4
ffffffffc0206982:	00c6d713          	srli	a4,a3,0xc
ffffffffc0206986:	f654                	sd	a3,168(a2)
ffffffffc0206988:	56fd                	li	a3,-1
ffffffffc020698a:	16fe                	slli	a3,a3,0x3f
ffffffffc020698c:	8f55                	or	a4,a4,a3
ffffffffc020698e:	18071073          	csrw	satp,a4
ffffffffc0206992:	1902                	slli	s2,s2,0x20
ffffffffc0206994:	ff8b0d13          	addi	s10,s6,-8
ffffffffc0206998:	199c                	addi	a5,sp,240
ffffffffc020699a:	0e010b93          	addi	s7,sp,224
ffffffffc020699e:	02095913          	srli	s2,s2,0x20
ffffffffc02069a2:	1b94                	addi	a3,sp,496
ffffffffc02069a4:	97ea                	add	a5,a5,s10
ffffffffc02069a6:	016b8cb3          	add	s9,s7,s6
ffffffffc02069aa:	9d36                	add	s10,s10,a3
ffffffffc02069ac:	00391713          	slli	a4,s2,0x3
ffffffffc02069b0:	4c05                	li	s8,1
ffffffffc02069b2:	e422                	sd	s0,8(sp)
ffffffffc02069b4:	40ec8cb3          	sub	s9,s9,a4
ffffffffc02069b8:	846a                	mv	s0,s10
ffffffffc02069ba:	0c7e                	slli	s8,s8,0x1f
ffffffffc02069bc:	e826                	sd	s1,16(sp)
ffffffffc02069be:	8d3e                	mv	s10,a5
ffffffffc02069c0:	000d3483          	ld	s1,0(s10)
ffffffffc02069c4:	8526                	mv	a0,s1
ffffffffc02069c6:	58c040ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc02069ca:	00150693          	addi	a3,a0,1
ffffffffc02069ce:	40dc0c33          	sub	s8,s8,a3
ffffffffc02069d2:	ff8c7c13          	andi	s8,s8,-8
ffffffffc02069d6:	8626                	mv	a2,s1
ffffffffc02069d8:	85e2                	mv	a1,s8
ffffffffc02069da:	8556                	mv	a0,s5
ffffffffc02069dc:	850fb0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc02069e0:	2e050f63          	beqz	a0,ffffffffc0206cde <do_execve+0x7d0>
ffffffffc02069e4:	01843023          	sd	s8,0(s0)
ffffffffc02069e8:	1d61                	addi	s10,s10,-8
ffffffffc02069ea:	1461                	addi	s0,s0,-8
ffffffffc02069ec:	fd9d1ae3          	bne	s10,s9,ffffffffc02069c0 <do_execve+0x4b2>
ffffffffc02069f0:	008b0713          	addi	a4,s6,8
ffffffffc02069f4:	40ec0c33          	sub	s8,s8,a4
ffffffffc02069f8:	1f010c93          	addi	s9,sp,496
ffffffffc02069fc:	64c2                	ld	s1,16(sp)
ffffffffc02069fe:	6422                	ld	s0,8(sp)
ffffffffc0206a00:	419c0d33          	sub	s10,s8,s9
ffffffffc0206a04:	a011                	j	ffffffffc0206a08 <do_execve+0x4fa>
ffffffffc0206a06:	8dbe                	mv	s11,a5
ffffffffc0206a08:	46a1                	li	a3,8
ffffffffc0206a0a:	8666                	mv	a2,s9
ffffffffc0206a0c:	019d05b3          	add	a1,s10,s9
ffffffffc0206a10:	8556                	mv	a0,s5
ffffffffc0206a12:	81afb0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0206a16:	2c050563          	beqz	a0,ffffffffc0206ce0 <do_execve+0x7d2>
ffffffffc0206a1a:	001d879b          	addiw	a5,s11,1
ffffffffc0206a1e:	0ca1                	addi	s9,s9,8
ffffffffc0206a20:	fe9dc3e3          	blt	s11,s1,ffffffffc0206a06 <do_execve+0x4f8>
ffffffffc0206a24:	46a1                	li	a3,8
ffffffffc0206a26:	1090                	addi	a2,sp,96
ffffffffc0206a28:	018b05b3          	add	a1,s6,s8
ffffffffc0206a2c:	8556                	mv	a0,s5
ffffffffc0206a2e:	f082                	sd	zero,96(sp)
ffffffffc0206a30:	ffdfa0ef          	jal	ra,ffffffffc0201a2c <copy_to_user>
ffffffffc0206a34:	2a050663          	beqz	a0,ffffffffc0206ce0 <do_execve+0x7d2>
ffffffffc0206a38:	000a3783          	ld	a5,0(s4)
ffffffffc0206a3c:	12000613          	li	a2,288
ffffffffc0206a40:	4581                	li	a1,0
ffffffffc0206a42:	73c4                	ld	s1,160(a5)
ffffffffc0206a44:	1004ba83          	ld	s5,256(s1)
ffffffffc0206a48:	8526                	mv	a0,s1
ffffffffc0206a4a:	5aa040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206a4e:	672e                	ld	a4,200(sp)
ffffffffc0206a50:	eddaf793          	andi	a5,s5,-291
ffffffffc0206a54:	0207e793          	ori	a5,a5,32
ffffffffc0206a58:	0184b823          	sd	s8,16(s1)
ffffffffc0206a5c:	e8a0                	sd	s0,80(s1)
ffffffffc0206a5e:	0584bc23          	sd	s8,88(s1)
ffffffffc0206a62:	10e4b423          	sd	a4,264(s1)
ffffffffc0206a66:	10f4b023          	sd	a5,256(s1)
ffffffffc0206a6a:	854e                	mv	a0,s3
ffffffffc0206a6c:	df3fd0ef          	jal	ra,ffffffffc020485e <sysfile_close>
ffffffffc0206a70:	b515                	j	ffffffffc0206894 <do_execve+0x386>
ffffffffc0206a72:	8562                	mv	a0,s8
ffffffffc0206a74:	b51fa0ef          	jal	ra,ffffffffc02015c4 <exit_mmap>
ffffffffc0206a78:	018c3503          	ld	a0,24(s8) # 7fffb018 <_binary_bin_sfs_img_size+0x7ff85d18>
ffffffffc0206a7c:	878ff0ef          	jal	ra,ffffffffc0205af4 <put_pgdir.isra.0>
ffffffffc0206a80:	8562                	mv	a0,s8
ffffffffc0206a82:	9a7fa0ef          	jal	ra,ffffffffc0201428 <mm_destroy>
ffffffffc0206a86:	be6d                	j	ffffffffc0206640 <do_execve+0x132>
ffffffffc0206a88:	7b62                	ld	s6,56(sp)
ffffffffc0206a8a:	8dca                	mv	s11,s2
ffffffffc0206a8c:	4936                	lw	s2,76(sp)
ffffffffc0206a8e:	6406                	ld	s0,64(sp)
ffffffffc0206a90:	0e010b93          	addi	s7,sp,224
ffffffffc0206a94:	1902                	slli	s2,s2,0x20
ffffffffc0206a96:	02095913          	srli	s2,s2,0x20
ffffffffc0206a9a:	b17d                	j	ffffffffc0206748 <do_execve+0x23a>
ffffffffc0206a9c:	760a                	ld	a2,160(sp)
ffffffffc0206a9e:	67ea                	ld	a5,152(sp)
ffffffffc0206aa0:	24f66263          	bltu	a2,a5,ffffffffc0206ce4 <do_execve+0x7d6>
ffffffffc0206aa4:	57f6                	lw	a5,124(sp)
ffffffffc0206aa6:	0017f693          	andi	a3,a5,1
ffffffffc0206aaa:	c291                	beqz	a3,ffffffffc0206aae <do_execve+0x5a0>
ffffffffc0206aac:	4691                	li	a3,4
ffffffffc0206aae:	0027f713          	andi	a4,a5,2
ffffffffc0206ab2:	8b91                	andi	a5,a5,4
ffffffffc0206ab4:	eb61                	bnez	a4,ffffffffc0206b84 <do_execve+0x676>
ffffffffc0206ab6:	4745                	li	a4,17
ffffffffc0206ab8:	f83a                	sd	a4,48(sp)
ffffffffc0206aba:	c789                	beqz	a5,ffffffffc0206ac4 <do_execve+0x5b6>
ffffffffc0206abc:	47cd                	li	a5,19
ffffffffc0206abe:	0016e693          	ori	a3,a3,1
ffffffffc0206ac2:	f83e                	sd	a5,48(sp)
ffffffffc0206ac4:	0026f793          	andi	a5,a3,2
ffffffffc0206ac8:	e3e9                	bnez	a5,ffffffffc0206b8a <do_execve+0x67c>
ffffffffc0206aca:	0046f793          	andi	a5,a3,4
ffffffffc0206ace:	c789                	beqz	a5,ffffffffc0206ad8 <do_execve+0x5ca>
ffffffffc0206ad0:	77c2                	ld	a5,48(sp)
ffffffffc0206ad2:	0087e793          	ori	a5,a5,8
ffffffffc0206ad6:	f83e                	sd	a5,48(sp)
ffffffffc0206ad8:	65aa                	ld	a1,136(sp)
ffffffffc0206ada:	4701                	li	a4,0
ffffffffc0206adc:	8556                	mv	a0,s5
ffffffffc0206ade:	99dfa0ef          	jal	ra,ffffffffc020147a <mm_map>
ffffffffc0206ae2:	892a                	mv	s2,a0
ffffffffc0206ae4:	f155                	bnez	a0,ffffffffc0206a88 <do_execve+0x57a>
ffffffffc0206ae6:	642a                	ld	s0,136(sp)
ffffffffc0206ae8:	6c6a                	ld	s8,152(sp)
ffffffffc0206aea:	77fd                	lui	a5,0xfffff
ffffffffc0206aec:	00f47db3          	and	s11,s0,a5
ffffffffc0206af0:	018407b3          	add	a5,s0,s8
ffffffffc0206af4:	e43e                	sd	a5,8(sp)
ffffffffc0206af6:	6b8a                	ld	s7,128(sp)
ffffffffc0206af8:	1ef47063          	bgeu	s0,a5,ffffffffc0206cd8 <do_execve+0x7ca>
ffffffffc0206afc:	5971                	li	s2,-4
ffffffffc0206afe:	ec56                	sd	s5,24(sp)
ffffffffc0206b00:	67e2                	ld	a5,24(sp)
ffffffffc0206b02:	7642                	ld	a2,48(sp)
ffffffffc0206b04:	85ee                	mv	a1,s11
ffffffffc0206b06:	6f88                	ld	a0,24(a5)
ffffffffc0206b08:	851fd0ef          	jal	ra,ffffffffc0204358 <pgdir_alloc_page>
ffffffffc0206b0c:	84aa                	mv	s1,a0
ffffffffc0206b0e:	c941                	beqz	a0,ffffffffc0206b9e <do_execve+0x690>
ffffffffc0206b10:	6785                	lui	a5,0x1
ffffffffc0206b12:	00fd8ab3          	add	s5,s11,a5
ffffffffc0206b16:	67a2                	ld	a5,8(sp)
ffffffffc0206b18:	408a8b33          	sub	s6,s5,s0
ffffffffc0206b1c:	0157f463          	bgeu	a5,s5,ffffffffc0206b24 <do_execve+0x616>
ffffffffc0206b20:	40878b33          	sub	s6,a5,s0
ffffffffc0206b24:	000cbc03          	ld	s8,0(s9) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0206b28:	7782                	ld	a5,32(sp)
ffffffffc0206b2a:	000d3603          	ld	a2,0(s10)
ffffffffc0206b2e:	41848c33          	sub	s8,s1,s8
ffffffffc0206b32:	406c5c13          	srai	s8,s8,0x6
ffffffffc0206b36:	9c3e                	add	s8,s8,a5
ffffffffc0206b38:	67c2                	ld	a5,16(sp)
ffffffffc0206b3a:	00fc75b3          	and	a1,s8,a5
ffffffffc0206b3e:	0c32                	slli	s8,s8,0xc
ffffffffc0206b40:	1ac5fc63          	bgeu	a1,a2,ffffffffc0206cf8 <do_execve+0x7ea>
ffffffffc0206b44:	00090797          	auipc	a5,0x90
ffffffffc0206b48:	d7478793          	addi	a5,a5,-652 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206b4c:	639c                	ld	a5,0(a5)
ffffffffc0206b4e:	4601                	li	a2,0
ffffffffc0206b50:	85de                	mv	a1,s7
ffffffffc0206b52:	854e                	mv	a0,s3
ffffffffc0206b54:	f43e                	sd	a5,40(sp)
ffffffffc0206b56:	f3bfd0ef          	jal	ra,ffffffffc0204a90 <sysfile_seek>
ffffffffc0206b5a:	892a                	mv	s2,a0
ffffffffc0206b5c:	e129                	bnez	a0,ffffffffc0206b9e <do_execve+0x690>
ffffffffc0206b5e:	77a2                	ld	a5,40(sp)
ffffffffc0206b60:	41b405b3          	sub	a1,s0,s11
ffffffffc0206b64:	865a                	mv	a2,s6
ffffffffc0206b66:	97e2                	add	a5,a5,s8
ffffffffc0206b68:	95be                	add	a1,a1,a5
ffffffffc0206b6a:	854e                	mv	a0,s3
ffffffffc0206b6c:	cf7fd0ef          	jal	ra,ffffffffc0204862 <sysfile_read>
ffffffffc0206b70:	02ab0063          	beq	s6,a0,ffffffffc0206b90 <do_execve+0x682>
ffffffffc0206b74:	7b62                	ld	s6,56(sp)
ffffffffc0206b76:	6ae2                	ld	s5,24(sp)
ffffffffc0206b78:	6406                	ld	s0,64(sp)
ffffffffc0206b7a:	4936                	lw	s2,76(sp)
ffffffffc0206b7c:	87aa                	mv	a5,a0
ffffffffc0206b7e:	ba055de3          	bgez	a0,ffffffffc0206738 <do_execve+0x22a>
ffffffffc0206b82:	be65                	j	ffffffffc020673a <do_execve+0x22c>
ffffffffc0206b84:	0026e693          	ori	a3,a3,2
ffffffffc0206b88:	fb95                	bnez	a5,ffffffffc0206abc <do_execve+0x5ae>
ffffffffc0206b8a:	47dd                	li	a5,23
ffffffffc0206b8c:	f83e                	sd	a5,48(sp)
ffffffffc0206b8e:	bf35                	j	ffffffffc0206aca <do_execve+0x5bc>
ffffffffc0206b90:	67a2                	ld	a5,8(sp)
ffffffffc0206b92:	945a                	add	s0,s0,s6
ffffffffc0206b94:	9bda                	add	s7,s7,s6
ffffffffc0206b96:	00f47963          	bgeu	s0,a5,ffffffffc0206ba8 <do_execve+0x69a>
ffffffffc0206b9a:	8dd6                	mv	s11,s5
ffffffffc0206b9c:	b795                	j	ffffffffc0206b00 <do_execve+0x5f2>
ffffffffc0206b9e:	7b62                	ld	s6,56(sp)
ffffffffc0206ba0:	6ae2                	ld	s5,24(sp)
ffffffffc0206ba2:	b5e5                	j	ffffffffc0206a8a <do_execve+0x57c>
ffffffffc0206ba4:	5975                	li	s2,-3
ffffffffc0206ba6:	b985                	j	ffffffffc0206816 <do_execve+0x308>
ffffffffc0206ba8:	6baa                	ld	s7,136(sp)
ffffffffc0206baa:	8b56                	mv	s6,s5
ffffffffc0206bac:	6ae2                	ld	s5,24(sp)
ffffffffc0206bae:	ec26                	sd	s1,24(sp)
ffffffffc0206bb0:	770a                	ld	a4,160(sp)
ffffffffc0206bb2:	9bba                	add	s7,s7,a4
ffffffffc0206bb4:	09647063          	bgeu	s0,s6,ffffffffc0206c34 <do_execve+0x726>
ffffffffc0206bb8:	6785                	lui	a5,0x1
ffffffffc0206bba:	00f40533          	add	a0,s0,a5
ffffffffc0206bbe:	41650533          	sub	a0,a0,s6
ffffffffc0206bc2:	408b8c33          	sub	s8,s7,s0
ffffffffc0206bc6:	016be463          	bltu	s7,s6,ffffffffc0206bce <do_execve+0x6c0>
ffffffffc0206bca:	408b0c33          	sub	s8,s6,s0
ffffffffc0206bce:	67e2                	ld	a5,24(sp)
ffffffffc0206bd0:	000cb703          	ld	a4,0(s9)
ffffffffc0206bd4:	000d3603          	ld	a2,0(s10)
ffffffffc0206bd8:	40e78733          	sub	a4,a5,a4
ffffffffc0206bdc:	7782                	ld	a5,32(sp)
ffffffffc0206bde:	8719                	srai	a4,a4,0x6
ffffffffc0206be0:	973e                	add	a4,a4,a5
ffffffffc0206be2:	67c2                	ld	a5,16(sp)
ffffffffc0206be4:	00c71693          	slli	a3,a4,0xc
ffffffffc0206be8:	00f775b3          	and	a1,a4,a5
ffffffffc0206bec:	10c5f763          	bgeu	a1,a2,ffffffffc0206cfa <do_execve+0x7ec>
ffffffffc0206bf0:	00090797          	auipc	a5,0x90
ffffffffc0206bf4:	cc878793          	addi	a5,a5,-824 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206bf8:	6398                	ld	a4,0(a5)
ffffffffc0206bfa:	8662                	mv	a2,s8
ffffffffc0206bfc:	4581                	li	a1,0
ffffffffc0206bfe:	9736                	add	a4,a4,a3
ffffffffc0206c00:	953a                	add	a0,a0,a4
ffffffffc0206c02:	3f2040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206c06:	9462                	add	s0,s0,s8
ffffffffc0206c08:	036bf463          	bgeu	s7,s6,ffffffffc0206c30 <do_execve+0x722>
ffffffffc0206c0c:	ce8b8ee3          	beq	s7,s0,ffffffffc0206908 <do_execve+0x3fa>
ffffffffc0206c10:	00007697          	auipc	a3,0x7
ffffffffc0206c14:	a7068693          	addi	a3,a3,-1424 # ffffffffc020d680 <CSWTCH.79+0x2e0>
ffffffffc0206c18:	00005617          	auipc	a2,0x5
ffffffffc0206c1c:	be060613          	addi	a2,a2,-1056 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0206c20:	34000593          	li	a1,832
ffffffffc0206c24:	00007517          	auipc	a0,0x7
ffffffffc0206c28:	84450513          	addi	a0,a0,-1980 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206c2c:	e02f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206c30:	fe8b10e3          	bne	s6,s0,ffffffffc0206c10 <do_execve+0x702>
ffffffffc0206c34:	cd747ae3          	bgeu	s0,s7,ffffffffc0206908 <do_execve+0x3fa>
ffffffffc0206c38:	7942                	ld	s2,48(sp)
ffffffffc0206c3a:	7c02                	ld	s8,32(sp)
ffffffffc0206c3c:	a0a9                	j	ffffffffc0206c86 <do_execve+0x778>
ffffffffc0206c3e:	6785                	lui	a5,0x1
ffffffffc0206c40:	41640533          	sub	a0,s0,s6
ffffffffc0206c44:	9b3e                	add	s6,s6,a5
ffffffffc0206c46:	408b0633          	sub	a2,s6,s0
ffffffffc0206c4a:	016bf463          	bgeu	s7,s6,ffffffffc0206c52 <do_execve+0x744>
ffffffffc0206c4e:	408b8633          	sub	a2,s7,s0
ffffffffc0206c52:	000cb783          	ld	a5,0(s9)
ffffffffc0206c56:	66c2                	ld	a3,16(sp)
ffffffffc0206c58:	000d3703          	ld	a4,0(s10)
ffffffffc0206c5c:	40f487b3          	sub	a5,s1,a5
ffffffffc0206c60:	8799                	srai	a5,a5,0x6
ffffffffc0206c62:	97e2                	add	a5,a5,s8
ffffffffc0206c64:	8efd                	and	a3,a3,a5
ffffffffc0206c66:	07b2                	slli	a5,a5,0xc
ffffffffc0206c68:	0ae6f763          	bgeu	a3,a4,ffffffffc0206d16 <do_execve+0x808>
ffffffffc0206c6c:	00090717          	auipc	a4,0x90
ffffffffc0206c70:	c4c70713          	addi	a4,a4,-948 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206c74:	6318                	ld	a4,0(a4)
ffffffffc0206c76:	9432                	add	s0,s0,a2
ffffffffc0206c78:	4581                	li	a1,0
ffffffffc0206c7a:	97ba                	add	a5,a5,a4
ffffffffc0206c7c:	953e                	add	a0,a0,a5
ffffffffc0206c7e:	376040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206c82:	03747463          	bgeu	s0,s7,ffffffffc0206caa <do_execve+0x79c>
ffffffffc0206c86:	018ab503          	ld	a0,24(s5)
ffffffffc0206c8a:	864a                	mv	a2,s2
ffffffffc0206c8c:	85da                	mv	a1,s6
ffffffffc0206c8e:	ecafd0ef          	jal	ra,ffffffffc0204358 <pgdir_alloc_page>
ffffffffc0206c92:	84aa                	mv	s1,a0
ffffffffc0206c94:	f54d                	bnez	a0,ffffffffc0206c3e <do_execve+0x730>
ffffffffc0206c96:	7b62                	ld	s6,56(sp)
ffffffffc0206c98:	6406                	ld	s0,64(sp)
ffffffffc0206c9a:	4936                	lw	s2,76(sp)
ffffffffc0206c9c:	5df1                	li	s11,-4
ffffffffc0206c9e:	1902                	slli	s2,s2,0x20
ffffffffc0206ca0:	0e010b93          	addi	s7,sp,224
ffffffffc0206ca4:	02095913          	srli	s2,s2,0x20
ffffffffc0206ca8:	b445                	j	ffffffffc0206748 <do_execve+0x23a>
ffffffffc0206caa:	ec26                	sd	s1,24(sp)
ffffffffc0206cac:	b9b1                	j	ffffffffc0206908 <do_execve+0x3fa>
ffffffffc0206cae:	5975                	li	s2,-3
ffffffffc0206cb0:	b40c1de3          	bnez	s8,ffffffffc020680a <do_execve+0x2fc>
ffffffffc0206cb4:	b68d                	j	ffffffffc0206816 <do_execve+0x308>
ffffffffc0206cb6:	ee0c07e3          	beqz	s8,ffffffffc0206ba4 <do_execve+0x696>
ffffffffc0206cba:	038c0513          	addi	a0,s8,56
ffffffffc0206cbe:	a89fd0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0206cc2:	5975                	li	s2,-3
ffffffffc0206cc4:	040c2823          	sw	zero,80(s8)
ffffffffc0206cc8:	b6b9                	j	ffffffffc0206816 <do_execve+0x308>
ffffffffc0206cca:	1902                	slli	s2,s2,0x20
ffffffffc0206ccc:	5df1                	li	s11,-4
ffffffffc0206cce:	0e010b93          	addi	s7,sp,224
ffffffffc0206cd2:	02095913          	srli	s2,s2,0x20
ffffffffc0206cd6:	be69                	j	ffffffffc0206870 <do_execve+0x362>
ffffffffc0206cd8:	8ba2                	mv	s7,s0
ffffffffc0206cda:	8b6e                	mv	s6,s11
ffffffffc0206cdc:	bdd1                	j	ffffffffc0206bb0 <do_execve+0x6a2>
ffffffffc0206cde:	6422                	ld	s0,8(sp)
ffffffffc0206ce0:	5df5                	li	s11,-3
ffffffffc0206ce2:	b49d                	j	ffffffffc0206748 <do_execve+0x23a>
ffffffffc0206ce4:	4936                	lw	s2,76(sp)
ffffffffc0206ce6:	7b62                	ld	s6,56(sp)
ffffffffc0206ce8:	6406                	ld	s0,64(sp)
ffffffffc0206cea:	1902                	slli	s2,s2,0x20
ffffffffc0206cec:	5de1                	li	s11,-8
ffffffffc0206cee:	0e010b93          	addi	s7,sp,224
ffffffffc0206cf2:	02095913          	srli	s2,s2,0x20
ffffffffc0206cf6:	bc89                	j	ffffffffc0206748 <do_execve+0x23a>
ffffffffc0206cf8:	86e2                	mv	a3,s8
ffffffffc0206cfa:	00005617          	auipc	a2,0x5
ffffffffc0206cfe:	62e60613          	addi	a2,a2,1582 # ffffffffc020c328 <commands+0xb90>
ffffffffc0206d02:	07100593          	li	a1,113
ffffffffc0206d06:	00005517          	auipc	a0,0x5
ffffffffc0206d0a:	64a50513          	addi	a0,a0,1610 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0206d0e:	d20f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206d12:	89ee                	mv	s3,s11
ffffffffc0206d14:	bc79                	j	ffffffffc02067b2 <do_execve+0x2a4>
ffffffffc0206d16:	86be                	mv	a3,a5
ffffffffc0206d18:	00005617          	auipc	a2,0x5
ffffffffc0206d1c:	61060613          	addi	a2,a2,1552 # ffffffffc020c328 <commands+0xb90>
ffffffffc0206d20:	07100593          	li	a1,113
ffffffffc0206d24:	00005517          	auipc	a0,0x5
ffffffffc0206d28:	62c50513          	addi	a0,a0,1580 # ffffffffc020c350 <commands+0xbb8>
ffffffffc0206d2c:	d02f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206d30:	00005617          	auipc	a2,0x5
ffffffffc0206d34:	6a060613          	addi	a2,a2,1696 # ffffffffc020c3d0 <commands+0xc38>
ffffffffc0206d38:	36100593          	li	a1,865
ffffffffc0206d3c:	00006517          	auipc	a0,0x6
ffffffffc0206d40:	72c50513          	addi	a0,a0,1836 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206d44:	ceaf90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206d48:	00007697          	auipc	a3,0x7
ffffffffc0206d4c:	97868693          	addi	a3,a3,-1672 # ffffffffc020d6c0 <CSWTCH.79+0x320>
ffffffffc0206d50:	00005617          	auipc	a2,0x5
ffffffffc0206d54:	aa860613          	addi	a2,a2,-1368 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0206d58:	35c00593          	li	a1,860
ffffffffc0206d5c:	00006517          	auipc	a0,0x6
ffffffffc0206d60:	70c50513          	addi	a0,a0,1804 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206d64:	ccaf90ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0206d68 <user_main>:
ffffffffc0206d68:	7179                	addi	sp,sp,-48
ffffffffc0206d6a:	e84a                	sd	s2,16(sp)
ffffffffc0206d6c:	00090917          	auipc	s2,0x90
ffffffffc0206d70:	b5490913          	addi	s2,s2,-1196 # ffffffffc02968c0 <current>
ffffffffc0206d74:	00093783          	ld	a5,0(s2)
ffffffffc0206d78:	00007617          	auipc	a2,0x7
ffffffffc0206d7c:	99060613          	addi	a2,a2,-1648 # ffffffffc020d708 <CSWTCH.79+0x368>
ffffffffc0206d80:	00007517          	auipc	a0,0x7
ffffffffc0206d84:	99050513          	addi	a0,a0,-1648 # ffffffffc020d710 <CSWTCH.79+0x370>
ffffffffc0206d88:	43cc                	lw	a1,4(a5)
ffffffffc0206d8a:	f406                	sd	ra,40(sp)
ffffffffc0206d8c:	f022                	sd	s0,32(sp)
ffffffffc0206d8e:	ec26                	sd	s1,24(sp)
ffffffffc0206d90:	e032                	sd	a2,0(sp)
ffffffffc0206d92:	e402                	sd	zero,8(sp)
ffffffffc0206d94:	b96f90ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0206d98:	6782                	ld	a5,0(sp)
ffffffffc0206d9a:	cfb9                	beqz	a5,ffffffffc0206df8 <user_main+0x90>
ffffffffc0206d9c:	003c                	addi	a5,sp,8
ffffffffc0206d9e:	4401                	li	s0,0
ffffffffc0206da0:	6398                	ld	a4,0(a5)
ffffffffc0206da2:	0405                	addi	s0,s0,1
ffffffffc0206da4:	07a1                	addi	a5,a5,8
ffffffffc0206da6:	ff6d                	bnez	a4,ffffffffc0206da0 <user_main+0x38>
ffffffffc0206da8:	00093783          	ld	a5,0(s2)
ffffffffc0206dac:	12000613          	li	a2,288
ffffffffc0206db0:	6b84                	ld	s1,16(a5)
ffffffffc0206db2:	73cc                	ld	a1,160(a5)
ffffffffc0206db4:	6789                	lui	a5,0x2
ffffffffc0206db6:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206dba:	94be                	add	s1,s1,a5
ffffffffc0206dbc:	8526                	mv	a0,s1
ffffffffc0206dbe:	288040ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0206dc2:	00093783          	ld	a5,0(s2)
ffffffffc0206dc6:	860a                	mv	a2,sp
ffffffffc0206dc8:	0004059b          	sext.w	a1,s0
ffffffffc0206dcc:	f3c4                	sd	s1,160(a5)
ffffffffc0206dce:	00007517          	auipc	a0,0x7
ffffffffc0206dd2:	93a50513          	addi	a0,a0,-1734 # ffffffffc020d708 <CSWTCH.79+0x368>
ffffffffc0206dd6:	f38ff0ef          	jal	ra,ffffffffc020650e <do_execve>
ffffffffc0206dda:	8126                	mv	sp,s1
ffffffffc0206ddc:	c7cfa06f          	j	ffffffffc0201258 <__trapret>
ffffffffc0206de0:	00007617          	auipc	a2,0x7
ffffffffc0206de4:	95860613          	addi	a2,a2,-1704 # ffffffffc020d738 <CSWTCH.79+0x398>
ffffffffc0206de8:	4aa00593          	li	a1,1194
ffffffffc0206dec:	00006517          	auipc	a0,0x6
ffffffffc0206df0:	67c50513          	addi	a0,a0,1660 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0206df4:	c3af90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0206df8:	4401                	li	s0,0
ffffffffc0206dfa:	b77d                	j	ffffffffc0206da8 <user_main+0x40>

ffffffffc0206dfc <do_yield>:
ffffffffc0206dfc:	00090797          	auipc	a5,0x90
ffffffffc0206e00:	ac47b783          	ld	a5,-1340(a5) # ffffffffc02968c0 <current>
ffffffffc0206e04:	4705                	li	a4,1
ffffffffc0206e06:	ef98                	sd	a4,24(a5)
ffffffffc0206e08:	4501                	li	a0,0
ffffffffc0206e0a:	8082                	ret

ffffffffc0206e0c <do_wait>:
ffffffffc0206e0c:	1101                	addi	sp,sp,-32
ffffffffc0206e0e:	e822                	sd	s0,16(sp)
ffffffffc0206e10:	e426                	sd	s1,8(sp)
ffffffffc0206e12:	ec06                	sd	ra,24(sp)
ffffffffc0206e14:	842e                	mv	s0,a1
ffffffffc0206e16:	84aa                	mv	s1,a0
ffffffffc0206e18:	c999                	beqz	a1,ffffffffc0206e2e <do_wait+0x22>
ffffffffc0206e1a:	00090797          	auipc	a5,0x90
ffffffffc0206e1e:	aa67b783          	ld	a5,-1370(a5) # ffffffffc02968c0 <current>
ffffffffc0206e22:	7788                	ld	a0,40(a5)
ffffffffc0206e24:	4685                	li	a3,1
ffffffffc0206e26:	4611                	li	a2,4
ffffffffc0206e28:	b3dfa0ef          	jal	ra,ffffffffc0201964 <user_mem_check>
ffffffffc0206e2c:	c909                	beqz	a0,ffffffffc0206e3e <do_wait+0x32>
ffffffffc0206e2e:	85a2                	mv	a1,s0
ffffffffc0206e30:	6442                	ld	s0,16(sp)
ffffffffc0206e32:	60e2                	ld	ra,24(sp)
ffffffffc0206e34:	8526                	mv	a0,s1
ffffffffc0206e36:	64a2                	ld	s1,8(sp)
ffffffffc0206e38:	6105                	addi	sp,sp,32
ffffffffc0206e3a:	bb2ff06f          	j	ffffffffc02061ec <do_wait.part.0>
ffffffffc0206e3e:	60e2                	ld	ra,24(sp)
ffffffffc0206e40:	6442                	ld	s0,16(sp)
ffffffffc0206e42:	64a2                	ld	s1,8(sp)
ffffffffc0206e44:	5575                	li	a0,-3
ffffffffc0206e46:	6105                	addi	sp,sp,32
ffffffffc0206e48:	8082                	ret

ffffffffc0206e4a <do_kill>:
ffffffffc0206e4a:	1141                	addi	sp,sp,-16
ffffffffc0206e4c:	6789                	lui	a5,0x2
ffffffffc0206e4e:	e406                	sd	ra,8(sp)
ffffffffc0206e50:	e022                	sd	s0,0(sp)
ffffffffc0206e52:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206e56:	17f9                	addi	a5,a5,-2
ffffffffc0206e58:	02e7e963          	bltu	a5,a4,ffffffffc0206e8a <do_kill+0x40>
ffffffffc0206e5c:	842a                	mv	s0,a0
ffffffffc0206e5e:	45a9                	li	a1,10
ffffffffc0206e60:	2501                	sext.w	a0,a0
ffffffffc0206e62:	678040ef          	jal	ra,ffffffffc020b4da <hash32>
ffffffffc0206e66:	02051793          	slli	a5,a0,0x20
ffffffffc0206e6a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206e6e:	0008b797          	auipc	a5,0x8b
ffffffffc0206e72:	95278793          	addi	a5,a5,-1710 # ffffffffc02917c0 <hash_list>
ffffffffc0206e76:	953e                	add	a0,a0,a5
ffffffffc0206e78:	87aa                	mv	a5,a0
ffffffffc0206e7a:	a029                	j	ffffffffc0206e84 <do_kill+0x3a>
ffffffffc0206e7c:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206e80:	00870b63          	beq	a4,s0,ffffffffc0206e96 <do_kill+0x4c>
ffffffffc0206e84:	679c                	ld	a5,8(a5)
ffffffffc0206e86:	fef51be3          	bne	a0,a5,ffffffffc0206e7c <do_kill+0x32>
ffffffffc0206e8a:	5475                	li	s0,-3
ffffffffc0206e8c:	60a2                	ld	ra,8(sp)
ffffffffc0206e8e:	8522                	mv	a0,s0
ffffffffc0206e90:	6402                	ld	s0,0(sp)
ffffffffc0206e92:	0141                	addi	sp,sp,16
ffffffffc0206e94:	8082                	ret
ffffffffc0206e96:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206e9a:	00177693          	andi	a3,a4,1
ffffffffc0206e9e:	e295                	bnez	a3,ffffffffc0206ec2 <do_kill+0x78>
ffffffffc0206ea0:	4bd4                	lw	a3,20(a5)
ffffffffc0206ea2:	00176713          	ori	a4,a4,1
ffffffffc0206ea6:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206eaa:	4401                	li	s0,0
ffffffffc0206eac:	fe06d0e3          	bgez	a3,ffffffffc0206e8c <do_kill+0x42>
ffffffffc0206eb0:	f2878513          	addi	a0,a5,-216
ffffffffc0206eb4:	308000ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc0206eb8:	60a2                	ld	ra,8(sp)
ffffffffc0206eba:	8522                	mv	a0,s0
ffffffffc0206ebc:	6402                	ld	s0,0(sp)
ffffffffc0206ebe:	0141                	addi	sp,sp,16
ffffffffc0206ec0:	8082                	ret
ffffffffc0206ec2:	545d                	li	s0,-9
ffffffffc0206ec4:	b7e1                	j	ffffffffc0206e8c <do_kill+0x42>

ffffffffc0206ec6 <proc_init>:
ffffffffc0206ec6:	1101                	addi	sp,sp,-32
ffffffffc0206ec8:	e426                	sd	s1,8(sp)
ffffffffc0206eca:	0008f797          	auipc	a5,0x8f
ffffffffc0206ece:	8f678793          	addi	a5,a5,-1802 # ffffffffc02957c0 <proc_list>
ffffffffc0206ed2:	ec06                	sd	ra,24(sp)
ffffffffc0206ed4:	e822                	sd	s0,16(sp)
ffffffffc0206ed6:	e04a                	sd	s2,0(sp)
ffffffffc0206ed8:	0008b497          	auipc	s1,0x8b
ffffffffc0206edc:	8e848493          	addi	s1,s1,-1816 # ffffffffc02917c0 <hash_list>
ffffffffc0206ee0:	e79c                	sd	a5,8(a5)
ffffffffc0206ee2:	e39c                	sd	a5,0(a5)
ffffffffc0206ee4:	0008f717          	auipc	a4,0x8f
ffffffffc0206ee8:	8dc70713          	addi	a4,a4,-1828 # ffffffffc02957c0 <proc_list>
ffffffffc0206eec:	87a6                	mv	a5,s1
ffffffffc0206eee:	e79c                	sd	a5,8(a5)
ffffffffc0206ef0:	e39c                	sd	a5,0(a5)
ffffffffc0206ef2:	07c1                	addi	a5,a5,16
ffffffffc0206ef4:	fef71de3          	bne	a4,a5,ffffffffc0206eee <proc_init+0x28>
ffffffffc0206ef8:	b51fe0ef          	jal	ra,ffffffffc0205a48 <alloc_proc>
ffffffffc0206efc:	00090917          	auipc	s2,0x90
ffffffffc0206f00:	9cc90913          	addi	s2,s2,-1588 # ffffffffc02968c8 <idleproc>
ffffffffc0206f04:	00a93023          	sd	a0,0(s2)
ffffffffc0206f08:	842a                	mv	s0,a0
ffffffffc0206f0a:	12050863          	beqz	a0,ffffffffc020703a <proc_init+0x174>
ffffffffc0206f0e:	4789                	li	a5,2
ffffffffc0206f10:	e11c                	sd	a5,0(a0)
ffffffffc0206f12:	0000a797          	auipc	a5,0xa
ffffffffc0206f16:	0ee78793          	addi	a5,a5,238 # ffffffffc0211000 <bootstack>
ffffffffc0206f1a:	e91c                	sd	a5,16(a0)
ffffffffc0206f1c:	4785                	li	a5,1
ffffffffc0206f1e:	ed1c                	sd	a5,24(a0)
ffffffffc0206f20:	8c7fe0ef          	jal	ra,ffffffffc02057e6 <files_create>
ffffffffc0206f24:	14a43423          	sd	a0,328(s0)
ffffffffc0206f28:	0e050d63          	beqz	a0,ffffffffc0207022 <proc_init+0x15c>
ffffffffc0206f2c:	00093403          	ld	s0,0(s2)
ffffffffc0206f30:	4641                	li	a2,16
ffffffffc0206f32:	4581                	li	a1,0
ffffffffc0206f34:	14843703          	ld	a4,328(s0)
ffffffffc0206f38:	0b440413          	addi	s0,s0,180
ffffffffc0206f3c:	8522                	mv	a0,s0
ffffffffc0206f3e:	4b1c                	lw	a5,16(a4)
ffffffffc0206f40:	2785                	addiw	a5,a5,1
ffffffffc0206f42:	cb1c                	sw	a5,16(a4)
ffffffffc0206f44:	0b0040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206f48:	463d                	li	a2,15
ffffffffc0206f4a:	00007597          	auipc	a1,0x7
ffffffffc0206f4e:	84e58593          	addi	a1,a1,-1970 # ffffffffc020d798 <CSWTCH.79+0x3f8>
ffffffffc0206f52:	8522                	mv	a0,s0
ffffffffc0206f54:	0f2040ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0206f58:	00090717          	auipc	a4,0x90
ffffffffc0206f5c:	98070713          	addi	a4,a4,-1664 # ffffffffc02968d8 <nr_process>
ffffffffc0206f60:	431c                	lw	a5,0(a4)
ffffffffc0206f62:	00093683          	ld	a3,0(s2)
ffffffffc0206f66:	4601                	li	a2,0
ffffffffc0206f68:	2785                	addiw	a5,a5,1
ffffffffc0206f6a:	4581                	li	a1,0
ffffffffc0206f6c:	fffff517          	auipc	a0,0xfffff
ffffffffc0206f70:	45250513          	addi	a0,a0,1106 # ffffffffc02063be <init_main>
ffffffffc0206f74:	c31c                	sw	a5,0(a4)
ffffffffc0206f76:	00090797          	auipc	a5,0x90
ffffffffc0206f7a:	94d7b523          	sd	a3,-1718(a5) # ffffffffc02968c0 <current>
ffffffffc0206f7e:	8bcff0ef          	jal	ra,ffffffffc020603a <kernel_thread>
ffffffffc0206f82:	842a                	mv	s0,a0
ffffffffc0206f84:	08a05363          	blez	a0,ffffffffc020700a <proc_init+0x144>
ffffffffc0206f88:	6789                	lui	a5,0x2
ffffffffc0206f8a:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206f8e:	17f9                	addi	a5,a5,-2
ffffffffc0206f90:	2501                	sext.w	a0,a0
ffffffffc0206f92:	02e7e363          	bltu	a5,a4,ffffffffc0206fb8 <proc_init+0xf2>
ffffffffc0206f96:	45a9                	li	a1,10
ffffffffc0206f98:	542040ef          	jal	ra,ffffffffc020b4da <hash32>
ffffffffc0206f9c:	02051793          	slli	a5,a0,0x20
ffffffffc0206fa0:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206fa4:	96a6                	add	a3,a3,s1
ffffffffc0206fa6:	87b6                	mv	a5,a3
ffffffffc0206fa8:	a029                	j	ffffffffc0206fb2 <proc_init+0xec>
ffffffffc0206faa:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206fae:	04870b63          	beq	a4,s0,ffffffffc0207004 <proc_init+0x13e>
ffffffffc0206fb2:	679c                	ld	a5,8(a5)
ffffffffc0206fb4:	fef69be3          	bne	a3,a5,ffffffffc0206faa <proc_init+0xe4>
ffffffffc0206fb8:	4781                	li	a5,0
ffffffffc0206fba:	0b478493          	addi	s1,a5,180
ffffffffc0206fbe:	4641                	li	a2,16
ffffffffc0206fc0:	4581                	li	a1,0
ffffffffc0206fc2:	00090417          	auipc	s0,0x90
ffffffffc0206fc6:	90e40413          	addi	s0,s0,-1778 # ffffffffc02968d0 <initproc>
ffffffffc0206fca:	8526                	mv	a0,s1
ffffffffc0206fcc:	e01c                	sd	a5,0(s0)
ffffffffc0206fce:	026040ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0206fd2:	463d                	li	a2,15
ffffffffc0206fd4:	00006597          	auipc	a1,0x6
ffffffffc0206fd8:	7ec58593          	addi	a1,a1,2028 # ffffffffc020d7c0 <CSWTCH.79+0x420>
ffffffffc0206fdc:	8526                	mv	a0,s1
ffffffffc0206fde:	068040ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0206fe2:	00093783          	ld	a5,0(s2)
ffffffffc0206fe6:	c7d1                	beqz	a5,ffffffffc0207072 <proc_init+0x1ac>
ffffffffc0206fe8:	43dc                	lw	a5,4(a5)
ffffffffc0206fea:	e7c1                	bnez	a5,ffffffffc0207072 <proc_init+0x1ac>
ffffffffc0206fec:	601c                	ld	a5,0(s0)
ffffffffc0206fee:	c3b5                	beqz	a5,ffffffffc0207052 <proc_init+0x18c>
ffffffffc0206ff0:	43d8                	lw	a4,4(a5)
ffffffffc0206ff2:	4785                	li	a5,1
ffffffffc0206ff4:	04f71f63          	bne	a4,a5,ffffffffc0207052 <proc_init+0x18c>
ffffffffc0206ff8:	60e2                	ld	ra,24(sp)
ffffffffc0206ffa:	6442                	ld	s0,16(sp)
ffffffffc0206ffc:	64a2                	ld	s1,8(sp)
ffffffffc0206ffe:	6902                	ld	s2,0(sp)
ffffffffc0207000:	6105                	addi	sp,sp,32
ffffffffc0207002:	8082                	ret
ffffffffc0207004:	f2878793          	addi	a5,a5,-216
ffffffffc0207008:	bf4d                	j	ffffffffc0206fba <proc_init+0xf4>
ffffffffc020700a:	00006617          	auipc	a2,0x6
ffffffffc020700e:	79660613          	addi	a2,a2,1942 # ffffffffc020d7a0 <CSWTCH.79+0x400>
ffffffffc0207012:	4f600593          	li	a1,1270
ffffffffc0207016:	00006517          	auipc	a0,0x6
ffffffffc020701a:	45250513          	addi	a0,a0,1106 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc020701e:	a10f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207022:	00006617          	auipc	a2,0x6
ffffffffc0207026:	74e60613          	addi	a2,a2,1870 # ffffffffc020d770 <CSWTCH.79+0x3d0>
ffffffffc020702a:	4ea00593          	li	a1,1258
ffffffffc020702e:	00006517          	auipc	a0,0x6
ffffffffc0207032:	43a50513          	addi	a0,a0,1082 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc0207036:	9f8f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020703a:	00006617          	auipc	a2,0x6
ffffffffc020703e:	71e60613          	addi	a2,a2,1822 # ffffffffc020d758 <CSWTCH.79+0x3b8>
ffffffffc0207042:	4e000593          	li	a1,1248
ffffffffc0207046:	00006517          	auipc	a0,0x6
ffffffffc020704a:	42250513          	addi	a0,a0,1058 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc020704e:	9e0f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207052:	00006697          	auipc	a3,0x6
ffffffffc0207056:	79e68693          	addi	a3,a3,1950 # ffffffffc020d7f0 <CSWTCH.79+0x450>
ffffffffc020705a:	00004617          	auipc	a2,0x4
ffffffffc020705e:	79e60613          	addi	a2,a2,1950 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207062:	4fd00593          	li	a1,1277
ffffffffc0207066:	00006517          	auipc	a0,0x6
ffffffffc020706a:	40250513          	addi	a0,a0,1026 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc020706e:	9c0f90ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207072:	00006697          	auipc	a3,0x6
ffffffffc0207076:	75668693          	addi	a3,a3,1878 # ffffffffc020d7c8 <CSWTCH.79+0x428>
ffffffffc020707a:	00004617          	auipc	a2,0x4
ffffffffc020707e:	77e60613          	addi	a2,a2,1918 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207082:	4fc00593          	li	a1,1276
ffffffffc0207086:	00006517          	auipc	a0,0x6
ffffffffc020708a:	3e250513          	addi	a0,a0,994 # ffffffffc020d468 <CSWTCH.79+0xc8>
ffffffffc020708e:	9a0f90ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207092 <cpu_idle>:
ffffffffc0207092:	1141                	addi	sp,sp,-16
ffffffffc0207094:	e022                	sd	s0,0(sp)
ffffffffc0207096:	e406                	sd	ra,8(sp)
ffffffffc0207098:	00090417          	auipc	s0,0x90
ffffffffc020709c:	82840413          	addi	s0,s0,-2008 # ffffffffc02968c0 <current>
ffffffffc02070a0:	6018                	ld	a4,0(s0)
ffffffffc02070a2:	6f1c                	ld	a5,24(a4)
ffffffffc02070a4:	dffd                	beqz	a5,ffffffffc02070a2 <cpu_idle+0x10>
ffffffffc02070a6:	1c8000ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc02070aa:	bfdd                	j	ffffffffc02070a0 <cpu_idle+0xe>

ffffffffc02070ac <lab6_set_priority>:
ffffffffc02070ac:	1141                	addi	sp,sp,-16
ffffffffc02070ae:	e022                	sd	s0,0(sp)
ffffffffc02070b0:	85aa                	mv	a1,a0
ffffffffc02070b2:	842a                	mv	s0,a0
ffffffffc02070b4:	00006517          	auipc	a0,0x6
ffffffffc02070b8:	76450513          	addi	a0,a0,1892 # ffffffffc020d818 <CSWTCH.79+0x478>
ffffffffc02070bc:	e406                	sd	ra,8(sp)
ffffffffc02070be:	86cf90ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02070c2:	0008f797          	auipc	a5,0x8f
ffffffffc02070c6:	7fe7b783          	ld	a5,2046(a5) # ffffffffc02968c0 <current>
ffffffffc02070ca:	e801                	bnez	s0,ffffffffc02070da <lab6_set_priority+0x2e>
ffffffffc02070cc:	60a2                	ld	ra,8(sp)
ffffffffc02070ce:	6402                	ld	s0,0(sp)
ffffffffc02070d0:	4705                	li	a4,1
ffffffffc02070d2:	14e7a223          	sw	a4,324(a5)
ffffffffc02070d6:	0141                	addi	sp,sp,16
ffffffffc02070d8:	8082                	ret
ffffffffc02070da:	60a2                	ld	ra,8(sp)
ffffffffc02070dc:	1487a223          	sw	s0,324(a5)
ffffffffc02070e0:	6402                	ld	s0,0(sp)
ffffffffc02070e2:	0141                	addi	sp,sp,16
ffffffffc02070e4:	8082                	ret

ffffffffc02070e6 <do_sleep>:
ffffffffc02070e6:	c539                	beqz	a0,ffffffffc0207134 <do_sleep+0x4e>
ffffffffc02070e8:	7179                	addi	sp,sp,-48
ffffffffc02070ea:	f022                	sd	s0,32(sp)
ffffffffc02070ec:	f406                	sd	ra,40(sp)
ffffffffc02070ee:	842a                	mv	s0,a0
ffffffffc02070f0:	100027f3          	csrr	a5,sstatus
ffffffffc02070f4:	8b89                	andi	a5,a5,2
ffffffffc02070f6:	e3a9                	bnez	a5,ffffffffc0207138 <do_sleep+0x52>
ffffffffc02070f8:	0008f797          	auipc	a5,0x8f
ffffffffc02070fc:	7c87b783          	ld	a5,1992(a5) # ffffffffc02968c0 <current>
ffffffffc0207100:	0818                	addi	a4,sp,16
ffffffffc0207102:	c02a                	sw	a0,0(sp)
ffffffffc0207104:	ec3a                	sd	a4,24(sp)
ffffffffc0207106:	e83a                	sd	a4,16(sp)
ffffffffc0207108:	e43e                	sd	a5,8(sp)
ffffffffc020710a:	4705                	li	a4,1
ffffffffc020710c:	c398                	sw	a4,0(a5)
ffffffffc020710e:	80000737          	lui	a4,0x80000
ffffffffc0207112:	840a                	mv	s0,sp
ffffffffc0207114:	0709                	addi	a4,a4,2
ffffffffc0207116:	0ee7a623          	sw	a4,236(a5)
ffffffffc020711a:	8522                	mv	a0,s0
ffffffffc020711c:	212000ef          	jal	ra,ffffffffc020732e <add_timer>
ffffffffc0207120:	14e000ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc0207124:	8522                	mv	a0,s0
ffffffffc0207126:	2d0000ef          	jal	ra,ffffffffc02073f6 <del_timer>
ffffffffc020712a:	70a2                	ld	ra,40(sp)
ffffffffc020712c:	7402                	ld	s0,32(sp)
ffffffffc020712e:	4501                	li	a0,0
ffffffffc0207130:	6145                	addi	sp,sp,48
ffffffffc0207132:	8082                	ret
ffffffffc0207134:	4501                	li	a0,0
ffffffffc0207136:	8082                	ret
ffffffffc0207138:	c6df90ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020713c:	0008f797          	auipc	a5,0x8f
ffffffffc0207140:	7847b783          	ld	a5,1924(a5) # ffffffffc02968c0 <current>
ffffffffc0207144:	0818                	addi	a4,sp,16
ffffffffc0207146:	c022                	sw	s0,0(sp)
ffffffffc0207148:	e43e                	sd	a5,8(sp)
ffffffffc020714a:	ec3a                	sd	a4,24(sp)
ffffffffc020714c:	e83a                	sd	a4,16(sp)
ffffffffc020714e:	4705                	li	a4,1
ffffffffc0207150:	c398                	sw	a4,0(a5)
ffffffffc0207152:	80000737          	lui	a4,0x80000
ffffffffc0207156:	0709                	addi	a4,a4,2
ffffffffc0207158:	840a                	mv	s0,sp
ffffffffc020715a:	8522                	mv	a0,s0
ffffffffc020715c:	0ee7a623          	sw	a4,236(a5)
ffffffffc0207160:	1ce000ef          	jal	ra,ffffffffc020732e <add_timer>
ffffffffc0207164:	c3bf90ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0207168:	bf65                	j	ffffffffc0207120 <do_sleep+0x3a>

ffffffffc020716a <sched_init>:
ffffffffc020716a:	1141                	addi	sp,sp,-16
ffffffffc020716c:	0008a717          	auipc	a4,0x8a
ffffffffc0207170:	eb470713          	addi	a4,a4,-332 # ffffffffc0291020 <default_sched_class>
ffffffffc0207174:	e022                	sd	s0,0(sp)
ffffffffc0207176:	e406                	sd	ra,8(sp)
ffffffffc0207178:	0008e797          	auipc	a5,0x8e
ffffffffc020717c:	67878793          	addi	a5,a5,1656 # ffffffffc02957f0 <timer_list>
ffffffffc0207180:	6714                	ld	a3,8(a4)
ffffffffc0207182:	0008e517          	auipc	a0,0x8e
ffffffffc0207186:	64e50513          	addi	a0,a0,1614 # ffffffffc02957d0 <__rq>
ffffffffc020718a:	e79c                	sd	a5,8(a5)
ffffffffc020718c:	e39c                	sd	a5,0(a5)
ffffffffc020718e:	4795                	li	a5,5
ffffffffc0207190:	c95c                	sw	a5,20(a0)
ffffffffc0207192:	0008f417          	auipc	s0,0x8f
ffffffffc0207196:	75640413          	addi	s0,s0,1878 # ffffffffc02968e8 <sched_class>
ffffffffc020719a:	0008f797          	auipc	a5,0x8f
ffffffffc020719e:	74a7b323          	sd	a0,1862(a5) # ffffffffc02968e0 <rq>
ffffffffc02071a2:	e018                	sd	a4,0(s0)
ffffffffc02071a4:	9682                	jalr	a3
ffffffffc02071a6:	601c                	ld	a5,0(s0)
ffffffffc02071a8:	6402                	ld	s0,0(sp)
ffffffffc02071aa:	60a2                	ld	ra,8(sp)
ffffffffc02071ac:	638c                	ld	a1,0(a5)
ffffffffc02071ae:	00006517          	auipc	a0,0x6
ffffffffc02071b2:	68250513          	addi	a0,a0,1666 # ffffffffc020d830 <CSWTCH.79+0x490>
ffffffffc02071b6:	0141                	addi	sp,sp,16
ffffffffc02071b8:	f73f806f          	j	ffffffffc020012a <cprintf>

ffffffffc02071bc <wakeup_proc>:
ffffffffc02071bc:	4118                	lw	a4,0(a0)
ffffffffc02071be:	1101                	addi	sp,sp,-32
ffffffffc02071c0:	ec06                	sd	ra,24(sp)
ffffffffc02071c2:	e822                	sd	s0,16(sp)
ffffffffc02071c4:	e426                	sd	s1,8(sp)
ffffffffc02071c6:	478d                	li	a5,3
ffffffffc02071c8:	08f70363          	beq	a4,a5,ffffffffc020724e <wakeup_proc+0x92>
ffffffffc02071cc:	842a                	mv	s0,a0
ffffffffc02071ce:	100027f3          	csrr	a5,sstatus
ffffffffc02071d2:	8b89                	andi	a5,a5,2
ffffffffc02071d4:	4481                	li	s1,0
ffffffffc02071d6:	e7bd                	bnez	a5,ffffffffc0207244 <wakeup_proc+0x88>
ffffffffc02071d8:	4789                	li	a5,2
ffffffffc02071da:	04f70863          	beq	a4,a5,ffffffffc020722a <wakeup_proc+0x6e>
ffffffffc02071de:	c01c                	sw	a5,0(s0)
ffffffffc02071e0:	0e042623          	sw	zero,236(s0)
ffffffffc02071e4:	0008f797          	auipc	a5,0x8f
ffffffffc02071e8:	6dc7b783          	ld	a5,1756(a5) # ffffffffc02968c0 <current>
ffffffffc02071ec:	02878363          	beq	a5,s0,ffffffffc0207212 <wakeup_proc+0x56>
ffffffffc02071f0:	0008f797          	auipc	a5,0x8f
ffffffffc02071f4:	6d87b783          	ld	a5,1752(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02071f8:	00f40d63          	beq	s0,a5,ffffffffc0207212 <wakeup_proc+0x56>
ffffffffc02071fc:	0008f797          	auipc	a5,0x8f
ffffffffc0207200:	6ec7b783          	ld	a5,1772(a5) # ffffffffc02968e8 <sched_class>
ffffffffc0207204:	6b9c                	ld	a5,16(a5)
ffffffffc0207206:	85a2                	mv	a1,s0
ffffffffc0207208:	0008f517          	auipc	a0,0x8f
ffffffffc020720c:	6d853503          	ld	a0,1752(a0) # ffffffffc02968e0 <rq>
ffffffffc0207210:	9782                	jalr	a5
ffffffffc0207212:	e491                	bnez	s1,ffffffffc020721e <wakeup_proc+0x62>
ffffffffc0207214:	60e2                	ld	ra,24(sp)
ffffffffc0207216:	6442                	ld	s0,16(sp)
ffffffffc0207218:	64a2                	ld	s1,8(sp)
ffffffffc020721a:	6105                	addi	sp,sp,32
ffffffffc020721c:	8082                	ret
ffffffffc020721e:	6442                	ld	s0,16(sp)
ffffffffc0207220:	60e2                	ld	ra,24(sp)
ffffffffc0207222:	64a2                	ld	s1,8(sp)
ffffffffc0207224:	6105                	addi	sp,sp,32
ffffffffc0207226:	b79f906f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc020722a:	00006617          	auipc	a2,0x6
ffffffffc020722e:	65660613          	addi	a2,a2,1622 # ffffffffc020d880 <CSWTCH.79+0x4e0>
ffffffffc0207232:	05200593          	li	a1,82
ffffffffc0207236:	00006517          	auipc	a0,0x6
ffffffffc020723a:	63250513          	addi	a0,a0,1586 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc020723e:	858f90ef          	jal	ra,ffffffffc0200296 <__warn>
ffffffffc0207242:	bfc1                	j	ffffffffc0207212 <wakeup_proc+0x56>
ffffffffc0207244:	b61f90ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0207248:	4018                	lw	a4,0(s0)
ffffffffc020724a:	4485                	li	s1,1
ffffffffc020724c:	b771                	j	ffffffffc02071d8 <wakeup_proc+0x1c>
ffffffffc020724e:	00006697          	auipc	a3,0x6
ffffffffc0207252:	5fa68693          	addi	a3,a3,1530 # ffffffffc020d848 <CSWTCH.79+0x4a8>
ffffffffc0207256:	00004617          	auipc	a2,0x4
ffffffffc020725a:	5a260613          	addi	a2,a2,1442 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020725e:	04300593          	li	a1,67
ffffffffc0207262:	00006517          	auipc	a0,0x6
ffffffffc0207266:	60650513          	addi	a0,a0,1542 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc020726a:	fc5f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020726e <schedule>:
ffffffffc020726e:	7179                	addi	sp,sp,-48
ffffffffc0207270:	f406                	sd	ra,40(sp)
ffffffffc0207272:	f022                	sd	s0,32(sp)
ffffffffc0207274:	ec26                	sd	s1,24(sp)
ffffffffc0207276:	e84a                	sd	s2,16(sp)
ffffffffc0207278:	e44e                	sd	s3,8(sp)
ffffffffc020727a:	e052                	sd	s4,0(sp)
ffffffffc020727c:	100027f3          	csrr	a5,sstatus
ffffffffc0207280:	8b89                	andi	a5,a5,2
ffffffffc0207282:	4a01                	li	s4,0
ffffffffc0207284:	e3cd                	bnez	a5,ffffffffc0207326 <schedule+0xb8>
ffffffffc0207286:	0008f497          	auipc	s1,0x8f
ffffffffc020728a:	63a48493          	addi	s1,s1,1594 # ffffffffc02968c0 <current>
ffffffffc020728e:	608c                	ld	a1,0(s1)
ffffffffc0207290:	0008f997          	auipc	s3,0x8f
ffffffffc0207294:	65898993          	addi	s3,s3,1624 # ffffffffc02968e8 <sched_class>
ffffffffc0207298:	0008f917          	auipc	s2,0x8f
ffffffffc020729c:	64890913          	addi	s2,s2,1608 # ffffffffc02968e0 <rq>
ffffffffc02072a0:	4194                	lw	a3,0(a1)
ffffffffc02072a2:	0005bc23          	sd	zero,24(a1)
ffffffffc02072a6:	4709                	li	a4,2
ffffffffc02072a8:	0009b783          	ld	a5,0(s3)
ffffffffc02072ac:	00093503          	ld	a0,0(s2)
ffffffffc02072b0:	04e68e63          	beq	a3,a4,ffffffffc020730c <schedule+0x9e>
ffffffffc02072b4:	739c                	ld	a5,32(a5)
ffffffffc02072b6:	9782                	jalr	a5
ffffffffc02072b8:	842a                	mv	s0,a0
ffffffffc02072ba:	c521                	beqz	a0,ffffffffc0207302 <schedule+0x94>
ffffffffc02072bc:	0009b783          	ld	a5,0(s3)
ffffffffc02072c0:	00093503          	ld	a0,0(s2)
ffffffffc02072c4:	85a2                	mv	a1,s0
ffffffffc02072c6:	6f9c                	ld	a5,24(a5)
ffffffffc02072c8:	9782                	jalr	a5
ffffffffc02072ca:	441c                	lw	a5,8(s0)
ffffffffc02072cc:	6098                	ld	a4,0(s1)
ffffffffc02072ce:	2785                	addiw	a5,a5,1
ffffffffc02072d0:	c41c                	sw	a5,8(s0)
ffffffffc02072d2:	00870563          	beq	a4,s0,ffffffffc02072dc <schedule+0x6e>
ffffffffc02072d6:	8522                	mv	a0,s0
ffffffffc02072d8:	893fe0ef          	jal	ra,ffffffffc0205b6a <proc_run>
ffffffffc02072dc:	000a1a63          	bnez	s4,ffffffffc02072f0 <schedule+0x82>
ffffffffc02072e0:	70a2                	ld	ra,40(sp)
ffffffffc02072e2:	7402                	ld	s0,32(sp)
ffffffffc02072e4:	64e2                	ld	s1,24(sp)
ffffffffc02072e6:	6942                	ld	s2,16(sp)
ffffffffc02072e8:	69a2                	ld	s3,8(sp)
ffffffffc02072ea:	6a02                	ld	s4,0(sp)
ffffffffc02072ec:	6145                	addi	sp,sp,48
ffffffffc02072ee:	8082                	ret
ffffffffc02072f0:	7402                	ld	s0,32(sp)
ffffffffc02072f2:	70a2                	ld	ra,40(sp)
ffffffffc02072f4:	64e2                	ld	s1,24(sp)
ffffffffc02072f6:	6942                	ld	s2,16(sp)
ffffffffc02072f8:	69a2                	ld	s3,8(sp)
ffffffffc02072fa:	6a02                	ld	s4,0(sp)
ffffffffc02072fc:	6145                	addi	sp,sp,48
ffffffffc02072fe:	aa1f906f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc0207302:	0008f417          	auipc	s0,0x8f
ffffffffc0207306:	5c643403          	ld	s0,1478(s0) # ffffffffc02968c8 <idleproc>
ffffffffc020730a:	b7c1                	j	ffffffffc02072ca <schedule+0x5c>
ffffffffc020730c:	0008f717          	auipc	a4,0x8f
ffffffffc0207310:	5bc73703          	ld	a4,1468(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0207314:	fae580e3          	beq	a1,a4,ffffffffc02072b4 <schedule+0x46>
ffffffffc0207318:	6b9c                	ld	a5,16(a5)
ffffffffc020731a:	9782                	jalr	a5
ffffffffc020731c:	0009b783          	ld	a5,0(s3)
ffffffffc0207320:	00093503          	ld	a0,0(s2)
ffffffffc0207324:	bf41                	j	ffffffffc02072b4 <schedule+0x46>
ffffffffc0207326:	a7ff90ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc020732a:	4a05                	li	s4,1
ffffffffc020732c:	bfa9                	j	ffffffffc0207286 <schedule+0x18>

ffffffffc020732e <add_timer>:
ffffffffc020732e:	1141                	addi	sp,sp,-16
ffffffffc0207330:	e022                	sd	s0,0(sp)
ffffffffc0207332:	e406                	sd	ra,8(sp)
ffffffffc0207334:	842a                	mv	s0,a0
ffffffffc0207336:	100027f3          	csrr	a5,sstatus
ffffffffc020733a:	8b89                	andi	a5,a5,2
ffffffffc020733c:	4501                	li	a0,0
ffffffffc020733e:	eba5                	bnez	a5,ffffffffc02073ae <add_timer+0x80>
ffffffffc0207340:	401c                	lw	a5,0(s0)
ffffffffc0207342:	cbb5                	beqz	a5,ffffffffc02073b6 <add_timer+0x88>
ffffffffc0207344:	6418                	ld	a4,8(s0)
ffffffffc0207346:	cb25                	beqz	a4,ffffffffc02073b6 <add_timer+0x88>
ffffffffc0207348:	6c18                	ld	a4,24(s0)
ffffffffc020734a:	01040593          	addi	a1,s0,16
ffffffffc020734e:	08e59463          	bne	a1,a4,ffffffffc02073d6 <add_timer+0xa8>
ffffffffc0207352:	0008e617          	auipc	a2,0x8e
ffffffffc0207356:	49e60613          	addi	a2,a2,1182 # ffffffffc02957f0 <timer_list>
ffffffffc020735a:	6618                	ld	a4,8(a2)
ffffffffc020735c:	00c71863          	bne	a4,a2,ffffffffc020736c <add_timer+0x3e>
ffffffffc0207360:	a80d                	j	ffffffffc0207392 <add_timer+0x64>
ffffffffc0207362:	6718                	ld	a4,8(a4)
ffffffffc0207364:	9f95                	subw	a5,a5,a3
ffffffffc0207366:	c01c                	sw	a5,0(s0)
ffffffffc0207368:	02c70563          	beq	a4,a2,ffffffffc0207392 <add_timer+0x64>
ffffffffc020736c:	ff072683          	lw	a3,-16(a4)
ffffffffc0207370:	fed7f9e3          	bgeu	a5,a3,ffffffffc0207362 <add_timer+0x34>
ffffffffc0207374:	40f687bb          	subw	a5,a3,a5
ffffffffc0207378:	fef72823          	sw	a5,-16(a4)
ffffffffc020737c:	631c                	ld	a5,0(a4)
ffffffffc020737e:	e30c                	sd	a1,0(a4)
ffffffffc0207380:	e78c                	sd	a1,8(a5)
ffffffffc0207382:	ec18                	sd	a4,24(s0)
ffffffffc0207384:	e81c                	sd	a5,16(s0)
ffffffffc0207386:	c105                	beqz	a0,ffffffffc02073a6 <add_timer+0x78>
ffffffffc0207388:	6402                	ld	s0,0(sp)
ffffffffc020738a:	60a2                	ld	ra,8(sp)
ffffffffc020738c:	0141                	addi	sp,sp,16
ffffffffc020738e:	a11f906f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc0207392:	0008e717          	auipc	a4,0x8e
ffffffffc0207396:	45e70713          	addi	a4,a4,1118 # ffffffffc02957f0 <timer_list>
ffffffffc020739a:	631c                	ld	a5,0(a4)
ffffffffc020739c:	e30c                	sd	a1,0(a4)
ffffffffc020739e:	e78c                	sd	a1,8(a5)
ffffffffc02073a0:	ec18                	sd	a4,24(s0)
ffffffffc02073a2:	e81c                	sd	a5,16(s0)
ffffffffc02073a4:	f175                	bnez	a0,ffffffffc0207388 <add_timer+0x5a>
ffffffffc02073a6:	60a2                	ld	ra,8(sp)
ffffffffc02073a8:	6402                	ld	s0,0(sp)
ffffffffc02073aa:	0141                	addi	sp,sp,16
ffffffffc02073ac:	8082                	ret
ffffffffc02073ae:	9f7f90ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02073b2:	4505                	li	a0,1
ffffffffc02073b4:	b771                	j	ffffffffc0207340 <add_timer+0x12>
ffffffffc02073b6:	00006697          	auipc	a3,0x6
ffffffffc02073ba:	4ea68693          	addi	a3,a3,1258 # ffffffffc020d8a0 <CSWTCH.79+0x500>
ffffffffc02073be:	00004617          	auipc	a2,0x4
ffffffffc02073c2:	43a60613          	addi	a2,a2,1082 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02073c6:	07a00593          	li	a1,122
ffffffffc02073ca:	00006517          	auipc	a0,0x6
ffffffffc02073ce:	49e50513          	addi	a0,a0,1182 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc02073d2:	e5df80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02073d6:	00006697          	auipc	a3,0x6
ffffffffc02073da:	4fa68693          	addi	a3,a3,1274 # ffffffffc020d8d0 <CSWTCH.79+0x530>
ffffffffc02073de:	00004617          	auipc	a2,0x4
ffffffffc02073e2:	41a60613          	addi	a2,a2,1050 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02073e6:	07b00593          	li	a1,123
ffffffffc02073ea:	00006517          	auipc	a0,0x6
ffffffffc02073ee:	47e50513          	addi	a0,a0,1150 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc02073f2:	e3df80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02073f6 <del_timer>:
ffffffffc02073f6:	1101                	addi	sp,sp,-32
ffffffffc02073f8:	e822                	sd	s0,16(sp)
ffffffffc02073fa:	ec06                	sd	ra,24(sp)
ffffffffc02073fc:	e426                	sd	s1,8(sp)
ffffffffc02073fe:	842a                	mv	s0,a0
ffffffffc0207400:	100027f3          	csrr	a5,sstatus
ffffffffc0207404:	8b89                	andi	a5,a5,2
ffffffffc0207406:	01050493          	addi	s1,a0,16
ffffffffc020740a:	eb9d                	bnez	a5,ffffffffc0207440 <del_timer+0x4a>
ffffffffc020740c:	6d1c                	ld	a5,24(a0)
ffffffffc020740e:	02978463          	beq	a5,s1,ffffffffc0207436 <del_timer+0x40>
ffffffffc0207412:	4114                	lw	a3,0(a0)
ffffffffc0207414:	6918                	ld	a4,16(a0)
ffffffffc0207416:	ce81                	beqz	a3,ffffffffc020742e <del_timer+0x38>
ffffffffc0207418:	0008e617          	auipc	a2,0x8e
ffffffffc020741c:	3d860613          	addi	a2,a2,984 # ffffffffc02957f0 <timer_list>
ffffffffc0207420:	00c78763          	beq	a5,a2,ffffffffc020742e <del_timer+0x38>
ffffffffc0207424:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207428:	9eb1                	addw	a3,a3,a2
ffffffffc020742a:	fed7a823          	sw	a3,-16(a5)
ffffffffc020742e:	e71c                	sd	a5,8(a4)
ffffffffc0207430:	e398                	sd	a4,0(a5)
ffffffffc0207432:	ec04                	sd	s1,24(s0)
ffffffffc0207434:	e804                	sd	s1,16(s0)
ffffffffc0207436:	60e2                	ld	ra,24(sp)
ffffffffc0207438:	6442                	ld	s0,16(sp)
ffffffffc020743a:	64a2                	ld	s1,8(sp)
ffffffffc020743c:	6105                	addi	sp,sp,32
ffffffffc020743e:	8082                	ret
ffffffffc0207440:	965f90ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0207444:	6c1c                	ld	a5,24(s0)
ffffffffc0207446:	02978463          	beq	a5,s1,ffffffffc020746e <del_timer+0x78>
ffffffffc020744a:	4014                	lw	a3,0(s0)
ffffffffc020744c:	6818                	ld	a4,16(s0)
ffffffffc020744e:	ce81                	beqz	a3,ffffffffc0207466 <del_timer+0x70>
ffffffffc0207450:	0008e617          	auipc	a2,0x8e
ffffffffc0207454:	3a060613          	addi	a2,a2,928 # ffffffffc02957f0 <timer_list>
ffffffffc0207458:	00c78763          	beq	a5,a2,ffffffffc0207466 <del_timer+0x70>
ffffffffc020745c:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207460:	9eb1                	addw	a3,a3,a2
ffffffffc0207462:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207466:	e71c                	sd	a5,8(a4)
ffffffffc0207468:	e398                	sd	a4,0(a5)
ffffffffc020746a:	ec04                	sd	s1,24(s0)
ffffffffc020746c:	e804                	sd	s1,16(s0)
ffffffffc020746e:	6442                	ld	s0,16(sp)
ffffffffc0207470:	60e2                	ld	ra,24(sp)
ffffffffc0207472:	64a2                	ld	s1,8(sp)
ffffffffc0207474:	6105                	addi	sp,sp,32
ffffffffc0207476:	929f906f          	j	ffffffffc0200d9e <intr_enable>

ffffffffc020747a <run_timer_list>:
ffffffffc020747a:	7139                	addi	sp,sp,-64
ffffffffc020747c:	fc06                	sd	ra,56(sp)
ffffffffc020747e:	f822                	sd	s0,48(sp)
ffffffffc0207480:	f426                	sd	s1,40(sp)
ffffffffc0207482:	f04a                	sd	s2,32(sp)
ffffffffc0207484:	ec4e                	sd	s3,24(sp)
ffffffffc0207486:	e852                	sd	s4,16(sp)
ffffffffc0207488:	e456                	sd	s5,8(sp)
ffffffffc020748a:	e05a                	sd	s6,0(sp)
ffffffffc020748c:	100027f3          	csrr	a5,sstatus
ffffffffc0207490:	8b89                	andi	a5,a5,2
ffffffffc0207492:	4b01                	li	s6,0
ffffffffc0207494:	efe9                	bnez	a5,ffffffffc020756e <run_timer_list+0xf4>
ffffffffc0207496:	0008e997          	auipc	s3,0x8e
ffffffffc020749a:	35a98993          	addi	s3,s3,858 # ffffffffc02957f0 <timer_list>
ffffffffc020749e:	0089b403          	ld	s0,8(s3)
ffffffffc02074a2:	07340a63          	beq	s0,s3,ffffffffc0207516 <run_timer_list+0x9c>
ffffffffc02074a6:	ff042783          	lw	a5,-16(s0)
ffffffffc02074aa:	ff040913          	addi	s2,s0,-16
ffffffffc02074ae:	0e078763          	beqz	a5,ffffffffc020759c <run_timer_list+0x122>
ffffffffc02074b2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02074b6:	fee42823          	sw	a4,-16(s0)
ffffffffc02074ba:	ef31                	bnez	a4,ffffffffc0207516 <run_timer_list+0x9c>
ffffffffc02074bc:	00006a97          	auipc	s5,0x6
ffffffffc02074c0:	47ca8a93          	addi	s5,s5,1148 # ffffffffc020d938 <CSWTCH.79+0x598>
ffffffffc02074c4:	00006a17          	auipc	s4,0x6
ffffffffc02074c8:	3a4a0a13          	addi	s4,s4,932 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc02074cc:	a005                	j	ffffffffc02074ec <run_timer_list+0x72>
ffffffffc02074ce:	0a07d763          	bgez	a5,ffffffffc020757c <run_timer_list+0x102>
ffffffffc02074d2:	8526                	mv	a0,s1
ffffffffc02074d4:	ce9ff0ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc02074d8:	854a                	mv	a0,s2
ffffffffc02074da:	f1dff0ef          	jal	ra,ffffffffc02073f6 <del_timer>
ffffffffc02074de:	03340c63          	beq	s0,s3,ffffffffc0207516 <run_timer_list+0x9c>
ffffffffc02074e2:	ff042783          	lw	a5,-16(s0)
ffffffffc02074e6:	ff040913          	addi	s2,s0,-16
ffffffffc02074ea:	e795                	bnez	a5,ffffffffc0207516 <run_timer_list+0x9c>
ffffffffc02074ec:	00893483          	ld	s1,8(s2)
ffffffffc02074f0:	6400                	ld	s0,8(s0)
ffffffffc02074f2:	0ec4a783          	lw	a5,236(s1)
ffffffffc02074f6:	ffe1                	bnez	a5,ffffffffc02074ce <run_timer_list+0x54>
ffffffffc02074f8:	40d4                	lw	a3,4(s1)
ffffffffc02074fa:	8656                	mv	a2,s5
ffffffffc02074fc:	0ba00593          	li	a1,186
ffffffffc0207500:	8552                	mv	a0,s4
ffffffffc0207502:	d95f80ef          	jal	ra,ffffffffc0200296 <__warn>
ffffffffc0207506:	8526                	mv	a0,s1
ffffffffc0207508:	cb5ff0ef          	jal	ra,ffffffffc02071bc <wakeup_proc>
ffffffffc020750c:	854a                	mv	a0,s2
ffffffffc020750e:	ee9ff0ef          	jal	ra,ffffffffc02073f6 <del_timer>
ffffffffc0207512:	fd3418e3          	bne	s0,s3,ffffffffc02074e2 <run_timer_list+0x68>
ffffffffc0207516:	0008f597          	auipc	a1,0x8f
ffffffffc020751a:	3aa5b583          	ld	a1,938(a1) # ffffffffc02968c0 <current>
ffffffffc020751e:	c18d                	beqz	a1,ffffffffc0207540 <run_timer_list+0xc6>
ffffffffc0207520:	0008f797          	auipc	a5,0x8f
ffffffffc0207524:	3a87b783          	ld	a5,936(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207528:	04f58763          	beq	a1,a5,ffffffffc0207576 <run_timer_list+0xfc>
ffffffffc020752c:	0008f797          	auipc	a5,0x8f
ffffffffc0207530:	3bc7b783          	ld	a5,956(a5) # ffffffffc02968e8 <sched_class>
ffffffffc0207534:	779c                	ld	a5,40(a5)
ffffffffc0207536:	0008f517          	auipc	a0,0x8f
ffffffffc020753a:	3aa53503          	ld	a0,938(a0) # ffffffffc02968e0 <rq>
ffffffffc020753e:	9782                	jalr	a5
ffffffffc0207540:	000b1c63          	bnez	s6,ffffffffc0207558 <run_timer_list+0xde>
ffffffffc0207544:	70e2                	ld	ra,56(sp)
ffffffffc0207546:	7442                	ld	s0,48(sp)
ffffffffc0207548:	74a2                	ld	s1,40(sp)
ffffffffc020754a:	7902                	ld	s2,32(sp)
ffffffffc020754c:	69e2                	ld	s3,24(sp)
ffffffffc020754e:	6a42                	ld	s4,16(sp)
ffffffffc0207550:	6aa2                	ld	s5,8(sp)
ffffffffc0207552:	6b02                	ld	s6,0(sp)
ffffffffc0207554:	6121                	addi	sp,sp,64
ffffffffc0207556:	8082                	ret
ffffffffc0207558:	7442                	ld	s0,48(sp)
ffffffffc020755a:	70e2                	ld	ra,56(sp)
ffffffffc020755c:	74a2                	ld	s1,40(sp)
ffffffffc020755e:	7902                	ld	s2,32(sp)
ffffffffc0207560:	69e2                	ld	s3,24(sp)
ffffffffc0207562:	6a42                	ld	s4,16(sp)
ffffffffc0207564:	6aa2                	ld	s5,8(sp)
ffffffffc0207566:	6b02                	ld	s6,0(sp)
ffffffffc0207568:	6121                	addi	sp,sp,64
ffffffffc020756a:	835f906f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc020756e:	837f90ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0207572:	4b05                	li	s6,1
ffffffffc0207574:	b70d                	j	ffffffffc0207496 <run_timer_list+0x1c>
ffffffffc0207576:	4785                	li	a5,1
ffffffffc0207578:	ed9c                	sd	a5,24(a1)
ffffffffc020757a:	b7d9                	j	ffffffffc0207540 <run_timer_list+0xc6>
ffffffffc020757c:	00006697          	auipc	a3,0x6
ffffffffc0207580:	39468693          	addi	a3,a3,916 # ffffffffc020d910 <CSWTCH.79+0x570>
ffffffffc0207584:	00004617          	auipc	a2,0x4
ffffffffc0207588:	27460613          	addi	a2,a2,628 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020758c:	0b600593          	li	a1,182
ffffffffc0207590:	00006517          	auipc	a0,0x6
ffffffffc0207594:	2d850513          	addi	a0,a0,728 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc0207598:	c97f80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020759c:	00006697          	auipc	a3,0x6
ffffffffc02075a0:	35c68693          	addi	a3,a3,860 # ffffffffc020d8f8 <CSWTCH.79+0x558>
ffffffffc02075a4:	00004617          	auipc	a2,0x4
ffffffffc02075a8:	25460613          	addi	a2,a2,596 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02075ac:	0ae00593          	li	a1,174
ffffffffc02075b0:	00006517          	auipc	a0,0x6
ffffffffc02075b4:	2b850513          	addi	a0,a0,696 # ffffffffc020d868 <CSWTCH.79+0x4c8>
ffffffffc02075b8:	c77f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02075bc <RR_init>:
ffffffffc02075bc:	e508                	sd	a0,8(a0)
ffffffffc02075be:	e108                	sd	a0,0(a0)
ffffffffc02075c0:	00052823          	sw	zero,16(a0)
ffffffffc02075c4:	8082                	ret

ffffffffc02075c6 <RR_pick_next>:
ffffffffc02075c6:	651c                	ld	a5,8(a0)
ffffffffc02075c8:	00f50563          	beq	a0,a5,ffffffffc02075d2 <RR_pick_next+0xc>
ffffffffc02075cc:	ef078513          	addi	a0,a5,-272
ffffffffc02075d0:	8082                	ret
ffffffffc02075d2:	4501                	li	a0,0
ffffffffc02075d4:	8082                	ret

ffffffffc02075d6 <RR_proc_tick>:
ffffffffc02075d6:	1205a783          	lw	a5,288(a1)
ffffffffc02075da:	00f05563          	blez	a5,ffffffffc02075e4 <RR_proc_tick+0xe>
ffffffffc02075de:	37fd                	addiw	a5,a5,-1
ffffffffc02075e0:	12f5a023          	sw	a5,288(a1)
ffffffffc02075e4:	e399                	bnez	a5,ffffffffc02075ea <RR_proc_tick+0x14>
ffffffffc02075e6:	4785                	li	a5,1
ffffffffc02075e8:	ed9c                	sd	a5,24(a1)
ffffffffc02075ea:	8082                	ret

ffffffffc02075ec <RR_dequeue>:
ffffffffc02075ec:	1185b703          	ld	a4,280(a1)
ffffffffc02075f0:	11058793          	addi	a5,a1,272
ffffffffc02075f4:	02e78363          	beq	a5,a4,ffffffffc020761a <RR_dequeue+0x2e>
ffffffffc02075f8:	1085b683          	ld	a3,264(a1)
ffffffffc02075fc:	00a69f63          	bne	a3,a0,ffffffffc020761a <RR_dequeue+0x2e>
ffffffffc0207600:	1105b503          	ld	a0,272(a1)
ffffffffc0207604:	4a90                	lw	a2,16(a3)
ffffffffc0207606:	e518                	sd	a4,8(a0)
ffffffffc0207608:	e308                	sd	a0,0(a4)
ffffffffc020760a:	10f5bc23          	sd	a5,280(a1)
ffffffffc020760e:	10f5b823          	sd	a5,272(a1)
ffffffffc0207612:	fff6079b          	addiw	a5,a2,-1
ffffffffc0207616:	ca9c                	sw	a5,16(a3)
ffffffffc0207618:	8082                	ret
ffffffffc020761a:	1141                	addi	sp,sp,-16
ffffffffc020761c:	00006697          	auipc	a3,0x6
ffffffffc0207620:	33c68693          	addi	a3,a3,828 # ffffffffc020d958 <CSWTCH.79+0x5b8>
ffffffffc0207624:	00004617          	auipc	a2,0x4
ffffffffc0207628:	1d460613          	addi	a2,a2,468 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020762c:	03c00593          	li	a1,60
ffffffffc0207630:	00006517          	auipc	a0,0x6
ffffffffc0207634:	36050513          	addi	a0,a0,864 # ffffffffc020d990 <CSWTCH.79+0x5f0>
ffffffffc0207638:	e406                	sd	ra,8(sp)
ffffffffc020763a:	bf5f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020763e <RR_enqueue>:
ffffffffc020763e:	1185b703          	ld	a4,280(a1)
ffffffffc0207642:	11058793          	addi	a5,a1,272
ffffffffc0207646:	02e79d63          	bne	a5,a4,ffffffffc0207680 <RR_enqueue+0x42>
ffffffffc020764a:	6118                	ld	a4,0(a0)
ffffffffc020764c:	1205a683          	lw	a3,288(a1)
ffffffffc0207650:	e11c                	sd	a5,0(a0)
ffffffffc0207652:	e71c                	sd	a5,8(a4)
ffffffffc0207654:	10a5bc23          	sd	a0,280(a1)
ffffffffc0207658:	10e5b823          	sd	a4,272(a1)
ffffffffc020765c:	495c                	lw	a5,20(a0)
ffffffffc020765e:	ea89                	bnez	a3,ffffffffc0207670 <RR_enqueue+0x32>
ffffffffc0207660:	12f5a023          	sw	a5,288(a1)
ffffffffc0207664:	491c                	lw	a5,16(a0)
ffffffffc0207666:	10a5b423          	sd	a0,264(a1)
ffffffffc020766a:	2785                	addiw	a5,a5,1
ffffffffc020766c:	c91c                	sw	a5,16(a0)
ffffffffc020766e:	8082                	ret
ffffffffc0207670:	fed7c8e3          	blt	a5,a3,ffffffffc0207660 <RR_enqueue+0x22>
ffffffffc0207674:	491c                	lw	a5,16(a0)
ffffffffc0207676:	10a5b423          	sd	a0,264(a1)
ffffffffc020767a:	2785                	addiw	a5,a5,1
ffffffffc020767c:	c91c                	sw	a5,16(a0)
ffffffffc020767e:	8082                	ret
ffffffffc0207680:	1141                	addi	sp,sp,-16
ffffffffc0207682:	00006697          	auipc	a3,0x6
ffffffffc0207686:	32e68693          	addi	a3,a3,814 # ffffffffc020d9b0 <CSWTCH.79+0x610>
ffffffffc020768a:	00004617          	auipc	a2,0x4
ffffffffc020768e:	16e60613          	addi	a2,a2,366 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207692:	02800593          	li	a1,40
ffffffffc0207696:	00006517          	auipc	a0,0x6
ffffffffc020769a:	2fa50513          	addi	a0,a0,762 # ffffffffc020d990 <CSWTCH.79+0x5f0>
ffffffffc020769e:	e406                	sd	ra,8(sp)
ffffffffc02076a0:	b8ff80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02076a4 <sys_getpid>:
ffffffffc02076a4:	0008f797          	auipc	a5,0x8f
ffffffffc02076a8:	21c7b783          	ld	a5,540(a5) # ffffffffc02968c0 <current>
ffffffffc02076ac:	43c8                	lw	a0,4(a5)
ffffffffc02076ae:	8082                	ret

ffffffffc02076b0 <sys_pgdir>:
ffffffffc02076b0:	4501                	li	a0,0
ffffffffc02076b2:	8082                	ret

ffffffffc02076b4 <sys_gettime>:
ffffffffc02076b4:	0008f797          	auipc	a5,0x8f
ffffffffc02076b8:	1bc7b783          	ld	a5,444(a5) # ffffffffc0296870 <ticks>
ffffffffc02076bc:	0027951b          	slliw	a0,a5,0x2
ffffffffc02076c0:	9d3d                	addw	a0,a0,a5
ffffffffc02076c2:	0015151b          	slliw	a0,a0,0x1
ffffffffc02076c6:	8082                	ret

ffffffffc02076c8 <sys_lab6_set_priority>:
ffffffffc02076c8:	4108                	lw	a0,0(a0)
ffffffffc02076ca:	1141                	addi	sp,sp,-16
ffffffffc02076cc:	e406                	sd	ra,8(sp)
ffffffffc02076ce:	9dfff0ef          	jal	ra,ffffffffc02070ac <lab6_set_priority>
ffffffffc02076d2:	60a2                	ld	ra,8(sp)
ffffffffc02076d4:	4501                	li	a0,0
ffffffffc02076d6:	0141                	addi	sp,sp,16
ffffffffc02076d8:	8082                	ret

ffffffffc02076da <sys_dup>:
ffffffffc02076da:	450c                	lw	a1,8(a0)
ffffffffc02076dc:	4108                	lw	a0,0(a0)
ffffffffc02076de:	deefd06f          	j	ffffffffc0204ccc <sysfile_dup>

ffffffffc02076e2 <sys_getdirentry>:
ffffffffc02076e2:	650c                	ld	a1,8(a0)
ffffffffc02076e4:	4108                	lw	a0,0(a0)
ffffffffc02076e6:	cf6fd06f          	j	ffffffffc0204bdc <sysfile_getdirentry>

ffffffffc02076ea <sys_getcwd>:
ffffffffc02076ea:	650c                	ld	a1,8(a0)
ffffffffc02076ec:	6108                	ld	a0,0(a0)
ffffffffc02076ee:	c4afd06f          	j	ffffffffc0204b38 <sysfile_getcwd>

ffffffffc02076f2 <sys_fsync>:
ffffffffc02076f2:	4108                	lw	a0,0(a0)
ffffffffc02076f4:	c40fd06f          	j	ffffffffc0204b34 <sysfile_fsync>

ffffffffc02076f8 <sys_fstat>:
ffffffffc02076f8:	650c                	ld	a1,8(a0)
ffffffffc02076fa:	4108                	lw	a0,0(a0)
ffffffffc02076fc:	b98fd06f          	j	ffffffffc0204a94 <sysfile_fstat>

ffffffffc0207700 <sys_seek>:
ffffffffc0207700:	4910                	lw	a2,16(a0)
ffffffffc0207702:	650c                	ld	a1,8(a0)
ffffffffc0207704:	4108                	lw	a0,0(a0)
ffffffffc0207706:	b8afd06f          	j	ffffffffc0204a90 <sysfile_seek>

ffffffffc020770a <sys_write>:
ffffffffc020770a:	6910                	ld	a2,16(a0)
ffffffffc020770c:	650c                	ld	a1,8(a0)
ffffffffc020770e:	4108                	lw	a0,0(a0)
ffffffffc0207710:	a66fd06f          	j	ffffffffc0204976 <sysfile_write>

ffffffffc0207714 <sys_read>:
ffffffffc0207714:	6910                	ld	a2,16(a0)
ffffffffc0207716:	650c                	ld	a1,8(a0)
ffffffffc0207718:	4108                	lw	a0,0(a0)
ffffffffc020771a:	948fd06f          	j	ffffffffc0204862 <sysfile_read>

ffffffffc020771e <sys_close>:
ffffffffc020771e:	4108                	lw	a0,0(a0)
ffffffffc0207720:	93efd06f          	j	ffffffffc020485e <sysfile_close>

ffffffffc0207724 <sys_open>:
ffffffffc0207724:	450c                	lw	a1,8(a0)
ffffffffc0207726:	6108                	ld	a0,0(a0)
ffffffffc0207728:	902fd06f          	j	ffffffffc020482a <sysfile_open>

ffffffffc020772c <sys_putc>:
ffffffffc020772c:	4108                	lw	a0,0(a0)
ffffffffc020772e:	1141                	addi	sp,sp,-16
ffffffffc0207730:	e406                	sd	ra,8(sp)
ffffffffc0207732:	a35f80ef          	jal	ra,ffffffffc0200166 <cputchar>
ffffffffc0207736:	60a2                	ld	ra,8(sp)
ffffffffc0207738:	4501                	li	a0,0
ffffffffc020773a:	0141                	addi	sp,sp,16
ffffffffc020773c:	8082                	ret

ffffffffc020773e <sys_kill>:
ffffffffc020773e:	4108                	lw	a0,0(a0)
ffffffffc0207740:	f0aff06f          	j	ffffffffc0206e4a <do_kill>

ffffffffc0207744 <sys_sleep>:
ffffffffc0207744:	4108                	lw	a0,0(a0)
ffffffffc0207746:	9a1ff06f          	j	ffffffffc02070e6 <do_sleep>

ffffffffc020774a <sys_yield>:
ffffffffc020774a:	eb2ff06f          	j	ffffffffc0206dfc <do_yield>

ffffffffc020774e <sys_exec>:
ffffffffc020774e:	6910                	ld	a2,16(a0)
ffffffffc0207750:	450c                	lw	a1,8(a0)
ffffffffc0207752:	6108                	ld	a0,0(a0)
ffffffffc0207754:	dbbfe06f          	j	ffffffffc020650e <do_execve>

ffffffffc0207758 <sys_wait>:
ffffffffc0207758:	650c                	ld	a1,8(a0)
ffffffffc020775a:	4108                	lw	a0,0(a0)
ffffffffc020775c:	eb0ff06f          	j	ffffffffc0206e0c <do_wait>

ffffffffc0207760 <sys_fork>:
ffffffffc0207760:	0008f797          	auipc	a5,0x8f
ffffffffc0207764:	1607b783          	ld	a5,352(a5) # ffffffffc02968c0 <current>
ffffffffc0207768:	73d0                	ld	a2,160(a5)
ffffffffc020776a:	4501                	li	a0,0
ffffffffc020776c:	6a0c                	ld	a1,16(a2)
ffffffffc020776e:	c64fe06f          	j	ffffffffc0205bd2 <do_fork>

ffffffffc0207772 <sys_exit>:
ffffffffc0207772:	4108                	lw	a0,0(a0)
ffffffffc0207774:	917fe06f          	j	ffffffffc020608a <do_exit>

ffffffffc0207778 <syscall>:
ffffffffc0207778:	715d                	addi	sp,sp,-80
ffffffffc020777a:	fc26                	sd	s1,56(sp)
ffffffffc020777c:	0008f497          	auipc	s1,0x8f
ffffffffc0207780:	14448493          	addi	s1,s1,324 # ffffffffc02968c0 <current>
ffffffffc0207784:	6098                	ld	a4,0(s1)
ffffffffc0207786:	e0a2                	sd	s0,64(sp)
ffffffffc0207788:	f84a                	sd	s2,48(sp)
ffffffffc020778a:	7340                	ld	s0,160(a4)
ffffffffc020778c:	e486                	sd	ra,72(sp)
ffffffffc020778e:	0ff00793          	li	a5,255
ffffffffc0207792:	05042903          	lw	s2,80(s0)
ffffffffc0207796:	0327ee63          	bltu	a5,s2,ffffffffc02077d2 <syscall+0x5a>
ffffffffc020779a:	00391713          	slli	a4,s2,0x3
ffffffffc020779e:	00006797          	auipc	a5,0x6
ffffffffc02077a2:	28a78793          	addi	a5,a5,650 # ffffffffc020da28 <syscalls>
ffffffffc02077a6:	97ba                	add	a5,a5,a4
ffffffffc02077a8:	639c                	ld	a5,0(a5)
ffffffffc02077aa:	c785                	beqz	a5,ffffffffc02077d2 <syscall+0x5a>
ffffffffc02077ac:	6c28                	ld	a0,88(s0)
ffffffffc02077ae:	702c                	ld	a1,96(s0)
ffffffffc02077b0:	7430                	ld	a2,104(s0)
ffffffffc02077b2:	7834                	ld	a3,112(s0)
ffffffffc02077b4:	7c38                	ld	a4,120(s0)
ffffffffc02077b6:	e42a                	sd	a0,8(sp)
ffffffffc02077b8:	e82e                	sd	a1,16(sp)
ffffffffc02077ba:	ec32                	sd	a2,24(sp)
ffffffffc02077bc:	f036                	sd	a3,32(sp)
ffffffffc02077be:	f43a                	sd	a4,40(sp)
ffffffffc02077c0:	0028                	addi	a0,sp,8
ffffffffc02077c2:	9782                	jalr	a5
ffffffffc02077c4:	60a6                	ld	ra,72(sp)
ffffffffc02077c6:	e828                	sd	a0,80(s0)
ffffffffc02077c8:	6406                	ld	s0,64(sp)
ffffffffc02077ca:	74e2                	ld	s1,56(sp)
ffffffffc02077cc:	7942                	ld	s2,48(sp)
ffffffffc02077ce:	6161                	addi	sp,sp,80
ffffffffc02077d0:	8082                	ret
ffffffffc02077d2:	8522                	mv	a0,s0
ffffffffc02077d4:	fbef90ef          	jal	ra,ffffffffc0200f92 <print_trapframe>
ffffffffc02077d8:	609c                	ld	a5,0(s1)
ffffffffc02077da:	86ca                	mv	a3,s2
ffffffffc02077dc:	00006617          	auipc	a2,0x6
ffffffffc02077e0:	20460613          	addi	a2,a2,516 # ffffffffc020d9e0 <CSWTCH.79+0x640>
ffffffffc02077e4:	43d8                	lw	a4,4(a5)
ffffffffc02077e6:	0d800593          	li	a1,216
ffffffffc02077ea:	0b478793          	addi	a5,a5,180
ffffffffc02077ee:	00006517          	auipc	a0,0x6
ffffffffc02077f2:	22250513          	addi	a0,a0,546 # ffffffffc020da10 <CSWTCH.79+0x670>
ffffffffc02077f6:	a39f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02077fa <vfs_do_add>:
ffffffffc02077fa:	7139                	addi	sp,sp,-64
ffffffffc02077fc:	fc06                	sd	ra,56(sp)
ffffffffc02077fe:	f822                	sd	s0,48(sp)
ffffffffc0207800:	f426                	sd	s1,40(sp)
ffffffffc0207802:	f04a                	sd	s2,32(sp)
ffffffffc0207804:	ec4e                	sd	s3,24(sp)
ffffffffc0207806:	e852                	sd	s4,16(sp)
ffffffffc0207808:	e456                	sd	s5,8(sp)
ffffffffc020780a:	e05a                	sd	s6,0(sp)
ffffffffc020780c:	0e050b63          	beqz	a0,ffffffffc0207902 <vfs_do_add+0x108>
ffffffffc0207810:	842a                	mv	s0,a0
ffffffffc0207812:	8a2e                	mv	s4,a1
ffffffffc0207814:	8b32                	mv	s6,a2
ffffffffc0207816:	8ab6                	mv	s5,a3
ffffffffc0207818:	c5cd                	beqz	a1,ffffffffc02078c2 <vfs_do_add+0xc8>
ffffffffc020781a:	4db8                	lw	a4,88(a1)
ffffffffc020781c:	6785                	lui	a5,0x1
ffffffffc020781e:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207822:	0af71163          	bne	a4,a5,ffffffffc02078c4 <vfs_do_add+0xca>
ffffffffc0207826:	8522                	mv	a0,s0
ffffffffc0207828:	72a030ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc020782c:	47fd                	li	a5,31
ffffffffc020782e:	0ca7e663          	bltu	a5,a0,ffffffffc02078fa <vfs_do_add+0x100>
ffffffffc0207832:	8522                	mv	a0,s0
ffffffffc0207834:	87ff80ef          	jal	ra,ffffffffc02000b2 <strdup>
ffffffffc0207838:	84aa                	mv	s1,a0
ffffffffc020783a:	c171                	beqz	a0,ffffffffc02078fe <vfs_do_add+0x104>
ffffffffc020783c:	03000513          	li	a0,48
ffffffffc0207840:	cd6fa0ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0207844:	89aa                	mv	s3,a0
ffffffffc0207846:	c92d                	beqz	a0,ffffffffc02078b8 <vfs_do_add+0xbe>
ffffffffc0207848:	0008e517          	auipc	a0,0x8e
ffffffffc020784c:	fc850513          	addi	a0,a0,-56 # ffffffffc0295810 <vdev_list_sem>
ffffffffc0207850:	0008e917          	auipc	s2,0x8e
ffffffffc0207854:	fb090913          	addi	s2,s2,-80 # ffffffffc0295800 <vdev_list>
ffffffffc0207858:	ef3fc0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020785c:	844a                	mv	s0,s2
ffffffffc020785e:	a039                	j	ffffffffc020786c <vfs_do_add+0x72>
ffffffffc0207860:	fe043503          	ld	a0,-32(s0)
ffffffffc0207864:	85a6                	mv	a1,s1
ffffffffc0207866:	734030ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc020786a:	cd2d                	beqz	a0,ffffffffc02078e4 <vfs_do_add+0xea>
ffffffffc020786c:	6400                	ld	s0,8(s0)
ffffffffc020786e:	ff2419e3          	bne	s0,s2,ffffffffc0207860 <vfs_do_add+0x66>
ffffffffc0207872:	6418                	ld	a4,8(s0)
ffffffffc0207874:	02098793          	addi	a5,s3,32
ffffffffc0207878:	0099b023          	sd	s1,0(s3)
ffffffffc020787c:	0149b423          	sd	s4,8(s3)
ffffffffc0207880:	0159bc23          	sd	s5,24(s3)
ffffffffc0207884:	0169b823          	sd	s6,16(s3)
ffffffffc0207888:	e31c                	sd	a5,0(a4)
ffffffffc020788a:	0289b023          	sd	s0,32(s3)
ffffffffc020788e:	02e9b423          	sd	a4,40(s3)
ffffffffc0207892:	0008e517          	auipc	a0,0x8e
ffffffffc0207896:	f7e50513          	addi	a0,a0,-130 # ffffffffc0295810 <vdev_list_sem>
ffffffffc020789a:	e41c                	sd	a5,8(s0)
ffffffffc020789c:	4401                	li	s0,0
ffffffffc020789e:	ea9fc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc02078a2:	70e2                	ld	ra,56(sp)
ffffffffc02078a4:	8522                	mv	a0,s0
ffffffffc02078a6:	7442                	ld	s0,48(sp)
ffffffffc02078a8:	74a2                	ld	s1,40(sp)
ffffffffc02078aa:	7902                	ld	s2,32(sp)
ffffffffc02078ac:	69e2                	ld	s3,24(sp)
ffffffffc02078ae:	6a42                	ld	s4,16(sp)
ffffffffc02078b0:	6aa2                	ld	s5,8(sp)
ffffffffc02078b2:	6b02                	ld	s6,0(sp)
ffffffffc02078b4:	6121                	addi	sp,sp,64
ffffffffc02078b6:	8082                	ret
ffffffffc02078b8:	5471                	li	s0,-4
ffffffffc02078ba:	8526                	mv	a0,s1
ffffffffc02078bc:	d0afa0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc02078c0:	b7cd                	j	ffffffffc02078a2 <vfs_do_add+0xa8>
ffffffffc02078c2:	d2b5                	beqz	a3,ffffffffc0207826 <vfs_do_add+0x2c>
ffffffffc02078c4:	00007697          	auipc	a3,0x7
ffffffffc02078c8:	98c68693          	addi	a3,a3,-1652 # ffffffffc020e250 <syscalls+0x828>
ffffffffc02078cc:	00004617          	auipc	a2,0x4
ffffffffc02078d0:	f2c60613          	addi	a2,a2,-212 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02078d4:	08f00593          	li	a1,143
ffffffffc02078d8:	00007517          	auipc	a0,0x7
ffffffffc02078dc:	96050513          	addi	a0,a0,-1696 # ffffffffc020e238 <syscalls+0x810>
ffffffffc02078e0:	94ff80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02078e4:	0008e517          	auipc	a0,0x8e
ffffffffc02078e8:	f2c50513          	addi	a0,a0,-212 # ffffffffc0295810 <vdev_list_sem>
ffffffffc02078ec:	e5bfc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc02078f0:	854e                	mv	a0,s3
ffffffffc02078f2:	cd4fa0ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc02078f6:	5425                	li	s0,-23
ffffffffc02078f8:	b7c9                	j	ffffffffc02078ba <vfs_do_add+0xc0>
ffffffffc02078fa:	5451                	li	s0,-12
ffffffffc02078fc:	b75d                	j	ffffffffc02078a2 <vfs_do_add+0xa8>
ffffffffc02078fe:	5471                	li	s0,-4
ffffffffc0207900:	b74d                	j	ffffffffc02078a2 <vfs_do_add+0xa8>
ffffffffc0207902:	00007697          	auipc	a3,0x7
ffffffffc0207906:	92668693          	addi	a3,a3,-1754 # ffffffffc020e228 <syscalls+0x800>
ffffffffc020790a:	00004617          	auipc	a2,0x4
ffffffffc020790e:	eee60613          	addi	a2,a2,-274 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207912:	08e00593          	li	a1,142
ffffffffc0207916:	00007517          	auipc	a0,0x7
ffffffffc020791a:	92250513          	addi	a0,a0,-1758 # ffffffffc020e238 <syscalls+0x810>
ffffffffc020791e:	911f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207922 <find_mount.part.0>:
ffffffffc0207922:	1141                	addi	sp,sp,-16
ffffffffc0207924:	00007697          	auipc	a3,0x7
ffffffffc0207928:	90468693          	addi	a3,a3,-1788 # ffffffffc020e228 <syscalls+0x800>
ffffffffc020792c:	00004617          	auipc	a2,0x4
ffffffffc0207930:	ecc60613          	addi	a2,a2,-308 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207934:	0cd00593          	li	a1,205
ffffffffc0207938:	00007517          	auipc	a0,0x7
ffffffffc020793c:	90050513          	addi	a0,a0,-1792 # ffffffffc020e238 <syscalls+0x810>
ffffffffc0207940:	e406                	sd	ra,8(sp)
ffffffffc0207942:	8edf80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207946 <vfs_devlist_init>:
ffffffffc0207946:	0008e797          	auipc	a5,0x8e
ffffffffc020794a:	eba78793          	addi	a5,a5,-326 # ffffffffc0295800 <vdev_list>
ffffffffc020794e:	4585                	li	a1,1
ffffffffc0207950:	0008e517          	auipc	a0,0x8e
ffffffffc0207954:	ec050513          	addi	a0,a0,-320 # ffffffffc0295810 <vdev_list_sem>
ffffffffc0207958:	e79c                	sd	a5,8(a5)
ffffffffc020795a:	e39c                	sd	a5,0(a5)
ffffffffc020795c:	de3fc06f          	j	ffffffffc020473e <sem_init>

ffffffffc0207960 <vfs_cleanup>:
ffffffffc0207960:	1101                	addi	sp,sp,-32
ffffffffc0207962:	e426                	sd	s1,8(sp)
ffffffffc0207964:	0008e497          	auipc	s1,0x8e
ffffffffc0207968:	e9c48493          	addi	s1,s1,-356 # ffffffffc0295800 <vdev_list>
ffffffffc020796c:	649c                	ld	a5,8(s1)
ffffffffc020796e:	ec06                	sd	ra,24(sp)
ffffffffc0207970:	e822                	sd	s0,16(sp)
ffffffffc0207972:	02978e63          	beq	a5,s1,ffffffffc02079ae <vfs_cleanup+0x4e>
ffffffffc0207976:	0008e517          	auipc	a0,0x8e
ffffffffc020797a:	e9a50513          	addi	a0,a0,-358 # ffffffffc0295810 <vdev_list_sem>
ffffffffc020797e:	dcdfc0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0207982:	6480                	ld	s0,8(s1)
ffffffffc0207984:	00940b63          	beq	s0,s1,ffffffffc020799a <vfs_cleanup+0x3a>
ffffffffc0207988:	ff043783          	ld	a5,-16(s0)
ffffffffc020798c:	853e                	mv	a0,a5
ffffffffc020798e:	c399                	beqz	a5,ffffffffc0207994 <vfs_cleanup+0x34>
ffffffffc0207990:	6bfc                	ld	a5,208(a5)
ffffffffc0207992:	9782                	jalr	a5
ffffffffc0207994:	6400                	ld	s0,8(s0)
ffffffffc0207996:	fe9419e3          	bne	s0,s1,ffffffffc0207988 <vfs_cleanup+0x28>
ffffffffc020799a:	6442                	ld	s0,16(sp)
ffffffffc020799c:	60e2                	ld	ra,24(sp)
ffffffffc020799e:	64a2                	ld	s1,8(sp)
ffffffffc02079a0:	0008e517          	auipc	a0,0x8e
ffffffffc02079a4:	e7050513          	addi	a0,a0,-400 # ffffffffc0295810 <vdev_list_sem>
ffffffffc02079a8:	6105                	addi	sp,sp,32
ffffffffc02079aa:	d9dfc06f          	j	ffffffffc0204746 <up>
ffffffffc02079ae:	60e2                	ld	ra,24(sp)
ffffffffc02079b0:	6442                	ld	s0,16(sp)
ffffffffc02079b2:	64a2                	ld	s1,8(sp)
ffffffffc02079b4:	6105                	addi	sp,sp,32
ffffffffc02079b6:	8082                	ret

ffffffffc02079b8 <vfs_get_root>:
ffffffffc02079b8:	7179                	addi	sp,sp,-48
ffffffffc02079ba:	f406                	sd	ra,40(sp)
ffffffffc02079bc:	f022                	sd	s0,32(sp)
ffffffffc02079be:	ec26                	sd	s1,24(sp)
ffffffffc02079c0:	e84a                	sd	s2,16(sp)
ffffffffc02079c2:	e44e                	sd	s3,8(sp)
ffffffffc02079c4:	e052                	sd	s4,0(sp)
ffffffffc02079c6:	c541                	beqz	a0,ffffffffc0207a4e <vfs_get_root+0x96>
ffffffffc02079c8:	0008e917          	auipc	s2,0x8e
ffffffffc02079cc:	e3890913          	addi	s2,s2,-456 # ffffffffc0295800 <vdev_list>
ffffffffc02079d0:	00893783          	ld	a5,8(s2)
ffffffffc02079d4:	07278b63          	beq	a5,s2,ffffffffc0207a4a <vfs_get_root+0x92>
ffffffffc02079d8:	89aa                	mv	s3,a0
ffffffffc02079da:	0008e517          	auipc	a0,0x8e
ffffffffc02079de:	e3650513          	addi	a0,a0,-458 # ffffffffc0295810 <vdev_list_sem>
ffffffffc02079e2:	8a2e                	mv	s4,a1
ffffffffc02079e4:	844a                	mv	s0,s2
ffffffffc02079e6:	d65fc0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc02079ea:	a801                	j	ffffffffc02079fa <vfs_get_root+0x42>
ffffffffc02079ec:	fe043583          	ld	a1,-32(s0)
ffffffffc02079f0:	854e                	mv	a0,s3
ffffffffc02079f2:	5a8030ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc02079f6:	84aa                	mv	s1,a0
ffffffffc02079f8:	c505                	beqz	a0,ffffffffc0207a20 <vfs_get_root+0x68>
ffffffffc02079fa:	6400                	ld	s0,8(s0)
ffffffffc02079fc:	ff2418e3          	bne	s0,s2,ffffffffc02079ec <vfs_get_root+0x34>
ffffffffc0207a00:	54cd                	li	s1,-13
ffffffffc0207a02:	0008e517          	auipc	a0,0x8e
ffffffffc0207a06:	e0e50513          	addi	a0,a0,-498 # ffffffffc0295810 <vdev_list_sem>
ffffffffc0207a0a:	d3dfc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0207a0e:	70a2                	ld	ra,40(sp)
ffffffffc0207a10:	7402                	ld	s0,32(sp)
ffffffffc0207a12:	6942                	ld	s2,16(sp)
ffffffffc0207a14:	69a2                	ld	s3,8(sp)
ffffffffc0207a16:	6a02                	ld	s4,0(sp)
ffffffffc0207a18:	8526                	mv	a0,s1
ffffffffc0207a1a:	64e2                	ld	s1,24(sp)
ffffffffc0207a1c:	6145                	addi	sp,sp,48
ffffffffc0207a1e:	8082                	ret
ffffffffc0207a20:	ff043503          	ld	a0,-16(s0)
ffffffffc0207a24:	c519                	beqz	a0,ffffffffc0207a32 <vfs_get_root+0x7a>
ffffffffc0207a26:	617c                	ld	a5,192(a0)
ffffffffc0207a28:	9782                	jalr	a5
ffffffffc0207a2a:	c519                	beqz	a0,ffffffffc0207a38 <vfs_get_root+0x80>
ffffffffc0207a2c:	00aa3023          	sd	a0,0(s4)
ffffffffc0207a30:	bfc9                	j	ffffffffc0207a02 <vfs_get_root+0x4a>
ffffffffc0207a32:	ff843783          	ld	a5,-8(s0)
ffffffffc0207a36:	c399                	beqz	a5,ffffffffc0207a3c <vfs_get_root+0x84>
ffffffffc0207a38:	54c9                	li	s1,-14
ffffffffc0207a3a:	b7e1                	j	ffffffffc0207a02 <vfs_get_root+0x4a>
ffffffffc0207a3c:	fe843503          	ld	a0,-24(s0)
ffffffffc0207a40:	7b0000ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0207a44:	fe843503          	ld	a0,-24(s0)
ffffffffc0207a48:	b7cd                	j	ffffffffc0207a2a <vfs_get_root+0x72>
ffffffffc0207a4a:	54cd                	li	s1,-13
ffffffffc0207a4c:	b7c9                	j	ffffffffc0207a0e <vfs_get_root+0x56>
ffffffffc0207a4e:	00006697          	auipc	a3,0x6
ffffffffc0207a52:	7da68693          	addi	a3,a3,2010 # ffffffffc020e228 <syscalls+0x800>
ffffffffc0207a56:	00004617          	auipc	a2,0x4
ffffffffc0207a5a:	da260613          	addi	a2,a2,-606 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207a5e:	04500593          	li	a1,69
ffffffffc0207a62:	00006517          	auipc	a0,0x6
ffffffffc0207a66:	7d650513          	addi	a0,a0,2006 # ffffffffc020e238 <syscalls+0x810>
ffffffffc0207a6a:	fc4f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207a6e <vfs_get_devname>:
ffffffffc0207a6e:	0008e697          	auipc	a3,0x8e
ffffffffc0207a72:	d9268693          	addi	a3,a3,-622 # ffffffffc0295800 <vdev_list>
ffffffffc0207a76:	87b6                	mv	a5,a3
ffffffffc0207a78:	e511                	bnez	a0,ffffffffc0207a84 <vfs_get_devname+0x16>
ffffffffc0207a7a:	a829                	j	ffffffffc0207a94 <vfs_get_devname+0x26>
ffffffffc0207a7c:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207a80:	00a70763          	beq	a4,a0,ffffffffc0207a8e <vfs_get_devname+0x20>
ffffffffc0207a84:	679c                	ld	a5,8(a5)
ffffffffc0207a86:	fed79be3          	bne	a5,a3,ffffffffc0207a7c <vfs_get_devname+0xe>
ffffffffc0207a8a:	4501                	li	a0,0
ffffffffc0207a8c:	8082                	ret
ffffffffc0207a8e:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207a92:	8082                	ret
ffffffffc0207a94:	1141                	addi	sp,sp,-16
ffffffffc0207a96:	00007697          	auipc	a3,0x7
ffffffffc0207a9a:	81a68693          	addi	a3,a3,-2022 # ffffffffc020e2b0 <syscalls+0x888>
ffffffffc0207a9e:	00004617          	auipc	a2,0x4
ffffffffc0207aa2:	d5a60613          	addi	a2,a2,-678 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207aa6:	06a00593          	li	a1,106
ffffffffc0207aaa:	00006517          	auipc	a0,0x6
ffffffffc0207aae:	78e50513          	addi	a0,a0,1934 # ffffffffc020e238 <syscalls+0x810>
ffffffffc0207ab2:	e406                	sd	ra,8(sp)
ffffffffc0207ab4:	f7af80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207ab8 <vfs_add_dev>:
ffffffffc0207ab8:	86b2                	mv	a3,a2
ffffffffc0207aba:	4601                	li	a2,0
ffffffffc0207abc:	d3fff06f          	j	ffffffffc02077fa <vfs_do_add>

ffffffffc0207ac0 <vfs_mount>:
ffffffffc0207ac0:	7179                	addi	sp,sp,-48
ffffffffc0207ac2:	e84a                	sd	s2,16(sp)
ffffffffc0207ac4:	892a                	mv	s2,a0
ffffffffc0207ac6:	0008e517          	auipc	a0,0x8e
ffffffffc0207aca:	d4a50513          	addi	a0,a0,-694 # ffffffffc0295810 <vdev_list_sem>
ffffffffc0207ace:	e44e                	sd	s3,8(sp)
ffffffffc0207ad0:	f406                	sd	ra,40(sp)
ffffffffc0207ad2:	f022                	sd	s0,32(sp)
ffffffffc0207ad4:	ec26                	sd	s1,24(sp)
ffffffffc0207ad6:	89ae                	mv	s3,a1
ffffffffc0207ad8:	c73fc0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0207adc:	08090a63          	beqz	s2,ffffffffc0207b70 <vfs_mount+0xb0>
ffffffffc0207ae0:	0008e497          	auipc	s1,0x8e
ffffffffc0207ae4:	d2048493          	addi	s1,s1,-736 # ffffffffc0295800 <vdev_list>
ffffffffc0207ae8:	6480                	ld	s0,8(s1)
ffffffffc0207aea:	00941663          	bne	s0,s1,ffffffffc0207af6 <vfs_mount+0x36>
ffffffffc0207aee:	a8ad                	j	ffffffffc0207b68 <vfs_mount+0xa8>
ffffffffc0207af0:	6400                	ld	s0,8(s0)
ffffffffc0207af2:	06940b63          	beq	s0,s1,ffffffffc0207b68 <vfs_mount+0xa8>
ffffffffc0207af6:	ff843783          	ld	a5,-8(s0)
ffffffffc0207afa:	dbfd                	beqz	a5,ffffffffc0207af0 <vfs_mount+0x30>
ffffffffc0207afc:	fe043503          	ld	a0,-32(s0)
ffffffffc0207b00:	85ca                	mv	a1,s2
ffffffffc0207b02:	498030ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc0207b06:	f56d                	bnez	a0,ffffffffc0207af0 <vfs_mount+0x30>
ffffffffc0207b08:	ff043783          	ld	a5,-16(s0)
ffffffffc0207b0c:	e3a5                	bnez	a5,ffffffffc0207b6c <vfs_mount+0xac>
ffffffffc0207b0e:	fe043783          	ld	a5,-32(s0)
ffffffffc0207b12:	c3c9                	beqz	a5,ffffffffc0207b94 <vfs_mount+0xd4>
ffffffffc0207b14:	ff843783          	ld	a5,-8(s0)
ffffffffc0207b18:	cfb5                	beqz	a5,ffffffffc0207b94 <vfs_mount+0xd4>
ffffffffc0207b1a:	fe843503          	ld	a0,-24(s0)
ffffffffc0207b1e:	c939                	beqz	a0,ffffffffc0207b74 <vfs_mount+0xb4>
ffffffffc0207b20:	4d38                	lw	a4,88(a0)
ffffffffc0207b22:	6785                	lui	a5,0x1
ffffffffc0207b24:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207b28:	04f71663          	bne	a4,a5,ffffffffc0207b74 <vfs_mount+0xb4>
ffffffffc0207b2c:	ff040593          	addi	a1,s0,-16
ffffffffc0207b30:	9982                	jalr	s3
ffffffffc0207b32:	84aa                	mv	s1,a0
ffffffffc0207b34:	ed01                	bnez	a0,ffffffffc0207b4c <vfs_mount+0x8c>
ffffffffc0207b36:	ff043783          	ld	a5,-16(s0)
ffffffffc0207b3a:	cfad                	beqz	a5,ffffffffc0207bb4 <vfs_mount+0xf4>
ffffffffc0207b3c:	fe043583          	ld	a1,-32(s0)
ffffffffc0207b40:	00007517          	auipc	a0,0x7
ffffffffc0207b44:	80050513          	addi	a0,a0,-2048 # ffffffffc020e340 <syscalls+0x918>
ffffffffc0207b48:	de2f80ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0207b4c:	0008e517          	auipc	a0,0x8e
ffffffffc0207b50:	cc450513          	addi	a0,a0,-828 # ffffffffc0295810 <vdev_list_sem>
ffffffffc0207b54:	bf3fc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0207b58:	70a2                	ld	ra,40(sp)
ffffffffc0207b5a:	7402                	ld	s0,32(sp)
ffffffffc0207b5c:	6942                	ld	s2,16(sp)
ffffffffc0207b5e:	69a2                	ld	s3,8(sp)
ffffffffc0207b60:	8526                	mv	a0,s1
ffffffffc0207b62:	64e2                	ld	s1,24(sp)
ffffffffc0207b64:	6145                	addi	sp,sp,48
ffffffffc0207b66:	8082                	ret
ffffffffc0207b68:	54cd                	li	s1,-13
ffffffffc0207b6a:	b7cd                	j	ffffffffc0207b4c <vfs_mount+0x8c>
ffffffffc0207b6c:	54c5                	li	s1,-15
ffffffffc0207b6e:	bff9                	j	ffffffffc0207b4c <vfs_mount+0x8c>
ffffffffc0207b70:	db3ff0ef          	jal	ra,ffffffffc0207922 <find_mount.part.0>
ffffffffc0207b74:	00006697          	auipc	a3,0x6
ffffffffc0207b78:	77c68693          	addi	a3,a3,1916 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0207b7c:	00004617          	auipc	a2,0x4
ffffffffc0207b80:	c7c60613          	addi	a2,a2,-900 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207b84:	0ed00593          	li	a1,237
ffffffffc0207b88:	00006517          	auipc	a0,0x6
ffffffffc0207b8c:	6b050513          	addi	a0,a0,1712 # ffffffffc020e238 <syscalls+0x810>
ffffffffc0207b90:	e9ef80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207b94:	00006697          	auipc	a3,0x6
ffffffffc0207b98:	72c68693          	addi	a3,a3,1836 # ffffffffc020e2c0 <syscalls+0x898>
ffffffffc0207b9c:	00004617          	auipc	a2,0x4
ffffffffc0207ba0:	c5c60613          	addi	a2,a2,-932 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207ba4:	0eb00593          	li	a1,235
ffffffffc0207ba8:	00006517          	auipc	a0,0x6
ffffffffc0207bac:	69050513          	addi	a0,a0,1680 # ffffffffc020e238 <syscalls+0x810>
ffffffffc0207bb0:	e7ef80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207bb4:	00006697          	auipc	a3,0x6
ffffffffc0207bb8:	77468693          	addi	a3,a3,1908 # ffffffffc020e328 <syscalls+0x900>
ffffffffc0207bbc:	00004617          	auipc	a2,0x4
ffffffffc0207bc0:	c3c60613          	addi	a2,a2,-964 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207bc4:	0ef00593          	li	a1,239
ffffffffc0207bc8:	00006517          	auipc	a0,0x6
ffffffffc0207bcc:	67050513          	addi	a0,a0,1648 # ffffffffc020e238 <syscalls+0x810>
ffffffffc0207bd0:	e5ef80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207bd4 <vfs_get_curdir>:
ffffffffc0207bd4:	0008f797          	auipc	a5,0x8f
ffffffffc0207bd8:	cec7b783          	ld	a5,-788(a5) # ffffffffc02968c0 <current>
ffffffffc0207bdc:	1487b783          	ld	a5,328(a5)
ffffffffc0207be0:	1101                	addi	sp,sp,-32
ffffffffc0207be2:	e426                	sd	s1,8(sp)
ffffffffc0207be4:	6384                	ld	s1,0(a5)
ffffffffc0207be6:	ec06                	sd	ra,24(sp)
ffffffffc0207be8:	e822                	sd	s0,16(sp)
ffffffffc0207bea:	cc81                	beqz	s1,ffffffffc0207c02 <vfs_get_curdir+0x2e>
ffffffffc0207bec:	842a                	mv	s0,a0
ffffffffc0207bee:	8526                	mv	a0,s1
ffffffffc0207bf0:	600000ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0207bf4:	4501                	li	a0,0
ffffffffc0207bf6:	e004                	sd	s1,0(s0)
ffffffffc0207bf8:	60e2                	ld	ra,24(sp)
ffffffffc0207bfa:	6442                	ld	s0,16(sp)
ffffffffc0207bfc:	64a2                	ld	s1,8(sp)
ffffffffc0207bfe:	6105                	addi	sp,sp,32
ffffffffc0207c00:	8082                	ret
ffffffffc0207c02:	5541                	li	a0,-16
ffffffffc0207c04:	bfd5                	j	ffffffffc0207bf8 <vfs_get_curdir+0x24>

ffffffffc0207c06 <vfs_set_curdir>:
ffffffffc0207c06:	7139                	addi	sp,sp,-64
ffffffffc0207c08:	f04a                	sd	s2,32(sp)
ffffffffc0207c0a:	0008f917          	auipc	s2,0x8f
ffffffffc0207c0e:	cb690913          	addi	s2,s2,-842 # ffffffffc02968c0 <current>
ffffffffc0207c12:	00093783          	ld	a5,0(s2)
ffffffffc0207c16:	f822                	sd	s0,48(sp)
ffffffffc0207c18:	842a                	mv	s0,a0
ffffffffc0207c1a:	1487b503          	ld	a0,328(a5)
ffffffffc0207c1e:	ec4e                	sd	s3,24(sp)
ffffffffc0207c20:	fc06                	sd	ra,56(sp)
ffffffffc0207c22:	f426                	sd	s1,40(sp)
ffffffffc0207c24:	bb7fd0ef          	jal	ra,ffffffffc02057da <lock_files>
ffffffffc0207c28:	00093783          	ld	a5,0(s2)
ffffffffc0207c2c:	1487b503          	ld	a0,328(a5)
ffffffffc0207c30:	00053983          	ld	s3,0(a0)
ffffffffc0207c34:	07340963          	beq	s0,s3,ffffffffc0207ca6 <vfs_set_curdir+0xa0>
ffffffffc0207c38:	cc39                	beqz	s0,ffffffffc0207c96 <vfs_set_curdir+0x90>
ffffffffc0207c3a:	783c                	ld	a5,112(s0)
ffffffffc0207c3c:	c7bd                	beqz	a5,ffffffffc0207caa <vfs_set_curdir+0xa4>
ffffffffc0207c3e:	6bbc                	ld	a5,80(a5)
ffffffffc0207c40:	c7ad                	beqz	a5,ffffffffc0207caa <vfs_set_curdir+0xa4>
ffffffffc0207c42:	00006597          	auipc	a1,0x6
ffffffffc0207c46:	77658593          	addi	a1,a1,1910 # ffffffffc020e3b8 <syscalls+0x990>
ffffffffc0207c4a:	8522                	mv	a0,s0
ffffffffc0207c4c:	5bc000ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0207c50:	783c                	ld	a5,112(s0)
ffffffffc0207c52:	006c                	addi	a1,sp,12
ffffffffc0207c54:	8522                	mv	a0,s0
ffffffffc0207c56:	6bbc                	ld	a5,80(a5)
ffffffffc0207c58:	9782                	jalr	a5
ffffffffc0207c5a:	84aa                	mv	s1,a0
ffffffffc0207c5c:	e901                	bnez	a0,ffffffffc0207c6c <vfs_set_curdir+0x66>
ffffffffc0207c5e:	47b2                	lw	a5,12(sp)
ffffffffc0207c60:	669d                	lui	a3,0x7
ffffffffc0207c62:	6709                	lui	a4,0x2
ffffffffc0207c64:	8ff5                	and	a5,a5,a3
ffffffffc0207c66:	54b9                	li	s1,-18
ffffffffc0207c68:	02e78063          	beq	a5,a4,ffffffffc0207c88 <vfs_set_curdir+0x82>
ffffffffc0207c6c:	00093783          	ld	a5,0(s2)
ffffffffc0207c70:	1487b503          	ld	a0,328(a5)
ffffffffc0207c74:	b6dfd0ef          	jal	ra,ffffffffc02057e0 <unlock_files>
ffffffffc0207c78:	70e2                	ld	ra,56(sp)
ffffffffc0207c7a:	7442                	ld	s0,48(sp)
ffffffffc0207c7c:	7902                	ld	s2,32(sp)
ffffffffc0207c7e:	69e2                	ld	s3,24(sp)
ffffffffc0207c80:	8526                	mv	a0,s1
ffffffffc0207c82:	74a2                	ld	s1,40(sp)
ffffffffc0207c84:	6121                	addi	sp,sp,64
ffffffffc0207c86:	8082                	ret
ffffffffc0207c88:	8522                	mv	a0,s0
ffffffffc0207c8a:	566000ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0207c8e:	00093783          	ld	a5,0(s2)
ffffffffc0207c92:	1487b503          	ld	a0,328(a5)
ffffffffc0207c96:	e100                	sd	s0,0(a0)
ffffffffc0207c98:	4481                	li	s1,0
ffffffffc0207c9a:	fc098de3          	beqz	s3,ffffffffc0207c74 <vfs_set_curdir+0x6e>
ffffffffc0207c9e:	854e                	mv	a0,s3
ffffffffc0207ca0:	61e000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0207ca4:	b7e1                	j	ffffffffc0207c6c <vfs_set_curdir+0x66>
ffffffffc0207ca6:	4481                	li	s1,0
ffffffffc0207ca8:	b7f1                	j	ffffffffc0207c74 <vfs_set_curdir+0x6e>
ffffffffc0207caa:	00006697          	auipc	a3,0x6
ffffffffc0207cae:	6a668693          	addi	a3,a3,1702 # ffffffffc020e350 <syscalls+0x928>
ffffffffc0207cb2:	00004617          	auipc	a2,0x4
ffffffffc0207cb6:	b4660613          	addi	a2,a2,-1210 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207cba:	04300593          	li	a1,67
ffffffffc0207cbe:	00006517          	auipc	a0,0x6
ffffffffc0207cc2:	6e250513          	addi	a0,a0,1762 # ffffffffc020e3a0 <syscalls+0x978>
ffffffffc0207cc6:	d68f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207cca <vfs_chdir>:
ffffffffc0207cca:	1101                	addi	sp,sp,-32
ffffffffc0207ccc:	002c                	addi	a1,sp,8
ffffffffc0207cce:	e822                	sd	s0,16(sp)
ffffffffc0207cd0:	ec06                	sd	ra,24(sp)
ffffffffc0207cd2:	21e000ef          	jal	ra,ffffffffc0207ef0 <vfs_lookup>
ffffffffc0207cd6:	842a                	mv	s0,a0
ffffffffc0207cd8:	c511                	beqz	a0,ffffffffc0207ce4 <vfs_chdir+0x1a>
ffffffffc0207cda:	60e2                	ld	ra,24(sp)
ffffffffc0207cdc:	8522                	mv	a0,s0
ffffffffc0207cde:	6442                	ld	s0,16(sp)
ffffffffc0207ce0:	6105                	addi	sp,sp,32
ffffffffc0207ce2:	8082                	ret
ffffffffc0207ce4:	6522                	ld	a0,8(sp)
ffffffffc0207ce6:	f21ff0ef          	jal	ra,ffffffffc0207c06 <vfs_set_curdir>
ffffffffc0207cea:	842a                	mv	s0,a0
ffffffffc0207cec:	6522                	ld	a0,8(sp)
ffffffffc0207cee:	5d0000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0207cf2:	60e2                	ld	ra,24(sp)
ffffffffc0207cf4:	8522                	mv	a0,s0
ffffffffc0207cf6:	6442                	ld	s0,16(sp)
ffffffffc0207cf8:	6105                	addi	sp,sp,32
ffffffffc0207cfa:	8082                	ret

ffffffffc0207cfc <vfs_getcwd>:
ffffffffc0207cfc:	0008f797          	auipc	a5,0x8f
ffffffffc0207d00:	bc47b783          	ld	a5,-1084(a5) # ffffffffc02968c0 <current>
ffffffffc0207d04:	1487b783          	ld	a5,328(a5)
ffffffffc0207d08:	7179                	addi	sp,sp,-48
ffffffffc0207d0a:	ec26                	sd	s1,24(sp)
ffffffffc0207d0c:	6384                	ld	s1,0(a5)
ffffffffc0207d0e:	f406                	sd	ra,40(sp)
ffffffffc0207d10:	f022                	sd	s0,32(sp)
ffffffffc0207d12:	e84a                	sd	s2,16(sp)
ffffffffc0207d14:	ccbd                	beqz	s1,ffffffffc0207d92 <vfs_getcwd+0x96>
ffffffffc0207d16:	892a                	mv	s2,a0
ffffffffc0207d18:	8526                	mv	a0,s1
ffffffffc0207d1a:	4d6000ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0207d1e:	74a8                	ld	a0,104(s1)
ffffffffc0207d20:	c93d                	beqz	a0,ffffffffc0207d96 <vfs_getcwd+0x9a>
ffffffffc0207d22:	d4dff0ef          	jal	ra,ffffffffc0207a6e <vfs_get_devname>
ffffffffc0207d26:	842a                	mv	s0,a0
ffffffffc0207d28:	22a030ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc0207d2c:	862a                	mv	a2,a0
ffffffffc0207d2e:	85a2                	mv	a1,s0
ffffffffc0207d30:	4701                	li	a4,0
ffffffffc0207d32:	4685                	li	a3,1
ffffffffc0207d34:	854a                	mv	a0,s2
ffffffffc0207d36:	a01fd0ef          	jal	ra,ffffffffc0205736 <iobuf_move>
ffffffffc0207d3a:	842a                	mv	s0,a0
ffffffffc0207d3c:	c919                	beqz	a0,ffffffffc0207d52 <vfs_getcwd+0x56>
ffffffffc0207d3e:	8526                	mv	a0,s1
ffffffffc0207d40:	57e000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0207d44:	70a2                	ld	ra,40(sp)
ffffffffc0207d46:	8522                	mv	a0,s0
ffffffffc0207d48:	7402                	ld	s0,32(sp)
ffffffffc0207d4a:	64e2                	ld	s1,24(sp)
ffffffffc0207d4c:	6942                	ld	s2,16(sp)
ffffffffc0207d4e:	6145                	addi	sp,sp,48
ffffffffc0207d50:	8082                	ret
ffffffffc0207d52:	03a00793          	li	a5,58
ffffffffc0207d56:	4701                	li	a4,0
ffffffffc0207d58:	4685                	li	a3,1
ffffffffc0207d5a:	4605                	li	a2,1
ffffffffc0207d5c:	00f10593          	addi	a1,sp,15
ffffffffc0207d60:	854a                	mv	a0,s2
ffffffffc0207d62:	00f107a3          	sb	a5,15(sp)
ffffffffc0207d66:	9d1fd0ef          	jal	ra,ffffffffc0205736 <iobuf_move>
ffffffffc0207d6a:	842a                	mv	s0,a0
ffffffffc0207d6c:	f969                	bnez	a0,ffffffffc0207d3e <vfs_getcwd+0x42>
ffffffffc0207d6e:	78bc                	ld	a5,112(s1)
ffffffffc0207d70:	c3b9                	beqz	a5,ffffffffc0207db6 <vfs_getcwd+0xba>
ffffffffc0207d72:	7f9c                	ld	a5,56(a5)
ffffffffc0207d74:	c3a9                	beqz	a5,ffffffffc0207db6 <vfs_getcwd+0xba>
ffffffffc0207d76:	00006597          	auipc	a1,0x6
ffffffffc0207d7a:	6ba58593          	addi	a1,a1,1722 # ffffffffc020e430 <syscalls+0xa08>
ffffffffc0207d7e:	8526                	mv	a0,s1
ffffffffc0207d80:	488000ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0207d84:	78bc                	ld	a5,112(s1)
ffffffffc0207d86:	85ca                	mv	a1,s2
ffffffffc0207d88:	8526                	mv	a0,s1
ffffffffc0207d8a:	7f9c                	ld	a5,56(a5)
ffffffffc0207d8c:	9782                	jalr	a5
ffffffffc0207d8e:	842a                	mv	s0,a0
ffffffffc0207d90:	b77d                	j	ffffffffc0207d3e <vfs_getcwd+0x42>
ffffffffc0207d92:	5441                	li	s0,-16
ffffffffc0207d94:	bf45                	j	ffffffffc0207d44 <vfs_getcwd+0x48>
ffffffffc0207d96:	00006697          	auipc	a3,0x6
ffffffffc0207d9a:	62a68693          	addi	a3,a3,1578 # ffffffffc020e3c0 <syscalls+0x998>
ffffffffc0207d9e:	00004617          	auipc	a2,0x4
ffffffffc0207da2:	a5a60613          	addi	a2,a2,-1446 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207da6:	06e00593          	li	a1,110
ffffffffc0207daa:	00006517          	auipc	a0,0x6
ffffffffc0207dae:	5f650513          	addi	a0,a0,1526 # ffffffffc020e3a0 <syscalls+0x978>
ffffffffc0207db2:	c7cf80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207db6:	00006697          	auipc	a3,0x6
ffffffffc0207dba:	62268693          	addi	a3,a3,1570 # ffffffffc020e3d8 <syscalls+0x9b0>
ffffffffc0207dbe:	00004617          	auipc	a2,0x4
ffffffffc0207dc2:	a3a60613          	addi	a2,a2,-1478 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207dc6:	07800593          	li	a1,120
ffffffffc0207dca:	00006517          	auipc	a0,0x6
ffffffffc0207dce:	5d650513          	addi	a0,a0,1494 # ffffffffc020e3a0 <syscalls+0x978>
ffffffffc0207dd2:	c5cf80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207dd6 <get_device>:
ffffffffc0207dd6:	7179                	addi	sp,sp,-48
ffffffffc0207dd8:	ec26                	sd	s1,24(sp)
ffffffffc0207dda:	e84a                	sd	s2,16(sp)
ffffffffc0207ddc:	f406                	sd	ra,40(sp)
ffffffffc0207dde:	f022                	sd	s0,32(sp)
ffffffffc0207de0:	00054303          	lbu	t1,0(a0)
ffffffffc0207de4:	892e                	mv	s2,a1
ffffffffc0207de6:	84b2                	mv	s1,a2
ffffffffc0207de8:	02030463          	beqz	t1,ffffffffc0207e10 <get_device+0x3a>
ffffffffc0207dec:	00150413          	addi	s0,a0,1
ffffffffc0207df0:	86a2                	mv	a3,s0
ffffffffc0207df2:	879a                	mv	a5,t1
ffffffffc0207df4:	4701                	li	a4,0
ffffffffc0207df6:	03a00813          	li	a6,58
ffffffffc0207dfa:	02f00893          	li	a7,47
ffffffffc0207dfe:	03078363          	beq	a5,a6,ffffffffc0207e24 <get_device+0x4e>
ffffffffc0207e02:	05178a63          	beq	a5,a7,ffffffffc0207e56 <get_device+0x80>
ffffffffc0207e06:	0006c783          	lbu	a5,0(a3)
ffffffffc0207e0a:	2705                	addiw	a4,a4,1
ffffffffc0207e0c:	0685                	addi	a3,a3,1
ffffffffc0207e0e:	fbe5                	bnez	a5,ffffffffc0207dfe <get_device+0x28>
ffffffffc0207e10:	7402                	ld	s0,32(sp)
ffffffffc0207e12:	00a93023          	sd	a0,0(s2)
ffffffffc0207e16:	70a2                	ld	ra,40(sp)
ffffffffc0207e18:	6942                	ld	s2,16(sp)
ffffffffc0207e1a:	8526                	mv	a0,s1
ffffffffc0207e1c:	64e2                	ld	s1,24(sp)
ffffffffc0207e1e:	6145                	addi	sp,sp,48
ffffffffc0207e20:	db5ff06f          	j	ffffffffc0207bd4 <vfs_get_curdir>
ffffffffc0207e24:	cb15                	beqz	a4,ffffffffc0207e58 <get_device+0x82>
ffffffffc0207e26:	00e507b3          	add	a5,a0,a4
ffffffffc0207e2a:	0705                	addi	a4,a4,1
ffffffffc0207e2c:	00078023          	sb	zero,0(a5)
ffffffffc0207e30:	972a                	add	a4,a4,a0
ffffffffc0207e32:	02f00613          	li	a2,47
ffffffffc0207e36:	00074783          	lbu	a5,0(a4) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc0207e3a:	86ba                	mv	a3,a4
ffffffffc0207e3c:	0705                	addi	a4,a4,1
ffffffffc0207e3e:	fec78ce3          	beq	a5,a2,ffffffffc0207e36 <get_device+0x60>
ffffffffc0207e42:	7402                	ld	s0,32(sp)
ffffffffc0207e44:	70a2                	ld	ra,40(sp)
ffffffffc0207e46:	00d93023          	sd	a3,0(s2)
ffffffffc0207e4a:	85a6                	mv	a1,s1
ffffffffc0207e4c:	6942                	ld	s2,16(sp)
ffffffffc0207e4e:	64e2                	ld	s1,24(sp)
ffffffffc0207e50:	6145                	addi	sp,sp,48
ffffffffc0207e52:	b67ff06f          	j	ffffffffc02079b8 <vfs_get_root>
ffffffffc0207e56:	ff4d                	bnez	a4,ffffffffc0207e10 <get_device+0x3a>
ffffffffc0207e58:	02f00793          	li	a5,47
ffffffffc0207e5c:	04f30563          	beq	t1,a5,ffffffffc0207ea6 <get_device+0xd0>
ffffffffc0207e60:	03a00793          	li	a5,58
ffffffffc0207e64:	06f31663          	bne	t1,a5,ffffffffc0207ed0 <get_device+0xfa>
ffffffffc0207e68:	0028                	addi	a0,sp,8
ffffffffc0207e6a:	d6bff0ef          	jal	ra,ffffffffc0207bd4 <vfs_get_curdir>
ffffffffc0207e6e:	e515                	bnez	a0,ffffffffc0207e9a <get_device+0xc4>
ffffffffc0207e70:	67a2                	ld	a5,8(sp)
ffffffffc0207e72:	77a8                	ld	a0,104(a5)
ffffffffc0207e74:	cd15                	beqz	a0,ffffffffc0207eb0 <get_device+0xda>
ffffffffc0207e76:	617c                	ld	a5,192(a0)
ffffffffc0207e78:	9782                	jalr	a5
ffffffffc0207e7a:	87aa                	mv	a5,a0
ffffffffc0207e7c:	6522                	ld	a0,8(sp)
ffffffffc0207e7e:	e09c                	sd	a5,0(s1)
ffffffffc0207e80:	43e000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0207e84:	02f00713          	li	a4,47
ffffffffc0207e88:	a011                	j	ffffffffc0207e8c <get_device+0xb6>
ffffffffc0207e8a:	0405                	addi	s0,s0,1
ffffffffc0207e8c:	00044783          	lbu	a5,0(s0)
ffffffffc0207e90:	fee78de3          	beq	a5,a4,ffffffffc0207e8a <get_device+0xb4>
ffffffffc0207e94:	00893023          	sd	s0,0(s2)
ffffffffc0207e98:	4501                	li	a0,0
ffffffffc0207e9a:	70a2                	ld	ra,40(sp)
ffffffffc0207e9c:	7402                	ld	s0,32(sp)
ffffffffc0207e9e:	64e2                	ld	s1,24(sp)
ffffffffc0207ea0:	6942                	ld	s2,16(sp)
ffffffffc0207ea2:	6145                	addi	sp,sp,48
ffffffffc0207ea4:	8082                	ret
ffffffffc0207ea6:	8526                	mv	a0,s1
ffffffffc0207ea8:	616000ef          	jal	ra,ffffffffc02084be <vfs_get_bootfs>
ffffffffc0207eac:	dd61                	beqz	a0,ffffffffc0207e84 <get_device+0xae>
ffffffffc0207eae:	b7f5                	j	ffffffffc0207e9a <get_device+0xc4>
ffffffffc0207eb0:	00006697          	auipc	a3,0x6
ffffffffc0207eb4:	51068693          	addi	a3,a3,1296 # ffffffffc020e3c0 <syscalls+0x998>
ffffffffc0207eb8:	00004617          	auipc	a2,0x4
ffffffffc0207ebc:	94060613          	addi	a2,a2,-1728 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207ec0:	03900593          	li	a1,57
ffffffffc0207ec4:	00006517          	auipc	a0,0x6
ffffffffc0207ec8:	58c50513          	addi	a0,a0,1420 # ffffffffc020e450 <syscalls+0xa28>
ffffffffc0207ecc:	b62f80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0207ed0:	00006697          	auipc	a3,0x6
ffffffffc0207ed4:	57068693          	addi	a3,a3,1392 # ffffffffc020e440 <syscalls+0xa18>
ffffffffc0207ed8:	00004617          	auipc	a2,0x4
ffffffffc0207edc:	92060613          	addi	a2,a2,-1760 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207ee0:	03300593          	li	a1,51
ffffffffc0207ee4:	00006517          	auipc	a0,0x6
ffffffffc0207ee8:	56c50513          	addi	a0,a0,1388 # ffffffffc020e450 <syscalls+0xa28>
ffffffffc0207eec:	b42f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207ef0 <vfs_lookup>:
ffffffffc0207ef0:	7139                	addi	sp,sp,-64
ffffffffc0207ef2:	f426                	sd	s1,40(sp)
ffffffffc0207ef4:	0830                	addi	a2,sp,24
ffffffffc0207ef6:	84ae                	mv	s1,a1
ffffffffc0207ef8:	002c                	addi	a1,sp,8
ffffffffc0207efa:	f822                	sd	s0,48(sp)
ffffffffc0207efc:	fc06                	sd	ra,56(sp)
ffffffffc0207efe:	f04a                	sd	s2,32(sp)
ffffffffc0207f00:	e42a                	sd	a0,8(sp)
ffffffffc0207f02:	ed5ff0ef          	jal	ra,ffffffffc0207dd6 <get_device>
ffffffffc0207f06:	842a                	mv	s0,a0
ffffffffc0207f08:	ed1d                	bnez	a0,ffffffffc0207f46 <vfs_lookup+0x56>
ffffffffc0207f0a:	67a2                	ld	a5,8(sp)
ffffffffc0207f0c:	6962                	ld	s2,24(sp)
ffffffffc0207f0e:	0007c783          	lbu	a5,0(a5)
ffffffffc0207f12:	c3a9                	beqz	a5,ffffffffc0207f54 <vfs_lookup+0x64>
ffffffffc0207f14:	04090963          	beqz	s2,ffffffffc0207f66 <vfs_lookup+0x76>
ffffffffc0207f18:	07093783          	ld	a5,112(s2)
ffffffffc0207f1c:	c7a9                	beqz	a5,ffffffffc0207f66 <vfs_lookup+0x76>
ffffffffc0207f1e:	7bbc                	ld	a5,112(a5)
ffffffffc0207f20:	c3b9                	beqz	a5,ffffffffc0207f66 <vfs_lookup+0x76>
ffffffffc0207f22:	854a                	mv	a0,s2
ffffffffc0207f24:	00006597          	auipc	a1,0x6
ffffffffc0207f28:	59458593          	addi	a1,a1,1428 # ffffffffc020e4b8 <syscalls+0xa90>
ffffffffc0207f2c:	2dc000ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0207f30:	07093783          	ld	a5,112(s2)
ffffffffc0207f34:	65a2                	ld	a1,8(sp)
ffffffffc0207f36:	6562                	ld	a0,24(sp)
ffffffffc0207f38:	7bbc                	ld	a5,112(a5)
ffffffffc0207f3a:	8626                	mv	a2,s1
ffffffffc0207f3c:	9782                	jalr	a5
ffffffffc0207f3e:	842a                	mv	s0,a0
ffffffffc0207f40:	6562                	ld	a0,24(sp)
ffffffffc0207f42:	37c000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0207f46:	70e2                	ld	ra,56(sp)
ffffffffc0207f48:	8522                	mv	a0,s0
ffffffffc0207f4a:	7442                	ld	s0,48(sp)
ffffffffc0207f4c:	74a2                	ld	s1,40(sp)
ffffffffc0207f4e:	7902                	ld	s2,32(sp)
ffffffffc0207f50:	6121                	addi	sp,sp,64
ffffffffc0207f52:	8082                	ret
ffffffffc0207f54:	70e2                	ld	ra,56(sp)
ffffffffc0207f56:	8522                	mv	a0,s0
ffffffffc0207f58:	7442                	ld	s0,48(sp)
ffffffffc0207f5a:	0124b023          	sd	s2,0(s1)
ffffffffc0207f5e:	74a2                	ld	s1,40(sp)
ffffffffc0207f60:	7902                	ld	s2,32(sp)
ffffffffc0207f62:	6121                	addi	sp,sp,64
ffffffffc0207f64:	8082                	ret
ffffffffc0207f66:	00006697          	auipc	a3,0x6
ffffffffc0207f6a:	50268693          	addi	a3,a3,1282 # ffffffffc020e468 <syscalls+0xa40>
ffffffffc0207f6e:	00004617          	auipc	a2,0x4
ffffffffc0207f72:	88a60613          	addi	a2,a2,-1910 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0207f76:	04f00593          	li	a1,79
ffffffffc0207f7a:	00006517          	auipc	a0,0x6
ffffffffc0207f7e:	4d650513          	addi	a0,a0,1238 # ffffffffc020e450 <syscalls+0xa28>
ffffffffc0207f82:	aacf80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0207f86 <vfs_lookup_parent>:
ffffffffc0207f86:	7139                	addi	sp,sp,-64
ffffffffc0207f88:	f822                	sd	s0,48(sp)
ffffffffc0207f8a:	f426                	sd	s1,40(sp)
ffffffffc0207f8c:	842e                	mv	s0,a1
ffffffffc0207f8e:	84b2                	mv	s1,a2
ffffffffc0207f90:	002c                	addi	a1,sp,8
ffffffffc0207f92:	0830                	addi	a2,sp,24
ffffffffc0207f94:	fc06                	sd	ra,56(sp)
ffffffffc0207f96:	e42a                	sd	a0,8(sp)
ffffffffc0207f98:	e3fff0ef          	jal	ra,ffffffffc0207dd6 <get_device>
ffffffffc0207f9c:	e509                	bnez	a0,ffffffffc0207fa6 <vfs_lookup_parent+0x20>
ffffffffc0207f9e:	67a2                	ld	a5,8(sp)
ffffffffc0207fa0:	e09c                	sd	a5,0(s1)
ffffffffc0207fa2:	67e2                	ld	a5,24(sp)
ffffffffc0207fa4:	e01c                	sd	a5,0(s0)
ffffffffc0207fa6:	70e2                	ld	ra,56(sp)
ffffffffc0207fa8:	7442                	ld	s0,48(sp)
ffffffffc0207faa:	74a2                	ld	s1,40(sp)
ffffffffc0207fac:	6121                	addi	sp,sp,64
ffffffffc0207fae:	8082                	ret

ffffffffc0207fb0 <vfs_open>:
ffffffffc0207fb0:	711d                	addi	sp,sp,-96
ffffffffc0207fb2:	e4a6                	sd	s1,72(sp)
ffffffffc0207fb4:	e0ca                	sd	s2,64(sp)
ffffffffc0207fb6:	fc4e                	sd	s3,56(sp)
ffffffffc0207fb8:	ec86                	sd	ra,88(sp)
ffffffffc0207fba:	e8a2                	sd	s0,80(sp)
ffffffffc0207fbc:	f852                	sd	s4,48(sp)
ffffffffc0207fbe:	f456                	sd	s5,40(sp)
ffffffffc0207fc0:	0035f793          	andi	a5,a1,3
ffffffffc0207fc4:	84ae                	mv	s1,a1
ffffffffc0207fc6:	892a                	mv	s2,a0
ffffffffc0207fc8:	89b2                	mv	s3,a2
ffffffffc0207fca:	0e078663          	beqz	a5,ffffffffc02080b6 <vfs_open+0x106>
ffffffffc0207fce:	470d                	li	a4,3
ffffffffc0207fd0:	0105fa93          	andi	s5,a1,16
ffffffffc0207fd4:	0ce78f63          	beq	a5,a4,ffffffffc02080b2 <vfs_open+0x102>
ffffffffc0207fd8:	002c                	addi	a1,sp,8
ffffffffc0207fda:	854a                	mv	a0,s2
ffffffffc0207fdc:	f15ff0ef          	jal	ra,ffffffffc0207ef0 <vfs_lookup>
ffffffffc0207fe0:	842a                	mv	s0,a0
ffffffffc0207fe2:	0044fa13          	andi	s4,s1,4
ffffffffc0207fe6:	e159                	bnez	a0,ffffffffc020806c <vfs_open+0xbc>
ffffffffc0207fe8:	00c4f793          	andi	a5,s1,12
ffffffffc0207fec:	4731                	li	a4,12
ffffffffc0207fee:	0ee78263          	beq	a5,a4,ffffffffc02080d2 <vfs_open+0x122>
ffffffffc0207ff2:	6422                	ld	s0,8(sp)
ffffffffc0207ff4:	12040163          	beqz	s0,ffffffffc0208116 <vfs_open+0x166>
ffffffffc0207ff8:	783c                	ld	a5,112(s0)
ffffffffc0207ffa:	cff1                	beqz	a5,ffffffffc02080d6 <vfs_open+0x126>
ffffffffc0207ffc:	679c                	ld	a5,8(a5)
ffffffffc0207ffe:	cfe1                	beqz	a5,ffffffffc02080d6 <vfs_open+0x126>
ffffffffc0208000:	8522                	mv	a0,s0
ffffffffc0208002:	00006597          	auipc	a1,0x6
ffffffffc0208006:	58e58593          	addi	a1,a1,1422 # ffffffffc020e590 <syscalls+0xb68>
ffffffffc020800a:	1fe000ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc020800e:	783c                	ld	a5,112(s0)
ffffffffc0208010:	6522                	ld	a0,8(sp)
ffffffffc0208012:	85a6                	mv	a1,s1
ffffffffc0208014:	679c                	ld	a5,8(a5)
ffffffffc0208016:	9782                	jalr	a5
ffffffffc0208018:	842a                	mv	s0,a0
ffffffffc020801a:	6522                	ld	a0,8(sp)
ffffffffc020801c:	e845                	bnez	s0,ffffffffc02080cc <vfs_open+0x11c>
ffffffffc020801e:	015a6a33          	or	s4,s4,s5
ffffffffc0208022:	1da000ef          	jal	ra,ffffffffc02081fc <inode_open_inc>
ffffffffc0208026:	020a0663          	beqz	s4,ffffffffc0208052 <vfs_open+0xa2>
ffffffffc020802a:	64a2                	ld	s1,8(sp)
ffffffffc020802c:	c4e9                	beqz	s1,ffffffffc02080f6 <vfs_open+0x146>
ffffffffc020802e:	78bc                	ld	a5,112(s1)
ffffffffc0208030:	c3f9                	beqz	a5,ffffffffc02080f6 <vfs_open+0x146>
ffffffffc0208032:	73bc                	ld	a5,96(a5)
ffffffffc0208034:	c3e9                	beqz	a5,ffffffffc02080f6 <vfs_open+0x146>
ffffffffc0208036:	00006597          	auipc	a1,0x6
ffffffffc020803a:	5ba58593          	addi	a1,a1,1466 # ffffffffc020e5f0 <syscalls+0xbc8>
ffffffffc020803e:	8526                	mv	a0,s1
ffffffffc0208040:	1c8000ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0208044:	78bc                	ld	a5,112(s1)
ffffffffc0208046:	6522                	ld	a0,8(sp)
ffffffffc0208048:	4581                	li	a1,0
ffffffffc020804a:	73bc                	ld	a5,96(a5)
ffffffffc020804c:	9782                	jalr	a5
ffffffffc020804e:	87aa                	mv	a5,a0
ffffffffc0208050:	e92d                	bnez	a0,ffffffffc02080c2 <vfs_open+0x112>
ffffffffc0208052:	67a2                	ld	a5,8(sp)
ffffffffc0208054:	00f9b023          	sd	a5,0(s3)
ffffffffc0208058:	60e6                	ld	ra,88(sp)
ffffffffc020805a:	8522                	mv	a0,s0
ffffffffc020805c:	6446                	ld	s0,80(sp)
ffffffffc020805e:	64a6                	ld	s1,72(sp)
ffffffffc0208060:	6906                	ld	s2,64(sp)
ffffffffc0208062:	79e2                	ld	s3,56(sp)
ffffffffc0208064:	7a42                	ld	s4,48(sp)
ffffffffc0208066:	7aa2                	ld	s5,40(sp)
ffffffffc0208068:	6125                	addi	sp,sp,96
ffffffffc020806a:	8082                	ret
ffffffffc020806c:	57c1                	li	a5,-16
ffffffffc020806e:	fef515e3          	bne	a0,a5,ffffffffc0208058 <vfs_open+0xa8>
ffffffffc0208072:	fe0a03e3          	beqz	s4,ffffffffc0208058 <vfs_open+0xa8>
ffffffffc0208076:	0810                	addi	a2,sp,16
ffffffffc0208078:	082c                	addi	a1,sp,24
ffffffffc020807a:	854a                	mv	a0,s2
ffffffffc020807c:	f0bff0ef          	jal	ra,ffffffffc0207f86 <vfs_lookup_parent>
ffffffffc0208080:	842a                	mv	s0,a0
ffffffffc0208082:	f979                	bnez	a0,ffffffffc0208058 <vfs_open+0xa8>
ffffffffc0208084:	6462                	ld	s0,24(sp)
ffffffffc0208086:	c845                	beqz	s0,ffffffffc0208136 <vfs_open+0x186>
ffffffffc0208088:	783c                	ld	a5,112(s0)
ffffffffc020808a:	c7d5                	beqz	a5,ffffffffc0208136 <vfs_open+0x186>
ffffffffc020808c:	77bc                	ld	a5,104(a5)
ffffffffc020808e:	c7c5                	beqz	a5,ffffffffc0208136 <vfs_open+0x186>
ffffffffc0208090:	8522                	mv	a0,s0
ffffffffc0208092:	00006597          	auipc	a1,0x6
ffffffffc0208096:	49658593          	addi	a1,a1,1174 # ffffffffc020e528 <syscalls+0xb00>
ffffffffc020809a:	16e000ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc020809e:	783c                	ld	a5,112(s0)
ffffffffc02080a0:	65c2                	ld	a1,16(sp)
ffffffffc02080a2:	6562                	ld	a0,24(sp)
ffffffffc02080a4:	77bc                	ld	a5,104(a5)
ffffffffc02080a6:	4034d613          	srai	a2,s1,0x3
ffffffffc02080aa:	0034                	addi	a3,sp,8
ffffffffc02080ac:	8a05                	andi	a2,a2,1
ffffffffc02080ae:	9782                	jalr	a5
ffffffffc02080b0:	b789                	j	ffffffffc0207ff2 <vfs_open+0x42>
ffffffffc02080b2:	5475                	li	s0,-3
ffffffffc02080b4:	b755                	j	ffffffffc0208058 <vfs_open+0xa8>
ffffffffc02080b6:	0105fa93          	andi	s5,a1,16
ffffffffc02080ba:	5475                	li	s0,-3
ffffffffc02080bc:	f80a9ee3          	bnez	s5,ffffffffc0208058 <vfs_open+0xa8>
ffffffffc02080c0:	bf21                	j	ffffffffc0207fd8 <vfs_open+0x28>
ffffffffc02080c2:	6522                	ld	a0,8(sp)
ffffffffc02080c4:	843e                	mv	s0,a5
ffffffffc02080c6:	2a0000ef          	jal	ra,ffffffffc0208366 <inode_open_dec>
ffffffffc02080ca:	6522                	ld	a0,8(sp)
ffffffffc02080cc:	1f2000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc02080d0:	b761                	j	ffffffffc0208058 <vfs_open+0xa8>
ffffffffc02080d2:	5425                	li	s0,-23
ffffffffc02080d4:	b751                	j	ffffffffc0208058 <vfs_open+0xa8>
ffffffffc02080d6:	00006697          	auipc	a3,0x6
ffffffffc02080da:	46a68693          	addi	a3,a3,1130 # ffffffffc020e540 <syscalls+0xb18>
ffffffffc02080de:	00003617          	auipc	a2,0x3
ffffffffc02080e2:	71a60613          	addi	a2,a2,1818 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02080e6:	03300593          	li	a1,51
ffffffffc02080ea:	00006517          	auipc	a0,0x6
ffffffffc02080ee:	42650513          	addi	a0,a0,1062 # ffffffffc020e510 <syscalls+0xae8>
ffffffffc02080f2:	93cf80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02080f6:	00006697          	auipc	a3,0x6
ffffffffc02080fa:	4a268693          	addi	a3,a3,1186 # ffffffffc020e598 <syscalls+0xb70>
ffffffffc02080fe:	00003617          	auipc	a2,0x3
ffffffffc0208102:	6fa60613          	addi	a2,a2,1786 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208106:	03a00593          	li	a1,58
ffffffffc020810a:	00006517          	auipc	a0,0x6
ffffffffc020810e:	40650513          	addi	a0,a0,1030 # ffffffffc020e510 <syscalls+0xae8>
ffffffffc0208112:	91cf80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208116:	00006697          	auipc	a3,0x6
ffffffffc020811a:	41a68693          	addi	a3,a3,1050 # ffffffffc020e530 <syscalls+0xb08>
ffffffffc020811e:	00003617          	auipc	a2,0x3
ffffffffc0208122:	6da60613          	addi	a2,a2,1754 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208126:	03100593          	li	a1,49
ffffffffc020812a:	00006517          	auipc	a0,0x6
ffffffffc020812e:	3e650513          	addi	a0,a0,998 # ffffffffc020e510 <syscalls+0xae8>
ffffffffc0208132:	8fcf80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208136:	00006697          	auipc	a3,0x6
ffffffffc020813a:	38a68693          	addi	a3,a3,906 # ffffffffc020e4c0 <syscalls+0xa98>
ffffffffc020813e:	00003617          	auipc	a2,0x3
ffffffffc0208142:	6ba60613          	addi	a2,a2,1722 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208146:	02c00593          	li	a1,44
ffffffffc020814a:	00006517          	auipc	a0,0x6
ffffffffc020814e:	3c650513          	addi	a0,a0,966 # ffffffffc020e510 <syscalls+0xae8>
ffffffffc0208152:	8dcf80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208156 <vfs_close>:
ffffffffc0208156:	1141                	addi	sp,sp,-16
ffffffffc0208158:	e406                	sd	ra,8(sp)
ffffffffc020815a:	e022                	sd	s0,0(sp)
ffffffffc020815c:	842a                	mv	s0,a0
ffffffffc020815e:	208000ef          	jal	ra,ffffffffc0208366 <inode_open_dec>
ffffffffc0208162:	8522                	mv	a0,s0
ffffffffc0208164:	15a000ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc0208168:	60a2                	ld	ra,8(sp)
ffffffffc020816a:	6402                	ld	s0,0(sp)
ffffffffc020816c:	4501                	li	a0,0
ffffffffc020816e:	0141                	addi	sp,sp,16
ffffffffc0208170:	8082                	ret

ffffffffc0208172 <__alloc_inode>:
ffffffffc0208172:	1141                	addi	sp,sp,-16
ffffffffc0208174:	e022                	sd	s0,0(sp)
ffffffffc0208176:	842a                	mv	s0,a0
ffffffffc0208178:	07800513          	li	a0,120
ffffffffc020817c:	e406                	sd	ra,8(sp)
ffffffffc020817e:	b99f90ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0208182:	c111                	beqz	a0,ffffffffc0208186 <__alloc_inode+0x14>
ffffffffc0208184:	cd20                	sw	s0,88(a0)
ffffffffc0208186:	60a2                	ld	ra,8(sp)
ffffffffc0208188:	6402                	ld	s0,0(sp)
ffffffffc020818a:	0141                	addi	sp,sp,16
ffffffffc020818c:	8082                	ret

ffffffffc020818e <inode_init>:
ffffffffc020818e:	4785                	li	a5,1
ffffffffc0208190:	06052023          	sw	zero,96(a0)
ffffffffc0208194:	f92c                	sd	a1,112(a0)
ffffffffc0208196:	f530                	sd	a2,104(a0)
ffffffffc0208198:	cd7c                	sw	a5,92(a0)
ffffffffc020819a:	8082                	ret

ffffffffc020819c <inode_kill>:
ffffffffc020819c:	4d78                	lw	a4,92(a0)
ffffffffc020819e:	1141                	addi	sp,sp,-16
ffffffffc02081a0:	e406                	sd	ra,8(sp)
ffffffffc02081a2:	e719                	bnez	a4,ffffffffc02081b0 <inode_kill+0x14>
ffffffffc02081a4:	513c                	lw	a5,96(a0)
ffffffffc02081a6:	e78d                	bnez	a5,ffffffffc02081d0 <inode_kill+0x34>
ffffffffc02081a8:	60a2                	ld	ra,8(sp)
ffffffffc02081aa:	0141                	addi	sp,sp,16
ffffffffc02081ac:	c1bf906f          	j	ffffffffc0201dc6 <kfree>
ffffffffc02081b0:	00006697          	auipc	a3,0x6
ffffffffc02081b4:	45068693          	addi	a3,a3,1104 # ffffffffc020e600 <syscalls+0xbd8>
ffffffffc02081b8:	00003617          	auipc	a2,0x3
ffffffffc02081bc:	64060613          	addi	a2,a2,1600 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02081c0:	02900593          	li	a1,41
ffffffffc02081c4:	00006517          	auipc	a0,0x6
ffffffffc02081c8:	45c50513          	addi	a0,a0,1116 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc02081cc:	862f80ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02081d0:	00006697          	auipc	a3,0x6
ffffffffc02081d4:	46868693          	addi	a3,a3,1128 # ffffffffc020e638 <syscalls+0xc10>
ffffffffc02081d8:	00003617          	auipc	a2,0x3
ffffffffc02081dc:	62060613          	addi	a2,a2,1568 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02081e0:	02a00593          	li	a1,42
ffffffffc02081e4:	00006517          	auipc	a0,0x6
ffffffffc02081e8:	43c50513          	addi	a0,a0,1084 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc02081ec:	842f80ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02081f0 <inode_ref_inc>:
ffffffffc02081f0:	4d7c                	lw	a5,92(a0)
ffffffffc02081f2:	2785                	addiw	a5,a5,1
ffffffffc02081f4:	cd7c                	sw	a5,92(a0)
ffffffffc02081f6:	0007851b          	sext.w	a0,a5
ffffffffc02081fa:	8082                	ret

ffffffffc02081fc <inode_open_inc>:
ffffffffc02081fc:	513c                	lw	a5,96(a0)
ffffffffc02081fe:	2785                	addiw	a5,a5,1
ffffffffc0208200:	d13c                	sw	a5,96(a0)
ffffffffc0208202:	0007851b          	sext.w	a0,a5
ffffffffc0208206:	8082                	ret

ffffffffc0208208 <inode_check>:
ffffffffc0208208:	1141                	addi	sp,sp,-16
ffffffffc020820a:	e406                	sd	ra,8(sp)
ffffffffc020820c:	c90d                	beqz	a0,ffffffffc020823e <inode_check+0x36>
ffffffffc020820e:	793c                	ld	a5,112(a0)
ffffffffc0208210:	c79d                	beqz	a5,ffffffffc020823e <inode_check+0x36>
ffffffffc0208212:	6398                	ld	a4,0(a5)
ffffffffc0208214:	4625d7b7          	lui	a5,0x4625d
ffffffffc0208218:	0786                	slli	a5,a5,0x1
ffffffffc020821a:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc020821e:	08f71063          	bne	a4,a5,ffffffffc020829e <inode_check+0x96>
ffffffffc0208222:	4d78                	lw	a4,92(a0)
ffffffffc0208224:	513c                	lw	a5,96(a0)
ffffffffc0208226:	04f74c63          	blt	a4,a5,ffffffffc020827e <inode_check+0x76>
ffffffffc020822a:	0407ca63          	bltz	a5,ffffffffc020827e <inode_check+0x76>
ffffffffc020822e:	66c1                	lui	a3,0x10
ffffffffc0208230:	02d75763          	bge	a4,a3,ffffffffc020825e <inode_check+0x56>
ffffffffc0208234:	02d7d563          	bge	a5,a3,ffffffffc020825e <inode_check+0x56>
ffffffffc0208238:	60a2                	ld	ra,8(sp)
ffffffffc020823a:	0141                	addi	sp,sp,16
ffffffffc020823c:	8082                	ret
ffffffffc020823e:	00006697          	auipc	a3,0x6
ffffffffc0208242:	41a68693          	addi	a3,a3,1050 # ffffffffc020e658 <syscalls+0xc30>
ffffffffc0208246:	00003617          	auipc	a2,0x3
ffffffffc020824a:	5b260613          	addi	a2,a2,1458 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020824e:	06e00593          	li	a1,110
ffffffffc0208252:	00006517          	auipc	a0,0x6
ffffffffc0208256:	3ce50513          	addi	a0,a0,974 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc020825a:	fd5f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020825e:	00006697          	auipc	a3,0x6
ffffffffc0208262:	47a68693          	addi	a3,a3,1146 # ffffffffc020e6d8 <syscalls+0xcb0>
ffffffffc0208266:	00003617          	auipc	a2,0x3
ffffffffc020826a:	59260613          	addi	a2,a2,1426 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020826e:	07200593          	li	a1,114
ffffffffc0208272:	00006517          	auipc	a0,0x6
ffffffffc0208276:	3ae50513          	addi	a0,a0,942 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc020827a:	fb5f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020827e:	00006697          	auipc	a3,0x6
ffffffffc0208282:	42a68693          	addi	a3,a3,1066 # ffffffffc020e6a8 <syscalls+0xc80>
ffffffffc0208286:	00003617          	auipc	a2,0x3
ffffffffc020828a:	57260613          	addi	a2,a2,1394 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020828e:	07100593          	li	a1,113
ffffffffc0208292:	00006517          	auipc	a0,0x6
ffffffffc0208296:	38e50513          	addi	a0,a0,910 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc020829a:	f95f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020829e:	00006697          	auipc	a3,0x6
ffffffffc02082a2:	3e268693          	addi	a3,a3,994 # ffffffffc020e680 <syscalls+0xc58>
ffffffffc02082a6:	00003617          	auipc	a2,0x3
ffffffffc02082aa:	55260613          	addi	a2,a2,1362 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02082ae:	06f00593          	li	a1,111
ffffffffc02082b2:	00006517          	auipc	a0,0x6
ffffffffc02082b6:	36e50513          	addi	a0,a0,878 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc02082ba:	f75f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02082be <inode_ref_dec>:
ffffffffc02082be:	4d7c                	lw	a5,92(a0)
ffffffffc02082c0:	1101                	addi	sp,sp,-32
ffffffffc02082c2:	ec06                	sd	ra,24(sp)
ffffffffc02082c4:	e822                	sd	s0,16(sp)
ffffffffc02082c6:	e426                	sd	s1,8(sp)
ffffffffc02082c8:	e04a                	sd	s2,0(sp)
ffffffffc02082ca:	06f05e63          	blez	a5,ffffffffc0208346 <inode_ref_dec+0x88>
ffffffffc02082ce:	fff7849b          	addiw	s1,a5,-1
ffffffffc02082d2:	cd64                	sw	s1,92(a0)
ffffffffc02082d4:	842a                	mv	s0,a0
ffffffffc02082d6:	e09d                	bnez	s1,ffffffffc02082fc <inode_ref_dec+0x3e>
ffffffffc02082d8:	793c                	ld	a5,112(a0)
ffffffffc02082da:	c7b1                	beqz	a5,ffffffffc0208326 <inode_ref_dec+0x68>
ffffffffc02082dc:	0487b903          	ld	s2,72(a5)
ffffffffc02082e0:	04090363          	beqz	s2,ffffffffc0208326 <inode_ref_dec+0x68>
ffffffffc02082e4:	00006597          	auipc	a1,0x6
ffffffffc02082e8:	4a458593          	addi	a1,a1,1188 # ffffffffc020e788 <syscalls+0xd60>
ffffffffc02082ec:	f1dff0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02082f0:	8522                	mv	a0,s0
ffffffffc02082f2:	9902                	jalr	s2
ffffffffc02082f4:	c501                	beqz	a0,ffffffffc02082fc <inode_ref_dec+0x3e>
ffffffffc02082f6:	57c5                	li	a5,-15
ffffffffc02082f8:	00f51963          	bne	a0,a5,ffffffffc020830a <inode_ref_dec+0x4c>
ffffffffc02082fc:	60e2                	ld	ra,24(sp)
ffffffffc02082fe:	6442                	ld	s0,16(sp)
ffffffffc0208300:	6902                	ld	s2,0(sp)
ffffffffc0208302:	8526                	mv	a0,s1
ffffffffc0208304:	64a2                	ld	s1,8(sp)
ffffffffc0208306:	6105                	addi	sp,sp,32
ffffffffc0208308:	8082                	ret
ffffffffc020830a:	85aa                	mv	a1,a0
ffffffffc020830c:	00006517          	auipc	a0,0x6
ffffffffc0208310:	48450513          	addi	a0,a0,1156 # ffffffffc020e790 <syscalls+0xd68>
ffffffffc0208314:	e17f70ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0208318:	60e2                	ld	ra,24(sp)
ffffffffc020831a:	6442                	ld	s0,16(sp)
ffffffffc020831c:	6902                	ld	s2,0(sp)
ffffffffc020831e:	8526                	mv	a0,s1
ffffffffc0208320:	64a2                	ld	s1,8(sp)
ffffffffc0208322:	6105                	addi	sp,sp,32
ffffffffc0208324:	8082                	ret
ffffffffc0208326:	00006697          	auipc	a3,0x6
ffffffffc020832a:	41268693          	addi	a3,a3,1042 # ffffffffc020e738 <syscalls+0xd10>
ffffffffc020832e:	00003617          	auipc	a2,0x3
ffffffffc0208332:	4ca60613          	addi	a2,a2,1226 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208336:	04400593          	li	a1,68
ffffffffc020833a:	00006517          	auipc	a0,0x6
ffffffffc020833e:	2e650513          	addi	a0,a0,742 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc0208342:	eedf70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208346:	00006697          	auipc	a3,0x6
ffffffffc020834a:	3d268693          	addi	a3,a3,978 # ffffffffc020e718 <syscalls+0xcf0>
ffffffffc020834e:	00003617          	auipc	a2,0x3
ffffffffc0208352:	4aa60613          	addi	a2,a2,1194 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208356:	03f00593          	li	a1,63
ffffffffc020835a:	00006517          	auipc	a0,0x6
ffffffffc020835e:	2c650513          	addi	a0,a0,710 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc0208362:	ecdf70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208366 <inode_open_dec>:
ffffffffc0208366:	513c                	lw	a5,96(a0)
ffffffffc0208368:	1101                	addi	sp,sp,-32
ffffffffc020836a:	ec06                	sd	ra,24(sp)
ffffffffc020836c:	e822                	sd	s0,16(sp)
ffffffffc020836e:	e426                	sd	s1,8(sp)
ffffffffc0208370:	e04a                	sd	s2,0(sp)
ffffffffc0208372:	06f05b63          	blez	a5,ffffffffc02083e8 <inode_open_dec+0x82>
ffffffffc0208376:	fff7849b          	addiw	s1,a5,-1
ffffffffc020837a:	d124                	sw	s1,96(a0)
ffffffffc020837c:	842a                	mv	s0,a0
ffffffffc020837e:	e085                	bnez	s1,ffffffffc020839e <inode_open_dec+0x38>
ffffffffc0208380:	793c                	ld	a5,112(a0)
ffffffffc0208382:	c3b9                	beqz	a5,ffffffffc02083c8 <inode_open_dec+0x62>
ffffffffc0208384:	0107b903          	ld	s2,16(a5)
ffffffffc0208388:	04090063          	beqz	s2,ffffffffc02083c8 <inode_open_dec+0x62>
ffffffffc020838c:	00006597          	auipc	a1,0x6
ffffffffc0208390:	49458593          	addi	a1,a1,1172 # ffffffffc020e820 <syscalls+0xdf8>
ffffffffc0208394:	e75ff0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0208398:	8522                	mv	a0,s0
ffffffffc020839a:	9902                	jalr	s2
ffffffffc020839c:	e901                	bnez	a0,ffffffffc02083ac <inode_open_dec+0x46>
ffffffffc020839e:	60e2                	ld	ra,24(sp)
ffffffffc02083a0:	6442                	ld	s0,16(sp)
ffffffffc02083a2:	6902                	ld	s2,0(sp)
ffffffffc02083a4:	8526                	mv	a0,s1
ffffffffc02083a6:	64a2                	ld	s1,8(sp)
ffffffffc02083a8:	6105                	addi	sp,sp,32
ffffffffc02083aa:	8082                	ret
ffffffffc02083ac:	85aa                	mv	a1,a0
ffffffffc02083ae:	00006517          	auipc	a0,0x6
ffffffffc02083b2:	47a50513          	addi	a0,a0,1146 # ffffffffc020e828 <syscalls+0xe00>
ffffffffc02083b6:	d75f70ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02083ba:	60e2                	ld	ra,24(sp)
ffffffffc02083bc:	6442                	ld	s0,16(sp)
ffffffffc02083be:	6902                	ld	s2,0(sp)
ffffffffc02083c0:	8526                	mv	a0,s1
ffffffffc02083c2:	64a2                	ld	s1,8(sp)
ffffffffc02083c4:	6105                	addi	sp,sp,32
ffffffffc02083c6:	8082                	ret
ffffffffc02083c8:	00006697          	auipc	a3,0x6
ffffffffc02083cc:	40868693          	addi	a3,a3,1032 # ffffffffc020e7d0 <syscalls+0xda8>
ffffffffc02083d0:	00003617          	auipc	a2,0x3
ffffffffc02083d4:	42860613          	addi	a2,a2,1064 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02083d8:	06100593          	li	a1,97
ffffffffc02083dc:	00006517          	auipc	a0,0x6
ffffffffc02083e0:	24450513          	addi	a0,a0,580 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc02083e4:	e4bf70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02083e8:	00006697          	auipc	a3,0x6
ffffffffc02083ec:	3c868693          	addi	a3,a3,968 # ffffffffc020e7b0 <syscalls+0xd88>
ffffffffc02083f0:	00003617          	auipc	a2,0x3
ffffffffc02083f4:	40860613          	addi	a2,a2,1032 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02083f8:	05c00593          	li	a1,92
ffffffffc02083fc:	00006517          	auipc	a0,0x6
ffffffffc0208400:	22450513          	addi	a0,a0,548 # ffffffffc020e620 <syscalls+0xbf8>
ffffffffc0208404:	e2bf70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208408 <__alloc_fs>:
ffffffffc0208408:	1141                	addi	sp,sp,-16
ffffffffc020840a:	e022                	sd	s0,0(sp)
ffffffffc020840c:	842a                	mv	s0,a0
ffffffffc020840e:	0d800513          	li	a0,216
ffffffffc0208412:	e406                	sd	ra,8(sp)
ffffffffc0208414:	903f90ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0208418:	c119                	beqz	a0,ffffffffc020841e <__alloc_fs+0x16>
ffffffffc020841a:	0a852823          	sw	s0,176(a0)
ffffffffc020841e:	60a2                	ld	ra,8(sp)
ffffffffc0208420:	6402                	ld	s0,0(sp)
ffffffffc0208422:	0141                	addi	sp,sp,16
ffffffffc0208424:	8082                	ret

ffffffffc0208426 <vfs_init>:
ffffffffc0208426:	1141                	addi	sp,sp,-16
ffffffffc0208428:	4585                	li	a1,1
ffffffffc020842a:	0008d517          	auipc	a0,0x8d
ffffffffc020842e:	3fe50513          	addi	a0,a0,1022 # ffffffffc0295828 <bootfs_sem>
ffffffffc0208432:	e406                	sd	ra,8(sp)
ffffffffc0208434:	b0afc0ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc0208438:	60a2                	ld	ra,8(sp)
ffffffffc020843a:	0141                	addi	sp,sp,16
ffffffffc020843c:	d0aff06f          	j	ffffffffc0207946 <vfs_devlist_init>

ffffffffc0208440 <vfs_set_bootfs>:
ffffffffc0208440:	7179                	addi	sp,sp,-48
ffffffffc0208442:	f022                	sd	s0,32(sp)
ffffffffc0208444:	f406                	sd	ra,40(sp)
ffffffffc0208446:	ec26                	sd	s1,24(sp)
ffffffffc0208448:	e402                	sd	zero,8(sp)
ffffffffc020844a:	842a                	mv	s0,a0
ffffffffc020844c:	c915                	beqz	a0,ffffffffc0208480 <vfs_set_bootfs+0x40>
ffffffffc020844e:	03a00593          	li	a1,58
ffffffffc0208452:	38d020ef          	jal	ra,ffffffffc020afde <strchr>
ffffffffc0208456:	c135                	beqz	a0,ffffffffc02084ba <vfs_set_bootfs+0x7a>
ffffffffc0208458:	00154783          	lbu	a5,1(a0)
ffffffffc020845c:	efb9                	bnez	a5,ffffffffc02084ba <vfs_set_bootfs+0x7a>
ffffffffc020845e:	8522                	mv	a0,s0
ffffffffc0208460:	86bff0ef          	jal	ra,ffffffffc0207cca <vfs_chdir>
ffffffffc0208464:	842a                	mv	s0,a0
ffffffffc0208466:	c519                	beqz	a0,ffffffffc0208474 <vfs_set_bootfs+0x34>
ffffffffc0208468:	70a2                	ld	ra,40(sp)
ffffffffc020846a:	8522                	mv	a0,s0
ffffffffc020846c:	7402                	ld	s0,32(sp)
ffffffffc020846e:	64e2                	ld	s1,24(sp)
ffffffffc0208470:	6145                	addi	sp,sp,48
ffffffffc0208472:	8082                	ret
ffffffffc0208474:	0028                	addi	a0,sp,8
ffffffffc0208476:	f5eff0ef          	jal	ra,ffffffffc0207bd4 <vfs_get_curdir>
ffffffffc020847a:	842a                	mv	s0,a0
ffffffffc020847c:	f575                	bnez	a0,ffffffffc0208468 <vfs_set_bootfs+0x28>
ffffffffc020847e:	6422                	ld	s0,8(sp)
ffffffffc0208480:	0008d517          	auipc	a0,0x8d
ffffffffc0208484:	3a850513          	addi	a0,a0,936 # ffffffffc0295828 <bootfs_sem>
ffffffffc0208488:	ac2fc0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020848c:	0008e797          	auipc	a5,0x8e
ffffffffc0208490:	46478793          	addi	a5,a5,1124 # ffffffffc02968f0 <bootfs_node>
ffffffffc0208494:	6384                	ld	s1,0(a5)
ffffffffc0208496:	0008d517          	auipc	a0,0x8d
ffffffffc020849a:	39250513          	addi	a0,a0,914 # ffffffffc0295828 <bootfs_sem>
ffffffffc020849e:	e380                	sd	s0,0(a5)
ffffffffc02084a0:	4401                	li	s0,0
ffffffffc02084a2:	aa4fc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc02084a6:	d0e9                	beqz	s1,ffffffffc0208468 <vfs_set_bootfs+0x28>
ffffffffc02084a8:	8526                	mv	a0,s1
ffffffffc02084aa:	e15ff0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc02084ae:	70a2                	ld	ra,40(sp)
ffffffffc02084b0:	8522                	mv	a0,s0
ffffffffc02084b2:	7402                	ld	s0,32(sp)
ffffffffc02084b4:	64e2                	ld	s1,24(sp)
ffffffffc02084b6:	6145                	addi	sp,sp,48
ffffffffc02084b8:	8082                	ret
ffffffffc02084ba:	5475                	li	s0,-3
ffffffffc02084bc:	b775                	j	ffffffffc0208468 <vfs_set_bootfs+0x28>

ffffffffc02084be <vfs_get_bootfs>:
ffffffffc02084be:	1101                	addi	sp,sp,-32
ffffffffc02084c0:	e426                	sd	s1,8(sp)
ffffffffc02084c2:	0008e497          	auipc	s1,0x8e
ffffffffc02084c6:	42e48493          	addi	s1,s1,1070 # ffffffffc02968f0 <bootfs_node>
ffffffffc02084ca:	609c                	ld	a5,0(s1)
ffffffffc02084cc:	ec06                	sd	ra,24(sp)
ffffffffc02084ce:	e822                	sd	s0,16(sp)
ffffffffc02084d0:	c3a1                	beqz	a5,ffffffffc0208510 <vfs_get_bootfs+0x52>
ffffffffc02084d2:	842a                	mv	s0,a0
ffffffffc02084d4:	0008d517          	auipc	a0,0x8d
ffffffffc02084d8:	35450513          	addi	a0,a0,852 # ffffffffc0295828 <bootfs_sem>
ffffffffc02084dc:	a6efc0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc02084e0:	6084                	ld	s1,0(s1)
ffffffffc02084e2:	c08d                	beqz	s1,ffffffffc0208504 <vfs_get_bootfs+0x46>
ffffffffc02084e4:	8526                	mv	a0,s1
ffffffffc02084e6:	d0bff0ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc02084ea:	0008d517          	auipc	a0,0x8d
ffffffffc02084ee:	33e50513          	addi	a0,a0,830 # ffffffffc0295828 <bootfs_sem>
ffffffffc02084f2:	a54fc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc02084f6:	4501                	li	a0,0
ffffffffc02084f8:	e004                	sd	s1,0(s0)
ffffffffc02084fa:	60e2                	ld	ra,24(sp)
ffffffffc02084fc:	6442                	ld	s0,16(sp)
ffffffffc02084fe:	64a2                	ld	s1,8(sp)
ffffffffc0208500:	6105                	addi	sp,sp,32
ffffffffc0208502:	8082                	ret
ffffffffc0208504:	0008d517          	auipc	a0,0x8d
ffffffffc0208508:	32450513          	addi	a0,a0,804 # ffffffffc0295828 <bootfs_sem>
ffffffffc020850c:	a3afc0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0208510:	5541                	li	a0,-16
ffffffffc0208512:	b7e5                	j	ffffffffc02084fa <vfs_get_bootfs+0x3c>

ffffffffc0208514 <stdin_open>:
ffffffffc0208514:	4501                	li	a0,0
ffffffffc0208516:	e191                	bnez	a1,ffffffffc020851a <stdin_open+0x6>
ffffffffc0208518:	8082                	ret
ffffffffc020851a:	5575                	li	a0,-3
ffffffffc020851c:	8082                	ret

ffffffffc020851e <stdin_close>:
ffffffffc020851e:	4501                	li	a0,0
ffffffffc0208520:	8082                	ret

ffffffffc0208522 <stdin_ioctl>:
ffffffffc0208522:	5575                	li	a0,-3
ffffffffc0208524:	8082                	ret

ffffffffc0208526 <stdin_io>:
ffffffffc0208526:	7135                	addi	sp,sp,-160
ffffffffc0208528:	ed06                	sd	ra,152(sp)
ffffffffc020852a:	e922                	sd	s0,144(sp)
ffffffffc020852c:	e526                	sd	s1,136(sp)
ffffffffc020852e:	e14a                	sd	s2,128(sp)
ffffffffc0208530:	fcce                	sd	s3,120(sp)
ffffffffc0208532:	f8d2                	sd	s4,112(sp)
ffffffffc0208534:	f4d6                	sd	s5,104(sp)
ffffffffc0208536:	f0da                	sd	s6,96(sp)
ffffffffc0208538:	ecde                	sd	s7,88(sp)
ffffffffc020853a:	e8e2                	sd	s8,80(sp)
ffffffffc020853c:	e4e6                	sd	s9,72(sp)
ffffffffc020853e:	e0ea                	sd	s10,64(sp)
ffffffffc0208540:	fc6e                	sd	s11,56(sp)
ffffffffc0208542:	14061163          	bnez	a2,ffffffffc0208684 <stdin_io+0x15e>
ffffffffc0208546:	0005bd83          	ld	s11,0(a1)
ffffffffc020854a:	0185bd03          	ld	s10,24(a1)
ffffffffc020854e:	8b2e                	mv	s6,a1
ffffffffc0208550:	100027f3          	csrr	a5,sstatus
ffffffffc0208554:	8b89                	andi	a5,a5,2
ffffffffc0208556:	10079e63          	bnez	a5,ffffffffc0208672 <stdin_io+0x14c>
ffffffffc020855a:	4401                	li	s0,0
ffffffffc020855c:	100d0963          	beqz	s10,ffffffffc020866e <stdin_io+0x148>
ffffffffc0208560:	0008e997          	auipc	s3,0x8e
ffffffffc0208564:	39898993          	addi	s3,s3,920 # ffffffffc02968f8 <p_rpos>
ffffffffc0208568:	0009b783          	ld	a5,0(s3)
ffffffffc020856c:	800004b7          	lui	s1,0x80000
ffffffffc0208570:	6c85                	lui	s9,0x1
ffffffffc0208572:	4a81                	li	s5,0
ffffffffc0208574:	0008ea17          	auipc	s4,0x8e
ffffffffc0208578:	38ca0a13          	addi	s4,s4,908 # ffffffffc0296900 <p_wpos>
ffffffffc020857c:	0491                	addi	s1,s1,4
ffffffffc020857e:	0008d917          	auipc	s2,0x8d
ffffffffc0208582:	2c290913          	addi	s2,s2,706 # ffffffffc0295840 <__wait_queue>
ffffffffc0208586:	1cfd                	addi	s9,s9,-1
ffffffffc0208588:	000a3703          	ld	a4,0(s4)
ffffffffc020858c:	000a8c1b          	sext.w	s8,s5
ffffffffc0208590:	8be2                	mv	s7,s8
ffffffffc0208592:	02e7d763          	bge	a5,a4,ffffffffc02085c0 <stdin_io+0x9a>
ffffffffc0208596:	a859                	j	ffffffffc020862c <stdin_io+0x106>
ffffffffc0208598:	cd7fe0ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc020859c:	100027f3          	csrr	a5,sstatus
ffffffffc02085a0:	8b89                	andi	a5,a5,2
ffffffffc02085a2:	4401                	li	s0,0
ffffffffc02085a4:	ef8d                	bnez	a5,ffffffffc02085de <stdin_io+0xb8>
ffffffffc02085a6:	0028                	addi	a0,sp,8
ffffffffc02085a8:	ed3fb0ef          	jal	ra,ffffffffc020447a <wait_in_queue>
ffffffffc02085ac:	e121                	bnez	a0,ffffffffc02085ec <stdin_io+0xc6>
ffffffffc02085ae:	47c2                	lw	a5,16(sp)
ffffffffc02085b0:	04979563          	bne	a5,s1,ffffffffc02085fa <stdin_io+0xd4>
ffffffffc02085b4:	0009b783          	ld	a5,0(s3)
ffffffffc02085b8:	000a3703          	ld	a4,0(s4)
ffffffffc02085bc:	06e7c863          	blt	a5,a4,ffffffffc020862c <stdin_io+0x106>
ffffffffc02085c0:	8626                	mv	a2,s1
ffffffffc02085c2:	002c                	addi	a1,sp,8
ffffffffc02085c4:	854a                	mv	a0,s2
ffffffffc02085c6:	fdffb0ef          	jal	ra,ffffffffc02045a4 <wait_current_set>
ffffffffc02085ca:	d479                	beqz	s0,ffffffffc0208598 <stdin_io+0x72>
ffffffffc02085cc:	fd2f80ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc02085d0:	c9ffe0ef          	jal	ra,ffffffffc020726e <schedule>
ffffffffc02085d4:	100027f3          	csrr	a5,sstatus
ffffffffc02085d8:	8b89                	andi	a5,a5,2
ffffffffc02085da:	4401                	li	s0,0
ffffffffc02085dc:	d7e9                	beqz	a5,ffffffffc02085a6 <stdin_io+0x80>
ffffffffc02085de:	fc6f80ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc02085e2:	0028                	addi	a0,sp,8
ffffffffc02085e4:	4405                	li	s0,1
ffffffffc02085e6:	e95fb0ef          	jal	ra,ffffffffc020447a <wait_in_queue>
ffffffffc02085ea:	d171                	beqz	a0,ffffffffc02085ae <stdin_io+0x88>
ffffffffc02085ec:	002c                	addi	a1,sp,8
ffffffffc02085ee:	854a                	mv	a0,s2
ffffffffc02085f0:	e31fb0ef          	jal	ra,ffffffffc0204420 <wait_queue_del>
ffffffffc02085f4:	47c2                	lw	a5,16(sp)
ffffffffc02085f6:	fa978fe3          	beq	a5,s1,ffffffffc02085b4 <stdin_io+0x8e>
ffffffffc02085fa:	e435                	bnez	s0,ffffffffc0208666 <stdin_io+0x140>
ffffffffc02085fc:	060b8963          	beqz	s7,ffffffffc020866e <stdin_io+0x148>
ffffffffc0208600:	018b3783          	ld	a5,24(s6)
ffffffffc0208604:	41578ab3          	sub	s5,a5,s5
ffffffffc0208608:	015b3c23          	sd	s5,24(s6)
ffffffffc020860c:	60ea                	ld	ra,152(sp)
ffffffffc020860e:	644a                	ld	s0,144(sp)
ffffffffc0208610:	64aa                	ld	s1,136(sp)
ffffffffc0208612:	690a                	ld	s2,128(sp)
ffffffffc0208614:	79e6                	ld	s3,120(sp)
ffffffffc0208616:	7a46                	ld	s4,112(sp)
ffffffffc0208618:	7aa6                	ld	s5,104(sp)
ffffffffc020861a:	7b06                	ld	s6,96(sp)
ffffffffc020861c:	6c46                	ld	s8,80(sp)
ffffffffc020861e:	6ca6                	ld	s9,72(sp)
ffffffffc0208620:	6d06                	ld	s10,64(sp)
ffffffffc0208622:	7de2                	ld	s11,56(sp)
ffffffffc0208624:	855e                	mv	a0,s7
ffffffffc0208626:	6be6                	ld	s7,88(sp)
ffffffffc0208628:	610d                	addi	sp,sp,160
ffffffffc020862a:	8082                	ret
ffffffffc020862c:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208630:	03475693          	srli	a3,a4,0x34
ffffffffc0208634:	00d78733          	add	a4,a5,a3
ffffffffc0208638:	01977733          	and	a4,a4,s9
ffffffffc020863c:	8f15                	sub	a4,a4,a3
ffffffffc020863e:	0008d697          	auipc	a3,0x8d
ffffffffc0208642:	21268693          	addi	a3,a3,530 # ffffffffc0295850 <stdin_buffer>
ffffffffc0208646:	9736                	add	a4,a4,a3
ffffffffc0208648:	00074683          	lbu	a3,0(a4)
ffffffffc020864c:	0785                	addi	a5,a5,1
ffffffffc020864e:	015d8733          	add	a4,s11,s5
ffffffffc0208652:	00d70023          	sb	a3,0(a4)
ffffffffc0208656:	00f9b023          	sd	a5,0(s3)
ffffffffc020865a:	0a85                	addi	s5,s5,1
ffffffffc020865c:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208660:	f3aae4e3          	bltu	s5,s10,ffffffffc0208588 <stdin_io+0x62>
ffffffffc0208664:	dc51                	beqz	s0,ffffffffc0208600 <stdin_io+0xda>
ffffffffc0208666:	f38f80ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc020866a:	f80b9be3          	bnez	s7,ffffffffc0208600 <stdin_io+0xda>
ffffffffc020866e:	4b81                	li	s7,0
ffffffffc0208670:	bf71                	j	ffffffffc020860c <stdin_io+0xe6>
ffffffffc0208672:	f32f80ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0208676:	4405                	li	s0,1
ffffffffc0208678:	ee0d14e3          	bnez	s10,ffffffffc0208560 <stdin_io+0x3a>
ffffffffc020867c:	f22f80ef          	jal	ra,ffffffffc0200d9e <intr_enable>
ffffffffc0208680:	4b81                	li	s7,0
ffffffffc0208682:	b769                	j	ffffffffc020860c <stdin_io+0xe6>
ffffffffc0208684:	5bf5                	li	s7,-3
ffffffffc0208686:	b759                	j	ffffffffc020860c <stdin_io+0xe6>

ffffffffc0208688 <dev_stdin_write>:
ffffffffc0208688:	e111                	bnez	a0,ffffffffc020868c <dev_stdin_write+0x4>
ffffffffc020868a:	8082                	ret
ffffffffc020868c:	1101                	addi	sp,sp,-32
ffffffffc020868e:	e822                	sd	s0,16(sp)
ffffffffc0208690:	ec06                	sd	ra,24(sp)
ffffffffc0208692:	e426                	sd	s1,8(sp)
ffffffffc0208694:	842a                	mv	s0,a0
ffffffffc0208696:	100027f3          	csrr	a5,sstatus
ffffffffc020869a:	8b89                	andi	a5,a5,2
ffffffffc020869c:	4481                	li	s1,0
ffffffffc020869e:	e3c1                	bnez	a5,ffffffffc020871e <dev_stdin_write+0x96>
ffffffffc02086a0:	0008e597          	auipc	a1,0x8e
ffffffffc02086a4:	26058593          	addi	a1,a1,608 # ffffffffc0296900 <p_wpos>
ffffffffc02086a8:	6198                	ld	a4,0(a1)
ffffffffc02086aa:	6605                	lui	a2,0x1
ffffffffc02086ac:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc02086b0:	43f75693          	srai	a3,a4,0x3f
ffffffffc02086b4:	92d1                	srli	a3,a3,0x34
ffffffffc02086b6:	00d707b3          	add	a5,a4,a3
ffffffffc02086ba:	8fe9                	and	a5,a5,a0
ffffffffc02086bc:	8f95                	sub	a5,a5,a3
ffffffffc02086be:	0008d697          	auipc	a3,0x8d
ffffffffc02086c2:	19268693          	addi	a3,a3,402 # ffffffffc0295850 <stdin_buffer>
ffffffffc02086c6:	97b6                	add	a5,a5,a3
ffffffffc02086c8:	00878023          	sb	s0,0(a5)
ffffffffc02086cc:	0008e797          	auipc	a5,0x8e
ffffffffc02086d0:	22c7b783          	ld	a5,556(a5) # ffffffffc02968f8 <p_rpos>
ffffffffc02086d4:	40f707b3          	sub	a5,a4,a5
ffffffffc02086d8:	00c7d463          	bge	a5,a2,ffffffffc02086e0 <dev_stdin_write+0x58>
ffffffffc02086dc:	0705                	addi	a4,a4,1
ffffffffc02086de:	e198                	sd	a4,0(a1)
ffffffffc02086e0:	0008d517          	auipc	a0,0x8d
ffffffffc02086e4:	16050513          	addi	a0,a0,352 # ffffffffc0295840 <__wait_queue>
ffffffffc02086e8:	d87fb0ef          	jal	ra,ffffffffc020446e <wait_queue_empty>
ffffffffc02086ec:	cd09                	beqz	a0,ffffffffc0208706 <dev_stdin_write+0x7e>
ffffffffc02086ee:	e491                	bnez	s1,ffffffffc02086fa <dev_stdin_write+0x72>
ffffffffc02086f0:	60e2                	ld	ra,24(sp)
ffffffffc02086f2:	6442                	ld	s0,16(sp)
ffffffffc02086f4:	64a2                	ld	s1,8(sp)
ffffffffc02086f6:	6105                	addi	sp,sp,32
ffffffffc02086f8:	8082                	ret
ffffffffc02086fa:	6442                	ld	s0,16(sp)
ffffffffc02086fc:	60e2                	ld	ra,24(sp)
ffffffffc02086fe:	64a2                	ld	s1,8(sp)
ffffffffc0208700:	6105                	addi	sp,sp,32
ffffffffc0208702:	e9cf806f          	j	ffffffffc0200d9e <intr_enable>
ffffffffc0208706:	800005b7          	lui	a1,0x80000
ffffffffc020870a:	4605                	li	a2,1
ffffffffc020870c:	0591                	addi	a1,a1,4
ffffffffc020870e:	0008d517          	auipc	a0,0x8d
ffffffffc0208712:	13250513          	addi	a0,a0,306 # ffffffffc0295840 <__wait_queue>
ffffffffc0208716:	dc1fb0ef          	jal	ra,ffffffffc02044d6 <wakeup_queue>
ffffffffc020871a:	d8f9                	beqz	s1,ffffffffc02086f0 <dev_stdin_write+0x68>
ffffffffc020871c:	bff9                	j	ffffffffc02086fa <dev_stdin_write+0x72>
ffffffffc020871e:	e86f80ef          	jal	ra,ffffffffc0200da4 <intr_disable>
ffffffffc0208722:	4485                	li	s1,1
ffffffffc0208724:	bfb5                	j	ffffffffc02086a0 <dev_stdin_write+0x18>

ffffffffc0208726 <dev_init_stdin>:
ffffffffc0208726:	1141                	addi	sp,sp,-16
ffffffffc0208728:	e406                	sd	ra,8(sp)
ffffffffc020872a:	e022                	sd	s0,0(sp)
ffffffffc020872c:	74a000ef          	jal	ra,ffffffffc0208e76 <dev_create_inode>
ffffffffc0208730:	c93d                	beqz	a0,ffffffffc02087a6 <dev_init_stdin+0x80>
ffffffffc0208732:	4d38                	lw	a4,88(a0)
ffffffffc0208734:	6785                	lui	a5,0x1
ffffffffc0208736:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020873a:	842a                	mv	s0,a0
ffffffffc020873c:	08f71e63          	bne	a4,a5,ffffffffc02087d8 <dev_init_stdin+0xb2>
ffffffffc0208740:	4785                	li	a5,1
ffffffffc0208742:	e41c                	sd	a5,8(s0)
ffffffffc0208744:	00000797          	auipc	a5,0x0
ffffffffc0208748:	dd078793          	addi	a5,a5,-560 # ffffffffc0208514 <stdin_open>
ffffffffc020874c:	e81c                	sd	a5,16(s0)
ffffffffc020874e:	00000797          	auipc	a5,0x0
ffffffffc0208752:	dd078793          	addi	a5,a5,-560 # ffffffffc020851e <stdin_close>
ffffffffc0208756:	ec1c                	sd	a5,24(s0)
ffffffffc0208758:	00000797          	auipc	a5,0x0
ffffffffc020875c:	dce78793          	addi	a5,a5,-562 # ffffffffc0208526 <stdin_io>
ffffffffc0208760:	f01c                	sd	a5,32(s0)
ffffffffc0208762:	00000797          	auipc	a5,0x0
ffffffffc0208766:	dc078793          	addi	a5,a5,-576 # ffffffffc0208522 <stdin_ioctl>
ffffffffc020876a:	f41c                	sd	a5,40(s0)
ffffffffc020876c:	0008d517          	auipc	a0,0x8d
ffffffffc0208770:	0d450513          	addi	a0,a0,212 # ffffffffc0295840 <__wait_queue>
ffffffffc0208774:	00043023          	sd	zero,0(s0)
ffffffffc0208778:	0008e797          	auipc	a5,0x8e
ffffffffc020877c:	1807b423          	sd	zero,392(a5) # ffffffffc0296900 <p_wpos>
ffffffffc0208780:	0008e797          	auipc	a5,0x8e
ffffffffc0208784:	1607bc23          	sd	zero,376(a5) # ffffffffc02968f8 <p_rpos>
ffffffffc0208788:	c93fb0ef          	jal	ra,ffffffffc020441a <wait_queue_init>
ffffffffc020878c:	4601                	li	a2,0
ffffffffc020878e:	85a2                	mv	a1,s0
ffffffffc0208790:	00006517          	auipc	a0,0x6
ffffffffc0208794:	0f850513          	addi	a0,a0,248 # ffffffffc020e888 <syscalls+0xe60>
ffffffffc0208798:	b20ff0ef          	jal	ra,ffffffffc0207ab8 <vfs_add_dev>
ffffffffc020879c:	e10d                	bnez	a0,ffffffffc02087be <dev_init_stdin+0x98>
ffffffffc020879e:	60a2                	ld	ra,8(sp)
ffffffffc02087a0:	6402                	ld	s0,0(sp)
ffffffffc02087a2:	0141                	addi	sp,sp,16
ffffffffc02087a4:	8082                	ret
ffffffffc02087a6:	00006617          	auipc	a2,0x6
ffffffffc02087aa:	0a260613          	addi	a2,a2,162 # ffffffffc020e848 <syscalls+0xe20>
ffffffffc02087ae:	07500593          	li	a1,117
ffffffffc02087b2:	00006517          	auipc	a0,0x6
ffffffffc02087b6:	0b650513          	addi	a0,a0,182 # ffffffffc020e868 <syscalls+0xe40>
ffffffffc02087ba:	a75f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02087be:	86aa                	mv	a3,a0
ffffffffc02087c0:	00006617          	auipc	a2,0x6
ffffffffc02087c4:	0d060613          	addi	a2,a2,208 # ffffffffc020e890 <syscalls+0xe68>
ffffffffc02087c8:	07b00593          	li	a1,123
ffffffffc02087cc:	00006517          	auipc	a0,0x6
ffffffffc02087d0:	09c50513          	addi	a0,a0,156 # ffffffffc020e868 <syscalls+0xe40>
ffffffffc02087d4:	a5bf70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02087d8:	00006697          	auipc	a3,0x6
ffffffffc02087dc:	b1868693          	addi	a3,a3,-1256 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc02087e0:	00003617          	auipc	a2,0x3
ffffffffc02087e4:	01860613          	addi	a2,a2,24 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02087e8:	07700593          	li	a1,119
ffffffffc02087ec:	00006517          	auipc	a0,0x6
ffffffffc02087f0:	07c50513          	addi	a0,a0,124 # ffffffffc020e868 <syscalls+0xe40>
ffffffffc02087f4:	a3bf70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02087f8 <disk0_open>:
ffffffffc02087f8:	4501                	li	a0,0
ffffffffc02087fa:	8082                	ret

ffffffffc02087fc <disk0_close>:
ffffffffc02087fc:	4501                	li	a0,0
ffffffffc02087fe:	8082                	ret

ffffffffc0208800 <disk0_ioctl>:
ffffffffc0208800:	5531                	li	a0,-20
ffffffffc0208802:	8082                	ret

ffffffffc0208804 <disk0_io>:
ffffffffc0208804:	659c                	ld	a5,8(a1)
ffffffffc0208806:	7159                	addi	sp,sp,-112
ffffffffc0208808:	eca6                	sd	s1,88(sp)
ffffffffc020880a:	f45e                	sd	s7,40(sp)
ffffffffc020880c:	6d84                	ld	s1,24(a1)
ffffffffc020880e:	6b85                	lui	s7,0x1
ffffffffc0208810:	1bfd                	addi	s7,s7,-1
ffffffffc0208812:	e4ce                	sd	s3,72(sp)
ffffffffc0208814:	43f7d993          	srai	s3,a5,0x3f
ffffffffc0208818:	0179f9b3          	and	s3,s3,s7
ffffffffc020881c:	99be                	add	s3,s3,a5
ffffffffc020881e:	8fc5                	or	a5,a5,s1
ffffffffc0208820:	f486                	sd	ra,104(sp)
ffffffffc0208822:	f0a2                	sd	s0,96(sp)
ffffffffc0208824:	e8ca                	sd	s2,80(sp)
ffffffffc0208826:	e0d2                	sd	s4,64(sp)
ffffffffc0208828:	fc56                	sd	s5,56(sp)
ffffffffc020882a:	f85a                	sd	s6,48(sp)
ffffffffc020882c:	f062                	sd	s8,32(sp)
ffffffffc020882e:	ec66                	sd	s9,24(sp)
ffffffffc0208830:	e86a                	sd	s10,16(sp)
ffffffffc0208832:	0177f7b3          	and	a5,a5,s7
ffffffffc0208836:	10079d63          	bnez	a5,ffffffffc0208950 <disk0_io+0x14c>
ffffffffc020883a:	40c9d993          	srai	s3,s3,0xc
ffffffffc020883e:	00c4d713          	srli	a4,s1,0xc
ffffffffc0208842:	2981                	sext.w	s3,s3
ffffffffc0208844:	2701                	sext.w	a4,a4
ffffffffc0208846:	00e987bb          	addw	a5,s3,a4
ffffffffc020884a:	6114                	ld	a3,0(a0)
ffffffffc020884c:	1782                	slli	a5,a5,0x20
ffffffffc020884e:	9381                	srli	a5,a5,0x20
ffffffffc0208850:	10f6e063          	bltu	a3,a5,ffffffffc0208950 <disk0_io+0x14c>
ffffffffc0208854:	4501                	li	a0,0
ffffffffc0208856:	ef19                	bnez	a4,ffffffffc0208874 <disk0_io+0x70>
ffffffffc0208858:	70a6                	ld	ra,104(sp)
ffffffffc020885a:	7406                	ld	s0,96(sp)
ffffffffc020885c:	64e6                	ld	s1,88(sp)
ffffffffc020885e:	6946                	ld	s2,80(sp)
ffffffffc0208860:	69a6                	ld	s3,72(sp)
ffffffffc0208862:	6a06                	ld	s4,64(sp)
ffffffffc0208864:	7ae2                	ld	s5,56(sp)
ffffffffc0208866:	7b42                	ld	s6,48(sp)
ffffffffc0208868:	7ba2                	ld	s7,40(sp)
ffffffffc020886a:	7c02                	ld	s8,32(sp)
ffffffffc020886c:	6ce2                	ld	s9,24(sp)
ffffffffc020886e:	6d42                	ld	s10,16(sp)
ffffffffc0208870:	6165                	addi	sp,sp,112
ffffffffc0208872:	8082                	ret
ffffffffc0208874:	0008e517          	auipc	a0,0x8e
ffffffffc0208878:	fdc50513          	addi	a0,a0,-36 # ffffffffc0296850 <disk0_sem>
ffffffffc020887c:	8b2e                	mv	s6,a1
ffffffffc020887e:	8c32                	mv	s8,a2
ffffffffc0208880:	0008ea97          	auipc	s5,0x8e
ffffffffc0208884:	088a8a93          	addi	s5,s5,136 # ffffffffc0296908 <disk0_buffer>
ffffffffc0208888:	ec3fb0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020888c:	6c91                	lui	s9,0x4
ffffffffc020888e:	e4b9                	bnez	s1,ffffffffc02088dc <disk0_io+0xd8>
ffffffffc0208890:	a845                	j	ffffffffc0208940 <disk0_io+0x13c>
ffffffffc0208892:	00c4d413          	srli	s0,s1,0xc
ffffffffc0208896:	0034169b          	slliw	a3,s0,0x3
ffffffffc020889a:	00068d1b          	sext.w	s10,a3
ffffffffc020889e:	1682                	slli	a3,a3,0x20
ffffffffc02088a0:	2401                	sext.w	s0,s0
ffffffffc02088a2:	9281                	srli	a3,a3,0x20
ffffffffc02088a4:	8926                	mv	s2,s1
ffffffffc02088a6:	00399a1b          	slliw	s4,s3,0x3
ffffffffc02088aa:	862e                	mv	a2,a1
ffffffffc02088ac:	4509                	li	a0,2
ffffffffc02088ae:	85d2                	mv	a1,s4
ffffffffc02088b0:	d81f70ef          	jal	ra,ffffffffc0200630 <ide_read_secs>
ffffffffc02088b4:	e165                	bnez	a0,ffffffffc0208994 <disk0_io+0x190>
ffffffffc02088b6:	000ab583          	ld	a1,0(s5)
ffffffffc02088ba:	0038                	addi	a4,sp,8
ffffffffc02088bc:	4685                	li	a3,1
ffffffffc02088be:	864a                	mv	a2,s2
ffffffffc02088c0:	855a                	mv	a0,s6
ffffffffc02088c2:	e75fc0ef          	jal	ra,ffffffffc0205736 <iobuf_move>
ffffffffc02088c6:	67a2                	ld	a5,8(sp)
ffffffffc02088c8:	09279663          	bne	a5,s2,ffffffffc0208954 <disk0_io+0x150>
ffffffffc02088cc:	017977b3          	and	a5,s2,s7
ffffffffc02088d0:	e3d1                	bnez	a5,ffffffffc0208954 <disk0_io+0x150>
ffffffffc02088d2:	412484b3          	sub	s1,s1,s2
ffffffffc02088d6:	013409bb          	addw	s3,s0,s3
ffffffffc02088da:	c0bd                	beqz	s1,ffffffffc0208940 <disk0_io+0x13c>
ffffffffc02088dc:	000ab583          	ld	a1,0(s5)
ffffffffc02088e0:	000c1b63          	bnez	s8,ffffffffc02088f6 <disk0_io+0xf2>
ffffffffc02088e4:	fb94e7e3          	bltu	s1,s9,ffffffffc0208892 <disk0_io+0x8e>
ffffffffc02088e8:	02000693          	li	a3,32
ffffffffc02088ec:	02000d13          	li	s10,32
ffffffffc02088f0:	4411                	li	s0,4
ffffffffc02088f2:	6911                	lui	s2,0x4
ffffffffc02088f4:	bf4d                	j	ffffffffc02088a6 <disk0_io+0xa2>
ffffffffc02088f6:	0038                	addi	a4,sp,8
ffffffffc02088f8:	4681                	li	a3,0
ffffffffc02088fa:	6611                	lui	a2,0x4
ffffffffc02088fc:	855a                	mv	a0,s6
ffffffffc02088fe:	e39fc0ef          	jal	ra,ffffffffc0205736 <iobuf_move>
ffffffffc0208902:	6422                	ld	s0,8(sp)
ffffffffc0208904:	c825                	beqz	s0,ffffffffc0208974 <disk0_io+0x170>
ffffffffc0208906:	0684e763          	bltu	s1,s0,ffffffffc0208974 <disk0_io+0x170>
ffffffffc020890a:	017477b3          	and	a5,s0,s7
ffffffffc020890e:	e3bd                	bnez	a5,ffffffffc0208974 <disk0_io+0x170>
ffffffffc0208910:	8031                	srli	s0,s0,0xc
ffffffffc0208912:	0034179b          	slliw	a5,s0,0x3
ffffffffc0208916:	000ab603          	ld	a2,0(s5)
ffffffffc020891a:	0039991b          	slliw	s2,s3,0x3
ffffffffc020891e:	02079693          	slli	a3,a5,0x20
ffffffffc0208922:	9281                	srli	a3,a3,0x20
ffffffffc0208924:	85ca                	mv	a1,s2
ffffffffc0208926:	4509                	li	a0,2
ffffffffc0208928:	2401                	sext.w	s0,s0
ffffffffc020892a:	00078a1b          	sext.w	s4,a5
ffffffffc020892e:	d99f70ef          	jal	ra,ffffffffc02006c6 <ide_write_secs>
ffffffffc0208932:	e151                	bnez	a0,ffffffffc02089b6 <disk0_io+0x1b2>
ffffffffc0208934:	6922                	ld	s2,8(sp)
ffffffffc0208936:	013409bb          	addw	s3,s0,s3
ffffffffc020893a:	412484b3          	sub	s1,s1,s2
ffffffffc020893e:	fcd9                	bnez	s1,ffffffffc02088dc <disk0_io+0xd8>
ffffffffc0208940:	0008e517          	auipc	a0,0x8e
ffffffffc0208944:	f1050513          	addi	a0,a0,-240 # ffffffffc0296850 <disk0_sem>
ffffffffc0208948:	dfffb0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020894c:	4501                	li	a0,0
ffffffffc020894e:	b729                	j	ffffffffc0208858 <disk0_io+0x54>
ffffffffc0208950:	5575                	li	a0,-3
ffffffffc0208952:	b719                	j	ffffffffc0208858 <disk0_io+0x54>
ffffffffc0208954:	00006697          	auipc	a3,0x6
ffffffffc0208958:	05468693          	addi	a3,a3,84 # ffffffffc020e9a8 <syscalls+0xf80>
ffffffffc020895c:	00003617          	auipc	a2,0x3
ffffffffc0208960:	e9c60613          	addi	a2,a2,-356 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208964:	06200593          	li	a1,98
ffffffffc0208968:	00006517          	auipc	a0,0x6
ffffffffc020896c:	f8850513          	addi	a0,a0,-120 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208970:	8bff70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208974:	00006697          	auipc	a3,0x6
ffffffffc0208978:	f3c68693          	addi	a3,a3,-196 # ffffffffc020e8b0 <syscalls+0xe88>
ffffffffc020897c:	00003617          	auipc	a2,0x3
ffffffffc0208980:	e7c60613          	addi	a2,a2,-388 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208984:	05700593          	li	a1,87
ffffffffc0208988:	00006517          	auipc	a0,0x6
ffffffffc020898c:	f6850513          	addi	a0,a0,-152 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208990:	89ff70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208994:	88aa                	mv	a7,a0
ffffffffc0208996:	886a                	mv	a6,s10
ffffffffc0208998:	87a2                	mv	a5,s0
ffffffffc020899a:	8752                	mv	a4,s4
ffffffffc020899c:	86ce                	mv	a3,s3
ffffffffc020899e:	00006617          	auipc	a2,0x6
ffffffffc02089a2:	fc260613          	addi	a2,a2,-62 # ffffffffc020e960 <syscalls+0xf38>
ffffffffc02089a6:	02d00593          	li	a1,45
ffffffffc02089aa:	00006517          	auipc	a0,0x6
ffffffffc02089ae:	f4650513          	addi	a0,a0,-186 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc02089b2:	87df70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02089b6:	88aa                	mv	a7,a0
ffffffffc02089b8:	8852                	mv	a6,s4
ffffffffc02089ba:	87a2                	mv	a5,s0
ffffffffc02089bc:	874a                	mv	a4,s2
ffffffffc02089be:	86ce                	mv	a3,s3
ffffffffc02089c0:	00006617          	auipc	a2,0x6
ffffffffc02089c4:	f5060613          	addi	a2,a2,-176 # ffffffffc020e910 <syscalls+0xee8>
ffffffffc02089c8:	03700593          	li	a1,55
ffffffffc02089cc:	00006517          	auipc	a0,0x6
ffffffffc02089d0:	f2450513          	addi	a0,a0,-220 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc02089d4:	85bf70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02089d8 <dev_init_disk0>:
ffffffffc02089d8:	1101                	addi	sp,sp,-32
ffffffffc02089da:	ec06                	sd	ra,24(sp)
ffffffffc02089dc:	e822                	sd	s0,16(sp)
ffffffffc02089de:	e426                	sd	s1,8(sp)
ffffffffc02089e0:	496000ef          	jal	ra,ffffffffc0208e76 <dev_create_inode>
ffffffffc02089e4:	c541                	beqz	a0,ffffffffc0208a6c <dev_init_disk0+0x94>
ffffffffc02089e6:	4d38                	lw	a4,88(a0)
ffffffffc02089e8:	6485                	lui	s1,0x1
ffffffffc02089ea:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02089ee:	842a                	mv	s0,a0
ffffffffc02089f0:	0cf71f63          	bne	a4,a5,ffffffffc0208ace <dev_init_disk0+0xf6>
ffffffffc02089f4:	4509                	li	a0,2
ffffffffc02089f6:	beff70ef          	jal	ra,ffffffffc02005e4 <ide_device_valid>
ffffffffc02089fa:	cd55                	beqz	a0,ffffffffc0208ab6 <dev_init_disk0+0xde>
ffffffffc02089fc:	4509                	li	a0,2
ffffffffc02089fe:	c0bf70ef          	jal	ra,ffffffffc0200608 <ide_device_size>
ffffffffc0208a02:	00355793          	srli	a5,a0,0x3
ffffffffc0208a06:	e01c                	sd	a5,0(s0)
ffffffffc0208a08:	00000797          	auipc	a5,0x0
ffffffffc0208a0c:	df078793          	addi	a5,a5,-528 # ffffffffc02087f8 <disk0_open>
ffffffffc0208a10:	e81c                	sd	a5,16(s0)
ffffffffc0208a12:	00000797          	auipc	a5,0x0
ffffffffc0208a16:	dea78793          	addi	a5,a5,-534 # ffffffffc02087fc <disk0_close>
ffffffffc0208a1a:	ec1c                	sd	a5,24(s0)
ffffffffc0208a1c:	00000797          	auipc	a5,0x0
ffffffffc0208a20:	de878793          	addi	a5,a5,-536 # ffffffffc0208804 <disk0_io>
ffffffffc0208a24:	f01c                	sd	a5,32(s0)
ffffffffc0208a26:	00000797          	auipc	a5,0x0
ffffffffc0208a2a:	dda78793          	addi	a5,a5,-550 # ffffffffc0208800 <disk0_ioctl>
ffffffffc0208a2e:	f41c                	sd	a5,40(s0)
ffffffffc0208a30:	4585                	li	a1,1
ffffffffc0208a32:	0008e517          	auipc	a0,0x8e
ffffffffc0208a36:	e1e50513          	addi	a0,a0,-482 # ffffffffc0296850 <disk0_sem>
ffffffffc0208a3a:	e404                	sd	s1,8(s0)
ffffffffc0208a3c:	d03fb0ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc0208a40:	6511                	lui	a0,0x4
ffffffffc0208a42:	ad4f90ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0208a46:	0008e797          	auipc	a5,0x8e
ffffffffc0208a4a:	eca7b123          	sd	a0,-318(a5) # ffffffffc0296908 <disk0_buffer>
ffffffffc0208a4e:	c921                	beqz	a0,ffffffffc0208a9e <dev_init_disk0+0xc6>
ffffffffc0208a50:	4605                	li	a2,1
ffffffffc0208a52:	85a2                	mv	a1,s0
ffffffffc0208a54:	00006517          	auipc	a0,0x6
ffffffffc0208a58:	fe450513          	addi	a0,a0,-28 # ffffffffc020ea38 <syscalls+0x1010>
ffffffffc0208a5c:	85cff0ef          	jal	ra,ffffffffc0207ab8 <vfs_add_dev>
ffffffffc0208a60:	e115                	bnez	a0,ffffffffc0208a84 <dev_init_disk0+0xac>
ffffffffc0208a62:	60e2                	ld	ra,24(sp)
ffffffffc0208a64:	6442                	ld	s0,16(sp)
ffffffffc0208a66:	64a2                	ld	s1,8(sp)
ffffffffc0208a68:	6105                	addi	sp,sp,32
ffffffffc0208a6a:	8082                	ret
ffffffffc0208a6c:	00006617          	auipc	a2,0x6
ffffffffc0208a70:	f6c60613          	addi	a2,a2,-148 # ffffffffc020e9d8 <syscalls+0xfb0>
ffffffffc0208a74:	08700593          	li	a1,135
ffffffffc0208a78:	00006517          	auipc	a0,0x6
ffffffffc0208a7c:	e7850513          	addi	a0,a0,-392 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208a80:	faef70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208a84:	86aa                	mv	a3,a0
ffffffffc0208a86:	00006617          	auipc	a2,0x6
ffffffffc0208a8a:	fba60613          	addi	a2,a2,-70 # ffffffffc020ea40 <syscalls+0x1018>
ffffffffc0208a8e:	08d00593          	li	a1,141
ffffffffc0208a92:	00006517          	auipc	a0,0x6
ffffffffc0208a96:	e5e50513          	addi	a0,a0,-418 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208a9a:	f94f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208a9e:	00006617          	auipc	a2,0x6
ffffffffc0208aa2:	f7a60613          	addi	a2,a2,-134 # ffffffffc020ea18 <syscalls+0xff0>
ffffffffc0208aa6:	07f00593          	li	a1,127
ffffffffc0208aaa:	00006517          	auipc	a0,0x6
ffffffffc0208aae:	e4650513          	addi	a0,a0,-442 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208ab2:	f7cf70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208ab6:	00006617          	auipc	a2,0x6
ffffffffc0208aba:	f4260613          	addi	a2,a2,-190 # ffffffffc020e9f8 <syscalls+0xfd0>
ffffffffc0208abe:	07300593          	li	a1,115
ffffffffc0208ac2:	00006517          	auipc	a0,0x6
ffffffffc0208ac6:	e2e50513          	addi	a0,a0,-466 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208aca:	f64f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208ace:	00006697          	auipc	a3,0x6
ffffffffc0208ad2:	82268693          	addi	a3,a3,-2014 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208ad6:	00003617          	auipc	a2,0x3
ffffffffc0208ada:	d2260613          	addi	a2,a2,-734 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208ade:	08900593          	li	a1,137
ffffffffc0208ae2:	00006517          	auipc	a0,0x6
ffffffffc0208ae6:	e0e50513          	addi	a0,a0,-498 # ffffffffc020e8f0 <syscalls+0xec8>
ffffffffc0208aea:	f44f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208aee <stdout_open>:
ffffffffc0208aee:	4785                	li	a5,1
ffffffffc0208af0:	4501                	li	a0,0
ffffffffc0208af2:	00f59363          	bne	a1,a5,ffffffffc0208af8 <stdout_open+0xa>
ffffffffc0208af6:	8082                	ret
ffffffffc0208af8:	5575                	li	a0,-3
ffffffffc0208afa:	8082                	ret

ffffffffc0208afc <stdout_close>:
ffffffffc0208afc:	4501                	li	a0,0
ffffffffc0208afe:	8082                	ret

ffffffffc0208b00 <stdout_ioctl>:
ffffffffc0208b00:	5575                	li	a0,-3
ffffffffc0208b02:	8082                	ret

ffffffffc0208b04 <stdout_io>:
ffffffffc0208b04:	ca05                	beqz	a2,ffffffffc0208b34 <stdout_io+0x30>
ffffffffc0208b06:	6d9c                	ld	a5,24(a1)
ffffffffc0208b08:	1101                	addi	sp,sp,-32
ffffffffc0208b0a:	e822                	sd	s0,16(sp)
ffffffffc0208b0c:	e426                	sd	s1,8(sp)
ffffffffc0208b0e:	ec06                	sd	ra,24(sp)
ffffffffc0208b10:	6180                	ld	s0,0(a1)
ffffffffc0208b12:	84ae                	mv	s1,a1
ffffffffc0208b14:	cb91                	beqz	a5,ffffffffc0208b28 <stdout_io+0x24>
ffffffffc0208b16:	00044503          	lbu	a0,0(s0)
ffffffffc0208b1a:	0405                	addi	s0,s0,1
ffffffffc0208b1c:	e4af70ef          	jal	ra,ffffffffc0200166 <cputchar>
ffffffffc0208b20:	6c9c                	ld	a5,24(s1)
ffffffffc0208b22:	17fd                	addi	a5,a5,-1
ffffffffc0208b24:	ec9c                	sd	a5,24(s1)
ffffffffc0208b26:	fbe5                	bnez	a5,ffffffffc0208b16 <stdout_io+0x12>
ffffffffc0208b28:	60e2                	ld	ra,24(sp)
ffffffffc0208b2a:	6442                	ld	s0,16(sp)
ffffffffc0208b2c:	64a2                	ld	s1,8(sp)
ffffffffc0208b2e:	4501                	li	a0,0
ffffffffc0208b30:	6105                	addi	sp,sp,32
ffffffffc0208b32:	8082                	ret
ffffffffc0208b34:	5575                	li	a0,-3
ffffffffc0208b36:	8082                	ret

ffffffffc0208b38 <dev_init_stdout>:
ffffffffc0208b38:	1141                	addi	sp,sp,-16
ffffffffc0208b3a:	e406                	sd	ra,8(sp)
ffffffffc0208b3c:	33a000ef          	jal	ra,ffffffffc0208e76 <dev_create_inode>
ffffffffc0208b40:	c939                	beqz	a0,ffffffffc0208b96 <dev_init_stdout+0x5e>
ffffffffc0208b42:	4d38                	lw	a4,88(a0)
ffffffffc0208b44:	6785                	lui	a5,0x1
ffffffffc0208b46:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208b4a:	85aa                	mv	a1,a0
ffffffffc0208b4c:	06f71e63          	bne	a4,a5,ffffffffc0208bc8 <dev_init_stdout+0x90>
ffffffffc0208b50:	4785                	li	a5,1
ffffffffc0208b52:	e51c                	sd	a5,8(a0)
ffffffffc0208b54:	00000797          	auipc	a5,0x0
ffffffffc0208b58:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208aee <stdout_open>
ffffffffc0208b5c:	e91c                	sd	a5,16(a0)
ffffffffc0208b5e:	00000797          	auipc	a5,0x0
ffffffffc0208b62:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208afc <stdout_close>
ffffffffc0208b66:	ed1c                	sd	a5,24(a0)
ffffffffc0208b68:	00000797          	auipc	a5,0x0
ffffffffc0208b6c:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208b04 <stdout_io>
ffffffffc0208b70:	f11c                	sd	a5,32(a0)
ffffffffc0208b72:	00000797          	auipc	a5,0x0
ffffffffc0208b76:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208b00 <stdout_ioctl>
ffffffffc0208b7a:	00053023          	sd	zero,0(a0)
ffffffffc0208b7e:	f51c                	sd	a5,40(a0)
ffffffffc0208b80:	4601                	li	a2,0
ffffffffc0208b82:	00006517          	auipc	a0,0x6
ffffffffc0208b86:	f1e50513          	addi	a0,a0,-226 # ffffffffc020eaa0 <syscalls+0x1078>
ffffffffc0208b8a:	f2ffe0ef          	jal	ra,ffffffffc0207ab8 <vfs_add_dev>
ffffffffc0208b8e:	e105                	bnez	a0,ffffffffc0208bae <dev_init_stdout+0x76>
ffffffffc0208b90:	60a2                	ld	ra,8(sp)
ffffffffc0208b92:	0141                	addi	sp,sp,16
ffffffffc0208b94:	8082                	ret
ffffffffc0208b96:	00006617          	auipc	a2,0x6
ffffffffc0208b9a:	eca60613          	addi	a2,a2,-310 # ffffffffc020ea60 <syscalls+0x1038>
ffffffffc0208b9e:	03700593          	li	a1,55
ffffffffc0208ba2:	00006517          	auipc	a0,0x6
ffffffffc0208ba6:	ede50513          	addi	a0,a0,-290 # ffffffffc020ea80 <syscalls+0x1058>
ffffffffc0208baa:	e84f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208bae:	86aa                	mv	a3,a0
ffffffffc0208bb0:	00006617          	auipc	a2,0x6
ffffffffc0208bb4:	ef860613          	addi	a2,a2,-264 # ffffffffc020eaa8 <syscalls+0x1080>
ffffffffc0208bb8:	03d00593          	li	a1,61
ffffffffc0208bbc:	00006517          	auipc	a0,0x6
ffffffffc0208bc0:	ec450513          	addi	a0,a0,-316 # ffffffffc020ea80 <syscalls+0x1058>
ffffffffc0208bc4:	e6af70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208bc8:	00005697          	auipc	a3,0x5
ffffffffc0208bcc:	72868693          	addi	a3,a3,1832 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208bd0:	00003617          	auipc	a2,0x3
ffffffffc0208bd4:	c2860613          	addi	a2,a2,-984 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208bd8:	03900593          	li	a1,57
ffffffffc0208bdc:	00006517          	auipc	a0,0x6
ffffffffc0208be0:	ea450513          	addi	a0,a0,-348 # ffffffffc020ea80 <syscalls+0x1058>
ffffffffc0208be4:	e4af70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208be8 <dev_lookup>:
ffffffffc0208be8:	0005c783          	lbu	a5,0(a1) # ffffffff80000000 <_binary_bin_sfs_img_size+0xffffffff7ff8ad00>
ffffffffc0208bec:	e385                	bnez	a5,ffffffffc0208c0c <dev_lookup+0x24>
ffffffffc0208bee:	1101                	addi	sp,sp,-32
ffffffffc0208bf0:	e822                	sd	s0,16(sp)
ffffffffc0208bf2:	e426                	sd	s1,8(sp)
ffffffffc0208bf4:	ec06                	sd	ra,24(sp)
ffffffffc0208bf6:	84aa                	mv	s1,a0
ffffffffc0208bf8:	8432                	mv	s0,a2
ffffffffc0208bfa:	df6ff0ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc0208bfe:	60e2                	ld	ra,24(sp)
ffffffffc0208c00:	e004                	sd	s1,0(s0)
ffffffffc0208c02:	6442                	ld	s0,16(sp)
ffffffffc0208c04:	64a2                	ld	s1,8(sp)
ffffffffc0208c06:	4501                	li	a0,0
ffffffffc0208c08:	6105                	addi	sp,sp,32
ffffffffc0208c0a:	8082                	ret
ffffffffc0208c0c:	5541                	li	a0,-16
ffffffffc0208c0e:	8082                	ret

ffffffffc0208c10 <dev_fstat>:
ffffffffc0208c10:	1101                	addi	sp,sp,-32
ffffffffc0208c12:	e426                	sd	s1,8(sp)
ffffffffc0208c14:	84ae                	mv	s1,a1
ffffffffc0208c16:	e822                	sd	s0,16(sp)
ffffffffc0208c18:	02000613          	li	a2,32
ffffffffc0208c1c:	842a                	mv	s0,a0
ffffffffc0208c1e:	4581                	li	a1,0
ffffffffc0208c20:	8526                	mv	a0,s1
ffffffffc0208c22:	ec06                	sd	ra,24(sp)
ffffffffc0208c24:	3d0020ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0208c28:	c429                	beqz	s0,ffffffffc0208c72 <dev_fstat+0x62>
ffffffffc0208c2a:	783c                	ld	a5,112(s0)
ffffffffc0208c2c:	c3b9                	beqz	a5,ffffffffc0208c72 <dev_fstat+0x62>
ffffffffc0208c2e:	6bbc                	ld	a5,80(a5)
ffffffffc0208c30:	c3a9                	beqz	a5,ffffffffc0208c72 <dev_fstat+0x62>
ffffffffc0208c32:	00005597          	auipc	a1,0x5
ffffffffc0208c36:	78658593          	addi	a1,a1,1926 # ffffffffc020e3b8 <syscalls+0x990>
ffffffffc0208c3a:	8522                	mv	a0,s0
ffffffffc0208c3c:	dccff0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0208c40:	783c                	ld	a5,112(s0)
ffffffffc0208c42:	85a6                	mv	a1,s1
ffffffffc0208c44:	8522                	mv	a0,s0
ffffffffc0208c46:	6bbc                	ld	a5,80(a5)
ffffffffc0208c48:	9782                	jalr	a5
ffffffffc0208c4a:	ed19                	bnez	a0,ffffffffc0208c68 <dev_fstat+0x58>
ffffffffc0208c4c:	4c38                	lw	a4,88(s0)
ffffffffc0208c4e:	6785                	lui	a5,0x1
ffffffffc0208c50:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208c54:	02f71f63          	bne	a4,a5,ffffffffc0208c92 <dev_fstat+0x82>
ffffffffc0208c58:	6018                	ld	a4,0(s0)
ffffffffc0208c5a:	641c                	ld	a5,8(s0)
ffffffffc0208c5c:	4685                	li	a3,1
ffffffffc0208c5e:	e494                	sd	a3,8(s1)
ffffffffc0208c60:	02e787b3          	mul	a5,a5,a4
ffffffffc0208c64:	e898                	sd	a4,16(s1)
ffffffffc0208c66:	ec9c                	sd	a5,24(s1)
ffffffffc0208c68:	60e2                	ld	ra,24(sp)
ffffffffc0208c6a:	6442                	ld	s0,16(sp)
ffffffffc0208c6c:	64a2                	ld	s1,8(sp)
ffffffffc0208c6e:	6105                	addi	sp,sp,32
ffffffffc0208c70:	8082                	ret
ffffffffc0208c72:	00005697          	auipc	a3,0x5
ffffffffc0208c76:	6de68693          	addi	a3,a3,1758 # ffffffffc020e350 <syscalls+0x928>
ffffffffc0208c7a:	00003617          	auipc	a2,0x3
ffffffffc0208c7e:	b7e60613          	addi	a2,a2,-1154 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208c82:	04200593          	li	a1,66
ffffffffc0208c86:	00006517          	auipc	a0,0x6
ffffffffc0208c8a:	e4250513          	addi	a0,a0,-446 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208c8e:	da0f70ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0208c92:	00005697          	auipc	a3,0x5
ffffffffc0208c96:	65e68693          	addi	a3,a3,1630 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208c9a:	00003617          	auipc	a2,0x3
ffffffffc0208c9e:	b5e60613          	addi	a2,a2,-1186 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208ca2:	04500593          	li	a1,69
ffffffffc0208ca6:	00006517          	auipc	a0,0x6
ffffffffc0208caa:	e2250513          	addi	a0,a0,-478 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208cae:	d80f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208cb2 <dev_ioctl>:
ffffffffc0208cb2:	c909                	beqz	a0,ffffffffc0208cc4 <dev_ioctl+0x12>
ffffffffc0208cb4:	4d34                	lw	a3,88(a0)
ffffffffc0208cb6:	6705                	lui	a4,0x1
ffffffffc0208cb8:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208cbc:	00e69463          	bne	a3,a4,ffffffffc0208cc4 <dev_ioctl+0x12>
ffffffffc0208cc0:	751c                	ld	a5,40(a0)
ffffffffc0208cc2:	8782                	jr	a5
ffffffffc0208cc4:	1141                	addi	sp,sp,-16
ffffffffc0208cc6:	00005697          	auipc	a3,0x5
ffffffffc0208cca:	62a68693          	addi	a3,a3,1578 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208cce:	00003617          	auipc	a2,0x3
ffffffffc0208cd2:	b2a60613          	addi	a2,a2,-1238 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208cd6:	03500593          	li	a1,53
ffffffffc0208cda:	00006517          	auipc	a0,0x6
ffffffffc0208cde:	dee50513          	addi	a0,a0,-530 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208ce2:	e406                	sd	ra,8(sp)
ffffffffc0208ce4:	d4af70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208ce8 <dev_tryseek>:
ffffffffc0208ce8:	c51d                	beqz	a0,ffffffffc0208d16 <dev_tryseek+0x2e>
ffffffffc0208cea:	4d38                	lw	a4,88(a0)
ffffffffc0208cec:	6785                	lui	a5,0x1
ffffffffc0208cee:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208cf2:	02f71263          	bne	a4,a5,ffffffffc0208d16 <dev_tryseek+0x2e>
ffffffffc0208cf6:	611c                	ld	a5,0(a0)
ffffffffc0208cf8:	cf89                	beqz	a5,ffffffffc0208d12 <dev_tryseek+0x2a>
ffffffffc0208cfa:	6518                	ld	a4,8(a0)
ffffffffc0208cfc:	02e5f6b3          	remu	a3,a1,a4
ffffffffc0208d00:	ea89                	bnez	a3,ffffffffc0208d12 <dev_tryseek+0x2a>
ffffffffc0208d02:	0005c863          	bltz	a1,ffffffffc0208d12 <dev_tryseek+0x2a>
ffffffffc0208d06:	02e787b3          	mul	a5,a5,a4
ffffffffc0208d0a:	00f5f463          	bgeu	a1,a5,ffffffffc0208d12 <dev_tryseek+0x2a>
ffffffffc0208d0e:	4501                	li	a0,0
ffffffffc0208d10:	8082                	ret
ffffffffc0208d12:	5575                	li	a0,-3
ffffffffc0208d14:	8082                	ret
ffffffffc0208d16:	1141                	addi	sp,sp,-16
ffffffffc0208d18:	00005697          	auipc	a3,0x5
ffffffffc0208d1c:	5d868693          	addi	a3,a3,1496 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208d20:	00003617          	auipc	a2,0x3
ffffffffc0208d24:	ad860613          	addi	a2,a2,-1320 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208d28:	05f00593          	li	a1,95
ffffffffc0208d2c:	00006517          	auipc	a0,0x6
ffffffffc0208d30:	d9c50513          	addi	a0,a0,-612 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208d34:	e406                	sd	ra,8(sp)
ffffffffc0208d36:	cf8f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208d3a <dev_gettype>:
ffffffffc0208d3a:	c10d                	beqz	a0,ffffffffc0208d5c <dev_gettype+0x22>
ffffffffc0208d3c:	4d38                	lw	a4,88(a0)
ffffffffc0208d3e:	6785                	lui	a5,0x1
ffffffffc0208d40:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208d44:	00f71c63          	bne	a4,a5,ffffffffc0208d5c <dev_gettype+0x22>
ffffffffc0208d48:	6118                	ld	a4,0(a0)
ffffffffc0208d4a:	6795                	lui	a5,0x5
ffffffffc0208d4c:	c701                	beqz	a4,ffffffffc0208d54 <dev_gettype+0x1a>
ffffffffc0208d4e:	c19c                	sw	a5,0(a1)
ffffffffc0208d50:	4501                	li	a0,0
ffffffffc0208d52:	8082                	ret
ffffffffc0208d54:	6791                	lui	a5,0x4
ffffffffc0208d56:	c19c                	sw	a5,0(a1)
ffffffffc0208d58:	4501                	li	a0,0
ffffffffc0208d5a:	8082                	ret
ffffffffc0208d5c:	1141                	addi	sp,sp,-16
ffffffffc0208d5e:	00005697          	auipc	a3,0x5
ffffffffc0208d62:	59268693          	addi	a3,a3,1426 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208d66:	00003617          	auipc	a2,0x3
ffffffffc0208d6a:	a9260613          	addi	a2,a2,-1390 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208d6e:	05300593          	li	a1,83
ffffffffc0208d72:	00006517          	auipc	a0,0x6
ffffffffc0208d76:	d5650513          	addi	a0,a0,-682 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208d7a:	e406                	sd	ra,8(sp)
ffffffffc0208d7c:	cb2f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208d80 <dev_write>:
ffffffffc0208d80:	c911                	beqz	a0,ffffffffc0208d94 <dev_write+0x14>
ffffffffc0208d82:	4d34                	lw	a3,88(a0)
ffffffffc0208d84:	6705                	lui	a4,0x1
ffffffffc0208d86:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208d8a:	00e69563          	bne	a3,a4,ffffffffc0208d94 <dev_write+0x14>
ffffffffc0208d8e:	711c                	ld	a5,32(a0)
ffffffffc0208d90:	4605                	li	a2,1
ffffffffc0208d92:	8782                	jr	a5
ffffffffc0208d94:	1141                	addi	sp,sp,-16
ffffffffc0208d96:	00005697          	auipc	a3,0x5
ffffffffc0208d9a:	55a68693          	addi	a3,a3,1370 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208d9e:	00003617          	auipc	a2,0x3
ffffffffc0208da2:	a5a60613          	addi	a2,a2,-1446 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208da6:	02c00593          	li	a1,44
ffffffffc0208daa:	00006517          	auipc	a0,0x6
ffffffffc0208dae:	d1e50513          	addi	a0,a0,-738 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208db2:	e406                	sd	ra,8(sp)
ffffffffc0208db4:	c7af70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208db8 <dev_read>:
ffffffffc0208db8:	c911                	beqz	a0,ffffffffc0208dcc <dev_read+0x14>
ffffffffc0208dba:	4d34                	lw	a3,88(a0)
ffffffffc0208dbc:	6705                	lui	a4,0x1
ffffffffc0208dbe:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208dc2:	00e69563          	bne	a3,a4,ffffffffc0208dcc <dev_read+0x14>
ffffffffc0208dc6:	711c                	ld	a5,32(a0)
ffffffffc0208dc8:	4601                	li	a2,0
ffffffffc0208dca:	8782                	jr	a5
ffffffffc0208dcc:	1141                	addi	sp,sp,-16
ffffffffc0208dce:	00005697          	auipc	a3,0x5
ffffffffc0208dd2:	52268693          	addi	a3,a3,1314 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208dd6:	00003617          	auipc	a2,0x3
ffffffffc0208dda:	a2260613          	addi	a2,a2,-1502 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208dde:	02300593          	li	a1,35
ffffffffc0208de2:	00006517          	auipc	a0,0x6
ffffffffc0208de6:	ce650513          	addi	a0,a0,-794 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208dea:	e406                	sd	ra,8(sp)
ffffffffc0208dec:	c42f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208df0 <dev_close>:
ffffffffc0208df0:	c909                	beqz	a0,ffffffffc0208e02 <dev_close+0x12>
ffffffffc0208df2:	4d34                	lw	a3,88(a0)
ffffffffc0208df4:	6705                	lui	a4,0x1
ffffffffc0208df6:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208dfa:	00e69463          	bne	a3,a4,ffffffffc0208e02 <dev_close+0x12>
ffffffffc0208dfe:	6d1c                	ld	a5,24(a0)
ffffffffc0208e00:	8782                	jr	a5
ffffffffc0208e02:	1141                	addi	sp,sp,-16
ffffffffc0208e04:	00005697          	auipc	a3,0x5
ffffffffc0208e08:	4ec68693          	addi	a3,a3,1260 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208e0c:	00003617          	auipc	a2,0x3
ffffffffc0208e10:	9ec60613          	addi	a2,a2,-1556 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208e14:	45e9                	li	a1,26
ffffffffc0208e16:	00006517          	auipc	a0,0x6
ffffffffc0208e1a:	cb250513          	addi	a0,a0,-846 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208e1e:	e406                	sd	ra,8(sp)
ffffffffc0208e20:	c0ef70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208e24 <dev_open>:
ffffffffc0208e24:	03c5f713          	andi	a4,a1,60
ffffffffc0208e28:	eb11                	bnez	a4,ffffffffc0208e3c <dev_open+0x18>
ffffffffc0208e2a:	c919                	beqz	a0,ffffffffc0208e40 <dev_open+0x1c>
ffffffffc0208e2c:	4d34                	lw	a3,88(a0)
ffffffffc0208e2e:	6705                	lui	a4,0x1
ffffffffc0208e30:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208e34:	00e69663          	bne	a3,a4,ffffffffc0208e40 <dev_open+0x1c>
ffffffffc0208e38:	691c                	ld	a5,16(a0)
ffffffffc0208e3a:	8782                	jr	a5
ffffffffc0208e3c:	5575                	li	a0,-3
ffffffffc0208e3e:	8082                	ret
ffffffffc0208e40:	1141                	addi	sp,sp,-16
ffffffffc0208e42:	00005697          	auipc	a3,0x5
ffffffffc0208e46:	4ae68693          	addi	a3,a3,1198 # ffffffffc020e2f0 <syscalls+0x8c8>
ffffffffc0208e4a:	00003617          	auipc	a2,0x3
ffffffffc0208e4e:	9ae60613          	addi	a2,a2,-1618 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208e52:	45c5                	li	a1,17
ffffffffc0208e54:	00006517          	auipc	a0,0x6
ffffffffc0208e58:	c7450513          	addi	a0,a0,-908 # ffffffffc020eac8 <syscalls+0x10a0>
ffffffffc0208e5c:	e406                	sd	ra,8(sp)
ffffffffc0208e5e:	bd0f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208e62 <dev_init>:
ffffffffc0208e62:	1141                	addi	sp,sp,-16
ffffffffc0208e64:	e406                	sd	ra,8(sp)
ffffffffc0208e66:	8c1ff0ef          	jal	ra,ffffffffc0208726 <dev_init_stdin>
ffffffffc0208e6a:	ccfff0ef          	jal	ra,ffffffffc0208b38 <dev_init_stdout>
ffffffffc0208e6e:	60a2                	ld	ra,8(sp)
ffffffffc0208e70:	0141                	addi	sp,sp,16
ffffffffc0208e72:	b67ff06f          	j	ffffffffc02089d8 <dev_init_disk0>

ffffffffc0208e76 <dev_create_inode>:
ffffffffc0208e76:	6505                	lui	a0,0x1
ffffffffc0208e78:	1141                	addi	sp,sp,-16
ffffffffc0208e7a:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208e7e:	e022                	sd	s0,0(sp)
ffffffffc0208e80:	e406                	sd	ra,8(sp)
ffffffffc0208e82:	af0ff0ef          	jal	ra,ffffffffc0208172 <__alloc_inode>
ffffffffc0208e86:	842a                	mv	s0,a0
ffffffffc0208e88:	c901                	beqz	a0,ffffffffc0208e98 <dev_create_inode+0x22>
ffffffffc0208e8a:	4601                	li	a2,0
ffffffffc0208e8c:	00006597          	auipc	a1,0x6
ffffffffc0208e90:	c5458593          	addi	a1,a1,-940 # ffffffffc020eae0 <dev_node_ops>
ffffffffc0208e94:	afaff0ef          	jal	ra,ffffffffc020818e <inode_init>
ffffffffc0208e98:	60a2                	ld	ra,8(sp)
ffffffffc0208e9a:	8522                	mv	a0,s0
ffffffffc0208e9c:	6402                	ld	s0,0(sp)
ffffffffc0208e9e:	0141                	addi	sp,sp,16
ffffffffc0208ea0:	8082                	ret

ffffffffc0208ea2 <sfs_init>:
ffffffffc0208ea2:	1141                	addi	sp,sp,-16
ffffffffc0208ea4:	00006517          	auipc	a0,0x6
ffffffffc0208ea8:	b9450513          	addi	a0,a0,-1132 # ffffffffc020ea38 <syscalls+0x1010>
ffffffffc0208eac:	e406                	sd	ra,8(sp)
ffffffffc0208eae:	0bd000ef          	jal	ra,ffffffffc020976a <sfs_mount>
ffffffffc0208eb2:	e501                	bnez	a0,ffffffffc0208eba <sfs_init+0x18>
ffffffffc0208eb4:	60a2                	ld	ra,8(sp)
ffffffffc0208eb6:	0141                	addi	sp,sp,16
ffffffffc0208eb8:	8082                	ret
ffffffffc0208eba:	86aa                	mv	a3,a0
ffffffffc0208ebc:	00006617          	auipc	a2,0x6
ffffffffc0208ec0:	ca460613          	addi	a2,a2,-860 # ffffffffc020eb60 <dev_node_ops+0x80>
ffffffffc0208ec4:	45c1                	li	a1,16
ffffffffc0208ec6:	00006517          	auipc	a0,0x6
ffffffffc0208eca:	cba50513          	addi	a0,a0,-838 # ffffffffc020eb80 <dev_node_ops+0xa0>
ffffffffc0208ece:	b60f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208ed2 <sfs_rwblock_nolock>:
ffffffffc0208ed2:	7139                	addi	sp,sp,-64
ffffffffc0208ed4:	f822                	sd	s0,48(sp)
ffffffffc0208ed6:	f426                	sd	s1,40(sp)
ffffffffc0208ed8:	fc06                	sd	ra,56(sp)
ffffffffc0208eda:	842a                	mv	s0,a0
ffffffffc0208edc:	84b6                	mv	s1,a3
ffffffffc0208ede:	e211                	bnez	a2,ffffffffc0208ee2 <sfs_rwblock_nolock+0x10>
ffffffffc0208ee0:	e715                	bnez	a4,ffffffffc0208f0c <sfs_rwblock_nolock+0x3a>
ffffffffc0208ee2:	405c                	lw	a5,4(s0)
ffffffffc0208ee4:	02f67463          	bgeu	a2,a5,ffffffffc0208f0c <sfs_rwblock_nolock+0x3a>
ffffffffc0208ee8:	00c6169b          	slliw	a3,a2,0xc
ffffffffc0208eec:	1682                	slli	a3,a3,0x20
ffffffffc0208eee:	6605                	lui	a2,0x1
ffffffffc0208ef0:	9281                	srli	a3,a3,0x20
ffffffffc0208ef2:	850a                	mv	a0,sp
ffffffffc0208ef4:	839fc0ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc0208ef8:	85aa                	mv	a1,a0
ffffffffc0208efa:	7808                	ld	a0,48(s0)
ffffffffc0208efc:	8626                	mv	a2,s1
ffffffffc0208efe:	7118                	ld	a4,32(a0)
ffffffffc0208f00:	9702                	jalr	a4
ffffffffc0208f02:	70e2                	ld	ra,56(sp)
ffffffffc0208f04:	7442                	ld	s0,48(sp)
ffffffffc0208f06:	74a2                	ld	s1,40(sp)
ffffffffc0208f08:	6121                	addi	sp,sp,64
ffffffffc0208f0a:	8082                	ret
ffffffffc0208f0c:	00006697          	auipc	a3,0x6
ffffffffc0208f10:	c8c68693          	addi	a3,a3,-884 # ffffffffc020eb98 <dev_node_ops+0xb8>
ffffffffc0208f14:	00003617          	auipc	a2,0x3
ffffffffc0208f18:	8e460613          	addi	a2,a2,-1820 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0208f1c:	45d5                	li	a1,21
ffffffffc0208f1e:	00006517          	auipc	a0,0x6
ffffffffc0208f22:	cb250513          	addi	a0,a0,-846 # ffffffffc020ebd0 <dev_node_ops+0xf0>
ffffffffc0208f26:	b08f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0208f2a <sfs_rblock>:
ffffffffc0208f2a:	7139                	addi	sp,sp,-64
ffffffffc0208f2c:	ec4e                	sd	s3,24(sp)
ffffffffc0208f2e:	89b6                	mv	s3,a3
ffffffffc0208f30:	f822                	sd	s0,48(sp)
ffffffffc0208f32:	f04a                	sd	s2,32(sp)
ffffffffc0208f34:	e852                	sd	s4,16(sp)
ffffffffc0208f36:	fc06                	sd	ra,56(sp)
ffffffffc0208f38:	f426                	sd	s1,40(sp)
ffffffffc0208f3a:	e456                	sd	s5,8(sp)
ffffffffc0208f3c:	8a2a                	mv	s4,a0
ffffffffc0208f3e:	892e                	mv	s2,a1
ffffffffc0208f40:	8432                	mv	s0,a2
ffffffffc0208f42:	2e0000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc0208f46:	04098063          	beqz	s3,ffffffffc0208f86 <sfs_rblock+0x5c>
ffffffffc0208f4a:	013409bb          	addw	s3,s0,s3
ffffffffc0208f4e:	6a85                	lui	s5,0x1
ffffffffc0208f50:	a021                	j	ffffffffc0208f58 <sfs_rblock+0x2e>
ffffffffc0208f52:	9956                	add	s2,s2,s5
ffffffffc0208f54:	02898963          	beq	s3,s0,ffffffffc0208f86 <sfs_rblock+0x5c>
ffffffffc0208f58:	8622                	mv	a2,s0
ffffffffc0208f5a:	85ca                	mv	a1,s2
ffffffffc0208f5c:	4705                	li	a4,1
ffffffffc0208f5e:	4681                	li	a3,0
ffffffffc0208f60:	8552                	mv	a0,s4
ffffffffc0208f62:	f71ff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc0208f66:	84aa                	mv	s1,a0
ffffffffc0208f68:	2405                	addiw	s0,s0,1
ffffffffc0208f6a:	d565                	beqz	a0,ffffffffc0208f52 <sfs_rblock+0x28>
ffffffffc0208f6c:	8552                	mv	a0,s4
ffffffffc0208f6e:	2c4000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc0208f72:	70e2                	ld	ra,56(sp)
ffffffffc0208f74:	7442                	ld	s0,48(sp)
ffffffffc0208f76:	7902                	ld	s2,32(sp)
ffffffffc0208f78:	69e2                	ld	s3,24(sp)
ffffffffc0208f7a:	6a42                	ld	s4,16(sp)
ffffffffc0208f7c:	6aa2                	ld	s5,8(sp)
ffffffffc0208f7e:	8526                	mv	a0,s1
ffffffffc0208f80:	74a2                	ld	s1,40(sp)
ffffffffc0208f82:	6121                	addi	sp,sp,64
ffffffffc0208f84:	8082                	ret
ffffffffc0208f86:	4481                	li	s1,0
ffffffffc0208f88:	b7d5                	j	ffffffffc0208f6c <sfs_rblock+0x42>

ffffffffc0208f8a <sfs_wblock>:
ffffffffc0208f8a:	7139                	addi	sp,sp,-64
ffffffffc0208f8c:	ec4e                	sd	s3,24(sp)
ffffffffc0208f8e:	89b6                	mv	s3,a3
ffffffffc0208f90:	f822                	sd	s0,48(sp)
ffffffffc0208f92:	f04a                	sd	s2,32(sp)
ffffffffc0208f94:	e852                	sd	s4,16(sp)
ffffffffc0208f96:	fc06                	sd	ra,56(sp)
ffffffffc0208f98:	f426                	sd	s1,40(sp)
ffffffffc0208f9a:	e456                	sd	s5,8(sp)
ffffffffc0208f9c:	8a2a                	mv	s4,a0
ffffffffc0208f9e:	892e                	mv	s2,a1
ffffffffc0208fa0:	8432                	mv	s0,a2
ffffffffc0208fa2:	280000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc0208fa6:	04098063          	beqz	s3,ffffffffc0208fe6 <sfs_wblock+0x5c>
ffffffffc0208faa:	013409bb          	addw	s3,s0,s3
ffffffffc0208fae:	6a85                	lui	s5,0x1
ffffffffc0208fb0:	a021                	j	ffffffffc0208fb8 <sfs_wblock+0x2e>
ffffffffc0208fb2:	9956                	add	s2,s2,s5
ffffffffc0208fb4:	02898963          	beq	s3,s0,ffffffffc0208fe6 <sfs_wblock+0x5c>
ffffffffc0208fb8:	8622                	mv	a2,s0
ffffffffc0208fba:	85ca                	mv	a1,s2
ffffffffc0208fbc:	4705                	li	a4,1
ffffffffc0208fbe:	4685                	li	a3,1
ffffffffc0208fc0:	8552                	mv	a0,s4
ffffffffc0208fc2:	f11ff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc0208fc6:	84aa                	mv	s1,a0
ffffffffc0208fc8:	2405                	addiw	s0,s0,1
ffffffffc0208fca:	d565                	beqz	a0,ffffffffc0208fb2 <sfs_wblock+0x28>
ffffffffc0208fcc:	8552                	mv	a0,s4
ffffffffc0208fce:	264000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc0208fd2:	70e2                	ld	ra,56(sp)
ffffffffc0208fd4:	7442                	ld	s0,48(sp)
ffffffffc0208fd6:	7902                	ld	s2,32(sp)
ffffffffc0208fd8:	69e2                	ld	s3,24(sp)
ffffffffc0208fda:	6a42                	ld	s4,16(sp)
ffffffffc0208fdc:	6aa2                	ld	s5,8(sp)
ffffffffc0208fde:	8526                	mv	a0,s1
ffffffffc0208fe0:	74a2                	ld	s1,40(sp)
ffffffffc0208fe2:	6121                	addi	sp,sp,64
ffffffffc0208fe4:	8082                	ret
ffffffffc0208fe6:	4481                	li	s1,0
ffffffffc0208fe8:	b7d5                	j	ffffffffc0208fcc <sfs_wblock+0x42>

ffffffffc0208fea <sfs_rbuf>:
ffffffffc0208fea:	7179                	addi	sp,sp,-48
ffffffffc0208fec:	f406                	sd	ra,40(sp)
ffffffffc0208fee:	f022                	sd	s0,32(sp)
ffffffffc0208ff0:	ec26                	sd	s1,24(sp)
ffffffffc0208ff2:	e84a                	sd	s2,16(sp)
ffffffffc0208ff4:	e44e                	sd	s3,8(sp)
ffffffffc0208ff6:	e052                	sd	s4,0(sp)
ffffffffc0208ff8:	6785                	lui	a5,0x1
ffffffffc0208ffa:	04f77863          	bgeu	a4,a5,ffffffffc020904a <sfs_rbuf+0x60>
ffffffffc0208ffe:	84ba                	mv	s1,a4
ffffffffc0209000:	9732                	add	a4,a4,a2
ffffffffc0209002:	89b2                	mv	s3,a2
ffffffffc0209004:	04e7e363          	bltu	a5,a4,ffffffffc020904a <sfs_rbuf+0x60>
ffffffffc0209008:	8936                	mv	s2,a3
ffffffffc020900a:	842a                	mv	s0,a0
ffffffffc020900c:	8a2e                	mv	s4,a1
ffffffffc020900e:	214000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc0209012:	642c                	ld	a1,72(s0)
ffffffffc0209014:	864a                	mv	a2,s2
ffffffffc0209016:	4705                	li	a4,1
ffffffffc0209018:	4681                	li	a3,0
ffffffffc020901a:	8522                	mv	a0,s0
ffffffffc020901c:	eb7ff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc0209020:	892a                	mv	s2,a0
ffffffffc0209022:	cd09                	beqz	a0,ffffffffc020903c <sfs_rbuf+0x52>
ffffffffc0209024:	8522                	mv	a0,s0
ffffffffc0209026:	20c000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc020902a:	70a2                	ld	ra,40(sp)
ffffffffc020902c:	7402                	ld	s0,32(sp)
ffffffffc020902e:	64e2                	ld	s1,24(sp)
ffffffffc0209030:	69a2                	ld	s3,8(sp)
ffffffffc0209032:	6a02                	ld	s4,0(sp)
ffffffffc0209034:	854a                	mv	a0,s2
ffffffffc0209036:	6942                	ld	s2,16(sp)
ffffffffc0209038:	6145                	addi	sp,sp,48
ffffffffc020903a:	8082                	ret
ffffffffc020903c:	642c                	ld	a1,72(s0)
ffffffffc020903e:	864e                	mv	a2,s3
ffffffffc0209040:	8552                	mv	a0,s4
ffffffffc0209042:	95a6                	add	a1,a1,s1
ffffffffc0209044:	002020ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0209048:	bff1                	j	ffffffffc0209024 <sfs_rbuf+0x3a>
ffffffffc020904a:	00006697          	auipc	a3,0x6
ffffffffc020904e:	b9e68693          	addi	a3,a3,-1122 # ffffffffc020ebe8 <dev_node_ops+0x108>
ffffffffc0209052:	00002617          	auipc	a2,0x2
ffffffffc0209056:	7a660613          	addi	a2,a2,1958 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020905a:	05500593          	li	a1,85
ffffffffc020905e:	00006517          	auipc	a0,0x6
ffffffffc0209062:	b7250513          	addi	a0,a0,-1166 # ffffffffc020ebd0 <dev_node_ops+0xf0>
ffffffffc0209066:	9c8f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020906a <sfs_wbuf>:
ffffffffc020906a:	7139                	addi	sp,sp,-64
ffffffffc020906c:	fc06                	sd	ra,56(sp)
ffffffffc020906e:	f822                	sd	s0,48(sp)
ffffffffc0209070:	f426                	sd	s1,40(sp)
ffffffffc0209072:	f04a                	sd	s2,32(sp)
ffffffffc0209074:	ec4e                	sd	s3,24(sp)
ffffffffc0209076:	e852                	sd	s4,16(sp)
ffffffffc0209078:	e456                	sd	s5,8(sp)
ffffffffc020907a:	6785                	lui	a5,0x1
ffffffffc020907c:	06f77163          	bgeu	a4,a5,ffffffffc02090de <sfs_wbuf+0x74>
ffffffffc0209080:	893a                	mv	s2,a4
ffffffffc0209082:	9732                	add	a4,a4,a2
ffffffffc0209084:	8a32                	mv	s4,a2
ffffffffc0209086:	04e7ec63          	bltu	a5,a4,ffffffffc02090de <sfs_wbuf+0x74>
ffffffffc020908a:	842a                	mv	s0,a0
ffffffffc020908c:	89b6                	mv	s3,a3
ffffffffc020908e:	8aae                	mv	s5,a1
ffffffffc0209090:	192000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc0209094:	642c                	ld	a1,72(s0)
ffffffffc0209096:	4705                	li	a4,1
ffffffffc0209098:	4681                	li	a3,0
ffffffffc020909a:	864e                	mv	a2,s3
ffffffffc020909c:	8522                	mv	a0,s0
ffffffffc020909e:	e35ff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc02090a2:	84aa                	mv	s1,a0
ffffffffc02090a4:	cd11                	beqz	a0,ffffffffc02090c0 <sfs_wbuf+0x56>
ffffffffc02090a6:	8522                	mv	a0,s0
ffffffffc02090a8:	18a000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc02090ac:	70e2                	ld	ra,56(sp)
ffffffffc02090ae:	7442                	ld	s0,48(sp)
ffffffffc02090b0:	7902                	ld	s2,32(sp)
ffffffffc02090b2:	69e2                	ld	s3,24(sp)
ffffffffc02090b4:	6a42                	ld	s4,16(sp)
ffffffffc02090b6:	6aa2                	ld	s5,8(sp)
ffffffffc02090b8:	8526                	mv	a0,s1
ffffffffc02090ba:	74a2                	ld	s1,40(sp)
ffffffffc02090bc:	6121                	addi	sp,sp,64
ffffffffc02090be:	8082                	ret
ffffffffc02090c0:	6428                	ld	a0,72(s0)
ffffffffc02090c2:	8652                	mv	a2,s4
ffffffffc02090c4:	85d6                	mv	a1,s5
ffffffffc02090c6:	954a                	add	a0,a0,s2
ffffffffc02090c8:	77f010ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc02090cc:	642c                	ld	a1,72(s0)
ffffffffc02090ce:	4705                	li	a4,1
ffffffffc02090d0:	4685                	li	a3,1
ffffffffc02090d2:	864e                	mv	a2,s3
ffffffffc02090d4:	8522                	mv	a0,s0
ffffffffc02090d6:	dfdff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc02090da:	84aa                	mv	s1,a0
ffffffffc02090dc:	b7e9                	j	ffffffffc02090a6 <sfs_wbuf+0x3c>
ffffffffc02090de:	00006697          	auipc	a3,0x6
ffffffffc02090e2:	b0a68693          	addi	a3,a3,-1270 # ffffffffc020ebe8 <dev_node_ops+0x108>
ffffffffc02090e6:	00002617          	auipc	a2,0x2
ffffffffc02090ea:	71260613          	addi	a2,a2,1810 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02090ee:	06b00593          	li	a1,107
ffffffffc02090f2:	00006517          	auipc	a0,0x6
ffffffffc02090f6:	ade50513          	addi	a0,a0,-1314 # ffffffffc020ebd0 <dev_node_ops+0xf0>
ffffffffc02090fa:	934f70ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02090fe <sfs_sync_super>:
ffffffffc02090fe:	1101                	addi	sp,sp,-32
ffffffffc0209100:	ec06                	sd	ra,24(sp)
ffffffffc0209102:	e822                	sd	s0,16(sp)
ffffffffc0209104:	e426                	sd	s1,8(sp)
ffffffffc0209106:	842a                	mv	s0,a0
ffffffffc0209108:	11a000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc020910c:	6428                	ld	a0,72(s0)
ffffffffc020910e:	6605                	lui	a2,0x1
ffffffffc0209110:	4581                	li	a1,0
ffffffffc0209112:	6e3010ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc0209116:	6428                	ld	a0,72(s0)
ffffffffc0209118:	85a2                	mv	a1,s0
ffffffffc020911a:	02c00613          	li	a2,44
ffffffffc020911e:	729010ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc0209122:	642c                	ld	a1,72(s0)
ffffffffc0209124:	4701                	li	a4,0
ffffffffc0209126:	4685                	li	a3,1
ffffffffc0209128:	4601                	li	a2,0
ffffffffc020912a:	8522                	mv	a0,s0
ffffffffc020912c:	da7ff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc0209130:	84aa                	mv	s1,a0
ffffffffc0209132:	8522                	mv	a0,s0
ffffffffc0209134:	0fe000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc0209138:	60e2                	ld	ra,24(sp)
ffffffffc020913a:	6442                	ld	s0,16(sp)
ffffffffc020913c:	8526                	mv	a0,s1
ffffffffc020913e:	64a2                	ld	s1,8(sp)
ffffffffc0209140:	6105                	addi	sp,sp,32
ffffffffc0209142:	8082                	ret

ffffffffc0209144 <sfs_sync_freemap>:
ffffffffc0209144:	7139                	addi	sp,sp,-64
ffffffffc0209146:	ec4e                	sd	s3,24(sp)
ffffffffc0209148:	e852                	sd	s4,16(sp)
ffffffffc020914a:	00456983          	lwu	s3,4(a0)
ffffffffc020914e:	8a2a                	mv	s4,a0
ffffffffc0209150:	7d08                	ld	a0,56(a0)
ffffffffc0209152:	67a1                	lui	a5,0x8
ffffffffc0209154:	17fd                	addi	a5,a5,-1
ffffffffc0209156:	4581                	li	a1,0
ffffffffc0209158:	f822                	sd	s0,48(sp)
ffffffffc020915a:	fc06                	sd	ra,56(sp)
ffffffffc020915c:	f426                	sd	s1,40(sp)
ffffffffc020915e:	f04a                	sd	s2,32(sp)
ffffffffc0209160:	e456                	sd	s5,8(sp)
ffffffffc0209162:	99be                	add	s3,s3,a5
ffffffffc0209164:	5e1010ef          	jal	ra,ffffffffc020af44 <bitmap_getdata>
ffffffffc0209168:	00f9d993          	srli	s3,s3,0xf
ffffffffc020916c:	842a                	mv	s0,a0
ffffffffc020916e:	8552                	mv	a0,s4
ffffffffc0209170:	0b2000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc0209174:	04098163          	beqz	s3,ffffffffc02091b6 <sfs_sync_freemap+0x72>
ffffffffc0209178:	09b2                	slli	s3,s3,0xc
ffffffffc020917a:	99a2                	add	s3,s3,s0
ffffffffc020917c:	4909                	li	s2,2
ffffffffc020917e:	6a85                	lui	s5,0x1
ffffffffc0209180:	a021                	j	ffffffffc0209188 <sfs_sync_freemap+0x44>
ffffffffc0209182:	2905                	addiw	s2,s2,1
ffffffffc0209184:	02898963          	beq	s3,s0,ffffffffc02091b6 <sfs_sync_freemap+0x72>
ffffffffc0209188:	85a2                	mv	a1,s0
ffffffffc020918a:	864a                	mv	a2,s2
ffffffffc020918c:	4705                	li	a4,1
ffffffffc020918e:	4685                	li	a3,1
ffffffffc0209190:	8552                	mv	a0,s4
ffffffffc0209192:	d41ff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc0209196:	84aa                	mv	s1,a0
ffffffffc0209198:	9456                	add	s0,s0,s5
ffffffffc020919a:	d565                	beqz	a0,ffffffffc0209182 <sfs_sync_freemap+0x3e>
ffffffffc020919c:	8552                	mv	a0,s4
ffffffffc020919e:	094000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc02091a2:	70e2                	ld	ra,56(sp)
ffffffffc02091a4:	7442                	ld	s0,48(sp)
ffffffffc02091a6:	7902                	ld	s2,32(sp)
ffffffffc02091a8:	69e2                	ld	s3,24(sp)
ffffffffc02091aa:	6a42                	ld	s4,16(sp)
ffffffffc02091ac:	6aa2                	ld	s5,8(sp)
ffffffffc02091ae:	8526                	mv	a0,s1
ffffffffc02091b0:	74a2                	ld	s1,40(sp)
ffffffffc02091b2:	6121                	addi	sp,sp,64
ffffffffc02091b4:	8082                	ret
ffffffffc02091b6:	4481                	li	s1,0
ffffffffc02091b8:	b7d5                	j	ffffffffc020919c <sfs_sync_freemap+0x58>

ffffffffc02091ba <sfs_clear_block>:
ffffffffc02091ba:	7179                	addi	sp,sp,-48
ffffffffc02091bc:	f022                	sd	s0,32(sp)
ffffffffc02091be:	e84a                	sd	s2,16(sp)
ffffffffc02091c0:	e44e                	sd	s3,8(sp)
ffffffffc02091c2:	f406                	sd	ra,40(sp)
ffffffffc02091c4:	89b2                	mv	s3,a2
ffffffffc02091c6:	ec26                	sd	s1,24(sp)
ffffffffc02091c8:	892a                	mv	s2,a0
ffffffffc02091ca:	842e                	mv	s0,a1
ffffffffc02091cc:	056000ef          	jal	ra,ffffffffc0209222 <lock_sfs_io>
ffffffffc02091d0:	04893503          	ld	a0,72(s2) # 4048 <_binary_bin_swap_img_size-0x3cb8>
ffffffffc02091d4:	6605                	lui	a2,0x1
ffffffffc02091d6:	4581                	li	a1,0
ffffffffc02091d8:	61d010ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc02091dc:	02098d63          	beqz	s3,ffffffffc0209216 <sfs_clear_block+0x5c>
ffffffffc02091e0:	013409bb          	addw	s3,s0,s3
ffffffffc02091e4:	a019                	j	ffffffffc02091ea <sfs_clear_block+0x30>
ffffffffc02091e6:	02898863          	beq	s3,s0,ffffffffc0209216 <sfs_clear_block+0x5c>
ffffffffc02091ea:	04893583          	ld	a1,72(s2)
ffffffffc02091ee:	8622                	mv	a2,s0
ffffffffc02091f0:	4705                	li	a4,1
ffffffffc02091f2:	4685                	li	a3,1
ffffffffc02091f4:	854a                	mv	a0,s2
ffffffffc02091f6:	cddff0ef          	jal	ra,ffffffffc0208ed2 <sfs_rwblock_nolock>
ffffffffc02091fa:	84aa                	mv	s1,a0
ffffffffc02091fc:	2405                	addiw	s0,s0,1
ffffffffc02091fe:	d565                	beqz	a0,ffffffffc02091e6 <sfs_clear_block+0x2c>
ffffffffc0209200:	854a                	mv	a0,s2
ffffffffc0209202:	030000ef          	jal	ra,ffffffffc0209232 <unlock_sfs_io>
ffffffffc0209206:	70a2                	ld	ra,40(sp)
ffffffffc0209208:	7402                	ld	s0,32(sp)
ffffffffc020920a:	6942                	ld	s2,16(sp)
ffffffffc020920c:	69a2                	ld	s3,8(sp)
ffffffffc020920e:	8526                	mv	a0,s1
ffffffffc0209210:	64e2                	ld	s1,24(sp)
ffffffffc0209212:	6145                	addi	sp,sp,48
ffffffffc0209214:	8082                	ret
ffffffffc0209216:	4481                	li	s1,0
ffffffffc0209218:	b7e5                	j	ffffffffc0209200 <sfs_clear_block+0x46>

ffffffffc020921a <lock_sfs_fs>:
ffffffffc020921a:	05050513          	addi	a0,a0,80
ffffffffc020921e:	d2cfb06f          	j	ffffffffc020474a <down>

ffffffffc0209222 <lock_sfs_io>:
ffffffffc0209222:	06850513          	addi	a0,a0,104
ffffffffc0209226:	d24fb06f          	j	ffffffffc020474a <down>

ffffffffc020922a <unlock_sfs_fs>:
ffffffffc020922a:	05050513          	addi	a0,a0,80
ffffffffc020922e:	d18fb06f          	j	ffffffffc0204746 <up>

ffffffffc0209232 <unlock_sfs_io>:
ffffffffc0209232:	06850513          	addi	a0,a0,104
ffffffffc0209236:	d10fb06f          	j	ffffffffc0204746 <up>

ffffffffc020923a <sfs_unmount>:
ffffffffc020923a:	1141                	addi	sp,sp,-16
ffffffffc020923c:	e406                	sd	ra,8(sp)
ffffffffc020923e:	e022                	sd	s0,0(sp)
ffffffffc0209240:	cd1d                	beqz	a0,ffffffffc020927e <sfs_unmount+0x44>
ffffffffc0209242:	0b052783          	lw	a5,176(a0)
ffffffffc0209246:	842a                	mv	s0,a0
ffffffffc0209248:	eb9d                	bnez	a5,ffffffffc020927e <sfs_unmount+0x44>
ffffffffc020924a:	7158                	ld	a4,160(a0)
ffffffffc020924c:	09850793          	addi	a5,a0,152
ffffffffc0209250:	02f71563          	bne	a4,a5,ffffffffc020927a <sfs_unmount+0x40>
ffffffffc0209254:	613c                	ld	a5,64(a0)
ffffffffc0209256:	e7a1                	bnez	a5,ffffffffc020929e <sfs_unmount+0x64>
ffffffffc0209258:	7d08                	ld	a0,56(a0)
ffffffffc020925a:	4d1010ef          	jal	ra,ffffffffc020af2a <bitmap_destroy>
ffffffffc020925e:	6428                	ld	a0,72(s0)
ffffffffc0209260:	b67f80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0209264:	7448                	ld	a0,168(s0)
ffffffffc0209266:	b61f80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020926a:	8522                	mv	a0,s0
ffffffffc020926c:	b5bf80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0209270:	4501                	li	a0,0
ffffffffc0209272:	60a2                	ld	ra,8(sp)
ffffffffc0209274:	6402                	ld	s0,0(sp)
ffffffffc0209276:	0141                	addi	sp,sp,16
ffffffffc0209278:	8082                	ret
ffffffffc020927a:	5545                	li	a0,-15
ffffffffc020927c:	bfdd                	j	ffffffffc0209272 <sfs_unmount+0x38>
ffffffffc020927e:	00006697          	auipc	a3,0x6
ffffffffc0209282:	9b268693          	addi	a3,a3,-1614 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc0209286:	00002617          	auipc	a2,0x2
ffffffffc020928a:	57260613          	addi	a2,a2,1394 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020928e:	04100593          	li	a1,65
ffffffffc0209292:	00006517          	auipc	a0,0x6
ffffffffc0209296:	9ce50513          	addi	a0,a0,-1586 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc020929a:	f95f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020929e:	00006697          	auipc	a3,0x6
ffffffffc02092a2:	9da68693          	addi	a3,a3,-1574 # ffffffffc020ec78 <dev_node_ops+0x198>
ffffffffc02092a6:	00002617          	auipc	a2,0x2
ffffffffc02092aa:	55260613          	addi	a2,a2,1362 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02092ae:	04500593          	li	a1,69
ffffffffc02092b2:	00006517          	auipc	a0,0x6
ffffffffc02092b6:	9ae50513          	addi	a0,a0,-1618 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc02092ba:	f75f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02092be <sfs_cleanup>:
ffffffffc02092be:	1101                	addi	sp,sp,-32
ffffffffc02092c0:	ec06                	sd	ra,24(sp)
ffffffffc02092c2:	e822                	sd	s0,16(sp)
ffffffffc02092c4:	e426                	sd	s1,8(sp)
ffffffffc02092c6:	e04a                	sd	s2,0(sp)
ffffffffc02092c8:	c525                	beqz	a0,ffffffffc0209330 <sfs_cleanup+0x72>
ffffffffc02092ca:	0b052783          	lw	a5,176(a0)
ffffffffc02092ce:	84aa                	mv	s1,a0
ffffffffc02092d0:	e3a5                	bnez	a5,ffffffffc0209330 <sfs_cleanup+0x72>
ffffffffc02092d2:	4158                	lw	a4,4(a0)
ffffffffc02092d4:	4514                	lw	a3,8(a0)
ffffffffc02092d6:	00c50913          	addi	s2,a0,12
ffffffffc02092da:	85ca                	mv	a1,s2
ffffffffc02092dc:	40d7063b          	subw	a2,a4,a3
ffffffffc02092e0:	00006517          	auipc	a0,0x6
ffffffffc02092e4:	9b050513          	addi	a0,a0,-1616 # ffffffffc020ec90 <dev_node_ops+0x1b0>
ffffffffc02092e8:	e43f60ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02092ec:	02000413          	li	s0,32
ffffffffc02092f0:	a019                	j	ffffffffc02092f6 <sfs_cleanup+0x38>
ffffffffc02092f2:	347d                	addiw	s0,s0,-1
ffffffffc02092f4:	c819                	beqz	s0,ffffffffc020930a <sfs_cleanup+0x4c>
ffffffffc02092f6:	7cdc                	ld	a5,184(s1)
ffffffffc02092f8:	8526                	mv	a0,s1
ffffffffc02092fa:	9782                	jalr	a5
ffffffffc02092fc:	f97d                	bnez	a0,ffffffffc02092f2 <sfs_cleanup+0x34>
ffffffffc02092fe:	60e2                	ld	ra,24(sp)
ffffffffc0209300:	6442                	ld	s0,16(sp)
ffffffffc0209302:	64a2                	ld	s1,8(sp)
ffffffffc0209304:	6902                	ld	s2,0(sp)
ffffffffc0209306:	6105                	addi	sp,sp,32
ffffffffc0209308:	8082                	ret
ffffffffc020930a:	6442                	ld	s0,16(sp)
ffffffffc020930c:	60e2                	ld	ra,24(sp)
ffffffffc020930e:	64a2                	ld	s1,8(sp)
ffffffffc0209310:	86ca                	mv	a3,s2
ffffffffc0209312:	6902                	ld	s2,0(sp)
ffffffffc0209314:	872a                	mv	a4,a0
ffffffffc0209316:	00006617          	auipc	a2,0x6
ffffffffc020931a:	99a60613          	addi	a2,a2,-1638 # ffffffffc020ecb0 <dev_node_ops+0x1d0>
ffffffffc020931e:	05f00593          	li	a1,95
ffffffffc0209322:	00006517          	auipc	a0,0x6
ffffffffc0209326:	93e50513          	addi	a0,a0,-1730 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc020932a:	6105                	addi	sp,sp,32
ffffffffc020932c:	f6bf606f          	j	ffffffffc0200296 <__warn>
ffffffffc0209330:	00006697          	auipc	a3,0x6
ffffffffc0209334:	90068693          	addi	a3,a3,-1792 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc0209338:	00002617          	auipc	a2,0x2
ffffffffc020933c:	4c060613          	addi	a2,a2,1216 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209340:	05400593          	li	a1,84
ffffffffc0209344:	00006517          	auipc	a0,0x6
ffffffffc0209348:	91c50513          	addi	a0,a0,-1764 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc020934c:	ee3f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209350 <sfs_sync>:
ffffffffc0209350:	7179                	addi	sp,sp,-48
ffffffffc0209352:	f406                	sd	ra,40(sp)
ffffffffc0209354:	f022                	sd	s0,32(sp)
ffffffffc0209356:	ec26                	sd	s1,24(sp)
ffffffffc0209358:	e84a                	sd	s2,16(sp)
ffffffffc020935a:	e44e                	sd	s3,8(sp)
ffffffffc020935c:	e052                	sd	s4,0(sp)
ffffffffc020935e:	cd4d                	beqz	a0,ffffffffc0209418 <sfs_sync+0xc8>
ffffffffc0209360:	0b052783          	lw	a5,176(a0)
ffffffffc0209364:	8a2a                	mv	s4,a0
ffffffffc0209366:	ebcd                	bnez	a5,ffffffffc0209418 <sfs_sync+0xc8>
ffffffffc0209368:	eb3ff0ef          	jal	ra,ffffffffc020921a <lock_sfs_fs>
ffffffffc020936c:	0a0a3403          	ld	s0,160(s4)
ffffffffc0209370:	098a0913          	addi	s2,s4,152
ffffffffc0209374:	02890763          	beq	s2,s0,ffffffffc02093a2 <sfs_sync+0x52>
ffffffffc0209378:	00004997          	auipc	s3,0x4
ffffffffc020937c:	fa098993          	addi	s3,s3,-96 # ffffffffc020d318 <default_pmm_manager+0xb58>
ffffffffc0209380:	7c1c                	ld	a5,56(s0)
ffffffffc0209382:	fc840493          	addi	s1,s0,-56
ffffffffc0209386:	cbb5                	beqz	a5,ffffffffc02093fa <sfs_sync+0xaa>
ffffffffc0209388:	7b9c                	ld	a5,48(a5)
ffffffffc020938a:	cba5                	beqz	a5,ffffffffc02093fa <sfs_sync+0xaa>
ffffffffc020938c:	85ce                	mv	a1,s3
ffffffffc020938e:	8526                	mv	a0,s1
ffffffffc0209390:	e79fe0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0209394:	7c1c                	ld	a5,56(s0)
ffffffffc0209396:	8526                	mv	a0,s1
ffffffffc0209398:	7b9c                	ld	a5,48(a5)
ffffffffc020939a:	9782                	jalr	a5
ffffffffc020939c:	6400                	ld	s0,8(s0)
ffffffffc020939e:	fe8911e3          	bne	s2,s0,ffffffffc0209380 <sfs_sync+0x30>
ffffffffc02093a2:	8552                	mv	a0,s4
ffffffffc02093a4:	e87ff0ef          	jal	ra,ffffffffc020922a <unlock_sfs_fs>
ffffffffc02093a8:	040a3783          	ld	a5,64(s4)
ffffffffc02093ac:	4501                	li	a0,0
ffffffffc02093ae:	eb89                	bnez	a5,ffffffffc02093c0 <sfs_sync+0x70>
ffffffffc02093b0:	70a2                	ld	ra,40(sp)
ffffffffc02093b2:	7402                	ld	s0,32(sp)
ffffffffc02093b4:	64e2                	ld	s1,24(sp)
ffffffffc02093b6:	6942                	ld	s2,16(sp)
ffffffffc02093b8:	69a2                	ld	s3,8(sp)
ffffffffc02093ba:	6a02                	ld	s4,0(sp)
ffffffffc02093bc:	6145                	addi	sp,sp,48
ffffffffc02093be:	8082                	ret
ffffffffc02093c0:	040a3023          	sd	zero,64(s4)
ffffffffc02093c4:	8552                	mv	a0,s4
ffffffffc02093c6:	d39ff0ef          	jal	ra,ffffffffc02090fe <sfs_sync_super>
ffffffffc02093ca:	cd01                	beqz	a0,ffffffffc02093e2 <sfs_sync+0x92>
ffffffffc02093cc:	70a2                	ld	ra,40(sp)
ffffffffc02093ce:	7402                	ld	s0,32(sp)
ffffffffc02093d0:	4785                	li	a5,1
ffffffffc02093d2:	04fa3023          	sd	a5,64(s4)
ffffffffc02093d6:	64e2                	ld	s1,24(sp)
ffffffffc02093d8:	6942                	ld	s2,16(sp)
ffffffffc02093da:	69a2                	ld	s3,8(sp)
ffffffffc02093dc:	6a02                	ld	s4,0(sp)
ffffffffc02093de:	6145                	addi	sp,sp,48
ffffffffc02093e0:	8082                	ret
ffffffffc02093e2:	8552                	mv	a0,s4
ffffffffc02093e4:	d61ff0ef          	jal	ra,ffffffffc0209144 <sfs_sync_freemap>
ffffffffc02093e8:	f175                	bnez	a0,ffffffffc02093cc <sfs_sync+0x7c>
ffffffffc02093ea:	70a2                	ld	ra,40(sp)
ffffffffc02093ec:	7402                	ld	s0,32(sp)
ffffffffc02093ee:	64e2                	ld	s1,24(sp)
ffffffffc02093f0:	6942                	ld	s2,16(sp)
ffffffffc02093f2:	69a2                	ld	s3,8(sp)
ffffffffc02093f4:	6a02                	ld	s4,0(sp)
ffffffffc02093f6:	6145                	addi	sp,sp,48
ffffffffc02093f8:	8082                	ret
ffffffffc02093fa:	00004697          	auipc	a3,0x4
ffffffffc02093fe:	ece68693          	addi	a3,a3,-306 # ffffffffc020d2c8 <default_pmm_manager+0xb08>
ffffffffc0209402:	00002617          	auipc	a2,0x2
ffffffffc0209406:	3f660613          	addi	a2,a2,1014 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020940a:	45ed                	li	a1,27
ffffffffc020940c:	00006517          	auipc	a0,0x6
ffffffffc0209410:	85450513          	addi	a0,a0,-1964 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc0209414:	e1bf60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209418:	00006697          	auipc	a3,0x6
ffffffffc020941c:	81868693          	addi	a3,a3,-2024 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc0209420:	00002617          	auipc	a2,0x2
ffffffffc0209424:	3d860613          	addi	a2,a2,984 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209428:	45d5                	li	a1,21
ffffffffc020942a:	00006517          	auipc	a0,0x6
ffffffffc020942e:	83650513          	addi	a0,a0,-1994 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc0209432:	dfdf60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209436 <sfs_get_root>:
ffffffffc0209436:	1101                	addi	sp,sp,-32
ffffffffc0209438:	ec06                	sd	ra,24(sp)
ffffffffc020943a:	cd09                	beqz	a0,ffffffffc0209454 <sfs_get_root+0x1e>
ffffffffc020943c:	0b052783          	lw	a5,176(a0)
ffffffffc0209440:	eb91                	bnez	a5,ffffffffc0209454 <sfs_get_root+0x1e>
ffffffffc0209442:	4605                	li	a2,1
ffffffffc0209444:	002c                	addi	a1,sp,8
ffffffffc0209446:	324010ef          	jal	ra,ffffffffc020a76a <sfs_load_inode>
ffffffffc020944a:	e50d                	bnez	a0,ffffffffc0209474 <sfs_get_root+0x3e>
ffffffffc020944c:	60e2                	ld	ra,24(sp)
ffffffffc020944e:	6522                	ld	a0,8(sp)
ffffffffc0209450:	6105                	addi	sp,sp,32
ffffffffc0209452:	8082                	ret
ffffffffc0209454:	00005697          	auipc	a3,0x5
ffffffffc0209458:	7dc68693          	addi	a3,a3,2012 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020945c:	00002617          	auipc	a2,0x2
ffffffffc0209460:	39c60613          	addi	a2,a2,924 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209464:	03600593          	li	a1,54
ffffffffc0209468:	00005517          	auipc	a0,0x5
ffffffffc020946c:	7f850513          	addi	a0,a0,2040 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc0209470:	dbff60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209474:	86aa                	mv	a3,a0
ffffffffc0209476:	00006617          	auipc	a2,0x6
ffffffffc020947a:	85a60613          	addi	a2,a2,-1958 # ffffffffc020ecd0 <dev_node_ops+0x1f0>
ffffffffc020947e:	03700593          	li	a1,55
ffffffffc0209482:	00005517          	auipc	a0,0x5
ffffffffc0209486:	7de50513          	addi	a0,a0,2014 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc020948a:	da5f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020948e <sfs_do_mount>:
ffffffffc020948e:	6518                	ld	a4,8(a0)
ffffffffc0209490:	7171                	addi	sp,sp,-176
ffffffffc0209492:	f506                	sd	ra,168(sp)
ffffffffc0209494:	f122                	sd	s0,160(sp)
ffffffffc0209496:	ed26                	sd	s1,152(sp)
ffffffffc0209498:	e94a                	sd	s2,144(sp)
ffffffffc020949a:	e54e                	sd	s3,136(sp)
ffffffffc020949c:	e152                	sd	s4,128(sp)
ffffffffc020949e:	fcd6                	sd	s5,120(sp)
ffffffffc02094a0:	f8da                	sd	s6,112(sp)
ffffffffc02094a2:	f4de                	sd	s7,104(sp)
ffffffffc02094a4:	f0e2                	sd	s8,96(sp)
ffffffffc02094a6:	ece6                	sd	s9,88(sp)
ffffffffc02094a8:	e8ea                	sd	s10,80(sp)
ffffffffc02094aa:	e4ee                	sd	s11,72(sp)
ffffffffc02094ac:	6785                	lui	a5,0x1
ffffffffc02094ae:	24f71663          	bne	a4,a5,ffffffffc02096fa <sfs_do_mount+0x26c>
ffffffffc02094b2:	892a                	mv	s2,a0
ffffffffc02094b4:	4501                	li	a0,0
ffffffffc02094b6:	8aae                	mv	s5,a1
ffffffffc02094b8:	f51fe0ef          	jal	ra,ffffffffc0208408 <__alloc_fs>
ffffffffc02094bc:	842a                	mv	s0,a0
ffffffffc02094be:	24050463          	beqz	a0,ffffffffc0209706 <sfs_do_mount+0x278>
ffffffffc02094c2:	0b052b03          	lw	s6,176(a0)
ffffffffc02094c6:	260b1263          	bnez	s6,ffffffffc020972a <sfs_do_mount+0x29c>
ffffffffc02094ca:	03253823          	sd	s2,48(a0)
ffffffffc02094ce:	6505                	lui	a0,0x1
ffffffffc02094d0:	847f80ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc02094d4:	e428                	sd	a0,72(s0)
ffffffffc02094d6:	84aa                	mv	s1,a0
ffffffffc02094d8:	16050363          	beqz	a0,ffffffffc020963e <sfs_do_mount+0x1b0>
ffffffffc02094dc:	85aa                	mv	a1,a0
ffffffffc02094de:	4681                	li	a3,0
ffffffffc02094e0:	6605                	lui	a2,0x1
ffffffffc02094e2:	1008                	addi	a0,sp,32
ffffffffc02094e4:	a48fc0ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc02094e8:	02093783          	ld	a5,32(s2)
ffffffffc02094ec:	85aa                	mv	a1,a0
ffffffffc02094ee:	4601                	li	a2,0
ffffffffc02094f0:	854a                	mv	a0,s2
ffffffffc02094f2:	9782                	jalr	a5
ffffffffc02094f4:	8a2a                	mv	s4,a0
ffffffffc02094f6:	10051e63          	bnez	a0,ffffffffc0209612 <sfs_do_mount+0x184>
ffffffffc02094fa:	408c                	lw	a1,0(s1)
ffffffffc02094fc:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc0209500:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc0209504:	14c59863          	bne	a1,a2,ffffffffc0209654 <sfs_do_mount+0x1c6>
ffffffffc0209508:	40dc                	lw	a5,4(s1)
ffffffffc020950a:	00093603          	ld	a2,0(s2)
ffffffffc020950e:	02079713          	slli	a4,a5,0x20
ffffffffc0209512:	9301                	srli	a4,a4,0x20
ffffffffc0209514:	12e66763          	bltu	a2,a4,ffffffffc0209642 <sfs_do_mount+0x1b4>
ffffffffc0209518:	020485a3          	sb	zero,43(s1)
ffffffffc020951c:	0084af03          	lw	t5,8(s1)
ffffffffc0209520:	00c4ae83          	lw	t4,12(s1)
ffffffffc0209524:	0104ae03          	lw	t3,16(s1)
ffffffffc0209528:	0144a303          	lw	t1,20(s1)
ffffffffc020952c:	0184a883          	lw	a7,24(s1)
ffffffffc0209530:	01c4a803          	lw	a6,28(s1)
ffffffffc0209534:	5090                	lw	a2,32(s1)
ffffffffc0209536:	50d4                	lw	a3,36(s1)
ffffffffc0209538:	5498                	lw	a4,40(s1)
ffffffffc020953a:	6511                	lui	a0,0x4
ffffffffc020953c:	c00c                	sw	a1,0(s0)
ffffffffc020953e:	c05c                	sw	a5,4(s0)
ffffffffc0209540:	01e42423          	sw	t5,8(s0)
ffffffffc0209544:	01d42623          	sw	t4,12(s0)
ffffffffc0209548:	01c42823          	sw	t3,16(s0)
ffffffffc020954c:	00642a23          	sw	t1,20(s0)
ffffffffc0209550:	01142c23          	sw	a7,24(s0)
ffffffffc0209554:	01042e23          	sw	a6,28(s0)
ffffffffc0209558:	d010                	sw	a2,32(s0)
ffffffffc020955a:	d054                	sw	a3,36(s0)
ffffffffc020955c:	d418                	sw	a4,40(s0)
ffffffffc020955e:	fb8f80ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc0209562:	f448                	sd	a0,168(s0)
ffffffffc0209564:	8c2a                	mv	s8,a0
ffffffffc0209566:	18050c63          	beqz	a0,ffffffffc02096fe <sfs_do_mount+0x270>
ffffffffc020956a:	6711                	lui	a4,0x4
ffffffffc020956c:	87aa                	mv	a5,a0
ffffffffc020956e:	972a                	add	a4,a4,a0
ffffffffc0209570:	e79c                	sd	a5,8(a5)
ffffffffc0209572:	e39c                	sd	a5,0(a5)
ffffffffc0209574:	07c1                	addi	a5,a5,16
ffffffffc0209576:	fee79de3          	bne	a5,a4,ffffffffc0209570 <sfs_do_mount+0xe2>
ffffffffc020957a:	0044eb83          	lwu	s7,4(s1)
ffffffffc020957e:	67a1                	lui	a5,0x8
ffffffffc0209580:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc0209584:	9bce                	add	s7,s7,s3
ffffffffc0209586:	77e1                	lui	a5,0xffff8
ffffffffc0209588:	00fbfbb3          	and	s7,s7,a5
ffffffffc020958c:	2b81                	sext.w	s7,s7
ffffffffc020958e:	855e                	mv	a0,s7
ffffffffc0209590:	7a0010ef          	jal	ra,ffffffffc020ad30 <bitmap_create>
ffffffffc0209594:	fc08                	sd	a0,56(s0)
ffffffffc0209596:	8d2a                	mv	s10,a0
ffffffffc0209598:	14050f63          	beqz	a0,ffffffffc02096f6 <sfs_do_mount+0x268>
ffffffffc020959c:	0044e783          	lwu	a5,4(s1)
ffffffffc02095a0:	082c                	addi	a1,sp,24
ffffffffc02095a2:	97ce                	add	a5,a5,s3
ffffffffc02095a4:	00f7d713          	srli	a4,a5,0xf
ffffffffc02095a8:	e43a                	sd	a4,8(sp)
ffffffffc02095aa:	40f7d993          	srai	s3,a5,0xf
ffffffffc02095ae:	197010ef          	jal	ra,ffffffffc020af44 <bitmap_getdata>
ffffffffc02095b2:	14050c63          	beqz	a0,ffffffffc020970a <sfs_do_mount+0x27c>
ffffffffc02095b6:	00c9979b          	slliw	a5,s3,0xc
ffffffffc02095ba:	66e2                	ld	a3,24(sp)
ffffffffc02095bc:	1782                	slli	a5,a5,0x20
ffffffffc02095be:	9381                	srli	a5,a5,0x20
ffffffffc02095c0:	14d79563          	bne	a5,a3,ffffffffc020970a <sfs_do_mount+0x27c>
ffffffffc02095c4:	6722                	ld	a4,8(sp)
ffffffffc02095c6:	6d89                	lui	s11,0x2
ffffffffc02095c8:	89aa                	mv	s3,a0
ffffffffc02095ca:	00c71c93          	slli	s9,a4,0xc
ffffffffc02095ce:	9caa                	add	s9,s9,a0
ffffffffc02095d0:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02095d4:	e711                	bnez	a4,ffffffffc02095e0 <sfs_do_mount+0x152>
ffffffffc02095d6:	a079                	j	ffffffffc0209664 <sfs_do_mount+0x1d6>
ffffffffc02095d8:	6785                	lui	a5,0x1
ffffffffc02095da:	99be                	add	s3,s3,a5
ffffffffc02095dc:	093c8463          	beq	s9,s3,ffffffffc0209664 <sfs_do_mount+0x1d6>
ffffffffc02095e0:	013d86bb          	addw	a3,s11,s3
ffffffffc02095e4:	1682                	slli	a3,a3,0x20
ffffffffc02095e6:	6605                	lui	a2,0x1
ffffffffc02095e8:	85ce                	mv	a1,s3
ffffffffc02095ea:	9281                	srli	a3,a3,0x20
ffffffffc02095ec:	1008                	addi	a0,sp,32
ffffffffc02095ee:	93efc0ef          	jal	ra,ffffffffc020572c <iobuf_init>
ffffffffc02095f2:	02093783          	ld	a5,32(s2)
ffffffffc02095f6:	85aa                	mv	a1,a0
ffffffffc02095f8:	4601                	li	a2,0
ffffffffc02095fa:	854a                	mv	a0,s2
ffffffffc02095fc:	9782                	jalr	a5
ffffffffc02095fe:	dd69                	beqz	a0,ffffffffc02095d8 <sfs_do_mount+0x14a>
ffffffffc0209600:	e42a                	sd	a0,8(sp)
ffffffffc0209602:	856a                	mv	a0,s10
ffffffffc0209604:	127010ef          	jal	ra,ffffffffc020af2a <bitmap_destroy>
ffffffffc0209608:	67a2                	ld	a5,8(sp)
ffffffffc020960a:	8a3e                	mv	s4,a5
ffffffffc020960c:	8562                	mv	a0,s8
ffffffffc020960e:	fb8f80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0209612:	8526                	mv	a0,s1
ffffffffc0209614:	fb2f80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0209618:	8522                	mv	a0,s0
ffffffffc020961a:	facf80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020961e:	70aa                	ld	ra,168(sp)
ffffffffc0209620:	740a                	ld	s0,160(sp)
ffffffffc0209622:	64ea                	ld	s1,152(sp)
ffffffffc0209624:	694a                	ld	s2,144(sp)
ffffffffc0209626:	69aa                	ld	s3,136(sp)
ffffffffc0209628:	7ae6                	ld	s5,120(sp)
ffffffffc020962a:	7b46                	ld	s6,112(sp)
ffffffffc020962c:	7ba6                	ld	s7,104(sp)
ffffffffc020962e:	7c06                	ld	s8,96(sp)
ffffffffc0209630:	6ce6                	ld	s9,88(sp)
ffffffffc0209632:	6d46                	ld	s10,80(sp)
ffffffffc0209634:	6da6                	ld	s11,72(sp)
ffffffffc0209636:	8552                	mv	a0,s4
ffffffffc0209638:	6a0a                	ld	s4,128(sp)
ffffffffc020963a:	614d                	addi	sp,sp,176
ffffffffc020963c:	8082                	ret
ffffffffc020963e:	5a71                	li	s4,-4
ffffffffc0209640:	bfe1                	j	ffffffffc0209618 <sfs_do_mount+0x18a>
ffffffffc0209642:	85be                	mv	a1,a5
ffffffffc0209644:	00005517          	auipc	a0,0x5
ffffffffc0209648:	6e450513          	addi	a0,a0,1764 # ffffffffc020ed28 <dev_node_ops+0x248>
ffffffffc020964c:	adff60ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0209650:	5a75                	li	s4,-3
ffffffffc0209652:	b7c1                	j	ffffffffc0209612 <sfs_do_mount+0x184>
ffffffffc0209654:	00005517          	auipc	a0,0x5
ffffffffc0209658:	69c50513          	addi	a0,a0,1692 # ffffffffc020ecf0 <dev_node_ops+0x210>
ffffffffc020965c:	acff60ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc0209660:	5a75                	li	s4,-3
ffffffffc0209662:	bf45                	j	ffffffffc0209612 <sfs_do_mount+0x184>
ffffffffc0209664:	00442903          	lw	s2,4(s0)
ffffffffc0209668:	4481                	li	s1,0
ffffffffc020966a:	080b8c63          	beqz	s7,ffffffffc0209702 <sfs_do_mount+0x274>
ffffffffc020966e:	85a6                	mv	a1,s1
ffffffffc0209670:	856a                	mv	a0,s10
ffffffffc0209672:	03f010ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc0209676:	c111                	beqz	a0,ffffffffc020967a <sfs_do_mount+0x1ec>
ffffffffc0209678:	2b05                	addiw	s6,s6,1
ffffffffc020967a:	2485                	addiw	s1,s1,1
ffffffffc020967c:	fe9b99e3          	bne	s7,s1,ffffffffc020966e <sfs_do_mount+0x1e0>
ffffffffc0209680:	441c                	lw	a5,8(s0)
ffffffffc0209682:	0d679463          	bne	a5,s6,ffffffffc020974a <sfs_do_mount+0x2bc>
ffffffffc0209686:	4585                	li	a1,1
ffffffffc0209688:	05040513          	addi	a0,s0,80
ffffffffc020968c:	04043023          	sd	zero,64(s0)
ffffffffc0209690:	8aefb0ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc0209694:	4585                	li	a1,1
ffffffffc0209696:	06840513          	addi	a0,s0,104
ffffffffc020969a:	8a4fb0ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc020969e:	4585                	li	a1,1
ffffffffc02096a0:	08040513          	addi	a0,s0,128
ffffffffc02096a4:	89afb0ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc02096a8:	09840793          	addi	a5,s0,152
ffffffffc02096ac:	f05c                	sd	a5,160(s0)
ffffffffc02096ae:	ec5c                	sd	a5,152(s0)
ffffffffc02096b0:	874a                	mv	a4,s2
ffffffffc02096b2:	86da                	mv	a3,s6
ffffffffc02096b4:	4169063b          	subw	a2,s2,s6
ffffffffc02096b8:	00c40593          	addi	a1,s0,12
ffffffffc02096bc:	00005517          	auipc	a0,0x5
ffffffffc02096c0:	6fc50513          	addi	a0,a0,1788 # ffffffffc020edb8 <dev_node_ops+0x2d8>
ffffffffc02096c4:	a67f60ef          	jal	ra,ffffffffc020012a <cprintf>
ffffffffc02096c8:	00000797          	auipc	a5,0x0
ffffffffc02096cc:	c8878793          	addi	a5,a5,-888 # ffffffffc0209350 <sfs_sync>
ffffffffc02096d0:	fc5c                	sd	a5,184(s0)
ffffffffc02096d2:	00000797          	auipc	a5,0x0
ffffffffc02096d6:	d6478793          	addi	a5,a5,-668 # ffffffffc0209436 <sfs_get_root>
ffffffffc02096da:	e07c                	sd	a5,192(s0)
ffffffffc02096dc:	00000797          	auipc	a5,0x0
ffffffffc02096e0:	b5e78793          	addi	a5,a5,-1186 # ffffffffc020923a <sfs_unmount>
ffffffffc02096e4:	e47c                	sd	a5,200(s0)
ffffffffc02096e6:	00000797          	auipc	a5,0x0
ffffffffc02096ea:	bd878793          	addi	a5,a5,-1064 # ffffffffc02092be <sfs_cleanup>
ffffffffc02096ee:	e87c                	sd	a5,208(s0)
ffffffffc02096f0:	008ab023          	sd	s0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc02096f4:	b72d                	j	ffffffffc020961e <sfs_do_mount+0x190>
ffffffffc02096f6:	5a71                	li	s4,-4
ffffffffc02096f8:	bf11                	j	ffffffffc020960c <sfs_do_mount+0x17e>
ffffffffc02096fa:	5a49                	li	s4,-14
ffffffffc02096fc:	b70d                	j	ffffffffc020961e <sfs_do_mount+0x190>
ffffffffc02096fe:	5a71                	li	s4,-4
ffffffffc0209700:	bf09                	j	ffffffffc0209612 <sfs_do_mount+0x184>
ffffffffc0209702:	4b01                	li	s6,0
ffffffffc0209704:	bfb5                	j	ffffffffc0209680 <sfs_do_mount+0x1f2>
ffffffffc0209706:	5a71                	li	s4,-4
ffffffffc0209708:	bf19                	j	ffffffffc020961e <sfs_do_mount+0x190>
ffffffffc020970a:	00005697          	auipc	a3,0x5
ffffffffc020970e:	64e68693          	addi	a3,a3,1614 # ffffffffc020ed58 <dev_node_ops+0x278>
ffffffffc0209712:	00002617          	auipc	a2,0x2
ffffffffc0209716:	0e660613          	addi	a2,a2,230 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020971a:	08300593          	li	a1,131
ffffffffc020971e:	00005517          	auipc	a0,0x5
ffffffffc0209722:	54250513          	addi	a0,a0,1346 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc0209726:	b09f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020972a:	00005697          	auipc	a3,0x5
ffffffffc020972e:	50668693          	addi	a3,a3,1286 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc0209732:	00002617          	auipc	a2,0x2
ffffffffc0209736:	0c660613          	addi	a2,a2,198 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020973a:	0a300593          	li	a1,163
ffffffffc020973e:	00005517          	auipc	a0,0x5
ffffffffc0209742:	52250513          	addi	a0,a0,1314 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc0209746:	ae9f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020974a:	00005697          	auipc	a3,0x5
ffffffffc020974e:	63e68693          	addi	a3,a3,1598 # ffffffffc020ed88 <dev_node_ops+0x2a8>
ffffffffc0209752:	00002617          	auipc	a2,0x2
ffffffffc0209756:	0a660613          	addi	a2,a2,166 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020975a:	0e000593          	li	a1,224
ffffffffc020975e:	00005517          	auipc	a0,0x5
ffffffffc0209762:	50250513          	addi	a0,a0,1282 # ffffffffc020ec60 <dev_node_ops+0x180>
ffffffffc0209766:	ac9f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020976a <sfs_mount>:
ffffffffc020976a:	00000597          	auipc	a1,0x0
ffffffffc020976e:	d2458593          	addi	a1,a1,-732 # ffffffffc020948e <sfs_do_mount>
ffffffffc0209772:	b4efe06f          	j	ffffffffc0207ac0 <vfs_mount>

ffffffffc0209776 <sfs_opendir>:
ffffffffc0209776:	0235f593          	andi	a1,a1,35
ffffffffc020977a:	4501                	li	a0,0
ffffffffc020977c:	e191                	bnez	a1,ffffffffc0209780 <sfs_opendir+0xa>
ffffffffc020977e:	8082                	ret
ffffffffc0209780:	553d                	li	a0,-17
ffffffffc0209782:	8082                	ret

ffffffffc0209784 <sfs_openfile>:
ffffffffc0209784:	4501                	li	a0,0
ffffffffc0209786:	8082                	ret

ffffffffc0209788 <sfs_gettype>:
ffffffffc0209788:	1141                	addi	sp,sp,-16
ffffffffc020978a:	e406                	sd	ra,8(sp)
ffffffffc020978c:	c939                	beqz	a0,ffffffffc02097e2 <sfs_gettype+0x5a>
ffffffffc020978e:	4d34                	lw	a3,88(a0)
ffffffffc0209790:	6785                	lui	a5,0x1
ffffffffc0209792:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209796:	04e69663          	bne	a3,a4,ffffffffc02097e2 <sfs_gettype+0x5a>
ffffffffc020979a:	6114                	ld	a3,0(a0)
ffffffffc020979c:	4709                	li	a4,2
ffffffffc020979e:	0046d683          	lhu	a3,4(a3)
ffffffffc02097a2:	02e68a63          	beq	a3,a4,ffffffffc02097d6 <sfs_gettype+0x4e>
ffffffffc02097a6:	470d                	li	a4,3
ffffffffc02097a8:	02e68163          	beq	a3,a4,ffffffffc02097ca <sfs_gettype+0x42>
ffffffffc02097ac:	4705                	li	a4,1
ffffffffc02097ae:	00e68f63          	beq	a3,a4,ffffffffc02097cc <sfs_gettype+0x44>
ffffffffc02097b2:	00005617          	auipc	a2,0x5
ffffffffc02097b6:	67660613          	addi	a2,a2,1654 # ffffffffc020ee28 <dev_node_ops+0x348>
ffffffffc02097ba:	37a00593          	li	a1,890
ffffffffc02097be:	00005517          	auipc	a0,0x5
ffffffffc02097c2:	65250513          	addi	a0,a0,1618 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc02097c6:	a69f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02097ca:	678d                	lui	a5,0x3
ffffffffc02097cc:	60a2                	ld	ra,8(sp)
ffffffffc02097ce:	c19c                	sw	a5,0(a1)
ffffffffc02097d0:	4501                	li	a0,0
ffffffffc02097d2:	0141                	addi	sp,sp,16
ffffffffc02097d4:	8082                	ret
ffffffffc02097d6:	60a2                	ld	ra,8(sp)
ffffffffc02097d8:	6789                	lui	a5,0x2
ffffffffc02097da:	c19c                	sw	a5,0(a1)
ffffffffc02097dc:	4501                	li	a0,0
ffffffffc02097de:	0141                	addi	sp,sp,16
ffffffffc02097e0:	8082                	ret
ffffffffc02097e2:	00005697          	auipc	a3,0x5
ffffffffc02097e6:	5f668693          	addi	a3,a3,1526 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc02097ea:	00002617          	auipc	a2,0x2
ffffffffc02097ee:	00e60613          	addi	a2,a2,14 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02097f2:	36e00593          	li	a1,878
ffffffffc02097f6:	00005517          	auipc	a0,0x5
ffffffffc02097fa:	61a50513          	addi	a0,a0,1562 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc02097fe:	a31f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209802 <sfs_fsync>:
ffffffffc0209802:	7179                	addi	sp,sp,-48
ffffffffc0209804:	ec26                	sd	s1,24(sp)
ffffffffc0209806:	7524                	ld	s1,104(a0)
ffffffffc0209808:	f406                	sd	ra,40(sp)
ffffffffc020980a:	f022                	sd	s0,32(sp)
ffffffffc020980c:	e84a                	sd	s2,16(sp)
ffffffffc020980e:	e44e                	sd	s3,8(sp)
ffffffffc0209810:	c4bd                	beqz	s1,ffffffffc020987e <sfs_fsync+0x7c>
ffffffffc0209812:	0b04a783          	lw	a5,176(s1)
ffffffffc0209816:	e7a5                	bnez	a5,ffffffffc020987e <sfs_fsync+0x7c>
ffffffffc0209818:	4d38                	lw	a4,88(a0)
ffffffffc020981a:	6785                	lui	a5,0x1
ffffffffc020981c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209820:	842a                	mv	s0,a0
ffffffffc0209822:	06f71e63          	bne	a4,a5,ffffffffc020989e <sfs_fsync+0x9c>
ffffffffc0209826:	691c                	ld	a5,16(a0)
ffffffffc0209828:	4901                	li	s2,0
ffffffffc020982a:	eb89                	bnez	a5,ffffffffc020983c <sfs_fsync+0x3a>
ffffffffc020982c:	70a2                	ld	ra,40(sp)
ffffffffc020982e:	7402                	ld	s0,32(sp)
ffffffffc0209830:	64e2                	ld	s1,24(sp)
ffffffffc0209832:	69a2                	ld	s3,8(sp)
ffffffffc0209834:	854a                	mv	a0,s2
ffffffffc0209836:	6942                	ld	s2,16(sp)
ffffffffc0209838:	6145                	addi	sp,sp,48
ffffffffc020983a:	8082                	ret
ffffffffc020983c:	02050993          	addi	s3,a0,32
ffffffffc0209840:	854e                	mv	a0,s3
ffffffffc0209842:	f09fa0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc0209846:	681c                	ld	a5,16(s0)
ffffffffc0209848:	ef81                	bnez	a5,ffffffffc0209860 <sfs_fsync+0x5e>
ffffffffc020984a:	854e                	mv	a0,s3
ffffffffc020984c:	efbfa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc0209850:	70a2                	ld	ra,40(sp)
ffffffffc0209852:	7402                	ld	s0,32(sp)
ffffffffc0209854:	64e2                	ld	s1,24(sp)
ffffffffc0209856:	69a2                	ld	s3,8(sp)
ffffffffc0209858:	854a                	mv	a0,s2
ffffffffc020985a:	6942                	ld	s2,16(sp)
ffffffffc020985c:	6145                	addi	sp,sp,48
ffffffffc020985e:	8082                	ret
ffffffffc0209860:	4414                	lw	a3,8(s0)
ffffffffc0209862:	600c                	ld	a1,0(s0)
ffffffffc0209864:	00043823          	sd	zero,16(s0)
ffffffffc0209868:	4701                	li	a4,0
ffffffffc020986a:	04000613          	li	a2,64
ffffffffc020986e:	8526                	mv	a0,s1
ffffffffc0209870:	ffaff0ef          	jal	ra,ffffffffc020906a <sfs_wbuf>
ffffffffc0209874:	892a                	mv	s2,a0
ffffffffc0209876:	d971                	beqz	a0,ffffffffc020984a <sfs_fsync+0x48>
ffffffffc0209878:	4785                	li	a5,1
ffffffffc020987a:	e81c                	sd	a5,16(s0)
ffffffffc020987c:	b7f9                	j	ffffffffc020984a <sfs_fsync+0x48>
ffffffffc020987e:	00005697          	auipc	a3,0x5
ffffffffc0209882:	3b268693          	addi	a3,a3,946 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc0209886:	00002617          	auipc	a2,0x2
ffffffffc020988a:	f7260613          	addi	a2,a2,-142 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020988e:	2b200593          	li	a1,690
ffffffffc0209892:	00005517          	auipc	a0,0x5
ffffffffc0209896:	57e50513          	addi	a0,a0,1406 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020989a:	995f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020989e:	00005697          	auipc	a3,0x5
ffffffffc02098a2:	53a68693          	addi	a3,a3,1338 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc02098a6:	00002617          	auipc	a2,0x2
ffffffffc02098aa:	f5260613          	addi	a2,a2,-174 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02098ae:	2b300593          	li	a1,691
ffffffffc02098b2:	00005517          	auipc	a0,0x5
ffffffffc02098b6:	55e50513          	addi	a0,a0,1374 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc02098ba:	975f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc02098be <sfs_fstat>:
ffffffffc02098be:	1101                	addi	sp,sp,-32
ffffffffc02098c0:	e426                	sd	s1,8(sp)
ffffffffc02098c2:	84ae                	mv	s1,a1
ffffffffc02098c4:	e822                	sd	s0,16(sp)
ffffffffc02098c6:	02000613          	li	a2,32
ffffffffc02098ca:	842a                	mv	s0,a0
ffffffffc02098cc:	4581                	li	a1,0
ffffffffc02098ce:	8526                	mv	a0,s1
ffffffffc02098d0:	ec06                	sd	ra,24(sp)
ffffffffc02098d2:	722010ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc02098d6:	c439                	beqz	s0,ffffffffc0209924 <sfs_fstat+0x66>
ffffffffc02098d8:	783c                	ld	a5,112(s0)
ffffffffc02098da:	c7a9                	beqz	a5,ffffffffc0209924 <sfs_fstat+0x66>
ffffffffc02098dc:	6bbc                	ld	a5,80(a5)
ffffffffc02098de:	c3b9                	beqz	a5,ffffffffc0209924 <sfs_fstat+0x66>
ffffffffc02098e0:	00005597          	auipc	a1,0x5
ffffffffc02098e4:	ad858593          	addi	a1,a1,-1320 # ffffffffc020e3b8 <syscalls+0x990>
ffffffffc02098e8:	8522                	mv	a0,s0
ffffffffc02098ea:	91ffe0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02098ee:	783c                	ld	a5,112(s0)
ffffffffc02098f0:	85a6                	mv	a1,s1
ffffffffc02098f2:	8522                	mv	a0,s0
ffffffffc02098f4:	6bbc                	ld	a5,80(a5)
ffffffffc02098f6:	9782                	jalr	a5
ffffffffc02098f8:	e10d                	bnez	a0,ffffffffc020991a <sfs_fstat+0x5c>
ffffffffc02098fa:	4c38                	lw	a4,88(s0)
ffffffffc02098fc:	6785                	lui	a5,0x1
ffffffffc02098fe:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209902:	04f71163          	bne	a4,a5,ffffffffc0209944 <sfs_fstat+0x86>
ffffffffc0209906:	601c                	ld	a5,0(s0)
ffffffffc0209908:	0067d683          	lhu	a3,6(a5)
ffffffffc020990c:	0087e703          	lwu	a4,8(a5)
ffffffffc0209910:	0007e783          	lwu	a5,0(a5)
ffffffffc0209914:	e494                	sd	a3,8(s1)
ffffffffc0209916:	e898                	sd	a4,16(s1)
ffffffffc0209918:	ec9c                	sd	a5,24(s1)
ffffffffc020991a:	60e2                	ld	ra,24(sp)
ffffffffc020991c:	6442                	ld	s0,16(sp)
ffffffffc020991e:	64a2                	ld	s1,8(sp)
ffffffffc0209920:	6105                	addi	sp,sp,32
ffffffffc0209922:	8082                	ret
ffffffffc0209924:	00005697          	auipc	a3,0x5
ffffffffc0209928:	a2c68693          	addi	a3,a3,-1492 # ffffffffc020e350 <syscalls+0x928>
ffffffffc020992c:	00002617          	auipc	a2,0x2
ffffffffc0209930:	ecc60613          	addi	a2,a2,-308 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209934:	2a300593          	li	a1,675
ffffffffc0209938:	00005517          	auipc	a0,0x5
ffffffffc020993c:	4d850513          	addi	a0,a0,1240 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209940:	8eff60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209944:	00005697          	auipc	a3,0x5
ffffffffc0209948:	49468693          	addi	a3,a3,1172 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020994c:	00002617          	auipc	a2,0x2
ffffffffc0209950:	eac60613          	addi	a2,a2,-340 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209954:	2a600593          	li	a1,678
ffffffffc0209958:	00005517          	auipc	a0,0x5
ffffffffc020995c:	4b850513          	addi	a0,a0,1208 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209960:	8cff60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209964 <sfs_tryseek>:
ffffffffc0209964:	080007b7          	lui	a5,0x8000
ffffffffc0209968:	04f5fd63          	bgeu	a1,a5,ffffffffc02099c2 <sfs_tryseek+0x5e>
ffffffffc020996c:	1101                	addi	sp,sp,-32
ffffffffc020996e:	e822                	sd	s0,16(sp)
ffffffffc0209970:	ec06                	sd	ra,24(sp)
ffffffffc0209972:	e426                	sd	s1,8(sp)
ffffffffc0209974:	842a                	mv	s0,a0
ffffffffc0209976:	c921                	beqz	a0,ffffffffc02099c6 <sfs_tryseek+0x62>
ffffffffc0209978:	4d38                	lw	a4,88(a0)
ffffffffc020997a:	6785                	lui	a5,0x1
ffffffffc020997c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209980:	04f71363          	bne	a4,a5,ffffffffc02099c6 <sfs_tryseek+0x62>
ffffffffc0209984:	611c                	ld	a5,0(a0)
ffffffffc0209986:	84ae                	mv	s1,a1
ffffffffc0209988:	0007e783          	lwu	a5,0(a5)
ffffffffc020998c:	02b7d563          	bge	a5,a1,ffffffffc02099b6 <sfs_tryseek+0x52>
ffffffffc0209990:	793c                	ld	a5,112(a0)
ffffffffc0209992:	cbb1                	beqz	a5,ffffffffc02099e6 <sfs_tryseek+0x82>
ffffffffc0209994:	73bc                	ld	a5,96(a5)
ffffffffc0209996:	cba1                	beqz	a5,ffffffffc02099e6 <sfs_tryseek+0x82>
ffffffffc0209998:	00005597          	auipc	a1,0x5
ffffffffc020999c:	c5858593          	addi	a1,a1,-936 # ffffffffc020e5f0 <syscalls+0xbc8>
ffffffffc02099a0:	869fe0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc02099a4:	783c                	ld	a5,112(s0)
ffffffffc02099a6:	8522                	mv	a0,s0
ffffffffc02099a8:	6442                	ld	s0,16(sp)
ffffffffc02099aa:	60e2                	ld	ra,24(sp)
ffffffffc02099ac:	73bc                	ld	a5,96(a5)
ffffffffc02099ae:	85a6                	mv	a1,s1
ffffffffc02099b0:	64a2                	ld	s1,8(sp)
ffffffffc02099b2:	6105                	addi	sp,sp,32
ffffffffc02099b4:	8782                	jr	a5
ffffffffc02099b6:	60e2                	ld	ra,24(sp)
ffffffffc02099b8:	6442                	ld	s0,16(sp)
ffffffffc02099ba:	64a2                	ld	s1,8(sp)
ffffffffc02099bc:	4501                	li	a0,0
ffffffffc02099be:	6105                	addi	sp,sp,32
ffffffffc02099c0:	8082                	ret
ffffffffc02099c2:	5575                	li	a0,-3
ffffffffc02099c4:	8082                	ret
ffffffffc02099c6:	00005697          	auipc	a3,0x5
ffffffffc02099ca:	41268693          	addi	a3,a3,1042 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc02099ce:	00002617          	auipc	a2,0x2
ffffffffc02099d2:	e2a60613          	addi	a2,a2,-470 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02099d6:	38500593          	li	a1,901
ffffffffc02099da:	00005517          	auipc	a0,0x5
ffffffffc02099de:	43650513          	addi	a0,a0,1078 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc02099e2:	84df60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc02099e6:	00005697          	auipc	a3,0x5
ffffffffc02099ea:	bb268693          	addi	a3,a3,-1102 # ffffffffc020e598 <syscalls+0xb70>
ffffffffc02099ee:	00002617          	auipc	a2,0x2
ffffffffc02099f2:	e0a60613          	addi	a2,a2,-502 # ffffffffc020b7f8 <commands+0x60>
ffffffffc02099f6:	38700593          	li	a1,903
ffffffffc02099fa:	00005517          	auipc	a0,0x5
ffffffffc02099fe:	41650513          	addi	a0,a0,1046 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209a02:	82df60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209a06 <sfs_close>:
ffffffffc0209a06:	1141                	addi	sp,sp,-16
ffffffffc0209a08:	e406                	sd	ra,8(sp)
ffffffffc0209a0a:	e022                	sd	s0,0(sp)
ffffffffc0209a0c:	c11d                	beqz	a0,ffffffffc0209a32 <sfs_close+0x2c>
ffffffffc0209a0e:	793c                	ld	a5,112(a0)
ffffffffc0209a10:	842a                	mv	s0,a0
ffffffffc0209a12:	c385                	beqz	a5,ffffffffc0209a32 <sfs_close+0x2c>
ffffffffc0209a14:	7b9c                	ld	a5,48(a5)
ffffffffc0209a16:	cf91                	beqz	a5,ffffffffc0209a32 <sfs_close+0x2c>
ffffffffc0209a18:	00004597          	auipc	a1,0x4
ffffffffc0209a1c:	90058593          	addi	a1,a1,-1792 # ffffffffc020d318 <default_pmm_manager+0xb58>
ffffffffc0209a20:	fe8fe0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0209a24:	783c                	ld	a5,112(s0)
ffffffffc0209a26:	8522                	mv	a0,s0
ffffffffc0209a28:	6402                	ld	s0,0(sp)
ffffffffc0209a2a:	60a2                	ld	ra,8(sp)
ffffffffc0209a2c:	7b9c                	ld	a5,48(a5)
ffffffffc0209a2e:	0141                	addi	sp,sp,16
ffffffffc0209a30:	8782                	jr	a5
ffffffffc0209a32:	00004697          	auipc	a3,0x4
ffffffffc0209a36:	89668693          	addi	a3,a3,-1898 # ffffffffc020d2c8 <default_pmm_manager+0xb08>
ffffffffc0209a3a:	00002617          	auipc	a2,0x2
ffffffffc0209a3e:	dbe60613          	addi	a2,a2,-578 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209a42:	21c00593          	li	a1,540
ffffffffc0209a46:	00005517          	auipc	a0,0x5
ffffffffc0209a4a:	3ca50513          	addi	a0,a0,970 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209a4e:	fe0f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209a52 <sfs_io.part.0>:
ffffffffc0209a52:	1141                	addi	sp,sp,-16
ffffffffc0209a54:	00005697          	auipc	a3,0x5
ffffffffc0209a58:	38468693          	addi	a3,a3,900 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc0209a5c:	00002617          	auipc	a2,0x2
ffffffffc0209a60:	d9c60613          	addi	a2,a2,-612 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209a64:	28200593          	li	a1,642
ffffffffc0209a68:	00005517          	auipc	a0,0x5
ffffffffc0209a6c:	3a850513          	addi	a0,a0,936 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209a70:	e406                	sd	ra,8(sp)
ffffffffc0209a72:	fbcf60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209a76 <sfs_block_free>:
ffffffffc0209a76:	1101                	addi	sp,sp,-32
ffffffffc0209a78:	e426                	sd	s1,8(sp)
ffffffffc0209a7a:	ec06                	sd	ra,24(sp)
ffffffffc0209a7c:	e822                	sd	s0,16(sp)
ffffffffc0209a7e:	4154                	lw	a3,4(a0)
ffffffffc0209a80:	84ae                	mv	s1,a1
ffffffffc0209a82:	c595                	beqz	a1,ffffffffc0209aae <sfs_block_free+0x38>
ffffffffc0209a84:	02d5f563          	bgeu	a1,a3,ffffffffc0209aae <sfs_block_free+0x38>
ffffffffc0209a88:	842a                	mv	s0,a0
ffffffffc0209a8a:	7d08                	ld	a0,56(a0)
ffffffffc0209a8c:	424010ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc0209a90:	ed05                	bnez	a0,ffffffffc0209ac8 <sfs_block_free+0x52>
ffffffffc0209a92:	7c08                	ld	a0,56(s0)
ffffffffc0209a94:	85a6                	mv	a1,s1
ffffffffc0209a96:	442010ef          	jal	ra,ffffffffc020aed8 <bitmap_free>
ffffffffc0209a9a:	441c                	lw	a5,8(s0)
ffffffffc0209a9c:	4705                	li	a4,1
ffffffffc0209a9e:	60e2                	ld	ra,24(sp)
ffffffffc0209aa0:	2785                	addiw	a5,a5,1
ffffffffc0209aa2:	e038                	sd	a4,64(s0)
ffffffffc0209aa4:	c41c                	sw	a5,8(s0)
ffffffffc0209aa6:	6442                	ld	s0,16(sp)
ffffffffc0209aa8:	64a2                	ld	s1,8(sp)
ffffffffc0209aaa:	6105                	addi	sp,sp,32
ffffffffc0209aac:	8082                	ret
ffffffffc0209aae:	8726                	mv	a4,s1
ffffffffc0209ab0:	00005617          	auipc	a2,0x5
ffffffffc0209ab4:	39060613          	addi	a2,a2,912 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc0209ab8:	05300593          	li	a1,83
ffffffffc0209abc:	00005517          	auipc	a0,0x5
ffffffffc0209ac0:	35450513          	addi	a0,a0,852 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209ac4:	f6af60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209ac8:	00005697          	auipc	a3,0x5
ffffffffc0209acc:	3b068693          	addi	a3,a3,944 # ffffffffc020ee78 <dev_node_ops+0x398>
ffffffffc0209ad0:	00002617          	auipc	a2,0x2
ffffffffc0209ad4:	d2860613          	addi	a2,a2,-728 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209ad8:	06a00593          	li	a1,106
ffffffffc0209adc:	00005517          	auipc	a0,0x5
ffffffffc0209ae0:	33450513          	addi	a0,a0,820 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209ae4:	f4af60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209ae8 <sfs_reclaim>:
ffffffffc0209ae8:	1101                	addi	sp,sp,-32
ffffffffc0209aea:	e426                	sd	s1,8(sp)
ffffffffc0209aec:	7524                	ld	s1,104(a0)
ffffffffc0209aee:	ec06                	sd	ra,24(sp)
ffffffffc0209af0:	e822                	sd	s0,16(sp)
ffffffffc0209af2:	e04a                	sd	s2,0(sp)
ffffffffc0209af4:	0e048a63          	beqz	s1,ffffffffc0209be8 <sfs_reclaim+0x100>
ffffffffc0209af8:	0b04a783          	lw	a5,176(s1)
ffffffffc0209afc:	0e079663          	bnez	a5,ffffffffc0209be8 <sfs_reclaim+0x100>
ffffffffc0209b00:	4d38                	lw	a4,88(a0)
ffffffffc0209b02:	6785                	lui	a5,0x1
ffffffffc0209b04:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209b08:	842a                	mv	s0,a0
ffffffffc0209b0a:	10f71f63          	bne	a4,a5,ffffffffc0209c28 <sfs_reclaim+0x140>
ffffffffc0209b0e:	8526                	mv	a0,s1
ffffffffc0209b10:	f0aff0ef          	jal	ra,ffffffffc020921a <lock_sfs_fs>
ffffffffc0209b14:	4c1c                	lw	a5,24(s0)
ffffffffc0209b16:	0ef05963          	blez	a5,ffffffffc0209c08 <sfs_reclaim+0x120>
ffffffffc0209b1a:	fff7871b          	addiw	a4,a5,-1
ffffffffc0209b1e:	cc18                	sw	a4,24(s0)
ffffffffc0209b20:	eb59                	bnez	a4,ffffffffc0209bb6 <sfs_reclaim+0xce>
ffffffffc0209b22:	05c42903          	lw	s2,92(s0)
ffffffffc0209b26:	08091863          	bnez	s2,ffffffffc0209bb6 <sfs_reclaim+0xce>
ffffffffc0209b2a:	601c                	ld	a5,0(s0)
ffffffffc0209b2c:	0067d783          	lhu	a5,6(a5)
ffffffffc0209b30:	e785                	bnez	a5,ffffffffc0209b58 <sfs_reclaim+0x70>
ffffffffc0209b32:	783c                	ld	a5,112(s0)
ffffffffc0209b34:	10078a63          	beqz	a5,ffffffffc0209c48 <sfs_reclaim+0x160>
ffffffffc0209b38:	73bc                	ld	a5,96(a5)
ffffffffc0209b3a:	10078763          	beqz	a5,ffffffffc0209c48 <sfs_reclaim+0x160>
ffffffffc0209b3e:	00005597          	auipc	a1,0x5
ffffffffc0209b42:	ab258593          	addi	a1,a1,-1358 # ffffffffc020e5f0 <syscalls+0xbc8>
ffffffffc0209b46:	8522                	mv	a0,s0
ffffffffc0209b48:	ec0fe0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0209b4c:	783c                	ld	a5,112(s0)
ffffffffc0209b4e:	4581                	li	a1,0
ffffffffc0209b50:	8522                	mv	a0,s0
ffffffffc0209b52:	73bc                	ld	a5,96(a5)
ffffffffc0209b54:	9782                	jalr	a5
ffffffffc0209b56:	e559                	bnez	a0,ffffffffc0209be4 <sfs_reclaim+0xfc>
ffffffffc0209b58:	681c                	ld	a5,16(s0)
ffffffffc0209b5a:	c39d                	beqz	a5,ffffffffc0209b80 <sfs_reclaim+0x98>
ffffffffc0209b5c:	783c                	ld	a5,112(s0)
ffffffffc0209b5e:	10078563          	beqz	a5,ffffffffc0209c68 <sfs_reclaim+0x180>
ffffffffc0209b62:	7b9c                	ld	a5,48(a5)
ffffffffc0209b64:	10078263          	beqz	a5,ffffffffc0209c68 <sfs_reclaim+0x180>
ffffffffc0209b68:	8522                	mv	a0,s0
ffffffffc0209b6a:	00003597          	auipc	a1,0x3
ffffffffc0209b6e:	7ae58593          	addi	a1,a1,1966 # ffffffffc020d318 <default_pmm_manager+0xb58>
ffffffffc0209b72:	e96fe0ef          	jal	ra,ffffffffc0208208 <inode_check>
ffffffffc0209b76:	783c                	ld	a5,112(s0)
ffffffffc0209b78:	8522                	mv	a0,s0
ffffffffc0209b7a:	7b9c                	ld	a5,48(a5)
ffffffffc0209b7c:	9782                	jalr	a5
ffffffffc0209b7e:	e13d                	bnez	a0,ffffffffc0209be4 <sfs_reclaim+0xfc>
ffffffffc0209b80:	7c18                	ld	a4,56(s0)
ffffffffc0209b82:	603c                	ld	a5,64(s0)
ffffffffc0209b84:	8526                	mv	a0,s1
ffffffffc0209b86:	e71c                	sd	a5,8(a4)
ffffffffc0209b88:	e398                	sd	a4,0(a5)
ffffffffc0209b8a:	6438                	ld	a4,72(s0)
ffffffffc0209b8c:	683c                	ld	a5,80(s0)
ffffffffc0209b8e:	e71c                	sd	a5,8(a4)
ffffffffc0209b90:	e398                	sd	a4,0(a5)
ffffffffc0209b92:	e98ff0ef          	jal	ra,ffffffffc020922a <unlock_sfs_fs>
ffffffffc0209b96:	6008                	ld	a0,0(s0)
ffffffffc0209b98:	00655783          	lhu	a5,6(a0)
ffffffffc0209b9c:	cb85                	beqz	a5,ffffffffc0209bcc <sfs_reclaim+0xe4>
ffffffffc0209b9e:	a28f80ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc0209ba2:	8522                	mv	a0,s0
ffffffffc0209ba4:	df8fe0ef          	jal	ra,ffffffffc020819c <inode_kill>
ffffffffc0209ba8:	60e2                	ld	ra,24(sp)
ffffffffc0209baa:	6442                	ld	s0,16(sp)
ffffffffc0209bac:	64a2                	ld	s1,8(sp)
ffffffffc0209bae:	854a                	mv	a0,s2
ffffffffc0209bb0:	6902                	ld	s2,0(sp)
ffffffffc0209bb2:	6105                	addi	sp,sp,32
ffffffffc0209bb4:	8082                	ret
ffffffffc0209bb6:	5945                	li	s2,-15
ffffffffc0209bb8:	8526                	mv	a0,s1
ffffffffc0209bba:	e70ff0ef          	jal	ra,ffffffffc020922a <unlock_sfs_fs>
ffffffffc0209bbe:	60e2                	ld	ra,24(sp)
ffffffffc0209bc0:	6442                	ld	s0,16(sp)
ffffffffc0209bc2:	64a2                	ld	s1,8(sp)
ffffffffc0209bc4:	854a                	mv	a0,s2
ffffffffc0209bc6:	6902                	ld	s2,0(sp)
ffffffffc0209bc8:	6105                	addi	sp,sp,32
ffffffffc0209bca:	8082                	ret
ffffffffc0209bcc:	440c                	lw	a1,8(s0)
ffffffffc0209bce:	8526                	mv	a0,s1
ffffffffc0209bd0:	ea7ff0ef          	jal	ra,ffffffffc0209a76 <sfs_block_free>
ffffffffc0209bd4:	6008                	ld	a0,0(s0)
ffffffffc0209bd6:	5d4c                	lw	a1,60(a0)
ffffffffc0209bd8:	d1f9                	beqz	a1,ffffffffc0209b9e <sfs_reclaim+0xb6>
ffffffffc0209bda:	8526                	mv	a0,s1
ffffffffc0209bdc:	e9bff0ef          	jal	ra,ffffffffc0209a76 <sfs_block_free>
ffffffffc0209be0:	6008                	ld	a0,0(s0)
ffffffffc0209be2:	bf75                	j	ffffffffc0209b9e <sfs_reclaim+0xb6>
ffffffffc0209be4:	892a                	mv	s2,a0
ffffffffc0209be6:	bfc9                	j	ffffffffc0209bb8 <sfs_reclaim+0xd0>
ffffffffc0209be8:	00005697          	auipc	a3,0x5
ffffffffc0209bec:	04868693          	addi	a3,a3,72 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc0209bf0:	00002617          	auipc	a2,0x2
ffffffffc0209bf4:	c0860613          	addi	a2,a2,-1016 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209bf8:	34300593          	li	a1,835
ffffffffc0209bfc:	00005517          	auipc	a0,0x5
ffffffffc0209c00:	21450513          	addi	a0,a0,532 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209c04:	e2af60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209c08:	00005697          	auipc	a3,0x5
ffffffffc0209c0c:	29068693          	addi	a3,a3,656 # ffffffffc020ee98 <dev_node_ops+0x3b8>
ffffffffc0209c10:	00002617          	auipc	a2,0x2
ffffffffc0209c14:	be860613          	addi	a2,a2,-1048 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209c18:	34900593          	li	a1,841
ffffffffc0209c1c:	00005517          	auipc	a0,0x5
ffffffffc0209c20:	1f450513          	addi	a0,a0,500 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209c24:	e0af60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209c28:	00005697          	auipc	a3,0x5
ffffffffc0209c2c:	1b068693          	addi	a3,a3,432 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc0209c30:	00002617          	auipc	a2,0x2
ffffffffc0209c34:	bc860613          	addi	a2,a2,-1080 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209c38:	34400593          	li	a1,836
ffffffffc0209c3c:	00005517          	auipc	a0,0x5
ffffffffc0209c40:	1d450513          	addi	a0,a0,468 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209c44:	deaf60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209c48:	00005697          	auipc	a3,0x5
ffffffffc0209c4c:	95068693          	addi	a3,a3,-1712 # ffffffffc020e598 <syscalls+0xb70>
ffffffffc0209c50:	00002617          	auipc	a2,0x2
ffffffffc0209c54:	ba860613          	addi	a2,a2,-1112 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209c58:	34e00593          	li	a1,846
ffffffffc0209c5c:	00005517          	auipc	a0,0x5
ffffffffc0209c60:	1b450513          	addi	a0,a0,436 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209c64:	dcaf60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209c68:	00003697          	auipc	a3,0x3
ffffffffc0209c6c:	66068693          	addi	a3,a3,1632 # ffffffffc020d2c8 <default_pmm_manager+0xb08>
ffffffffc0209c70:	00002617          	auipc	a2,0x2
ffffffffc0209c74:	b8860613          	addi	a2,a2,-1144 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209c78:	35300593          	li	a1,851
ffffffffc0209c7c:	00005517          	auipc	a0,0x5
ffffffffc0209c80:	19450513          	addi	a0,a0,404 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209c84:	daaf60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209c88 <sfs_block_alloc>:
ffffffffc0209c88:	1101                	addi	sp,sp,-32
ffffffffc0209c8a:	e822                	sd	s0,16(sp)
ffffffffc0209c8c:	842a                	mv	s0,a0
ffffffffc0209c8e:	7d08                	ld	a0,56(a0)
ffffffffc0209c90:	e426                	sd	s1,8(sp)
ffffffffc0209c92:	ec06                	sd	ra,24(sp)
ffffffffc0209c94:	84ae                	mv	s1,a1
ffffffffc0209c96:	1aa010ef          	jal	ra,ffffffffc020ae40 <bitmap_alloc>
ffffffffc0209c9a:	e90d                	bnez	a0,ffffffffc0209ccc <sfs_block_alloc+0x44>
ffffffffc0209c9c:	441c                	lw	a5,8(s0)
ffffffffc0209c9e:	cbad                	beqz	a5,ffffffffc0209d10 <sfs_block_alloc+0x88>
ffffffffc0209ca0:	37fd                	addiw	a5,a5,-1
ffffffffc0209ca2:	c41c                	sw	a5,8(s0)
ffffffffc0209ca4:	408c                	lw	a1,0(s1)
ffffffffc0209ca6:	4785                	li	a5,1
ffffffffc0209ca8:	e03c                	sd	a5,64(s0)
ffffffffc0209caa:	4054                	lw	a3,4(s0)
ffffffffc0209cac:	c58d                	beqz	a1,ffffffffc0209cd6 <sfs_block_alloc+0x4e>
ffffffffc0209cae:	02d5f463          	bgeu	a1,a3,ffffffffc0209cd6 <sfs_block_alloc+0x4e>
ffffffffc0209cb2:	7c08                	ld	a0,56(s0)
ffffffffc0209cb4:	1fc010ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc0209cb8:	ed05                	bnez	a0,ffffffffc0209cf0 <sfs_block_alloc+0x68>
ffffffffc0209cba:	8522                	mv	a0,s0
ffffffffc0209cbc:	6442                	ld	s0,16(sp)
ffffffffc0209cbe:	408c                	lw	a1,0(s1)
ffffffffc0209cc0:	60e2                	ld	ra,24(sp)
ffffffffc0209cc2:	64a2                	ld	s1,8(sp)
ffffffffc0209cc4:	4605                	li	a2,1
ffffffffc0209cc6:	6105                	addi	sp,sp,32
ffffffffc0209cc8:	cf2ff06f          	j	ffffffffc02091ba <sfs_clear_block>
ffffffffc0209ccc:	60e2                	ld	ra,24(sp)
ffffffffc0209cce:	6442                	ld	s0,16(sp)
ffffffffc0209cd0:	64a2                	ld	s1,8(sp)
ffffffffc0209cd2:	6105                	addi	sp,sp,32
ffffffffc0209cd4:	8082                	ret
ffffffffc0209cd6:	872e                	mv	a4,a1
ffffffffc0209cd8:	00005617          	auipc	a2,0x5
ffffffffc0209cdc:	16860613          	addi	a2,a2,360 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc0209ce0:	05300593          	li	a1,83
ffffffffc0209ce4:	00005517          	auipc	a0,0x5
ffffffffc0209ce8:	12c50513          	addi	a0,a0,300 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209cec:	d42f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209cf0:	00005697          	auipc	a3,0x5
ffffffffc0209cf4:	1e068693          	addi	a3,a3,480 # ffffffffc020eed0 <dev_node_ops+0x3f0>
ffffffffc0209cf8:	00002617          	auipc	a2,0x2
ffffffffc0209cfc:	b0060613          	addi	a2,a2,-1280 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209d00:	06100593          	li	a1,97
ffffffffc0209d04:	00005517          	auipc	a0,0x5
ffffffffc0209d08:	10c50513          	addi	a0,a0,268 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209d0c:	d22f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209d10:	00005697          	auipc	a3,0x5
ffffffffc0209d14:	1a068693          	addi	a3,a3,416 # ffffffffc020eeb0 <dev_node_ops+0x3d0>
ffffffffc0209d18:	00002617          	auipc	a2,0x2
ffffffffc0209d1c:	ae060613          	addi	a2,a2,-1312 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209d20:	05f00593          	li	a1,95
ffffffffc0209d24:	00005517          	auipc	a0,0x5
ffffffffc0209d28:	0ec50513          	addi	a0,a0,236 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209d2c:	d02f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209d30 <sfs_bmap_load_nolock>:
ffffffffc0209d30:	7159                	addi	sp,sp,-112
ffffffffc0209d32:	f85a                	sd	s6,48(sp)
ffffffffc0209d34:	0005bb03          	ld	s6,0(a1)
ffffffffc0209d38:	f45e                	sd	s7,40(sp)
ffffffffc0209d3a:	f486                	sd	ra,104(sp)
ffffffffc0209d3c:	008b2b83          	lw	s7,8(s6)
ffffffffc0209d40:	f0a2                	sd	s0,96(sp)
ffffffffc0209d42:	eca6                	sd	s1,88(sp)
ffffffffc0209d44:	e8ca                	sd	s2,80(sp)
ffffffffc0209d46:	e4ce                	sd	s3,72(sp)
ffffffffc0209d48:	e0d2                	sd	s4,64(sp)
ffffffffc0209d4a:	fc56                	sd	s5,56(sp)
ffffffffc0209d4c:	f062                	sd	s8,32(sp)
ffffffffc0209d4e:	ec66                	sd	s9,24(sp)
ffffffffc0209d50:	18cbe363          	bltu	s7,a2,ffffffffc0209ed6 <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209d54:	47ad                	li	a5,11
ffffffffc0209d56:	8aae                	mv	s5,a1
ffffffffc0209d58:	8432                	mv	s0,a2
ffffffffc0209d5a:	84aa                	mv	s1,a0
ffffffffc0209d5c:	89b6                	mv	s3,a3
ffffffffc0209d5e:	04c7f563          	bgeu	a5,a2,ffffffffc0209da8 <sfs_bmap_load_nolock+0x78>
ffffffffc0209d62:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209d66:	0007069b          	sext.w	a3,a4
ffffffffc0209d6a:	3ff00793          	li	a5,1023
ffffffffc0209d6e:	1ad7e163          	bltu	a5,a3,ffffffffc0209f10 <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209d72:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209d76:	02071793          	slli	a5,a4,0x20
ffffffffc0209d7a:	c602                	sw	zero,12(sp)
ffffffffc0209d7c:	c452                	sw	s4,8(sp)
ffffffffc0209d7e:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209d82:	0e0a1e63          	bnez	s4,ffffffffc0209e7e <sfs_bmap_load_nolock+0x14e>
ffffffffc0209d86:	0acb8663          	beq	s7,a2,ffffffffc0209e32 <sfs_bmap_load_nolock+0x102>
ffffffffc0209d8a:	4a01                	li	s4,0
ffffffffc0209d8c:	40d4                	lw	a3,4(s1)
ffffffffc0209d8e:	8752                	mv	a4,s4
ffffffffc0209d90:	00005617          	auipc	a2,0x5
ffffffffc0209d94:	0b060613          	addi	a2,a2,176 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc0209d98:	05300593          	li	a1,83
ffffffffc0209d9c:	00005517          	auipc	a0,0x5
ffffffffc0209da0:	07450513          	addi	a0,a0,116 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209da4:	c8af60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209da8:	02061793          	slli	a5,a2,0x20
ffffffffc0209dac:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209db0:	9a5a                	add	s4,s4,s6
ffffffffc0209db2:	00ca2583          	lw	a1,12(s4)
ffffffffc0209db6:	c22e                	sw	a1,4(sp)
ffffffffc0209db8:	ed99                	bnez	a1,ffffffffc0209dd6 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209dba:	fccb98e3          	bne	s7,a2,ffffffffc0209d8a <sfs_bmap_load_nolock+0x5a>
ffffffffc0209dbe:	004c                	addi	a1,sp,4
ffffffffc0209dc0:	ec9ff0ef          	jal	ra,ffffffffc0209c88 <sfs_block_alloc>
ffffffffc0209dc4:	892a                	mv	s2,a0
ffffffffc0209dc6:	e921                	bnez	a0,ffffffffc0209e16 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209dc8:	4592                	lw	a1,4(sp)
ffffffffc0209dca:	4705                	li	a4,1
ffffffffc0209dcc:	00ba2623          	sw	a1,12(s4)
ffffffffc0209dd0:	00eab823          	sd	a4,16(s5)
ffffffffc0209dd4:	d9dd                	beqz	a1,ffffffffc0209d8a <sfs_bmap_load_nolock+0x5a>
ffffffffc0209dd6:	40d4                	lw	a3,4(s1)
ffffffffc0209dd8:	10d5ff63          	bgeu	a1,a3,ffffffffc0209ef6 <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209ddc:	7c88                	ld	a0,56(s1)
ffffffffc0209dde:	0d2010ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc0209de2:	18051363          	bnez	a0,ffffffffc0209f68 <sfs_bmap_load_nolock+0x238>
ffffffffc0209de6:	4a12                	lw	s4,4(sp)
ffffffffc0209de8:	fa0a02e3          	beqz	s4,ffffffffc0209d8c <sfs_bmap_load_nolock+0x5c>
ffffffffc0209dec:	40dc                	lw	a5,4(s1)
ffffffffc0209dee:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209d8c <sfs_bmap_load_nolock+0x5c>
ffffffffc0209df2:	7c88                	ld	a0,56(s1)
ffffffffc0209df4:	85d2                	mv	a1,s4
ffffffffc0209df6:	0ba010ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc0209dfa:	12051763          	bnez	a0,ffffffffc0209f28 <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209dfe:	008b9763          	bne	s7,s0,ffffffffc0209e0c <sfs_bmap_load_nolock+0xdc>
ffffffffc0209e02:	008b2783          	lw	a5,8(s6)
ffffffffc0209e06:	2785                	addiw	a5,a5,1
ffffffffc0209e08:	00fb2423          	sw	a5,8(s6)
ffffffffc0209e0c:	4901                	li	s2,0
ffffffffc0209e0e:	00098463          	beqz	s3,ffffffffc0209e16 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209e12:	0149a023          	sw	s4,0(s3)
ffffffffc0209e16:	70a6                	ld	ra,104(sp)
ffffffffc0209e18:	7406                	ld	s0,96(sp)
ffffffffc0209e1a:	64e6                	ld	s1,88(sp)
ffffffffc0209e1c:	69a6                	ld	s3,72(sp)
ffffffffc0209e1e:	6a06                	ld	s4,64(sp)
ffffffffc0209e20:	7ae2                	ld	s5,56(sp)
ffffffffc0209e22:	7b42                	ld	s6,48(sp)
ffffffffc0209e24:	7ba2                	ld	s7,40(sp)
ffffffffc0209e26:	7c02                	ld	s8,32(sp)
ffffffffc0209e28:	6ce2                	ld	s9,24(sp)
ffffffffc0209e2a:	854a                	mv	a0,s2
ffffffffc0209e2c:	6946                	ld	s2,80(sp)
ffffffffc0209e2e:	6165                	addi	sp,sp,112
ffffffffc0209e30:	8082                	ret
ffffffffc0209e32:	002c                	addi	a1,sp,8
ffffffffc0209e34:	e55ff0ef          	jal	ra,ffffffffc0209c88 <sfs_block_alloc>
ffffffffc0209e38:	892a                	mv	s2,a0
ffffffffc0209e3a:	00c10c93          	addi	s9,sp,12
ffffffffc0209e3e:	fd61                	bnez	a0,ffffffffc0209e16 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209e40:	85e6                	mv	a1,s9
ffffffffc0209e42:	8526                	mv	a0,s1
ffffffffc0209e44:	e45ff0ef          	jal	ra,ffffffffc0209c88 <sfs_block_alloc>
ffffffffc0209e48:	892a                	mv	s2,a0
ffffffffc0209e4a:	e925                	bnez	a0,ffffffffc0209eba <sfs_bmap_load_nolock+0x18a>
ffffffffc0209e4c:	46a2                	lw	a3,8(sp)
ffffffffc0209e4e:	85e6                	mv	a1,s9
ffffffffc0209e50:	8762                	mv	a4,s8
ffffffffc0209e52:	4611                	li	a2,4
ffffffffc0209e54:	8526                	mv	a0,s1
ffffffffc0209e56:	a14ff0ef          	jal	ra,ffffffffc020906a <sfs_wbuf>
ffffffffc0209e5a:	45b2                	lw	a1,12(sp)
ffffffffc0209e5c:	892a                	mv	s2,a0
ffffffffc0209e5e:	e939                	bnez	a0,ffffffffc0209eb4 <sfs_bmap_load_nolock+0x184>
ffffffffc0209e60:	03cb2683          	lw	a3,60(s6)
ffffffffc0209e64:	4722                	lw	a4,8(sp)
ffffffffc0209e66:	c22e                	sw	a1,4(sp)
ffffffffc0209e68:	f6d706e3          	beq	a4,a3,ffffffffc0209dd4 <sfs_bmap_load_nolock+0xa4>
ffffffffc0209e6c:	eef1                	bnez	a3,ffffffffc0209f48 <sfs_bmap_load_nolock+0x218>
ffffffffc0209e6e:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209e72:	4705                	li	a4,1
ffffffffc0209e74:	00eab823          	sd	a4,16(s5)
ffffffffc0209e78:	f00589e3          	beqz	a1,ffffffffc0209d8a <sfs_bmap_load_nolock+0x5a>
ffffffffc0209e7c:	bfa9                	j	ffffffffc0209dd6 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209e7e:	00c10c93          	addi	s9,sp,12
ffffffffc0209e82:	8762                	mv	a4,s8
ffffffffc0209e84:	86d2                	mv	a3,s4
ffffffffc0209e86:	4611                	li	a2,4
ffffffffc0209e88:	85e6                	mv	a1,s9
ffffffffc0209e8a:	960ff0ef          	jal	ra,ffffffffc0208fea <sfs_rbuf>
ffffffffc0209e8e:	892a                	mv	s2,a0
ffffffffc0209e90:	f159                	bnez	a0,ffffffffc0209e16 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209e92:	45b2                	lw	a1,12(sp)
ffffffffc0209e94:	e995                	bnez	a1,ffffffffc0209ec8 <sfs_bmap_load_nolock+0x198>
ffffffffc0209e96:	fa8b85e3          	beq	s7,s0,ffffffffc0209e40 <sfs_bmap_load_nolock+0x110>
ffffffffc0209e9a:	03cb2703          	lw	a4,60(s6)
ffffffffc0209e9e:	47a2                	lw	a5,8(sp)
ffffffffc0209ea0:	c202                	sw	zero,4(sp)
ffffffffc0209ea2:	eee784e3          	beq	a5,a4,ffffffffc0209d8a <sfs_bmap_load_nolock+0x5a>
ffffffffc0209ea6:	e34d                	bnez	a4,ffffffffc0209f48 <sfs_bmap_load_nolock+0x218>
ffffffffc0209ea8:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209eac:	4785                	li	a5,1
ffffffffc0209eae:	00fab823          	sd	a5,16(s5)
ffffffffc0209eb2:	bde1                	j	ffffffffc0209d8a <sfs_bmap_load_nolock+0x5a>
ffffffffc0209eb4:	8526                	mv	a0,s1
ffffffffc0209eb6:	bc1ff0ef          	jal	ra,ffffffffc0209a76 <sfs_block_free>
ffffffffc0209eba:	45a2                	lw	a1,8(sp)
ffffffffc0209ebc:	f4ba0de3          	beq	s4,a1,ffffffffc0209e16 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ec0:	8526                	mv	a0,s1
ffffffffc0209ec2:	bb5ff0ef          	jal	ra,ffffffffc0209a76 <sfs_block_free>
ffffffffc0209ec6:	bf81                	j	ffffffffc0209e16 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ec8:	03cb2683          	lw	a3,60(s6)
ffffffffc0209ecc:	4722                	lw	a4,8(sp)
ffffffffc0209ece:	c22e                	sw	a1,4(sp)
ffffffffc0209ed0:	f8e69ee3          	bne	a3,a4,ffffffffc0209e6c <sfs_bmap_load_nolock+0x13c>
ffffffffc0209ed4:	b709                	j	ffffffffc0209dd6 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209ed6:	00005697          	auipc	a3,0x5
ffffffffc0209eda:	02268693          	addi	a3,a3,34 # ffffffffc020eef8 <dev_node_ops+0x418>
ffffffffc0209ede:	00002617          	auipc	a2,0x2
ffffffffc0209ee2:	91a60613          	addi	a2,a2,-1766 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209ee6:	16400593          	li	a1,356
ffffffffc0209eea:	00005517          	auipc	a0,0x5
ffffffffc0209eee:	f2650513          	addi	a0,a0,-218 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209ef2:	b3cf60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209ef6:	872e                	mv	a4,a1
ffffffffc0209ef8:	00005617          	auipc	a2,0x5
ffffffffc0209efc:	f4860613          	addi	a2,a2,-184 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc0209f00:	05300593          	li	a1,83
ffffffffc0209f04:	00005517          	auipc	a0,0x5
ffffffffc0209f08:	f0c50513          	addi	a0,a0,-244 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209f0c:	b22f60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209f10:	00005617          	auipc	a2,0x5
ffffffffc0209f14:	01860613          	addi	a2,a2,24 # ffffffffc020ef28 <dev_node_ops+0x448>
ffffffffc0209f18:	11e00593          	li	a1,286
ffffffffc0209f1c:	00005517          	auipc	a0,0x5
ffffffffc0209f20:	ef450513          	addi	a0,a0,-268 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209f24:	b0af60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209f28:	00005697          	auipc	a3,0x5
ffffffffc0209f2c:	f5068693          	addi	a3,a3,-176 # ffffffffc020ee78 <dev_node_ops+0x398>
ffffffffc0209f30:	00002617          	auipc	a2,0x2
ffffffffc0209f34:	8c860613          	addi	a2,a2,-1848 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209f38:	16b00593          	li	a1,363
ffffffffc0209f3c:	00005517          	auipc	a0,0x5
ffffffffc0209f40:	ed450513          	addi	a0,a0,-300 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209f44:	aeaf60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209f48:	00005697          	auipc	a3,0x5
ffffffffc0209f4c:	fc868693          	addi	a3,a3,-56 # ffffffffc020ef10 <dev_node_ops+0x430>
ffffffffc0209f50:	00002617          	auipc	a2,0x2
ffffffffc0209f54:	8a860613          	addi	a2,a2,-1880 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209f58:	11800593          	li	a1,280
ffffffffc0209f5c:	00005517          	auipc	a0,0x5
ffffffffc0209f60:	eb450513          	addi	a0,a0,-332 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209f64:	acaf60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc0209f68:	00005697          	auipc	a3,0x5
ffffffffc0209f6c:	ff068693          	addi	a3,a3,-16 # ffffffffc020ef58 <dev_node_ops+0x478>
ffffffffc0209f70:	00002617          	auipc	a2,0x2
ffffffffc0209f74:	88860613          	addi	a2,a2,-1912 # ffffffffc020b7f8 <commands+0x60>
ffffffffc0209f78:	12100593          	li	a1,289
ffffffffc0209f7c:	00005517          	auipc	a0,0x5
ffffffffc0209f80:	e9450513          	addi	a0,a0,-364 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc0209f84:	aaaf60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc0209f88 <sfs_io_nolock>:
ffffffffc0209f88:	7175                	addi	sp,sp,-144
ffffffffc0209f8a:	f0d2                	sd	s4,96(sp)
ffffffffc0209f8c:	8a2e                	mv	s4,a1
ffffffffc0209f8e:	618c                	ld	a1,0(a1)
ffffffffc0209f90:	e506                	sd	ra,136(sp)
ffffffffc0209f92:	e122                	sd	s0,128(sp)
ffffffffc0209f94:	0045d883          	lhu	a7,4(a1)
ffffffffc0209f98:	fca6                	sd	s1,120(sp)
ffffffffc0209f9a:	f8ca                	sd	s2,112(sp)
ffffffffc0209f9c:	f4ce                	sd	s3,104(sp)
ffffffffc0209f9e:	ecd6                	sd	s5,88(sp)
ffffffffc0209fa0:	e8da                	sd	s6,80(sp)
ffffffffc0209fa2:	e4de                	sd	s7,72(sp)
ffffffffc0209fa4:	e0e2                	sd	s8,64(sp)
ffffffffc0209fa6:	fc66                	sd	s9,56(sp)
ffffffffc0209fa8:	f86a                	sd	s10,48(sp)
ffffffffc0209faa:	f46e                	sd	s11,40(sp)
ffffffffc0209fac:	4809                	li	a6,2
ffffffffc0209fae:	e03a                	sd	a4,0(sp)
ffffffffc0209fb0:	15088563          	beq	a7,a6,ffffffffc020a0fa <sfs_io_nolock+0x172>
ffffffffc0209fb4:	8bb6                	mv	s7,a3
ffffffffc0209fb6:	6682                	ld	a3,0(sp)
ffffffffc0209fb8:	08000737          	lui	a4,0x8000
ffffffffc0209fbc:	8dde                	mv	s11,s7
ffffffffc0209fbe:	6280                	ld	s0,0(a3)
ffffffffc0209fc0:	0006b023          	sd	zero,0(a3)
ffffffffc0209fc4:	945e                	add	s0,s0,s7
ffffffffc0209fc6:	12ebf863          	bgeu	s7,a4,ffffffffc020a0f6 <sfs_io_nolock+0x16e>
ffffffffc0209fca:	13744663          	blt	s0,s7,ffffffffc020a0f6 <sfs_io_nolock+0x16e>
ffffffffc0209fce:	892a                	mv	s2,a0
ffffffffc0209fd0:	4501                	li	a0,0
ffffffffc0209fd2:	0a8b8e63          	beq	s7,s0,ffffffffc020a08e <sfs_io_nolock+0x106>
ffffffffc0209fd6:	84b2                	mv	s1,a2
ffffffffc0209fd8:	00877463          	bgeu	a4,s0,ffffffffc0209fe0 <sfs_io_nolock+0x58>
ffffffffc0209fdc:	08000437          	lui	s0,0x8000
ffffffffc0209fe0:	e7f1                	bnez	a5,ffffffffc020a0ac <sfs_io_nolock+0x124>
ffffffffc0209fe2:	0005e783          	lwu	a5,0(a1)
ffffffffc0209fe6:	4501                	li	a0,0
ffffffffc0209fe8:	0afbd363          	bge	s7,a5,ffffffffc020a08e <sfs_io_nolock+0x106>
ffffffffc0209fec:	1087c163          	blt	a5,s0,ffffffffc020a0ee <sfs_io_nolock+0x166>
ffffffffc0209ff0:	fffff797          	auipc	a5,0xfffff
ffffffffc0209ff4:	f3a78793          	addi	a5,a5,-198 # ffffffffc0208f2a <sfs_rblock>
ffffffffc0209ff8:	e43e                	sd	a5,8(sp)
ffffffffc0209ffa:	fffffc97          	auipc	s9,0xfffff
ffffffffc0209ffe:	ff0c8c93          	addi	s9,s9,-16 # ffffffffc0208fea <sfs_rbuf>
ffffffffc020a002:	6a85                	lui	s5,0x1
ffffffffc020a004:	8d5e                	mv	s10,s7
ffffffffc020a006:	4981                	li	s3,0
ffffffffc020a008:	fffa8b13          	addi	s6,s5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc020a00c:	4501                	li	a0,0
ffffffffc020a00e:	068bd063          	bge	s7,s0,ffffffffc020a06e <sfs_io_nolock+0xe6>
ffffffffc020a012:	43fd5613          	srai	a2,s10,0x3f
ffffffffc020a016:	03465693          	srli	a3,a2,0x34
ffffffffc020a01a:	00dd0733          	add	a4,s10,a3
ffffffffc020a01e:	01677733          	and	a4,a4,s6
ffffffffc020a022:	40d70c33          	sub	s8,a4,a3
ffffffffc020a026:	418a8db3          	sub	s11,s5,s8
ffffffffc020a02a:	01bd06b3          	add	a3,s10,s11
ffffffffc020a02e:	00d47463          	bgeu	s0,a3,ffffffffc020a036 <sfs_io_nolock+0xae>
ffffffffc020a032:	41a40db3          	sub	s11,s0,s10
ffffffffc020a036:	01667633          	and	a2,a2,s6
ffffffffc020a03a:	966a                	add	a2,a2,s10
ffffffffc020a03c:	8631                	srai	a2,a2,0xc
ffffffffc020a03e:	0874                	addi	a3,sp,28
ffffffffc020a040:	2601                	sext.w	a2,a2
ffffffffc020a042:	85d2                	mv	a1,s4
ffffffffc020a044:	854a                	mv	a0,s2
ffffffffc020a046:	cebff0ef          	jal	ra,ffffffffc0209d30 <sfs_bmap_load_nolock>
ffffffffc020a04a:	e105                	bnez	a0,ffffffffc020a06a <sfs_io_nolock+0xe2>
ffffffffc020a04c:	4672                	lw	a2,28(sp)
ffffffffc020a04e:	095d8a63          	beq	s11,s5,ffffffffc020a0e2 <sfs_io_nolock+0x15a>
ffffffffc020a052:	86b2                	mv	a3,a2
ffffffffc020a054:	8762                	mv	a4,s8
ffffffffc020a056:	866e                	mv	a2,s11
ffffffffc020a058:	85a6                	mv	a1,s1
ffffffffc020a05a:	854a                	mv	a0,s2
ffffffffc020a05c:	9c82                	jalr	s9
ffffffffc020a05e:	e511                	bnez	a0,ffffffffc020a06a <sfs_io_nolock+0xe2>
ffffffffc020a060:	9d6e                	add	s10,s10,s11
ffffffffc020a062:	94ee                	add	s1,s1,s11
ffffffffc020a064:	99ee                	add	s3,s3,s11
ffffffffc020a066:	fa8d46e3          	blt	s10,s0,ffffffffc020a012 <sfs_io_nolock+0x8a>
ffffffffc020a06a:	013b8db3          	add	s11,s7,s3
ffffffffc020a06e:	000a3783          	ld	a5,0(s4)
ffffffffc020a072:	6702                	ld	a4,0(sp)
ffffffffc020a074:	01373023          	sd	s3,0(a4) # 8000000 <_binary_bin_sfs_img_size+0x7f8ad00>
ffffffffc020a078:	0007e703          	lwu	a4,0(a5)
ffffffffc020a07c:	01b77963          	bgeu	a4,s11,ffffffffc020a08e <sfs_io_nolock+0x106>
ffffffffc020a080:	013b89bb          	addw	s3,s7,s3
ffffffffc020a084:	0137a023          	sw	s3,0(a5)
ffffffffc020a088:	4785                	li	a5,1
ffffffffc020a08a:	00fa3823          	sd	a5,16(s4)
ffffffffc020a08e:	60aa                	ld	ra,136(sp)
ffffffffc020a090:	640a                	ld	s0,128(sp)
ffffffffc020a092:	74e6                	ld	s1,120(sp)
ffffffffc020a094:	7946                	ld	s2,112(sp)
ffffffffc020a096:	79a6                	ld	s3,104(sp)
ffffffffc020a098:	7a06                	ld	s4,96(sp)
ffffffffc020a09a:	6ae6                	ld	s5,88(sp)
ffffffffc020a09c:	6b46                	ld	s6,80(sp)
ffffffffc020a09e:	6ba6                	ld	s7,72(sp)
ffffffffc020a0a0:	6c06                	ld	s8,64(sp)
ffffffffc020a0a2:	7ce2                	ld	s9,56(sp)
ffffffffc020a0a4:	7d42                	ld	s10,48(sp)
ffffffffc020a0a6:	7da2                	ld	s11,40(sp)
ffffffffc020a0a8:	6149                	addi	sp,sp,144
ffffffffc020a0aa:	8082                	ret
ffffffffc020a0ac:	0085a983          	lw	s3,8(a1)
ffffffffc020a0b0:	40cbda93          	srai	s5,s7,0xc
ffffffffc020a0b4:	2a81                	sext.w	s5,s5
ffffffffc020a0b6:	0159fc63          	bgeu	s3,s5,ffffffffc020a0ce <sfs_io_nolock+0x146>
ffffffffc020a0ba:	4681                	li	a3,0
ffffffffc020a0bc:	864e                	mv	a2,s3
ffffffffc020a0be:	85d2                	mv	a1,s4
ffffffffc020a0c0:	854a                	mv	a0,s2
ffffffffc020a0c2:	c6fff0ef          	jal	ra,ffffffffc0209d30 <sfs_bmap_load_nolock>
ffffffffc020a0c6:	e515                	bnez	a0,ffffffffc020a0f2 <sfs_io_nolock+0x16a>
ffffffffc020a0c8:	2985                	addiw	s3,s3,1
ffffffffc020a0ca:	ff59e8e3          	bltu	s3,s5,ffffffffc020a0ba <sfs_io_nolock+0x132>
ffffffffc020a0ce:	fffff797          	auipc	a5,0xfffff
ffffffffc020a0d2:	ebc78793          	addi	a5,a5,-324 # ffffffffc0208f8a <sfs_wblock>
ffffffffc020a0d6:	e43e                	sd	a5,8(sp)
ffffffffc020a0d8:	fffffc97          	auipc	s9,0xfffff
ffffffffc020a0dc:	f92c8c93          	addi	s9,s9,-110 # ffffffffc020906a <sfs_wbuf>
ffffffffc020a0e0:	b70d                	j	ffffffffc020a002 <sfs_io_nolock+0x7a>
ffffffffc020a0e2:	67a2                	ld	a5,8(sp)
ffffffffc020a0e4:	4685                	li	a3,1
ffffffffc020a0e6:	85a6                	mv	a1,s1
ffffffffc020a0e8:	854a                	mv	a0,s2
ffffffffc020a0ea:	9782                	jalr	a5
ffffffffc020a0ec:	bf8d                	j	ffffffffc020a05e <sfs_io_nolock+0xd6>
ffffffffc020a0ee:	843e                	mv	s0,a5
ffffffffc020a0f0:	b701                	j	ffffffffc0209ff0 <sfs_io_nolock+0x68>
ffffffffc020a0f2:	4981                	li	s3,0
ffffffffc020a0f4:	bfad                	j	ffffffffc020a06e <sfs_io_nolock+0xe6>
ffffffffc020a0f6:	5575                	li	a0,-3
ffffffffc020a0f8:	bf59                	j	ffffffffc020a08e <sfs_io_nolock+0x106>
ffffffffc020a0fa:	00005697          	auipc	a3,0x5
ffffffffc020a0fe:	e8668693          	addi	a3,a3,-378 # ffffffffc020ef80 <dev_node_ops+0x4a0>
ffffffffc020a102:	00001617          	auipc	a2,0x1
ffffffffc020a106:	6f660613          	addi	a2,a2,1782 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a10a:	22b00593          	li	a1,555
ffffffffc020a10e:	00005517          	auipc	a0,0x5
ffffffffc020a112:	d0250513          	addi	a0,a0,-766 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a116:	918f60ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020a11a <sfs_read>:
ffffffffc020a11a:	7139                	addi	sp,sp,-64
ffffffffc020a11c:	f04a                	sd	s2,32(sp)
ffffffffc020a11e:	06853903          	ld	s2,104(a0)
ffffffffc020a122:	fc06                	sd	ra,56(sp)
ffffffffc020a124:	f822                	sd	s0,48(sp)
ffffffffc020a126:	f426                	sd	s1,40(sp)
ffffffffc020a128:	ec4e                	sd	s3,24(sp)
ffffffffc020a12a:	04090f63          	beqz	s2,ffffffffc020a188 <sfs_read+0x6e>
ffffffffc020a12e:	0b092783          	lw	a5,176(s2)
ffffffffc020a132:	ebb9                	bnez	a5,ffffffffc020a188 <sfs_read+0x6e>
ffffffffc020a134:	4d38                	lw	a4,88(a0)
ffffffffc020a136:	6785                	lui	a5,0x1
ffffffffc020a138:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a13c:	842a                	mv	s0,a0
ffffffffc020a13e:	06f71563          	bne	a4,a5,ffffffffc020a1a8 <sfs_read+0x8e>
ffffffffc020a142:	02050993          	addi	s3,a0,32
ffffffffc020a146:	854e                	mv	a0,s3
ffffffffc020a148:	84ae                	mv	s1,a1
ffffffffc020a14a:	e00fa0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020a14e:	0184b803          	ld	a6,24(s1)
ffffffffc020a152:	6494                	ld	a3,8(s1)
ffffffffc020a154:	6090                	ld	a2,0(s1)
ffffffffc020a156:	85a2                	mv	a1,s0
ffffffffc020a158:	4781                	li	a5,0
ffffffffc020a15a:	0038                	addi	a4,sp,8
ffffffffc020a15c:	854a                	mv	a0,s2
ffffffffc020a15e:	e442                	sd	a6,8(sp)
ffffffffc020a160:	e29ff0ef          	jal	ra,ffffffffc0209f88 <sfs_io_nolock>
ffffffffc020a164:	65a2                	ld	a1,8(sp)
ffffffffc020a166:	842a                	mv	s0,a0
ffffffffc020a168:	ed81                	bnez	a1,ffffffffc020a180 <sfs_read+0x66>
ffffffffc020a16a:	854e                	mv	a0,s3
ffffffffc020a16c:	ddafa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020a170:	70e2                	ld	ra,56(sp)
ffffffffc020a172:	8522                	mv	a0,s0
ffffffffc020a174:	7442                	ld	s0,48(sp)
ffffffffc020a176:	74a2                	ld	s1,40(sp)
ffffffffc020a178:	7902                	ld	s2,32(sp)
ffffffffc020a17a:	69e2                	ld	s3,24(sp)
ffffffffc020a17c:	6121                	addi	sp,sp,64
ffffffffc020a17e:	8082                	ret
ffffffffc020a180:	8526                	mv	a0,s1
ffffffffc020a182:	e20fb0ef          	jal	ra,ffffffffc02057a2 <iobuf_skip>
ffffffffc020a186:	b7d5                	j	ffffffffc020a16a <sfs_read+0x50>
ffffffffc020a188:	00005697          	auipc	a3,0x5
ffffffffc020a18c:	aa868693          	addi	a3,a3,-1368 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020a190:	00001617          	auipc	a2,0x1
ffffffffc020a194:	66860613          	addi	a2,a2,1640 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a198:	28100593          	li	a1,641
ffffffffc020a19c:	00005517          	auipc	a0,0x5
ffffffffc020a1a0:	c7450513          	addi	a0,a0,-908 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a1a4:	88af60ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a1a8:	8abff0ef          	jal	ra,ffffffffc0209a52 <sfs_io.part.0>

ffffffffc020a1ac <sfs_write>:
ffffffffc020a1ac:	7139                	addi	sp,sp,-64
ffffffffc020a1ae:	f04a                	sd	s2,32(sp)
ffffffffc020a1b0:	06853903          	ld	s2,104(a0)
ffffffffc020a1b4:	fc06                	sd	ra,56(sp)
ffffffffc020a1b6:	f822                	sd	s0,48(sp)
ffffffffc020a1b8:	f426                	sd	s1,40(sp)
ffffffffc020a1ba:	ec4e                	sd	s3,24(sp)
ffffffffc020a1bc:	04090f63          	beqz	s2,ffffffffc020a21a <sfs_write+0x6e>
ffffffffc020a1c0:	0b092783          	lw	a5,176(s2)
ffffffffc020a1c4:	ebb9                	bnez	a5,ffffffffc020a21a <sfs_write+0x6e>
ffffffffc020a1c6:	4d38                	lw	a4,88(a0)
ffffffffc020a1c8:	6785                	lui	a5,0x1
ffffffffc020a1ca:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a1ce:	842a                	mv	s0,a0
ffffffffc020a1d0:	06f71563          	bne	a4,a5,ffffffffc020a23a <sfs_write+0x8e>
ffffffffc020a1d4:	02050993          	addi	s3,a0,32
ffffffffc020a1d8:	854e                	mv	a0,s3
ffffffffc020a1da:	84ae                	mv	s1,a1
ffffffffc020a1dc:	d6efa0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020a1e0:	0184b803          	ld	a6,24(s1)
ffffffffc020a1e4:	6494                	ld	a3,8(s1)
ffffffffc020a1e6:	6090                	ld	a2,0(s1)
ffffffffc020a1e8:	85a2                	mv	a1,s0
ffffffffc020a1ea:	4785                	li	a5,1
ffffffffc020a1ec:	0038                	addi	a4,sp,8
ffffffffc020a1ee:	854a                	mv	a0,s2
ffffffffc020a1f0:	e442                	sd	a6,8(sp)
ffffffffc020a1f2:	d97ff0ef          	jal	ra,ffffffffc0209f88 <sfs_io_nolock>
ffffffffc020a1f6:	65a2                	ld	a1,8(sp)
ffffffffc020a1f8:	842a                	mv	s0,a0
ffffffffc020a1fa:	ed81                	bnez	a1,ffffffffc020a212 <sfs_write+0x66>
ffffffffc020a1fc:	854e                	mv	a0,s3
ffffffffc020a1fe:	d48fa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020a202:	70e2                	ld	ra,56(sp)
ffffffffc020a204:	8522                	mv	a0,s0
ffffffffc020a206:	7442                	ld	s0,48(sp)
ffffffffc020a208:	74a2                	ld	s1,40(sp)
ffffffffc020a20a:	7902                	ld	s2,32(sp)
ffffffffc020a20c:	69e2                	ld	s3,24(sp)
ffffffffc020a20e:	6121                	addi	sp,sp,64
ffffffffc020a210:	8082                	ret
ffffffffc020a212:	8526                	mv	a0,s1
ffffffffc020a214:	d8efb0ef          	jal	ra,ffffffffc02057a2 <iobuf_skip>
ffffffffc020a218:	b7d5                	j	ffffffffc020a1fc <sfs_write+0x50>
ffffffffc020a21a:	00005697          	auipc	a3,0x5
ffffffffc020a21e:	a1668693          	addi	a3,a3,-1514 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020a222:	00001617          	auipc	a2,0x1
ffffffffc020a226:	5d660613          	addi	a2,a2,1494 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a22a:	28100593          	li	a1,641
ffffffffc020a22e:	00005517          	auipc	a0,0x5
ffffffffc020a232:	be250513          	addi	a0,a0,-1054 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a236:	ff9f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a23a:	819ff0ef          	jal	ra,ffffffffc0209a52 <sfs_io.part.0>

ffffffffc020a23e <sfs_dirent_read_nolock>:
ffffffffc020a23e:	6198                	ld	a4,0(a1)
ffffffffc020a240:	7179                	addi	sp,sp,-48
ffffffffc020a242:	f406                	sd	ra,40(sp)
ffffffffc020a244:	00475883          	lhu	a7,4(a4)
ffffffffc020a248:	f022                	sd	s0,32(sp)
ffffffffc020a24a:	ec26                	sd	s1,24(sp)
ffffffffc020a24c:	4809                	li	a6,2
ffffffffc020a24e:	05089b63          	bne	a7,a6,ffffffffc020a2a4 <sfs_dirent_read_nolock+0x66>
ffffffffc020a252:	4718                	lw	a4,8(a4)
ffffffffc020a254:	87b2                	mv	a5,a2
ffffffffc020a256:	2601                	sext.w	a2,a2
ffffffffc020a258:	04e7f663          	bgeu	a5,a4,ffffffffc020a2a4 <sfs_dirent_read_nolock+0x66>
ffffffffc020a25c:	84b6                	mv	s1,a3
ffffffffc020a25e:	0074                	addi	a3,sp,12
ffffffffc020a260:	842a                	mv	s0,a0
ffffffffc020a262:	acfff0ef          	jal	ra,ffffffffc0209d30 <sfs_bmap_load_nolock>
ffffffffc020a266:	c511                	beqz	a0,ffffffffc020a272 <sfs_dirent_read_nolock+0x34>
ffffffffc020a268:	70a2                	ld	ra,40(sp)
ffffffffc020a26a:	7402                	ld	s0,32(sp)
ffffffffc020a26c:	64e2                	ld	s1,24(sp)
ffffffffc020a26e:	6145                	addi	sp,sp,48
ffffffffc020a270:	8082                	ret
ffffffffc020a272:	45b2                	lw	a1,12(sp)
ffffffffc020a274:	4054                	lw	a3,4(s0)
ffffffffc020a276:	c5b9                	beqz	a1,ffffffffc020a2c4 <sfs_dirent_read_nolock+0x86>
ffffffffc020a278:	04d5f663          	bgeu	a1,a3,ffffffffc020a2c4 <sfs_dirent_read_nolock+0x86>
ffffffffc020a27c:	7c08                	ld	a0,56(s0)
ffffffffc020a27e:	433000ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc020a282:	ed31                	bnez	a0,ffffffffc020a2de <sfs_dirent_read_nolock+0xa0>
ffffffffc020a284:	46b2                	lw	a3,12(sp)
ffffffffc020a286:	4701                	li	a4,0
ffffffffc020a288:	10400613          	li	a2,260
ffffffffc020a28c:	85a6                	mv	a1,s1
ffffffffc020a28e:	8522                	mv	a0,s0
ffffffffc020a290:	d5bfe0ef          	jal	ra,ffffffffc0208fea <sfs_rbuf>
ffffffffc020a294:	f971                	bnez	a0,ffffffffc020a268 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a296:	100481a3          	sb	zero,259(s1)
ffffffffc020a29a:	70a2                	ld	ra,40(sp)
ffffffffc020a29c:	7402                	ld	s0,32(sp)
ffffffffc020a29e:	64e2                	ld	s1,24(sp)
ffffffffc020a2a0:	6145                	addi	sp,sp,48
ffffffffc020a2a2:	8082                	ret
ffffffffc020a2a4:	00005697          	auipc	a3,0x5
ffffffffc020a2a8:	cfc68693          	addi	a3,a3,-772 # ffffffffc020efa0 <dev_node_ops+0x4c0>
ffffffffc020a2ac:	00001617          	auipc	a2,0x1
ffffffffc020a2b0:	54c60613          	addi	a2,a2,1356 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a2b4:	18e00593          	li	a1,398
ffffffffc020a2b8:	00005517          	auipc	a0,0x5
ffffffffc020a2bc:	b5850513          	addi	a0,a0,-1192 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a2c0:	f6ff50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a2c4:	872e                	mv	a4,a1
ffffffffc020a2c6:	00005617          	auipc	a2,0x5
ffffffffc020a2ca:	b7a60613          	addi	a2,a2,-1158 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc020a2ce:	05300593          	li	a1,83
ffffffffc020a2d2:	00005517          	auipc	a0,0x5
ffffffffc020a2d6:	b3e50513          	addi	a0,a0,-1218 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a2da:	f55f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a2de:	00005697          	auipc	a3,0x5
ffffffffc020a2e2:	b9a68693          	addi	a3,a3,-1126 # ffffffffc020ee78 <dev_node_ops+0x398>
ffffffffc020a2e6:	00001617          	auipc	a2,0x1
ffffffffc020a2ea:	51260613          	addi	a2,a2,1298 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a2ee:	19500593          	li	a1,405
ffffffffc020a2f2:	00005517          	auipc	a0,0x5
ffffffffc020a2f6:	b1e50513          	addi	a0,a0,-1250 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a2fa:	f35f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020a2fe <sfs_getdirentry>:
ffffffffc020a2fe:	715d                	addi	sp,sp,-80
ffffffffc020a300:	ec56                	sd	s5,24(sp)
ffffffffc020a302:	8aaa                	mv	s5,a0
ffffffffc020a304:	10400513          	li	a0,260
ffffffffc020a308:	e85a                	sd	s6,16(sp)
ffffffffc020a30a:	e486                	sd	ra,72(sp)
ffffffffc020a30c:	e0a2                	sd	s0,64(sp)
ffffffffc020a30e:	fc26                	sd	s1,56(sp)
ffffffffc020a310:	f84a                	sd	s2,48(sp)
ffffffffc020a312:	f44e                	sd	s3,40(sp)
ffffffffc020a314:	f052                	sd	s4,32(sp)
ffffffffc020a316:	e45e                	sd	s7,8(sp)
ffffffffc020a318:	e062                	sd	s8,0(sp)
ffffffffc020a31a:	8b2e                	mv	s6,a1
ffffffffc020a31c:	9fbf70ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020a320:	cd61                	beqz	a0,ffffffffc020a3f8 <sfs_getdirentry+0xfa>
ffffffffc020a322:	068abb83          	ld	s7,104(s5)
ffffffffc020a326:	0c0b8b63          	beqz	s7,ffffffffc020a3fc <sfs_getdirentry+0xfe>
ffffffffc020a32a:	0b0ba783          	lw	a5,176(s7) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a32e:	e7f9                	bnez	a5,ffffffffc020a3fc <sfs_getdirentry+0xfe>
ffffffffc020a330:	058aa703          	lw	a4,88(s5)
ffffffffc020a334:	6785                	lui	a5,0x1
ffffffffc020a336:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a33a:	0ef71163          	bne	a4,a5,ffffffffc020a41c <sfs_getdirentry+0x11e>
ffffffffc020a33e:	008b3983          	ld	s3,8(s6)
ffffffffc020a342:	892a                	mv	s2,a0
ffffffffc020a344:	0a09c163          	bltz	s3,ffffffffc020a3e6 <sfs_getdirentry+0xe8>
ffffffffc020a348:	0ff9f793          	zext.b	a5,s3
ffffffffc020a34c:	efc9                	bnez	a5,ffffffffc020a3e6 <sfs_getdirentry+0xe8>
ffffffffc020a34e:	000ab783          	ld	a5,0(s5)
ffffffffc020a352:	0089d993          	srli	s3,s3,0x8
ffffffffc020a356:	2981                	sext.w	s3,s3
ffffffffc020a358:	479c                	lw	a5,8(a5)
ffffffffc020a35a:	0937eb63          	bltu	a5,s3,ffffffffc020a3f0 <sfs_getdirentry+0xf2>
ffffffffc020a35e:	020a8c13          	addi	s8,s5,32
ffffffffc020a362:	8562                	mv	a0,s8
ffffffffc020a364:	be6fa0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020a368:	000ab783          	ld	a5,0(s5)
ffffffffc020a36c:	0087aa03          	lw	s4,8(a5)
ffffffffc020a370:	07405663          	blez	s4,ffffffffc020a3dc <sfs_getdirentry+0xde>
ffffffffc020a374:	4481                	li	s1,0
ffffffffc020a376:	a811                	j	ffffffffc020a38a <sfs_getdirentry+0x8c>
ffffffffc020a378:	00092783          	lw	a5,0(s2)
ffffffffc020a37c:	c781                	beqz	a5,ffffffffc020a384 <sfs_getdirentry+0x86>
ffffffffc020a37e:	02098263          	beqz	s3,ffffffffc020a3a2 <sfs_getdirentry+0xa4>
ffffffffc020a382:	39fd                	addiw	s3,s3,-1
ffffffffc020a384:	2485                	addiw	s1,s1,1
ffffffffc020a386:	049a0b63          	beq	s4,s1,ffffffffc020a3dc <sfs_getdirentry+0xde>
ffffffffc020a38a:	86ca                	mv	a3,s2
ffffffffc020a38c:	8626                	mv	a2,s1
ffffffffc020a38e:	85d6                	mv	a1,s5
ffffffffc020a390:	855e                	mv	a0,s7
ffffffffc020a392:	eadff0ef          	jal	ra,ffffffffc020a23e <sfs_dirent_read_nolock>
ffffffffc020a396:	842a                	mv	s0,a0
ffffffffc020a398:	d165                	beqz	a0,ffffffffc020a378 <sfs_getdirentry+0x7a>
ffffffffc020a39a:	8562                	mv	a0,s8
ffffffffc020a39c:	baafa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020a3a0:	a831                	j	ffffffffc020a3bc <sfs_getdirentry+0xbe>
ffffffffc020a3a2:	8562                	mv	a0,s8
ffffffffc020a3a4:	ba2fa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020a3a8:	4701                	li	a4,0
ffffffffc020a3aa:	4685                	li	a3,1
ffffffffc020a3ac:	10000613          	li	a2,256
ffffffffc020a3b0:	00490593          	addi	a1,s2,4
ffffffffc020a3b4:	855a                	mv	a0,s6
ffffffffc020a3b6:	b80fb0ef          	jal	ra,ffffffffc0205736 <iobuf_move>
ffffffffc020a3ba:	842a                	mv	s0,a0
ffffffffc020a3bc:	854a                	mv	a0,s2
ffffffffc020a3be:	a09f70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020a3c2:	60a6                	ld	ra,72(sp)
ffffffffc020a3c4:	8522                	mv	a0,s0
ffffffffc020a3c6:	6406                	ld	s0,64(sp)
ffffffffc020a3c8:	74e2                	ld	s1,56(sp)
ffffffffc020a3ca:	7942                	ld	s2,48(sp)
ffffffffc020a3cc:	79a2                	ld	s3,40(sp)
ffffffffc020a3ce:	7a02                	ld	s4,32(sp)
ffffffffc020a3d0:	6ae2                	ld	s5,24(sp)
ffffffffc020a3d2:	6b42                	ld	s6,16(sp)
ffffffffc020a3d4:	6ba2                	ld	s7,8(sp)
ffffffffc020a3d6:	6c02                	ld	s8,0(sp)
ffffffffc020a3d8:	6161                	addi	sp,sp,80
ffffffffc020a3da:	8082                	ret
ffffffffc020a3dc:	8562                	mv	a0,s8
ffffffffc020a3de:	5441                	li	s0,-16
ffffffffc020a3e0:	b66fa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020a3e4:	bfe1                	j	ffffffffc020a3bc <sfs_getdirentry+0xbe>
ffffffffc020a3e6:	854a                	mv	a0,s2
ffffffffc020a3e8:	9dff70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020a3ec:	5475                	li	s0,-3
ffffffffc020a3ee:	bfd1                	j	ffffffffc020a3c2 <sfs_getdirentry+0xc4>
ffffffffc020a3f0:	9d7f70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020a3f4:	5441                	li	s0,-16
ffffffffc020a3f6:	b7f1                	j	ffffffffc020a3c2 <sfs_getdirentry+0xc4>
ffffffffc020a3f8:	5471                	li	s0,-4
ffffffffc020a3fa:	b7e1                	j	ffffffffc020a3c2 <sfs_getdirentry+0xc4>
ffffffffc020a3fc:	00005697          	auipc	a3,0x5
ffffffffc020a400:	83468693          	addi	a3,a3,-1996 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020a404:	00001617          	auipc	a2,0x1
ffffffffc020a408:	3f460613          	addi	a2,a2,1012 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a40c:	32500593          	li	a1,805
ffffffffc020a410:	00005517          	auipc	a0,0x5
ffffffffc020a414:	a0050513          	addi	a0,a0,-1536 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a418:	e17f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a41c:	00005697          	auipc	a3,0x5
ffffffffc020a420:	9bc68693          	addi	a3,a3,-1604 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020a424:	00001617          	auipc	a2,0x1
ffffffffc020a428:	3d460613          	addi	a2,a2,980 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a42c:	32600593          	li	a1,806
ffffffffc020a430:	00005517          	auipc	a0,0x5
ffffffffc020a434:	9e050513          	addi	a0,a0,-1568 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a438:	df7f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020a43c <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a43c:	715d                	addi	sp,sp,-80
ffffffffc020a43e:	f052                	sd	s4,32(sp)
ffffffffc020a440:	8a2a                	mv	s4,a0
ffffffffc020a442:	8532                	mv	a0,a2
ffffffffc020a444:	f44e                	sd	s3,40(sp)
ffffffffc020a446:	e85a                	sd	s6,16(sp)
ffffffffc020a448:	e45e                	sd	s7,8(sp)
ffffffffc020a44a:	e486                	sd	ra,72(sp)
ffffffffc020a44c:	e0a2                	sd	s0,64(sp)
ffffffffc020a44e:	fc26                	sd	s1,56(sp)
ffffffffc020a450:	f84a                	sd	s2,48(sp)
ffffffffc020a452:	ec56                	sd	s5,24(sp)
ffffffffc020a454:	e062                	sd	s8,0(sp)
ffffffffc020a456:	8b32                	mv	s6,a2
ffffffffc020a458:	89ae                	mv	s3,a1
ffffffffc020a45a:	8bb6                	mv	s7,a3
ffffffffc020a45c:	2f7000ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc020a460:	0ff00793          	li	a5,255
ffffffffc020a464:	06a7ef63          	bltu	a5,a0,ffffffffc020a4e2 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a468:	10400513          	li	a0,260
ffffffffc020a46c:	8abf70ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020a470:	892a                	mv	s2,a0
ffffffffc020a472:	c535                	beqz	a0,ffffffffc020a4de <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a474:	0009b783          	ld	a5,0(s3)
ffffffffc020a478:	0087aa83          	lw	s5,8(a5)
ffffffffc020a47c:	05505a63          	blez	s5,ffffffffc020a4d0 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a480:	4481                	li	s1,0
ffffffffc020a482:	00450c13          	addi	s8,a0,4
ffffffffc020a486:	a829                	j	ffffffffc020a4a0 <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a488:	00092783          	lw	a5,0(s2)
ffffffffc020a48c:	c799                	beqz	a5,ffffffffc020a49a <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a48e:	85e2                	mv	a1,s8
ffffffffc020a490:	855a                	mv	a0,s6
ffffffffc020a492:	309000ef          	jal	ra,ffffffffc020af9a <strcmp>
ffffffffc020a496:	842a                	mv	s0,a0
ffffffffc020a498:	cd15                	beqz	a0,ffffffffc020a4d4 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a49a:	2485                	addiw	s1,s1,1
ffffffffc020a49c:	029a8a63          	beq	s5,s1,ffffffffc020a4d0 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a4a0:	86ca                	mv	a3,s2
ffffffffc020a4a2:	8626                	mv	a2,s1
ffffffffc020a4a4:	85ce                	mv	a1,s3
ffffffffc020a4a6:	8552                	mv	a0,s4
ffffffffc020a4a8:	d97ff0ef          	jal	ra,ffffffffc020a23e <sfs_dirent_read_nolock>
ffffffffc020a4ac:	842a                	mv	s0,a0
ffffffffc020a4ae:	dd69                	beqz	a0,ffffffffc020a488 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a4b0:	854a                	mv	a0,s2
ffffffffc020a4b2:	915f70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020a4b6:	60a6                	ld	ra,72(sp)
ffffffffc020a4b8:	8522                	mv	a0,s0
ffffffffc020a4ba:	6406                	ld	s0,64(sp)
ffffffffc020a4bc:	74e2                	ld	s1,56(sp)
ffffffffc020a4be:	7942                	ld	s2,48(sp)
ffffffffc020a4c0:	79a2                	ld	s3,40(sp)
ffffffffc020a4c2:	7a02                	ld	s4,32(sp)
ffffffffc020a4c4:	6ae2                	ld	s5,24(sp)
ffffffffc020a4c6:	6b42                	ld	s6,16(sp)
ffffffffc020a4c8:	6ba2                	ld	s7,8(sp)
ffffffffc020a4ca:	6c02                	ld	s8,0(sp)
ffffffffc020a4cc:	6161                	addi	sp,sp,80
ffffffffc020a4ce:	8082                	ret
ffffffffc020a4d0:	5441                	li	s0,-16
ffffffffc020a4d2:	bff9                	j	ffffffffc020a4b0 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a4d4:	00092783          	lw	a5,0(s2)
ffffffffc020a4d8:	00fba023          	sw	a5,0(s7)
ffffffffc020a4dc:	bfd1                	j	ffffffffc020a4b0 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a4de:	5471                	li	s0,-4
ffffffffc020a4e0:	bfd9                	j	ffffffffc020a4b6 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a4e2:	00005697          	auipc	a3,0x5
ffffffffc020a4e6:	b0e68693          	addi	a3,a3,-1266 # ffffffffc020eff0 <dev_node_ops+0x510>
ffffffffc020a4ea:	00001617          	auipc	a2,0x1
ffffffffc020a4ee:	30e60613          	addi	a2,a2,782 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a4f2:	1ba00593          	li	a1,442
ffffffffc020a4f6:	00005517          	auipc	a0,0x5
ffffffffc020a4fa:	91a50513          	addi	a0,a0,-1766 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a4fe:	d31f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020a502 <sfs_truncfile>:
ffffffffc020a502:	7175                	addi	sp,sp,-144
ffffffffc020a504:	e506                	sd	ra,136(sp)
ffffffffc020a506:	e122                	sd	s0,128(sp)
ffffffffc020a508:	fca6                	sd	s1,120(sp)
ffffffffc020a50a:	f8ca                	sd	s2,112(sp)
ffffffffc020a50c:	f4ce                	sd	s3,104(sp)
ffffffffc020a50e:	f0d2                	sd	s4,96(sp)
ffffffffc020a510:	ecd6                	sd	s5,88(sp)
ffffffffc020a512:	e8da                	sd	s6,80(sp)
ffffffffc020a514:	e4de                	sd	s7,72(sp)
ffffffffc020a516:	e0e2                	sd	s8,64(sp)
ffffffffc020a518:	fc66                	sd	s9,56(sp)
ffffffffc020a51a:	f86a                	sd	s10,48(sp)
ffffffffc020a51c:	f46e                	sd	s11,40(sp)
ffffffffc020a51e:	080007b7          	lui	a5,0x8000
ffffffffc020a522:	16b7e463          	bltu	a5,a1,ffffffffc020a68a <sfs_truncfile+0x188>
ffffffffc020a526:	06853c83          	ld	s9,104(a0)
ffffffffc020a52a:	89aa                	mv	s3,a0
ffffffffc020a52c:	160c8163          	beqz	s9,ffffffffc020a68e <sfs_truncfile+0x18c>
ffffffffc020a530:	0b0ca783          	lw	a5,176(s9)
ffffffffc020a534:	14079d63          	bnez	a5,ffffffffc020a68e <sfs_truncfile+0x18c>
ffffffffc020a538:	4d38                	lw	a4,88(a0)
ffffffffc020a53a:	6405                	lui	s0,0x1
ffffffffc020a53c:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a540:	16f71763          	bne	a4,a5,ffffffffc020a6ae <sfs_truncfile+0x1ac>
ffffffffc020a544:	00053a83          	ld	s5,0(a0)
ffffffffc020a548:	147d                	addi	s0,s0,-1
ffffffffc020a54a:	942e                	add	s0,s0,a1
ffffffffc020a54c:	000ae783          	lwu	a5,0(s5)
ffffffffc020a550:	8031                	srli	s0,s0,0xc
ffffffffc020a552:	8a2e                	mv	s4,a1
ffffffffc020a554:	2401                	sext.w	s0,s0
ffffffffc020a556:	02b79763          	bne	a5,a1,ffffffffc020a584 <sfs_truncfile+0x82>
ffffffffc020a55a:	008aa783          	lw	a5,8(s5)
ffffffffc020a55e:	4901                	li	s2,0
ffffffffc020a560:	18879763          	bne	a5,s0,ffffffffc020a6ee <sfs_truncfile+0x1ec>
ffffffffc020a564:	60aa                	ld	ra,136(sp)
ffffffffc020a566:	640a                	ld	s0,128(sp)
ffffffffc020a568:	74e6                	ld	s1,120(sp)
ffffffffc020a56a:	79a6                	ld	s3,104(sp)
ffffffffc020a56c:	7a06                	ld	s4,96(sp)
ffffffffc020a56e:	6ae6                	ld	s5,88(sp)
ffffffffc020a570:	6b46                	ld	s6,80(sp)
ffffffffc020a572:	6ba6                	ld	s7,72(sp)
ffffffffc020a574:	6c06                	ld	s8,64(sp)
ffffffffc020a576:	7ce2                	ld	s9,56(sp)
ffffffffc020a578:	7d42                	ld	s10,48(sp)
ffffffffc020a57a:	7da2                	ld	s11,40(sp)
ffffffffc020a57c:	854a                	mv	a0,s2
ffffffffc020a57e:	7946                	ld	s2,112(sp)
ffffffffc020a580:	6149                	addi	sp,sp,144
ffffffffc020a582:	8082                	ret
ffffffffc020a584:	02050b13          	addi	s6,a0,32
ffffffffc020a588:	855a                	mv	a0,s6
ffffffffc020a58a:	9c0fa0ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020a58e:	008aa483          	lw	s1,8(s5)
ffffffffc020a592:	0a84e663          	bltu	s1,s0,ffffffffc020a63e <sfs_truncfile+0x13c>
ffffffffc020a596:	0c947163          	bgeu	s0,s1,ffffffffc020a658 <sfs_truncfile+0x156>
ffffffffc020a59a:	4dad                	li	s11,11
ffffffffc020a59c:	4b85                	li	s7,1
ffffffffc020a59e:	a09d                	j	ffffffffc020a604 <sfs_truncfile+0x102>
ffffffffc020a5a0:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a5a4:	0009079b          	sext.w	a5,s2
ffffffffc020a5a8:	3ff00713          	li	a4,1023
ffffffffc020a5ac:	04f76563          	bltu	a4,a5,ffffffffc020a5f6 <sfs_truncfile+0xf4>
ffffffffc020a5b0:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a5b4:	040c0163          	beqz	s8,ffffffffc020a5f6 <sfs_truncfile+0xf4>
ffffffffc020a5b8:	004ca783          	lw	a5,4(s9)
ffffffffc020a5bc:	18fc7963          	bgeu	s8,a5,ffffffffc020a74e <sfs_truncfile+0x24c>
ffffffffc020a5c0:	038cb503          	ld	a0,56(s9)
ffffffffc020a5c4:	85e2                	mv	a1,s8
ffffffffc020a5c6:	0eb000ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc020a5ca:	16051263          	bnez	a0,ffffffffc020a72e <sfs_truncfile+0x22c>
ffffffffc020a5ce:	02091793          	slli	a5,s2,0x20
ffffffffc020a5d2:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a5d6:	86e2                	mv	a3,s8
ffffffffc020a5d8:	4611                	li	a2,4
ffffffffc020a5da:	082c                	addi	a1,sp,24
ffffffffc020a5dc:	8566                	mv	a0,s9
ffffffffc020a5de:	e43a                	sd	a4,8(sp)
ffffffffc020a5e0:	ce02                	sw	zero,28(sp)
ffffffffc020a5e2:	a09fe0ef          	jal	ra,ffffffffc0208fea <sfs_rbuf>
ffffffffc020a5e6:	892a                	mv	s2,a0
ffffffffc020a5e8:	e141                	bnez	a0,ffffffffc020a668 <sfs_truncfile+0x166>
ffffffffc020a5ea:	47e2                	lw	a5,24(sp)
ffffffffc020a5ec:	6722                	ld	a4,8(sp)
ffffffffc020a5ee:	e3c9                	bnez	a5,ffffffffc020a670 <sfs_truncfile+0x16e>
ffffffffc020a5f0:	008d2603          	lw	a2,8(s10)
ffffffffc020a5f4:	367d                	addiw	a2,a2,-1
ffffffffc020a5f6:	00cd2423          	sw	a2,8(s10)
ffffffffc020a5fa:	0179b823          	sd	s7,16(s3)
ffffffffc020a5fe:	34fd                	addiw	s1,s1,-1
ffffffffc020a600:	04940a63          	beq	s0,s1,ffffffffc020a654 <sfs_truncfile+0x152>
ffffffffc020a604:	0009bd03          	ld	s10,0(s3)
ffffffffc020a608:	008d2703          	lw	a4,8(s10)
ffffffffc020a60c:	c369                	beqz	a4,ffffffffc020a6ce <sfs_truncfile+0x1cc>
ffffffffc020a60e:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a612:	0007861b          	sext.w	a2,a5
ffffffffc020a616:	f8cde5e3          	bltu	s11,a2,ffffffffc020a5a0 <sfs_truncfile+0x9e>
ffffffffc020a61a:	02079713          	slli	a4,a5,0x20
ffffffffc020a61e:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a622:	00fd0933          	add	s2,s10,a5
ffffffffc020a626:	00c92583          	lw	a1,12(s2)
ffffffffc020a62a:	d5f1                	beqz	a1,ffffffffc020a5f6 <sfs_truncfile+0xf4>
ffffffffc020a62c:	8566                	mv	a0,s9
ffffffffc020a62e:	c48ff0ef          	jal	ra,ffffffffc0209a76 <sfs_block_free>
ffffffffc020a632:	00092623          	sw	zero,12(s2)
ffffffffc020a636:	008d2603          	lw	a2,8(s10)
ffffffffc020a63a:	367d                	addiw	a2,a2,-1
ffffffffc020a63c:	bf6d                	j	ffffffffc020a5f6 <sfs_truncfile+0xf4>
ffffffffc020a63e:	4681                	li	a3,0
ffffffffc020a640:	8626                	mv	a2,s1
ffffffffc020a642:	85ce                	mv	a1,s3
ffffffffc020a644:	8566                	mv	a0,s9
ffffffffc020a646:	eeaff0ef          	jal	ra,ffffffffc0209d30 <sfs_bmap_load_nolock>
ffffffffc020a64a:	892a                	mv	s2,a0
ffffffffc020a64c:	ed11                	bnez	a0,ffffffffc020a668 <sfs_truncfile+0x166>
ffffffffc020a64e:	2485                	addiw	s1,s1,1
ffffffffc020a650:	fe9417e3          	bne	s0,s1,ffffffffc020a63e <sfs_truncfile+0x13c>
ffffffffc020a654:	008aa483          	lw	s1,8(s5)
ffffffffc020a658:	0a941b63          	bne	s0,s1,ffffffffc020a70e <sfs_truncfile+0x20c>
ffffffffc020a65c:	014aa023          	sw	s4,0(s5)
ffffffffc020a660:	4785                	li	a5,1
ffffffffc020a662:	00f9b823          	sd	a5,16(s3)
ffffffffc020a666:	4901                	li	s2,0
ffffffffc020a668:	855a                	mv	a0,s6
ffffffffc020a66a:	8dcfa0ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020a66e:	bddd                	j	ffffffffc020a564 <sfs_truncfile+0x62>
ffffffffc020a670:	86e2                	mv	a3,s8
ffffffffc020a672:	4611                	li	a2,4
ffffffffc020a674:	086c                	addi	a1,sp,28
ffffffffc020a676:	8566                	mv	a0,s9
ffffffffc020a678:	9f3fe0ef          	jal	ra,ffffffffc020906a <sfs_wbuf>
ffffffffc020a67c:	892a                	mv	s2,a0
ffffffffc020a67e:	f56d                	bnez	a0,ffffffffc020a668 <sfs_truncfile+0x166>
ffffffffc020a680:	45e2                	lw	a1,24(sp)
ffffffffc020a682:	8566                	mv	a0,s9
ffffffffc020a684:	bf2ff0ef          	jal	ra,ffffffffc0209a76 <sfs_block_free>
ffffffffc020a688:	b7a5                	j	ffffffffc020a5f0 <sfs_truncfile+0xee>
ffffffffc020a68a:	5975                	li	s2,-3
ffffffffc020a68c:	bde1                	j	ffffffffc020a564 <sfs_truncfile+0x62>
ffffffffc020a68e:	00004697          	auipc	a3,0x4
ffffffffc020a692:	5a268693          	addi	a3,a3,1442 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020a696:	00001617          	auipc	a2,0x1
ffffffffc020a69a:	16260613          	addi	a2,a2,354 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a69e:	39400593          	li	a1,916
ffffffffc020a6a2:	00004517          	auipc	a0,0x4
ffffffffc020a6a6:	76e50513          	addi	a0,a0,1902 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a6aa:	b85f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a6ae:	00004697          	auipc	a3,0x4
ffffffffc020a6b2:	72a68693          	addi	a3,a3,1834 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020a6b6:	00001617          	auipc	a2,0x1
ffffffffc020a6ba:	14260613          	addi	a2,a2,322 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a6be:	39500593          	li	a1,917
ffffffffc020a6c2:	00004517          	auipc	a0,0x4
ffffffffc020a6c6:	74e50513          	addi	a0,a0,1870 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a6ca:	b65f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a6ce:	00005697          	auipc	a3,0x5
ffffffffc020a6d2:	96268693          	addi	a3,a3,-1694 # ffffffffc020f030 <dev_node_ops+0x550>
ffffffffc020a6d6:	00001617          	auipc	a2,0x1
ffffffffc020a6da:	12260613          	addi	a2,a2,290 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a6de:	17b00593          	li	a1,379
ffffffffc020a6e2:	00004517          	auipc	a0,0x4
ffffffffc020a6e6:	72e50513          	addi	a0,a0,1838 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a6ea:	b45f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a6ee:	00005697          	auipc	a3,0x5
ffffffffc020a6f2:	92a68693          	addi	a3,a3,-1750 # ffffffffc020f018 <dev_node_ops+0x538>
ffffffffc020a6f6:	00001617          	auipc	a2,0x1
ffffffffc020a6fa:	10260613          	addi	a2,a2,258 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a6fe:	39c00593          	li	a1,924
ffffffffc020a702:	00004517          	auipc	a0,0x4
ffffffffc020a706:	70e50513          	addi	a0,a0,1806 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a70a:	b25f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a70e:	00005697          	auipc	a3,0x5
ffffffffc020a712:	97268693          	addi	a3,a3,-1678 # ffffffffc020f080 <dev_node_ops+0x5a0>
ffffffffc020a716:	00001617          	auipc	a2,0x1
ffffffffc020a71a:	0e260613          	addi	a2,a2,226 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a71e:	3b500593          	li	a1,949
ffffffffc020a722:	00004517          	auipc	a0,0x4
ffffffffc020a726:	6ee50513          	addi	a0,a0,1774 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a72a:	b05f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a72e:	00005697          	auipc	a3,0x5
ffffffffc020a732:	91a68693          	addi	a3,a3,-1766 # ffffffffc020f048 <dev_node_ops+0x568>
ffffffffc020a736:	00001617          	auipc	a2,0x1
ffffffffc020a73a:	0c260613          	addi	a2,a2,194 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a73e:	12b00593          	li	a1,299
ffffffffc020a742:	00004517          	auipc	a0,0x4
ffffffffc020a746:	6ce50513          	addi	a0,a0,1742 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a74a:	ae5f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a74e:	8762                	mv	a4,s8
ffffffffc020a750:	86be                	mv	a3,a5
ffffffffc020a752:	00004617          	auipc	a2,0x4
ffffffffc020a756:	6ee60613          	addi	a2,a2,1774 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc020a75a:	05300593          	li	a1,83
ffffffffc020a75e:	00004517          	auipc	a0,0x4
ffffffffc020a762:	6b250513          	addi	a0,a0,1714 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a766:	ac9f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020a76a <sfs_load_inode>:
ffffffffc020a76a:	7139                	addi	sp,sp,-64
ffffffffc020a76c:	fc06                	sd	ra,56(sp)
ffffffffc020a76e:	f822                	sd	s0,48(sp)
ffffffffc020a770:	f426                	sd	s1,40(sp)
ffffffffc020a772:	f04a                	sd	s2,32(sp)
ffffffffc020a774:	84b2                	mv	s1,a2
ffffffffc020a776:	892a                	mv	s2,a0
ffffffffc020a778:	ec4e                	sd	s3,24(sp)
ffffffffc020a77a:	e852                	sd	s4,16(sp)
ffffffffc020a77c:	89ae                	mv	s3,a1
ffffffffc020a77e:	e456                	sd	s5,8(sp)
ffffffffc020a780:	a9bfe0ef          	jal	ra,ffffffffc020921a <lock_sfs_fs>
ffffffffc020a784:	45a9                	li	a1,10
ffffffffc020a786:	8526                	mv	a0,s1
ffffffffc020a788:	0a893403          	ld	s0,168(s2)
ffffffffc020a78c:	54f000ef          	jal	ra,ffffffffc020b4da <hash32>
ffffffffc020a790:	02051793          	slli	a5,a0,0x20
ffffffffc020a794:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a798:	9722                	add	a4,a4,s0
ffffffffc020a79a:	843a                	mv	s0,a4
ffffffffc020a79c:	a029                	j	ffffffffc020a7a6 <sfs_load_inode+0x3c>
ffffffffc020a79e:	fc042783          	lw	a5,-64(s0)
ffffffffc020a7a2:	10978863          	beq	a5,s1,ffffffffc020a8b2 <sfs_load_inode+0x148>
ffffffffc020a7a6:	6400                	ld	s0,8(s0)
ffffffffc020a7a8:	fe871be3          	bne	a4,s0,ffffffffc020a79e <sfs_load_inode+0x34>
ffffffffc020a7ac:	04000513          	li	a0,64
ffffffffc020a7b0:	d66f70ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020a7b4:	8aaa                	mv	s5,a0
ffffffffc020a7b6:	16050563          	beqz	a0,ffffffffc020a920 <sfs_load_inode+0x1b6>
ffffffffc020a7ba:	00492683          	lw	a3,4(s2)
ffffffffc020a7be:	18048363          	beqz	s1,ffffffffc020a944 <sfs_load_inode+0x1da>
ffffffffc020a7c2:	18d4f163          	bgeu	s1,a3,ffffffffc020a944 <sfs_load_inode+0x1da>
ffffffffc020a7c6:	03893503          	ld	a0,56(s2)
ffffffffc020a7ca:	85a6                	mv	a1,s1
ffffffffc020a7cc:	6e4000ef          	jal	ra,ffffffffc020aeb0 <bitmap_test>
ffffffffc020a7d0:	18051763          	bnez	a0,ffffffffc020a95e <sfs_load_inode+0x1f4>
ffffffffc020a7d4:	4701                	li	a4,0
ffffffffc020a7d6:	86a6                	mv	a3,s1
ffffffffc020a7d8:	04000613          	li	a2,64
ffffffffc020a7dc:	85d6                	mv	a1,s5
ffffffffc020a7de:	854a                	mv	a0,s2
ffffffffc020a7e0:	80bfe0ef          	jal	ra,ffffffffc0208fea <sfs_rbuf>
ffffffffc020a7e4:	842a                	mv	s0,a0
ffffffffc020a7e6:	0e051563          	bnez	a0,ffffffffc020a8d0 <sfs_load_inode+0x166>
ffffffffc020a7ea:	006ad783          	lhu	a5,6(s5)
ffffffffc020a7ee:	12078b63          	beqz	a5,ffffffffc020a924 <sfs_load_inode+0x1ba>
ffffffffc020a7f2:	6405                	lui	s0,0x1
ffffffffc020a7f4:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a7f8:	97bfd0ef          	jal	ra,ffffffffc0208172 <__alloc_inode>
ffffffffc020a7fc:	8a2a                	mv	s4,a0
ffffffffc020a7fe:	c961                	beqz	a0,ffffffffc020a8ce <sfs_load_inode+0x164>
ffffffffc020a800:	004ad683          	lhu	a3,4(s5)
ffffffffc020a804:	4785                	li	a5,1
ffffffffc020a806:	0cf69c63          	bne	a3,a5,ffffffffc020a8de <sfs_load_inode+0x174>
ffffffffc020a80a:	864a                	mv	a2,s2
ffffffffc020a80c:	00005597          	auipc	a1,0x5
ffffffffc020a810:	98458593          	addi	a1,a1,-1660 # ffffffffc020f190 <sfs_node_fileops>
ffffffffc020a814:	97bfd0ef          	jal	ra,ffffffffc020818e <inode_init>
ffffffffc020a818:	058a2783          	lw	a5,88(s4)
ffffffffc020a81c:	23540413          	addi	s0,s0,565
ffffffffc020a820:	0e879063          	bne	a5,s0,ffffffffc020a900 <sfs_load_inode+0x196>
ffffffffc020a824:	4785                	li	a5,1
ffffffffc020a826:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a82a:	015a3023          	sd	s5,0(s4)
ffffffffc020a82e:	009a2423          	sw	s1,8(s4)
ffffffffc020a832:	000a3823          	sd	zero,16(s4)
ffffffffc020a836:	4585                	li	a1,1
ffffffffc020a838:	020a0513          	addi	a0,s4,32
ffffffffc020a83c:	f03f90ef          	jal	ra,ffffffffc020473e <sem_init>
ffffffffc020a840:	058a2703          	lw	a4,88(s4)
ffffffffc020a844:	6785                	lui	a5,0x1
ffffffffc020a846:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a84a:	14f71663          	bne	a4,a5,ffffffffc020a996 <sfs_load_inode+0x22c>
ffffffffc020a84e:	0a093703          	ld	a4,160(s2)
ffffffffc020a852:	038a0793          	addi	a5,s4,56
ffffffffc020a856:	008a2503          	lw	a0,8(s4)
ffffffffc020a85a:	e31c                	sd	a5,0(a4)
ffffffffc020a85c:	0af93023          	sd	a5,160(s2)
ffffffffc020a860:	09890793          	addi	a5,s2,152
ffffffffc020a864:	0a893403          	ld	s0,168(s2)
ffffffffc020a868:	45a9                	li	a1,10
ffffffffc020a86a:	04ea3023          	sd	a4,64(s4)
ffffffffc020a86e:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a872:	469000ef          	jal	ra,ffffffffc020b4da <hash32>
ffffffffc020a876:	02051713          	slli	a4,a0,0x20
ffffffffc020a87a:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a87e:	97a2                	add	a5,a5,s0
ffffffffc020a880:	6798                	ld	a4,8(a5)
ffffffffc020a882:	048a0693          	addi	a3,s4,72
ffffffffc020a886:	e314                	sd	a3,0(a4)
ffffffffc020a888:	e794                	sd	a3,8(a5)
ffffffffc020a88a:	04ea3823          	sd	a4,80(s4)
ffffffffc020a88e:	04fa3423          	sd	a5,72(s4)
ffffffffc020a892:	854a                	mv	a0,s2
ffffffffc020a894:	997fe0ef          	jal	ra,ffffffffc020922a <unlock_sfs_fs>
ffffffffc020a898:	4401                	li	s0,0
ffffffffc020a89a:	0149b023          	sd	s4,0(s3)
ffffffffc020a89e:	70e2                	ld	ra,56(sp)
ffffffffc020a8a0:	8522                	mv	a0,s0
ffffffffc020a8a2:	7442                	ld	s0,48(sp)
ffffffffc020a8a4:	74a2                	ld	s1,40(sp)
ffffffffc020a8a6:	7902                	ld	s2,32(sp)
ffffffffc020a8a8:	69e2                	ld	s3,24(sp)
ffffffffc020a8aa:	6a42                	ld	s4,16(sp)
ffffffffc020a8ac:	6aa2                	ld	s5,8(sp)
ffffffffc020a8ae:	6121                	addi	sp,sp,64
ffffffffc020a8b0:	8082                	ret
ffffffffc020a8b2:	fb840a13          	addi	s4,s0,-72
ffffffffc020a8b6:	8552                	mv	a0,s4
ffffffffc020a8b8:	939fd0ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc020a8bc:	4785                	li	a5,1
ffffffffc020a8be:	fcf51ae3          	bne	a0,a5,ffffffffc020a892 <sfs_load_inode+0x128>
ffffffffc020a8c2:	fd042783          	lw	a5,-48(s0)
ffffffffc020a8c6:	2785                	addiw	a5,a5,1
ffffffffc020a8c8:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a8cc:	b7d9                	j	ffffffffc020a892 <sfs_load_inode+0x128>
ffffffffc020a8ce:	5471                	li	s0,-4
ffffffffc020a8d0:	8556                	mv	a0,s5
ffffffffc020a8d2:	cf4f70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020a8d6:	854a                	mv	a0,s2
ffffffffc020a8d8:	953fe0ef          	jal	ra,ffffffffc020922a <unlock_sfs_fs>
ffffffffc020a8dc:	b7c9                	j	ffffffffc020a89e <sfs_load_inode+0x134>
ffffffffc020a8de:	4789                	li	a5,2
ffffffffc020a8e0:	08f69f63          	bne	a3,a5,ffffffffc020a97e <sfs_load_inode+0x214>
ffffffffc020a8e4:	864a                	mv	a2,s2
ffffffffc020a8e6:	00005597          	auipc	a1,0x5
ffffffffc020a8ea:	82a58593          	addi	a1,a1,-2006 # ffffffffc020f110 <sfs_node_dirops>
ffffffffc020a8ee:	8a1fd0ef          	jal	ra,ffffffffc020818e <inode_init>
ffffffffc020a8f2:	058a2703          	lw	a4,88(s4)
ffffffffc020a8f6:	6785                	lui	a5,0x1
ffffffffc020a8f8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a8fc:	f2f704e3          	beq	a4,a5,ffffffffc020a824 <sfs_load_inode+0xba>
ffffffffc020a900:	00004697          	auipc	a3,0x4
ffffffffc020a904:	4d868693          	addi	a3,a3,1240 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020a908:	00001617          	auipc	a2,0x1
ffffffffc020a90c:	ef060613          	addi	a2,a2,-272 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a910:	07700593          	li	a1,119
ffffffffc020a914:	00004517          	auipc	a0,0x4
ffffffffc020a918:	4fc50513          	addi	a0,a0,1276 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a91c:	913f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a920:	5471                	li	s0,-4
ffffffffc020a922:	bf55                	j	ffffffffc020a8d6 <sfs_load_inode+0x16c>
ffffffffc020a924:	00004697          	auipc	a3,0x4
ffffffffc020a928:	77468693          	addi	a3,a3,1908 # ffffffffc020f098 <dev_node_ops+0x5b8>
ffffffffc020a92c:	00001617          	auipc	a2,0x1
ffffffffc020a930:	ecc60613          	addi	a2,a2,-308 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a934:	0ad00593          	li	a1,173
ffffffffc020a938:	00004517          	auipc	a0,0x4
ffffffffc020a93c:	4d850513          	addi	a0,a0,1240 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a940:	8eff50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a944:	8726                	mv	a4,s1
ffffffffc020a946:	00004617          	auipc	a2,0x4
ffffffffc020a94a:	4fa60613          	addi	a2,a2,1274 # ffffffffc020ee40 <dev_node_ops+0x360>
ffffffffc020a94e:	05300593          	li	a1,83
ffffffffc020a952:	00004517          	auipc	a0,0x4
ffffffffc020a956:	4be50513          	addi	a0,a0,1214 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a95a:	8d5f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a95e:	00004697          	auipc	a3,0x4
ffffffffc020a962:	51a68693          	addi	a3,a3,1306 # ffffffffc020ee78 <dev_node_ops+0x398>
ffffffffc020a966:	00001617          	auipc	a2,0x1
ffffffffc020a96a:	e9260613          	addi	a2,a2,-366 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a96e:	0a800593          	li	a1,168
ffffffffc020a972:	00004517          	auipc	a0,0x4
ffffffffc020a976:	49e50513          	addi	a0,a0,1182 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a97a:	8b5f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a97e:	00004617          	auipc	a2,0x4
ffffffffc020a982:	4aa60613          	addi	a2,a2,1194 # ffffffffc020ee28 <dev_node_ops+0x348>
ffffffffc020a986:	02e00593          	li	a1,46
ffffffffc020a98a:	00004517          	auipc	a0,0x4
ffffffffc020a98e:	48650513          	addi	a0,a0,1158 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a992:	89df50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020a996:	00004697          	auipc	a3,0x4
ffffffffc020a99a:	44268693          	addi	a3,a3,1090 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020a99e:	00001617          	auipc	a2,0x1
ffffffffc020a9a2:	e5a60613          	addi	a2,a2,-422 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020a9a6:	0b100593          	li	a1,177
ffffffffc020a9aa:	00004517          	auipc	a0,0x4
ffffffffc020a9ae:	46650513          	addi	a0,a0,1126 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020a9b2:	87df50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020a9b6 <sfs_lookup>:
ffffffffc020a9b6:	7139                	addi	sp,sp,-64
ffffffffc020a9b8:	ec4e                	sd	s3,24(sp)
ffffffffc020a9ba:	06853983          	ld	s3,104(a0)
ffffffffc020a9be:	fc06                	sd	ra,56(sp)
ffffffffc020a9c0:	f822                	sd	s0,48(sp)
ffffffffc020a9c2:	f426                	sd	s1,40(sp)
ffffffffc020a9c4:	f04a                	sd	s2,32(sp)
ffffffffc020a9c6:	e852                	sd	s4,16(sp)
ffffffffc020a9c8:	0a098c63          	beqz	s3,ffffffffc020aa80 <sfs_lookup+0xca>
ffffffffc020a9cc:	0b09a783          	lw	a5,176(s3)
ffffffffc020a9d0:	ebc5                	bnez	a5,ffffffffc020aa80 <sfs_lookup+0xca>
ffffffffc020a9d2:	0005c783          	lbu	a5,0(a1)
ffffffffc020a9d6:	84ae                	mv	s1,a1
ffffffffc020a9d8:	c7c1                	beqz	a5,ffffffffc020aa60 <sfs_lookup+0xaa>
ffffffffc020a9da:	02f00713          	li	a4,47
ffffffffc020a9de:	08e78163          	beq	a5,a4,ffffffffc020aa60 <sfs_lookup+0xaa>
ffffffffc020a9e2:	842a                	mv	s0,a0
ffffffffc020a9e4:	8a32                	mv	s4,a2
ffffffffc020a9e6:	80bfd0ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc020a9ea:	4c38                	lw	a4,88(s0)
ffffffffc020a9ec:	6785                	lui	a5,0x1
ffffffffc020a9ee:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a9f2:	0af71763          	bne	a4,a5,ffffffffc020aaa0 <sfs_lookup+0xea>
ffffffffc020a9f6:	6018                	ld	a4,0(s0)
ffffffffc020a9f8:	4789                	li	a5,2
ffffffffc020a9fa:	00475703          	lhu	a4,4(a4)
ffffffffc020a9fe:	04f71c63          	bne	a4,a5,ffffffffc020aa56 <sfs_lookup+0xa0>
ffffffffc020aa02:	02040913          	addi	s2,s0,32
ffffffffc020aa06:	854a                	mv	a0,s2
ffffffffc020aa08:	d43f90ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020aa0c:	8626                	mv	a2,s1
ffffffffc020aa0e:	0054                	addi	a3,sp,4
ffffffffc020aa10:	85a2                	mv	a1,s0
ffffffffc020aa12:	854e                	mv	a0,s3
ffffffffc020aa14:	a29ff0ef          	jal	ra,ffffffffc020a43c <sfs_dirent_search_nolock.constprop.0>
ffffffffc020aa18:	84aa                	mv	s1,a0
ffffffffc020aa1a:	854a                	mv	a0,s2
ffffffffc020aa1c:	d2bf90ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020aa20:	cc89                	beqz	s1,ffffffffc020aa3a <sfs_lookup+0x84>
ffffffffc020aa22:	8522                	mv	a0,s0
ffffffffc020aa24:	89bfd0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc020aa28:	70e2                	ld	ra,56(sp)
ffffffffc020aa2a:	7442                	ld	s0,48(sp)
ffffffffc020aa2c:	7902                	ld	s2,32(sp)
ffffffffc020aa2e:	69e2                	ld	s3,24(sp)
ffffffffc020aa30:	6a42                	ld	s4,16(sp)
ffffffffc020aa32:	8526                	mv	a0,s1
ffffffffc020aa34:	74a2                	ld	s1,40(sp)
ffffffffc020aa36:	6121                	addi	sp,sp,64
ffffffffc020aa38:	8082                	ret
ffffffffc020aa3a:	4612                	lw	a2,4(sp)
ffffffffc020aa3c:	002c                	addi	a1,sp,8
ffffffffc020aa3e:	854e                	mv	a0,s3
ffffffffc020aa40:	d2bff0ef          	jal	ra,ffffffffc020a76a <sfs_load_inode>
ffffffffc020aa44:	84aa                	mv	s1,a0
ffffffffc020aa46:	8522                	mv	a0,s0
ffffffffc020aa48:	877fd0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc020aa4c:	fcf1                	bnez	s1,ffffffffc020aa28 <sfs_lookup+0x72>
ffffffffc020aa4e:	67a2                	ld	a5,8(sp)
ffffffffc020aa50:	00fa3023          	sd	a5,0(s4)
ffffffffc020aa54:	bfd1                	j	ffffffffc020aa28 <sfs_lookup+0x72>
ffffffffc020aa56:	8522                	mv	a0,s0
ffffffffc020aa58:	867fd0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc020aa5c:	54b9                	li	s1,-18
ffffffffc020aa5e:	b7e9                	j	ffffffffc020aa28 <sfs_lookup+0x72>
ffffffffc020aa60:	00004697          	auipc	a3,0x4
ffffffffc020aa64:	65068693          	addi	a3,a3,1616 # ffffffffc020f0b0 <dev_node_ops+0x5d0>
ffffffffc020aa68:	00001617          	auipc	a2,0x1
ffffffffc020aa6c:	d9060613          	addi	a2,a2,-624 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020aa70:	3c600593          	li	a1,966
ffffffffc020aa74:	00004517          	auipc	a0,0x4
ffffffffc020aa78:	39c50513          	addi	a0,a0,924 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020aa7c:	fb2f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020aa80:	00004697          	auipc	a3,0x4
ffffffffc020aa84:	1b068693          	addi	a3,a3,432 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020aa88:	00001617          	auipc	a2,0x1
ffffffffc020aa8c:	d7060613          	addi	a2,a2,-656 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020aa90:	3c500593          	li	a1,965
ffffffffc020aa94:	00004517          	auipc	a0,0x4
ffffffffc020aa98:	37c50513          	addi	a0,a0,892 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020aa9c:	f92f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020aaa0:	00004697          	auipc	a3,0x4
ffffffffc020aaa4:	33868693          	addi	a3,a3,824 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020aaa8:	00001617          	auipc	a2,0x1
ffffffffc020aaac:	d5060613          	addi	a2,a2,-688 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020aab0:	3c800593          	li	a1,968
ffffffffc020aab4:	00004517          	auipc	a0,0x4
ffffffffc020aab8:	35c50513          	addi	a0,a0,860 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020aabc:	f72f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020aac0 <sfs_namefile>:
ffffffffc020aac0:	6d98                	ld	a4,24(a1)
ffffffffc020aac2:	7175                	addi	sp,sp,-144
ffffffffc020aac4:	e506                	sd	ra,136(sp)
ffffffffc020aac6:	e122                	sd	s0,128(sp)
ffffffffc020aac8:	fca6                	sd	s1,120(sp)
ffffffffc020aaca:	f8ca                	sd	s2,112(sp)
ffffffffc020aacc:	f4ce                	sd	s3,104(sp)
ffffffffc020aace:	f0d2                	sd	s4,96(sp)
ffffffffc020aad0:	ecd6                	sd	s5,88(sp)
ffffffffc020aad2:	e8da                	sd	s6,80(sp)
ffffffffc020aad4:	e4de                	sd	s7,72(sp)
ffffffffc020aad6:	e0e2                	sd	s8,64(sp)
ffffffffc020aad8:	fc66                	sd	s9,56(sp)
ffffffffc020aada:	f86a                	sd	s10,48(sp)
ffffffffc020aadc:	f46e                	sd	s11,40(sp)
ffffffffc020aade:	e42e                	sd	a1,8(sp)
ffffffffc020aae0:	4789                	li	a5,2
ffffffffc020aae2:	1ae7f363          	bgeu	a5,a4,ffffffffc020ac88 <sfs_namefile+0x1c8>
ffffffffc020aae6:	89aa                	mv	s3,a0
ffffffffc020aae8:	10400513          	li	a0,260
ffffffffc020aaec:	a2af70ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020aaf0:	842a                	mv	s0,a0
ffffffffc020aaf2:	18050b63          	beqz	a0,ffffffffc020ac88 <sfs_namefile+0x1c8>
ffffffffc020aaf6:	0689b483          	ld	s1,104(s3)
ffffffffc020aafa:	1e048963          	beqz	s1,ffffffffc020acec <sfs_namefile+0x22c>
ffffffffc020aafe:	0b04a783          	lw	a5,176(s1)
ffffffffc020ab02:	1e079563          	bnez	a5,ffffffffc020acec <sfs_namefile+0x22c>
ffffffffc020ab06:	0589ac83          	lw	s9,88(s3)
ffffffffc020ab0a:	6785                	lui	a5,0x1
ffffffffc020ab0c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ab10:	1afc9e63          	bne	s9,a5,ffffffffc020accc <sfs_namefile+0x20c>
ffffffffc020ab14:	6722                	ld	a4,8(sp)
ffffffffc020ab16:	854e                	mv	a0,s3
ffffffffc020ab18:	8ace                	mv	s5,s3
ffffffffc020ab1a:	6f1c                	ld	a5,24(a4)
ffffffffc020ab1c:	00073b03          	ld	s6,0(a4)
ffffffffc020ab20:	02098a13          	addi	s4,s3,32
ffffffffc020ab24:	ffe78b93          	addi	s7,a5,-2
ffffffffc020ab28:	9b3e                	add	s6,s6,a5
ffffffffc020ab2a:	00004d17          	auipc	s10,0x4
ffffffffc020ab2e:	5a6d0d13          	addi	s10,s10,1446 # ffffffffc020f0d0 <dev_node_ops+0x5f0>
ffffffffc020ab32:	ebefd0ef          	jal	ra,ffffffffc02081f0 <inode_ref_inc>
ffffffffc020ab36:	00440c13          	addi	s8,s0,4
ffffffffc020ab3a:	e066                	sd	s9,0(sp)
ffffffffc020ab3c:	8552                	mv	a0,s4
ffffffffc020ab3e:	c0df90ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020ab42:	0854                	addi	a3,sp,20
ffffffffc020ab44:	866a                	mv	a2,s10
ffffffffc020ab46:	85d6                	mv	a1,s5
ffffffffc020ab48:	8526                	mv	a0,s1
ffffffffc020ab4a:	8f3ff0ef          	jal	ra,ffffffffc020a43c <sfs_dirent_search_nolock.constprop.0>
ffffffffc020ab4e:	8daa                	mv	s11,a0
ffffffffc020ab50:	8552                	mv	a0,s4
ffffffffc020ab52:	bf5f90ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020ab56:	020d8863          	beqz	s11,ffffffffc020ab86 <sfs_namefile+0xc6>
ffffffffc020ab5a:	854e                	mv	a0,s3
ffffffffc020ab5c:	f62fd0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc020ab60:	8522                	mv	a0,s0
ffffffffc020ab62:	a64f70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020ab66:	60aa                	ld	ra,136(sp)
ffffffffc020ab68:	640a                	ld	s0,128(sp)
ffffffffc020ab6a:	74e6                	ld	s1,120(sp)
ffffffffc020ab6c:	7946                	ld	s2,112(sp)
ffffffffc020ab6e:	79a6                	ld	s3,104(sp)
ffffffffc020ab70:	7a06                	ld	s4,96(sp)
ffffffffc020ab72:	6ae6                	ld	s5,88(sp)
ffffffffc020ab74:	6b46                	ld	s6,80(sp)
ffffffffc020ab76:	6ba6                	ld	s7,72(sp)
ffffffffc020ab78:	6c06                	ld	s8,64(sp)
ffffffffc020ab7a:	7ce2                	ld	s9,56(sp)
ffffffffc020ab7c:	7d42                	ld	s10,48(sp)
ffffffffc020ab7e:	856e                	mv	a0,s11
ffffffffc020ab80:	7da2                	ld	s11,40(sp)
ffffffffc020ab82:	6149                	addi	sp,sp,144
ffffffffc020ab84:	8082                	ret
ffffffffc020ab86:	4652                	lw	a2,20(sp)
ffffffffc020ab88:	082c                	addi	a1,sp,24
ffffffffc020ab8a:	8526                	mv	a0,s1
ffffffffc020ab8c:	bdfff0ef          	jal	ra,ffffffffc020a76a <sfs_load_inode>
ffffffffc020ab90:	8daa                	mv	s11,a0
ffffffffc020ab92:	f561                	bnez	a0,ffffffffc020ab5a <sfs_namefile+0x9a>
ffffffffc020ab94:	854e                	mv	a0,s3
ffffffffc020ab96:	008aa903          	lw	s2,8(s5)
ffffffffc020ab9a:	f24fd0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc020ab9e:	6ce2                	ld	s9,24(sp)
ffffffffc020aba0:	0b3c8463          	beq	s9,s3,ffffffffc020ac48 <sfs_namefile+0x188>
ffffffffc020aba4:	100c8463          	beqz	s9,ffffffffc020acac <sfs_namefile+0x1ec>
ffffffffc020aba8:	058ca703          	lw	a4,88(s9)
ffffffffc020abac:	6782                	ld	a5,0(sp)
ffffffffc020abae:	0ef71f63          	bne	a4,a5,ffffffffc020acac <sfs_namefile+0x1ec>
ffffffffc020abb2:	008ca703          	lw	a4,8(s9)
ffffffffc020abb6:	8ae6                	mv	s5,s9
ffffffffc020abb8:	0d270a63          	beq	a4,s2,ffffffffc020ac8c <sfs_namefile+0x1cc>
ffffffffc020abbc:	000cb703          	ld	a4,0(s9)
ffffffffc020abc0:	4789                	li	a5,2
ffffffffc020abc2:	00475703          	lhu	a4,4(a4)
ffffffffc020abc6:	0cf71363          	bne	a4,a5,ffffffffc020ac8c <sfs_namefile+0x1cc>
ffffffffc020abca:	020c8a13          	addi	s4,s9,32
ffffffffc020abce:	8552                	mv	a0,s4
ffffffffc020abd0:	b7bf90ef          	jal	ra,ffffffffc020474a <down>
ffffffffc020abd4:	000cb703          	ld	a4,0(s9)
ffffffffc020abd8:	00872983          	lw	s3,8(a4)
ffffffffc020abdc:	01304963          	bgtz	s3,ffffffffc020abee <sfs_namefile+0x12e>
ffffffffc020abe0:	a899                	j	ffffffffc020ac36 <sfs_namefile+0x176>
ffffffffc020abe2:	4018                	lw	a4,0(s0)
ffffffffc020abe4:	01270e63          	beq	a4,s2,ffffffffc020ac00 <sfs_namefile+0x140>
ffffffffc020abe8:	2d85                	addiw	s11,s11,1
ffffffffc020abea:	05b98663          	beq	s3,s11,ffffffffc020ac36 <sfs_namefile+0x176>
ffffffffc020abee:	86a2                	mv	a3,s0
ffffffffc020abf0:	866e                	mv	a2,s11
ffffffffc020abf2:	85e6                	mv	a1,s9
ffffffffc020abf4:	8526                	mv	a0,s1
ffffffffc020abf6:	e48ff0ef          	jal	ra,ffffffffc020a23e <sfs_dirent_read_nolock>
ffffffffc020abfa:	872a                	mv	a4,a0
ffffffffc020abfc:	d17d                	beqz	a0,ffffffffc020abe2 <sfs_namefile+0x122>
ffffffffc020abfe:	a82d                	j	ffffffffc020ac38 <sfs_namefile+0x178>
ffffffffc020ac00:	8552                	mv	a0,s4
ffffffffc020ac02:	b45f90ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020ac06:	8562                	mv	a0,s8
ffffffffc020ac08:	34a000ef          	jal	ra,ffffffffc020af52 <strlen>
ffffffffc020ac0c:	00150793          	addi	a5,a0,1
ffffffffc020ac10:	862a                	mv	a2,a0
ffffffffc020ac12:	06fbe863          	bltu	s7,a5,ffffffffc020ac82 <sfs_namefile+0x1c2>
ffffffffc020ac16:	fff64913          	not	s2,a2
ffffffffc020ac1a:	995a                	add	s2,s2,s6
ffffffffc020ac1c:	85e2                	mv	a1,s8
ffffffffc020ac1e:	854a                	mv	a0,s2
ffffffffc020ac20:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020ac24:	422000ef          	jal	ra,ffffffffc020b046 <memcpy>
ffffffffc020ac28:	02f00793          	li	a5,47
ffffffffc020ac2c:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020ac30:	89e6                	mv	s3,s9
ffffffffc020ac32:	8b4a                	mv	s6,s2
ffffffffc020ac34:	b721                	j	ffffffffc020ab3c <sfs_namefile+0x7c>
ffffffffc020ac36:	5741                	li	a4,-16
ffffffffc020ac38:	8552                	mv	a0,s4
ffffffffc020ac3a:	e03a                	sd	a4,0(sp)
ffffffffc020ac3c:	b0bf90ef          	jal	ra,ffffffffc0204746 <up>
ffffffffc020ac40:	6702                	ld	a4,0(sp)
ffffffffc020ac42:	89e6                	mv	s3,s9
ffffffffc020ac44:	8dba                	mv	s11,a4
ffffffffc020ac46:	bf11                	j	ffffffffc020ab5a <sfs_namefile+0x9a>
ffffffffc020ac48:	854e                	mv	a0,s3
ffffffffc020ac4a:	e74fd0ef          	jal	ra,ffffffffc02082be <inode_ref_dec>
ffffffffc020ac4e:	64a2                	ld	s1,8(sp)
ffffffffc020ac50:	85da                	mv	a1,s6
ffffffffc020ac52:	6c98                	ld	a4,24(s1)
ffffffffc020ac54:	6088                	ld	a0,0(s1)
ffffffffc020ac56:	1779                	addi	a4,a4,-2
ffffffffc020ac58:	41770bb3          	sub	s7,a4,s7
ffffffffc020ac5c:	865e                	mv	a2,s7
ffffffffc020ac5e:	0505                	addi	a0,a0,1
ffffffffc020ac60:	3a6000ef          	jal	ra,ffffffffc020b006 <memmove>
ffffffffc020ac64:	02f00713          	li	a4,47
ffffffffc020ac68:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020ac6c:	955e                	add	a0,a0,s7
ffffffffc020ac6e:	00050023          	sb	zero,0(a0)
ffffffffc020ac72:	85de                	mv	a1,s7
ffffffffc020ac74:	8526                	mv	a0,s1
ffffffffc020ac76:	b2dfa0ef          	jal	ra,ffffffffc02057a2 <iobuf_skip>
ffffffffc020ac7a:	8522                	mv	a0,s0
ffffffffc020ac7c:	94af70ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020ac80:	b5dd                	j	ffffffffc020ab66 <sfs_namefile+0xa6>
ffffffffc020ac82:	89e6                	mv	s3,s9
ffffffffc020ac84:	5df1                	li	s11,-4
ffffffffc020ac86:	bdd1                	j	ffffffffc020ab5a <sfs_namefile+0x9a>
ffffffffc020ac88:	5df1                	li	s11,-4
ffffffffc020ac8a:	bdf1                	j	ffffffffc020ab66 <sfs_namefile+0xa6>
ffffffffc020ac8c:	00004697          	auipc	a3,0x4
ffffffffc020ac90:	44c68693          	addi	a3,a3,1100 # ffffffffc020f0d8 <dev_node_ops+0x5f8>
ffffffffc020ac94:	00001617          	auipc	a2,0x1
ffffffffc020ac98:	b6460613          	addi	a2,a2,-1180 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020ac9c:	2e400593          	li	a1,740
ffffffffc020aca0:	00004517          	auipc	a0,0x4
ffffffffc020aca4:	17050513          	addi	a0,a0,368 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020aca8:	d86f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020acac:	00004697          	auipc	a3,0x4
ffffffffc020acb0:	12c68693          	addi	a3,a3,300 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020acb4:	00001617          	auipc	a2,0x1
ffffffffc020acb8:	b4460613          	addi	a2,a2,-1212 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020acbc:	2e300593          	li	a1,739
ffffffffc020acc0:	00004517          	auipc	a0,0x4
ffffffffc020acc4:	15050513          	addi	a0,a0,336 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020acc8:	d66f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020accc:	00004697          	auipc	a3,0x4
ffffffffc020acd0:	10c68693          	addi	a3,a3,268 # ffffffffc020edd8 <dev_node_ops+0x2f8>
ffffffffc020acd4:	00001617          	auipc	a2,0x1
ffffffffc020acd8:	b2460613          	addi	a2,a2,-1244 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020acdc:	2d000593          	li	a1,720
ffffffffc020ace0:	00004517          	auipc	a0,0x4
ffffffffc020ace4:	13050513          	addi	a0,a0,304 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020ace8:	d46f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020acec:	00004697          	auipc	a3,0x4
ffffffffc020acf0:	f4468693          	addi	a3,a3,-188 # ffffffffc020ec30 <dev_node_ops+0x150>
ffffffffc020acf4:	00001617          	auipc	a2,0x1
ffffffffc020acf8:	b0460613          	addi	a2,a2,-1276 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020acfc:	2cf00593          	li	a1,719
ffffffffc020ad00:	00004517          	auipc	a0,0x4
ffffffffc020ad04:	11050513          	addi	a0,a0,272 # ffffffffc020ee10 <dev_node_ops+0x330>
ffffffffc020ad08:	d26f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020ad0c <bitmap_translate.part.0>:
ffffffffc020ad0c:	1141                	addi	sp,sp,-16
ffffffffc020ad0e:	00004697          	auipc	a3,0x4
ffffffffc020ad12:	50268693          	addi	a3,a3,1282 # ffffffffc020f210 <sfs_node_fileops+0x80>
ffffffffc020ad16:	00001617          	auipc	a2,0x1
ffffffffc020ad1a:	ae260613          	addi	a2,a2,-1310 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020ad1e:	04c00593          	li	a1,76
ffffffffc020ad22:	00004517          	auipc	a0,0x4
ffffffffc020ad26:	50650513          	addi	a0,a0,1286 # ffffffffc020f228 <sfs_node_fileops+0x98>
ffffffffc020ad2a:	e406                	sd	ra,8(sp)
ffffffffc020ad2c:	d02f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020ad30 <bitmap_create>:
ffffffffc020ad30:	7139                	addi	sp,sp,-64
ffffffffc020ad32:	fc06                	sd	ra,56(sp)
ffffffffc020ad34:	f822                	sd	s0,48(sp)
ffffffffc020ad36:	f426                	sd	s1,40(sp)
ffffffffc020ad38:	f04a                	sd	s2,32(sp)
ffffffffc020ad3a:	ec4e                	sd	s3,24(sp)
ffffffffc020ad3c:	e852                	sd	s4,16(sp)
ffffffffc020ad3e:	e456                	sd	s5,8(sp)
ffffffffc020ad40:	c14d                	beqz	a0,ffffffffc020ade2 <bitmap_create+0xb2>
ffffffffc020ad42:	842a                	mv	s0,a0
ffffffffc020ad44:	4541                	li	a0,16
ffffffffc020ad46:	fd1f60ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020ad4a:	84aa                	mv	s1,a0
ffffffffc020ad4c:	cd25                	beqz	a0,ffffffffc020adc4 <bitmap_create+0x94>
ffffffffc020ad4e:	02041a13          	slli	s4,s0,0x20
ffffffffc020ad52:	020a5a13          	srli	s4,s4,0x20
ffffffffc020ad56:	01fa0793          	addi	a5,s4,31
ffffffffc020ad5a:	0057d993          	srli	s3,a5,0x5
ffffffffc020ad5e:	00299a93          	slli	s5,s3,0x2
ffffffffc020ad62:	8556                	mv	a0,s5
ffffffffc020ad64:	894e                	mv	s2,s3
ffffffffc020ad66:	fb1f60ef          	jal	ra,ffffffffc0201d16 <kmalloc>
ffffffffc020ad6a:	c53d                	beqz	a0,ffffffffc020add8 <bitmap_create+0xa8>
ffffffffc020ad6c:	0134a223          	sw	s3,4(s1)
ffffffffc020ad70:	c080                	sw	s0,0(s1)
ffffffffc020ad72:	8656                	mv	a2,s5
ffffffffc020ad74:	0ff00593          	li	a1,255
ffffffffc020ad78:	27c000ef          	jal	ra,ffffffffc020aff4 <memset>
ffffffffc020ad7c:	e488                	sd	a0,8(s1)
ffffffffc020ad7e:	0996                	slli	s3,s3,0x5
ffffffffc020ad80:	053a0263          	beq	s4,s3,ffffffffc020adc4 <bitmap_create+0x94>
ffffffffc020ad84:	fff9079b          	addiw	a5,s2,-1
ffffffffc020ad88:	0057969b          	slliw	a3,a5,0x5
ffffffffc020ad8c:	0054561b          	srliw	a2,s0,0x5
ffffffffc020ad90:	40d4073b          	subw	a4,s0,a3
ffffffffc020ad94:	0054541b          	srliw	s0,s0,0x5
ffffffffc020ad98:	08f61463          	bne	a2,a5,ffffffffc020ae20 <bitmap_create+0xf0>
ffffffffc020ad9c:	fff7069b          	addiw	a3,a4,-1
ffffffffc020ada0:	47f9                	li	a5,30
ffffffffc020ada2:	04d7ef63          	bltu	a5,a3,ffffffffc020ae00 <bitmap_create+0xd0>
ffffffffc020ada6:	1402                	slli	s0,s0,0x20
ffffffffc020ada8:	8079                	srli	s0,s0,0x1e
ffffffffc020adaa:	9522                	add	a0,a0,s0
ffffffffc020adac:	411c                	lw	a5,0(a0)
ffffffffc020adae:	4585                	li	a1,1
ffffffffc020adb0:	02000613          	li	a2,32
ffffffffc020adb4:	00e596bb          	sllw	a3,a1,a4
ffffffffc020adb8:	8fb5                	xor	a5,a5,a3
ffffffffc020adba:	2705                	addiw	a4,a4,1
ffffffffc020adbc:	2781                	sext.w	a5,a5
ffffffffc020adbe:	fec71be3          	bne	a4,a2,ffffffffc020adb4 <bitmap_create+0x84>
ffffffffc020adc2:	c11c                	sw	a5,0(a0)
ffffffffc020adc4:	70e2                	ld	ra,56(sp)
ffffffffc020adc6:	7442                	ld	s0,48(sp)
ffffffffc020adc8:	7902                	ld	s2,32(sp)
ffffffffc020adca:	69e2                	ld	s3,24(sp)
ffffffffc020adcc:	6a42                	ld	s4,16(sp)
ffffffffc020adce:	6aa2                	ld	s5,8(sp)
ffffffffc020add0:	8526                	mv	a0,s1
ffffffffc020add2:	74a2                	ld	s1,40(sp)
ffffffffc020add4:	6121                	addi	sp,sp,64
ffffffffc020add6:	8082                	ret
ffffffffc020add8:	8526                	mv	a0,s1
ffffffffc020adda:	fedf60ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020adde:	4481                	li	s1,0
ffffffffc020ade0:	b7d5                	j	ffffffffc020adc4 <bitmap_create+0x94>
ffffffffc020ade2:	00004697          	auipc	a3,0x4
ffffffffc020ade6:	45e68693          	addi	a3,a3,1118 # ffffffffc020f240 <sfs_node_fileops+0xb0>
ffffffffc020adea:	00001617          	auipc	a2,0x1
ffffffffc020adee:	a0e60613          	addi	a2,a2,-1522 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020adf2:	45d5                	li	a1,21
ffffffffc020adf4:	00004517          	auipc	a0,0x4
ffffffffc020adf8:	43450513          	addi	a0,a0,1076 # ffffffffc020f228 <sfs_node_fileops+0x98>
ffffffffc020adfc:	c32f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020ae00:	00004697          	auipc	a3,0x4
ffffffffc020ae04:	48068693          	addi	a3,a3,1152 # ffffffffc020f280 <sfs_node_fileops+0xf0>
ffffffffc020ae08:	00001617          	auipc	a2,0x1
ffffffffc020ae0c:	9f060613          	addi	a2,a2,-1552 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020ae10:	02b00593          	li	a1,43
ffffffffc020ae14:	00004517          	auipc	a0,0x4
ffffffffc020ae18:	41450513          	addi	a0,a0,1044 # ffffffffc020f228 <sfs_node_fileops+0x98>
ffffffffc020ae1c:	c12f50ef          	jal	ra,ffffffffc020022e <__panic>
ffffffffc020ae20:	00004697          	auipc	a3,0x4
ffffffffc020ae24:	44868693          	addi	a3,a3,1096 # ffffffffc020f268 <sfs_node_fileops+0xd8>
ffffffffc020ae28:	00001617          	auipc	a2,0x1
ffffffffc020ae2c:	9d060613          	addi	a2,a2,-1584 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020ae30:	02a00593          	li	a1,42
ffffffffc020ae34:	00004517          	auipc	a0,0x4
ffffffffc020ae38:	3f450513          	addi	a0,a0,1012 # ffffffffc020f228 <sfs_node_fileops+0x98>
ffffffffc020ae3c:	bf2f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020ae40 <bitmap_alloc>:
ffffffffc020ae40:	4150                	lw	a2,4(a0)
ffffffffc020ae42:	651c                	ld	a5,8(a0)
ffffffffc020ae44:	c231                	beqz	a2,ffffffffc020ae88 <bitmap_alloc+0x48>
ffffffffc020ae46:	4701                	li	a4,0
ffffffffc020ae48:	a029                	j	ffffffffc020ae52 <bitmap_alloc+0x12>
ffffffffc020ae4a:	2705                	addiw	a4,a4,1
ffffffffc020ae4c:	0791                	addi	a5,a5,4
ffffffffc020ae4e:	02e60d63          	beq	a2,a4,ffffffffc020ae88 <bitmap_alloc+0x48>
ffffffffc020ae52:	4394                	lw	a3,0(a5)
ffffffffc020ae54:	dafd                	beqz	a3,ffffffffc020ae4a <bitmap_alloc+0xa>
ffffffffc020ae56:	4501                	li	a0,0
ffffffffc020ae58:	4885                	li	a7,1
ffffffffc020ae5a:	8e36                	mv	t3,a3
ffffffffc020ae5c:	02000313          	li	t1,32
ffffffffc020ae60:	a021                	j	ffffffffc020ae68 <bitmap_alloc+0x28>
ffffffffc020ae62:	2505                	addiw	a0,a0,1
ffffffffc020ae64:	02650463          	beq	a0,t1,ffffffffc020ae8c <bitmap_alloc+0x4c>
ffffffffc020ae68:	00a8983b          	sllw	a6,a7,a0
ffffffffc020ae6c:	0106f633          	and	a2,a3,a6
ffffffffc020ae70:	2601                	sext.w	a2,a2
ffffffffc020ae72:	da65                	beqz	a2,ffffffffc020ae62 <bitmap_alloc+0x22>
ffffffffc020ae74:	010e4833          	xor	a6,t3,a6
ffffffffc020ae78:	0057171b          	slliw	a4,a4,0x5
ffffffffc020ae7c:	9f29                	addw	a4,a4,a0
ffffffffc020ae7e:	0107a023          	sw	a6,0(a5)
ffffffffc020ae82:	c198                	sw	a4,0(a1)
ffffffffc020ae84:	4501                	li	a0,0
ffffffffc020ae86:	8082                	ret
ffffffffc020ae88:	5571                	li	a0,-4
ffffffffc020ae8a:	8082                	ret
ffffffffc020ae8c:	1141                	addi	sp,sp,-16
ffffffffc020ae8e:	00002697          	auipc	a3,0x2
ffffffffc020ae92:	dda68693          	addi	a3,a3,-550 # ffffffffc020cc68 <default_pmm_manager+0x4a8>
ffffffffc020ae96:	00001617          	auipc	a2,0x1
ffffffffc020ae9a:	96260613          	addi	a2,a2,-1694 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020ae9e:	04300593          	li	a1,67
ffffffffc020aea2:	00004517          	auipc	a0,0x4
ffffffffc020aea6:	38650513          	addi	a0,a0,902 # ffffffffc020f228 <sfs_node_fileops+0x98>
ffffffffc020aeaa:	e406                	sd	ra,8(sp)
ffffffffc020aeac:	b82f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020aeb0 <bitmap_test>:
ffffffffc020aeb0:	411c                	lw	a5,0(a0)
ffffffffc020aeb2:	00f5ff63          	bgeu	a1,a5,ffffffffc020aed0 <bitmap_test+0x20>
ffffffffc020aeb6:	651c                	ld	a5,8(a0)
ffffffffc020aeb8:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020aebc:	070a                	slli	a4,a4,0x2
ffffffffc020aebe:	97ba                	add	a5,a5,a4
ffffffffc020aec0:	4388                	lw	a0,0(a5)
ffffffffc020aec2:	4785                	li	a5,1
ffffffffc020aec4:	00b795bb          	sllw	a1,a5,a1
ffffffffc020aec8:	8d6d                	and	a0,a0,a1
ffffffffc020aeca:	1502                	slli	a0,a0,0x20
ffffffffc020aecc:	9101                	srli	a0,a0,0x20
ffffffffc020aece:	8082                	ret
ffffffffc020aed0:	1141                	addi	sp,sp,-16
ffffffffc020aed2:	e406                	sd	ra,8(sp)
ffffffffc020aed4:	e39ff0ef          	jal	ra,ffffffffc020ad0c <bitmap_translate.part.0>

ffffffffc020aed8 <bitmap_free>:
ffffffffc020aed8:	411c                	lw	a5,0(a0)
ffffffffc020aeda:	1141                	addi	sp,sp,-16
ffffffffc020aedc:	e406                	sd	ra,8(sp)
ffffffffc020aede:	02f5f463          	bgeu	a1,a5,ffffffffc020af06 <bitmap_free+0x2e>
ffffffffc020aee2:	651c                	ld	a5,8(a0)
ffffffffc020aee4:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020aee8:	070a                	slli	a4,a4,0x2
ffffffffc020aeea:	97ba                	add	a5,a5,a4
ffffffffc020aeec:	4398                	lw	a4,0(a5)
ffffffffc020aeee:	4685                	li	a3,1
ffffffffc020aef0:	00b695bb          	sllw	a1,a3,a1
ffffffffc020aef4:	00b776b3          	and	a3,a4,a1
ffffffffc020aef8:	2681                	sext.w	a3,a3
ffffffffc020aefa:	ea81                	bnez	a3,ffffffffc020af0a <bitmap_free+0x32>
ffffffffc020aefc:	60a2                	ld	ra,8(sp)
ffffffffc020aefe:	8f4d                	or	a4,a4,a1
ffffffffc020af00:	c398                	sw	a4,0(a5)
ffffffffc020af02:	0141                	addi	sp,sp,16
ffffffffc020af04:	8082                	ret
ffffffffc020af06:	e07ff0ef          	jal	ra,ffffffffc020ad0c <bitmap_translate.part.0>
ffffffffc020af0a:	00004697          	auipc	a3,0x4
ffffffffc020af0e:	39e68693          	addi	a3,a3,926 # ffffffffc020f2a8 <sfs_node_fileops+0x118>
ffffffffc020af12:	00001617          	auipc	a2,0x1
ffffffffc020af16:	8e660613          	addi	a2,a2,-1818 # ffffffffc020b7f8 <commands+0x60>
ffffffffc020af1a:	05f00593          	li	a1,95
ffffffffc020af1e:	00004517          	auipc	a0,0x4
ffffffffc020af22:	30a50513          	addi	a0,a0,778 # ffffffffc020f228 <sfs_node_fileops+0x98>
ffffffffc020af26:	b08f50ef          	jal	ra,ffffffffc020022e <__panic>

ffffffffc020af2a <bitmap_destroy>:
ffffffffc020af2a:	1141                	addi	sp,sp,-16
ffffffffc020af2c:	e022                	sd	s0,0(sp)
ffffffffc020af2e:	842a                	mv	s0,a0
ffffffffc020af30:	6508                	ld	a0,8(a0)
ffffffffc020af32:	e406                	sd	ra,8(sp)
ffffffffc020af34:	e93f60ef          	jal	ra,ffffffffc0201dc6 <kfree>
ffffffffc020af38:	8522                	mv	a0,s0
ffffffffc020af3a:	6402                	ld	s0,0(sp)
ffffffffc020af3c:	60a2                	ld	ra,8(sp)
ffffffffc020af3e:	0141                	addi	sp,sp,16
ffffffffc020af40:	e87f606f          	j	ffffffffc0201dc6 <kfree>

ffffffffc020af44 <bitmap_getdata>:
ffffffffc020af44:	c589                	beqz	a1,ffffffffc020af4e <bitmap_getdata+0xa>
ffffffffc020af46:	00456783          	lwu	a5,4(a0)
ffffffffc020af4a:	078a                	slli	a5,a5,0x2
ffffffffc020af4c:	e19c                	sd	a5,0(a1)
ffffffffc020af4e:	6508                	ld	a0,8(a0)
ffffffffc020af50:	8082                	ret

ffffffffc020af52 <strlen>:
ffffffffc020af52:	00054783          	lbu	a5,0(a0)
ffffffffc020af56:	872a                	mv	a4,a0
ffffffffc020af58:	4501                	li	a0,0
ffffffffc020af5a:	cb81                	beqz	a5,ffffffffc020af6a <strlen+0x18>
ffffffffc020af5c:	0505                	addi	a0,a0,1
ffffffffc020af5e:	00a707b3          	add	a5,a4,a0
ffffffffc020af62:	0007c783          	lbu	a5,0(a5)
ffffffffc020af66:	fbfd                	bnez	a5,ffffffffc020af5c <strlen+0xa>
ffffffffc020af68:	8082                	ret
ffffffffc020af6a:	8082                	ret

ffffffffc020af6c <strnlen>:
ffffffffc020af6c:	4781                	li	a5,0
ffffffffc020af6e:	e589                	bnez	a1,ffffffffc020af78 <strnlen+0xc>
ffffffffc020af70:	a811                	j	ffffffffc020af84 <strnlen+0x18>
ffffffffc020af72:	0785                	addi	a5,a5,1
ffffffffc020af74:	00f58863          	beq	a1,a5,ffffffffc020af84 <strnlen+0x18>
ffffffffc020af78:	00f50733          	add	a4,a0,a5
ffffffffc020af7c:	00074703          	lbu	a4,0(a4)
ffffffffc020af80:	fb6d                	bnez	a4,ffffffffc020af72 <strnlen+0x6>
ffffffffc020af82:	85be                	mv	a1,a5
ffffffffc020af84:	852e                	mv	a0,a1
ffffffffc020af86:	8082                	ret

ffffffffc020af88 <strcpy>:
ffffffffc020af88:	87aa                	mv	a5,a0
ffffffffc020af8a:	0005c703          	lbu	a4,0(a1)
ffffffffc020af8e:	0785                	addi	a5,a5,1
ffffffffc020af90:	0585                	addi	a1,a1,1
ffffffffc020af92:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020af96:	fb75                	bnez	a4,ffffffffc020af8a <strcpy+0x2>
ffffffffc020af98:	8082                	ret

ffffffffc020af9a <strcmp>:
ffffffffc020af9a:	00054783          	lbu	a5,0(a0)
ffffffffc020af9e:	0005c703          	lbu	a4,0(a1)
ffffffffc020afa2:	cb89                	beqz	a5,ffffffffc020afb4 <strcmp+0x1a>
ffffffffc020afa4:	0505                	addi	a0,a0,1
ffffffffc020afa6:	0585                	addi	a1,a1,1
ffffffffc020afa8:	fee789e3          	beq	a5,a4,ffffffffc020af9a <strcmp>
ffffffffc020afac:	0007851b          	sext.w	a0,a5
ffffffffc020afb0:	9d19                	subw	a0,a0,a4
ffffffffc020afb2:	8082                	ret
ffffffffc020afb4:	4501                	li	a0,0
ffffffffc020afb6:	bfed                	j	ffffffffc020afb0 <strcmp+0x16>

ffffffffc020afb8 <strncmp>:
ffffffffc020afb8:	c20d                	beqz	a2,ffffffffc020afda <strncmp+0x22>
ffffffffc020afba:	962e                	add	a2,a2,a1
ffffffffc020afbc:	a031                	j	ffffffffc020afc8 <strncmp+0x10>
ffffffffc020afbe:	0505                	addi	a0,a0,1
ffffffffc020afc0:	00e79a63          	bne	a5,a4,ffffffffc020afd4 <strncmp+0x1c>
ffffffffc020afc4:	00b60b63          	beq	a2,a1,ffffffffc020afda <strncmp+0x22>
ffffffffc020afc8:	00054783          	lbu	a5,0(a0)
ffffffffc020afcc:	0585                	addi	a1,a1,1
ffffffffc020afce:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020afd2:	f7f5                	bnez	a5,ffffffffc020afbe <strncmp+0x6>
ffffffffc020afd4:	40e7853b          	subw	a0,a5,a4
ffffffffc020afd8:	8082                	ret
ffffffffc020afda:	4501                	li	a0,0
ffffffffc020afdc:	8082                	ret

ffffffffc020afde <strchr>:
ffffffffc020afde:	00054783          	lbu	a5,0(a0)
ffffffffc020afe2:	c799                	beqz	a5,ffffffffc020aff0 <strchr+0x12>
ffffffffc020afe4:	00f58763          	beq	a1,a5,ffffffffc020aff2 <strchr+0x14>
ffffffffc020afe8:	00154783          	lbu	a5,1(a0)
ffffffffc020afec:	0505                	addi	a0,a0,1
ffffffffc020afee:	fbfd                	bnez	a5,ffffffffc020afe4 <strchr+0x6>
ffffffffc020aff0:	4501                	li	a0,0
ffffffffc020aff2:	8082                	ret

ffffffffc020aff4 <memset>:
ffffffffc020aff4:	ca01                	beqz	a2,ffffffffc020b004 <memset+0x10>
ffffffffc020aff6:	962a                	add	a2,a2,a0
ffffffffc020aff8:	87aa                	mv	a5,a0
ffffffffc020affa:	0785                	addi	a5,a5,1
ffffffffc020affc:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b000:	fec79de3          	bne	a5,a2,ffffffffc020affa <memset+0x6>
ffffffffc020b004:	8082                	ret

ffffffffc020b006 <memmove>:
ffffffffc020b006:	02a5f263          	bgeu	a1,a0,ffffffffc020b02a <memmove+0x24>
ffffffffc020b00a:	00c587b3          	add	a5,a1,a2
ffffffffc020b00e:	00f57e63          	bgeu	a0,a5,ffffffffc020b02a <memmove+0x24>
ffffffffc020b012:	00c50733          	add	a4,a0,a2
ffffffffc020b016:	c615                	beqz	a2,ffffffffc020b042 <memmove+0x3c>
ffffffffc020b018:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b01c:	17fd                	addi	a5,a5,-1
ffffffffc020b01e:	177d                	addi	a4,a4,-1
ffffffffc020b020:	00d70023          	sb	a3,0(a4)
ffffffffc020b024:	fef59ae3          	bne	a1,a5,ffffffffc020b018 <memmove+0x12>
ffffffffc020b028:	8082                	ret
ffffffffc020b02a:	00c586b3          	add	a3,a1,a2
ffffffffc020b02e:	87aa                	mv	a5,a0
ffffffffc020b030:	ca11                	beqz	a2,ffffffffc020b044 <memmove+0x3e>
ffffffffc020b032:	0005c703          	lbu	a4,0(a1)
ffffffffc020b036:	0585                	addi	a1,a1,1
ffffffffc020b038:	0785                	addi	a5,a5,1
ffffffffc020b03a:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b03e:	fed59ae3          	bne	a1,a3,ffffffffc020b032 <memmove+0x2c>
ffffffffc020b042:	8082                	ret
ffffffffc020b044:	8082                	ret

ffffffffc020b046 <memcpy>:
ffffffffc020b046:	ca19                	beqz	a2,ffffffffc020b05c <memcpy+0x16>
ffffffffc020b048:	962e                	add	a2,a2,a1
ffffffffc020b04a:	87aa                	mv	a5,a0
ffffffffc020b04c:	0005c703          	lbu	a4,0(a1)
ffffffffc020b050:	0585                	addi	a1,a1,1
ffffffffc020b052:	0785                	addi	a5,a5,1
ffffffffc020b054:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b058:	fec59ae3          	bne	a1,a2,ffffffffc020b04c <memcpy+0x6>
ffffffffc020b05c:	8082                	ret

ffffffffc020b05e <printnum>:
ffffffffc020b05e:	02071893          	slli	a7,a4,0x20
ffffffffc020b062:	7139                	addi	sp,sp,-64
ffffffffc020b064:	0208d893          	srli	a7,a7,0x20
ffffffffc020b068:	e456                	sd	s5,8(sp)
ffffffffc020b06a:	0316fab3          	remu	s5,a3,a7
ffffffffc020b06e:	f822                	sd	s0,48(sp)
ffffffffc020b070:	f426                	sd	s1,40(sp)
ffffffffc020b072:	f04a                	sd	s2,32(sp)
ffffffffc020b074:	ec4e                	sd	s3,24(sp)
ffffffffc020b076:	fc06                	sd	ra,56(sp)
ffffffffc020b078:	e852                	sd	s4,16(sp)
ffffffffc020b07a:	84aa                	mv	s1,a0
ffffffffc020b07c:	89ae                	mv	s3,a1
ffffffffc020b07e:	8932                	mv	s2,a2
ffffffffc020b080:	fff7841b          	addiw	s0,a5,-1
ffffffffc020b084:	2a81                	sext.w	s5,s5
ffffffffc020b086:	0516f163          	bgeu	a3,a7,ffffffffc020b0c8 <printnum+0x6a>
ffffffffc020b08a:	8a42                	mv	s4,a6
ffffffffc020b08c:	00805863          	blez	s0,ffffffffc020b09c <printnum+0x3e>
ffffffffc020b090:	347d                	addiw	s0,s0,-1
ffffffffc020b092:	864e                	mv	a2,s3
ffffffffc020b094:	85ca                	mv	a1,s2
ffffffffc020b096:	8552                	mv	a0,s4
ffffffffc020b098:	9482                	jalr	s1
ffffffffc020b09a:	f87d                	bnez	s0,ffffffffc020b090 <printnum+0x32>
ffffffffc020b09c:	1a82                	slli	s5,s5,0x20
ffffffffc020b09e:	00004797          	auipc	a5,0x4
ffffffffc020b0a2:	21a78793          	addi	a5,a5,538 # ffffffffc020f2b8 <sfs_node_fileops+0x128>
ffffffffc020b0a6:	020ada93          	srli	s5,s5,0x20
ffffffffc020b0aa:	9abe                	add	s5,s5,a5
ffffffffc020b0ac:	7442                	ld	s0,48(sp)
ffffffffc020b0ae:	000ac503          	lbu	a0,0(s5)
ffffffffc020b0b2:	70e2                	ld	ra,56(sp)
ffffffffc020b0b4:	6a42                	ld	s4,16(sp)
ffffffffc020b0b6:	6aa2                	ld	s5,8(sp)
ffffffffc020b0b8:	864e                	mv	a2,s3
ffffffffc020b0ba:	85ca                	mv	a1,s2
ffffffffc020b0bc:	69e2                	ld	s3,24(sp)
ffffffffc020b0be:	7902                	ld	s2,32(sp)
ffffffffc020b0c0:	87a6                	mv	a5,s1
ffffffffc020b0c2:	74a2                	ld	s1,40(sp)
ffffffffc020b0c4:	6121                	addi	sp,sp,64
ffffffffc020b0c6:	8782                	jr	a5
ffffffffc020b0c8:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b0cc:	87a2                	mv	a5,s0
ffffffffc020b0ce:	f91ff0ef          	jal	ra,ffffffffc020b05e <printnum>
ffffffffc020b0d2:	b7e9                	j	ffffffffc020b09c <printnum+0x3e>

ffffffffc020b0d4 <sprintputch>:
ffffffffc020b0d4:	499c                	lw	a5,16(a1)
ffffffffc020b0d6:	6198                	ld	a4,0(a1)
ffffffffc020b0d8:	6594                	ld	a3,8(a1)
ffffffffc020b0da:	2785                	addiw	a5,a5,1
ffffffffc020b0dc:	c99c                	sw	a5,16(a1)
ffffffffc020b0de:	00d77763          	bgeu	a4,a3,ffffffffc020b0ec <sprintputch+0x18>
ffffffffc020b0e2:	00170793          	addi	a5,a4,1
ffffffffc020b0e6:	e19c                	sd	a5,0(a1)
ffffffffc020b0e8:	00a70023          	sb	a0,0(a4)
ffffffffc020b0ec:	8082                	ret

ffffffffc020b0ee <vprintfmt>:
ffffffffc020b0ee:	7119                	addi	sp,sp,-128
ffffffffc020b0f0:	f4a6                	sd	s1,104(sp)
ffffffffc020b0f2:	f0ca                	sd	s2,96(sp)
ffffffffc020b0f4:	ecce                	sd	s3,88(sp)
ffffffffc020b0f6:	e8d2                	sd	s4,80(sp)
ffffffffc020b0f8:	e4d6                	sd	s5,72(sp)
ffffffffc020b0fa:	e0da                	sd	s6,64(sp)
ffffffffc020b0fc:	fc5e                	sd	s7,56(sp)
ffffffffc020b0fe:	ec6e                	sd	s11,24(sp)
ffffffffc020b100:	fc86                	sd	ra,120(sp)
ffffffffc020b102:	f8a2                	sd	s0,112(sp)
ffffffffc020b104:	f862                	sd	s8,48(sp)
ffffffffc020b106:	f466                	sd	s9,40(sp)
ffffffffc020b108:	f06a                	sd	s10,32(sp)
ffffffffc020b10a:	89aa                	mv	s3,a0
ffffffffc020b10c:	892e                	mv	s2,a1
ffffffffc020b10e:	84b2                	mv	s1,a2
ffffffffc020b110:	8db6                	mv	s11,a3
ffffffffc020b112:	8aba                	mv	s5,a4
ffffffffc020b114:	02500a13          	li	s4,37
ffffffffc020b118:	5bfd                	li	s7,-1
ffffffffc020b11a:	00004b17          	auipc	s6,0x4
ffffffffc020b11e:	1cab0b13          	addi	s6,s6,458 # ffffffffc020f2e4 <sfs_node_fileops+0x154>
ffffffffc020b122:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b126:	001d8413          	addi	s0,s11,1
ffffffffc020b12a:	01450b63          	beq	a0,s4,ffffffffc020b140 <vprintfmt+0x52>
ffffffffc020b12e:	c129                	beqz	a0,ffffffffc020b170 <vprintfmt+0x82>
ffffffffc020b130:	864a                	mv	a2,s2
ffffffffc020b132:	85a6                	mv	a1,s1
ffffffffc020b134:	0405                	addi	s0,s0,1
ffffffffc020b136:	9982                	jalr	s3
ffffffffc020b138:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b13c:	ff4519e3          	bne	a0,s4,ffffffffc020b12e <vprintfmt+0x40>
ffffffffc020b140:	00044583          	lbu	a1,0(s0)
ffffffffc020b144:	02000813          	li	a6,32
ffffffffc020b148:	4d01                	li	s10,0
ffffffffc020b14a:	4301                	li	t1,0
ffffffffc020b14c:	5cfd                	li	s9,-1
ffffffffc020b14e:	5c7d                	li	s8,-1
ffffffffc020b150:	05500513          	li	a0,85
ffffffffc020b154:	48a5                	li	a7,9
ffffffffc020b156:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b15a:	0ff67613          	zext.b	a2,a2
ffffffffc020b15e:	00140d93          	addi	s11,s0,1
ffffffffc020b162:	04c56263          	bltu	a0,a2,ffffffffc020b1a6 <vprintfmt+0xb8>
ffffffffc020b166:	060a                	slli	a2,a2,0x2
ffffffffc020b168:	965a                	add	a2,a2,s6
ffffffffc020b16a:	4214                	lw	a3,0(a2)
ffffffffc020b16c:	96da                	add	a3,a3,s6
ffffffffc020b16e:	8682                	jr	a3
ffffffffc020b170:	70e6                	ld	ra,120(sp)
ffffffffc020b172:	7446                	ld	s0,112(sp)
ffffffffc020b174:	74a6                	ld	s1,104(sp)
ffffffffc020b176:	7906                	ld	s2,96(sp)
ffffffffc020b178:	69e6                	ld	s3,88(sp)
ffffffffc020b17a:	6a46                	ld	s4,80(sp)
ffffffffc020b17c:	6aa6                	ld	s5,72(sp)
ffffffffc020b17e:	6b06                	ld	s6,64(sp)
ffffffffc020b180:	7be2                	ld	s7,56(sp)
ffffffffc020b182:	7c42                	ld	s8,48(sp)
ffffffffc020b184:	7ca2                	ld	s9,40(sp)
ffffffffc020b186:	7d02                	ld	s10,32(sp)
ffffffffc020b188:	6de2                	ld	s11,24(sp)
ffffffffc020b18a:	6109                	addi	sp,sp,128
ffffffffc020b18c:	8082                	ret
ffffffffc020b18e:	882e                	mv	a6,a1
ffffffffc020b190:	00144583          	lbu	a1,1(s0)
ffffffffc020b194:	846e                	mv	s0,s11
ffffffffc020b196:	00140d93          	addi	s11,s0,1
ffffffffc020b19a:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b19e:	0ff67613          	zext.b	a2,a2
ffffffffc020b1a2:	fcc572e3          	bgeu	a0,a2,ffffffffc020b166 <vprintfmt+0x78>
ffffffffc020b1a6:	864a                	mv	a2,s2
ffffffffc020b1a8:	85a6                	mv	a1,s1
ffffffffc020b1aa:	02500513          	li	a0,37
ffffffffc020b1ae:	9982                	jalr	s3
ffffffffc020b1b0:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b1b4:	8da2                	mv	s11,s0
ffffffffc020b1b6:	f74786e3          	beq	a5,s4,ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b1ba:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b1be:	1dfd                	addi	s11,s11,-1
ffffffffc020b1c0:	ff479de3          	bne	a5,s4,ffffffffc020b1ba <vprintfmt+0xcc>
ffffffffc020b1c4:	bfb9                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b1c6:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b1ca:	00144583          	lbu	a1,1(s0)
ffffffffc020b1ce:	846e                	mv	s0,s11
ffffffffc020b1d0:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b1d4:	0005861b          	sext.w	a2,a1
ffffffffc020b1d8:	02d8e463          	bltu	a7,a3,ffffffffc020b200 <vprintfmt+0x112>
ffffffffc020b1dc:	00144583          	lbu	a1,1(s0)
ffffffffc020b1e0:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b1e4:	0196873b          	addw	a4,a3,s9
ffffffffc020b1e8:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b1ec:	9f31                	addw	a4,a4,a2
ffffffffc020b1ee:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b1f2:	0405                	addi	s0,s0,1
ffffffffc020b1f4:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b1f8:	0005861b          	sext.w	a2,a1
ffffffffc020b1fc:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b1dc <vprintfmt+0xee>
ffffffffc020b200:	f40c5be3          	bgez	s8,ffffffffc020b156 <vprintfmt+0x68>
ffffffffc020b204:	8c66                	mv	s8,s9
ffffffffc020b206:	5cfd                	li	s9,-1
ffffffffc020b208:	b7b9                	j	ffffffffc020b156 <vprintfmt+0x68>
ffffffffc020b20a:	fffc4693          	not	a3,s8
ffffffffc020b20e:	96fd                	srai	a3,a3,0x3f
ffffffffc020b210:	00dc77b3          	and	a5,s8,a3
ffffffffc020b214:	00144583          	lbu	a1,1(s0)
ffffffffc020b218:	00078c1b          	sext.w	s8,a5
ffffffffc020b21c:	846e                	mv	s0,s11
ffffffffc020b21e:	bf25                	j	ffffffffc020b156 <vprintfmt+0x68>
ffffffffc020b220:	000aac83          	lw	s9,0(s5)
ffffffffc020b224:	00144583          	lbu	a1,1(s0)
ffffffffc020b228:	0aa1                	addi	s5,s5,8
ffffffffc020b22a:	846e                	mv	s0,s11
ffffffffc020b22c:	bfd1                	j	ffffffffc020b200 <vprintfmt+0x112>
ffffffffc020b22e:	4705                	li	a4,1
ffffffffc020b230:	008a8613          	addi	a2,s5,8
ffffffffc020b234:	00674463          	blt	a4,t1,ffffffffc020b23c <vprintfmt+0x14e>
ffffffffc020b238:	1c030c63          	beqz	t1,ffffffffc020b410 <vprintfmt+0x322>
ffffffffc020b23c:	000ab683          	ld	a3,0(s5)
ffffffffc020b240:	4741                	li	a4,16
ffffffffc020b242:	8ab2                	mv	s5,a2
ffffffffc020b244:	2801                	sext.w	a6,a6
ffffffffc020b246:	87e2                	mv	a5,s8
ffffffffc020b248:	8626                	mv	a2,s1
ffffffffc020b24a:	85ca                	mv	a1,s2
ffffffffc020b24c:	854e                	mv	a0,s3
ffffffffc020b24e:	e11ff0ef          	jal	ra,ffffffffc020b05e <printnum>
ffffffffc020b252:	bdc1                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b254:	000aa503          	lw	a0,0(s5)
ffffffffc020b258:	864a                	mv	a2,s2
ffffffffc020b25a:	85a6                	mv	a1,s1
ffffffffc020b25c:	0aa1                	addi	s5,s5,8
ffffffffc020b25e:	9982                	jalr	s3
ffffffffc020b260:	b5c9                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b262:	4705                	li	a4,1
ffffffffc020b264:	008a8613          	addi	a2,s5,8
ffffffffc020b268:	00674463          	blt	a4,t1,ffffffffc020b270 <vprintfmt+0x182>
ffffffffc020b26c:	18030d63          	beqz	t1,ffffffffc020b406 <vprintfmt+0x318>
ffffffffc020b270:	000ab683          	ld	a3,0(s5)
ffffffffc020b274:	4729                	li	a4,10
ffffffffc020b276:	8ab2                	mv	s5,a2
ffffffffc020b278:	b7f1                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b27a:	00144583          	lbu	a1,1(s0)
ffffffffc020b27e:	4d05                	li	s10,1
ffffffffc020b280:	846e                	mv	s0,s11
ffffffffc020b282:	bdd1                	j	ffffffffc020b156 <vprintfmt+0x68>
ffffffffc020b284:	864a                	mv	a2,s2
ffffffffc020b286:	85a6                	mv	a1,s1
ffffffffc020b288:	02500513          	li	a0,37
ffffffffc020b28c:	9982                	jalr	s3
ffffffffc020b28e:	bd51                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b290:	00144583          	lbu	a1,1(s0)
ffffffffc020b294:	2305                	addiw	t1,t1,1
ffffffffc020b296:	846e                	mv	s0,s11
ffffffffc020b298:	bd7d                	j	ffffffffc020b156 <vprintfmt+0x68>
ffffffffc020b29a:	4705                	li	a4,1
ffffffffc020b29c:	008a8613          	addi	a2,s5,8
ffffffffc020b2a0:	00674463          	blt	a4,t1,ffffffffc020b2a8 <vprintfmt+0x1ba>
ffffffffc020b2a4:	14030c63          	beqz	t1,ffffffffc020b3fc <vprintfmt+0x30e>
ffffffffc020b2a8:	000ab683          	ld	a3,0(s5)
ffffffffc020b2ac:	4721                	li	a4,8
ffffffffc020b2ae:	8ab2                	mv	s5,a2
ffffffffc020b2b0:	bf51                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b2b2:	03000513          	li	a0,48
ffffffffc020b2b6:	864a                	mv	a2,s2
ffffffffc020b2b8:	85a6                	mv	a1,s1
ffffffffc020b2ba:	e042                	sd	a6,0(sp)
ffffffffc020b2bc:	9982                	jalr	s3
ffffffffc020b2be:	864a                	mv	a2,s2
ffffffffc020b2c0:	85a6                	mv	a1,s1
ffffffffc020b2c2:	07800513          	li	a0,120
ffffffffc020b2c6:	9982                	jalr	s3
ffffffffc020b2c8:	0aa1                	addi	s5,s5,8
ffffffffc020b2ca:	6802                	ld	a6,0(sp)
ffffffffc020b2cc:	4741                	li	a4,16
ffffffffc020b2ce:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b2d2:	bf8d                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b2d4:	000ab403          	ld	s0,0(s5)
ffffffffc020b2d8:	008a8793          	addi	a5,s5,8
ffffffffc020b2dc:	e03e                	sd	a5,0(sp)
ffffffffc020b2de:	14040c63          	beqz	s0,ffffffffc020b436 <vprintfmt+0x348>
ffffffffc020b2e2:	11805063          	blez	s8,ffffffffc020b3e2 <vprintfmt+0x2f4>
ffffffffc020b2e6:	02d00693          	li	a3,45
ffffffffc020b2ea:	0cd81963          	bne	a6,a3,ffffffffc020b3bc <vprintfmt+0x2ce>
ffffffffc020b2ee:	00044683          	lbu	a3,0(s0)
ffffffffc020b2f2:	0006851b          	sext.w	a0,a3
ffffffffc020b2f6:	ce8d                	beqz	a3,ffffffffc020b330 <vprintfmt+0x242>
ffffffffc020b2f8:	00140a93          	addi	s5,s0,1
ffffffffc020b2fc:	05e00413          	li	s0,94
ffffffffc020b300:	000cc563          	bltz	s9,ffffffffc020b30a <vprintfmt+0x21c>
ffffffffc020b304:	3cfd                	addiw	s9,s9,-1
ffffffffc020b306:	037c8363          	beq	s9,s7,ffffffffc020b32c <vprintfmt+0x23e>
ffffffffc020b30a:	864a                	mv	a2,s2
ffffffffc020b30c:	85a6                	mv	a1,s1
ffffffffc020b30e:	100d0663          	beqz	s10,ffffffffc020b41a <vprintfmt+0x32c>
ffffffffc020b312:	3681                	addiw	a3,a3,-32
ffffffffc020b314:	10d47363          	bgeu	s0,a3,ffffffffc020b41a <vprintfmt+0x32c>
ffffffffc020b318:	03f00513          	li	a0,63
ffffffffc020b31c:	9982                	jalr	s3
ffffffffc020b31e:	000ac683          	lbu	a3,0(s5)
ffffffffc020b322:	3c7d                	addiw	s8,s8,-1
ffffffffc020b324:	0a85                	addi	s5,s5,1
ffffffffc020b326:	0006851b          	sext.w	a0,a3
ffffffffc020b32a:	faf9                	bnez	a3,ffffffffc020b300 <vprintfmt+0x212>
ffffffffc020b32c:	01805a63          	blez	s8,ffffffffc020b340 <vprintfmt+0x252>
ffffffffc020b330:	3c7d                	addiw	s8,s8,-1
ffffffffc020b332:	864a                	mv	a2,s2
ffffffffc020b334:	85a6                	mv	a1,s1
ffffffffc020b336:	02000513          	li	a0,32
ffffffffc020b33a:	9982                	jalr	s3
ffffffffc020b33c:	fe0c1ae3          	bnez	s8,ffffffffc020b330 <vprintfmt+0x242>
ffffffffc020b340:	6a82                	ld	s5,0(sp)
ffffffffc020b342:	b3c5                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b344:	4705                	li	a4,1
ffffffffc020b346:	008a8d13          	addi	s10,s5,8
ffffffffc020b34a:	00674463          	blt	a4,t1,ffffffffc020b352 <vprintfmt+0x264>
ffffffffc020b34e:	0a030463          	beqz	t1,ffffffffc020b3f6 <vprintfmt+0x308>
ffffffffc020b352:	000ab403          	ld	s0,0(s5)
ffffffffc020b356:	0c044463          	bltz	s0,ffffffffc020b41e <vprintfmt+0x330>
ffffffffc020b35a:	86a2                	mv	a3,s0
ffffffffc020b35c:	8aea                	mv	s5,s10
ffffffffc020b35e:	4729                	li	a4,10
ffffffffc020b360:	b5d5                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b362:	000aa783          	lw	a5,0(s5)
ffffffffc020b366:	46e1                	li	a3,24
ffffffffc020b368:	0aa1                	addi	s5,s5,8
ffffffffc020b36a:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b36e:	8fb9                	xor	a5,a5,a4
ffffffffc020b370:	40e7873b          	subw	a4,a5,a4
ffffffffc020b374:	02e6c663          	blt	a3,a4,ffffffffc020b3a0 <vprintfmt+0x2b2>
ffffffffc020b378:	00371793          	slli	a5,a4,0x3
ffffffffc020b37c:	00004697          	auipc	a3,0x4
ffffffffc020b380:	29c68693          	addi	a3,a3,668 # ffffffffc020f618 <error_string>
ffffffffc020b384:	97b6                	add	a5,a5,a3
ffffffffc020b386:	639c                	ld	a5,0(a5)
ffffffffc020b388:	cf81                	beqz	a5,ffffffffc020b3a0 <vprintfmt+0x2b2>
ffffffffc020b38a:	873e                	mv	a4,a5
ffffffffc020b38c:	00000697          	auipc	a3,0x0
ffffffffc020b390:	18c68693          	addi	a3,a3,396 # ffffffffc020b518 <etext+0x28>
ffffffffc020b394:	8626                	mv	a2,s1
ffffffffc020b396:	85ca                	mv	a1,s2
ffffffffc020b398:	854e                	mv	a0,s3
ffffffffc020b39a:	0d4000ef          	jal	ra,ffffffffc020b46e <printfmt>
ffffffffc020b39e:	b351                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b3a0:	00004697          	auipc	a3,0x4
ffffffffc020b3a4:	f3868693          	addi	a3,a3,-200 # ffffffffc020f2d8 <sfs_node_fileops+0x148>
ffffffffc020b3a8:	8626                	mv	a2,s1
ffffffffc020b3aa:	85ca                	mv	a1,s2
ffffffffc020b3ac:	854e                	mv	a0,s3
ffffffffc020b3ae:	0c0000ef          	jal	ra,ffffffffc020b46e <printfmt>
ffffffffc020b3b2:	bb85                	j	ffffffffc020b122 <vprintfmt+0x34>
ffffffffc020b3b4:	00004417          	auipc	s0,0x4
ffffffffc020b3b8:	f1c40413          	addi	s0,s0,-228 # ffffffffc020f2d0 <sfs_node_fileops+0x140>
ffffffffc020b3bc:	85e6                	mv	a1,s9
ffffffffc020b3be:	8522                	mv	a0,s0
ffffffffc020b3c0:	e442                	sd	a6,8(sp)
ffffffffc020b3c2:	babff0ef          	jal	ra,ffffffffc020af6c <strnlen>
ffffffffc020b3c6:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b3ca:	01805c63          	blez	s8,ffffffffc020b3e2 <vprintfmt+0x2f4>
ffffffffc020b3ce:	6822                	ld	a6,8(sp)
ffffffffc020b3d0:	00080a9b          	sext.w	s5,a6
ffffffffc020b3d4:	3c7d                	addiw	s8,s8,-1
ffffffffc020b3d6:	864a                	mv	a2,s2
ffffffffc020b3d8:	85a6                	mv	a1,s1
ffffffffc020b3da:	8556                	mv	a0,s5
ffffffffc020b3dc:	9982                	jalr	s3
ffffffffc020b3de:	fe0c1be3          	bnez	s8,ffffffffc020b3d4 <vprintfmt+0x2e6>
ffffffffc020b3e2:	00044683          	lbu	a3,0(s0)
ffffffffc020b3e6:	00140a93          	addi	s5,s0,1
ffffffffc020b3ea:	0006851b          	sext.w	a0,a3
ffffffffc020b3ee:	daa9                	beqz	a3,ffffffffc020b340 <vprintfmt+0x252>
ffffffffc020b3f0:	05e00413          	li	s0,94
ffffffffc020b3f4:	b731                	j	ffffffffc020b300 <vprintfmt+0x212>
ffffffffc020b3f6:	000aa403          	lw	s0,0(s5)
ffffffffc020b3fa:	bfb1                	j	ffffffffc020b356 <vprintfmt+0x268>
ffffffffc020b3fc:	000ae683          	lwu	a3,0(s5)
ffffffffc020b400:	4721                	li	a4,8
ffffffffc020b402:	8ab2                	mv	s5,a2
ffffffffc020b404:	b581                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b406:	000ae683          	lwu	a3,0(s5)
ffffffffc020b40a:	4729                	li	a4,10
ffffffffc020b40c:	8ab2                	mv	s5,a2
ffffffffc020b40e:	bd1d                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b410:	000ae683          	lwu	a3,0(s5)
ffffffffc020b414:	4741                	li	a4,16
ffffffffc020b416:	8ab2                	mv	s5,a2
ffffffffc020b418:	b535                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b41a:	9982                	jalr	s3
ffffffffc020b41c:	b709                	j	ffffffffc020b31e <vprintfmt+0x230>
ffffffffc020b41e:	864a                	mv	a2,s2
ffffffffc020b420:	85a6                	mv	a1,s1
ffffffffc020b422:	02d00513          	li	a0,45
ffffffffc020b426:	e042                	sd	a6,0(sp)
ffffffffc020b428:	9982                	jalr	s3
ffffffffc020b42a:	6802                	ld	a6,0(sp)
ffffffffc020b42c:	8aea                	mv	s5,s10
ffffffffc020b42e:	408006b3          	neg	a3,s0
ffffffffc020b432:	4729                	li	a4,10
ffffffffc020b434:	bd01                	j	ffffffffc020b244 <vprintfmt+0x156>
ffffffffc020b436:	03805163          	blez	s8,ffffffffc020b458 <vprintfmt+0x36a>
ffffffffc020b43a:	02d00693          	li	a3,45
ffffffffc020b43e:	f6d81be3          	bne	a6,a3,ffffffffc020b3b4 <vprintfmt+0x2c6>
ffffffffc020b442:	00004417          	auipc	s0,0x4
ffffffffc020b446:	e8e40413          	addi	s0,s0,-370 # ffffffffc020f2d0 <sfs_node_fileops+0x140>
ffffffffc020b44a:	02800693          	li	a3,40
ffffffffc020b44e:	02800513          	li	a0,40
ffffffffc020b452:	00140a93          	addi	s5,s0,1
ffffffffc020b456:	b55d                	j	ffffffffc020b2fc <vprintfmt+0x20e>
ffffffffc020b458:	00004a97          	auipc	s5,0x4
ffffffffc020b45c:	e79a8a93          	addi	s5,s5,-391 # ffffffffc020f2d1 <sfs_node_fileops+0x141>
ffffffffc020b460:	02800513          	li	a0,40
ffffffffc020b464:	02800693          	li	a3,40
ffffffffc020b468:	05e00413          	li	s0,94
ffffffffc020b46c:	bd51                	j	ffffffffc020b300 <vprintfmt+0x212>

ffffffffc020b46e <printfmt>:
ffffffffc020b46e:	7139                	addi	sp,sp,-64
ffffffffc020b470:	02010313          	addi	t1,sp,32
ffffffffc020b474:	f03a                	sd	a4,32(sp)
ffffffffc020b476:	871a                	mv	a4,t1
ffffffffc020b478:	ec06                	sd	ra,24(sp)
ffffffffc020b47a:	f43e                	sd	a5,40(sp)
ffffffffc020b47c:	f842                	sd	a6,48(sp)
ffffffffc020b47e:	fc46                	sd	a7,56(sp)
ffffffffc020b480:	e41a                	sd	t1,8(sp)
ffffffffc020b482:	c6dff0ef          	jal	ra,ffffffffc020b0ee <vprintfmt>
ffffffffc020b486:	60e2                	ld	ra,24(sp)
ffffffffc020b488:	6121                	addi	sp,sp,64
ffffffffc020b48a:	8082                	ret

ffffffffc020b48c <snprintf>:
ffffffffc020b48c:	711d                	addi	sp,sp,-96
ffffffffc020b48e:	15fd                	addi	a1,a1,-1
ffffffffc020b490:	03810313          	addi	t1,sp,56
ffffffffc020b494:	95aa                	add	a1,a1,a0
ffffffffc020b496:	f406                	sd	ra,40(sp)
ffffffffc020b498:	fc36                	sd	a3,56(sp)
ffffffffc020b49a:	e0ba                	sd	a4,64(sp)
ffffffffc020b49c:	e4be                	sd	a5,72(sp)
ffffffffc020b49e:	e8c2                	sd	a6,80(sp)
ffffffffc020b4a0:	ecc6                	sd	a7,88(sp)
ffffffffc020b4a2:	e01a                	sd	t1,0(sp)
ffffffffc020b4a4:	e42a                	sd	a0,8(sp)
ffffffffc020b4a6:	e82e                	sd	a1,16(sp)
ffffffffc020b4a8:	cc02                	sw	zero,24(sp)
ffffffffc020b4aa:	c515                	beqz	a0,ffffffffc020b4d6 <snprintf+0x4a>
ffffffffc020b4ac:	02a5e563          	bltu	a1,a0,ffffffffc020b4d6 <snprintf+0x4a>
ffffffffc020b4b0:	75dd                	lui	a1,0xffff7
ffffffffc020b4b2:	86b2                	mv	a3,a2
ffffffffc020b4b4:	00000517          	auipc	a0,0x0
ffffffffc020b4b8:	c2050513          	addi	a0,a0,-992 # ffffffffc020b0d4 <sprintputch>
ffffffffc020b4bc:	871a                	mv	a4,t1
ffffffffc020b4be:	0030                	addi	a2,sp,8
ffffffffc020b4c0:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b4c4:	c2bff0ef          	jal	ra,ffffffffc020b0ee <vprintfmt>
ffffffffc020b4c8:	67a2                	ld	a5,8(sp)
ffffffffc020b4ca:	00078023          	sb	zero,0(a5)
ffffffffc020b4ce:	4562                	lw	a0,24(sp)
ffffffffc020b4d0:	70a2                	ld	ra,40(sp)
ffffffffc020b4d2:	6125                	addi	sp,sp,96
ffffffffc020b4d4:	8082                	ret
ffffffffc020b4d6:	5575                	li	a0,-3
ffffffffc020b4d8:	bfe5                	j	ffffffffc020b4d0 <snprintf+0x44>

ffffffffc020b4da <hash32>:
ffffffffc020b4da:	9e3707b7          	lui	a5,0x9e370
ffffffffc020b4de:	2785                	addiw	a5,a5,1
ffffffffc020b4e0:	02a7853b          	mulw	a0,a5,a0
ffffffffc020b4e4:	02000793          	li	a5,32
ffffffffc020b4e8:	9f8d                	subw	a5,a5,a1
ffffffffc020b4ea:	00f5553b          	srlw	a0,a0,a5
ffffffffc020b4ee:	8082                	ret
