
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000b297          	auipc	t0,0xb
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020b000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000b297          	auipc	t0,0xb
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020b008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020a2b7          	lui	t0,0xc020a
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c020a137          	lui	sp,0xc020a

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000a6517          	auipc	a0,0xa6
ffffffffc020004e:	1e650513          	addi	a0,a0,486 # ffffffffc02a6230 <buf>
ffffffffc0200052:	000aa617          	auipc	a2,0xaa
ffffffffc0200056:	68a60613          	addi	a2,a2,1674 # ffffffffc02aa6dc <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	240050ef          	jal	ra,ffffffffc02052a2 <memset>
    dtb_init();
ffffffffc0200066:	4d6000ef          	jal	ra,ffffffffc020053c <dtb_init>
    cons_init(); // init the console
ffffffffc020006a:	0d7000ef          	jal	ra,ffffffffc0200940 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006e:	00005597          	auipc	a1,0x5
ffffffffc0200072:	66258593          	addi	a1,a1,1634 # ffffffffc02056d0 <etext>
ffffffffc0200076:	00005517          	auipc	a0,0x5
ffffffffc020007a:	67a50513          	addi	a0,a0,1658 # ffffffffc02056f0 <etext+0x20>
ffffffffc020007e:	062000ef          	jal	ra,ffffffffc02000e0 <cprintf>

    print_kerninfo();
ffffffffc0200082:	248000ef          	jal	ra,ffffffffc02002ca <print_kerninfo>

    // grade_backtrace();

    pmm_init(); // init physical memory management
ffffffffc0200086:	603020ef          	jal	ra,ffffffffc0202e88 <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	129000ef          	jal	ra,ffffffffc02009b2 <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	133000ef          	jal	ra,ffffffffc02009c0 <idt_init>

    vmm_init();  // init virtual memory management
ffffffffc0200092:	2e2010ef          	jal	ra,ffffffffc0201374 <vmm_init>
    proc_init(); // init process table
ffffffffc0200096:	5cd040ef          	jal	ra,ffffffffc0204e62 <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009a:	053000ef          	jal	ra,ffffffffc02008ec <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc020009e:	117000ef          	jal	ra,ffffffffc02009b4 <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a2:	759040ef          	jal	ra,ffffffffc0204ffa <cpu_idle>

ffffffffc02000a6 <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc02000a6:	1141                	addi	sp,sp,-16
ffffffffc02000a8:	e022                	sd	s0,0(sp)
ffffffffc02000aa:	e406                	sd	ra,8(sp)
ffffffffc02000ac:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc02000ae:	095000ef          	jal	ra,ffffffffc0200942 <cons_putc>
    (*cnt)++;
ffffffffc02000b2:	401c                	lw	a5,0(s0)
}
ffffffffc02000b4:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc02000b6:	2785                	addiw	a5,a5,1
ffffffffc02000b8:	c01c                	sw	a5,0(s0)
}
ffffffffc02000ba:	6402                	ld	s0,0(sp)
ffffffffc02000bc:	0141                	addi	sp,sp,16
ffffffffc02000be:	8082                	ret

ffffffffc02000c0 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc02000c0:	1101                	addi	sp,sp,-32
ffffffffc02000c2:	862a                	mv	a2,a0
ffffffffc02000c4:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02000c6:	00000517          	auipc	a0,0x0
ffffffffc02000ca:	fe050513          	addi	a0,a0,-32 # ffffffffc02000a6 <cputch>
ffffffffc02000ce:	006c                	addi	a1,sp,12
{
ffffffffc02000d0:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000d2:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02000d4:	264050ef          	jal	ra,ffffffffc0205338 <vprintfmt>
    return cnt;
}
ffffffffc02000d8:	60e2                	ld	ra,24(sp)
ffffffffc02000da:	4532                	lw	a0,12(sp)
ffffffffc02000dc:	6105                	addi	sp,sp,32
ffffffffc02000de:	8082                	ret

ffffffffc02000e0 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc02000e0:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000e2:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
{
ffffffffc02000e6:	8e2a                	mv	t3,a0
ffffffffc02000e8:	f42e                	sd	a1,40(sp)
ffffffffc02000ea:	f832                	sd	a2,48(sp)
ffffffffc02000ec:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02000ee:	00000517          	auipc	a0,0x0
ffffffffc02000f2:	fb850513          	addi	a0,a0,-72 # ffffffffc02000a6 <cputch>
ffffffffc02000f6:	004c                	addi	a1,sp,4
ffffffffc02000f8:	869a                	mv	a3,t1
ffffffffc02000fa:	8672                	mv	a2,t3
{
ffffffffc02000fc:	ec06                	sd	ra,24(sp)
ffffffffc02000fe:	e0ba                	sd	a4,64(sp)
ffffffffc0200100:	e4be                	sd	a5,72(sp)
ffffffffc0200102:	e8c2                	sd	a6,80(sp)
ffffffffc0200104:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc0200106:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc0200108:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020010a:	22e050ef          	jal	ra,ffffffffc0205338 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc020010e:	60e2                	ld	ra,24(sp)
ffffffffc0200110:	4512                	lw	a0,4(sp)
ffffffffc0200112:	6125                	addi	sp,sp,96
ffffffffc0200114:	8082                	ret

ffffffffc0200116 <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc0200116:	02d0006f          	j	ffffffffc0200942 <cons_putc>

ffffffffc020011a <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc020011a:	1101                	addi	sp,sp,-32
ffffffffc020011c:	e822                	sd	s0,16(sp)
ffffffffc020011e:	ec06                	sd	ra,24(sp)
ffffffffc0200120:	e426                	sd	s1,8(sp)
ffffffffc0200122:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc0200124:	00054503          	lbu	a0,0(a0)
ffffffffc0200128:	c51d                	beqz	a0,ffffffffc0200156 <cputs+0x3c>
ffffffffc020012a:	0405                	addi	s0,s0,1
ffffffffc020012c:	4485                	li	s1,1
ffffffffc020012e:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200130:	013000ef          	jal	ra,ffffffffc0200942 <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc0200134:	00044503          	lbu	a0,0(s0)
ffffffffc0200138:	008487bb          	addw	a5,s1,s0
ffffffffc020013c:	0405                	addi	s0,s0,1
ffffffffc020013e:	f96d                	bnez	a0,ffffffffc0200130 <cputs+0x16>
    (*cnt)++;
ffffffffc0200140:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200144:	4529                	li	a0,10
ffffffffc0200146:	7fc000ef          	jal	ra,ffffffffc0200942 <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc020014a:	60e2                	ld	ra,24(sp)
ffffffffc020014c:	8522                	mv	a0,s0
ffffffffc020014e:	6442                	ld	s0,16(sp)
ffffffffc0200150:	64a2                	ld	s1,8(sp)
ffffffffc0200152:	6105                	addi	sp,sp,32
ffffffffc0200154:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc0200156:	4405                	li	s0,1
ffffffffc0200158:	b7f5                	j	ffffffffc0200144 <cputs+0x2a>

ffffffffc020015a <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc020015a:	1141                	addi	sp,sp,-16
ffffffffc020015c:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc020015e:	019000ef          	jal	ra,ffffffffc0200976 <cons_getc>
ffffffffc0200162:	dd75                	beqz	a0,ffffffffc020015e <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200164:	60a2                	ld	ra,8(sp)
ffffffffc0200166:	0141                	addi	sp,sp,16
ffffffffc0200168:	8082                	ret

ffffffffc020016a <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc020016a:	715d                	addi	sp,sp,-80
ffffffffc020016c:	e486                	sd	ra,72(sp)
ffffffffc020016e:	e0a6                	sd	s1,64(sp)
ffffffffc0200170:	fc4a                	sd	s2,56(sp)
ffffffffc0200172:	f84e                	sd	s3,48(sp)
ffffffffc0200174:	f452                	sd	s4,40(sp)
ffffffffc0200176:	f056                	sd	s5,32(sp)
ffffffffc0200178:	ec5a                	sd	s6,24(sp)
ffffffffc020017a:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc020017c:	c901                	beqz	a0,ffffffffc020018c <readline+0x22>
ffffffffc020017e:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0200180:	00005517          	auipc	a0,0x5
ffffffffc0200184:	57850513          	addi	a0,a0,1400 # ffffffffc02056f8 <etext+0x28>
ffffffffc0200188:	f59ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
readline(const char *prompt) {
ffffffffc020018c:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020018e:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0200190:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0200192:	4aa9                	li	s5,10
ffffffffc0200194:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0200196:	000a6b97          	auipc	s7,0xa6
ffffffffc020019a:	09ab8b93          	addi	s7,s7,154 # ffffffffc02a6230 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020019e:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02001a2:	fb9ff0ef          	jal	ra,ffffffffc020015a <getchar>
        if (c < 0) {
ffffffffc02001a6:	00054a63          	bltz	a0,ffffffffc02001ba <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001aa:	00a95a63          	bge	s2,a0,ffffffffc02001be <readline+0x54>
ffffffffc02001ae:	029a5263          	bge	s4,s1,ffffffffc02001d2 <readline+0x68>
        c = getchar();
ffffffffc02001b2:	fa9ff0ef          	jal	ra,ffffffffc020015a <getchar>
        if (c < 0) {
ffffffffc02001b6:	fe055ae3          	bgez	a0,ffffffffc02001aa <readline+0x40>
            return NULL;
ffffffffc02001ba:	4501                	li	a0,0
ffffffffc02001bc:	a091                	j	ffffffffc0200200 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02001be:	03351463          	bne	a0,s3,ffffffffc02001e6 <readline+0x7c>
ffffffffc02001c2:	e8a9                	bnez	s1,ffffffffc0200214 <readline+0xaa>
        c = getchar();
ffffffffc02001c4:	f97ff0ef          	jal	ra,ffffffffc020015a <getchar>
        if (c < 0) {
ffffffffc02001c8:	fe0549e3          	bltz	a0,ffffffffc02001ba <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001cc:	fea959e3          	bge	s2,a0,ffffffffc02001be <readline+0x54>
ffffffffc02001d0:	4481                	li	s1,0
            cputchar(c);
ffffffffc02001d2:	e42a                	sd	a0,8(sp)
ffffffffc02001d4:	f43ff0ef          	jal	ra,ffffffffc0200116 <cputchar>
            buf[i ++] = c;
ffffffffc02001d8:	6522                	ld	a0,8(sp)
ffffffffc02001da:	009b87b3          	add	a5,s7,s1
ffffffffc02001de:	2485                	addiw	s1,s1,1
ffffffffc02001e0:	00a78023          	sb	a0,0(a5)
ffffffffc02001e4:	bf7d                	j	ffffffffc02001a2 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc02001e6:	01550463          	beq	a0,s5,ffffffffc02001ee <readline+0x84>
ffffffffc02001ea:	fb651ce3          	bne	a0,s6,ffffffffc02001a2 <readline+0x38>
            cputchar(c);
ffffffffc02001ee:	f29ff0ef          	jal	ra,ffffffffc0200116 <cputchar>
            buf[i] = '\0';
ffffffffc02001f2:	000a6517          	auipc	a0,0xa6
ffffffffc02001f6:	03e50513          	addi	a0,a0,62 # ffffffffc02a6230 <buf>
ffffffffc02001fa:	94aa                	add	s1,s1,a0
ffffffffc02001fc:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0200200:	60a6                	ld	ra,72(sp)
ffffffffc0200202:	6486                	ld	s1,64(sp)
ffffffffc0200204:	7962                	ld	s2,56(sp)
ffffffffc0200206:	79c2                	ld	s3,48(sp)
ffffffffc0200208:	7a22                	ld	s4,40(sp)
ffffffffc020020a:	7a82                	ld	s5,32(sp)
ffffffffc020020c:	6b62                	ld	s6,24(sp)
ffffffffc020020e:	6bc2                	ld	s7,16(sp)
ffffffffc0200210:	6161                	addi	sp,sp,80
ffffffffc0200212:	8082                	ret
            cputchar(c);
ffffffffc0200214:	4521                	li	a0,8
ffffffffc0200216:	f01ff0ef          	jal	ra,ffffffffc0200116 <cputchar>
            i --;
ffffffffc020021a:	34fd                	addiw	s1,s1,-1
ffffffffc020021c:	b759                	j	ffffffffc02001a2 <readline+0x38>

ffffffffc020021e <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void __panic(const char *file, int line, const char *fmt, ...)
{
    if (is_panic)
ffffffffc020021e:	000aa317          	auipc	t1,0xaa
ffffffffc0200222:	43a30313          	addi	t1,t1,1082 # ffffffffc02aa658 <is_panic>
ffffffffc0200226:	00033e03          	ld	t3,0(t1)
{
ffffffffc020022a:	715d                	addi	sp,sp,-80
ffffffffc020022c:	ec06                	sd	ra,24(sp)
ffffffffc020022e:	e822                	sd	s0,16(sp)
ffffffffc0200230:	f436                	sd	a3,40(sp)
ffffffffc0200232:	f83a                	sd	a4,48(sp)
ffffffffc0200234:	fc3e                	sd	a5,56(sp)
ffffffffc0200236:	e0c2                	sd	a6,64(sp)
ffffffffc0200238:	e4c6                	sd	a7,72(sp)
    if (is_panic)
ffffffffc020023a:	020e1a63          	bnez	t3,ffffffffc020026e <__panic+0x50>
    {
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc020023e:	4785                	li	a5,1
ffffffffc0200240:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc0200244:	8432                	mv	s0,a2
ffffffffc0200246:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200248:	862e                	mv	a2,a1
ffffffffc020024a:	85aa                	mv	a1,a0
ffffffffc020024c:	00005517          	auipc	a0,0x5
ffffffffc0200250:	4b450513          	addi	a0,a0,1204 # ffffffffc0205700 <etext+0x30>
    va_start(ap, fmt);
ffffffffc0200254:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200256:	e8bff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020025a:	65a2                	ld	a1,8(sp)
ffffffffc020025c:	8522                	mv	a0,s0
ffffffffc020025e:	e63ff0ef          	jal	ra,ffffffffc02000c0 <vcprintf>
    cprintf("\n");
ffffffffc0200262:	00007517          	auipc	a0,0x7
ffffffffc0200266:	aa650513          	addi	a0,a0,-1370 # ffffffffc0206d08 <default_pmm_manager+0x488>
ffffffffc020026a:	e77ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc020026e:	4501                	li	a0,0
ffffffffc0200270:	4581                	li	a1,0
ffffffffc0200272:	4601                	li	a2,0
ffffffffc0200274:	48a1                	li	a7,8
ffffffffc0200276:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc020027a:	740000ef          	jal	ra,ffffffffc02009ba <intr_disable>
    while (1)
    {
        kmonitor(NULL);
ffffffffc020027e:	4501                	li	a0,0
ffffffffc0200280:	174000ef          	jal	ra,ffffffffc02003f4 <kmonitor>
    while (1)
ffffffffc0200284:	bfed                	j	ffffffffc020027e <__panic+0x60>

ffffffffc0200286 <__warn>:
    }
}

/* __warn - like panic, but don't */
void __warn(const char *file, int line, const char *fmt, ...)
{
ffffffffc0200286:	715d                	addi	sp,sp,-80
ffffffffc0200288:	832e                	mv	t1,a1
ffffffffc020028a:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020028c:	85aa                	mv	a1,a0
{
ffffffffc020028e:	8432                	mv	s0,a2
ffffffffc0200290:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200292:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200294:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200296:	00005517          	auipc	a0,0x5
ffffffffc020029a:	48a50513          	addi	a0,a0,1162 # ffffffffc0205720 <etext+0x50>
{
ffffffffc020029e:	ec06                	sd	ra,24(sp)
ffffffffc02002a0:	f436                	sd	a3,40(sp)
ffffffffc02002a2:	f83a                	sd	a4,48(sp)
ffffffffc02002a4:	e0c2                	sd	a6,64(sp)
ffffffffc02002a6:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02002a8:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc02002aa:	e37ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02002ae:	65a2                	ld	a1,8(sp)
ffffffffc02002b0:	8522                	mv	a0,s0
ffffffffc02002b2:	e0fff0ef          	jal	ra,ffffffffc02000c0 <vcprintf>
    cprintf("\n");
ffffffffc02002b6:	00007517          	auipc	a0,0x7
ffffffffc02002ba:	a5250513          	addi	a0,a0,-1454 # ffffffffc0206d08 <default_pmm_manager+0x488>
ffffffffc02002be:	e23ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    va_end(ap);
}
ffffffffc02002c2:	60e2                	ld	ra,24(sp)
ffffffffc02002c4:	6442                	ld	s0,16(sp)
ffffffffc02002c6:	6161                	addi	sp,sp,80
ffffffffc02002c8:	8082                	ret

ffffffffc02002ca <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void)
{
ffffffffc02002ca:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc02002cc:	00005517          	auipc	a0,0x5
ffffffffc02002d0:	47450513          	addi	a0,a0,1140 # ffffffffc0205740 <etext+0x70>
{
ffffffffc02002d4:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02002d6:	e0bff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc02002da:	00000597          	auipc	a1,0x0
ffffffffc02002de:	d7058593          	addi	a1,a1,-656 # ffffffffc020004a <kern_init>
ffffffffc02002e2:	00005517          	auipc	a0,0x5
ffffffffc02002e6:	47e50513          	addi	a0,a0,1150 # ffffffffc0205760 <etext+0x90>
ffffffffc02002ea:	df7ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc02002ee:	00005597          	auipc	a1,0x5
ffffffffc02002f2:	3e258593          	addi	a1,a1,994 # ffffffffc02056d0 <etext>
ffffffffc02002f6:	00005517          	auipc	a0,0x5
ffffffffc02002fa:	48a50513          	addi	a0,a0,1162 # ffffffffc0205780 <etext+0xb0>
ffffffffc02002fe:	de3ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200302:	000a6597          	auipc	a1,0xa6
ffffffffc0200306:	f2e58593          	addi	a1,a1,-210 # ffffffffc02a6230 <buf>
ffffffffc020030a:	00005517          	auipc	a0,0x5
ffffffffc020030e:	49650513          	addi	a0,a0,1174 # ffffffffc02057a0 <etext+0xd0>
ffffffffc0200312:	dcfff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc0200316:	000aa597          	auipc	a1,0xaa
ffffffffc020031a:	3c658593          	addi	a1,a1,966 # ffffffffc02aa6dc <end>
ffffffffc020031e:	00005517          	auipc	a0,0x5
ffffffffc0200322:	4a250513          	addi	a0,a0,1186 # ffffffffc02057c0 <etext+0xf0>
ffffffffc0200326:	dbbff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020032a:	000aa597          	auipc	a1,0xaa
ffffffffc020032e:	7b158593          	addi	a1,a1,1969 # ffffffffc02aaadb <end+0x3ff>
ffffffffc0200332:	00000797          	auipc	a5,0x0
ffffffffc0200336:	d1878793          	addi	a5,a5,-744 # ffffffffc020004a <kern_init>
ffffffffc020033a:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020033e:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200342:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200344:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200348:	95be                	add	a1,a1,a5
ffffffffc020034a:	85a9                	srai	a1,a1,0xa
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	49450513          	addi	a0,a0,1172 # ffffffffc02057e0 <etext+0x110>
}
ffffffffc0200354:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200356:	b369                	j	ffffffffc02000e0 <cprintf>

ffffffffc0200358 <print_stackframe>:
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void)
{
ffffffffc0200358:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc020035a:	00005617          	auipc	a2,0x5
ffffffffc020035e:	4b660613          	addi	a2,a2,1206 # ffffffffc0205810 <etext+0x140>
ffffffffc0200362:	04f00593          	li	a1,79
ffffffffc0200366:	00005517          	auipc	a0,0x5
ffffffffc020036a:	4c250513          	addi	a0,a0,1218 # ffffffffc0205828 <etext+0x158>
{
ffffffffc020036e:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200370:	eafff0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0200374 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int mon_help(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200374:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i++)
    {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200376:	00005617          	auipc	a2,0x5
ffffffffc020037a:	4ca60613          	addi	a2,a2,1226 # ffffffffc0205840 <etext+0x170>
ffffffffc020037e:	00005597          	auipc	a1,0x5
ffffffffc0200382:	4e258593          	addi	a1,a1,1250 # ffffffffc0205860 <etext+0x190>
ffffffffc0200386:	00005517          	auipc	a0,0x5
ffffffffc020038a:	4e250513          	addi	a0,a0,1250 # ffffffffc0205868 <etext+0x198>
{
ffffffffc020038e:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200390:	d51ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
ffffffffc0200394:	00005617          	auipc	a2,0x5
ffffffffc0200398:	4e460613          	addi	a2,a2,1252 # ffffffffc0205878 <etext+0x1a8>
ffffffffc020039c:	00005597          	auipc	a1,0x5
ffffffffc02003a0:	50458593          	addi	a1,a1,1284 # ffffffffc02058a0 <etext+0x1d0>
ffffffffc02003a4:	00005517          	auipc	a0,0x5
ffffffffc02003a8:	4c450513          	addi	a0,a0,1220 # ffffffffc0205868 <etext+0x198>
ffffffffc02003ac:	d35ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
ffffffffc02003b0:	00005617          	auipc	a2,0x5
ffffffffc02003b4:	50060613          	addi	a2,a2,1280 # ffffffffc02058b0 <etext+0x1e0>
ffffffffc02003b8:	00005597          	auipc	a1,0x5
ffffffffc02003bc:	51858593          	addi	a1,a1,1304 # ffffffffc02058d0 <etext+0x200>
ffffffffc02003c0:	00005517          	auipc	a0,0x5
ffffffffc02003c4:	4a850513          	addi	a0,a0,1192 # ffffffffc0205868 <etext+0x198>
ffffffffc02003c8:	d19ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    }
    return 0;
}
ffffffffc02003cc:	60a2                	ld	ra,8(sp)
ffffffffc02003ce:	4501                	li	a0,0
ffffffffc02003d0:	0141                	addi	sp,sp,16
ffffffffc02003d2:	8082                	ret

ffffffffc02003d4 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int mon_kerninfo(int argc, char **argv, struct trapframe *tf)
{
ffffffffc02003d4:	1141                	addi	sp,sp,-16
ffffffffc02003d6:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02003d8:	ef3ff0ef          	jal	ra,ffffffffc02002ca <print_kerninfo>
    return 0;
}
ffffffffc02003dc:	60a2                	ld	ra,8(sp)
ffffffffc02003de:	4501                	li	a0,0
ffffffffc02003e0:	0141                	addi	sp,sp,16
ffffffffc02003e2:	8082                	ret

ffffffffc02003e4 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int mon_backtrace(int argc, char **argv, struct trapframe *tf)
{
ffffffffc02003e4:	1141                	addi	sp,sp,-16
ffffffffc02003e6:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02003e8:	f71ff0ef          	jal	ra,ffffffffc0200358 <print_stackframe>
    return 0;
}
ffffffffc02003ec:	60a2                	ld	ra,8(sp)
ffffffffc02003ee:	4501                	li	a0,0
ffffffffc02003f0:	0141                	addi	sp,sp,16
ffffffffc02003f2:	8082                	ret

ffffffffc02003f4 <kmonitor>:
{
ffffffffc02003f4:	7115                	addi	sp,sp,-224
ffffffffc02003f6:	ed5e                	sd	s7,152(sp)
ffffffffc02003f8:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003fa:	00005517          	auipc	a0,0x5
ffffffffc02003fe:	4e650513          	addi	a0,a0,1254 # ffffffffc02058e0 <etext+0x210>
{
ffffffffc0200402:	ed86                	sd	ra,216(sp)
ffffffffc0200404:	e9a2                	sd	s0,208(sp)
ffffffffc0200406:	e5a6                	sd	s1,200(sp)
ffffffffc0200408:	e1ca                	sd	s2,192(sp)
ffffffffc020040a:	fd4e                	sd	s3,184(sp)
ffffffffc020040c:	f952                	sd	s4,176(sp)
ffffffffc020040e:	f556                	sd	s5,168(sp)
ffffffffc0200410:	f15a                	sd	s6,160(sp)
ffffffffc0200412:	e962                	sd	s8,144(sp)
ffffffffc0200414:	e566                	sd	s9,136(sp)
ffffffffc0200416:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200418:	cc9ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc020041c:	00005517          	auipc	a0,0x5
ffffffffc0200420:	4ec50513          	addi	a0,a0,1260 # ffffffffc0205908 <etext+0x238>
ffffffffc0200424:	cbdff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    if (tf != NULL)
ffffffffc0200428:	000b8563          	beqz	s7,ffffffffc0200432 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020042c:	855e                	mv	a0,s7
ffffffffc020042e:	77a000ef          	jal	ra,ffffffffc0200ba8 <print_trapframe>
ffffffffc0200432:	00005c17          	auipc	s8,0x5
ffffffffc0200436:	546c0c13          	addi	s8,s8,1350 # ffffffffc0205978 <commands>
        if ((buf = readline("K> ")) != NULL)
ffffffffc020043a:	00005917          	auipc	s2,0x5
ffffffffc020043e:	4f690913          	addi	s2,s2,1270 # ffffffffc0205930 <etext+0x260>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200442:	00005497          	auipc	s1,0x5
ffffffffc0200446:	4f648493          	addi	s1,s1,1270 # ffffffffc0205938 <etext+0x268>
        if (argc == MAXARGS - 1)
ffffffffc020044a:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020044c:	00005b17          	auipc	s6,0x5
ffffffffc0200450:	4f4b0b13          	addi	s6,s6,1268 # ffffffffc0205940 <etext+0x270>
        argv[argc++] = buf;
ffffffffc0200454:	00005a17          	auipc	s4,0x5
ffffffffc0200458:	40ca0a13          	addi	s4,s4,1036 # ffffffffc0205860 <etext+0x190>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc020045c:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL)
ffffffffc020045e:	854a                	mv	a0,s2
ffffffffc0200460:	d0bff0ef          	jal	ra,ffffffffc020016a <readline>
ffffffffc0200464:	842a                	mv	s0,a0
ffffffffc0200466:	dd65                	beqz	a0,ffffffffc020045e <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200468:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc020046c:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc020046e:	e1bd                	bnez	a1,ffffffffc02004d4 <kmonitor+0xe0>
    if (argc == 0)
ffffffffc0200470:	fe0c87e3          	beqz	s9,ffffffffc020045e <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc0200474:	6582                	ld	a1,0(sp)
ffffffffc0200476:	00005d17          	auipc	s10,0x5
ffffffffc020047a:	502d0d13          	addi	s10,s10,1282 # ffffffffc0205978 <commands>
        argv[argc++] = buf;
ffffffffc020047e:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc0200480:	4401                	li	s0,0
ffffffffc0200482:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc0200484:	5c5040ef          	jal	ra,ffffffffc0205248 <strcmp>
ffffffffc0200488:	c919                	beqz	a0,ffffffffc020049e <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc020048a:	2405                	addiw	s0,s0,1
ffffffffc020048c:	0b540063          	beq	s0,s5,ffffffffc020052c <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc0200490:	000d3503          	ld	a0,0(s10)
ffffffffc0200494:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc0200496:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc0200498:	5b1040ef          	jal	ra,ffffffffc0205248 <strcmp>
ffffffffc020049c:	f57d                	bnez	a0,ffffffffc020048a <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc020049e:	00141793          	slli	a5,s0,0x1
ffffffffc02004a2:	97a2                	add	a5,a5,s0
ffffffffc02004a4:	078e                	slli	a5,a5,0x3
ffffffffc02004a6:	97e2                	add	a5,a5,s8
ffffffffc02004a8:	6b9c                	ld	a5,16(a5)
ffffffffc02004aa:	865e                	mv	a2,s7
ffffffffc02004ac:	002c                	addi	a1,sp,8
ffffffffc02004ae:	fffc851b          	addiw	a0,s9,-1
ffffffffc02004b2:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0)
ffffffffc02004b4:	fa0555e3          	bgez	a0,ffffffffc020045e <kmonitor+0x6a>
}
ffffffffc02004b8:	60ee                	ld	ra,216(sp)
ffffffffc02004ba:	644e                	ld	s0,208(sp)
ffffffffc02004bc:	64ae                	ld	s1,200(sp)
ffffffffc02004be:	690e                	ld	s2,192(sp)
ffffffffc02004c0:	79ea                	ld	s3,184(sp)
ffffffffc02004c2:	7a4a                	ld	s4,176(sp)
ffffffffc02004c4:	7aaa                	ld	s5,168(sp)
ffffffffc02004c6:	7b0a                	ld	s6,160(sp)
ffffffffc02004c8:	6bea                	ld	s7,152(sp)
ffffffffc02004ca:	6c4a                	ld	s8,144(sp)
ffffffffc02004cc:	6caa                	ld	s9,136(sp)
ffffffffc02004ce:	6d0a                	ld	s10,128(sp)
ffffffffc02004d0:	612d                	addi	sp,sp,224
ffffffffc02004d2:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02004d4:	8526                	mv	a0,s1
ffffffffc02004d6:	5b7040ef          	jal	ra,ffffffffc020528c <strchr>
ffffffffc02004da:	c901                	beqz	a0,ffffffffc02004ea <kmonitor+0xf6>
ffffffffc02004dc:	00144583          	lbu	a1,1(s0)
            *buf++ = '\0';
ffffffffc02004e0:	00040023          	sb	zero,0(s0)
ffffffffc02004e4:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02004e6:	d5c9                	beqz	a1,ffffffffc0200470 <kmonitor+0x7c>
ffffffffc02004e8:	b7f5                	j	ffffffffc02004d4 <kmonitor+0xe0>
        if (*buf == '\0')
ffffffffc02004ea:	00044783          	lbu	a5,0(s0)
ffffffffc02004ee:	d3c9                	beqz	a5,ffffffffc0200470 <kmonitor+0x7c>
        if (argc == MAXARGS - 1)
ffffffffc02004f0:	033c8963          	beq	s9,s3,ffffffffc0200522 <kmonitor+0x12e>
        argv[argc++] = buf;
ffffffffc02004f4:	003c9793          	slli	a5,s9,0x3
ffffffffc02004f8:	0118                	addi	a4,sp,128
ffffffffc02004fa:	97ba                	add	a5,a5,a4
ffffffffc02004fc:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
        argv[argc++] = buf;
ffffffffc0200504:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200506:	e591                	bnez	a1,ffffffffc0200512 <kmonitor+0x11e>
ffffffffc0200508:	b7b5                	j	ffffffffc0200474 <kmonitor+0x80>
ffffffffc020050a:	00144583          	lbu	a1,1(s0)
            buf++;
ffffffffc020050e:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200510:	d1a5                	beqz	a1,ffffffffc0200470 <kmonitor+0x7c>
ffffffffc0200512:	8526                	mv	a0,s1
ffffffffc0200514:	579040ef          	jal	ra,ffffffffc020528c <strchr>
ffffffffc0200518:	d96d                	beqz	a0,ffffffffc020050a <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc020051a:	00044583          	lbu	a1,0(s0)
ffffffffc020051e:	d9a9                	beqz	a1,ffffffffc0200470 <kmonitor+0x7c>
ffffffffc0200520:	bf55                	j	ffffffffc02004d4 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200522:	45c1                	li	a1,16
ffffffffc0200524:	855a                	mv	a0,s6
ffffffffc0200526:	bbbff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
ffffffffc020052a:	b7e9                	j	ffffffffc02004f4 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020052c:	6582                	ld	a1,0(sp)
ffffffffc020052e:	00005517          	auipc	a0,0x5
ffffffffc0200532:	43250513          	addi	a0,a0,1074 # ffffffffc0205960 <etext+0x290>
ffffffffc0200536:	babff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    return 0;
ffffffffc020053a:	b715                	j	ffffffffc020045e <kmonitor+0x6a>

ffffffffc020053c <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc020053c:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc020053e:	00005517          	auipc	a0,0x5
ffffffffc0200542:	48250513          	addi	a0,a0,1154 # ffffffffc02059c0 <commands+0x48>
void dtb_init(void) {
ffffffffc0200546:	fc86                	sd	ra,120(sp)
ffffffffc0200548:	f8a2                	sd	s0,112(sp)
ffffffffc020054a:	e8d2                	sd	s4,80(sp)
ffffffffc020054c:	f4a6                	sd	s1,104(sp)
ffffffffc020054e:	f0ca                	sd	s2,96(sp)
ffffffffc0200550:	ecce                	sd	s3,88(sp)
ffffffffc0200552:	e4d6                	sd	s5,72(sp)
ffffffffc0200554:	e0da                	sd	s6,64(sp)
ffffffffc0200556:	fc5e                	sd	s7,56(sp)
ffffffffc0200558:	f862                	sd	s8,48(sp)
ffffffffc020055a:	f466                	sd	s9,40(sp)
ffffffffc020055c:	f06a                	sd	s10,32(sp)
ffffffffc020055e:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200560:	b81ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200564:	0000b597          	auipc	a1,0xb
ffffffffc0200568:	a9c5b583          	ld	a1,-1380(a1) # ffffffffc020b000 <boot_hartid>
ffffffffc020056c:	00005517          	auipc	a0,0x5
ffffffffc0200570:	46450513          	addi	a0,a0,1124 # ffffffffc02059d0 <commands+0x58>
ffffffffc0200574:	b6dff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc0200578:	0000b417          	auipc	s0,0xb
ffffffffc020057c:	a9040413          	addi	s0,s0,-1392 # ffffffffc020b008 <boot_dtb>
ffffffffc0200580:	600c                	ld	a1,0(s0)
ffffffffc0200582:	00005517          	auipc	a0,0x5
ffffffffc0200586:	45e50513          	addi	a0,a0,1118 # ffffffffc02059e0 <commands+0x68>
ffffffffc020058a:	b57ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc020058e:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200592:	00005517          	auipc	a0,0x5
ffffffffc0200596:	46650513          	addi	a0,a0,1126 # ffffffffc02059f8 <commands+0x80>
    if (boot_dtb == 0) {
ffffffffc020059a:	120a0463          	beqz	s4,ffffffffc02006c2 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc020059e:	57f5                	li	a5,-3
ffffffffc02005a0:	07fa                	slli	a5,a5,0x1e
ffffffffc02005a2:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc02005a6:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005a8:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005ac:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005ae:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02005b2:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005b6:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005ba:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005be:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005c2:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005c4:	8ec9                	or	a3,a3,a0
ffffffffc02005c6:	0087979b          	slliw	a5,a5,0x8
ffffffffc02005ca:	1b7d                	addi	s6,s6,-1
ffffffffc02005cc:	0167f7b3          	and	a5,a5,s6
ffffffffc02005d0:	8dd5                	or	a1,a1,a3
ffffffffc02005d2:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc02005d4:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005d8:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc02005da:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe35811>
ffffffffc02005de:	10f59163          	bne	a1,a5,ffffffffc02006e0 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02005e2:	471c                	lw	a5,8(a4)
ffffffffc02005e4:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02005e6:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005e8:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02005ec:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02005f0:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005f4:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005f8:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005fc:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200600:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200604:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200608:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020060c:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200610:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200612:	01146433          	or	s0,s0,a7
ffffffffc0200616:	0086969b          	slliw	a3,a3,0x8
ffffffffc020061a:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020061e:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200620:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200624:	8c49                	or	s0,s0,a0
ffffffffc0200626:	0166f6b3          	and	a3,a3,s6
ffffffffc020062a:	00ca6a33          	or	s4,s4,a2
ffffffffc020062e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200632:	8c55                	or	s0,s0,a3
ffffffffc0200634:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200638:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020063a:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020063c:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020063e:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200642:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200644:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200646:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020064a:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020064c:	00005917          	auipc	s2,0x5
ffffffffc0200650:	3fc90913          	addi	s2,s2,1020 # ffffffffc0205a48 <commands+0xd0>
ffffffffc0200654:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200656:	4d91                	li	s11,4
ffffffffc0200658:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020065a:	00005497          	auipc	s1,0x5
ffffffffc020065e:	3e648493          	addi	s1,s1,998 # ffffffffc0205a40 <commands+0xc8>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200662:	000a2703          	lw	a4,0(s4)
ffffffffc0200666:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	0087569b          	srliw	a3,a4,0x8
ffffffffc020066e:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200672:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200676:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020067a:	0107571b          	srliw	a4,a4,0x10
ffffffffc020067e:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200680:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200684:	0087171b          	slliw	a4,a4,0x8
ffffffffc0200688:	8fd5                	or	a5,a5,a3
ffffffffc020068a:	00eb7733          	and	a4,s6,a4
ffffffffc020068e:	8fd9                	or	a5,a5,a4
ffffffffc0200690:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200692:	09778c63          	beq	a5,s7,ffffffffc020072a <dtb_init+0x1ee>
ffffffffc0200696:	00fbea63          	bltu	s7,a5,ffffffffc02006aa <dtb_init+0x16e>
ffffffffc020069a:	07a78663          	beq	a5,s10,ffffffffc0200706 <dtb_init+0x1ca>
ffffffffc020069e:	4709                	li	a4,2
ffffffffc02006a0:	00e79763          	bne	a5,a4,ffffffffc02006ae <dtb_init+0x172>
ffffffffc02006a4:	4c81                	li	s9,0
ffffffffc02006a6:	8a56                	mv	s4,s5
ffffffffc02006a8:	bf6d                	j	ffffffffc0200662 <dtb_init+0x126>
ffffffffc02006aa:	ffb78ee3          	beq	a5,s11,ffffffffc02006a6 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc02006ae:	00005517          	auipc	a0,0x5
ffffffffc02006b2:	41250513          	addi	a0,a0,1042 # ffffffffc0205ac0 <commands+0x148>
ffffffffc02006b6:	a2bff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc02006ba:	00005517          	auipc	a0,0x5
ffffffffc02006be:	43e50513          	addi	a0,a0,1086 # ffffffffc0205af8 <commands+0x180>
}
ffffffffc02006c2:	7446                	ld	s0,112(sp)
ffffffffc02006c4:	70e6                	ld	ra,120(sp)
ffffffffc02006c6:	74a6                	ld	s1,104(sp)
ffffffffc02006c8:	7906                	ld	s2,96(sp)
ffffffffc02006ca:	69e6                	ld	s3,88(sp)
ffffffffc02006cc:	6a46                	ld	s4,80(sp)
ffffffffc02006ce:	6aa6                	ld	s5,72(sp)
ffffffffc02006d0:	6b06                	ld	s6,64(sp)
ffffffffc02006d2:	7be2                	ld	s7,56(sp)
ffffffffc02006d4:	7c42                	ld	s8,48(sp)
ffffffffc02006d6:	7ca2                	ld	s9,40(sp)
ffffffffc02006d8:	7d02                	ld	s10,32(sp)
ffffffffc02006da:	6de2                	ld	s11,24(sp)
ffffffffc02006dc:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02006de:	b409                	j	ffffffffc02000e0 <cprintf>
}
ffffffffc02006e0:	7446                	ld	s0,112(sp)
ffffffffc02006e2:	70e6                	ld	ra,120(sp)
ffffffffc02006e4:	74a6                	ld	s1,104(sp)
ffffffffc02006e6:	7906                	ld	s2,96(sp)
ffffffffc02006e8:	69e6                	ld	s3,88(sp)
ffffffffc02006ea:	6a46                	ld	s4,80(sp)
ffffffffc02006ec:	6aa6                	ld	s5,72(sp)
ffffffffc02006ee:	6b06                	ld	s6,64(sp)
ffffffffc02006f0:	7be2                	ld	s7,56(sp)
ffffffffc02006f2:	7c42                	ld	s8,48(sp)
ffffffffc02006f4:	7ca2                	ld	s9,40(sp)
ffffffffc02006f6:	7d02                	ld	s10,32(sp)
ffffffffc02006f8:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02006fa:	00005517          	auipc	a0,0x5
ffffffffc02006fe:	31e50513          	addi	a0,a0,798 # ffffffffc0205a18 <commands+0xa0>
}
ffffffffc0200702:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200704:	baf1                	j	ffffffffc02000e0 <cprintf>
                int name_len = strlen(name);
ffffffffc0200706:	8556                	mv	a0,s5
ffffffffc0200708:	2f9040ef          	jal	ra,ffffffffc0205200 <strlen>
ffffffffc020070c:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020070e:	4619                	li	a2,6
ffffffffc0200710:	85a6                	mv	a1,s1
ffffffffc0200712:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc0200714:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200716:	351040ef          	jal	ra,ffffffffc0205266 <strncmp>
ffffffffc020071a:	e111                	bnez	a0,ffffffffc020071e <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc020071c:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc020071e:	0a91                	addi	s5,s5,4
ffffffffc0200720:	9ad2                	add	s5,s5,s4
ffffffffc0200722:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200726:	8a56                	mv	s4,s5
ffffffffc0200728:	bf2d                	j	ffffffffc0200662 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc020072a:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020072e:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200732:	0087d71b          	srliw	a4,a5,0x8
ffffffffc0200736:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020073a:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020073e:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200742:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200746:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020074a:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020074e:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200752:	00eaeab3          	or	s5,s5,a4
ffffffffc0200756:	00fb77b3          	and	a5,s6,a5
ffffffffc020075a:	00faeab3          	or	s5,s5,a5
ffffffffc020075e:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200760:	000c9c63          	bnez	s9,ffffffffc0200778 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200764:	1a82                	slli	s5,s5,0x20
ffffffffc0200766:	00368793          	addi	a5,a3,3
ffffffffc020076a:	020ada93          	srli	s5,s5,0x20
ffffffffc020076e:	9abe                	add	s5,s5,a5
ffffffffc0200770:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200774:	8a56                	mv	s4,s5
ffffffffc0200776:	b5f5                	j	ffffffffc0200662 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200778:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020077c:	85ca                	mv	a1,s2
ffffffffc020077e:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200780:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200784:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200788:	0187971b          	slliw	a4,a5,0x18
ffffffffc020078c:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200790:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200794:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200796:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020079a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020079e:	8d59                	or	a0,a0,a4
ffffffffc02007a0:	00fb77b3          	and	a5,s6,a5
ffffffffc02007a4:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc02007a6:	1502                	slli	a0,a0,0x20
ffffffffc02007a8:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02007aa:	9522                	add	a0,a0,s0
ffffffffc02007ac:	29d040ef          	jal	ra,ffffffffc0205248 <strcmp>
ffffffffc02007b0:	66a2                	ld	a3,8(sp)
ffffffffc02007b2:	f94d                	bnez	a0,ffffffffc0200764 <dtb_init+0x228>
ffffffffc02007b4:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200764 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc02007b8:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02007bc:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02007c0:	00005517          	auipc	a0,0x5
ffffffffc02007c4:	29050513          	addi	a0,a0,656 # ffffffffc0205a50 <commands+0xd8>
           fdt32_to_cpu(x >> 32);
ffffffffc02007c8:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007cc:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc02007d0:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007d4:	0187de1b          	srliw	t3,a5,0x18
ffffffffc02007d8:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007dc:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007e0:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007e4:	0187d693          	srli	a3,a5,0x18
ffffffffc02007e8:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02007ec:	0087579b          	srliw	a5,a4,0x8
ffffffffc02007f0:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007f4:	0106561b          	srliw	a2,a2,0x10
ffffffffc02007f8:	010f6f33          	or	t5,t5,a6
ffffffffc02007fc:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200800:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200804:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200808:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020080c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200810:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200814:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200818:	0107581b          	srliw	a6,a4,0x10
ffffffffc020081c:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200820:	8361                	srli	a4,a4,0x18
ffffffffc0200822:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200826:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020082a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020082e:	00cb7633          	and	a2,s6,a2
ffffffffc0200832:	0088181b          	slliw	a6,a6,0x8
ffffffffc0200836:	0085959b          	slliw	a1,a1,0x8
ffffffffc020083a:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020083e:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200842:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200846:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020084a:	0088989b          	slliw	a7,a7,0x8
ffffffffc020084e:	011b78b3          	and	a7,s6,a7
ffffffffc0200852:	005eeeb3          	or	t4,t4,t0
ffffffffc0200856:	00c6e733          	or	a4,a3,a2
ffffffffc020085a:	006c6c33          	or	s8,s8,t1
ffffffffc020085e:	010b76b3          	and	a3,s6,a6
ffffffffc0200862:	00bb7b33          	and	s6,s6,a1
ffffffffc0200866:	01d7e7b3          	or	a5,a5,t4
ffffffffc020086a:	016c6b33          	or	s6,s8,s6
ffffffffc020086e:	01146433          	or	s0,s0,a7
ffffffffc0200872:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200874:	1702                	slli	a4,a4,0x20
ffffffffc0200876:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200878:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020087a:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020087c:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020087e:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200882:	0167eb33          	or	s6,a5,s6
ffffffffc0200886:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200888:	859ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc020088c:	85a2                	mv	a1,s0
ffffffffc020088e:	00005517          	auipc	a0,0x5
ffffffffc0200892:	1e250513          	addi	a0,a0,482 # ffffffffc0205a70 <commands+0xf8>
ffffffffc0200896:	84bff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020089a:	014b5613          	srli	a2,s6,0x14
ffffffffc020089e:	85da                	mv	a1,s6
ffffffffc02008a0:	00005517          	auipc	a0,0x5
ffffffffc02008a4:	1e850513          	addi	a0,a0,488 # ffffffffc0205a88 <commands+0x110>
ffffffffc02008a8:	839ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc02008ac:	008b05b3          	add	a1,s6,s0
ffffffffc02008b0:	15fd                	addi	a1,a1,-1
ffffffffc02008b2:	00005517          	auipc	a0,0x5
ffffffffc02008b6:	1f650513          	addi	a0,a0,502 # ffffffffc0205aa8 <commands+0x130>
ffffffffc02008ba:	827ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02008be:	00005517          	auipc	a0,0x5
ffffffffc02008c2:	23a50513          	addi	a0,a0,570 # ffffffffc0205af8 <commands+0x180>
        memory_base = mem_base;
ffffffffc02008c6:	000aa797          	auipc	a5,0xaa
ffffffffc02008ca:	d887bd23          	sd	s0,-614(a5) # ffffffffc02aa660 <memory_base>
        memory_size = mem_size;
ffffffffc02008ce:	000aa797          	auipc	a5,0xaa
ffffffffc02008d2:	d967bd23          	sd	s6,-614(a5) # ffffffffc02aa668 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02008d6:	b3f5                	j	ffffffffc02006c2 <dtb_init+0x186>

ffffffffc02008d8 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02008d8:	000aa517          	auipc	a0,0xaa
ffffffffc02008dc:	d8853503          	ld	a0,-632(a0) # ffffffffc02aa660 <memory_base>
ffffffffc02008e0:	8082                	ret

ffffffffc02008e2 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc02008e2:	000aa517          	auipc	a0,0xaa
ffffffffc02008e6:	d8653503          	ld	a0,-634(a0) # ffffffffc02aa668 <memory_size>
ffffffffc02008ea:	8082                	ret

ffffffffc02008ec <clock_init>:
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
    // divided by 500 when using Spike(2MHz)
    // divided by 100 when using QEMU(10MHz)
    timebase = 1e7 / 100;
ffffffffc02008ec:	67e1                	lui	a5,0x18
ffffffffc02008ee:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_exit_out_size+0xd588>
ffffffffc02008f2:	000aa717          	auipc	a4,0xaa
ffffffffc02008f6:	d8f73323          	sd	a5,-634(a4) # ffffffffc02aa678 <timebase>
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc02008fa:	c0102573          	rdtime	a0
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc02008fe:	4581                	li	a1,0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200900:	953e                	add	a0,a0,a5
ffffffffc0200902:	4601                	li	a2,0
ffffffffc0200904:	4881                	li	a7,0
ffffffffc0200906:	00000073          	ecall
    set_csr(sie, MIP_STIP);
ffffffffc020090a:	02000793          	li	a5,32
ffffffffc020090e:	1047a7f3          	csrrs	a5,sie,a5
    cprintf("++ setup timer interrupts\n");
ffffffffc0200912:	00005517          	auipc	a0,0x5
ffffffffc0200916:	1fe50513          	addi	a0,a0,510 # ffffffffc0205b10 <commands+0x198>
    ticks = 0;
ffffffffc020091a:	000aa797          	auipc	a5,0xaa
ffffffffc020091e:	d407bb23          	sd	zero,-682(a5) # ffffffffc02aa670 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200922:	fbeff06f          	j	ffffffffc02000e0 <cprintf>

ffffffffc0200926 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200926:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020092a:	000aa797          	auipc	a5,0xaa
ffffffffc020092e:	d4e7b783          	ld	a5,-690(a5) # ffffffffc02aa678 <timebase>
ffffffffc0200932:	953e                	add	a0,a0,a5
ffffffffc0200934:	4581                	li	a1,0
ffffffffc0200936:	4601                	li	a2,0
ffffffffc0200938:	4881                	li	a7,0
ffffffffc020093a:	00000073          	ecall
ffffffffc020093e:	8082                	ret

ffffffffc0200940 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200940:	8082                	ret

ffffffffc0200942 <cons_putc>:
#include <riscv.h>
#include <assert.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0200942:	100027f3          	csrr	a5,sstatus
ffffffffc0200946:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200948:	0ff57513          	zext.b	a0,a0
ffffffffc020094c:	e799                	bnez	a5,ffffffffc020095a <cons_putc+0x18>
ffffffffc020094e:	4581                	li	a1,0
ffffffffc0200950:	4601                	li	a2,0
ffffffffc0200952:	4885                	li	a7,1
ffffffffc0200954:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc0200958:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc020095a:	1101                	addi	sp,sp,-32
ffffffffc020095c:	ec06                	sd	ra,24(sp)
ffffffffc020095e:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0200960:	05a000ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0200964:	6522                	ld	a0,8(sp)
ffffffffc0200966:	4581                	li	a1,0
ffffffffc0200968:	4601                	li	a2,0
ffffffffc020096a:	4885                	li	a7,1
ffffffffc020096c:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc0200970:	60e2                	ld	ra,24(sp)
ffffffffc0200972:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc0200974:	a081                	j	ffffffffc02009b4 <intr_enable>

ffffffffc0200976 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0200976:	100027f3          	csrr	a5,sstatus
ffffffffc020097a:	8b89                	andi	a5,a5,2
ffffffffc020097c:	eb89                	bnez	a5,ffffffffc020098e <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc020097e:	4501                	li	a0,0
ffffffffc0200980:	4581                	li	a1,0
ffffffffc0200982:	4601                	li	a2,0
ffffffffc0200984:	4889                	li	a7,2
ffffffffc0200986:	00000073          	ecall
ffffffffc020098a:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc020098c:	8082                	ret
int cons_getc(void) {
ffffffffc020098e:	1101                	addi	sp,sp,-32
ffffffffc0200990:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc0200992:	028000ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0200996:	4501                	li	a0,0
ffffffffc0200998:	4581                	li	a1,0
ffffffffc020099a:	4601                	li	a2,0
ffffffffc020099c:	4889                	li	a7,2
ffffffffc020099e:	00000073          	ecall
ffffffffc02009a2:	2501                	sext.w	a0,a0
ffffffffc02009a4:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02009a6:	00e000ef          	jal	ra,ffffffffc02009b4 <intr_enable>
}
ffffffffc02009aa:	60e2                	ld	ra,24(sp)
ffffffffc02009ac:	6522                	ld	a0,8(sp)
ffffffffc02009ae:	6105                	addi	sp,sp,32
ffffffffc02009b0:	8082                	ret

ffffffffc02009b2 <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009b4:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009b8:	8082                	ret

ffffffffc02009ba <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ba:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009be:	8082                	ret

ffffffffc02009c0 <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009c0:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009c4:	00000797          	auipc	a5,0x0
ffffffffc02009c8:	4c478793          	addi	a5,a5,1220 # ffffffffc0200e88 <__alltraps>
ffffffffc02009cc:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009d0:	000407b7          	lui	a5,0x40
ffffffffc02009d4:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009d8:	8082                	ret

ffffffffc02009da <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009da:	610c                	ld	a1,0(a0)
{
ffffffffc02009dc:	1141                	addi	sp,sp,-16
ffffffffc02009de:	e022                	sd	s0,0(sp)
ffffffffc02009e0:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e2:	00005517          	auipc	a0,0x5
ffffffffc02009e6:	14e50513          	addi	a0,a0,334 # ffffffffc0205b30 <commands+0x1b8>
{
ffffffffc02009ea:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009ec:	ef4ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009f0:	640c                	ld	a1,8(s0)
ffffffffc02009f2:	00005517          	auipc	a0,0x5
ffffffffc02009f6:	15650513          	addi	a0,a0,342 # ffffffffc0205b48 <commands+0x1d0>
ffffffffc02009fa:	ee6ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009fe:	680c                	ld	a1,16(s0)
ffffffffc0200a00:	00005517          	auipc	a0,0x5
ffffffffc0200a04:	16050513          	addi	a0,a0,352 # ffffffffc0205b60 <commands+0x1e8>
ffffffffc0200a08:	ed8ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a0c:	6c0c                	ld	a1,24(s0)
ffffffffc0200a0e:	00005517          	auipc	a0,0x5
ffffffffc0200a12:	16a50513          	addi	a0,a0,362 # ffffffffc0205b78 <commands+0x200>
ffffffffc0200a16:	ecaff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a1a:	700c                	ld	a1,32(s0)
ffffffffc0200a1c:	00005517          	auipc	a0,0x5
ffffffffc0200a20:	17450513          	addi	a0,a0,372 # ffffffffc0205b90 <commands+0x218>
ffffffffc0200a24:	ebcff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a28:	740c                	ld	a1,40(s0)
ffffffffc0200a2a:	00005517          	auipc	a0,0x5
ffffffffc0200a2e:	17e50513          	addi	a0,a0,382 # ffffffffc0205ba8 <commands+0x230>
ffffffffc0200a32:	eaeff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a36:	780c                	ld	a1,48(s0)
ffffffffc0200a38:	00005517          	auipc	a0,0x5
ffffffffc0200a3c:	18850513          	addi	a0,a0,392 # ffffffffc0205bc0 <commands+0x248>
ffffffffc0200a40:	ea0ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a44:	7c0c                	ld	a1,56(s0)
ffffffffc0200a46:	00005517          	auipc	a0,0x5
ffffffffc0200a4a:	19250513          	addi	a0,a0,402 # ffffffffc0205bd8 <commands+0x260>
ffffffffc0200a4e:	e92ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a52:	602c                	ld	a1,64(s0)
ffffffffc0200a54:	00005517          	auipc	a0,0x5
ffffffffc0200a58:	19c50513          	addi	a0,a0,412 # ffffffffc0205bf0 <commands+0x278>
ffffffffc0200a5c:	e84ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a60:	642c                	ld	a1,72(s0)
ffffffffc0200a62:	00005517          	auipc	a0,0x5
ffffffffc0200a66:	1a650513          	addi	a0,a0,422 # ffffffffc0205c08 <commands+0x290>
ffffffffc0200a6a:	e76ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a6e:	682c                	ld	a1,80(s0)
ffffffffc0200a70:	00005517          	auipc	a0,0x5
ffffffffc0200a74:	1b050513          	addi	a0,a0,432 # ffffffffc0205c20 <commands+0x2a8>
ffffffffc0200a78:	e68ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a7c:	6c2c                	ld	a1,88(s0)
ffffffffc0200a7e:	00005517          	auipc	a0,0x5
ffffffffc0200a82:	1ba50513          	addi	a0,a0,442 # ffffffffc0205c38 <commands+0x2c0>
ffffffffc0200a86:	e5aff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a8a:	702c                	ld	a1,96(s0)
ffffffffc0200a8c:	00005517          	auipc	a0,0x5
ffffffffc0200a90:	1c450513          	addi	a0,a0,452 # ffffffffc0205c50 <commands+0x2d8>
ffffffffc0200a94:	e4cff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a98:	742c                	ld	a1,104(s0)
ffffffffc0200a9a:	00005517          	auipc	a0,0x5
ffffffffc0200a9e:	1ce50513          	addi	a0,a0,462 # ffffffffc0205c68 <commands+0x2f0>
ffffffffc0200aa2:	e3eff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200aa6:	782c                	ld	a1,112(s0)
ffffffffc0200aa8:	00005517          	auipc	a0,0x5
ffffffffc0200aac:	1d850513          	addi	a0,a0,472 # ffffffffc0205c80 <commands+0x308>
ffffffffc0200ab0:	e30ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200ab4:	7c2c                	ld	a1,120(s0)
ffffffffc0200ab6:	00005517          	auipc	a0,0x5
ffffffffc0200aba:	1e250513          	addi	a0,a0,482 # ffffffffc0205c98 <commands+0x320>
ffffffffc0200abe:	e22ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200ac2:	604c                	ld	a1,128(s0)
ffffffffc0200ac4:	00005517          	auipc	a0,0x5
ffffffffc0200ac8:	1ec50513          	addi	a0,a0,492 # ffffffffc0205cb0 <commands+0x338>
ffffffffc0200acc:	e14ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200ad0:	644c                	ld	a1,136(s0)
ffffffffc0200ad2:	00005517          	auipc	a0,0x5
ffffffffc0200ad6:	1f650513          	addi	a0,a0,502 # ffffffffc0205cc8 <commands+0x350>
ffffffffc0200ada:	e06ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ade:	684c                	ld	a1,144(s0)
ffffffffc0200ae0:	00005517          	auipc	a0,0x5
ffffffffc0200ae4:	20050513          	addi	a0,a0,512 # ffffffffc0205ce0 <commands+0x368>
ffffffffc0200ae8:	df8ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200aec:	6c4c                	ld	a1,152(s0)
ffffffffc0200aee:	00005517          	auipc	a0,0x5
ffffffffc0200af2:	20a50513          	addi	a0,a0,522 # ffffffffc0205cf8 <commands+0x380>
ffffffffc0200af6:	deaff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200afa:	704c                	ld	a1,160(s0)
ffffffffc0200afc:	00005517          	auipc	a0,0x5
ffffffffc0200b00:	21450513          	addi	a0,a0,532 # ffffffffc0205d10 <commands+0x398>
ffffffffc0200b04:	ddcff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200b08:	744c                	ld	a1,168(s0)
ffffffffc0200b0a:	00005517          	auipc	a0,0x5
ffffffffc0200b0e:	21e50513          	addi	a0,a0,542 # ffffffffc0205d28 <commands+0x3b0>
ffffffffc0200b12:	dceff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b16:	784c                	ld	a1,176(s0)
ffffffffc0200b18:	00005517          	auipc	a0,0x5
ffffffffc0200b1c:	22850513          	addi	a0,a0,552 # ffffffffc0205d40 <commands+0x3c8>
ffffffffc0200b20:	dc0ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b24:	7c4c                	ld	a1,184(s0)
ffffffffc0200b26:	00005517          	auipc	a0,0x5
ffffffffc0200b2a:	23250513          	addi	a0,a0,562 # ffffffffc0205d58 <commands+0x3e0>
ffffffffc0200b2e:	db2ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b32:	606c                	ld	a1,192(s0)
ffffffffc0200b34:	00005517          	auipc	a0,0x5
ffffffffc0200b38:	23c50513          	addi	a0,a0,572 # ffffffffc0205d70 <commands+0x3f8>
ffffffffc0200b3c:	da4ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b40:	646c                	ld	a1,200(s0)
ffffffffc0200b42:	00005517          	auipc	a0,0x5
ffffffffc0200b46:	24650513          	addi	a0,a0,582 # ffffffffc0205d88 <commands+0x410>
ffffffffc0200b4a:	d96ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b4e:	686c                	ld	a1,208(s0)
ffffffffc0200b50:	00005517          	auipc	a0,0x5
ffffffffc0200b54:	25050513          	addi	a0,a0,592 # ffffffffc0205da0 <commands+0x428>
ffffffffc0200b58:	d88ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b5c:	6c6c                	ld	a1,216(s0)
ffffffffc0200b5e:	00005517          	auipc	a0,0x5
ffffffffc0200b62:	25a50513          	addi	a0,a0,602 # ffffffffc0205db8 <commands+0x440>
ffffffffc0200b66:	d7aff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b6a:	706c                	ld	a1,224(s0)
ffffffffc0200b6c:	00005517          	auipc	a0,0x5
ffffffffc0200b70:	26450513          	addi	a0,a0,612 # ffffffffc0205dd0 <commands+0x458>
ffffffffc0200b74:	d6cff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b78:	746c                	ld	a1,232(s0)
ffffffffc0200b7a:	00005517          	auipc	a0,0x5
ffffffffc0200b7e:	26e50513          	addi	a0,a0,622 # ffffffffc0205de8 <commands+0x470>
ffffffffc0200b82:	d5eff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b86:	786c                	ld	a1,240(s0)
ffffffffc0200b88:	00005517          	auipc	a0,0x5
ffffffffc0200b8c:	27850513          	addi	a0,a0,632 # ffffffffc0205e00 <commands+0x488>
ffffffffc0200b90:	d50ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b94:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b96:	6402                	ld	s0,0(sp)
ffffffffc0200b98:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b9a:	00005517          	auipc	a0,0x5
ffffffffc0200b9e:	27e50513          	addi	a0,a0,638 # ffffffffc0205e18 <commands+0x4a0>
}
ffffffffc0200ba2:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200ba4:	d3cff06f          	j	ffffffffc02000e0 <cprintf>

ffffffffc0200ba8 <print_trapframe>:
{
ffffffffc0200ba8:	1141                	addi	sp,sp,-16
ffffffffc0200baa:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bac:	85aa                	mv	a1,a0
{
ffffffffc0200bae:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb0:	00005517          	auipc	a0,0x5
ffffffffc0200bb4:	28050513          	addi	a0,a0,640 # ffffffffc0205e30 <commands+0x4b8>
{
ffffffffc0200bb8:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bba:	d26ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bbe:	8522                	mv	a0,s0
ffffffffc0200bc0:	e1bff0ef          	jal	ra,ffffffffc02009da <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bc4:	10043583          	ld	a1,256(s0)
ffffffffc0200bc8:	00005517          	auipc	a0,0x5
ffffffffc0200bcc:	28050513          	addi	a0,a0,640 # ffffffffc0205e48 <commands+0x4d0>
ffffffffc0200bd0:	d10ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bd4:	10843583          	ld	a1,264(s0)
ffffffffc0200bd8:	00005517          	auipc	a0,0x5
ffffffffc0200bdc:	28850513          	addi	a0,a0,648 # ffffffffc0205e60 <commands+0x4e8>
ffffffffc0200be0:	d00ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200be4:	11043583          	ld	a1,272(s0)
ffffffffc0200be8:	00005517          	auipc	a0,0x5
ffffffffc0200bec:	29050513          	addi	a0,a0,656 # ffffffffc0205e78 <commands+0x500>
ffffffffc0200bf0:	cf0ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf4:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bf8:	6402                	ld	s0,0(sp)
ffffffffc0200bfa:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bfc:	00005517          	auipc	a0,0x5
ffffffffc0200c00:	28c50513          	addi	a0,a0,652 # ffffffffc0205e88 <commands+0x510>
}
ffffffffc0200c04:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200c06:	cdaff06f          	j	ffffffffc02000e0 <cprintf>

ffffffffc0200c0a <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c0a:	11853783          	ld	a5,280(a0)
ffffffffc0200c0e:	472d                	li	a4,11
ffffffffc0200c10:	0786                	slli	a5,a5,0x1
ffffffffc0200c12:	8385                	srli	a5,a5,0x1
ffffffffc0200c14:	06f76c63          	bltu	a4,a5,ffffffffc0200c8c <interrupt_handler+0x82>
ffffffffc0200c18:	00005717          	auipc	a4,0x5
ffffffffc0200c1c:	33870713          	addi	a4,a4,824 # ffffffffc0205f50 <commands+0x5d8>
ffffffffc0200c20:	078a                	slli	a5,a5,0x2
ffffffffc0200c22:	97ba                	add	a5,a5,a4
ffffffffc0200c24:	439c                	lw	a5,0(a5)
ffffffffc0200c26:	97ba                	add	a5,a5,a4
ffffffffc0200c28:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c2a:	00005517          	auipc	a0,0x5
ffffffffc0200c2e:	2d650513          	addi	a0,a0,726 # ffffffffc0205f00 <commands+0x588>
ffffffffc0200c32:	caeff06f          	j	ffffffffc02000e0 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c36:	00005517          	auipc	a0,0x5
ffffffffc0200c3a:	2aa50513          	addi	a0,a0,682 # ffffffffc0205ee0 <commands+0x568>
ffffffffc0200c3e:	ca2ff06f          	j	ffffffffc02000e0 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c42:	00005517          	auipc	a0,0x5
ffffffffc0200c46:	25e50513          	addi	a0,a0,606 # ffffffffc0205ea0 <commands+0x528>
ffffffffc0200c4a:	c96ff06f          	j	ffffffffc02000e0 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c4e:	00005517          	auipc	a0,0x5
ffffffffc0200c52:	27250513          	addi	a0,a0,626 # ffffffffc0205ec0 <commands+0x548>
ffffffffc0200c56:	c8aff06f          	j	ffffffffc02000e0 <cprintf>
{
ffffffffc0200c5a:	1141                	addi	sp,sp,-16
ffffffffc0200c5c:	e406                	sd	ra,8(sp)
        ; //case后要跟语句不能直接先声明，加上一个空语句
        static int ticks = 0; //计数当前未到TICK_NUM的中断数
        static int print_num = 0; //已经打印多少次“100 ticks”

        //(1)
        clock_set_next_event();
ffffffffc0200c5e:	cc9ff0ef          	jal	ra,ffffffffc0200926 <clock_set_next_event>
        //(2)
        ticks++;
ffffffffc0200c62:	000aa717          	auipc	a4,0xaa
ffffffffc0200c66:	a2270713          	addi	a4,a4,-1502 # ffffffffc02aa684 <ticks.1>
ffffffffc0200c6a:	431c                	lw	a5,0(a4)
        //(3)
        if(ticks >= TICK_NUM){
ffffffffc0200c6c:	06300693          	li	a3,99
        ticks++;
ffffffffc0200c70:	0017861b          	addiw	a2,a5,1
ffffffffc0200c74:	c310                	sw	a2,0(a4)
        if(ticks >= TICK_NUM){
ffffffffc0200c76:	00c6cc63          	blt	a3,a2,ffffffffc0200c8e <interrupt_handler+0x84>
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c7a:	60a2                	ld	ra,8(sp)
ffffffffc0200c7c:	0141                	addi	sp,sp,16
ffffffffc0200c7e:	8082                	ret
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c80:	00005517          	auipc	a0,0x5
ffffffffc0200c84:	2b050513          	addi	a0,a0,688 # ffffffffc0205f30 <commands+0x5b8>
ffffffffc0200c88:	c58ff06f          	j	ffffffffc02000e0 <cprintf>
        print_trapframe(tf);
ffffffffc0200c8c:	bf31                	j	ffffffffc0200ba8 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200c8e:	06400593          	li	a1,100
ffffffffc0200c92:	00005517          	auipc	a0,0x5
ffffffffc0200c96:	28e50513          	addi	a0,a0,654 # ffffffffc0205f20 <commands+0x5a8>
ffffffffc0200c9a:	c46ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
            print_num++;
ffffffffc0200c9e:	000aa717          	auipc	a4,0xaa
ffffffffc0200ca2:	9e270713          	addi	a4,a4,-1566 # ffffffffc02aa680 <print_num.0>
ffffffffc0200ca6:	431c                	lw	a5,0(a4)
            ticks = 0;
ffffffffc0200ca8:	000aa697          	auipc	a3,0xaa
ffffffffc0200cac:	9c06ae23          	sw	zero,-1572(a3) # ffffffffc02aa684 <ticks.1>
            if(current != NULL && current->state == PROC_RUNNABLE) {
ffffffffc0200cb0:	000aa697          	auipc	a3,0xaa
ffffffffc0200cb4:	a106b683          	ld	a3,-1520(a3) # ffffffffc02aa6c0 <current>
            print_num++;
ffffffffc0200cb8:	2785                	addiw	a5,a5,1
ffffffffc0200cba:	c31c                	sw	a5,0(a4)
            if(current != NULL && current->state == PROC_RUNNABLE) {
ffffffffc0200cbc:	c699                	beqz	a3,ffffffffc0200cca <interrupt_handler+0xc0>
ffffffffc0200cbe:	4290                	lw	a2,0(a3)
ffffffffc0200cc0:	4709                	li	a4,2
ffffffffc0200cc2:	00e61463          	bne	a2,a4,ffffffffc0200cca <interrupt_handler+0xc0>
                current->need_resched = 1;
ffffffffc0200cc6:	4705                	li	a4,1
ffffffffc0200cc8:	ee98                	sd	a4,24(a3)
            if(print_num == 10){
ffffffffc0200cca:	4729                	li	a4,10
ffffffffc0200ccc:	fae797e3          	bne	a5,a4,ffffffffc0200c7a <interrupt_handler+0x70>
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200cd0:	4501                	li	a0,0
ffffffffc0200cd2:	4581                	li	a1,0
ffffffffc0200cd4:	4601                	li	a2,0
ffffffffc0200cd6:	48a1                	li	a7,8
ffffffffc0200cd8:	00000073          	ecall
}
ffffffffc0200cdc:	bf79                	j	ffffffffc0200c7a <interrupt_handler+0x70>

ffffffffc0200cde <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200cde:	11853783          	ld	a5,280(a0)
{
ffffffffc0200ce2:	1141                	addi	sp,sp,-16
ffffffffc0200ce4:	e022                	sd	s0,0(sp)
ffffffffc0200ce6:	e406                	sd	ra,8(sp)
ffffffffc0200ce8:	473d                	li	a4,15
ffffffffc0200cea:	842a                	mv	s0,a0
ffffffffc0200cec:	0cf76463          	bltu	a4,a5,ffffffffc0200db4 <exception_handler+0xd6>
ffffffffc0200cf0:	00005717          	auipc	a4,0x5
ffffffffc0200cf4:	42070713          	addi	a4,a4,1056 # ffffffffc0206110 <commands+0x798>
ffffffffc0200cf8:	078a                	slli	a5,a5,0x2
ffffffffc0200cfa:	97ba                	add	a5,a5,a4
ffffffffc0200cfc:	439c                	lw	a5,0(a5)
ffffffffc0200cfe:	97ba                	add	a5,a5,a4
ffffffffc0200d00:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200d02:	00005517          	auipc	a0,0x5
ffffffffc0200d06:	36650513          	addi	a0,a0,870 # ffffffffc0206068 <commands+0x6f0>
ffffffffc0200d0a:	bd6ff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
        tf->epc += 4;
ffffffffc0200d0e:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200d12:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200d14:	0791                	addi	a5,a5,4
ffffffffc0200d16:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200d1a:	6402                	ld	s0,0(sp)
ffffffffc0200d1c:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200d1e:	4620406f          	j	ffffffffc0205180 <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200d22:	00005517          	auipc	a0,0x5
ffffffffc0200d26:	36650513          	addi	a0,a0,870 # ffffffffc0206088 <commands+0x710>
}
ffffffffc0200d2a:	6402                	ld	s0,0(sp)
ffffffffc0200d2c:	60a2                	ld	ra,8(sp)
ffffffffc0200d2e:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200d30:	bb0ff06f          	j	ffffffffc02000e0 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200d34:	00005517          	auipc	a0,0x5
ffffffffc0200d38:	37450513          	addi	a0,a0,884 # ffffffffc02060a8 <commands+0x730>
ffffffffc0200d3c:	b7fd                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200d3e:	00005517          	auipc	a0,0x5
ffffffffc0200d42:	38a50513          	addi	a0,a0,906 # ffffffffc02060c8 <commands+0x750>
ffffffffc0200d46:	b7d5                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d48:	00005517          	auipc	a0,0x5
ffffffffc0200d4c:	39850513          	addi	a0,a0,920 # ffffffffc02060e0 <commands+0x768>
ffffffffc0200d50:	bfe9                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d52:	00005517          	auipc	a0,0x5
ffffffffc0200d56:	3a650513          	addi	a0,a0,934 # ffffffffc02060f8 <commands+0x780>
ffffffffc0200d5a:	bfc1                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d5c:	00005517          	auipc	a0,0x5
ffffffffc0200d60:	22450513          	addi	a0,a0,548 # ffffffffc0205f80 <commands+0x608>
ffffffffc0200d64:	b7d9                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d66:	00005517          	auipc	a0,0x5
ffffffffc0200d6a:	23a50513          	addi	a0,a0,570 # ffffffffc0205fa0 <commands+0x628>
ffffffffc0200d6e:	bf75                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d70:	00005517          	auipc	a0,0x5
ffffffffc0200d74:	25050513          	addi	a0,a0,592 # ffffffffc0205fc0 <commands+0x648>
ffffffffc0200d78:	bf4d                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d7a:	00005517          	auipc	a0,0x5
ffffffffc0200d7e:	25e50513          	addi	a0,a0,606 # ffffffffc0205fd8 <commands+0x660>
ffffffffc0200d82:	b5eff0ef          	jal	ra,ffffffffc02000e0 <cprintf>
        if (tf->gpr.a7 == 10)
ffffffffc0200d86:	6458                	ld	a4,136(s0)
ffffffffc0200d88:	47a9                	li	a5,10
ffffffffc0200d8a:	04f70663          	beq	a4,a5,ffffffffc0200dd6 <exception_handler+0xf8>
}
ffffffffc0200d8e:	60a2                	ld	ra,8(sp)
ffffffffc0200d90:	6402                	ld	s0,0(sp)
ffffffffc0200d92:	0141                	addi	sp,sp,16
ffffffffc0200d94:	8082                	ret
        cprintf("Load address misaligned\n");
ffffffffc0200d96:	00005517          	auipc	a0,0x5
ffffffffc0200d9a:	25250513          	addi	a0,a0,594 # ffffffffc0205fe8 <commands+0x670>
ffffffffc0200d9e:	b771                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200da0:	00005517          	auipc	a0,0x5
ffffffffc0200da4:	26850513          	addi	a0,a0,616 # ffffffffc0206008 <commands+0x690>
ffffffffc0200da8:	b749                	j	ffffffffc0200d2a <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200daa:	00005517          	auipc	a0,0x5
ffffffffc0200dae:	2a650513          	addi	a0,a0,678 # ffffffffc0206050 <commands+0x6d8>
ffffffffc0200db2:	bfa5                	j	ffffffffc0200d2a <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200db4:	8522                	mv	a0,s0
}
ffffffffc0200db6:	6402                	ld	s0,0(sp)
ffffffffc0200db8:	60a2                	ld	ra,8(sp)
ffffffffc0200dba:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200dbc:	b3f5                	j	ffffffffc0200ba8 <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200dbe:	00005617          	auipc	a2,0x5
ffffffffc0200dc2:	26260613          	addi	a2,a2,610 # ffffffffc0206020 <commands+0x6a8>
ffffffffc0200dc6:	0ce00593          	li	a1,206
ffffffffc0200dca:	00005517          	auipc	a0,0x5
ffffffffc0200dce:	26e50513          	addi	a0,a0,622 # ffffffffc0206038 <commands+0x6c0>
ffffffffc0200dd2:	c4cff0ef          	jal	ra,ffffffffc020021e <__panic>
            tf->epc += 4;
ffffffffc0200dd6:	10843783          	ld	a5,264(s0)
ffffffffc0200dda:	0791                	addi	a5,a5,4
ffffffffc0200ddc:	10f43423          	sd	a5,264(s0)
            syscall();
ffffffffc0200de0:	3a0040ef          	jal	ra,ffffffffc0205180 <syscall>
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200de4:	000aa797          	auipc	a5,0xaa
ffffffffc0200de8:	8dc7b783          	ld	a5,-1828(a5) # ffffffffc02aa6c0 <current>
ffffffffc0200dec:	6b9c                	ld	a5,16(a5)
ffffffffc0200dee:	8522                	mv	a0,s0
}
ffffffffc0200df0:	6402                	ld	s0,0(sp)
ffffffffc0200df2:	60a2                	ld	ra,8(sp)
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200df4:	6589                	lui	a1,0x2
ffffffffc0200df6:	95be                	add	a1,a1,a5
}
ffffffffc0200df8:	0141                	addi	sp,sp,16
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dfa:	aab1                	j	ffffffffc0200f56 <kernel_execve_ret>

ffffffffc0200dfc <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200dfc:	1101                	addi	sp,sp,-32
ffffffffc0200dfe:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200e00:	000aa417          	auipc	s0,0xaa
ffffffffc0200e04:	8c040413          	addi	s0,s0,-1856 # ffffffffc02aa6c0 <current>
ffffffffc0200e08:	6018                	ld	a4,0(s0)
{
ffffffffc0200e0a:	ec06                	sd	ra,24(sp)
ffffffffc0200e0c:	e426                	sd	s1,8(sp)
ffffffffc0200e0e:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e10:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200e14:	cf1d                	beqz	a4,ffffffffc0200e52 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200e16:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200e1a:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200e1e:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200e20:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e24:	0206c463          	bltz	a3,ffffffffc0200e4c <trap+0x50>
        exception_handler(tf);
ffffffffc0200e28:	eb7ff0ef          	jal	ra,ffffffffc0200cde <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200e2c:	601c                	ld	a5,0(s0)
ffffffffc0200e2e:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200e32:	e499                	bnez	s1,ffffffffc0200e40 <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200e34:	0b07a703          	lw	a4,176(a5)
ffffffffc0200e38:	8b05                	andi	a4,a4,1
ffffffffc0200e3a:	e329                	bnez	a4,ffffffffc0200e7c <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200e3c:	6f9c                	ld	a5,24(a5)
ffffffffc0200e3e:	eb85                	bnez	a5,ffffffffc0200e6e <trap+0x72>
            {
                schedule();
            }
        }
    }
ffffffffc0200e40:	60e2                	ld	ra,24(sp)
ffffffffc0200e42:	6442                	ld	s0,16(sp)
ffffffffc0200e44:	64a2                	ld	s1,8(sp)
ffffffffc0200e46:	6902                	ld	s2,0(sp)
ffffffffc0200e48:	6105                	addi	sp,sp,32
ffffffffc0200e4a:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200e4c:	dbfff0ef          	jal	ra,ffffffffc0200c0a <interrupt_handler>
ffffffffc0200e50:	bff1                	j	ffffffffc0200e2c <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e52:	0006c863          	bltz	a3,ffffffffc0200e62 <trap+0x66>
ffffffffc0200e56:	6442                	ld	s0,16(sp)
ffffffffc0200e58:	60e2                	ld	ra,24(sp)
ffffffffc0200e5a:	64a2                	ld	s1,8(sp)
ffffffffc0200e5c:	6902                	ld	s2,0(sp)
ffffffffc0200e5e:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200e60:	bdbd                	j	ffffffffc0200cde <exception_handler>
ffffffffc0200e62:	6442                	ld	s0,16(sp)
ffffffffc0200e64:	60e2                	ld	ra,24(sp)
ffffffffc0200e66:	64a2                	ld	s1,8(sp)
ffffffffc0200e68:	6902                	ld	s2,0(sp)
ffffffffc0200e6a:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200e6c:	bb79                	j	ffffffffc0200c0a <interrupt_handler>
ffffffffc0200e6e:	6442                	ld	s0,16(sp)
ffffffffc0200e70:	60e2                	ld	ra,24(sp)
ffffffffc0200e72:	64a2                	ld	s1,8(sp)
ffffffffc0200e74:	6902                	ld	s2,0(sp)
ffffffffc0200e76:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e78:	21c0406f          	j	ffffffffc0205094 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e7c:	555d                	li	a0,-9
ffffffffc0200e7e:	5c6030ef          	jal	ra,ffffffffc0204444 <do_exit>
            if (current->need_resched)
ffffffffc0200e82:	601c                	ld	a5,0(s0)
ffffffffc0200e84:	bf65                	j	ffffffffc0200e3c <trap+0x40>
	...

ffffffffc0200e88 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e88:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e8c:	00011463          	bnez	sp,ffffffffc0200e94 <__alltraps+0xc>
ffffffffc0200e90:	14002173          	csrr	sp,sscratch
ffffffffc0200e94:	712d                	addi	sp,sp,-288
ffffffffc0200e96:	e002                	sd	zero,0(sp)
ffffffffc0200e98:	e406                	sd	ra,8(sp)
ffffffffc0200e9a:	ec0e                	sd	gp,24(sp)
ffffffffc0200e9c:	f012                	sd	tp,32(sp)
ffffffffc0200e9e:	f416                	sd	t0,40(sp)
ffffffffc0200ea0:	f81a                	sd	t1,48(sp)
ffffffffc0200ea2:	fc1e                	sd	t2,56(sp)
ffffffffc0200ea4:	e0a2                	sd	s0,64(sp)
ffffffffc0200ea6:	e4a6                	sd	s1,72(sp)
ffffffffc0200ea8:	e8aa                	sd	a0,80(sp)
ffffffffc0200eaa:	ecae                	sd	a1,88(sp)
ffffffffc0200eac:	f0b2                	sd	a2,96(sp)
ffffffffc0200eae:	f4b6                	sd	a3,104(sp)
ffffffffc0200eb0:	f8ba                	sd	a4,112(sp)
ffffffffc0200eb2:	fcbe                	sd	a5,120(sp)
ffffffffc0200eb4:	e142                	sd	a6,128(sp)
ffffffffc0200eb6:	e546                	sd	a7,136(sp)
ffffffffc0200eb8:	e94a                	sd	s2,144(sp)
ffffffffc0200eba:	ed4e                	sd	s3,152(sp)
ffffffffc0200ebc:	f152                	sd	s4,160(sp)
ffffffffc0200ebe:	f556                	sd	s5,168(sp)
ffffffffc0200ec0:	f95a                	sd	s6,176(sp)
ffffffffc0200ec2:	fd5e                	sd	s7,184(sp)
ffffffffc0200ec4:	e1e2                	sd	s8,192(sp)
ffffffffc0200ec6:	e5e6                	sd	s9,200(sp)
ffffffffc0200ec8:	e9ea                	sd	s10,208(sp)
ffffffffc0200eca:	edee                	sd	s11,216(sp)
ffffffffc0200ecc:	f1f2                	sd	t3,224(sp)
ffffffffc0200ece:	f5f6                	sd	t4,232(sp)
ffffffffc0200ed0:	f9fa                	sd	t5,240(sp)
ffffffffc0200ed2:	fdfe                	sd	t6,248(sp)
ffffffffc0200ed4:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200ed8:	100024f3          	csrr	s1,sstatus
ffffffffc0200edc:	14102973          	csrr	s2,sepc
ffffffffc0200ee0:	143029f3          	csrr	s3,stval
ffffffffc0200ee4:	14202a73          	csrr	s4,scause
ffffffffc0200ee8:	e822                	sd	s0,16(sp)
ffffffffc0200eea:	e226                	sd	s1,256(sp)
ffffffffc0200eec:	e64a                	sd	s2,264(sp)
ffffffffc0200eee:	ea4e                	sd	s3,272(sp)
ffffffffc0200ef0:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200ef2:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ef4:	f09ff0ef          	jal	ra,ffffffffc0200dfc <trap>

ffffffffc0200ef8 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200ef8:	6492                	ld	s1,256(sp)
ffffffffc0200efa:	6932                	ld	s2,264(sp)
ffffffffc0200efc:	1004f413          	andi	s0,s1,256
ffffffffc0200f00:	e401                	bnez	s0,ffffffffc0200f08 <__trapret+0x10>
ffffffffc0200f02:	1200                	addi	s0,sp,288
ffffffffc0200f04:	14041073          	csrw	sscratch,s0
ffffffffc0200f08:	10049073          	csrw	sstatus,s1
ffffffffc0200f0c:	14191073          	csrw	sepc,s2
ffffffffc0200f10:	60a2                	ld	ra,8(sp)
ffffffffc0200f12:	61e2                	ld	gp,24(sp)
ffffffffc0200f14:	7202                	ld	tp,32(sp)
ffffffffc0200f16:	72a2                	ld	t0,40(sp)
ffffffffc0200f18:	7342                	ld	t1,48(sp)
ffffffffc0200f1a:	73e2                	ld	t2,56(sp)
ffffffffc0200f1c:	6406                	ld	s0,64(sp)
ffffffffc0200f1e:	64a6                	ld	s1,72(sp)
ffffffffc0200f20:	6546                	ld	a0,80(sp)
ffffffffc0200f22:	65e6                	ld	a1,88(sp)
ffffffffc0200f24:	7606                	ld	a2,96(sp)
ffffffffc0200f26:	76a6                	ld	a3,104(sp)
ffffffffc0200f28:	7746                	ld	a4,112(sp)
ffffffffc0200f2a:	77e6                	ld	a5,120(sp)
ffffffffc0200f2c:	680a                	ld	a6,128(sp)
ffffffffc0200f2e:	68aa                	ld	a7,136(sp)
ffffffffc0200f30:	694a                	ld	s2,144(sp)
ffffffffc0200f32:	69ea                	ld	s3,152(sp)
ffffffffc0200f34:	7a0a                	ld	s4,160(sp)
ffffffffc0200f36:	7aaa                	ld	s5,168(sp)
ffffffffc0200f38:	7b4a                	ld	s6,176(sp)
ffffffffc0200f3a:	7bea                	ld	s7,184(sp)
ffffffffc0200f3c:	6c0e                	ld	s8,192(sp)
ffffffffc0200f3e:	6cae                	ld	s9,200(sp)
ffffffffc0200f40:	6d4e                	ld	s10,208(sp)
ffffffffc0200f42:	6dee                	ld	s11,216(sp)
ffffffffc0200f44:	7e0e                	ld	t3,224(sp)
ffffffffc0200f46:	7eae                	ld	t4,232(sp)
ffffffffc0200f48:	7f4e                	ld	t5,240(sp)
ffffffffc0200f4a:	7fee                	ld	t6,248(sp)
ffffffffc0200f4c:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200f4e:	10200073          	sret

ffffffffc0200f52 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200f52:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200f54:	b755                	j	ffffffffc0200ef8 <__trapret>

ffffffffc0200f56 <kernel_execve_ret>:

    .global kernel_execve_ret
kernel_execve_ret:
    // adjust sp to beneath kstacktop of current process
    addi a1, a1, -36*REGBYTES
ffffffffc0200f56:	ee058593          	addi	a1,a1,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cc8>

    // copy from previous trapframe to new trapframe
    LOAD s1, 35*REGBYTES(a0)
ffffffffc0200f5a:	11853483          	ld	s1,280(a0)
    STORE s1, 35*REGBYTES(a1)
ffffffffc0200f5e:	1095bc23          	sd	s1,280(a1)
    LOAD s1, 34*REGBYTES(a0)
ffffffffc0200f62:	11053483          	ld	s1,272(a0)
    STORE s1, 34*REGBYTES(a1)
ffffffffc0200f66:	1095b823          	sd	s1,272(a1)
    LOAD s1, 33*REGBYTES(a0)
ffffffffc0200f6a:	10853483          	ld	s1,264(a0)
    STORE s1, 33*REGBYTES(a1)
ffffffffc0200f6e:	1095b423          	sd	s1,264(a1)
    LOAD s1, 32*REGBYTES(a0)
ffffffffc0200f72:	10053483          	ld	s1,256(a0)
    STORE s1, 32*REGBYTES(a1)
ffffffffc0200f76:	1095b023          	sd	s1,256(a1)
    LOAD s1, 31*REGBYTES(a0)
ffffffffc0200f7a:	7d64                	ld	s1,248(a0)
    STORE s1, 31*REGBYTES(a1)
ffffffffc0200f7c:	fde4                	sd	s1,248(a1)
    LOAD s1, 30*REGBYTES(a0)
ffffffffc0200f7e:	7964                	ld	s1,240(a0)
    STORE s1, 30*REGBYTES(a1)
ffffffffc0200f80:	f9e4                	sd	s1,240(a1)
    LOAD s1, 29*REGBYTES(a0)
ffffffffc0200f82:	7564                	ld	s1,232(a0)
    STORE s1, 29*REGBYTES(a1)
ffffffffc0200f84:	f5e4                	sd	s1,232(a1)
    LOAD s1, 28*REGBYTES(a0)
ffffffffc0200f86:	7164                	ld	s1,224(a0)
    STORE s1, 28*REGBYTES(a1)
ffffffffc0200f88:	f1e4                	sd	s1,224(a1)
    LOAD s1, 27*REGBYTES(a0)
ffffffffc0200f8a:	6d64                	ld	s1,216(a0)
    STORE s1, 27*REGBYTES(a1)
ffffffffc0200f8c:	ede4                	sd	s1,216(a1)
    LOAD s1, 26*REGBYTES(a0)
ffffffffc0200f8e:	6964                	ld	s1,208(a0)
    STORE s1, 26*REGBYTES(a1)
ffffffffc0200f90:	e9e4                	sd	s1,208(a1)
    LOAD s1, 25*REGBYTES(a0)
ffffffffc0200f92:	6564                	ld	s1,200(a0)
    STORE s1, 25*REGBYTES(a1)
ffffffffc0200f94:	e5e4                	sd	s1,200(a1)
    LOAD s1, 24*REGBYTES(a0)
ffffffffc0200f96:	6164                	ld	s1,192(a0)
    STORE s1, 24*REGBYTES(a1)
ffffffffc0200f98:	e1e4                	sd	s1,192(a1)
    LOAD s1, 23*REGBYTES(a0)
ffffffffc0200f9a:	7d44                	ld	s1,184(a0)
    STORE s1, 23*REGBYTES(a1)
ffffffffc0200f9c:	fdc4                	sd	s1,184(a1)
    LOAD s1, 22*REGBYTES(a0)
ffffffffc0200f9e:	7944                	ld	s1,176(a0)
    STORE s1, 22*REGBYTES(a1)
ffffffffc0200fa0:	f9c4                	sd	s1,176(a1)
    LOAD s1, 21*REGBYTES(a0)
ffffffffc0200fa2:	7544                	ld	s1,168(a0)
    STORE s1, 21*REGBYTES(a1)
ffffffffc0200fa4:	f5c4                	sd	s1,168(a1)
    LOAD s1, 20*REGBYTES(a0)
ffffffffc0200fa6:	7144                	ld	s1,160(a0)
    STORE s1, 20*REGBYTES(a1)
ffffffffc0200fa8:	f1c4                	sd	s1,160(a1)
    LOAD s1, 19*REGBYTES(a0)
ffffffffc0200faa:	6d44                	ld	s1,152(a0)
    STORE s1, 19*REGBYTES(a1)
ffffffffc0200fac:	edc4                	sd	s1,152(a1)
    LOAD s1, 18*REGBYTES(a0)
ffffffffc0200fae:	6944                	ld	s1,144(a0)
    STORE s1, 18*REGBYTES(a1)
ffffffffc0200fb0:	e9c4                	sd	s1,144(a1)
    LOAD s1, 17*REGBYTES(a0)
ffffffffc0200fb2:	6544                	ld	s1,136(a0)
    STORE s1, 17*REGBYTES(a1)
ffffffffc0200fb4:	e5c4                	sd	s1,136(a1)
    LOAD s1, 16*REGBYTES(a0)
ffffffffc0200fb6:	6144                	ld	s1,128(a0)
    STORE s1, 16*REGBYTES(a1)
ffffffffc0200fb8:	e1c4                	sd	s1,128(a1)
    LOAD s1, 15*REGBYTES(a0)
ffffffffc0200fba:	7d24                	ld	s1,120(a0)
    STORE s1, 15*REGBYTES(a1)
ffffffffc0200fbc:	fda4                	sd	s1,120(a1)
    LOAD s1, 14*REGBYTES(a0)
ffffffffc0200fbe:	7924                	ld	s1,112(a0)
    STORE s1, 14*REGBYTES(a1)
ffffffffc0200fc0:	f9a4                	sd	s1,112(a1)
    LOAD s1, 13*REGBYTES(a0)
ffffffffc0200fc2:	7524                	ld	s1,104(a0)
    STORE s1, 13*REGBYTES(a1)
ffffffffc0200fc4:	f5a4                	sd	s1,104(a1)
    LOAD s1, 12*REGBYTES(a0)
ffffffffc0200fc6:	7124                	ld	s1,96(a0)
    STORE s1, 12*REGBYTES(a1)
ffffffffc0200fc8:	f1a4                	sd	s1,96(a1)
    LOAD s1, 11*REGBYTES(a0)
ffffffffc0200fca:	6d24                	ld	s1,88(a0)
    STORE s1, 11*REGBYTES(a1)
ffffffffc0200fcc:	eda4                	sd	s1,88(a1)
    LOAD s1, 10*REGBYTES(a0)
ffffffffc0200fce:	6924                	ld	s1,80(a0)
    STORE s1, 10*REGBYTES(a1)
ffffffffc0200fd0:	e9a4                	sd	s1,80(a1)
    LOAD s1, 9*REGBYTES(a0)
ffffffffc0200fd2:	6524                	ld	s1,72(a0)
    STORE s1, 9*REGBYTES(a1)
ffffffffc0200fd4:	e5a4                	sd	s1,72(a1)
    LOAD s1, 8*REGBYTES(a0)
ffffffffc0200fd6:	6124                	ld	s1,64(a0)
    STORE s1, 8*REGBYTES(a1)
ffffffffc0200fd8:	e1a4                	sd	s1,64(a1)
    LOAD s1, 7*REGBYTES(a0)
ffffffffc0200fda:	7d04                	ld	s1,56(a0)
    STORE s1, 7*REGBYTES(a1)
ffffffffc0200fdc:	fd84                	sd	s1,56(a1)
    LOAD s1, 6*REGBYTES(a0)
ffffffffc0200fde:	7904                	ld	s1,48(a0)
    STORE s1, 6*REGBYTES(a1)
ffffffffc0200fe0:	f984                	sd	s1,48(a1)
    LOAD s1, 5*REGBYTES(a0)
ffffffffc0200fe2:	7504                	ld	s1,40(a0)
    STORE s1, 5*REGBYTES(a1)
ffffffffc0200fe4:	f584                	sd	s1,40(a1)
    LOAD s1, 4*REGBYTES(a0)
ffffffffc0200fe6:	7104                	ld	s1,32(a0)
    STORE s1, 4*REGBYTES(a1)
ffffffffc0200fe8:	f184                	sd	s1,32(a1)
    LOAD s1, 3*REGBYTES(a0)
ffffffffc0200fea:	6d04                	ld	s1,24(a0)
    STORE s1, 3*REGBYTES(a1)
ffffffffc0200fec:	ed84                	sd	s1,24(a1)
    LOAD s1, 2*REGBYTES(a0)
ffffffffc0200fee:	6904                	ld	s1,16(a0)
    STORE s1, 2*REGBYTES(a1)
ffffffffc0200ff0:	e984                	sd	s1,16(a1)
    LOAD s1, 1*REGBYTES(a0)
ffffffffc0200ff2:	6504                	ld	s1,8(a0)
    STORE s1, 1*REGBYTES(a1)
ffffffffc0200ff4:	e584                	sd	s1,8(a1)
    LOAD s1, 0*REGBYTES(a0)
ffffffffc0200ff6:	6104                	ld	s1,0(a0)
    STORE s1, 0*REGBYTES(a1)
ffffffffc0200ff8:	e184                	sd	s1,0(a1)

    // acutually adjust sp
    move sp, a1
ffffffffc0200ffa:	812e                	mv	sp,a1
ffffffffc0200ffc:	bdf5                	j	ffffffffc0200ef8 <__trapret>

ffffffffc0200ffe <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc0200ffe:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0201000:	00005697          	auipc	a3,0x5
ffffffffc0201004:	15068693          	addi	a3,a3,336 # ffffffffc0206150 <commands+0x7d8>
ffffffffc0201008:	00005617          	auipc	a2,0x5
ffffffffc020100c:	16860613          	addi	a2,a2,360 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201010:	07400593          	li	a1,116
ffffffffc0201014:	00005517          	auipc	a0,0x5
ffffffffc0201018:	17450513          	addi	a0,a0,372 # ffffffffc0206188 <commands+0x810>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc020101c:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc020101e:	a00ff0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201022 <mm_create>:
{
ffffffffc0201022:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201024:	04000513          	li	a0,64
{
ffffffffc0201028:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc020102a:	135000ef          	jal	ra,ffffffffc020195e <kmalloc>
    if (mm != NULL)
ffffffffc020102e:	cd19                	beqz	a0,ffffffffc020104c <mm_create+0x2a>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0201030:	e508                	sd	a0,8(a0)
ffffffffc0201032:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0201034:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0201038:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc020103c:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc0201040:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc0201044:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc0201048:	02053c23          	sd	zero,56(a0)
}
ffffffffc020104c:	60a2                	ld	ra,8(sp)
ffffffffc020104e:	0141                	addi	sp,sp,16
ffffffffc0201050:	8082                	ret

ffffffffc0201052 <find_vma>:
{
ffffffffc0201052:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc0201054:	c505                	beqz	a0,ffffffffc020107c <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0201056:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0201058:	c501                	beqz	a0,ffffffffc0201060 <find_vma+0xe>
ffffffffc020105a:	651c                	ld	a5,8(a0)
ffffffffc020105c:	02f5f263          	bgeu	a1,a5,ffffffffc0201080 <find_vma+0x2e>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0201060:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc0201062:	00f68d63          	beq	a3,a5,ffffffffc020107c <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0201066:	fe87b703          	ld	a4,-24(a5)
ffffffffc020106a:	00e5e663          	bltu	a1,a4,ffffffffc0201076 <find_vma+0x24>
ffffffffc020106e:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201072:	00e5ec63          	bltu	a1,a4,ffffffffc020108a <find_vma+0x38>
ffffffffc0201076:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc0201078:	fef697e3          	bne	a3,a5,ffffffffc0201066 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc020107c:	4501                	li	a0,0
}
ffffffffc020107e:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0201080:	691c                	ld	a5,16(a0)
ffffffffc0201082:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201060 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0201086:	ea88                	sd	a0,16(a3)
ffffffffc0201088:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc020108a:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc020108e:	ea88                	sd	a0,16(a3)
ffffffffc0201090:	8082                	ret

ffffffffc0201092 <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201092:	6590                	ld	a2,8(a1)
ffffffffc0201094:	0105b803          	ld	a6,16(a1)
{
ffffffffc0201098:	1141                	addi	sp,sp,-16
ffffffffc020109a:	e406                	sd	ra,8(sp)
ffffffffc020109c:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc020109e:	01066763          	bltu	a2,a6,ffffffffc02010ac <insert_vma_struct+0x1a>
ffffffffc02010a2:	a085                	j	ffffffffc0201102 <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc02010a4:	fe87b703          	ld	a4,-24(a5)
ffffffffc02010a8:	04e66863          	bltu	a2,a4,ffffffffc02010f8 <insert_vma_struct+0x66>
ffffffffc02010ac:	86be                	mv	a3,a5
ffffffffc02010ae:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc02010b0:	fef51ae3          	bne	a0,a5,ffffffffc02010a4 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc02010b4:	02a68463          	beq	a3,a0,ffffffffc02010dc <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc02010b8:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc02010bc:	fe86b883          	ld	a7,-24(a3)
ffffffffc02010c0:	08e8f163          	bgeu	a7,a4,ffffffffc0201142 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02010c4:	04e66f63          	bltu	a2,a4,ffffffffc0201122 <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc02010c8:	00f50a63          	beq	a0,a5,ffffffffc02010dc <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc02010cc:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc02010d0:	05076963          	bltu	a4,a6,ffffffffc0201122 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc02010d4:	ff07b603          	ld	a2,-16(a5)
ffffffffc02010d8:	02c77363          	bgeu	a4,a2,ffffffffc02010fe <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc02010dc:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc02010de:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc02010e0:	02058613          	addi	a2,a1,32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02010e4:	e390                	sd	a2,0(a5)
ffffffffc02010e6:	e690                	sd	a2,8(a3)
}
ffffffffc02010e8:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc02010ea:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc02010ec:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc02010ee:	0017079b          	addiw	a5,a4,1
ffffffffc02010f2:	d11c                	sw	a5,32(a0)
}
ffffffffc02010f4:	0141                	addi	sp,sp,16
ffffffffc02010f6:	8082                	ret
    if (le_prev != list)
ffffffffc02010f8:	fca690e3          	bne	a3,a0,ffffffffc02010b8 <insert_vma_struct+0x26>
ffffffffc02010fc:	bfd1                	j	ffffffffc02010d0 <insert_vma_struct+0x3e>
ffffffffc02010fe:	f01ff0ef          	jal	ra,ffffffffc0200ffe <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201102:	00005697          	auipc	a3,0x5
ffffffffc0201106:	09668693          	addi	a3,a3,150 # ffffffffc0206198 <commands+0x820>
ffffffffc020110a:	00005617          	auipc	a2,0x5
ffffffffc020110e:	06660613          	addi	a2,a2,102 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201112:	07a00593          	li	a1,122
ffffffffc0201116:	00005517          	auipc	a0,0x5
ffffffffc020111a:	07250513          	addi	a0,a0,114 # ffffffffc0206188 <commands+0x810>
ffffffffc020111e:	900ff0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201122:	00005697          	auipc	a3,0x5
ffffffffc0201126:	0b668693          	addi	a3,a3,182 # ffffffffc02061d8 <commands+0x860>
ffffffffc020112a:	00005617          	auipc	a2,0x5
ffffffffc020112e:	04660613          	addi	a2,a2,70 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201132:	07300593          	li	a1,115
ffffffffc0201136:	00005517          	auipc	a0,0x5
ffffffffc020113a:	05250513          	addi	a0,a0,82 # ffffffffc0206188 <commands+0x810>
ffffffffc020113e:	8e0ff0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc0201142:	00005697          	auipc	a3,0x5
ffffffffc0201146:	07668693          	addi	a3,a3,118 # ffffffffc02061b8 <commands+0x840>
ffffffffc020114a:	00005617          	auipc	a2,0x5
ffffffffc020114e:	02660613          	addi	a2,a2,38 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201152:	07200593          	li	a1,114
ffffffffc0201156:	00005517          	auipc	a0,0x5
ffffffffc020115a:	03250513          	addi	a0,a0,50 # ffffffffc0206188 <commands+0x810>
ffffffffc020115e:	8c0ff0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201162 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc0201162:	591c                	lw	a5,48(a0)
{
ffffffffc0201164:	1141                	addi	sp,sp,-16
ffffffffc0201166:	e406                	sd	ra,8(sp)
ffffffffc0201168:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc020116a:	e78d                	bnez	a5,ffffffffc0201194 <mm_destroy+0x32>
ffffffffc020116c:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc020116e:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc0201170:	00a40c63          	beq	s0,a0,ffffffffc0201188 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0201174:	6118                	ld	a4,0(a0)
ffffffffc0201176:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc0201178:	1501                	addi	a0,a0,-32
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc020117a:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc020117c:	e398                	sd	a4,0(a5)
ffffffffc020117e:	091000ef          	jal	ra,ffffffffc0201a0e <kfree>
    return listelm->next;
ffffffffc0201182:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc0201184:	fea418e3          	bne	s0,a0,ffffffffc0201174 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc0201188:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc020118a:	6402                	ld	s0,0(sp)
ffffffffc020118c:	60a2                	ld	ra,8(sp)
ffffffffc020118e:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc0201190:	07f0006f          	j	ffffffffc0201a0e <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0201194:	00005697          	auipc	a3,0x5
ffffffffc0201198:	06468693          	addi	a3,a3,100 # ffffffffc02061f8 <commands+0x880>
ffffffffc020119c:	00005617          	auipc	a2,0x5
ffffffffc02011a0:	fd460613          	addi	a2,a2,-44 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02011a4:	09e00593          	li	a1,158
ffffffffc02011a8:	00005517          	auipc	a0,0x5
ffffffffc02011ac:	fe050513          	addi	a0,a0,-32 # ffffffffc0206188 <commands+0x810>
ffffffffc02011b0:	86eff0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02011b4 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc02011b4:	7139                	addi	sp,sp,-64
ffffffffc02011b6:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02011b8:	6405                	lui	s0,0x1
ffffffffc02011ba:	147d                	addi	s0,s0,-1
ffffffffc02011bc:	77fd                	lui	a5,0xfffff
ffffffffc02011be:	9622                	add	a2,a2,s0
ffffffffc02011c0:	962e                	add	a2,a2,a1
{
ffffffffc02011c2:	f426                	sd	s1,40(sp)
ffffffffc02011c4:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02011c6:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc02011ca:	f04a                	sd	s2,32(sp)
ffffffffc02011cc:	ec4e                	sd	s3,24(sp)
ffffffffc02011ce:	e852                	sd	s4,16(sp)
ffffffffc02011d0:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc02011d2:	002005b7          	lui	a1,0x200
ffffffffc02011d6:	00f67433          	and	s0,a2,a5
ffffffffc02011da:	06b4e363          	bltu	s1,a1,ffffffffc0201240 <mm_map+0x8c>
ffffffffc02011de:	0684f163          	bgeu	s1,s0,ffffffffc0201240 <mm_map+0x8c>
ffffffffc02011e2:	4785                	li	a5,1
ffffffffc02011e4:	07fe                	slli	a5,a5,0x1f
ffffffffc02011e6:	0487ed63          	bltu	a5,s0,ffffffffc0201240 <mm_map+0x8c>
ffffffffc02011ea:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc02011ec:	cd21                	beqz	a0,ffffffffc0201244 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc02011ee:	85a6                	mv	a1,s1
ffffffffc02011f0:	8ab6                	mv	s5,a3
ffffffffc02011f2:	8a3a                	mv	s4,a4
ffffffffc02011f4:	e5fff0ef          	jal	ra,ffffffffc0201052 <find_vma>
ffffffffc02011f8:	c501                	beqz	a0,ffffffffc0201200 <mm_map+0x4c>
ffffffffc02011fa:	651c                	ld	a5,8(a0)
ffffffffc02011fc:	0487e263          	bltu	a5,s0,ffffffffc0201240 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201200:	03000513          	li	a0,48
ffffffffc0201204:	75a000ef          	jal	ra,ffffffffc020195e <kmalloc>
ffffffffc0201208:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc020120a:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc020120c:	02090163          	beqz	s2,ffffffffc020122e <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0201210:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc0201212:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0201216:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc020121a:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc020121e:	85ca                	mv	a1,s2
ffffffffc0201220:	e73ff0ef          	jal	ra,ffffffffc0201092 <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0201224:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc0201226:	000a0463          	beqz	s4,ffffffffc020122e <mm_map+0x7a>
        *vma_store = vma;
ffffffffc020122a:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc020122e:	70e2                	ld	ra,56(sp)
ffffffffc0201230:	7442                	ld	s0,48(sp)
ffffffffc0201232:	74a2                	ld	s1,40(sp)
ffffffffc0201234:	7902                	ld	s2,32(sp)
ffffffffc0201236:	69e2                	ld	s3,24(sp)
ffffffffc0201238:	6a42                	ld	s4,16(sp)
ffffffffc020123a:	6aa2                	ld	s5,8(sp)
ffffffffc020123c:	6121                	addi	sp,sp,64
ffffffffc020123e:	8082                	ret
        return -E_INVAL;
ffffffffc0201240:	5575                	li	a0,-3
ffffffffc0201242:	b7f5                	j	ffffffffc020122e <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0201244:	00005697          	auipc	a3,0x5
ffffffffc0201248:	fcc68693          	addi	a3,a3,-52 # ffffffffc0206210 <commands+0x898>
ffffffffc020124c:	00005617          	auipc	a2,0x5
ffffffffc0201250:	f2460613          	addi	a2,a2,-220 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201254:	0b300593          	li	a1,179
ffffffffc0201258:	00005517          	auipc	a0,0x5
ffffffffc020125c:	f3050513          	addi	a0,a0,-208 # ffffffffc0206188 <commands+0x810>
ffffffffc0201260:	fbffe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201264 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc0201264:	7139                	addi	sp,sp,-64
ffffffffc0201266:	fc06                	sd	ra,56(sp)
ffffffffc0201268:	f822                	sd	s0,48(sp)
ffffffffc020126a:	f426                	sd	s1,40(sp)
ffffffffc020126c:	f04a                	sd	s2,32(sp)
ffffffffc020126e:	ec4e                	sd	s3,24(sp)
ffffffffc0201270:	e852                	sd	s4,16(sp)
ffffffffc0201272:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0201274:	c52d                	beqz	a0,ffffffffc02012de <dup_mmap+0x7a>
ffffffffc0201276:	892a                	mv	s2,a0
ffffffffc0201278:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc020127a:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc020127c:	e595                	bnez	a1,ffffffffc02012a8 <dup_mmap+0x44>
ffffffffc020127e:	a085                	j	ffffffffc02012de <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0201280:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0201282:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_exit_out_size+0x1f4ef0>
        vma->vm_end = vm_end;
ffffffffc0201286:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc020128a:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc020128e:	e05ff0ef          	jal	ra,ffffffffc0201092 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc0201292:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8bb8>
ffffffffc0201296:	fe843603          	ld	a2,-24(s0)
ffffffffc020129a:	6c8c                	ld	a1,24(s1)
ffffffffc020129c:	01893503          	ld	a0,24(s2)
ffffffffc02012a0:	4701                	li	a4,0
ffffffffc02012a2:	027020ef          	jal	ra,ffffffffc0203ac8 <copy_range>
ffffffffc02012a6:	e105                	bnez	a0,ffffffffc02012c6 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc02012a8:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc02012aa:	02848863          	beq	s1,s0,ffffffffc02012da <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02012ae:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc02012b2:	fe843a83          	ld	s5,-24(s0)
ffffffffc02012b6:	ff043a03          	ld	s4,-16(s0)
ffffffffc02012ba:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02012be:	6a0000ef          	jal	ra,ffffffffc020195e <kmalloc>
ffffffffc02012c2:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc02012c4:	fd55                	bnez	a0,ffffffffc0201280 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc02012c6:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc02012c8:	70e2                	ld	ra,56(sp)
ffffffffc02012ca:	7442                	ld	s0,48(sp)
ffffffffc02012cc:	74a2                	ld	s1,40(sp)
ffffffffc02012ce:	7902                	ld	s2,32(sp)
ffffffffc02012d0:	69e2                	ld	s3,24(sp)
ffffffffc02012d2:	6a42                	ld	s4,16(sp)
ffffffffc02012d4:	6aa2                	ld	s5,8(sp)
ffffffffc02012d6:	6121                	addi	sp,sp,64
ffffffffc02012d8:	8082                	ret
    return 0;
ffffffffc02012da:	4501                	li	a0,0
ffffffffc02012dc:	b7f5                	j	ffffffffc02012c8 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc02012de:	00005697          	auipc	a3,0x5
ffffffffc02012e2:	f4268693          	addi	a3,a3,-190 # ffffffffc0206220 <commands+0x8a8>
ffffffffc02012e6:	00005617          	auipc	a2,0x5
ffffffffc02012ea:	e8a60613          	addi	a2,a2,-374 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02012ee:	0cf00593          	li	a1,207
ffffffffc02012f2:	00005517          	auipc	a0,0x5
ffffffffc02012f6:	e9650513          	addi	a0,a0,-362 # ffffffffc0206188 <commands+0x810>
ffffffffc02012fa:	f25fe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02012fe <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc02012fe:	1101                	addi	sp,sp,-32
ffffffffc0201300:	ec06                	sd	ra,24(sp)
ffffffffc0201302:	e822                	sd	s0,16(sp)
ffffffffc0201304:	e426                	sd	s1,8(sp)
ffffffffc0201306:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201308:	c531                	beqz	a0,ffffffffc0201354 <exit_mmap+0x56>
ffffffffc020130a:	591c                	lw	a5,48(a0)
ffffffffc020130c:	84aa                	mv	s1,a0
ffffffffc020130e:	e3b9                	bnez	a5,ffffffffc0201354 <exit_mmap+0x56>
    return listelm->next;
ffffffffc0201310:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc0201312:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc0201316:	02850663          	beq	a0,s0,ffffffffc0201342 <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc020131a:	ff043603          	ld	a2,-16(s0)
ffffffffc020131e:	fe843583          	ld	a1,-24(s0)
ffffffffc0201322:	854a                	mv	a0,s2
ffffffffc0201324:	5fa010ef          	jal	ra,ffffffffc020291e <unmap_range>
ffffffffc0201328:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc020132a:	fe8498e3          	bne	s1,s0,ffffffffc020131a <exit_mmap+0x1c>
ffffffffc020132e:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc0201330:	00848c63          	beq	s1,s0,ffffffffc0201348 <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201334:	ff043603          	ld	a2,-16(s0)
ffffffffc0201338:	fe843583          	ld	a1,-24(s0)
ffffffffc020133c:	854a                	mv	a0,s2
ffffffffc020133e:	726010ef          	jal	ra,ffffffffc0202a64 <exit_range>
ffffffffc0201342:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc0201344:	fe8498e3          	bne	s1,s0,ffffffffc0201334 <exit_mmap+0x36>
    }
}
ffffffffc0201348:	60e2                	ld	ra,24(sp)
ffffffffc020134a:	6442                	ld	s0,16(sp)
ffffffffc020134c:	64a2                	ld	s1,8(sp)
ffffffffc020134e:	6902                	ld	s2,0(sp)
ffffffffc0201350:	6105                	addi	sp,sp,32
ffffffffc0201352:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201354:	00005697          	auipc	a3,0x5
ffffffffc0201358:	eec68693          	addi	a3,a3,-276 # ffffffffc0206240 <commands+0x8c8>
ffffffffc020135c:	00005617          	auipc	a2,0x5
ffffffffc0201360:	e1460613          	addi	a2,a2,-492 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201364:	0e800593          	li	a1,232
ffffffffc0201368:	00005517          	auipc	a0,0x5
ffffffffc020136c:	e2050513          	addi	a0,a0,-480 # ffffffffc0206188 <commands+0x810>
ffffffffc0201370:	eaffe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201374 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0201374:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201376:	04000513          	li	a0,64
{
ffffffffc020137a:	fc06                	sd	ra,56(sp)
ffffffffc020137c:	f822                	sd	s0,48(sp)
ffffffffc020137e:	f426                	sd	s1,40(sp)
ffffffffc0201380:	f04a                	sd	s2,32(sp)
ffffffffc0201382:	ec4e                	sd	s3,24(sp)
ffffffffc0201384:	e852                	sd	s4,16(sp)
ffffffffc0201386:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201388:	5d6000ef          	jal	ra,ffffffffc020195e <kmalloc>
    if (mm != NULL)
ffffffffc020138c:	2e050663          	beqz	a0,ffffffffc0201678 <vmm_init+0x304>
ffffffffc0201390:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc0201392:	e508                	sd	a0,8(a0)
ffffffffc0201394:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0201396:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc020139a:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc020139e:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02013a2:	02053423          	sd	zero,40(a0)
ffffffffc02013a6:	02052823          	sw	zero,48(a0)
ffffffffc02013aa:	02053c23          	sd	zero,56(a0)
ffffffffc02013ae:	03200413          	li	s0,50
ffffffffc02013b2:	a811                	j	ffffffffc02013c6 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc02013b4:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc02013b6:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc02013b8:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc02013bc:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc02013be:	8526                	mv	a0,s1
ffffffffc02013c0:	cd3ff0ef          	jal	ra,ffffffffc0201092 <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc02013c4:	c80d                	beqz	s0,ffffffffc02013f6 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02013c6:	03000513          	li	a0,48
ffffffffc02013ca:	594000ef          	jal	ra,ffffffffc020195e <kmalloc>
ffffffffc02013ce:	85aa                	mv	a1,a0
ffffffffc02013d0:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc02013d4:	f165                	bnez	a0,ffffffffc02013b4 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc02013d6:	00005697          	auipc	a3,0x5
ffffffffc02013da:	00268693          	addi	a3,a3,2 # ffffffffc02063d8 <commands+0xa60>
ffffffffc02013de:	00005617          	auipc	a2,0x5
ffffffffc02013e2:	d9260613          	addi	a2,a2,-622 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02013e6:	12c00593          	li	a1,300
ffffffffc02013ea:	00005517          	auipc	a0,0x5
ffffffffc02013ee:	d9e50513          	addi	a0,a0,-610 # ffffffffc0206188 <commands+0x810>
ffffffffc02013f2:	e2dfe0ef          	jal	ra,ffffffffc020021e <__panic>
ffffffffc02013f6:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc02013fa:	1f900913          	li	s2,505
ffffffffc02013fe:	a819                	j	ffffffffc0201414 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc0201400:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0201402:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0201404:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0201408:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc020140a:	8526                	mv	a0,s1
ffffffffc020140c:	c87ff0ef          	jal	ra,ffffffffc0201092 <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0201410:	03240a63          	beq	s0,s2,ffffffffc0201444 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201414:	03000513          	li	a0,48
ffffffffc0201418:	546000ef          	jal	ra,ffffffffc020195e <kmalloc>
ffffffffc020141c:	85aa                	mv	a1,a0
ffffffffc020141e:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0201422:	fd79                	bnez	a0,ffffffffc0201400 <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0201424:	00005697          	auipc	a3,0x5
ffffffffc0201428:	fb468693          	addi	a3,a3,-76 # ffffffffc02063d8 <commands+0xa60>
ffffffffc020142c:	00005617          	auipc	a2,0x5
ffffffffc0201430:	d4460613          	addi	a2,a2,-700 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201434:	13300593          	li	a1,307
ffffffffc0201438:	00005517          	auipc	a0,0x5
ffffffffc020143c:	d5050513          	addi	a0,a0,-688 # ffffffffc0206188 <commands+0x810>
ffffffffc0201440:	ddffe0ef          	jal	ra,ffffffffc020021e <__panic>
    return listelm->next;
ffffffffc0201444:	649c                	ld	a5,8(s1)
ffffffffc0201446:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0201448:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc020144c:	16f48663          	beq	s1,a5,ffffffffc02015b8 <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0201450:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd5490c>
ffffffffc0201454:	ffe70693          	addi	a3,a4,-2
ffffffffc0201458:	10d61063          	bne	a2,a3,ffffffffc0201558 <vmm_init+0x1e4>
ffffffffc020145c:	ff07b683          	ld	a3,-16(a5)
ffffffffc0201460:	0ed71c63          	bne	a4,a3,ffffffffc0201558 <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0201464:	0715                	addi	a4,a4,5
ffffffffc0201466:	679c                	ld	a5,8(a5)
ffffffffc0201468:	feb712e3          	bne	a4,a1,ffffffffc020144c <vmm_init+0xd8>
ffffffffc020146c:	4a1d                	li	s4,7
ffffffffc020146e:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0201470:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0201474:	85a2                	mv	a1,s0
ffffffffc0201476:	8526                	mv	a0,s1
ffffffffc0201478:	bdbff0ef          	jal	ra,ffffffffc0201052 <find_vma>
ffffffffc020147c:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc020147e:	16050d63          	beqz	a0,ffffffffc02015f8 <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0201482:	00140593          	addi	a1,s0,1
ffffffffc0201486:	8526                	mv	a0,s1
ffffffffc0201488:	bcbff0ef          	jal	ra,ffffffffc0201052 <find_vma>
ffffffffc020148c:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc020148e:	14050563          	beqz	a0,ffffffffc02015d8 <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0201492:	85d2                	mv	a1,s4
ffffffffc0201494:	8526                	mv	a0,s1
ffffffffc0201496:	bbdff0ef          	jal	ra,ffffffffc0201052 <find_vma>
        assert(vma3 == NULL);
ffffffffc020149a:	16051f63          	bnez	a0,ffffffffc0201618 <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc020149e:	00340593          	addi	a1,s0,3
ffffffffc02014a2:	8526                	mv	a0,s1
ffffffffc02014a4:	bafff0ef          	jal	ra,ffffffffc0201052 <find_vma>
        assert(vma4 == NULL);
ffffffffc02014a8:	1a051863          	bnez	a0,ffffffffc0201658 <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc02014ac:	00440593          	addi	a1,s0,4
ffffffffc02014b0:	8526                	mv	a0,s1
ffffffffc02014b2:	ba1ff0ef          	jal	ra,ffffffffc0201052 <find_vma>
        assert(vma5 == NULL);
ffffffffc02014b6:	18051163          	bnez	a0,ffffffffc0201638 <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc02014ba:	00893783          	ld	a5,8(s2)
ffffffffc02014be:	0a879d63          	bne	a5,s0,ffffffffc0201578 <vmm_init+0x204>
ffffffffc02014c2:	01093783          	ld	a5,16(s2)
ffffffffc02014c6:	0b479963          	bne	a5,s4,ffffffffc0201578 <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc02014ca:	0089b783          	ld	a5,8(s3)
ffffffffc02014ce:	0c879563          	bne	a5,s0,ffffffffc0201598 <vmm_init+0x224>
ffffffffc02014d2:	0109b783          	ld	a5,16(s3)
ffffffffc02014d6:	0d479163          	bne	a5,s4,ffffffffc0201598 <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc02014da:	0415                	addi	s0,s0,5
ffffffffc02014dc:	0a15                	addi	s4,s4,5
ffffffffc02014de:	f9541be3          	bne	s0,s5,ffffffffc0201474 <vmm_init+0x100>
ffffffffc02014e2:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc02014e4:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc02014e6:	85a2                	mv	a1,s0
ffffffffc02014e8:	8526                	mv	a0,s1
ffffffffc02014ea:	b69ff0ef          	jal	ra,ffffffffc0201052 <find_vma>
ffffffffc02014ee:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc02014f2:	c90d                	beqz	a0,ffffffffc0201524 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc02014f4:	6914                	ld	a3,16(a0)
ffffffffc02014f6:	6510                	ld	a2,8(a0)
ffffffffc02014f8:	00005517          	auipc	a0,0x5
ffffffffc02014fc:	e6850513          	addi	a0,a0,-408 # ffffffffc0206360 <commands+0x9e8>
ffffffffc0201500:	be1fe0ef          	jal	ra,ffffffffc02000e0 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0201504:	00005697          	auipc	a3,0x5
ffffffffc0201508:	e8468693          	addi	a3,a3,-380 # ffffffffc0206388 <commands+0xa10>
ffffffffc020150c:	00005617          	auipc	a2,0x5
ffffffffc0201510:	c6460613          	addi	a2,a2,-924 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201514:	15900593          	li	a1,345
ffffffffc0201518:	00005517          	auipc	a0,0x5
ffffffffc020151c:	c7050513          	addi	a0,a0,-912 # ffffffffc0206188 <commands+0x810>
ffffffffc0201520:	cfffe0ef          	jal	ra,ffffffffc020021e <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0201524:	147d                	addi	s0,s0,-1
ffffffffc0201526:	fd2410e3          	bne	s0,s2,ffffffffc02014e6 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc020152a:	8526                	mv	a0,s1
ffffffffc020152c:	c37ff0ef          	jal	ra,ffffffffc0201162 <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0201530:	00005517          	auipc	a0,0x5
ffffffffc0201534:	e7050513          	addi	a0,a0,-400 # ffffffffc02063a0 <commands+0xa28>
ffffffffc0201538:	ba9fe0ef          	jal	ra,ffffffffc02000e0 <cprintf>
}
ffffffffc020153c:	7442                	ld	s0,48(sp)
ffffffffc020153e:	70e2                	ld	ra,56(sp)
ffffffffc0201540:	74a2                	ld	s1,40(sp)
ffffffffc0201542:	7902                	ld	s2,32(sp)
ffffffffc0201544:	69e2                	ld	s3,24(sp)
ffffffffc0201546:	6a42                	ld	s4,16(sp)
ffffffffc0201548:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc020154a:	00005517          	auipc	a0,0x5
ffffffffc020154e:	e7650513          	addi	a0,a0,-394 # ffffffffc02063c0 <commands+0xa48>
}
ffffffffc0201552:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0201554:	b8dfe06f          	j	ffffffffc02000e0 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0201558:	00005697          	auipc	a3,0x5
ffffffffc020155c:	d2068693          	addi	a3,a3,-736 # ffffffffc0206278 <commands+0x900>
ffffffffc0201560:	00005617          	auipc	a2,0x5
ffffffffc0201564:	c1060613          	addi	a2,a2,-1008 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201568:	13d00593          	li	a1,317
ffffffffc020156c:	00005517          	auipc	a0,0x5
ffffffffc0201570:	c1c50513          	addi	a0,a0,-996 # ffffffffc0206188 <commands+0x810>
ffffffffc0201574:	cabfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0201578:	00005697          	auipc	a3,0x5
ffffffffc020157c:	d8868693          	addi	a3,a3,-632 # ffffffffc0206300 <commands+0x988>
ffffffffc0201580:	00005617          	auipc	a2,0x5
ffffffffc0201584:	bf060613          	addi	a2,a2,-1040 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201588:	14e00593          	li	a1,334
ffffffffc020158c:	00005517          	auipc	a0,0x5
ffffffffc0201590:	bfc50513          	addi	a0,a0,-1028 # ffffffffc0206188 <commands+0x810>
ffffffffc0201594:	c8bfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0201598:	00005697          	auipc	a3,0x5
ffffffffc020159c:	d9868693          	addi	a3,a3,-616 # ffffffffc0206330 <commands+0x9b8>
ffffffffc02015a0:	00005617          	auipc	a2,0x5
ffffffffc02015a4:	bd060613          	addi	a2,a2,-1072 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02015a8:	14f00593          	li	a1,335
ffffffffc02015ac:	00005517          	auipc	a0,0x5
ffffffffc02015b0:	bdc50513          	addi	a0,a0,-1060 # ffffffffc0206188 <commands+0x810>
ffffffffc02015b4:	c6bfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc02015b8:	00005697          	auipc	a3,0x5
ffffffffc02015bc:	ca868693          	addi	a3,a3,-856 # ffffffffc0206260 <commands+0x8e8>
ffffffffc02015c0:	00005617          	auipc	a2,0x5
ffffffffc02015c4:	bb060613          	addi	a2,a2,-1104 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02015c8:	13b00593          	li	a1,315
ffffffffc02015cc:	00005517          	auipc	a0,0x5
ffffffffc02015d0:	bbc50513          	addi	a0,a0,-1092 # ffffffffc0206188 <commands+0x810>
ffffffffc02015d4:	c4bfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma2 != NULL);
ffffffffc02015d8:	00005697          	auipc	a3,0x5
ffffffffc02015dc:	ce868693          	addi	a3,a3,-792 # ffffffffc02062c0 <commands+0x948>
ffffffffc02015e0:	00005617          	auipc	a2,0x5
ffffffffc02015e4:	b9060613          	addi	a2,a2,-1136 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02015e8:	14600593          	li	a1,326
ffffffffc02015ec:	00005517          	auipc	a0,0x5
ffffffffc02015f0:	b9c50513          	addi	a0,a0,-1124 # ffffffffc0206188 <commands+0x810>
ffffffffc02015f4:	c2bfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma1 != NULL);
ffffffffc02015f8:	00005697          	auipc	a3,0x5
ffffffffc02015fc:	cb868693          	addi	a3,a3,-840 # ffffffffc02062b0 <commands+0x938>
ffffffffc0201600:	00005617          	auipc	a2,0x5
ffffffffc0201604:	b7060613          	addi	a2,a2,-1168 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201608:	14400593          	li	a1,324
ffffffffc020160c:	00005517          	auipc	a0,0x5
ffffffffc0201610:	b7c50513          	addi	a0,a0,-1156 # ffffffffc0206188 <commands+0x810>
ffffffffc0201614:	c0bfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma3 == NULL);
ffffffffc0201618:	00005697          	auipc	a3,0x5
ffffffffc020161c:	cb868693          	addi	a3,a3,-840 # ffffffffc02062d0 <commands+0x958>
ffffffffc0201620:	00005617          	auipc	a2,0x5
ffffffffc0201624:	b5060613          	addi	a2,a2,-1200 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201628:	14800593          	li	a1,328
ffffffffc020162c:	00005517          	auipc	a0,0x5
ffffffffc0201630:	b5c50513          	addi	a0,a0,-1188 # ffffffffc0206188 <commands+0x810>
ffffffffc0201634:	bebfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma5 == NULL);
ffffffffc0201638:	00005697          	auipc	a3,0x5
ffffffffc020163c:	cb868693          	addi	a3,a3,-840 # ffffffffc02062f0 <commands+0x978>
ffffffffc0201640:	00005617          	auipc	a2,0x5
ffffffffc0201644:	b3060613          	addi	a2,a2,-1232 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201648:	14c00593          	li	a1,332
ffffffffc020164c:	00005517          	auipc	a0,0x5
ffffffffc0201650:	b3c50513          	addi	a0,a0,-1220 # ffffffffc0206188 <commands+0x810>
ffffffffc0201654:	bcbfe0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(vma4 == NULL);
ffffffffc0201658:	00005697          	auipc	a3,0x5
ffffffffc020165c:	c8868693          	addi	a3,a3,-888 # ffffffffc02062e0 <commands+0x968>
ffffffffc0201660:	00005617          	auipc	a2,0x5
ffffffffc0201664:	b1060613          	addi	a2,a2,-1264 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201668:	14a00593          	li	a1,330
ffffffffc020166c:	00005517          	auipc	a0,0x5
ffffffffc0201670:	b1c50513          	addi	a0,a0,-1252 # ffffffffc0206188 <commands+0x810>
ffffffffc0201674:	babfe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(mm != NULL);
ffffffffc0201678:	00005697          	auipc	a3,0x5
ffffffffc020167c:	b9868693          	addi	a3,a3,-1128 # ffffffffc0206210 <commands+0x898>
ffffffffc0201680:	00005617          	auipc	a2,0x5
ffffffffc0201684:	af060613          	addi	a2,a2,-1296 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201688:	12400593          	li	a1,292
ffffffffc020168c:	00005517          	auipc	a0,0x5
ffffffffc0201690:	afc50513          	addi	a0,a0,-1284 # ffffffffc0206188 <commands+0x810>
ffffffffc0201694:	b8bfe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201698 <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0201698:	7179                	addi	sp,sp,-48
ffffffffc020169a:	f022                	sd	s0,32(sp)
ffffffffc020169c:	f406                	sd	ra,40(sp)
ffffffffc020169e:	ec26                	sd	s1,24(sp)
ffffffffc02016a0:	e84a                	sd	s2,16(sp)
ffffffffc02016a2:	e44e                	sd	s3,8(sp)
ffffffffc02016a4:	e052                	sd	s4,0(sp)
ffffffffc02016a6:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc02016a8:	c135                	beqz	a0,ffffffffc020170c <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc02016aa:	002007b7          	lui	a5,0x200
ffffffffc02016ae:	04f5e663          	bltu	a1,a5,ffffffffc02016fa <user_mem_check+0x62>
ffffffffc02016b2:	00c584b3          	add	s1,a1,a2
ffffffffc02016b6:	0495f263          	bgeu	a1,s1,ffffffffc02016fa <user_mem_check+0x62>
ffffffffc02016ba:	4785                	li	a5,1
ffffffffc02016bc:	07fe                	slli	a5,a5,0x1f
ffffffffc02016be:	0297ee63          	bltu	a5,s1,ffffffffc02016fa <user_mem_check+0x62>
ffffffffc02016c2:	892a                	mv	s2,a0
ffffffffc02016c4:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc02016c6:	6a05                	lui	s4,0x1
ffffffffc02016c8:	a821                	j	ffffffffc02016e0 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc02016ca:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc02016ce:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc02016d0:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc02016d2:	c685                	beqz	a3,ffffffffc02016fa <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc02016d4:	c399                	beqz	a5,ffffffffc02016da <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc02016d6:	02e46263          	bltu	s0,a4,ffffffffc02016fa <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc02016da:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc02016dc:	04947663          	bgeu	s0,s1,ffffffffc0201728 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc02016e0:	85a2                	mv	a1,s0
ffffffffc02016e2:	854a                	mv	a0,s2
ffffffffc02016e4:	96fff0ef          	jal	ra,ffffffffc0201052 <find_vma>
ffffffffc02016e8:	c909                	beqz	a0,ffffffffc02016fa <user_mem_check+0x62>
ffffffffc02016ea:	6518                	ld	a4,8(a0)
ffffffffc02016ec:	00e46763          	bltu	s0,a4,ffffffffc02016fa <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc02016f0:	4d1c                	lw	a5,24(a0)
ffffffffc02016f2:	fc099ce3          	bnez	s3,ffffffffc02016ca <user_mem_check+0x32>
ffffffffc02016f6:	8b85                	andi	a5,a5,1
ffffffffc02016f8:	f3ed                	bnez	a5,ffffffffc02016da <user_mem_check+0x42>
            return 0;
ffffffffc02016fa:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
ffffffffc02016fc:	70a2                	ld	ra,40(sp)
ffffffffc02016fe:	7402                	ld	s0,32(sp)
ffffffffc0201700:	64e2                	ld	s1,24(sp)
ffffffffc0201702:	6942                	ld	s2,16(sp)
ffffffffc0201704:	69a2                	ld	s3,8(sp)
ffffffffc0201706:	6a02                	ld	s4,0(sp)
ffffffffc0201708:	6145                	addi	sp,sp,48
ffffffffc020170a:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc020170c:	c02007b7          	lui	a5,0xc0200
ffffffffc0201710:	4501                	li	a0,0
ffffffffc0201712:	fef5e5e3          	bltu	a1,a5,ffffffffc02016fc <user_mem_check+0x64>
ffffffffc0201716:	962e                	add	a2,a2,a1
ffffffffc0201718:	fec5f2e3          	bgeu	a1,a2,ffffffffc02016fc <user_mem_check+0x64>
ffffffffc020171c:	c8000537          	lui	a0,0xc8000
ffffffffc0201720:	0505                	addi	a0,a0,1
ffffffffc0201722:	00a63533          	sltu	a0,a2,a0
ffffffffc0201726:	bfd9                	j	ffffffffc02016fc <user_mem_check+0x64>
        return 1;
ffffffffc0201728:	4505                	li	a0,1
ffffffffc020172a:	bfc9                	j	ffffffffc02016fc <user_mem_check+0x64>

ffffffffc020172c <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc020172c:	c94d                	beqz	a0,ffffffffc02017de <slob_free+0xb2>
{
ffffffffc020172e:	1141                	addi	sp,sp,-16
ffffffffc0201730:	e022                	sd	s0,0(sp)
ffffffffc0201732:	e406                	sd	ra,8(sp)
ffffffffc0201734:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201736:	e9c1                	bnez	a1,ffffffffc02017c6 <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201738:	100027f3          	csrr	a5,sstatus
ffffffffc020173c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020173e:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201740:	ebd9                	bnez	a5,ffffffffc02017d6 <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201742:	000a5617          	auipc	a2,0xa5
ffffffffc0201746:	ade60613          	addi	a2,a2,-1314 # ffffffffc02a6220 <slobfree>
ffffffffc020174a:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc020174c:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc020174e:	679c                	ld	a5,8(a5)
ffffffffc0201750:	02877a63          	bgeu	a4,s0,ffffffffc0201784 <slob_free+0x58>
ffffffffc0201754:	00f46463          	bltu	s0,a5,ffffffffc020175c <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201758:	fef76ae3          	bltu	a4,a5,ffffffffc020174c <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc020175c:	400c                	lw	a1,0(s0)
ffffffffc020175e:	00459693          	slli	a3,a1,0x4
ffffffffc0201762:	96a2                	add	a3,a3,s0
ffffffffc0201764:	02d78a63          	beq	a5,a3,ffffffffc0201798 <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc0201768:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc020176a:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc020176c:	00469793          	slli	a5,a3,0x4
ffffffffc0201770:	97ba                	add	a5,a5,a4
ffffffffc0201772:	02f40e63          	beq	s0,a5,ffffffffc02017ae <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc0201776:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc0201778:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc020177a:	e129                	bnez	a0,ffffffffc02017bc <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc020177c:	60a2                	ld	ra,8(sp)
ffffffffc020177e:	6402                	ld	s0,0(sp)
ffffffffc0201780:	0141                	addi	sp,sp,16
ffffffffc0201782:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201784:	fcf764e3          	bltu	a4,a5,ffffffffc020174c <slob_free+0x20>
ffffffffc0201788:	fcf472e3          	bgeu	s0,a5,ffffffffc020174c <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc020178c:	400c                	lw	a1,0(s0)
ffffffffc020178e:	00459693          	slli	a3,a1,0x4
ffffffffc0201792:	96a2                	add	a3,a3,s0
ffffffffc0201794:	fcd79ae3          	bne	a5,a3,ffffffffc0201768 <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc0201798:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc020179a:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc020179c:	9db5                	addw	a1,a1,a3
ffffffffc020179e:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc02017a0:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc02017a2:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc02017a4:	00469793          	slli	a5,a3,0x4
ffffffffc02017a8:	97ba                	add	a5,a5,a4
ffffffffc02017aa:	fcf416e3          	bne	s0,a5,ffffffffc0201776 <slob_free+0x4a>
		cur->units += b->units;
ffffffffc02017ae:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc02017b0:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc02017b2:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc02017b4:	9ebd                	addw	a3,a3,a5
ffffffffc02017b6:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc02017b8:	e70c                	sd	a1,8(a4)
ffffffffc02017ba:	d169                	beqz	a0,ffffffffc020177c <slob_free+0x50>
}
ffffffffc02017bc:	6402                	ld	s0,0(sp)
ffffffffc02017be:	60a2                	ld	ra,8(sp)
ffffffffc02017c0:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc02017c2:	9f2ff06f          	j	ffffffffc02009b4 <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc02017c6:	25bd                	addiw	a1,a1,15
ffffffffc02017c8:	8191                	srli	a1,a1,0x4
ffffffffc02017ca:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02017cc:	100027f3          	csrr	a5,sstatus
ffffffffc02017d0:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02017d2:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02017d4:	d7bd                	beqz	a5,ffffffffc0201742 <slob_free+0x16>
        intr_disable();
ffffffffc02017d6:	9e4ff0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        return 1;
ffffffffc02017da:	4505                	li	a0,1
ffffffffc02017dc:	b79d                	j	ffffffffc0201742 <slob_free+0x16>
ffffffffc02017de:	8082                	ret

ffffffffc02017e0 <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc02017e0:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02017e2:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc02017e4:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02017e8:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc02017ea:	601000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
	if (!page)
ffffffffc02017ee:	c91d                	beqz	a0,ffffffffc0201824 <__slob_get_free_pages.constprop.0+0x44>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc02017f0:	000a9697          	auipc	a3,0xa9
ffffffffc02017f4:	eb86b683          	ld	a3,-328(a3) # ffffffffc02aa6a8 <pages>
ffffffffc02017f8:	8d15                	sub	a0,a0,a3
ffffffffc02017fa:	8519                	srai	a0,a0,0x6
ffffffffc02017fc:	00006697          	auipc	a3,0x6
ffffffffc0201800:	01c6b683          	ld	a3,28(a3) # ffffffffc0207818 <nbase>
ffffffffc0201804:	9536                	add	a0,a0,a3
}

static inline void *
page2kva(struct Page *page)
{
    return KADDR(page2pa(page));
ffffffffc0201806:	00c51793          	slli	a5,a0,0xc
ffffffffc020180a:	83b1                	srli	a5,a5,0xc
ffffffffc020180c:	000a9717          	auipc	a4,0xa9
ffffffffc0201810:	e9473703          	ld	a4,-364(a4) # ffffffffc02aa6a0 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201814:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201816:	00e7fa63          	bgeu	a5,a4,ffffffffc020182a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc020181a:	000a9697          	auipc	a3,0xa9
ffffffffc020181e:	e9e6b683          	ld	a3,-354(a3) # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0201822:	9536                	add	a0,a0,a3
}
ffffffffc0201824:	60a2                	ld	ra,8(sp)
ffffffffc0201826:	0141                	addi	sp,sp,16
ffffffffc0201828:	8082                	ret
ffffffffc020182a:	86aa                	mv	a3,a0
ffffffffc020182c:	00005617          	auipc	a2,0x5
ffffffffc0201830:	bbc60613          	addi	a2,a2,-1092 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0201834:	07100593          	li	a1,113
ffffffffc0201838:	00005517          	auipc	a0,0x5
ffffffffc020183c:	bd850513          	addi	a0,a0,-1064 # ffffffffc0206410 <commands+0xa98>
ffffffffc0201840:	9dffe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201844 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201844:	1101                	addi	sp,sp,-32
ffffffffc0201846:	ec06                	sd	ra,24(sp)
ffffffffc0201848:	e822                	sd	s0,16(sp)
ffffffffc020184a:	e426                	sd	s1,8(sp)
ffffffffc020184c:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc020184e:	01050713          	addi	a4,a0,16
ffffffffc0201852:	6785                	lui	a5,0x1
ffffffffc0201854:	0cf77363          	bgeu	a4,a5,ffffffffc020191a <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201858:	00f50493          	addi	s1,a0,15
ffffffffc020185c:	8091                	srli	s1,s1,0x4
ffffffffc020185e:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201860:	10002673          	csrr	a2,sstatus
ffffffffc0201864:	8a09                	andi	a2,a2,2
ffffffffc0201866:	e25d                	bnez	a2,ffffffffc020190c <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201868:	000a5917          	auipc	s2,0xa5
ffffffffc020186c:	9b890913          	addi	s2,s2,-1608 # ffffffffc02a6220 <slobfree>
ffffffffc0201870:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201874:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201876:	4398                	lw	a4,0(a5)
ffffffffc0201878:	08975e63          	bge	a4,s1,ffffffffc0201914 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc020187c:	00f68b63          	beq	a3,a5,ffffffffc0201892 <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201880:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201882:	4018                	lw	a4,0(s0)
ffffffffc0201884:	02975a63          	bge	a4,s1,ffffffffc02018b8 <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201888:	00093683          	ld	a3,0(s2)
ffffffffc020188c:	87a2                	mv	a5,s0
ffffffffc020188e:	fef699e3          	bne	a3,a5,ffffffffc0201880 <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201892:	ee31                	bnez	a2,ffffffffc02018ee <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201894:	4501                	li	a0,0
ffffffffc0201896:	f4bff0ef          	jal	ra,ffffffffc02017e0 <__slob_get_free_pages.constprop.0>
ffffffffc020189a:	842a                	mv	s0,a0
			if (!cur)
ffffffffc020189c:	cd05                	beqz	a0,ffffffffc02018d4 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc020189e:	6585                	lui	a1,0x1
ffffffffc02018a0:	e8dff0ef          	jal	ra,ffffffffc020172c <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02018a4:	10002673          	csrr	a2,sstatus
ffffffffc02018a8:	8a09                	andi	a2,a2,2
ffffffffc02018aa:	ee05                	bnez	a2,ffffffffc02018e2 <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc02018ac:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc02018b0:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc02018b2:	4018                	lw	a4,0(s0)
ffffffffc02018b4:	fc974ae3          	blt	a4,s1,ffffffffc0201888 <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc02018b8:	04e48763          	beq	s1,a4,ffffffffc0201906 <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc02018bc:	00449693          	slli	a3,s1,0x4
ffffffffc02018c0:	96a2                	add	a3,a3,s0
ffffffffc02018c2:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc02018c4:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc02018c6:	9f05                	subw	a4,a4,s1
ffffffffc02018c8:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc02018ca:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc02018cc:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc02018ce:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc02018d2:	e20d                	bnez	a2,ffffffffc02018f4 <slob_alloc.constprop.0+0xb0>
}
ffffffffc02018d4:	60e2                	ld	ra,24(sp)
ffffffffc02018d6:	8522                	mv	a0,s0
ffffffffc02018d8:	6442                	ld	s0,16(sp)
ffffffffc02018da:	64a2                	ld	s1,8(sp)
ffffffffc02018dc:	6902                	ld	s2,0(sp)
ffffffffc02018de:	6105                	addi	sp,sp,32
ffffffffc02018e0:	8082                	ret
        intr_disable();
ffffffffc02018e2:	8d8ff0ef          	jal	ra,ffffffffc02009ba <intr_disable>
			cur = slobfree;
ffffffffc02018e6:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc02018ea:	4605                	li	a2,1
ffffffffc02018ec:	b7d1                	j	ffffffffc02018b0 <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc02018ee:	8c6ff0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc02018f2:	b74d                	j	ffffffffc0201894 <slob_alloc.constprop.0+0x50>
ffffffffc02018f4:	8c0ff0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
}
ffffffffc02018f8:	60e2                	ld	ra,24(sp)
ffffffffc02018fa:	8522                	mv	a0,s0
ffffffffc02018fc:	6442                	ld	s0,16(sp)
ffffffffc02018fe:	64a2                	ld	s1,8(sp)
ffffffffc0201900:	6902                	ld	s2,0(sp)
ffffffffc0201902:	6105                	addi	sp,sp,32
ffffffffc0201904:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201906:	6418                	ld	a4,8(s0)
ffffffffc0201908:	e798                	sd	a4,8(a5)
ffffffffc020190a:	b7d1                	j	ffffffffc02018ce <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc020190c:	8aeff0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        return 1;
ffffffffc0201910:	4605                	li	a2,1
ffffffffc0201912:	bf99                	j	ffffffffc0201868 <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201914:	843e                	mv	s0,a5
ffffffffc0201916:	87b6                	mv	a5,a3
ffffffffc0201918:	b745                	j	ffffffffc02018b8 <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc020191a:	00005697          	auipc	a3,0x5
ffffffffc020191e:	b0668693          	addi	a3,a3,-1274 # ffffffffc0206420 <commands+0xaa8>
ffffffffc0201922:	00005617          	auipc	a2,0x5
ffffffffc0201926:	84e60613          	addi	a2,a2,-1970 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020192a:	06300593          	li	a1,99
ffffffffc020192e:	00005517          	auipc	a0,0x5
ffffffffc0201932:	b1250513          	addi	a0,a0,-1262 # ffffffffc0206440 <commands+0xac8>
ffffffffc0201936:	8e9fe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc020193a <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc020193a:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc020193c:	00005517          	auipc	a0,0x5
ffffffffc0201940:	b1c50513          	addi	a0,a0,-1252 # ffffffffc0206458 <commands+0xae0>
{
ffffffffc0201944:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201946:	f9afe0ef          	jal	ra,ffffffffc02000e0 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc020194a:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc020194c:	00005517          	auipc	a0,0x5
ffffffffc0201950:	b2450513          	addi	a0,a0,-1244 # ffffffffc0206470 <commands+0xaf8>
}
ffffffffc0201954:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201956:	f8afe06f          	j	ffffffffc02000e0 <cprintf>

ffffffffc020195a <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc020195a:	4501                	li	a0,0
ffffffffc020195c:	8082                	ret

ffffffffc020195e <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc020195e:	1101                	addi	sp,sp,-32
ffffffffc0201960:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201962:	6905                	lui	s2,0x1
{
ffffffffc0201964:	e822                	sd	s0,16(sp)
ffffffffc0201966:	ec06                	sd	ra,24(sp)
ffffffffc0201968:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc020196a:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8bb9>
{
ffffffffc020196e:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201970:	04a7f963          	bgeu	a5,a0,ffffffffc02019c2 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201974:	4561                	li	a0,24
ffffffffc0201976:	ecfff0ef          	jal	ra,ffffffffc0201844 <slob_alloc.constprop.0>
ffffffffc020197a:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc020197c:	c929                	beqz	a0,ffffffffc02019ce <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc020197e:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201982:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201984:	00f95763          	bge	s2,a5,ffffffffc0201992 <kmalloc+0x34>
ffffffffc0201988:	6705                	lui	a4,0x1
ffffffffc020198a:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc020198c:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc020198e:	fef74ee3          	blt	a4,a5,ffffffffc020198a <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201992:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201994:	e4dff0ef          	jal	ra,ffffffffc02017e0 <__slob_get_free_pages.constprop.0>
ffffffffc0201998:	e488                	sd	a0,8(s1)
ffffffffc020199a:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc020199c:	c525                	beqz	a0,ffffffffc0201a04 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020199e:	100027f3          	csrr	a5,sstatus
ffffffffc02019a2:	8b89                	andi	a5,a5,2
ffffffffc02019a4:	ef8d                	bnez	a5,ffffffffc02019de <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc02019a6:	000a9797          	auipc	a5,0xa9
ffffffffc02019aa:	ce278793          	addi	a5,a5,-798 # ffffffffc02aa688 <bigblocks>
ffffffffc02019ae:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc02019b0:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02019b2:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc02019b4:	60e2                	ld	ra,24(sp)
ffffffffc02019b6:	8522                	mv	a0,s0
ffffffffc02019b8:	6442                	ld	s0,16(sp)
ffffffffc02019ba:	64a2                	ld	s1,8(sp)
ffffffffc02019bc:	6902                	ld	s2,0(sp)
ffffffffc02019be:	6105                	addi	sp,sp,32
ffffffffc02019c0:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc02019c2:	0541                	addi	a0,a0,16
ffffffffc02019c4:	e81ff0ef          	jal	ra,ffffffffc0201844 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc02019c8:	01050413          	addi	s0,a0,16
ffffffffc02019cc:	f565                	bnez	a0,ffffffffc02019b4 <kmalloc+0x56>
ffffffffc02019ce:	4401                	li	s0,0
}
ffffffffc02019d0:	60e2                	ld	ra,24(sp)
ffffffffc02019d2:	8522                	mv	a0,s0
ffffffffc02019d4:	6442                	ld	s0,16(sp)
ffffffffc02019d6:	64a2                	ld	s1,8(sp)
ffffffffc02019d8:	6902                	ld	s2,0(sp)
ffffffffc02019da:	6105                	addi	sp,sp,32
ffffffffc02019dc:	8082                	ret
        intr_disable();
ffffffffc02019de:	fddfe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
		bb->next = bigblocks;
ffffffffc02019e2:	000a9797          	auipc	a5,0xa9
ffffffffc02019e6:	ca678793          	addi	a5,a5,-858 # ffffffffc02aa688 <bigblocks>
ffffffffc02019ea:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc02019ec:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02019ee:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc02019f0:	fc5fe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
		return bb->pages;
ffffffffc02019f4:	6480                	ld	s0,8(s1)
}
ffffffffc02019f6:	60e2                	ld	ra,24(sp)
ffffffffc02019f8:	64a2                	ld	s1,8(sp)
ffffffffc02019fa:	8522                	mv	a0,s0
ffffffffc02019fc:	6442                	ld	s0,16(sp)
ffffffffc02019fe:	6902                	ld	s2,0(sp)
ffffffffc0201a00:	6105                	addi	sp,sp,32
ffffffffc0201a02:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201a04:	45e1                	li	a1,24
ffffffffc0201a06:	8526                	mv	a0,s1
ffffffffc0201a08:	d25ff0ef          	jal	ra,ffffffffc020172c <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201a0c:	b765                	j	ffffffffc02019b4 <kmalloc+0x56>

ffffffffc0201a0e <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201a0e:	c169                	beqz	a0,ffffffffc0201ad0 <kfree+0xc2>
{
ffffffffc0201a10:	1101                	addi	sp,sp,-32
ffffffffc0201a12:	e822                	sd	s0,16(sp)
ffffffffc0201a14:	ec06                	sd	ra,24(sp)
ffffffffc0201a16:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201a18:	03451793          	slli	a5,a0,0x34
ffffffffc0201a1c:	842a                	mv	s0,a0
ffffffffc0201a1e:	e3d9                	bnez	a5,ffffffffc0201aa4 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a20:	100027f3          	csrr	a5,sstatus
ffffffffc0201a24:	8b89                	andi	a5,a5,2
ffffffffc0201a26:	e7d9                	bnez	a5,ffffffffc0201ab4 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201a28:	000a9797          	auipc	a5,0xa9
ffffffffc0201a2c:	c607b783          	ld	a5,-928(a5) # ffffffffc02aa688 <bigblocks>
    return 0;
ffffffffc0201a30:	4601                	li	a2,0
ffffffffc0201a32:	cbad                	beqz	a5,ffffffffc0201aa4 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201a34:	000a9697          	auipc	a3,0xa9
ffffffffc0201a38:	c5468693          	addi	a3,a3,-940 # ffffffffc02aa688 <bigblocks>
ffffffffc0201a3c:	a021                	j	ffffffffc0201a44 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201a3e:	01048693          	addi	a3,s1,16
ffffffffc0201a42:	c3a5                	beqz	a5,ffffffffc0201aa2 <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201a44:	6798                	ld	a4,8(a5)
ffffffffc0201a46:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201a48:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201a4a:	fe871ae3          	bne	a4,s0,ffffffffc0201a3e <kfree+0x30>
				*last = bb->next;
ffffffffc0201a4e:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201a50:	ee2d                	bnez	a2,ffffffffc0201aca <kfree+0xbc>
}

static inline struct Page *
kva2page(void *kva)
{
    return pa2page(PADDR(kva));
ffffffffc0201a52:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201a56:	4098                	lw	a4,0(s1)
ffffffffc0201a58:	08f46963          	bltu	s0,a5,ffffffffc0201aea <kfree+0xdc>
ffffffffc0201a5c:	000a9697          	auipc	a3,0xa9
ffffffffc0201a60:	c5c6b683          	ld	a3,-932(a3) # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0201a64:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201a66:	8031                	srli	s0,s0,0xc
ffffffffc0201a68:	000a9797          	auipc	a5,0xa9
ffffffffc0201a6c:	c387b783          	ld	a5,-968(a5) # ffffffffc02aa6a0 <npage>
ffffffffc0201a70:	06f47163          	bgeu	s0,a5,ffffffffc0201ad2 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201a74:	00006517          	auipc	a0,0x6
ffffffffc0201a78:	da453503          	ld	a0,-604(a0) # ffffffffc0207818 <nbase>
ffffffffc0201a7c:	8c09                	sub	s0,s0,a0
ffffffffc0201a7e:	041a                	slli	s0,s0,0x6
	free_pages(kva2page((void *)kva), 1 << order);
ffffffffc0201a80:	000a9517          	auipc	a0,0xa9
ffffffffc0201a84:	c2853503          	ld	a0,-984(a0) # ffffffffc02aa6a8 <pages>
ffffffffc0201a88:	4585                	li	a1,1
ffffffffc0201a8a:	9522                	add	a0,a0,s0
ffffffffc0201a8c:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201a90:	399000ef          	jal	ra,ffffffffc0202628 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201a94:	6442                	ld	s0,16(sp)
ffffffffc0201a96:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201a98:	8526                	mv	a0,s1
}
ffffffffc0201a9a:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201a9c:	45e1                	li	a1,24
}
ffffffffc0201a9e:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201aa0:	b171                	j	ffffffffc020172c <slob_free>
ffffffffc0201aa2:	e20d                	bnez	a2,ffffffffc0201ac4 <kfree+0xb6>
ffffffffc0201aa4:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201aa8:	6442                	ld	s0,16(sp)
ffffffffc0201aaa:	60e2                	ld	ra,24(sp)
ffffffffc0201aac:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201aae:	4581                	li	a1,0
}
ffffffffc0201ab0:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201ab2:	b9ad                	j	ffffffffc020172c <slob_free>
        intr_disable();
ffffffffc0201ab4:	f07fe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201ab8:	000a9797          	auipc	a5,0xa9
ffffffffc0201abc:	bd07b783          	ld	a5,-1072(a5) # ffffffffc02aa688 <bigblocks>
        return 1;
ffffffffc0201ac0:	4605                	li	a2,1
ffffffffc0201ac2:	fbad                	bnez	a5,ffffffffc0201a34 <kfree+0x26>
        intr_enable();
ffffffffc0201ac4:	ef1fe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0201ac8:	bff1                	j	ffffffffc0201aa4 <kfree+0x96>
ffffffffc0201aca:	eebfe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0201ace:	b751                	j	ffffffffc0201a52 <kfree+0x44>
ffffffffc0201ad0:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201ad2:	00005617          	auipc	a2,0x5
ffffffffc0201ad6:	9e660613          	addi	a2,a2,-1562 # ffffffffc02064b8 <commands+0xb40>
ffffffffc0201ada:	06900593          	li	a1,105
ffffffffc0201ade:	00005517          	auipc	a0,0x5
ffffffffc0201ae2:	93250513          	addi	a0,a0,-1742 # ffffffffc0206410 <commands+0xa98>
ffffffffc0201ae6:	f38fe0ef          	jal	ra,ffffffffc020021e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201aea:	86a2                	mv	a3,s0
ffffffffc0201aec:	00005617          	auipc	a2,0x5
ffffffffc0201af0:	9a460613          	addi	a2,a2,-1628 # ffffffffc0206490 <commands+0xb18>
ffffffffc0201af4:	07700593          	li	a1,119
ffffffffc0201af8:	00005517          	auipc	a0,0x5
ffffffffc0201afc:	91850513          	addi	a0,a0,-1768 # ffffffffc0206410 <commands+0xa98>
ffffffffc0201b00:	f1efe0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0201b04 <default_init>:
    elm->prev = elm->next = elm;
ffffffffc0201b04:	000a5797          	auipc	a5,0xa5
ffffffffc0201b08:	b2c78793          	addi	a5,a5,-1236 # ffffffffc02a6630 <free_area>
ffffffffc0201b0c:	e79c                	sd	a5,8(a5)
ffffffffc0201b0e:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0201b10:	0007a823          	sw	zero,16(a5)
}
ffffffffc0201b14:	8082                	ret

ffffffffc0201b16 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0201b16:	000a5517          	auipc	a0,0xa5
ffffffffc0201b1a:	b2a56503          	lwu	a0,-1238(a0) # ffffffffc02a6640 <free_area+0x10>
ffffffffc0201b1e:	8082                	ret

ffffffffc0201b20 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc0201b20:	715d                	addi	sp,sp,-80
ffffffffc0201b22:	e0a2                	sd	s0,64(sp)
    return listelm->next;
ffffffffc0201b24:	000a5417          	auipc	s0,0xa5
ffffffffc0201b28:	b0c40413          	addi	s0,s0,-1268 # ffffffffc02a6630 <free_area>
ffffffffc0201b2c:	641c                	ld	a5,8(s0)
ffffffffc0201b2e:	e486                	sd	ra,72(sp)
ffffffffc0201b30:	fc26                	sd	s1,56(sp)
ffffffffc0201b32:	f84a                	sd	s2,48(sp)
ffffffffc0201b34:	f44e                	sd	s3,40(sp)
ffffffffc0201b36:	f052                	sd	s4,32(sp)
ffffffffc0201b38:	ec56                	sd	s5,24(sp)
ffffffffc0201b3a:	e85a                	sd	s6,16(sp)
ffffffffc0201b3c:	e45e                	sd	s7,8(sp)
ffffffffc0201b3e:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0201b40:	2a878d63          	beq	a5,s0,ffffffffc0201dfa <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0201b44:	4481                	li	s1,0
ffffffffc0201b46:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201b48:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0201b4c:	8b09                	andi	a4,a4,2
ffffffffc0201b4e:	2a070a63          	beqz	a4,ffffffffc0201e02 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0201b52:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b56:	679c                	ld	a5,8(a5)
ffffffffc0201b58:	2905                	addiw	s2,s2,1
ffffffffc0201b5a:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0201b5c:	fe8796e3          	bne	a5,s0,ffffffffc0201b48 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0201b60:	89a6                	mv	s3,s1
ffffffffc0201b62:	307000ef          	jal	ra,ffffffffc0202668 <nr_free_pages>
ffffffffc0201b66:	6f351e63          	bne	a0,s3,ffffffffc0202262 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201b6a:	4505                	li	a0,1
ffffffffc0201b6c:	27f000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201b70:	8aaa                	mv	s5,a0
ffffffffc0201b72:	42050863          	beqz	a0,ffffffffc0201fa2 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201b76:	4505                	li	a0,1
ffffffffc0201b78:	273000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201b7c:	89aa                	mv	s3,a0
ffffffffc0201b7e:	70050263          	beqz	a0,ffffffffc0202282 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201b82:	4505                	li	a0,1
ffffffffc0201b84:	267000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201b88:	8a2a                	mv	s4,a0
ffffffffc0201b8a:	48050c63          	beqz	a0,ffffffffc0202022 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201b8e:	293a8a63          	beq	s5,s3,ffffffffc0201e22 <default_check+0x302>
ffffffffc0201b92:	28aa8863          	beq	s5,a0,ffffffffc0201e22 <default_check+0x302>
ffffffffc0201b96:	28a98663          	beq	s3,a0,ffffffffc0201e22 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201b9a:	000aa783          	lw	a5,0(s5)
ffffffffc0201b9e:	2a079263          	bnez	a5,ffffffffc0201e42 <default_check+0x322>
ffffffffc0201ba2:	0009a783          	lw	a5,0(s3)
ffffffffc0201ba6:	28079e63          	bnez	a5,ffffffffc0201e42 <default_check+0x322>
ffffffffc0201baa:	411c                	lw	a5,0(a0)
ffffffffc0201bac:	28079b63          	bnez	a5,ffffffffc0201e42 <default_check+0x322>
    return page - pages + nbase;
ffffffffc0201bb0:	000a9797          	auipc	a5,0xa9
ffffffffc0201bb4:	af87b783          	ld	a5,-1288(a5) # ffffffffc02aa6a8 <pages>
ffffffffc0201bb8:	40fa8733          	sub	a4,s5,a5
ffffffffc0201bbc:	00006617          	auipc	a2,0x6
ffffffffc0201bc0:	c5c63603          	ld	a2,-932(a2) # ffffffffc0207818 <nbase>
ffffffffc0201bc4:	8719                	srai	a4,a4,0x6
ffffffffc0201bc6:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201bc8:	000a9697          	auipc	a3,0xa9
ffffffffc0201bcc:	ad86b683          	ld	a3,-1320(a3) # ffffffffc02aa6a0 <npage>
ffffffffc0201bd0:	06b2                	slli	a3,a3,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201bd2:	0732                	slli	a4,a4,0xc
ffffffffc0201bd4:	28d77763          	bgeu	a4,a3,ffffffffc0201e62 <default_check+0x342>
    return page - pages + nbase;
ffffffffc0201bd8:	40f98733          	sub	a4,s3,a5
ffffffffc0201bdc:	8719                	srai	a4,a4,0x6
ffffffffc0201bde:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201be0:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201be2:	4cd77063          	bgeu	a4,a3,ffffffffc02020a2 <default_check+0x582>
    return page - pages + nbase;
ffffffffc0201be6:	40f507b3          	sub	a5,a0,a5
ffffffffc0201bea:	8799                	srai	a5,a5,0x6
ffffffffc0201bec:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201bee:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201bf0:	30d7f963          	bgeu	a5,a3,ffffffffc0201f02 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc0201bf4:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201bf6:	00043c03          	ld	s8,0(s0)
ffffffffc0201bfa:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0201bfe:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0201c02:	e400                	sd	s0,8(s0)
ffffffffc0201c04:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0201c06:	000a5797          	auipc	a5,0xa5
ffffffffc0201c0a:	a207ad23          	sw	zero,-1478(a5) # ffffffffc02a6640 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0201c0e:	1dd000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c12:	2c051863          	bnez	a0,ffffffffc0201ee2 <default_check+0x3c2>
    free_page(p0);
ffffffffc0201c16:	4585                	li	a1,1
ffffffffc0201c18:	8556                	mv	a0,s5
ffffffffc0201c1a:	20f000ef          	jal	ra,ffffffffc0202628 <free_pages>
    free_page(p1);
ffffffffc0201c1e:	4585                	li	a1,1
ffffffffc0201c20:	854e                	mv	a0,s3
ffffffffc0201c22:	207000ef          	jal	ra,ffffffffc0202628 <free_pages>
    free_page(p2);
ffffffffc0201c26:	4585                	li	a1,1
ffffffffc0201c28:	8552                	mv	a0,s4
ffffffffc0201c2a:	1ff000ef          	jal	ra,ffffffffc0202628 <free_pages>
    assert(nr_free == 3);
ffffffffc0201c2e:	4818                	lw	a4,16(s0)
ffffffffc0201c30:	478d                	li	a5,3
ffffffffc0201c32:	28f71863          	bne	a4,a5,ffffffffc0201ec2 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201c36:	4505                	li	a0,1
ffffffffc0201c38:	1b3000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c3c:	89aa                	mv	s3,a0
ffffffffc0201c3e:	26050263          	beqz	a0,ffffffffc0201ea2 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201c42:	4505                	li	a0,1
ffffffffc0201c44:	1a7000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c48:	8aaa                	mv	s5,a0
ffffffffc0201c4a:	3a050c63          	beqz	a0,ffffffffc0202002 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201c4e:	4505                	li	a0,1
ffffffffc0201c50:	19b000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c54:	8a2a                	mv	s4,a0
ffffffffc0201c56:	38050663          	beqz	a0,ffffffffc0201fe2 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201c5a:	4505                	li	a0,1
ffffffffc0201c5c:	18f000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c60:	36051163          	bnez	a0,ffffffffc0201fc2 <default_check+0x4a2>
    free_page(p0);
ffffffffc0201c64:	4585                	li	a1,1
ffffffffc0201c66:	854e                	mv	a0,s3
ffffffffc0201c68:	1c1000ef          	jal	ra,ffffffffc0202628 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0201c6c:	641c                	ld	a5,8(s0)
ffffffffc0201c6e:	20878a63          	beq	a5,s0,ffffffffc0201e82 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201c72:	4505                	li	a0,1
ffffffffc0201c74:	177000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c78:	30a99563          	bne	s3,a0,ffffffffc0201f82 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0201c7c:	4505                	li	a0,1
ffffffffc0201c7e:	16d000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201c82:	2e051063          	bnez	a0,ffffffffc0201f62 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201c86:	481c                	lw	a5,16(s0)
ffffffffc0201c88:	2a079d63          	bnez	a5,ffffffffc0201f42 <default_check+0x422>
    free_page(p);
ffffffffc0201c8c:	854e                	mv	a0,s3
ffffffffc0201c8e:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0201c90:	01843023          	sd	s8,0(s0)
ffffffffc0201c94:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201c98:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0201c9c:	18d000ef          	jal	ra,ffffffffc0202628 <free_pages>
    free_page(p1);
ffffffffc0201ca0:	4585                	li	a1,1
ffffffffc0201ca2:	8556                	mv	a0,s5
ffffffffc0201ca4:	185000ef          	jal	ra,ffffffffc0202628 <free_pages>
    free_page(p2);
ffffffffc0201ca8:	4585                	li	a1,1
ffffffffc0201caa:	8552                	mv	a0,s4
ffffffffc0201cac:	17d000ef          	jal	ra,ffffffffc0202628 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0201cb0:	4515                	li	a0,5
ffffffffc0201cb2:	139000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201cb6:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0201cb8:	26050563          	beqz	a0,ffffffffc0201f22 <default_check+0x402>
ffffffffc0201cbc:	651c                	ld	a5,8(a0)
ffffffffc0201cbe:	8385                	srli	a5,a5,0x1
ffffffffc0201cc0:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0201cc2:	54079063          	bnez	a5,ffffffffc0202202 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0201cc6:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201cc8:	00043b03          	ld	s6,0(s0)
ffffffffc0201ccc:	00843a83          	ld	s5,8(s0)
ffffffffc0201cd0:	e000                	sd	s0,0(s0)
ffffffffc0201cd2:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0201cd4:	117000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201cd8:	50051563          	bnez	a0,ffffffffc02021e2 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0201cdc:	08098a13          	addi	s4,s3,128
ffffffffc0201ce0:	8552                	mv	a0,s4
ffffffffc0201ce2:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0201ce4:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0201ce8:	000a5797          	auipc	a5,0xa5
ffffffffc0201cec:	9407ac23          	sw	zero,-1704(a5) # ffffffffc02a6640 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0201cf0:	139000ef          	jal	ra,ffffffffc0202628 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0201cf4:	4511                	li	a0,4
ffffffffc0201cf6:	0f5000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201cfa:	4c051463          	bnez	a0,ffffffffc02021c2 <default_check+0x6a2>
ffffffffc0201cfe:	0889b783          	ld	a5,136(s3)
ffffffffc0201d02:	8385                	srli	a5,a5,0x1
ffffffffc0201d04:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201d06:	48078e63          	beqz	a5,ffffffffc02021a2 <default_check+0x682>
ffffffffc0201d0a:	0909a703          	lw	a4,144(s3)
ffffffffc0201d0e:	478d                	li	a5,3
ffffffffc0201d10:	48f71963          	bne	a4,a5,ffffffffc02021a2 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201d14:	450d                	li	a0,3
ffffffffc0201d16:	0d5000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201d1a:	8c2a                	mv	s8,a0
ffffffffc0201d1c:	46050363          	beqz	a0,ffffffffc0202182 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc0201d20:	4505                	li	a0,1
ffffffffc0201d22:	0c9000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201d26:	42051e63          	bnez	a0,ffffffffc0202162 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201d2a:	418a1c63          	bne	s4,s8,ffffffffc0202142 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0201d2e:	4585                	li	a1,1
ffffffffc0201d30:	854e                	mv	a0,s3
ffffffffc0201d32:	0f7000ef          	jal	ra,ffffffffc0202628 <free_pages>
    free_pages(p1, 3);
ffffffffc0201d36:	458d                	li	a1,3
ffffffffc0201d38:	8552                	mv	a0,s4
ffffffffc0201d3a:	0ef000ef          	jal	ra,ffffffffc0202628 <free_pages>
ffffffffc0201d3e:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201d42:	04098c13          	addi	s8,s3,64
ffffffffc0201d46:	8385                	srli	a5,a5,0x1
ffffffffc0201d48:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201d4a:	3c078c63          	beqz	a5,ffffffffc0202122 <default_check+0x602>
ffffffffc0201d4e:	0109a703          	lw	a4,16(s3)
ffffffffc0201d52:	4785                	li	a5,1
ffffffffc0201d54:	3cf71763          	bne	a4,a5,ffffffffc0202122 <default_check+0x602>
ffffffffc0201d58:	008a3783          	ld	a5,8(s4) # 1008 <_binary_obj___user_faultread_out_size-0x8ba0>
ffffffffc0201d5c:	8385                	srli	a5,a5,0x1
ffffffffc0201d5e:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201d60:	3a078163          	beqz	a5,ffffffffc0202102 <default_check+0x5e2>
ffffffffc0201d64:	010a2703          	lw	a4,16(s4)
ffffffffc0201d68:	478d                	li	a5,3
ffffffffc0201d6a:	38f71c63          	bne	a4,a5,ffffffffc0202102 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201d6e:	4505                	li	a0,1
ffffffffc0201d70:	07b000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201d74:	36a99763          	bne	s3,a0,ffffffffc02020e2 <default_check+0x5c2>
    free_page(p0);
ffffffffc0201d78:	4585                	li	a1,1
ffffffffc0201d7a:	0af000ef          	jal	ra,ffffffffc0202628 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201d7e:	4509                	li	a0,2
ffffffffc0201d80:	06b000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201d84:	32aa1f63          	bne	s4,a0,ffffffffc02020c2 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201d88:	4589                	li	a1,2
ffffffffc0201d8a:	09f000ef          	jal	ra,ffffffffc0202628 <free_pages>
    free_page(p2);
ffffffffc0201d8e:	4585                	li	a1,1
ffffffffc0201d90:	8562                	mv	a0,s8
ffffffffc0201d92:	097000ef          	jal	ra,ffffffffc0202628 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201d96:	4515                	li	a0,5
ffffffffc0201d98:	053000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201d9c:	89aa                	mv	s3,a0
ffffffffc0201d9e:	48050263          	beqz	a0,ffffffffc0202222 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201da2:	4505                	li	a0,1
ffffffffc0201da4:	047000ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc0201da8:	2c051d63          	bnez	a0,ffffffffc0202082 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc0201dac:	481c                	lw	a5,16(s0)
ffffffffc0201dae:	2a079a63          	bnez	a5,ffffffffc0202062 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201db2:	4595                	li	a1,5
ffffffffc0201db4:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0201db6:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0201dba:	01643023          	sd	s6,0(s0)
ffffffffc0201dbe:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0201dc2:	067000ef          	jal	ra,ffffffffc0202628 <free_pages>
    return listelm->next;
ffffffffc0201dc6:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0201dc8:	00878963          	beq	a5,s0,ffffffffc0201dda <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc0201dcc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201dd0:	679c                	ld	a5,8(a5)
ffffffffc0201dd2:	397d                	addiw	s2,s2,-1
ffffffffc0201dd4:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0201dd6:	fe879be3          	bne	a5,s0,ffffffffc0201dcc <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc0201dda:	26091463          	bnez	s2,ffffffffc0202042 <default_check+0x522>
    assert(total == 0);
ffffffffc0201dde:	46049263          	bnez	s1,ffffffffc0202242 <default_check+0x722>
}
ffffffffc0201de2:	60a6                	ld	ra,72(sp)
ffffffffc0201de4:	6406                	ld	s0,64(sp)
ffffffffc0201de6:	74e2                	ld	s1,56(sp)
ffffffffc0201de8:	7942                	ld	s2,48(sp)
ffffffffc0201dea:	79a2                	ld	s3,40(sp)
ffffffffc0201dec:	7a02                	ld	s4,32(sp)
ffffffffc0201dee:	6ae2                	ld	s5,24(sp)
ffffffffc0201df0:	6b42                	ld	s6,16(sp)
ffffffffc0201df2:	6ba2                	ld	s7,8(sp)
ffffffffc0201df4:	6c02                	ld	s8,0(sp)
ffffffffc0201df6:	6161                	addi	sp,sp,80
ffffffffc0201df8:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc0201dfa:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0201dfc:	4481                	li	s1,0
ffffffffc0201dfe:	4901                	li	s2,0
ffffffffc0201e00:	b38d                	j	ffffffffc0201b62 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0201e02:	00004697          	auipc	a3,0x4
ffffffffc0201e06:	6d668693          	addi	a3,a3,1750 # ffffffffc02064d8 <commands+0xb60>
ffffffffc0201e0a:	00004617          	auipc	a2,0x4
ffffffffc0201e0e:	36660613          	addi	a2,a2,870 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201e12:	11000593          	li	a1,272
ffffffffc0201e16:	00004517          	auipc	a0,0x4
ffffffffc0201e1a:	6d250513          	addi	a0,a0,1746 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201e1e:	c00fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201e22:	00004697          	auipc	a3,0x4
ffffffffc0201e26:	75e68693          	addi	a3,a3,1886 # ffffffffc0206580 <commands+0xc08>
ffffffffc0201e2a:	00004617          	auipc	a2,0x4
ffffffffc0201e2e:	34660613          	addi	a2,a2,838 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201e32:	0db00593          	li	a1,219
ffffffffc0201e36:	00004517          	auipc	a0,0x4
ffffffffc0201e3a:	6b250513          	addi	a0,a0,1714 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201e3e:	be0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201e42:	00004697          	auipc	a3,0x4
ffffffffc0201e46:	76668693          	addi	a3,a3,1894 # ffffffffc02065a8 <commands+0xc30>
ffffffffc0201e4a:	00004617          	auipc	a2,0x4
ffffffffc0201e4e:	32660613          	addi	a2,a2,806 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201e52:	0dc00593          	li	a1,220
ffffffffc0201e56:	00004517          	auipc	a0,0x4
ffffffffc0201e5a:	69250513          	addi	a0,a0,1682 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201e5e:	bc0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201e62:	00004697          	auipc	a3,0x4
ffffffffc0201e66:	78668693          	addi	a3,a3,1926 # ffffffffc02065e8 <commands+0xc70>
ffffffffc0201e6a:	00004617          	auipc	a2,0x4
ffffffffc0201e6e:	30660613          	addi	a2,a2,774 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201e72:	0de00593          	li	a1,222
ffffffffc0201e76:	00004517          	auipc	a0,0x4
ffffffffc0201e7a:	67250513          	addi	a0,a0,1650 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201e7e:	ba0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201e82:	00004697          	auipc	a3,0x4
ffffffffc0201e86:	7ee68693          	addi	a3,a3,2030 # ffffffffc0206670 <commands+0xcf8>
ffffffffc0201e8a:	00004617          	auipc	a2,0x4
ffffffffc0201e8e:	2e660613          	addi	a2,a2,742 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201e92:	0f700593          	li	a1,247
ffffffffc0201e96:	00004517          	auipc	a0,0x4
ffffffffc0201e9a:	65250513          	addi	a0,a0,1618 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201e9e:	b80fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201ea2:	00004697          	auipc	a3,0x4
ffffffffc0201ea6:	67e68693          	addi	a3,a3,1662 # ffffffffc0206520 <commands+0xba8>
ffffffffc0201eaa:	00004617          	auipc	a2,0x4
ffffffffc0201eae:	2c660613          	addi	a2,a2,710 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201eb2:	0f000593          	li	a1,240
ffffffffc0201eb6:	00004517          	auipc	a0,0x4
ffffffffc0201eba:	63250513          	addi	a0,a0,1586 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201ebe:	b60fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(nr_free == 3);
ffffffffc0201ec2:	00004697          	auipc	a3,0x4
ffffffffc0201ec6:	79e68693          	addi	a3,a3,1950 # ffffffffc0206660 <commands+0xce8>
ffffffffc0201eca:	00004617          	auipc	a2,0x4
ffffffffc0201ece:	2a660613          	addi	a2,a2,678 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201ed2:	0ee00593          	li	a1,238
ffffffffc0201ed6:	00004517          	auipc	a0,0x4
ffffffffc0201eda:	61250513          	addi	a0,a0,1554 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201ede:	b40fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201ee2:	00004697          	auipc	a3,0x4
ffffffffc0201ee6:	76668693          	addi	a3,a3,1894 # ffffffffc0206648 <commands+0xcd0>
ffffffffc0201eea:	00004617          	auipc	a2,0x4
ffffffffc0201eee:	28660613          	addi	a2,a2,646 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201ef2:	0e900593          	li	a1,233
ffffffffc0201ef6:	00004517          	auipc	a0,0x4
ffffffffc0201efa:	5f250513          	addi	a0,a0,1522 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201efe:	b20fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201f02:	00004697          	auipc	a3,0x4
ffffffffc0201f06:	72668693          	addi	a3,a3,1830 # ffffffffc0206628 <commands+0xcb0>
ffffffffc0201f0a:	00004617          	auipc	a2,0x4
ffffffffc0201f0e:	26660613          	addi	a2,a2,614 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201f12:	0e000593          	li	a1,224
ffffffffc0201f16:	00004517          	auipc	a0,0x4
ffffffffc0201f1a:	5d250513          	addi	a0,a0,1490 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201f1e:	b00fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(p0 != NULL);
ffffffffc0201f22:	00004697          	auipc	a3,0x4
ffffffffc0201f26:	79668693          	addi	a3,a3,1942 # ffffffffc02066b8 <commands+0xd40>
ffffffffc0201f2a:	00004617          	auipc	a2,0x4
ffffffffc0201f2e:	24660613          	addi	a2,a2,582 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201f32:	11800593          	li	a1,280
ffffffffc0201f36:	00004517          	auipc	a0,0x4
ffffffffc0201f3a:	5b250513          	addi	a0,a0,1458 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201f3e:	ae0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(nr_free == 0);
ffffffffc0201f42:	00004697          	auipc	a3,0x4
ffffffffc0201f46:	76668693          	addi	a3,a3,1894 # ffffffffc02066a8 <commands+0xd30>
ffffffffc0201f4a:	00004617          	auipc	a2,0x4
ffffffffc0201f4e:	22660613          	addi	a2,a2,550 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201f52:	0fd00593          	li	a1,253
ffffffffc0201f56:	00004517          	auipc	a0,0x4
ffffffffc0201f5a:	59250513          	addi	a0,a0,1426 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201f5e:	ac0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201f62:	00004697          	auipc	a3,0x4
ffffffffc0201f66:	6e668693          	addi	a3,a3,1766 # ffffffffc0206648 <commands+0xcd0>
ffffffffc0201f6a:	00004617          	auipc	a2,0x4
ffffffffc0201f6e:	20660613          	addi	a2,a2,518 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201f72:	0fb00593          	li	a1,251
ffffffffc0201f76:	00004517          	auipc	a0,0x4
ffffffffc0201f7a:	57250513          	addi	a0,a0,1394 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201f7e:	aa0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201f82:	00004697          	auipc	a3,0x4
ffffffffc0201f86:	70668693          	addi	a3,a3,1798 # ffffffffc0206688 <commands+0xd10>
ffffffffc0201f8a:	00004617          	auipc	a2,0x4
ffffffffc0201f8e:	1e660613          	addi	a2,a2,486 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201f92:	0fa00593          	li	a1,250
ffffffffc0201f96:	00004517          	auipc	a0,0x4
ffffffffc0201f9a:	55250513          	addi	a0,a0,1362 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201f9e:	a80fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201fa2:	00004697          	auipc	a3,0x4
ffffffffc0201fa6:	57e68693          	addi	a3,a3,1406 # ffffffffc0206520 <commands+0xba8>
ffffffffc0201faa:	00004617          	auipc	a2,0x4
ffffffffc0201fae:	1c660613          	addi	a2,a2,454 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201fb2:	0d700593          	li	a1,215
ffffffffc0201fb6:	00004517          	auipc	a0,0x4
ffffffffc0201fba:	53250513          	addi	a0,a0,1330 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201fbe:	a60fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201fc2:	00004697          	auipc	a3,0x4
ffffffffc0201fc6:	68668693          	addi	a3,a3,1670 # ffffffffc0206648 <commands+0xcd0>
ffffffffc0201fca:	00004617          	auipc	a2,0x4
ffffffffc0201fce:	1a660613          	addi	a2,a2,422 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201fd2:	0f400593          	li	a1,244
ffffffffc0201fd6:	00004517          	auipc	a0,0x4
ffffffffc0201fda:	51250513          	addi	a0,a0,1298 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201fde:	a40fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201fe2:	00004697          	auipc	a3,0x4
ffffffffc0201fe6:	57e68693          	addi	a3,a3,1406 # ffffffffc0206560 <commands+0xbe8>
ffffffffc0201fea:	00004617          	auipc	a2,0x4
ffffffffc0201fee:	18660613          	addi	a2,a2,390 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0201ff2:	0f200593          	li	a1,242
ffffffffc0201ff6:	00004517          	auipc	a0,0x4
ffffffffc0201ffa:	4f250513          	addi	a0,a0,1266 # ffffffffc02064e8 <commands+0xb70>
ffffffffc0201ffe:	a20fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202002:	00004697          	auipc	a3,0x4
ffffffffc0202006:	53e68693          	addi	a3,a3,1342 # ffffffffc0206540 <commands+0xbc8>
ffffffffc020200a:	00004617          	auipc	a2,0x4
ffffffffc020200e:	16660613          	addi	a2,a2,358 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202012:	0f100593          	li	a1,241
ffffffffc0202016:	00004517          	auipc	a0,0x4
ffffffffc020201a:	4d250513          	addi	a0,a0,1234 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020201e:	a00fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202022:	00004697          	auipc	a3,0x4
ffffffffc0202026:	53e68693          	addi	a3,a3,1342 # ffffffffc0206560 <commands+0xbe8>
ffffffffc020202a:	00004617          	auipc	a2,0x4
ffffffffc020202e:	14660613          	addi	a2,a2,326 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202032:	0d900593          	li	a1,217
ffffffffc0202036:	00004517          	auipc	a0,0x4
ffffffffc020203a:	4b250513          	addi	a0,a0,1202 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020203e:	9e0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(count == 0);
ffffffffc0202042:	00004697          	auipc	a3,0x4
ffffffffc0202046:	7c668693          	addi	a3,a3,1990 # ffffffffc0206808 <commands+0xe90>
ffffffffc020204a:	00004617          	auipc	a2,0x4
ffffffffc020204e:	12660613          	addi	a2,a2,294 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202052:	14600593          	li	a1,326
ffffffffc0202056:	00004517          	auipc	a0,0x4
ffffffffc020205a:	49250513          	addi	a0,a0,1170 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020205e:	9c0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(nr_free == 0);
ffffffffc0202062:	00004697          	auipc	a3,0x4
ffffffffc0202066:	64668693          	addi	a3,a3,1606 # ffffffffc02066a8 <commands+0xd30>
ffffffffc020206a:	00004617          	auipc	a2,0x4
ffffffffc020206e:	10660613          	addi	a2,a2,262 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202072:	13a00593          	li	a1,314
ffffffffc0202076:	00004517          	auipc	a0,0x4
ffffffffc020207a:	47250513          	addi	a0,a0,1138 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020207e:	9a0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202082:	00004697          	auipc	a3,0x4
ffffffffc0202086:	5c668693          	addi	a3,a3,1478 # ffffffffc0206648 <commands+0xcd0>
ffffffffc020208a:	00004617          	auipc	a2,0x4
ffffffffc020208e:	0e660613          	addi	a2,a2,230 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202092:	13800593          	li	a1,312
ffffffffc0202096:	00004517          	auipc	a0,0x4
ffffffffc020209a:	45250513          	addi	a0,a0,1106 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020209e:	980fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02020a2:	00004697          	auipc	a3,0x4
ffffffffc02020a6:	56668693          	addi	a3,a3,1382 # ffffffffc0206608 <commands+0xc90>
ffffffffc02020aa:	00004617          	auipc	a2,0x4
ffffffffc02020ae:	0c660613          	addi	a2,a2,198 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02020b2:	0df00593          	li	a1,223
ffffffffc02020b6:	00004517          	auipc	a0,0x4
ffffffffc02020ba:	43250513          	addi	a0,a0,1074 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02020be:	960fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02020c2:	00004697          	auipc	a3,0x4
ffffffffc02020c6:	70668693          	addi	a3,a3,1798 # ffffffffc02067c8 <commands+0xe50>
ffffffffc02020ca:	00004617          	auipc	a2,0x4
ffffffffc02020ce:	0a660613          	addi	a2,a2,166 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02020d2:	13200593          	li	a1,306
ffffffffc02020d6:	00004517          	auipc	a0,0x4
ffffffffc02020da:	41250513          	addi	a0,a0,1042 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02020de:	940fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02020e2:	00004697          	auipc	a3,0x4
ffffffffc02020e6:	6c668693          	addi	a3,a3,1734 # ffffffffc02067a8 <commands+0xe30>
ffffffffc02020ea:	00004617          	auipc	a2,0x4
ffffffffc02020ee:	08660613          	addi	a2,a2,134 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02020f2:	13000593          	li	a1,304
ffffffffc02020f6:	00004517          	auipc	a0,0x4
ffffffffc02020fa:	3f250513          	addi	a0,a0,1010 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02020fe:	920fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202102:	00004697          	auipc	a3,0x4
ffffffffc0202106:	67e68693          	addi	a3,a3,1662 # ffffffffc0206780 <commands+0xe08>
ffffffffc020210a:	00004617          	auipc	a2,0x4
ffffffffc020210e:	06660613          	addi	a2,a2,102 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202112:	12e00593          	li	a1,302
ffffffffc0202116:	00004517          	auipc	a0,0x4
ffffffffc020211a:	3d250513          	addi	a0,a0,978 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020211e:	900fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0202122:	00004697          	auipc	a3,0x4
ffffffffc0202126:	63668693          	addi	a3,a3,1590 # ffffffffc0206758 <commands+0xde0>
ffffffffc020212a:	00004617          	auipc	a2,0x4
ffffffffc020212e:	04660613          	addi	a2,a2,70 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202132:	12d00593          	li	a1,301
ffffffffc0202136:	00004517          	auipc	a0,0x4
ffffffffc020213a:	3b250513          	addi	a0,a0,946 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020213e:	8e0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(p0 + 2 == p1);
ffffffffc0202142:	00004697          	auipc	a3,0x4
ffffffffc0202146:	60668693          	addi	a3,a3,1542 # ffffffffc0206748 <commands+0xdd0>
ffffffffc020214a:	00004617          	auipc	a2,0x4
ffffffffc020214e:	02660613          	addi	a2,a2,38 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202152:	12800593          	li	a1,296
ffffffffc0202156:	00004517          	auipc	a0,0x4
ffffffffc020215a:	39250513          	addi	a0,a0,914 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020215e:	8c0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202162:	00004697          	auipc	a3,0x4
ffffffffc0202166:	4e668693          	addi	a3,a3,1254 # ffffffffc0206648 <commands+0xcd0>
ffffffffc020216a:	00004617          	auipc	a2,0x4
ffffffffc020216e:	00660613          	addi	a2,a2,6 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202172:	12700593          	li	a1,295
ffffffffc0202176:	00004517          	auipc	a0,0x4
ffffffffc020217a:	37250513          	addi	a0,a0,882 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020217e:	8a0fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0202182:	00004697          	auipc	a3,0x4
ffffffffc0202186:	5a668693          	addi	a3,a3,1446 # ffffffffc0206728 <commands+0xdb0>
ffffffffc020218a:	00004617          	auipc	a2,0x4
ffffffffc020218e:	fe660613          	addi	a2,a2,-26 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202192:	12600593          	li	a1,294
ffffffffc0202196:	00004517          	auipc	a0,0x4
ffffffffc020219a:	35250513          	addi	a0,a0,850 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020219e:	880fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02021a2:	00004697          	auipc	a3,0x4
ffffffffc02021a6:	55668693          	addi	a3,a3,1366 # ffffffffc02066f8 <commands+0xd80>
ffffffffc02021aa:	00004617          	auipc	a2,0x4
ffffffffc02021ae:	fc660613          	addi	a2,a2,-58 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02021b2:	12500593          	li	a1,293
ffffffffc02021b6:	00004517          	auipc	a0,0x4
ffffffffc02021ba:	33250513          	addi	a0,a0,818 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02021be:	860fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02021c2:	00004697          	auipc	a3,0x4
ffffffffc02021c6:	51e68693          	addi	a3,a3,1310 # ffffffffc02066e0 <commands+0xd68>
ffffffffc02021ca:	00004617          	auipc	a2,0x4
ffffffffc02021ce:	fa660613          	addi	a2,a2,-90 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02021d2:	12400593          	li	a1,292
ffffffffc02021d6:	00004517          	auipc	a0,0x4
ffffffffc02021da:	31250513          	addi	a0,a0,786 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02021de:	840fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02021e2:	00004697          	auipc	a3,0x4
ffffffffc02021e6:	46668693          	addi	a3,a3,1126 # ffffffffc0206648 <commands+0xcd0>
ffffffffc02021ea:	00004617          	auipc	a2,0x4
ffffffffc02021ee:	f8660613          	addi	a2,a2,-122 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02021f2:	11e00593          	li	a1,286
ffffffffc02021f6:	00004517          	auipc	a0,0x4
ffffffffc02021fa:	2f250513          	addi	a0,a0,754 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02021fe:	820fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(!PageProperty(p0));
ffffffffc0202202:	00004697          	auipc	a3,0x4
ffffffffc0202206:	4c668693          	addi	a3,a3,1222 # ffffffffc02066c8 <commands+0xd50>
ffffffffc020220a:	00004617          	auipc	a2,0x4
ffffffffc020220e:	f6660613          	addi	a2,a2,-154 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202212:	11900593          	li	a1,281
ffffffffc0202216:	00004517          	auipc	a0,0x4
ffffffffc020221a:	2d250513          	addi	a0,a0,722 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020221e:	800fe0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0202222:	00004697          	auipc	a3,0x4
ffffffffc0202226:	5c668693          	addi	a3,a3,1478 # ffffffffc02067e8 <commands+0xe70>
ffffffffc020222a:	00004617          	auipc	a2,0x4
ffffffffc020222e:	f4660613          	addi	a2,a2,-186 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202232:	13700593          	li	a1,311
ffffffffc0202236:	00004517          	auipc	a0,0x4
ffffffffc020223a:	2b250513          	addi	a0,a0,690 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020223e:	fe1fd0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(total == 0);
ffffffffc0202242:	00004697          	auipc	a3,0x4
ffffffffc0202246:	5d668693          	addi	a3,a3,1494 # ffffffffc0206818 <commands+0xea0>
ffffffffc020224a:	00004617          	auipc	a2,0x4
ffffffffc020224e:	f2660613          	addi	a2,a2,-218 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202252:	14700593          	li	a1,327
ffffffffc0202256:	00004517          	auipc	a0,0x4
ffffffffc020225a:	29250513          	addi	a0,a0,658 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020225e:	fc1fd0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(total == nr_free_pages());
ffffffffc0202262:	00004697          	auipc	a3,0x4
ffffffffc0202266:	29e68693          	addi	a3,a3,670 # ffffffffc0206500 <commands+0xb88>
ffffffffc020226a:	00004617          	auipc	a2,0x4
ffffffffc020226e:	f0660613          	addi	a2,a2,-250 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202272:	11300593          	li	a1,275
ffffffffc0202276:	00004517          	auipc	a0,0x4
ffffffffc020227a:	27250513          	addi	a0,a0,626 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020227e:	fa1fd0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202282:	00004697          	auipc	a3,0x4
ffffffffc0202286:	2be68693          	addi	a3,a3,702 # ffffffffc0206540 <commands+0xbc8>
ffffffffc020228a:	00004617          	auipc	a2,0x4
ffffffffc020228e:	ee660613          	addi	a2,a2,-282 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202292:	0d800593          	li	a1,216
ffffffffc0202296:	00004517          	auipc	a0,0x4
ffffffffc020229a:	25250513          	addi	a0,a0,594 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020229e:	f81fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02022a2 <default_free_pages>:
{
ffffffffc02022a2:	1141                	addi	sp,sp,-16
ffffffffc02022a4:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02022a6:	14058463          	beqz	a1,ffffffffc02023ee <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc02022aa:	00659693          	slli	a3,a1,0x6
ffffffffc02022ae:	96aa                	add	a3,a3,a0
ffffffffc02022b0:	87aa                	mv	a5,a0
ffffffffc02022b2:	02d50263          	beq	a0,a3,ffffffffc02022d6 <default_free_pages+0x34>
ffffffffc02022b6:	6798                	ld	a4,8(a5)
ffffffffc02022b8:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02022ba:	10071a63          	bnez	a4,ffffffffc02023ce <default_free_pages+0x12c>
ffffffffc02022be:	6798                	ld	a4,8(a5)
ffffffffc02022c0:	8b09                	andi	a4,a4,2
ffffffffc02022c2:	10071663          	bnez	a4,ffffffffc02023ce <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc02022c6:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc02022ca:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02022ce:	04078793          	addi	a5,a5,64
ffffffffc02022d2:	fed792e3          	bne	a5,a3,ffffffffc02022b6 <default_free_pages+0x14>
    base->property = n;
ffffffffc02022d6:	2581                	sext.w	a1,a1
ffffffffc02022d8:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02022da:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02022de:	4789                	li	a5,2
ffffffffc02022e0:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02022e4:	000a4697          	auipc	a3,0xa4
ffffffffc02022e8:	34c68693          	addi	a3,a3,844 # ffffffffc02a6630 <free_area>
ffffffffc02022ec:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02022ee:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02022f0:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02022f4:	9db9                	addw	a1,a1,a4
ffffffffc02022f6:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02022f8:	0ad78463          	beq	a5,a3,ffffffffc02023a0 <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02022fc:	fe878713          	addi	a4,a5,-24
ffffffffc0202300:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc0202304:	4581                	li	a1,0
            if (base < page)
ffffffffc0202306:	00e56a63          	bltu	a0,a4,ffffffffc020231a <default_free_pages+0x78>
    return listelm->next;
ffffffffc020230a:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc020230c:	04d70c63          	beq	a4,a3,ffffffffc0202364 <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc0202310:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0202312:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0202316:	fee57ae3          	bgeu	a0,a4,ffffffffc020230a <default_free_pages+0x68>
ffffffffc020231a:	c199                	beqz	a1,ffffffffc0202320 <default_free_pages+0x7e>
ffffffffc020231c:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202320:	6398                	ld	a4,0(a5)
    prev->next = next->prev = elm;
ffffffffc0202322:	e390                	sd	a2,0(a5)
ffffffffc0202324:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202326:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202328:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc020232a:	00d70d63          	beq	a4,a3,ffffffffc0202344 <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc020232e:	ff872583          	lw	a1,-8(a4) # ff8 <_binary_obj___user_faultread_out_size-0x8bb0>
        p = le2page(le, page_link);
ffffffffc0202332:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc0202336:	02059813          	slli	a6,a1,0x20
ffffffffc020233a:	01a85793          	srli	a5,a6,0x1a
ffffffffc020233e:	97b2                	add	a5,a5,a2
ffffffffc0202340:	02f50c63          	beq	a0,a5,ffffffffc0202378 <default_free_pages+0xd6>
    return listelm->next;
ffffffffc0202344:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc0202346:	00d78c63          	beq	a5,a3,ffffffffc020235e <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc020234a:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc020234c:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc0202350:	02061593          	slli	a1,a2,0x20
ffffffffc0202354:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0202358:	972a                	add	a4,a4,a0
ffffffffc020235a:	04e68a63          	beq	a3,a4,ffffffffc02023ae <default_free_pages+0x10c>
}
ffffffffc020235e:	60a2                	ld	ra,8(sp)
ffffffffc0202360:	0141                	addi	sp,sp,16
ffffffffc0202362:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0202364:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202366:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0202368:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020236a:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020236c:	02d70763          	beq	a4,a3,ffffffffc020239a <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc0202370:	8832                	mv	a6,a2
ffffffffc0202372:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0202374:	87ba                	mv	a5,a4
ffffffffc0202376:	bf71                	j	ffffffffc0202312 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0202378:	491c                	lw	a5,16(a0)
ffffffffc020237a:	9dbd                	addw	a1,a1,a5
ffffffffc020237c:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202380:	57f5                	li	a5,-3
ffffffffc0202382:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202386:	01853803          	ld	a6,24(a0)
ffffffffc020238a:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc020238c:	8532                	mv	a0,a2
    prev->next = next;
ffffffffc020238e:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0202392:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc0202394:	0105b023          	sd	a6,0(a1) # 1000 <_binary_obj___user_faultread_out_size-0x8ba8>
ffffffffc0202398:	b77d                	j	ffffffffc0202346 <default_free_pages+0xa4>
ffffffffc020239a:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc020239c:	873e                	mv	a4,a5
ffffffffc020239e:	bf41                	j	ffffffffc020232e <default_free_pages+0x8c>
}
ffffffffc02023a0:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02023a2:	e390                	sd	a2,0(a5)
ffffffffc02023a4:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02023a6:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02023a8:	ed1c                	sd	a5,24(a0)
ffffffffc02023aa:	0141                	addi	sp,sp,16
ffffffffc02023ac:	8082                	ret
            base->property += p->property;
ffffffffc02023ae:	ff87a703          	lw	a4,-8(a5)
ffffffffc02023b2:	ff078693          	addi	a3,a5,-16
ffffffffc02023b6:	9e39                	addw	a2,a2,a4
ffffffffc02023b8:	c910                	sw	a2,16(a0)
ffffffffc02023ba:	5775                	li	a4,-3
ffffffffc02023bc:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02023c0:	6398                	ld	a4,0(a5)
ffffffffc02023c2:	679c                	ld	a5,8(a5)
}
ffffffffc02023c4:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02023c6:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02023c8:	e398                	sd	a4,0(a5)
ffffffffc02023ca:	0141                	addi	sp,sp,16
ffffffffc02023cc:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02023ce:	00004697          	auipc	a3,0x4
ffffffffc02023d2:	46268693          	addi	a3,a3,1122 # ffffffffc0206830 <commands+0xeb8>
ffffffffc02023d6:	00004617          	auipc	a2,0x4
ffffffffc02023da:	d9a60613          	addi	a2,a2,-614 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02023de:	09400593          	li	a1,148
ffffffffc02023e2:	00004517          	auipc	a0,0x4
ffffffffc02023e6:	10650513          	addi	a0,a0,262 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02023ea:	e35fd0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(n > 0);
ffffffffc02023ee:	00004697          	auipc	a3,0x4
ffffffffc02023f2:	43a68693          	addi	a3,a3,1082 # ffffffffc0206828 <commands+0xeb0>
ffffffffc02023f6:	00004617          	auipc	a2,0x4
ffffffffc02023fa:	d7a60613          	addi	a2,a2,-646 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02023fe:	09000593          	li	a1,144
ffffffffc0202402:	00004517          	auipc	a0,0x4
ffffffffc0202406:	0e650513          	addi	a0,a0,230 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020240a:	e15fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc020240e <default_alloc_pages>:
    assert(n > 0);
ffffffffc020240e:	c941                	beqz	a0,ffffffffc020249e <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc0202410:	000a4597          	auipc	a1,0xa4
ffffffffc0202414:	22058593          	addi	a1,a1,544 # ffffffffc02a6630 <free_area>
ffffffffc0202418:	0105a803          	lw	a6,16(a1)
ffffffffc020241c:	872a                	mv	a4,a0
ffffffffc020241e:	02081793          	slli	a5,a6,0x20
ffffffffc0202422:	9381                	srli	a5,a5,0x20
ffffffffc0202424:	00a7ee63          	bltu	a5,a0,ffffffffc0202440 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0202428:	87ae                	mv	a5,a1
ffffffffc020242a:	a801                	j	ffffffffc020243a <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc020242c:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202430:	02069613          	slli	a2,a3,0x20
ffffffffc0202434:	9201                	srli	a2,a2,0x20
ffffffffc0202436:	00e67763          	bgeu	a2,a4,ffffffffc0202444 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc020243a:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc020243c:	feb798e3          	bne	a5,a1,ffffffffc020242c <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0202440:	4501                	li	a0,0
}
ffffffffc0202442:	8082                	ret
    return listelm->prev;
ffffffffc0202444:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202448:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020244c:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc0202450:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc0202454:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0202458:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc020245c:	02c77863          	bgeu	a4,a2,ffffffffc020248c <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0202460:	071a                	slli	a4,a4,0x6
ffffffffc0202462:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0202464:	41c686bb          	subw	a3,a3,t3
ffffffffc0202468:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020246a:	00870613          	addi	a2,a4,8
ffffffffc020246e:	4689                	li	a3,2
ffffffffc0202470:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0202474:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0202478:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc020247c:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0202480:	e290                	sd	a2,0(a3)
ffffffffc0202482:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0202486:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0202488:	01173c23          	sd	a7,24(a4)
ffffffffc020248c:	41c8083b          	subw	a6,a6,t3
ffffffffc0202490:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202494:	5775                	li	a4,-3
ffffffffc0202496:	17c1                	addi	a5,a5,-16
ffffffffc0202498:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020249c:	8082                	ret
{
ffffffffc020249e:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc02024a0:	00004697          	auipc	a3,0x4
ffffffffc02024a4:	38868693          	addi	a3,a3,904 # ffffffffc0206828 <commands+0xeb0>
ffffffffc02024a8:	00004617          	auipc	a2,0x4
ffffffffc02024ac:	cc860613          	addi	a2,a2,-824 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02024b0:	06c00593          	li	a1,108
ffffffffc02024b4:	00004517          	auipc	a0,0x4
ffffffffc02024b8:	03450513          	addi	a0,a0,52 # ffffffffc02064e8 <commands+0xb70>
{
ffffffffc02024bc:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02024be:	d61fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02024c2 <default_init_memmap>:
{
ffffffffc02024c2:	1141                	addi	sp,sp,-16
ffffffffc02024c4:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02024c6:	c5f1                	beqz	a1,ffffffffc0202592 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc02024c8:	00659693          	slli	a3,a1,0x6
ffffffffc02024cc:	96aa                	add	a3,a3,a0
ffffffffc02024ce:	87aa                	mv	a5,a0
ffffffffc02024d0:	00d50f63          	beq	a0,a3,ffffffffc02024ee <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02024d4:	6798                	ld	a4,8(a5)
ffffffffc02024d6:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02024d8:	cf49                	beqz	a4,ffffffffc0202572 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02024da:	0007a823          	sw	zero,16(a5)
ffffffffc02024de:	0007b423          	sd	zero,8(a5)
ffffffffc02024e2:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02024e6:	04078793          	addi	a5,a5,64
ffffffffc02024ea:	fed795e3          	bne	a5,a3,ffffffffc02024d4 <default_init_memmap+0x12>
    base->property = n;
ffffffffc02024ee:	2581                	sext.w	a1,a1
ffffffffc02024f0:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02024f2:	4789                	li	a5,2
ffffffffc02024f4:	00850713          	addi	a4,a0,8
ffffffffc02024f8:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02024fc:	000a4697          	auipc	a3,0xa4
ffffffffc0202500:	13468693          	addi	a3,a3,308 # ffffffffc02a6630 <free_area>
ffffffffc0202504:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0202506:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc0202508:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc020250c:	9db9                	addw	a1,a1,a4
ffffffffc020250e:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc0202510:	04d78a63          	beq	a5,a3,ffffffffc0202564 <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc0202514:	fe878713          	addi	a4,a5,-24
ffffffffc0202518:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc020251c:	4581                	li	a1,0
            if (base < page)
ffffffffc020251e:	00e56a63          	bltu	a0,a4,ffffffffc0202532 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0202522:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc0202524:	02d70263          	beq	a4,a3,ffffffffc0202548 <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc0202528:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc020252a:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc020252e:	fee57ae3          	bgeu	a0,a4,ffffffffc0202522 <default_init_memmap+0x60>
ffffffffc0202532:	c199                	beqz	a1,ffffffffc0202538 <default_init_memmap+0x76>
ffffffffc0202534:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202538:	6398                	ld	a4,0(a5)
}
ffffffffc020253a:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc020253c:	e390                	sd	a2,0(a5)
ffffffffc020253e:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202540:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202542:	ed18                	sd	a4,24(a0)
ffffffffc0202544:	0141                	addi	sp,sp,16
ffffffffc0202546:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0202548:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020254a:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020254c:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020254e:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0202550:	00d70663          	beq	a4,a3,ffffffffc020255c <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0202554:	8832                	mv	a6,a2
ffffffffc0202556:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0202558:	87ba                	mv	a5,a4
ffffffffc020255a:	bfc1                	j	ffffffffc020252a <default_init_memmap+0x68>
}
ffffffffc020255c:	60a2                	ld	ra,8(sp)
ffffffffc020255e:	e290                	sd	a2,0(a3)
ffffffffc0202560:	0141                	addi	sp,sp,16
ffffffffc0202562:	8082                	ret
ffffffffc0202564:	60a2                	ld	ra,8(sp)
ffffffffc0202566:	e390                	sd	a2,0(a5)
ffffffffc0202568:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020256a:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020256c:	ed1c                	sd	a5,24(a0)
ffffffffc020256e:	0141                	addi	sp,sp,16
ffffffffc0202570:	8082                	ret
        assert(PageReserved(p));
ffffffffc0202572:	00004697          	auipc	a3,0x4
ffffffffc0202576:	2e668693          	addi	a3,a3,742 # ffffffffc0206858 <commands+0xee0>
ffffffffc020257a:	00004617          	auipc	a2,0x4
ffffffffc020257e:	bf660613          	addi	a2,a2,-1034 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202582:	04b00593          	li	a1,75
ffffffffc0202586:	00004517          	auipc	a0,0x4
ffffffffc020258a:	f6250513          	addi	a0,a0,-158 # ffffffffc02064e8 <commands+0xb70>
ffffffffc020258e:	c91fd0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(n > 0);
ffffffffc0202592:	00004697          	auipc	a3,0x4
ffffffffc0202596:	29668693          	addi	a3,a3,662 # ffffffffc0206828 <commands+0xeb0>
ffffffffc020259a:	00004617          	auipc	a2,0x4
ffffffffc020259e:	bd660613          	addi	a2,a2,-1066 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02025a2:	04700593          	li	a1,71
ffffffffc02025a6:	00004517          	auipc	a0,0x4
ffffffffc02025aa:	f4250513          	addi	a0,a0,-190 # ffffffffc02064e8 <commands+0xb70>
ffffffffc02025ae:	c71fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02025b2 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc02025b2:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc02025b4:	00004617          	auipc	a2,0x4
ffffffffc02025b8:	f0460613          	addi	a2,a2,-252 # ffffffffc02064b8 <commands+0xb40>
ffffffffc02025bc:	06900593          	li	a1,105
ffffffffc02025c0:	00004517          	auipc	a0,0x4
ffffffffc02025c4:	e5050513          	addi	a0,a0,-432 # ffffffffc0206410 <commands+0xa98>
pa2page(uintptr_t pa)
ffffffffc02025c8:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc02025ca:	c55fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02025ce <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc02025ce:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc02025d0:	00004617          	auipc	a2,0x4
ffffffffc02025d4:	2e860613          	addi	a2,a2,744 # ffffffffc02068b8 <default_pmm_manager+0x38>
ffffffffc02025d8:	07f00593          	li	a1,127
ffffffffc02025dc:	00004517          	auipc	a0,0x4
ffffffffc02025e0:	e3450513          	addi	a0,a0,-460 # ffffffffc0206410 <commands+0xa98>
pte2page(pte_t pte)
ffffffffc02025e4:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc02025e6:	c39fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02025ea <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02025ea:	100027f3          	csrr	a5,sstatus
ffffffffc02025ee:	8b89                	andi	a5,a5,2
ffffffffc02025f0:	e799                	bnez	a5,ffffffffc02025fe <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc02025f2:	000a8797          	auipc	a5,0xa8
ffffffffc02025f6:	0be7b783          	ld	a5,190(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc02025fa:	6f9c                	ld	a5,24(a5)
ffffffffc02025fc:	8782                	jr	a5
{
ffffffffc02025fe:	1141                	addi	sp,sp,-16
ffffffffc0202600:	e406                	sd	ra,8(sp)
ffffffffc0202602:	e022                	sd	s0,0(sp)
ffffffffc0202604:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0202606:	bb4fe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc020260a:	000a8797          	auipc	a5,0xa8
ffffffffc020260e:	0a67b783          	ld	a5,166(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202612:	6f9c                	ld	a5,24(a5)
ffffffffc0202614:	8522                	mv	a0,s0
ffffffffc0202616:	9782                	jalr	a5
ffffffffc0202618:	842a                	mv	s0,a0
        intr_enable();
ffffffffc020261a:	b9afe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc020261e:	60a2                	ld	ra,8(sp)
ffffffffc0202620:	8522                	mv	a0,s0
ffffffffc0202622:	6402                	ld	s0,0(sp)
ffffffffc0202624:	0141                	addi	sp,sp,16
ffffffffc0202626:	8082                	ret

ffffffffc0202628 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202628:	100027f3          	csrr	a5,sstatus
ffffffffc020262c:	8b89                	andi	a5,a5,2
ffffffffc020262e:	e799                	bnez	a5,ffffffffc020263c <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0202630:	000a8797          	auipc	a5,0xa8
ffffffffc0202634:	0807b783          	ld	a5,128(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202638:	739c                	ld	a5,32(a5)
ffffffffc020263a:	8782                	jr	a5
{
ffffffffc020263c:	1101                	addi	sp,sp,-32
ffffffffc020263e:	ec06                	sd	ra,24(sp)
ffffffffc0202640:	e822                	sd	s0,16(sp)
ffffffffc0202642:	e426                	sd	s1,8(sp)
ffffffffc0202644:	842a                	mv	s0,a0
ffffffffc0202646:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0202648:	b72fe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020264c:	000a8797          	auipc	a5,0xa8
ffffffffc0202650:	0647b783          	ld	a5,100(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202654:	739c                	ld	a5,32(a5)
ffffffffc0202656:	85a6                	mv	a1,s1
ffffffffc0202658:	8522                	mv	a0,s0
ffffffffc020265a:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc020265c:	6442                	ld	s0,16(sp)
ffffffffc020265e:	60e2                	ld	ra,24(sp)
ffffffffc0202660:	64a2                	ld	s1,8(sp)
ffffffffc0202662:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0202664:	b50fe06f          	j	ffffffffc02009b4 <intr_enable>

ffffffffc0202668 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202668:	100027f3          	csrr	a5,sstatus
ffffffffc020266c:	8b89                	andi	a5,a5,2
ffffffffc020266e:	e799                	bnez	a5,ffffffffc020267c <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0202670:	000a8797          	auipc	a5,0xa8
ffffffffc0202674:	0407b783          	ld	a5,64(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202678:	779c                	ld	a5,40(a5)
ffffffffc020267a:	8782                	jr	a5
{
ffffffffc020267c:	1141                	addi	sp,sp,-16
ffffffffc020267e:	e406                	sd	ra,8(sp)
ffffffffc0202680:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0202682:	b38fe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202686:	000a8797          	auipc	a5,0xa8
ffffffffc020268a:	02a7b783          	ld	a5,42(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc020268e:	779c                	ld	a5,40(a5)
ffffffffc0202690:	9782                	jalr	a5
ffffffffc0202692:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202694:	b20fe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0202698:	60a2                	ld	ra,8(sp)
ffffffffc020269a:	8522                	mv	a0,s0
ffffffffc020269c:	6402                	ld	s0,0(sp)
ffffffffc020269e:	0141                	addi	sp,sp,16
ffffffffc02026a0:	8082                	ret

ffffffffc02026a2 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc02026a2:	01e5d793          	srli	a5,a1,0x1e
ffffffffc02026a6:	1ff7f793          	andi	a5,a5,511
{
ffffffffc02026aa:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc02026ac:	078e                	slli	a5,a5,0x3
{
ffffffffc02026ae:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc02026b0:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc02026b4:	6094                	ld	a3,0(s1)
{
ffffffffc02026b6:	f04a                	sd	s2,32(sp)
ffffffffc02026b8:	ec4e                	sd	s3,24(sp)
ffffffffc02026ba:	e852                	sd	s4,16(sp)
ffffffffc02026bc:	fc06                	sd	ra,56(sp)
ffffffffc02026be:	f822                	sd	s0,48(sp)
ffffffffc02026c0:	e456                	sd	s5,8(sp)
ffffffffc02026c2:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc02026c4:	0016f793          	andi	a5,a3,1
{
ffffffffc02026c8:	892e                	mv	s2,a1
ffffffffc02026ca:	8a32                	mv	s4,a2
ffffffffc02026cc:	000a8997          	auipc	s3,0xa8
ffffffffc02026d0:	fd498993          	addi	s3,s3,-44 # ffffffffc02aa6a0 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc02026d4:	efbd                	bnez	a5,ffffffffc0202752 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc02026d6:	14060c63          	beqz	a2,ffffffffc020282e <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02026da:	100027f3          	csrr	a5,sstatus
ffffffffc02026de:	8b89                	andi	a5,a5,2
ffffffffc02026e0:	14079963          	bnez	a5,ffffffffc0202832 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc02026e4:	000a8797          	auipc	a5,0xa8
ffffffffc02026e8:	fcc7b783          	ld	a5,-52(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc02026ec:	6f9c                	ld	a5,24(a5)
ffffffffc02026ee:	4505                	li	a0,1
ffffffffc02026f0:	9782                	jalr	a5
ffffffffc02026f2:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc02026f4:	12040d63          	beqz	s0,ffffffffc020282e <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc02026f8:	000a8b17          	auipc	s6,0xa8
ffffffffc02026fc:	fb0b0b13          	addi	s6,s6,-80 # ffffffffc02aa6a8 <pages>
ffffffffc0202700:	000b3503          	ld	a0,0(s6)
ffffffffc0202704:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202708:	000a8997          	auipc	s3,0xa8
ffffffffc020270c:	f9898993          	addi	s3,s3,-104 # ffffffffc02aa6a0 <npage>
ffffffffc0202710:	40a40533          	sub	a0,s0,a0
ffffffffc0202714:	8519                	srai	a0,a0,0x6
ffffffffc0202716:	9556                	add	a0,a0,s5
ffffffffc0202718:	0009b703          	ld	a4,0(s3)
ffffffffc020271c:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202720:	4685                	li	a3,1
ffffffffc0202722:	c014                	sw	a3,0(s0)
ffffffffc0202724:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202726:	0532                	slli	a0,a0,0xc
ffffffffc0202728:	16e7f763          	bgeu	a5,a4,ffffffffc0202896 <get_pte+0x1f4>
ffffffffc020272c:	000a8797          	auipc	a5,0xa8
ffffffffc0202730:	f8c7b783          	ld	a5,-116(a5) # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0202734:	6605                	lui	a2,0x1
ffffffffc0202736:	4581                	li	a1,0
ffffffffc0202738:	953e                	add	a0,a0,a5
ffffffffc020273a:	369020ef          	jal	ra,ffffffffc02052a2 <memset>
    return page - pages + nbase;
ffffffffc020273e:	000b3683          	ld	a3,0(s6)
ffffffffc0202742:	40d406b3          	sub	a3,s0,a3
ffffffffc0202746:	8699                	srai	a3,a3,0x6
ffffffffc0202748:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020274a:	06aa                	slli	a3,a3,0xa
ffffffffc020274c:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0202750:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202752:	77fd                	lui	a5,0xfffff
ffffffffc0202754:	068a                	slli	a3,a3,0x2
ffffffffc0202756:	0009b703          	ld	a4,0(s3)
ffffffffc020275a:	8efd                	and	a3,a3,a5
ffffffffc020275c:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202760:	10e7ff63          	bgeu	a5,a4,ffffffffc020287e <get_pte+0x1dc>
ffffffffc0202764:	000a8a97          	auipc	s5,0xa8
ffffffffc0202768:	f54a8a93          	addi	s5,s5,-172 # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc020276c:	000ab403          	ld	s0,0(s5)
ffffffffc0202770:	01595793          	srli	a5,s2,0x15
ffffffffc0202774:	1ff7f793          	andi	a5,a5,511
ffffffffc0202778:	96a2                	add	a3,a3,s0
ffffffffc020277a:	00379413          	slli	s0,a5,0x3
ffffffffc020277e:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc0202780:	6014                	ld	a3,0(s0)
ffffffffc0202782:	0016f793          	andi	a5,a3,1
ffffffffc0202786:	ebad                	bnez	a5,ffffffffc02027f8 <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0202788:	0a0a0363          	beqz	s4,ffffffffc020282e <get_pte+0x18c>
ffffffffc020278c:	100027f3          	csrr	a5,sstatus
ffffffffc0202790:	8b89                	andi	a5,a5,2
ffffffffc0202792:	efcd                	bnez	a5,ffffffffc020284c <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202794:	000a8797          	auipc	a5,0xa8
ffffffffc0202798:	f1c7b783          	ld	a5,-228(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc020279c:	6f9c                	ld	a5,24(a5)
ffffffffc020279e:	4505                	li	a0,1
ffffffffc02027a0:	9782                	jalr	a5
ffffffffc02027a2:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc02027a4:	c4c9                	beqz	s1,ffffffffc020282e <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc02027a6:	000a8b17          	auipc	s6,0xa8
ffffffffc02027aa:	f02b0b13          	addi	s6,s6,-254 # ffffffffc02aa6a8 <pages>
ffffffffc02027ae:	000b3503          	ld	a0,0(s6)
ffffffffc02027b2:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc02027b6:	0009b703          	ld	a4,0(s3)
ffffffffc02027ba:	40a48533          	sub	a0,s1,a0
ffffffffc02027be:	8519                	srai	a0,a0,0x6
ffffffffc02027c0:	9552                	add	a0,a0,s4
ffffffffc02027c2:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc02027c6:	4685                	li	a3,1
ffffffffc02027c8:	c094                	sw	a3,0(s1)
ffffffffc02027ca:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02027cc:	0532                	slli	a0,a0,0xc
ffffffffc02027ce:	0ee7f163          	bgeu	a5,a4,ffffffffc02028b0 <get_pte+0x20e>
ffffffffc02027d2:	000ab783          	ld	a5,0(s5)
ffffffffc02027d6:	6605                	lui	a2,0x1
ffffffffc02027d8:	4581                	li	a1,0
ffffffffc02027da:	953e                	add	a0,a0,a5
ffffffffc02027dc:	2c7020ef          	jal	ra,ffffffffc02052a2 <memset>
    return page - pages + nbase;
ffffffffc02027e0:	000b3683          	ld	a3,0(s6)
ffffffffc02027e4:	40d486b3          	sub	a3,s1,a3
ffffffffc02027e8:	8699                	srai	a3,a3,0x6
ffffffffc02027ea:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02027ec:	06aa                	slli	a3,a3,0xa
ffffffffc02027ee:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02027f2:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02027f4:	0009b703          	ld	a4,0(s3)
ffffffffc02027f8:	068a                	slli	a3,a3,0x2
ffffffffc02027fa:	757d                	lui	a0,0xfffff
ffffffffc02027fc:	8ee9                	and	a3,a3,a0
ffffffffc02027fe:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202802:	06e7f263          	bgeu	a5,a4,ffffffffc0202866 <get_pte+0x1c4>
ffffffffc0202806:	000ab503          	ld	a0,0(s5)
ffffffffc020280a:	00c95913          	srli	s2,s2,0xc
ffffffffc020280e:	1ff97913          	andi	s2,s2,511
ffffffffc0202812:	96aa                	add	a3,a3,a0
ffffffffc0202814:	00391513          	slli	a0,s2,0x3
ffffffffc0202818:	9536                	add	a0,a0,a3
}
ffffffffc020281a:	70e2                	ld	ra,56(sp)
ffffffffc020281c:	7442                	ld	s0,48(sp)
ffffffffc020281e:	74a2                	ld	s1,40(sp)
ffffffffc0202820:	7902                	ld	s2,32(sp)
ffffffffc0202822:	69e2                	ld	s3,24(sp)
ffffffffc0202824:	6a42                	ld	s4,16(sp)
ffffffffc0202826:	6aa2                	ld	s5,8(sp)
ffffffffc0202828:	6b02                	ld	s6,0(sp)
ffffffffc020282a:	6121                	addi	sp,sp,64
ffffffffc020282c:	8082                	ret
            return NULL;
ffffffffc020282e:	4501                	li	a0,0
ffffffffc0202830:	b7ed                	j	ffffffffc020281a <get_pte+0x178>
        intr_disable();
ffffffffc0202832:	988fe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202836:	000a8797          	auipc	a5,0xa8
ffffffffc020283a:	e7a7b783          	ld	a5,-390(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc020283e:	6f9c                	ld	a5,24(a5)
ffffffffc0202840:	4505                	li	a0,1
ffffffffc0202842:	9782                	jalr	a5
ffffffffc0202844:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202846:	96efe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc020284a:	b56d                	j	ffffffffc02026f4 <get_pte+0x52>
        intr_disable();
ffffffffc020284c:	96efe0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0202850:	000a8797          	auipc	a5,0xa8
ffffffffc0202854:	e607b783          	ld	a5,-416(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202858:	6f9c                	ld	a5,24(a5)
ffffffffc020285a:	4505                	li	a0,1
ffffffffc020285c:	9782                	jalr	a5
ffffffffc020285e:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc0202860:	954fe0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0202864:	b781                	j	ffffffffc02027a4 <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202866:	00004617          	auipc	a2,0x4
ffffffffc020286a:	b8260613          	addi	a2,a2,-1150 # ffffffffc02063e8 <commands+0xa70>
ffffffffc020286e:	0fa00593          	li	a1,250
ffffffffc0202872:	00004517          	auipc	a0,0x4
ffffffffc0202876:	06e50513          	addi	a0,a0,110 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020287a:	9a5fd0ef          	jal	ra,ffffffffc020021e <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc020287e:	00004617          	auipc	a2,0x4
ffffffffc0202882:	b6a60613          	addi	a2,a2,-1174 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0202886:	0ed00593          	li	a1,237
ffffffffc020288a:	00004517          	auipc	a0,0x4
ffffffffc020288e:	05650513          	addi	a0,a0,86 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0202892:	98dfd0ef          	jal	ra,ffffffffc020021e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202896:	86aa                	mv	a3,a0
ffffffffc0202898:	00004617          	auipc	a2,0x4
ffffffffc020289c:	b5060613          	addi	a2,a2,-1200 # ffffffffc02063e8 <commands+0xa70>
ffffffffc02028a0:	0e900593          	li	a1,233
ffffffffc02028a4:	00004517          	auipc	a0,0x4
ffffffffc02028a8:	03c50513          	addi	a0,a0,60 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02028ac:	973fd0ef          	jal	ra,ffffffffc020021e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc02028b0:	86aa                	mv	a3,a0
ffffffffc02028b2:	00004617          	auipc	a2,0x4
ffffffffc02028b6:	b3660613          	addi	a2,a2,-1226 # ffffffffc02063e8 <commands+0xa70>
ffffffffc02028ba:	0f700593          	li	a1,247
ffffffffc02028be:	00004517          	auipc	a0,0x4
ffffffffc02028c2:	02250513          	addi	a0,a0,34 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02028c6:	959fd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02028ca <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc02028ca:	1141                	addi	sp,sp,-16
ffffffffc02028cc:	e022                	sd	s0,0(sp)
ffffffffc02028ce:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02028d0:	4601                	li	a2,0
{
ffffffffc02028d2:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02028d4:	dcfff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
    if (ptep_store != NULL)
ffffffffc02028d8:	c011                	beqz	s0,ffffffffc02028dc <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc02028da:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02028dc:	c511                	beqz	a0,ffffffffc02028e8 <get_page+0x1e>
ffffffffc02028de:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc02028e0:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02028e2:	0017f713          	andi	a4,a5,1
ffffffffc02028e6:	e709                	bnez	a4,ffffffffc02028f0 <get_page+0x26>
}
ffffffffc02028e8:	60a2                	ld	ra,8(sp)
ffffffffc02028ea:	6402                	ld	s0,0(sp)
ffffffffc02028ec:	0141                	addi	sp,sp,16
ffffffffc02028ee:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02028f0:	078a                	slli	a5,a5,0x2
ffffffffc02028f2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02028f4:	000a8717          	auipc	a4,0xa8
ffffffffc02028f8:	dac73703          	ld	a4,-596(a4) # ffffffffc02aa6a0 <npage>
ffffffffc02028fc:	00e7ff63          	bgeu	a5,a4,ffffffffc020291a <get_page+0x50>
ffffffffc0202900:	60a2                	ld	ra,8(sp)
ffffffffc0202902:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc0202904:	fff80537          	lui	a0,0xfff80
ffffffffc0202908:	97aa                	add	a5,a5,a0
ffffffffc020290a:	079a                	slli	a5,a5,0x6
ffffffffc020290c:	000a8517          	auipc	a0,0xa8
ffffffffc0202910:	d9c53503          	ld	a0,-612(a0) # ffffffffc02aa6a8 <pages>
ffffffffc0202914:	953e                	add	a0,a0,a5
ffffffffc0202916:	0141                	addi	sp,sp,16
ffffffffc0202918:	8082                	ret
ffffffffc020291a:	c99ff0ef          	jal	ra,ffffffffc02025b2 <pa2page.part.0>

ffffffffc020291e <unmap_range>:
        tlb_invalidate(pgdir, la);
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc020291e:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202920:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202924:	f486                	sd	ra,104(sp)
ffffffffc0202926:	f0a2                	sd	s0,96(sp)
ffffffffc0202928:	eca6                	sd	s1,88(sp)
ffffffffc020292a:	e8ca                	sd	s2,80(sp)
ffffffffc020292c:	e4ce                	sd	s3,72(sp)
ffffffffc020292e:	e0d2                	sd	s4,64(sp)
ffffffffc0202930:	fc56                	sd	s5,56(sp)
ffffffffc0202932:	f85a                	sd	s6,48(sp)
ffffffffc0202934:	f45e                	sd	s7,40(sp)
ffffffffc0202936:	f062                	sd	s8,32(sp)
ffffffffc0202938:	ec66                	sd	s9,24(sp)
ffffffffc020293a:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020293c:	17d2                	slli	a5,a5,0x34
ffffffffc020293e:	e3ed                	bnez	a5,ffffffffc0202a20 <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc0202940:	002007b7          	lui	a5,0x200
ffffffffc0202944:	842e                	mv	s0,a1
ffffffffc0202946:	0ef5ed63          	bltu	a1,a5,ffffffffc0202a40 <unmap_range+0x122>
ffffffffc020294a:	8932                	mv	s2,a2
ffffffffc020294c:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202a40 <unmap_range+0x122>
ffffffffc0202950:	4785                	li	a5,1
ffffffffc0202952:	07fe                	slli	a5,a5,0x1f
ffffffffc0202954:	0ec7e663          	bltu	a5,a2,ffffffffc0202a40 <unmap_range+0x122>
ffffffffc0202958:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc020295a:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc020295c:	000a8c97          	auipc	s9,0xa8
ffffffffc0202960:	d44c8c93          	addi	s9,s9,-700 # ffffffffc02aa6a0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0202964:	000a8c17          	auipc	s8,0xa8
ffffffffc0202968:	d44c0c13          	addi	s8,s8,-700 # ffffffffc02aa6a8 <pages>
ffffffffc020296c:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc0202970:	000a8d17          	auipc	s10,0xa8
ffffffffc0202974:	d40d0d13          	addi	s10,s10,-704 # ffffffffc02aa6b0 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202978:	00200b37          	lui	s6,0x200
ffffffffc020297c:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202980:	4601                	li	a2,0
ffffffffc0202982:	85a2                	mv	a1,s0
ffffffffc0202984:	854e                	mv	a0,s3
ffffffffc0202986:	d1dff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc020298a:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc020298c:	cd29                	beqz	a0,ffffffffc02029e6 <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc020298e:	611c                	ld	a5,0(a0)
ffffffffc0202990:	e395                	bnez	a5,ffffffffc02029b4 <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202992:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202994:	ff2466e3          	bltu	s0,s2,ffffffffc0202980 <unmap_range+0x62>
}
ffffffffc0202998:	70a6                	ld	ra,104(sp)
ffffffffc020299a:	7406                	ld	s0,96(sp)
ffffffffc020299c:	64e6                	ld	s1,88(sp)
ffffffffc020299e:	6946                	ld	s2,80(sp)
ffffffffc02029a0:	69a6                	ld	s3,72(sp)
ffffffffc02029a2:	6a06                	ld	s4,64(sp)
ffffffffc02029a4:	7ae2                	ld	s5,56(sp)
ffffffffc02029a6:	7b42                	ld	s6,48(sp)
ffffffffc02029a8:	7ba2                	ld	s7,40(sp)
ffffffffc02029aa:	7c02                	ld	s8,32(sp)
ffffffffc02029ac:	6ce2                	ld	s9,24(sp)
ffffffffc02029ae:	6d42                	ld	s10,16(sp)
ffffffffc02029b0:	6165                	addi	sp,sp,112
ffffffffc02029b2:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc02029b4:	0017f713          	andi	a4,a5,1
ffffffffc02029b8:	df69                	beqz	a4,ffffffffc0202992 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc02029ba:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc02029be:	078a                	slli	a5,a5,0x2
ffffffffc02029c0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029c2:	08e7ff63          	bgeu	a5,a4,ffffffffc0202a60 <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc02029c6:	000c3503          	ld	a0,0(s8)
ffffffffc02029ca:	97de                	add	a5,a5,s7
ffffffffc02029cc:	079a                	slli	a5,a5,0x6
ffffffffc02029ce:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02029d0:	411c                	lw	a5,0(a0)
ffffffffc02029d2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02029d6:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc02029d8:	cf11                	beqz	a4,ffffffffc02029f4 <unmap_range+0xd6>
        *ptep = 0;
ffffffffc02029da:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02029de:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc02029e2:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02029e4:	bf45                	j	ffffffffc0202994 <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02029e6:	945a                	add	s0,s0,s6
ffffffffc02029e8:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc02029ec:	d455                	beqz	s0,ffffffffc0202998 <unmap_range+0x7a>
ffffffffc02029ee:	f92469e3          	bltu	s0,s2,ffffffffc0202980 <unmap_range+0x62>
ffffffffc02029f2:	b75d                	j	ffffffffc0202998 <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02029f4:	100027f3          	csrr	a5,sstatus
ffffffffc02029f8:	8b89                	andi	a5,a5,2
ffffffffc02029fa:	e799                	bnez	a5,ffffffffc0202a08 <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc02029fc:	000d3783          	ld	a5,0(s10)
ffffffffc0202a00:	4585                	li	a1,1
ffffffffc0202a02:	739c                	ld	a5,32(a5)
ffffffffc0202a04:	9782                	jalr	a5
    if (flag)
ffffffffc0202a06:	bfd1                	j	ffffffffc02029da <unmap_range+0xbc>
ffffffffc0202a08:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202a0a:	fb1fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0202a0e:	000d3783          	ld	a5,0(s10)
ffffffffc0202a12:	6522                	ld	a0,8(sp)
ffffffffc0202a14:	4585                	li	a1,1
ffffffffc0202a16:	739c                	ld	a5,32(a5)
ffffffffc0202a18:	9782                	jalr	a5
        intr_enable();
ffffffffc0202a1a:	f9bfd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0202a1e:	bf75                	j	ffffffffc02029da <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202a20:	00004697          	auipc	a3,0x4
ffffffffc0202a24:	ed068693          	addi	a3,a3,-304 # ffffffffc02068f0 <default_pmm_manager+0x70>
ffffffffc0202a28:	00003617          	auipc	a2,0x3
ffffffffc0202a2c:	74860613          	addi	a2,a2,1864 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202a30:	12000593          	li	a1,288
ffffffffc0202a34:	00004517          	auipc	a0,0x4
ffffffffc0202a38:	eac50513          	addi	a0,a0,-340 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0202a3c:	fe2fd0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202a40:	00004697          	auipc	a3,0x4
ffffffffc0202a44:	ee068693          	addi	a3,a3,-288 # ffffffffc0206920 <default_pmm_manager+0xa0>
ffffffffc0202a48:	00003617          	auipc	a2,0x3
ffffffffc0202a4c:	72860613          	addi	a2,a2,1832 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202a50:	12100593          	li	a1,289
ffffffffc0202a54:	00004517          	auipc	a0,0x4
ffffffffc0202a58:	e8c50513          	addi	a0,a0,-372 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0202a5c:	fc2fd0ef          	jal	ra,ffffffffc020021e <__panic>
ffffffffc0202a60:	b53ff0ef          	jal	ra,ffffffffc02025b2 <pa2page.part.0>

ffffffffc0202a64 <exit_range>:
{
ffffffffc0202a64:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202a66:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202a6a:	fc86                	sd	ra,120(sp)
ffffffffc0202a6c:	f8a2                	sd	s0,112(sp)
ffffffffc0202a6e:	f4a6                	sd	s1,104(sp)
ffffffffc0202a70:	f0ca                	sd	s2,96(sp)
ffffffffc0202a72:	ecce                	sd	s3,88(sp)
ffffffffc0202a74:	e8d2                	sd	s4,80(sp)
ffffffffc0202a76:	e4d6                	sd	s5,72(sp)
ffffffffc0202a78:	e0da                	sd	s6,64(sp)
ffffffffc0202a7a:	fc5e                	sd	s7,56(sp)
ffffffffc0202a7c:	f862                	sd	s8,48(sp)
ffffffffc0202a7e:	f466                	sd	s9,40(sp)
ffffffffc0202a80:	f06a                	sd	s10,32(sp)
ffffffffc0202a82:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202a84:	17d2                	slli	a5,a5,0x34
ffffffffc0202a86:	20079a63          	bnez	a5,ffffffffc0202c9a <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202a8a:	002007b7          	lui	a5,0x200
ffffffffc0202a8e:	24f5e463          	bltu	a1,a5,ffffffffc0202cd6 <exit_range+0x272>
ffffffffc0202a92:	8ab2                	mv	s5,a2
ffffffffc0202a94:	24c5f163          	bgeu	a1,a2,ffffffffc0202cd6 <exit_range+0x272>
ffffffffc0202a98:	4785                	li	a5,1
ffffffffc0202a9a:	07fe                	slli	a5,a5,0x1f
ffffffffc0202a9c:	22c7ed63          	bltu	a5,a2,ffffffffc0202cd6 <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc0202aa0:	c00009b7          	lui	s3,0xc0000
ffffffffc0202aa4:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202aa8:	ffe00937          	lui	s2,0xffe00
ffffffffc0202aac:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc0202ab0:	5cfd                	li	s9,-1
ffffffffc0202ab2:	8c2a                	mv	s8,a0
ffffffffc0202ab4:	0125f933          	and	s2,a1,s2
ffffffffc0202ab8:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202aba:	000a8d17          	auipc	s10,0xa8
ffffffffc0202abe:	be6d0d13          	addi	s10,s10,-1050 # ffffffffc02aa6a0 <npage>
    return KADDR(page2pa(page));
ffffffffc0202ac2:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc0202ac6:	000a8717          	auipc	a4,0xa8
ffffffffc0202aca:	be270713          	addi	a4,a4,-1054 # ffffffffc02aa6a8 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc0202ace:	000a8d97          	auipc	s11,0xa8
ffffffffc0202ad2:	be2d8d93          	addi	s11,s11,-1054 # ffffffffc02aa6b0 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc0202ad6:	c0000437          	lui	s0,0xc0000
ffffffffc0202ada:	944e                	add	s0,s0,s3
ffffffffc0202adc:	8079                	srli	s0,s0,0x1e
ffffffffc0202ade:	1ff47413          	andi	s0,s0,511
ffffffffc0202ae2:	040e                	slli	s0,s0,0x3
ffffffffc0202ae4:	9462                	add	s0,s0,s8
ffffffffc0202ae6:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ee8>
        if (pde1 & PTE_V)
ffffffffc0202aea:	001a7793          	andi	a5,s4,1
ffffffffc0202aee:	eb99                	bnez	a5,ffffffffc0202b04 <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc0202af0:	12098463          	beqz	s3,ffffffffc0202c18 <exit_range+0x1b4>
ffffffffc0202af4:	400007b7          	lui	a5,0x40000
ffffffffc0202af8:	97ce                	add	a5,a5,s3
ffffffffc0202afa:	894e                	mv	s2,s3
ffffffffc0202afc:	1159fe63          	bgeu	s3,s5,ffffffffc0202c18 <exit_range+0x1b4>
ffffffffc0202b00:	89be                	mv	s3,a5
ffffffffc0202b02:	bfd1                	j	ffffffffc0202ad6 <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc0202b04:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b08:	0a0a                	slli	s4,s4,0x2
ffffffffc0202b0a:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b0e:	1cfa7263          	bgeu	s4,a5,ffffffffc0202cd2 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b12:	fff80637          	lui	a2,0xfff80
ffffffffc0202b16:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc0202b18:	000806b7          	lui	a3,0x80
ffffffffc0202b1c:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202b1e:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc0202b22:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b24:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b26:	18f5fa63          	bgeu	a1,a5,ffffffffc0202cba <exit_range+0x256>
ffffffffc0202b2a:	000a8817          	auipc	a6,0xa8
ffffffffc0202b2e:	b8e80813          	addi	a6,a6,-1138 # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0202b32:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc0202b36:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc0202b38:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc0202b3c:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc0202b3e:	00080337          	lui	t1,0x80
ffffffffc0202b42:	6885                	lui	a7,0x1
ffffffffc0202b44:	a819                	j	ffffffffc0202b5a <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc0202b46:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc0202b48:	002007b7          	lui	a5,0x200
ffffffffc0202b4c:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202b4e:	08090c63          	beqz	s2,ffffffffc0202be6 <exit_range+0x182>
ffffffffc0202b52:	09397a63          	bgeu	s2,s3,ffffffffc0202be6 <exit_range+0x182>
ffffffffc0202b56:	0f597063          	bgeu	s2,s5,ffffffffc0202c36 <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc0202b5a:	01595493          	srli	s1,s2,0x15
ffffffffc0202b5e:	1ff4f493          	andi	s1,s1,511
ffffffffc0202b62:	048e                	slli	s1,s1,0x3
ffffffffc0202b64:	94da                	add	s1,s1,s6
ffffffffc0202b66:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc0202b68:	0017f693          	andi	a3,a5,1
ffffffffc0202b6c:	dee9                	beqz	a3,ffffffffc0202b46 <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc0202b6e:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b72:	078a                	slli	a5,a5,0x2
ffffffffc0202b74:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b76:	14b7fe63          	bgeu	a5,a1,ffffffffc0202cd2 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b7a:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc0202b7c:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc0202b80:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc0202b84:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b88:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b8a:	12bef863          	bgeu	t4,a1,ffffffffc0202cba <exit_range+0x256>
ffffffffc0202b8e:	00083783          	ld	a5,0(a6)
ffffffffc0202b92:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202b94:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc0202b98:	629c                	ld	a5,0(a3)
ffffffffc0202b9a:	8b85                	andi	a5,a5,1
ffffffffc0202b9c:	f7d5                	bnez	a5,ffffffffc0202b48 <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202b9e:	06a1                	addi	a3,a3,8
ffffffffc0202ba0:	fed59ce3          	bne	a1,a3,ffffffffc0202b98 <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc0202ba4:	631c                	ld	a5,0(a4)
ffffffffc0202ba6:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202ba8:	100027f3          	csrr	a5,sstatus
ffffffffc0202bac:	8b89                	andi	a5,a5,2
ffffffffc0202bae:	e7d9                	bnez	a5,ffffffffc0202c3c <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc0202bb0:	000db783          	ld	a5,0(s11)
ffffffffc0202bb4:	4585                	li	a1,1
ffffffffc0202bb6:	e032                	sd	a2,0(sp)
ffffffffc0202bb8:	739c                	ld	a5,32(a5)
ffffffffc0202bba:	9782                	jalr	a5
    if (flag)
ffffffffc0202bbc:	6602                	ld	a2,0(sp)
ffffffffc0202bbe:	000a8817          	auipc	a6,0xa8
ffffffffc0202bc2:	afa80813          	addi	a6,a6,-1286 # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0202bc6:	fff80e37          	lui	t3,0xfff80
ffffffffc0202bca:	00080337          	lui	t1,0x80
ffffffffc0202bce:	6885                	lui	a7,0x1
ffffffffc0202bd0:	000a8717          	auipc	a4,0xa8
ffffffffc0202bd4:	ad870713          	addi	a4,a4,-1320 # ffffffffc02aa6a8 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202bd8:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc0202bdc:	002007b7          	lui	a5,0x200
ffffffffc0202be0:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202be2:	f60918e3          	bnez	s2,ffffffffc0202b52 <exit_range+0xee>
            if (free_pd0)
ffffffffc0202be6:	f00b85e3          	beqz	s7,ffffffffc0202af0 <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc0202bea:	000d3783          	ld	a5,0(s10)
ffffffffc0202bee:	0efa7263          	bgeu	s4,a5,ffffffffc0202cd2 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202bf2:	6308                	ld	a0,0(a4)
ffffffffc0202bf4:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202bf6:	100027f3          	csrr	a5,sstatus
ffffffffc0202bfa:	8b89                	andi	a5,a5,2
ffffffffc0202bfc:	efad                	bnez	a5,ffffffffc0202c76 <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc0202bfe:	000db783          	ld	a5,0(s11)
ffffffffc0202c02:	4585                	li	a1,1
ffffffffc0202c04:	739c                	ld	a5,32(a5)
ffffffffc0202c06:	9782                	jalr	a5
ffffffffc0202c08:	000a8717          	auipc	a4,0xa8
ffffffffc0202c0c:	aa070713          	addi	a4,a4,-1376 # ffffffffc02aa6a8 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc0202c10:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc0202c14:	ee0990e3          	bnez	s3,ffffffffc0202af4 <exit_range+0x90>
}
ffffffffc0202c18:	70e6                	ld	ra,120(sp)
ffffffffc0202c1a:	7446                	ld	s0,112(sp)
ffffffffc0202c1c:	74a6                	ld	s1,104(sp)
ffffffffc0202c1e:	7906                	ld	s2,96(sp)
ffffffffc0202c20:	69e6                	ld	s3,88(sp)
ffffffffc0202c22:	6a46                	ld	s4,80(sp)
ffffffffc0202c24:	6aa6                	ld	s5,72(sp)
ffffffffc0202c26:	6b06                	ld	s6,64(sp)
ffffffffc0202c28:	7be2                	ld	s7,56(sp)
ffffffffc0202c2a:	7c42                	ld	s8,48(sp)
ffffffffc0202c2c:	7ca2                	ld	s9,40(sp)
ffffffffc0202c2e:	7d02                	ld	s10,32(sp)
ffffffffc0202c30:	6de2                	ld	s11,24(sp)
ffffffffc0202c32:	6109                	addi	sp,sp,128
ffffffffc0202c34:	8082                	ret
            if (free_pd0)
ffffffffc0202c36:	ea0b8fe3          	beqz	s7,ffffffffc0202af4 <exit_range+0x90>
ffffffffc0202c3a:	bf45                	j	ffffffffc0202bea <exit_range+0x186>
ffffffffc0202c3c:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc0202c3e:	e42a                	sd	a0,8(sp)
ffffffffc0202c40:	d7bfd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202c44:	000db783          	ld	a5,0(s11)
ffffffffc0202c48:	6522                	ld	a0,8(sp)
ffffffffc0202c4a:	4585                	li	a1,1
ffffffffc0202c4c:	739c                	ld	a5,32(a5)
ffffffffc0202c4e:	9782                	jalr	a5
        intr_enable();
ffffffffc0202c50:	d65fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0202c54:	6602                	ld	a2,0(sp)
ffffffffc0202c56:	000a8717          	auipc	a4,0xa8
ffffffffc0202c5a:	a5270713          	addi	a4,a4,-1454 # ffffffffc02aa6a8 <pages>
ffffffffc0202c5e:	6885                	lui	a7,0x1
ffffffffc0202c60:	00080337          	lui	t1,0x80
ffffffffc0202c64:	fff80e37          	lui	t3,0xfff80
ffffffffc0202c68:	000a8817          	auipc	a6,0xa8
ffffffffc0202c6c:	a5080813          	addi	a6,a6,-1456 # ffffffffc02aa6b8 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202c70:	0004b023          	sd	zero,0(s1)
ffffffffc0202c74:	b7a5                	j	ffffffffc0202bdc <exit_range+0x178>
ffffffffc0202c76:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc0202c78:	d43fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202c7c:	000db783          	ld	a5,0(s11)
ffffffffc0202c80:	6502                	ld	a0,0(sp)
ffffffffc0202c82:	4585                	li	a1,1
ffffffffc0202c84:	739c                	ld	a5,32(a5)
ffffffffc0202c86:	9782                	jalr	a5
        intr_enable();
ffffffffc0202c88:	d2dfd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0202c8c:	000a8717          	auipc	a4,0xa8
ffffffffc0202c90:	a1c70713          	addi	a4,a4,-1508 # ffffffffc02aa6a8 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc0202c94:	00043023          	sd	zero,0(s0)
ffffffffc0202c98:	bfb5                	j	ffffffffc0202c14 <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202c9a:	00004697          	auipc	a3,0x4
ffffffffc0202c9e:	c5668693          	addi	a3,a3,-938 # ffffffffc02068f0 <default_pmm_manager+0x70>
ffffffffc0202ca2:	00003617          	auipc	a2,0x3
ffffffffc0202ca6:	4ce60613          	addi	a2,a2,1230 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202caa:	13500593          	li	a1,309
ffffffffc0202cae:	00004517          	auipc	a0,0x4
ffffffffc0202cb2:	c3250513          	addi	a0,a0,-974 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0202cb6:	d68fd0ef          	jal	ra,ffffffffc020021e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202cba:	00003617          	auipc	a2,0x3
ffffffffc0202cbe:	72e60613          	addi	a2,a2,1838 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0202cc2:	07100593          	li	a1,113
ffffffffc0202cc6:	00003517          	auipc	a0,0x3
ffffffffc0202cca:	74a50513          	addi	a0,a0,1866 # ffffffffc0206410 <commands+0xa98>
ffffffffc0202cce:	d50fd0ef          	jal	ra,ffffffffc020021e <__panic>
ffffffffc0202cd2:	8e1ff0ef          	jal	ra,ffffffffc02025b2 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc0202cd6:	00004697          	auipc	a3,0x4
ffffffffc0202cda:	c4a68693          	addi	a3,a3,-950 # ffffffffc0206920 <default_pmm_manager+0xa0>
ffffffffc0202cde:	00003617          	auipc	a2,0x3
ffffffffc0202ce2:	49260613          	addi	a2,a2,1170 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0202ce6:	13600593          	li	a1,310
ffffffffc0202cea:	00004517          	auipc	a0,0x4
ffffffffc0202cee:	bf650513          	addi	a0,a0,-1034 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0202cf2:	d2cfd0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0202cf6 <page_remove>:
{
ffffffffc0202cf6:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202cf8:	4601                	li	a2,0
{
ffffffffc0202cfa:	ec26                	sd	s1,24(sp)
ffffffffc0202cfc:	f406                	sd	ra,40(sp)
ffffffffc0202cfe:	f022                	sd	s0,32(sp)
ffffffffc0202d00:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202d02:	9a1ff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
    if (ptep != NULL)
ffffffffc0202d06:	c511                	beqz	a0,ffffffffc0202d12 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc0202d08:	611c                	ld	a5,0(a0)
ffffffffc0202d0a:	842a                	mv	s0,a0
ffffffffc0202d0c:	0017f713          	andi	a4,a5,1
ffffffffc0202d10:	e711                	bnez	a4,ffffffffc0202d1c <page_remove+0x26>
}
ffffffffc0202d12:	70a2                	ld	ra,40(sp)
ffffffffc0202d14:	7402                	ld	s0,32(sp)
ffffffffc0202d16:	64e2                	ld	s1,24(sp)
ffffffffc0202d18:	6145                	addi	sp,sp,48
ffffffffc0202d1a:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202d1c:	078a                	slli	a5,a5,0x2
ffffffffc0202d1e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202d20:	000a8717          	auipc	a4,0xa8
ffffffffc0202d24:	98073703          	ld	a4,-1664(a4) # ffffffffc02aa6a0 <npage>
ffffffffc0202d28:	06e7f363          	bgeu	a5,a4,ffffffffc0202d8e <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc0202d2c:	fff80537          	lui	a0,0xfff80
ffffffffc0202d30:	97aa                	add	a5,a5,a0
ffffffffc0202d32:	079a                	slli	a5,a5,0x6
ffffffffc0202d34:	000a8517          	auipc	a0,0xa8
ffffffffc0202d38:	97453503          	ld	a0,-1676(a0) # ffffffffc02aa6a8 <pages>
ffffffffc0202d3c:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202d3e:	411c                	lw	a5,0(a0)
ffffffffc0202d40:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202d44:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc0202d46:	cb11                	beqz	a4,ffffffffc0202d5a <page_remove+0x64>
        *ptep = 0;
ffffffffc0202d48:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202d4c:	12048073          	sfence.vma	s1
}
ffffffffc0202d50:	70a2                	ld	ra,40(sp)
ffffffffc0202d52:	7402                	ld	s0,32(sp)
ffffffffc0202d54:	64e2                	ld	s1,24(sp)
ffffffffc0202d56:	6145                	addi	sp,sp,48
ffffffffc0202d58:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202d5a:	100027f3          	csrr	a5,sstatus
ffffffffc0202d5e:	8b89                	andi	a5,a5,2
ffffffffc0202d60:	eb89                	bnez	a5,ffffffffc0202d72 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc0202d62:	000a8797          	auipc	a5,0xa8
ffffffffc0202d66:	94e7b783          	ld	a5,-1714(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202d6a:	739c                	ld	a5,32(a5)
ffffffffc0202d6c:	4585                	li	a1,1
ffffffffc0202d6e:	9782                	jalr	a5
    if (flag)
ffffffffc0202d70:	bfe1                	j	ffffffffc0202d48 <page_remove+0x52>
        intr_disable();
ffffffffc0202d72:	e42a                	sd	a0,8(sp)
ffffffffc0202d74:	c47fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0202d78:	000a8797          	auipc	a5,0xa8
ffffffffc0202d7c:	9387b783          	ld	a5,-1736(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202d80:	739c                	ld	a5,32(a5)
ffffffffc0202d82:	6522                	ld	a0,8(sp)
ffffffffc0202d84:	4585                	li	a1,1
ffffffffc0202d86:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d88:	c2dfd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0202d8c:	bf75                	j	ffffffffc0202d48 <page_remove+0x52>
ffffffffc0202d8e:	825ff0ef          	jal	ra,ffffffffc02025b2 <pa2page.part.0>

ffffffffc0202d92 <page_insert>:
{
ffffffffc0202d92:	7139                	addi	sp,sp,-64
ffffffffc0202d94:	e852                	sd	s4,16(sp)
ffffffffc0202d96:	8a32                	mv	s4,a2
ffffffffc0202d98:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d9a:	4605                	li	a2,1
{
ffffffffc0202d9c:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202d9e:	85d2                	mv	a1,s4
{
ffffffffc0202da0:	f426                	sd	s1,40(sp)
ffffffffc0202da2:	fc06                	sd	ra,56(sp)
ffffffffc0202da4:	f04a                	sd	s2,32(sp)
ffffffffc0202da6:	ec4e                	sd	s3,24(sp)
ffffffffc0202da8:	e456                	sd	s5,8(sp)
ffffffffc0202daa:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202dac:	8f7ff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
    if (ptep == NULL)
ffffffffc0202db0:	c961                	beqz	a0,ffffffffc0202e80 <page_insert+0xee>
    page->ref += 1;
ffffffffc0202db2:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc0202db4:	611c                	ld	a5,0(a0)
ffffffffc0202db6:	89aa                	mv	s3,a0
ffffffffc0202db8:	0016871b          	addiw	a4,a3,1
ffffffffc0202dbc:	c018                	sw	a4,0(s0)
ffffffffc0202dbe:	0017f713          	andi	a4,a5,1
ffffffffc0202dc2:	ef05                	bnez	a4,ffffffffc0202dfa <page_insert+0x68>
    return page - pages + nbase;
ffffffffc0202dc4:	000a8717          	auipc	a4,0xa8
ffffffffc0202dc8:	8e473703          	ld	a4,-1820(a4) # ffffffffc02aa6a8 <pages>
ffffffffc0202dcc:	8c19                	sub	s0,s0,a4
ffffffffc0202dce:	000807b7          	lui	a5,0x80
ffffffffc0202dd2:	8419                	srai	s0,s0,0x6
ffffffffc0202dd4:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202dd6:	042a                	slli	s0,s0,0xa
ffffffffc0202dd8:	8cc1                	or	s1,s1,s0
ffffffffc0202dda:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc0202dde:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ee8>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202de2:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc0202de6:	4501                	li	a0,0
}
ffffffffc0202de8:	70e2                	ld	ra,56(sp)
ffffffffc0202dea:	7442                	ld	s0,48(sp)
ffffffffc0202dec:	74a2                	ld	s1,40(sp)
ffffffffc0202dee:	7902                	ld	s2,32(sp)
ffffffffc0202df0:	69e2                	ld	s3,24(sp)
ffffffffc0202df2:	6a42                	ld	s4,16(sp)
ffffffffc0202df4:	6aa2                	ld	s5,8(sp)
ffffffffc0202df6:	6121                	addi	sp,sp,64
ffffffffc0202df8:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202dfa:	078a                	slli	a5,a5,0x2
ffffffffc0202dfc:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202dfe:	000a8717          	auipc	a4,0xa8
ffffffffc0202e02:	8a273703          	ld	a4,-1886(a4) # ffffffffc02aa6a0 <npage>
ffffffffc0202e06:	06e7ff63          	bgeu	a5,a4,ffffffffc0202e84 <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc0202e0a:	000a8a97          	auipc	s5,0xa8
ffffffffc0202e0e:	89ea8a93          	addi	s5,s5,-1890 # ffffffffc02aa6a8 <pages>
ffffffffc0202e12:	000ab703          	ld	a4,0(s5)
ffffffffc0202e16:	fff80937          	lui	s2,0xfff80
ffffffffc0202e1a:	993e                	add	s2,s2,a5
ffffffffc0202e1c:	091a                	slli	s2,s2,0x6
ffffffffc0202e1e:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc0202e20:	01240c63          	beq	s0,s2,ffffffffc0202e38 <page_insert+0xa6>
    page->ref -= 1;
ffffffffc0202e24:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcd5924>
ffffffffc0202e28:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202e2c:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) == 0)
ffffffffc0202e30:	c691                	beqz	a3,ffffffffc0202e3c <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202e32:	120a0073          	sfence.vma	s4
}
ffffffffc0202e36:	bf59                	j	ffffffffc0202dcc <page_insert+0x3a>
ffffffffc0202e38:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc0202e3a:	bf49                	j	ffffffffc0202dcc <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202e3c:	100027f3          	csrr	a5,sstatus
ffffffffc0202e40:	8b89                	andi	a5,a5,2
ffffffffc0202e42:	ef91                	bnez	a5,ffffffffc0202e5e <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc0202e44:	000a8797          	auipc	a5,0xa8
ffffffffc0202e48:	86c7b783          	ld	a5,-1940(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202e4c:	739c                	ld	a5,32(a5)
ffffffffc0202e4e:	4585                	li	a1,1
ffffffffc0202e50:	854a                	mv	a0,s2
ffffffffc0202e52:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc0202e54:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202e58:	120a0073          	sfence.vma	s4
ffffffffc0202e5c:	bf85                	j	ffffffffc0202dcc <page_insert+0x3a>
        intr_disable();
ffffffffc0202e5e:	b5dfd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202e62:	000a8797          	auipc	a5,0xa8
ffffffffc0202e66:	84e7b783          	ld	a5,-1970(a5) # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0202e6a:	739c                	ld	a5,32(a5)
ffffffffc0202e6c:	4585                	li	a1,1
ffffffffc0202e6e:	854a                	mv	a0,s2
ffffffffc0202e70:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e72:	b43fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0202e76:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202e7a:	120a0073          	sfence.vma	s4
ffffffffc0202e7e:	b7b9                	j	ffffffffc0202dcc <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc0202e80:	5571                	li	a0,-4
ffffffffc0202e82:	b79d                	j	ffffffffc0202de8 <page_insert+0x56>
ffffffffc0202e84:	f2eff0ef          	jal	ra,ffffffffc02025b2 <pa2page.part.0>

ffffffffc0202e88 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0202e88:	00004797          	auipc	a5,0x4
ffffffffc0202e8c:	9f878793          	addi	a5,a5,-1544 # ffffffffc0206880 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202e90:	638c                	ld	a1,0(a5)
{
ffffffffc0202e92:	7159                	addi	sp,sp,-112
ffffffffc0202e94:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202e96:	00004517          	auipc	a0,0x4
ffffffffc0202e9a:	aa250513          	addi	a0,a0,-1374 # ffffffffc0206938 <default_pmm_manager+0xb8>
    pmm_manager = &default_pmm_manager;
ffffffffc0202e9e:	000a8b17          	auipc	s6,0xa8
ffffffffc0202ea2:	812b0b13          	addi	s6,s6,-2030 # ffffffffc02aa6b0 <pmm_manager>
{
ffffffffc0202ea6:	f486                	sd	ra,104(sp)
ffffffffc0202ea8:	e8ca                	sd	s2,80(sp)
ffffffffc0202eaa:	e4ce                	sd	s3,72(sp)
ffffffffc0202eac:	f0a2                	sd	s0,96(sp)
ffffffffc0202eae:	eca6                	sd	s1,88(sp)
ffffffffc0202eb0:	e0d2                	sd	s4,64(sp)
ffffffffc0202eb2:	fc56                	sd	s5,56(sp)
ffffffffc0202eb4:	f45e                	sd	s7,40(sp)
ffffffffc0202eb6:	f062                	sd	s8,32(sp)
ffffffffc0202eb8:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202eba:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202ebe:	a22fd0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    pmm_manager->init();
ffffffffc0202ec2:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202ec6:	000a7997          	auipc	s3,0xa7
ffffffffc0202eca:	7f298993          	addi	s3,s3,2034 # ffffffffc02aa6b8 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202ece:	679c                	ld	a5,8(a5)
ffffffffc0202ed0:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202ed2:	57f5                	li	a5,-3
ffffffffc0202ed4:	07fa                	slli	a5,a5,0x1e
ffffffffc0202ed6:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc0202eda:	9fffd0ef          	jal	ra,ffffffffc02008d8 <get_memory_base>
ffffffffc0202ede:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc0202ee0:	a03fd0ef          	jal	ra,ffffffffc02008e2 <get_memory_size>
    if (mem_size == 0)
ffffffffc0202ee4:	200505e3          	beqz	a0,ffffffffc02038ee <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc0202ee8:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc0202eea:	00004517          	auipc	a0,0x4
ffffffffc0202eee:	a8650513          	addi	a0,a0,-1402 # ffffffffc0206970 <default_pmm_manager+0xf0>
ffffffffc0202ef2:	9eefd0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc0202ef6:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0202efa:	fff40693          	addi	a3,s0,-1
ffffffffc0202efe:	864a                	mv	a2,s2
ffffffffc0202f00:	85a6                	mv	a1,s1
ffffffffc0202f02:	00004517          	auipc	a0,0x4
ffffffffc0202f06:	a8650513          	addi	a0,a0,-1402 # ffffffffc0206988 <default_pmm_manager+0x108>
ffffffffc0202f0a:	9d6fd0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0202f0e:	c8000737          	lui	a4,0xc8000
ffffffffc0202f12:	87a2                	mv	a5,s0
ffffffffc0202f14:	54876163          	bltu	a4,s0,ffffffffc0203456 <pmm_init+0x5ce>
ffffffffc0202f18:	757d                	lui	a0,0xfffff
ffffffffc0202f1a:	000a8617          	auipc	a2,0xa8
ffffffffc0202f1e:	7c160613          	addi	a2,a2,1985 # ffffffffc02ab6db <end+0xfff>
ffffffffc0202f22:	8e69                	and	a2,a2,a0
ffffffffc0202f24:	000a7497          	auipc	s1,0xa7
ffffffffc0202f28:	77c48493          	addi	s1,s1,1916 # ffffffffc02aa6a0 <npage>
ffffffffc0202f2c:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202f30:	000a7b97          	auipc	s7,0xa7
ffffffffc0202f34:	778b8b93          	addi	s7,s7,1912 # ffffffffc02aa6a8 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0202f38:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202f3a:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202f3e:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202f42:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202f44:	02f50863          	beq	a0,a5,ffffffffc0202f74 <pmm_init+0xec>
ffffffffc0202f48:	4781                	li	a5,0
ffffffffc0202f4a:	4585                	li	a1,1
ffffffffc0202f4c:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc0202f50:	00679513          	slli	a0,a5,0x6
ffffffffc0202f54:	9532                	add	a0,a0,a2
ffffffffc0202f56:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd5492c>
ffffffffc0202f5a:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202f5e:	6088                	ld	a0,0(s1)
ffffffffc0202f60:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc0202f62:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202f66:	00d50733          	add	a4,a0,a3
ffffffffc0202f6a:	fee7e3e3          	bltu	a5,a4,ffffffffc0202f50 <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202f6e:	071a                	slli	a4,a4,0x6
ffffffffc0202f70:	00e606b3          	add	a3,a2,a4
ffffffffc0202f74:	c02007b7          	lui	a5,0xc0200
ffffffffc0202f78:	2ef6ece3          	bltu	a3,a5,ffffffffc0203a70 <pmm_init+0xbe8>
ffffffffc0202f7c:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0202f80:	77fd                	lui	a5,0xfffff
ffffffffc0202f82:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202f84:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc0202f86:	5086eb63          	bltu	a3,s0,ffffffffc020349c <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202f8a:	00004517          	auipc	a0,0x4
ffffffffc0202f8e:	a2650513          	addi	a0,a0,-1498 # ffffffffc02069b0 <default_pmm_manager+0x130>
ffffffffc0202f92:	94efd0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc0202f96:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202f9a:	000a7917          	auipc	s2,0xa7
ffffffffc0202f9e:	6fe90913          	addi	s2,s2,1790 # ffffffffc02aa698 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202fa2:	7b9c                	ld	a5,48(a5)
ffffffffc0202fa4:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0202fa6:	00004517          	auipc	a0,0x4
ffffffffc0202faa:	a2250513          	addi	a0,a0,-1502 # ffffffffc02069c8 <default_pmm_manager+0x148>
ffffffffc0202fae:	932fd0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202fb2:	00007697          	auipc	a3,0x7
ffffffffc0202fb6:	04e68693          	addi	a3,a3,78 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc0202fba:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0202fbe:	c02007b7          	lui	a5,0xc0200
ffffffffc0202fc2:	28f6ebe3          	bltu	a3,a5,ffffffffc0203a58 <pmm_init+0xbd0>
ffffffffc0202fc6:	0009b783          	ld	a5,0(s3)
ffffffffc0202fca:	8e9d                	sub	a3,a3,a5
ffffffffc0202fcc:	000a7797          	auipc	a5,0xa7
ffffffffc0202fd0:	6cd7b223          	sd	a3,1732(a5) # ffffffffc02aa690 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202fd4:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd8:	8b89                	andi	a5,a5,2
ffffffffc0202fda:	4a079763          	bnez	a5,ffffffffc0203488 <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202fde:	000b3783          	ld	a5,0(s6)
ffffffffc0202fe2:	779c                	ld	a5,40(a5)
ffffffffc0202fe4:	9782                	jalr	a5
ffffffffc0202fe6:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202fe8:	6098                	ld	a4,0(s1)
ffffffffc0202fea:	c80007b7          	lui	a5,0xc8000
ffffffffc0202fee:	83b1                	srli	a5,a5,0xc
ffffffffc0202ff0:	66e7e363          	bltu	a5,a4,ffffffffc0203656 <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202ff4:	00093503          	ld	a0,0(s2)
ffffffffc0202ff8:	62050f63          	beqz	a0,ffffffffc0203636 <pmm_init+0x7ae>
ffffffffc0202ffc:	03451793          	slli	a5,a0,0x34
ffffffffc0203000:	62079b63          	bnez	a5,ffffffffc0203636 <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0203004:	4601                	li	a2,0
ffffffffc0203006:	4581                	li	a1,0
ffffffffc0203008:	8c3ff0ef          	jal	ra,ffffffffc02028ca <get_page>
ffffffffc020300c:	60051563          	bnez	a0,ffffffffc0203616 <pmm_init+0x78e>
ffffffffc0203010:	100027f3          	csrr	a5,sstatus
ffffffffc0203014:	8b89                	andi	a5,a5,2
ffffffffc0203016:	44079e63          	bnez	a5,ffffffffc0203472 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc020301a:	000b3783          	ld	a5,0(s6)
ffffffffc020301e:	4505                	li	a0,1
ffffffffc0203020:	6f9c                	ld	a5,24(a5)
ffffffffc0203022:	9782                	jalr	a5
ffffffffc0203024:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc0203026:	00093503          	ld	a0,0(s2)
ffffffffc020302a:	4681                	li	a3,0
ffffffffc020302c:	4601                	li	a2,0
ffffffffc020302e:	85d2                	mv	a1,s4
ffffffffc0203030:	d63ff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
ffffffffc0203034:	26051ae3          	bnez	a0,ffffffffc0203aa8 <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc0203038:	00093503          	ld	a0,0(s2)
ffffffffc020303c:	4601                	li	a2,0
ffffffffc020303e:	4581                	li	a1,0
ffffffffc0203040:	e62ff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc0203044:	240502e3          	beqz	a0,ffffffffc0203a88 <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc0203048:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc020304a:	0017f713          	andi	a4,a5,1
ffffffffc020304e:	5a070263          	beqz	a4,ffffffffc02035f2 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0203052:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc0203054:	078a                	slli	a5,a5,0x2
ffffffffc0203056:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203058:	58e7fb63          	bgeu	a5,a4,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc020305c:	000bb683          	ld	a3,0(s7)
ffffffffc0203060:	fff80637          	lui	a2,0xfff80
ffffffffc0203064:	97b2                	add	a5,a5,a2
ffffffffc0203066:	079a                	slli	a5,a5,0x6
ffffffffc0203068:	97b6                	add	a5,a5,a3
ffffffffc020306a:	14fa17e3          	bne	s4,a5,ffffffffc02039b8 <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc020306e:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8ba8>
ffffffffc0203072:	4785                	li	a5,1
ffffffffc0203074:	12f692e3          	bne	a3,a5,ffffffffc0203998 <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0203078:	00093503          	ld	a0,0(s2)
ffffffffc020307c:	77fd                	lui	a5,0xfffff
ffffffffc020307e:	6114                	ld	a3,0(a0)
ffffffffc0203080:	068a                	slli	a3,a3,0x2
ffffffffc0203082:	8efd                	and	a3,a3,a5
ffffffffc0203084:	00c6d613          	srli	a2,a3,0xc
ffffffffc0203088:	0ee67ce3          	bgeu	a2,a4,ffffffffc0203980 <pmm_init+0xaf8>
ffffffffc020308c:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0203090:	96e2                	add	a3,a3,s8
ffffffffc0203092:	0006ba83          	ld	s5,0(a3)
ffffffffc0203096:	0a8a                	slli	s5,s5,0x2
ffffffffc0203098:	00fafab3          	and	s5,s5,a5
ffffffffc020309c:	00cad793          	srli	a5,s5,0xc
ffffffffc02030a0:	0ce7f3e3          	bgeu	a5,a4,ffffffffc0203966 <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc02030a4:	4601                	li	a2,0
ffffffffc02030a6:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc02030a8:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc02030aa:	df8ff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc02030ae:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc02030b0:	55551363          	bne	a0,s5,ffffffffc02035f6 <pmm_init+0x76e>
ffffffffc02030b4:	100027f3          	csrr	a5,sstatus
ffffffffc02030b8:	8b89                	andi	a5,a5,2
ffffffffc02030ba:	3a079163          	bnez	a5,ffffffffc020345c <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc02030be:	000b3783          	ld	a5,0(s6)
ffffffffc02030c2:	4505                	li	a0,1
ffffffffc02030c4:	6f9c                	ld	a5,24(a5)
ffffffffc02030c6:	9782                	jalr	a5
ffffffffc02030c8:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc02030ca:	00093503          	ld	a0,0(s2)
ffffffffc02030ce:	46d1                	li	a3,20
ffffffffc02030d0:	6605                	lui	a2,0x1
ffffffffc02030d2:	85e2                	mv	a1,s8
ffffffffc02030d4:	cbfff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
ffffffffc02030d8:	060517e3          	bnez	a0,ffffffffc0203946 <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02030dc:	00093503          	ld	a0,0(s2)
ffffffffc02030e0:	4601                	li	a2,0
ffffffffc02030e2:	6585                	lui	a1,0x1
ffffffffc02030e4:	dbeff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc02030e8:	02050fe3          	beqz	a0,ffffffffc0203926 <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc02030ec:	611c                	ld	a5,0(a0)
ffffffffc02030ee:	0107f713          	andi	a4,a5,16
ffffffffc02030f2:	7c070e63          	beqz	a4,ffffffffc02038ce <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc02030f6:	8b91                	andi	a5,a5,4
ffffffffc02030f8:	7a078b63          	beqz	a5,ffffffffc02038ae <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc02030fc:	00093503          	ld	a0,0(s2)
ffffffffc0203100:	611c                	ld	a5,0(a0)
ffffffffc0203102:	8bc1                	andi	a5,a5,16
ffffffffc0203104:	78078563          	beqz	a5,ffffffffc020388e <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc0203108:	000c2703          	lw	a4,0(s8)
ffffffffc020310c:	4785                	li	a5,1
ffffffffc020310e:	76f71063          	bne	a4,a5,ffffffffc020386e <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc0203112:	4681                	li	a3,0
ffffffffc0203114:	6605                	lui	a2,0x1
ffffffffc0203116:	85d2                	mv	a1,s4
ffffffffc0203118:	c7bff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
ffffffffc020311c:	72051963          	bnez	a0,ffffffffc020384e <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc0203120:	000a2703          	lw	a4,0(s4)
ffffffffc0203124:	4789                	li	a5,2
ffffffffc0203126:	70f71463          	bne	a4,a5,ffffffffc020382e <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc020312a:	000c2783          	lw	a5,0(s8)
ffffffffc020312e:	6e079063          	bnez	a5,ffffffffc020380e <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0203132:	00093503          	ld	a0,0(s2)
ffffffffc0203136:	4601                	li	a2,0
ffffffffc0203138:	6585                	lui	a1,0x1
ffffffffc020313a:	d68ff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc020313e:	6a050863          	beqz	a0,ffffffffc02037ee <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc0203142:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc0203144:	00177793          	andi	a5,a4,1
ffffffffc0203148:	4a078563          	beqz	a5,ffffffffc02035f2 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc020314c:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc020314e:	00271793          	slli	a5,a4,0x2
ffffffffc0203152:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203154:	48d7fd63          	bgeu	a5,a3,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0203158:	000bb683          	ld	a3,0(s7)
ffffffffc020315c:	fff80ab7          	lui	s5,0xfff80
ffffffffc0203160:	97d6                	add	a5,a5,s5
ffffffffc0203162:	079a                	slli	a5,a5,0x6
ffffffffc0203164:	97b6                	add	a5,a5,a3
ffffffffc0203166:	66fa1463          	bne	s4,a5,ffffffffc02037ce <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc020316a:	8b41                	andi	a4,a4,16
ffffffffc020316c:	64071163          	bnez	a4,ffffffffc02037ae <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc0203170:	00093503          	ld	a0,0(s2)
ffffffffc0203174:	4581                	li	a1,0
ffffffffc0203176:	b81ff0ef          	jal	ra,ffffffffc0202cf6 <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc020317a:	000a2c83          	lw	s9,0(s4)
ffffffffc020317e:	4785                	li	a5,1
ffffffffc0203180:	60fc9763          	bne	s9,a5,ffffffffc020378e <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc0203184:	000c2783          	lw	a5,0(s8)
ffffffffc0203188:	5e079363          	bnez	a5,ffffffffc020376e <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc020318c:	00093503          	ld	a0,0(s2)
ffffffffc0203190:	6585                	lui	a1,0x1
ffffffffc0203192:	b65ff0ef          	jal	ra,ffffffffc0202cf6 <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc0203196:	000a2783          	lw	a5,0(s4)
ffffffffc020319a:	52079a63          	bnez	a5,ffffffffc02036ce <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc020319e:	000c2783          	lw	a5,0(s8)
ffffffffc02031a2:	50079663          	bnez	a5,ffffffffc02036ae <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc02031a6:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc02031aa:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc02031ac:	000a3683          	ld	a3,0(s4)
ffffffffc02031b0:	068a                	slli	a3,a3,0x2
ffffffffc02031b2:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc02031b4:	42b6fd63          	bgeu	a3,a1,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02031b8:	000bb503          	ld	a0,0(s7)
ffffffffc02031bc:	96d6                	add	a3,a3,s5
ffffffffc02031be:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc02031c0:	00d507b3          	add	a5,a0,a3
ffffffffc02031c4:	439c                	lw	a5,0(a5)
ffffffffc02031c6:	4d979463          	bne	a5,s9,ffffffffc020368e <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc02031ca:	8699                	srai	a3,a3,0x6
ffffffffc02031cc:	00080637          	lui	a2,0x80
ffffffffc02031d0:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02031d2:	00c69713          	slli	a4,a3,0xc
ffffffffc02031d6:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02031d8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02031da:	48b77e63          	bgeu	a4,a1,ffffffffc0203676 <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc02031de:	0009b703          	ld	a4,0(s3)
ffffffffc02031e2:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc02031e4:	629c                	ld	a5,0(a3)
ffffffffc02031e6:	078a                	slli	a5,a5,0x2
ffffffffc02031e8:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02031ea:	40b7f263          	bgeu	a5,a1,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02031ee:	8f91                	sub	a5,a5,a2
ffffffffc02031f0:	079a                	slli	a5,a5,0x6
ffffffffc02031f2:	953e                	add	a0,a0,a5
ffffffffc02031f4:	100027f3          	csrr	a5,sstatus
ffffffffc02031f8:	8b89                	andi	a5,a5,2
ffffffffc02031fa:	30079963          	bnez	a5,ffffffffc020350c <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc02031fe:	000b3783          	ld	a5,0(s6)
ffffffffc0203202:	4585                	li	a1,1
ffffffffc0203204:	739c                	ld	a5,32(a5)
ffffffffc0203206:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0203208:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc020320c:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc020320e:	078a                	slli	a5,a5,0x2
ffffffffc0203210:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203212:	3ce7fe63          	bgeu	a5,a4,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0203216:	000bb503          	ld	a0,0(s7)
ffffffffc020321a:	fff80737          	lui	a4,0xfff80
ffffffffc020321e:	97ba                	add	a5,a5,a4
ffffffffc0203220:	079a                	slli	a5,a5,0x6
ffffffffc0203222:	953e                	add	a0,a0,a5
ffffffffc0203224:	100027f3          	csrr	a5,sstatus
ffffffffc0203228:	8b89                	andi	a5,a5,2
ffffffffc020322a:	2c079563          	bnez	a5,ffffffffc02034f4 <pmm_init+0x66c>
ffffffffc020322e:	000b3783          	ld	a5,0(s6)
ffffffffc0203232:	4585                	li	a1,1
ffffffffc0203234:	739c                	ld	a5,32(a5)
ffffffffc0203236:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0203238:	00093783          	ld	a5,0(s2)
ffffffffc020323c:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd54924>
    asm volatile("sfence.vma");
ffffffffc0203240:	12000073          	sfence.vma
ffffffffc0203244:	100027f3          	csrr	a5,sstatus
ffffffffc0203248:	8b89                	andi	a5,a5,2
ffffffffc020324a:	28079b63          	bnez	a5,ffffffffc02034e0 <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc020324e:	000b3783          	ld	a5,0(s6)
ffffffffc0203252:	779c                	ld	a5,40(a5)
ffffffffc0203254:	9782                	jalr	a5
ffffffffc0203256:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0203258:	4b441b63          	bne	s0,s4,ffffffffc020370e <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc020325c:	00004517          	auipc	a0,0x4
ffffffffc0203260:	a9450513          	addi	a0,a0,-1388 # ffffffffc0206cf0 <default_pmm_manager+0x470>
ffffffffc0203264:	e7dfc0ef          	jal	ra,ffffffffc02000e0 <cprintf>
ffffffffc0203268:	100027f3          	csrr	a5,sstatus
ffffffffc020326c:	8b89                	andi	a5,a5,2
ffffffffc020326e:	24079f63          	bnez	a5,ffffffffc02034cc <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0203272:	000b3783          	ld	a5,0(s6)
ffffffffc0203276:	779c                	ld	a5,40(a5)
ffffffffc0203278:	9782                	jalr	a5
ffffffffc020327a:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc020327c:	6098                	ld	a4,0(s1)
ffffffffc020327e:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0203282:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0203284:	00c71793          	slli	a5,a4,0xc
ffffffffc0203288:	6a05                	lui	s4,0x1
ffffffffc020328a:	02f47c63          	bgeu	s0,a5,ffffffffc02032c2 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc020328e:	00c45793          	srli	a5,s0,0xc
ffffffffc0203292:	00093503          	ld	a0,0(s2)
ffffffffc0203296:	2ee7ff63          	bgeu	a5,a4,ffffffffc0203594 <pmm_init+0x70c>
ffffffffc020329a:	0009b583          	ld	a1,0(s3)
ffffffffc020329e:	4601                	li	a2,0
ffffffffc02032a0:	95a2                	add	a1,a1,s0
ffffffffc02032a2:	c00ff0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc02032a6:	32050463          	beqz	a0,ffffffffc02035ce <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc02032aa:	611c                	ld	a5,0(a0)
ffffffffc02032ac:	078a                	slli	a5,a5,0x2
ffffffffc02032ae:	0157f7b3          	and	a5,a5,s5
ffffffffc02032b2:	2e879e63          	bne	a5,s0,ffffffffc02035ae <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc02032b6:	6098                	ld	a4,0(s1)
ffffffffc02032b8:	9452                	add	s0,s0,s4
ffffffffc02032ba:	00c71793          	slli	a5,a4,0xc
ffffffffc02032be:	fcf468e3          	bltu	s0,a5,ffffffffc020328e <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc02032c2:	00093783          	ld	a5,0(s2)
ffffffffc02032c6:	639c                	ld	a5,0(a5)
ffffffffc02032c8:	42079363          	bnez	a5,ffffffffc02036ee <pmm_init+0x866>
ffffffffc02032cc:	100027f3          	csrr	a5,sstatus
ffffffffc02032d0:	8b89                	andi	a5,a5,2
ffffffffc02032d2:	24079963          	bnez	a5,ffffffffc0203524 <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc02032d6:	000b3783          	ld	a5,0(s6)
ffffffffc02032da:	4505                	li	a0,1
ffffffffc02032dc:	6f9c                	ld	a5,24(a5)
ffffffffc02032de:	9782                	jalr	a5
ffffffffc02032e0:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc02032e2:	00093503          	ld	a0,0(s2)
ffffffffc02032e6:	4699                	li	a3,6
ffffffffc02032e8:	10000613          	li	a2,256
ffffffffc02032ec:	85d2                	mv	a1,s4
ffffffffc02032ee:	aa5ff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
ffffffffc02032f2:	44051e63          	bnez	a0,ffffffffc020374e <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc02032f6:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8ba8>
ffffffffc02032fa:	4785                	li	a5,1
ffffffffc02032fc:	42f71963          	bne	a4,a5,ffffffffc020372e <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0203300:	00093503          	ld	a0,0(s2)
ffffffffc0203304:	6405                	lui	s0,0x1
ffffffffc0203306:	4699                	li	a3,6
ffffffffc0203308:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8aa8>
ffffffffc020330c:	85d2                	mv	a1,s4
ffffffffc020330e:	a85ff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
ffffffffc0203312:	72051363          	bnez	a0,ffffffffc0203a38 <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0203316:	000a2703          	lw	a4,0(s4)
ffffffffc020331a:	4789                	li	a5,2
ffffffffc020331c:	6ef71e63          	bne	a4,a5,ffffffffc0203a18 <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0203320:	00004597          	auipc	a1,0x4
ffffffffc0203324:	b1858593          	addi	a1,a1,-1256 # ffffffffc0206e38 <default_pmm_manager+0x5b8>
ffffffffc0203328:	10000513          	li	a0,256
ffffffffc020332c:	70b010ef          	jal	ra,ffffffffc0205236 <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0203330:	10040593          	addi	a1,s0,256
ffffffffc0203334:	10000513          	li	a0,256
ffffffffc0203338:	711010ef          	jal	ra,ffffffffc0205248 <strcmp>
ffffffffc020333c:	6a051e63          	bnez	a0,ffffffffc02039f8 <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0203340:	000bb683          	ld	a3,0(s7)
ffffffffc0203344:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0203348:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc020334a:	40da06b3          	sub	a3,s4,a3
ffffffffc020334e:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0203350:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0203352:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0203354:	8031                	srli	s0,s0,0xc
ffffffffc0203356:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc020335a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020335c:	30f77d63          	bgeu	a4,a5,ffffffffc0203676 <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0203360:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0203364:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0203368:	96be                	add	a3,a3,a5
ffffffffc020336a:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc020336e:	693010ef          	jal	ra,ffffffffc0205200 <strlen>
ffffffffc0203372:	66051363          	bnez	a0,ffffffffc02039d8 <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0203376:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc020337a:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc020337c:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd54924>
ffffffffc0203380:	068a                	slli	a3,a3,0x2
ffffffffc0203382:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0203384:	26f6f563          	bgeu	a3,a5,ffffffffc02035ee <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0203388:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc020338a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020338c:	2ef47563          	bgeu	s0,a5,ffffffffc0203676 <pmm_init+0x7ee>
ffffffffc0203390:	0009b403          	ld	s0,0(s3)
ffffffffc0203394:	9436                	add	s0,s0,a3
ffffffffc0203396:	100027f3          	csrr	a5,sstatus
ffffffffc020339a:	8b89                	andi	a5,a5,2
ffffffffc020339c:	1e079163          	bnez	a5,ffffffffc020357e <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc02033a0:	000b3783          	ld	a5,0(s6)
ffffffffc02033a4:	4585                	li	a1,1
ffffffffc02033a6:	8552                	mv	a0,s4
ffffffffc02033a8:	739c                	ld	a5,32(a5)
ffffffffc02033aa:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc02033ac:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc02033ae:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc02033b0:	078a                	slli	a5,a5,0x2
ffffffffc02033b2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02033b4:	22e7fd63          	bgeu	a5,a4,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02033b8:	000bb503          	ld	a0,0(s7)
ffffffffc02033bc:	fff80737          	lui	a4,0xfff80
ffffffffc02033c0:	97ba                	add	a5,a5,a4
ffffffffc02033c2:	079a                	slli	a5,a5,0x6
ffffffffc02033c4:	953e                	add	a0,a0,a5
ffffffffc02033c6:	100027f3          	csrr	a5,sstatus
ffffffffc02033ca:	8b89                	andi	a5,a5,2
ffffffffc02033cc:	18079d63          	bnez	a5,ffffffffc0203566 <pmm_init+0x6de>
ffffffffc02033d0:	000b3783          	ld	a5,0(s6)
ffffffffc02033d4:	4585                	li	a1,1
ffffffffc02033d6:	739c                	ld	a5,32(a5)
ffffffffc02033d8:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc02033da:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc02033de:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc02033e0:	078a                	slli	a5,a5,0x2
ffffffffc02033e2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02033e4:	20e7f563          	bgeu	a5,a4,ffffffffc02035ee <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02033e8:	000bb503          	ld	a0,0(s7)
ffffffffc02033ec:	fff80737          	lui	a4,0xfff80
ffffffffc02033f0:	97ba                	add	a5,a5,a4
ffffffffc02033f2:	079a                	slli	a5,a5,0x6
ffffffffc02033f4:	953e                	add	a0,a0,a5
ffffffffc02033f6:	100027f3          	csrr	a5,sstatus
ffffffffc02033fa:	8b89                	andi	a5,a5,2
ffffffffc02033fc:	14079963          	bnez	a5,ffffffffc020354e <pmm_init+0x6c6>
ffffffffc0203400:	000b3783          	ld	a5,0(s6)
ffffffffc0203404:	4585                	li	a1,1
ffffffffc0203406:	739c                	ld	a5,32(a5)
ffffffffc0203408:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc020340a:	00093783          	ld	a5,0(s2)
ffffffffc020340e:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0203412:	12000073          	sfence.vma
ffffffffc0203416:	100027f3          	csrr	a5,sstatus
ffffffffc020341a:	8b89                	andi	a5,a5,2
ffffffffc020341c:	10079f63          	bnez	a5,ffffffffc020353a <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0203420:	000b3783          	ld	a5,0(s6)
ffffffffc0203424:	779c                	ld	a5,40(a5)
ffffffffc0203426:	9782                	jalr	a5
ffffffffc0203428:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc020342a:	4c8c1e63          	bne	s8,s0,ffffffffc0203906 <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc020342e:	00004517          	auipc	a0,0x4
ffffffffc0203432:	a8250513          	addi	a0,a0,-1406 # ffffffffc0206eb0 <default_pmm_manager+0x630>
ffffffffc0203436:	cabfc0ef          	jal	ra,ffffffffc02000e0 <cprintf>
}
ffffffffc020343a:	7406                	ld	s0,96(sp)
ffffffffc020343c:	70a6                	ld	ra,104(sp)
ffffffffc020343e:	64e6                	ld	s1,88(sp)
ffffffffc0203440:	6946                	ld	s2,80(sp)
ffffffffc0203442:	69a6                	ld	s3,72(sp)
ffffffffc0203444:	6a06                	ld	s4,64(sp)
ffffffffc0203446:	7ae2                	ld	s5,56(sp)
ffffffffc0203448:	7b42                	ld	s6,48(sp)
ffffffffc020344a:	7ba2                	ld	s7,40(sp)
ffffffffc020344c:	7c02                	ld	s8,32(sp)
ffffffffc020344e:	6ce2                	ld	s9,24(sp)
ffffffffc0203450:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0203452:	ce8fe06f          	j	ffffffffc020193a <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0203456:	c80007b7          	lui	a5,0xc8000
ffffffffc020345a:	bc7d                	j	ffffffffc0202f18 <pmm_init+0x90>
        intr_disable();
ffffffffc020345c:	d5efd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203460:	000b3783          	ld	a5,0(s6)
ffffffffc0203464:	4505                	li	a0,1
ffffffffc0203466:	6f9c                	ld	a5,24(a5)
ffffffffc0203468:	9782                	jalr	a5
ffffffffc020346a:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc020346c:	d48fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203470:	b9a9                	j	ffffffffc02030ca <pmm_init+0x242>
        intr_disable();
ffffffffc0203472:	d48fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0203476:	000b3783          	ld	a5,0(s6)
ffffffffc020347a:	4505                	li	a0,1
ffffffffc020347c:	6f9c                	ld	a5,24(a5)
ffffffffc020347e:	9782                	jalr	a5
ffffffffc0203480:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0203482:	d32fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203486:	b645                	j	ffffffffc0203026 <pmm_init+0x19e>
        intr_disable();
ffffffffc0203488:	d32fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc020348c:	000b3783          	ld	a5,0(s6)
ffffffffc0203490:	779c                	ld	a5,40(a5)
ffffffffc0203492:	9782                	jalr	a5
ffffffffc0203494:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0203496:	d1efd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc020349a:	b6b9                	j	ffffffffc0202fe8 <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc020349c:	6705                	lui	a4,0x1
ffffffffc020349e:	177d                	addi	a4,a4,-1
ffffffffc02034a0:	96ba                	add	a3,a3,a4
ffffffffc02034a2:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc02034a4:	00c7d713          	srli	a4,a5,0xc
ffffffffc02034a8:	14a77363          	bgeu	a4,a0,ffffffffc02035ee <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc02034ac:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc02034b0:	fff80537          	lui	a0,0xfff80
ffffffffc02034b4:	972a                	add	a4,a4,a0
ffffffffc02034b6:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02034b8:	8c1d                	sub	s0,s0,a5
ffffffffc02034ba:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc02034be:	00c45593          	srli	a1,s0,0xc
ffffffffc02034c2:	9532                	add	a0,a0,a2
ffffffffc02034c4:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc02034c6:	0009b583          	ld	a1,0(s3)
}
ffffffffc02034ca:	b4c1                	j	ffffffffc0202f8a <pmm_init+0x102>
        intr_disable();
ffffffffc02034cc:	ceefd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc02034d0:	000b3783          	ld	a5,0(s6)
ffffffffc02034d4:	779c                	ld	a5,40(a5)
ffffffffc02034d6:	9782                	jalr	a5
ffffffffc02034d8:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc02034da:	cdafd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc02034de:	bb79                	j	ffffffffc020327c <pmm_init+0x3f4>
        intr_disable();
ffffffffc02034e0:	cdafd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc02034e4:	000b3783          	ld	a5,0(s6)
ffffffffc02034e8:	779c                	ld	a5,40(a5)
ffffffffc02034ea:	9782                	jalr	a5
ffffffffc02034ec:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc02034ee:	cc6fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc02034f2:	b39d                	j	ffffffffc0203258 <pmm_init+0x3d0>
ffffffffc02034f4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02034f6:	cc4fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02034fa:	000b3783          	ld	a5,0(s6)
ffffffffc02034fe:	6522                	ld	a0,8(sp)
ffffffffc0203500:	4585                	li	a1,1
ffffffffc0203502:	739c                	ld	a5,32(a5)
ffffffffc0203504:	9782                	jalr	a5
        intr_enable();
ffffffffc0203506:	caefd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc020350a:	b33d                	j	ffffffffc0203238 <pmm_init+0x3b0>
ffffffffc020350c:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc020350e:	cacfd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0203512:	000b3783          	ld	a5,0(s6)
ffffffffc0203516:	6522                	ld	a0,8(sp)
ffffffffc0203518:	4585                	li	a1,1
ffffffffc020351a:	739c                	ld	a5,32(a5)
ffffffffc020351c:	9782                	jalr	a5
        intr_enable();
ffffffffc020351e:	c96fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203522:	b1dd                	j	ffffffffc0203208 <pmm_init+0x380>
        intr_disable();
ffffffffc0203524:	c96fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203528:	000b3783          	ld	a5,0(s6)
ffffffffc020352c:	4505                	li	a0,1
ffffffffc020352e:	6f9c                	ld	a5,24(a5)
ffffffffc0203530:	9782                	jalr	a5
ffffffffc0203532:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0203534:	c80fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203538:	b36d                	j	ffffffffc02032e2 <pmm_init+0x45a>
        intr_disable();
ffffffffc020353a:	c80fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc020353e:	000b3783          	ld	a5,0(s6)
ffffffffc0203542:	779c                	ld	a5,40(a5)
ffffffffc0203544:	9782                	jalr	a5
ffffffffc0203546:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0203548:	c6cfd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc020354c:	bdf9                	j	ffffffffc020342a <pmm_init+0x5a2>
ffffffffc020354e:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203550:	c6afd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0203554:	000b3783          	ld	a5,0(s6)
ffffffffc0203558:	6522                	ld	a0,8(sp)
ffffffffc020355a:	4585                	li	a1,1
ffffffffc020355c:	739c                	ld	a5,32(a5)
ffffffffc020355e:	9782                	jalr	a5
        intr_enable();
ffffffffc0203560:	c54fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203564:	b55d                	j	ffffffffc020340a <pmm_init+0x582>
ffffffffc0203566:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203568:	c52fd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc020356c:	000b3783          	ld	a5,0(s6)
ffffffffc0203570:	6522                	ld	a0,8(sp)
ffffffffc0203572:	4585                	li	a1,1
ffffffffc0203574:	739c                	ld	a5,32(a5)
ffffffffc0203576:	9782                	jalr	a5
        intr_enable();
ffffffffc0203578:	c3cfd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc020357c:	bdb9                	j	ffffffffc02033da <pmm_init+0x552>
        intr_disable();
ffffffffc020357e:	c3cfd0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0203582:	000b3783          	ld	a5,0(s6)
ffffffffc0203586:	4585                	li	a1,1
ffffffffc0203588:	8552                	mv	a0,s4
ffffffffc020358a:	739c                	ld	a5,32(a5)
ffffffffc020358c:	9782                	jalr	a5
        intr_enable();
ffffffffc020358e:	c26fd0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203592:	bd29                	j	ffffffffc02033ac <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0203594:	86a2                	mv	a3,s0
ffffffffc0203596:	00003617          	auipc	a2,0x3
ffffffffc020359a:	e5260613          	addi	a2,a2,-430 # ffffffffc02063e8 <commands+0xa70>
ffffffffc020359e:	25300593          	li	a1,595
ffffffffc02035a2:	00003517          	auipc	a0,0x3
ffffffffc02035a6:	33e50513          	addi	a0,a0,830 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02035aa:	c75fc0ef          	jal	ra,ffffffffc020021e <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc02035ae:	00003697          	auipc	a3,0x3
ffffffffc02035b2:	7a268693          	addi	a3,a3,1954 # ffffffffc0206d50 <default_pmm_manager+0x4d0>
ffffffffc02035b6:	00003617          	auipc	a2,0x3
ffffffffc02035ba:	bba60613          	addi	a2,a2,-1094 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02035be:	25400593          	li	a1,596
ffffffffc02035c2:	00003517          	auipc	a0,0x3
ffffffffc02035c6:	31e50513          	addi	a0,a0,798 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02035ca:	c55fc0ef          	jal	ra,ffffffffc020021e <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc02035ce:	00003697          	auipc	a3,0x3
ffffffffc02035d2:	74268693          	addi	a3,a3,1858 # ffffffffc0206d10 <default_pmm_manager+0x490>
ffffffffc02035d6:	00003617          	auipc	a2,0x3
ffffffffc02035da:	b9a60613          	addi	a2,a2,-1126 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02035de:	25300593          	li	a1,595
ffffffffc02035e2:	00003517          	auipc	a0,0x3
ffffffffc02035e6:	2fe50513          	addi	a0,a0,766 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02035ea:	c35fc0ef          	jal	ra,ffffffffc020021e <__panic>
ffffffffc02035ee:	fc5fe0ef          	jal	ra,ffffffffc02025b2 <pa2page.part.0>
ffffffffc02035f2:	fddfe0ef          	jal	ra,ffffffffc02025ce <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc02035f6:	00003697          	auipc	a3,0x3
ffffffffc02035fa:	51268693          	addi	a3,a3,1298 # ffffffffc0206b08 <default_pmm_manager+0x288>
ffffffffc02035fe:	00003617          	auipc	a2,0x3
ffffffffc0203602:	b7260613          	addi	a2,a2,-1166 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203606:	22300593          	li	a1,547
ffffffffc020360a:	00003517          	auipc	a0,0x3
ffffffffc020360e:	2d650513          	addi	a0,a0,726 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203612:	c0dfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0203616:	00003697          	auipc	a3,0x3
ffffffffc020361a:	43268693          	addi	a3,a3,1074 # ffffffffc0206a48 <default_pmm_manager+0x1c8>
ffffffffc020361e:	00003617          	auipc	a2,0x3
ffffffffc0203622:	b5260613          	addi	a2,a2,-1198 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203626:	21600593          	li	a1,534
ffffffffc020362a:	00003517          	auipc	a0,0x3
ffffffffc020362e:	2b650513          	addi	a0,a0,694 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203632:	bedfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0203636:	00003697          	auipc	a3,0x3
ffffffffc020363a:	3d268693          	addi	a3,a3,978 # ffffffffc0206a08 <default_pmm_manager+0x188>
ffffffffc020363e:	00003617          	auipc	a2,0x3
ffffffffc0203642:	b3260613          	addi	a2,a2,-1230 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203646:	21500593          	li	a1,533
ffffffffc020364a:	00003517          	auipc	a0,0x3
ffffffffc020364e:	29650513          	addi	a0,a0,662 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203652:	bcdfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0203656:	00003697          	auipc	a3,0x3
ffffffffc020365a:	39268693          	addi	a3,a3,914 # ffffffffc02069e8 <default_pmm_manager+0x168>
ffffffffc020365e:	00003617          	auipc	a2,0x3
ffffffffc0203662:	b1260613          	addi	a2,a2,-1262 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203666:	21400593          	li	a1,532
ffffffffc020366a:	00003517          	auipc	a0,0x3
ffffffffc020366e:	27650513          	addi	a0,a0,630 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203672:	badfc0ef          	jal	ra,ffffffffc020021e <__panic>
    return KADDR(page2pa(page));
ffffffffc0203676:	00003617          	auipc	a2,0x3
ffffffffc020367a:	d7260613          	addi	a2,a2,-654 # ffffffffc02063e8 <commands+0xa70>
ffffffffc020367e:	07100593          	li	a1,113
ffffffffc0203682:	00003517          	auipc	a0,0x3
ffffffffc0203686:	d8e50513          	addi	a0,a0,-626 # ffffffffc0206410 <commands+0xa98>
ffffffffc020368a:	b95fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc020368e:	00003697          	auipc	a3,0x3
ffffffffc0203692:	60a68693          	addi	a3,a3,1546 # ffffffffc0206c98 <default_pmm_manager+0x418>
ffffffffc0203696:	00003617          	auipc	a2,0x3
ffffffffc020369a:	ada60613          	addi	a2,a2,-1318 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020369e:	23c00593          	li	a1,572
ffffffffc02036a2:	00003517          	auipc	a0,0x3
ffffffffc02036a6:	23e50513          	addi	a0,a0,574 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02036aa:	b75fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc02036ae:	00003697          	auipc	a3,0x3
ffffffffc02036b2:	5a268693          	addi	a3,a3,1442 # ffffffffc0206c50 <default_pmm_manager+0x3d0>
ffffffffc02036b6:	00003617          	auipc	a2,0x3
ffffffffc02036ba:	aba60613          	addi	a2,a2,-1350 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02036be:	23a00593          	li	a1,570
ffffffffc02036c2:	00003517          	auipc	a0,0x3
ffffffffc02036c6:	21e50513          	addi	a0,a0,542 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02036ca:	b55fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p1) == 0);
ffffffffc02036ce:	00003697          	auipc	a3,0x3
ffffffffc02036d2:	5b268693          	addi	a3,a3,1458 # ffffffffc0206c80 <default_pmm_manager+0x400>
ffffffffc02036d6:	00003617          	auipc	a2,0x3
ffffffffc02036da:	a9a60613          	addi	a2,a2,-1382 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02036de:	23900593          	li	a1,569
ffffffffc02036e2:	00003517          	auipc	a0,0x3
ffffffffc02036e6:	1fe50513          	addi	a0,a0,510 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02036ea:	b35fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc02036ee:	00003697          	auipc	a3,0x3
ffffffffc02036f2:	67a68693          	addi	a3,a3,1658 # ffffffffc0206d68 <default_pmm_manager+0x4e8>
ffffffffc02036f6:	00003617          	auipc	a2,0x3
ffffffffc02036fa:	a7a60613          	addi	a2,a2,-1414 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02036fe:	25700593          	li	a1,599
ffffffffc0203702:	00003517          	auipc	a0,0x3
ffffffffc0203706:	1de50513          	addi	a0,a0,478 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020370a:	b15fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc020370e:	00003697          	auipc	a3,0x3
ffffffffc0203712:	5ba68693          	addi	a3,a3,1466 # ffffffffc0206cc8 <default_pmm_manager+0x448>
ffffffffc0203716:	00003617          	auipc	a2,0x3
ffffffffc020371a:	a5a60613          	addi	a2,a2,-1446 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020371e:	24400593          	li	a1,580
ffffffffc0203722:	00003517          	auipc	a0,0x3
ffffffffc0203726:	1be50513          	addi	a0,a0,446 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020372a:	af5fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p) == 1);
ffffffffc020372e:	00003697          	auipc	a3,0x3
ffffffffc0203732:	69268693          	addi	a3,a3,1682 # ffffffffc0206dc0 <default_pmm_manager+0x540>
ffffffffc0203736:	00003617          	auipc	a2,0x3
ffffffffc020373a:	a3a60613          	addi	a2,a2,-1478 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020373e:	25c00593          	li	a1,604
ffffffffc0203742:	00003517          	auipc	a0,0x3
ffffffffc0203746:	19e50513          	addi	a0,a0,414 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020374a:	ad5fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc020374e:	00003697          	auipc	a3,0x3
ffffffffc0203752:	63268693          	addi	a3,a3,1586 # ffffffffc0206d80 <default_pmm_manager+0x500>
ffffffffc0203756:	00003617          	auipc	a2,0x3
ffffffffc020375a:	a1a60613          	addi	a2,a2,-1510 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020375e:	25b00593          	li	a1,603
ffffffffc0203762:	00003517          	auipc	a0,0x3
ffffffffc0203766:	17e50513          	addi	a0,a0,382 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020376a:	ab5fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc020376e:	00003697          	auipc	a3,0x3
ffffffffc0203772:	4e268693          	addi	a3,a3,1250 # ffffffffc0206c50 <default_pmm_manager+0x3d0>
ffffffffc0203776:	00003617          	auipc	a2,0x3
ffffffffc020377a:	9fa60613          	addi	a2,a2,-1542 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020377e:	23600593          	li	a1,566
ffffffffc0203782:	00003517          	auipc	a0,0x3
ffffffffc0203786:	15e50513          	addi	a0,a0,350 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020378a:	a95fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc020378e:	00003697          	auipc	a3,0x3
ffffffffc0203792:	36268693          	addi	a3,a3,866 # ffffffffc0206af0 <default_pmm_manager+0x270>
ffffffffc0203796:	00003617          	auipc	a2,0x3
ffffffffc020379a:	9da60613          	addi	a2,a2,-1574 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020379e:	23500593          	li	a1,565
ffffffffc02037a2:	00003517          	auipc	a0,0x3
ffffffffc02037a6:	13e50513          	addi	a0,a0,318 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02037aa:	a75fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc02037ae:	00003697          	auipc	a3,0x3
ffffffffc02037b2:	4ba68693          	addi	a3,a3,1210 # ffffffffc0206c68 <default_pmm_manager+0x3e8>
ffffffffc02037b6:	00003617          	auipc	a2,0x3
ffffffffc02037ba:	9ba60613          	addi	a2,a2,-1606 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02037be:	23200593          	li	a1,562
ffffffffc02037c2:	00003517          	auipc	a0,0x3
ffffffffc02037c6:	11e50513          	addi	a0,a0,286 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02037ca:	a55fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc02037ce:	00003697          	auipc	a3,0x3
ffffffffc02037d2:	30a68693          	addi	a3,a3,778 # ffffffffc0206ad8 <default_pmm_manager+0x258>
ffffffffc02037d6:	00003617          	auipc	a2,0x3
ffffffffc02037da:	99a60613          	addi	a2,a2,-1638 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02037de:	23100593          	li	a1,561
ffffffffc02037e2:	00003517          	auipc	a0,0x3
ffffffffc02037e6:	0fe50513          	addi	a0,a0,254 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02037ea:	a35fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02037ee:	00003697          	auipc	a3,0x3
ffffffffc02037f2:	38a68693          	addi	a3,a3,906 # ffffffffc0206b78 <default_pmm_manager+0x2f8>
ffffffffc02037f6:	00003617          	auipc	a2,0x3
ffffffffc02037fa:	97a60613          	addi	a2,a2,-1670 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02037fe:	23000593          	li	a1,560
ffffffffc0203802:	00003517          	auipc	a0,0x3
ffffffffc0203806:	0de50513          	addi	a0,a0,222 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020380a:	a15fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc020380e:	00003697          	auipc	a3,0x3
ffffffffc0203812:	44268693          	addi	a3,a3,1090 # ffffffffc0206c50 <default_pmm_manager+0x3d0>
ffffffffc0203816:	00003617          	auipc	a2,0x3
ffffffffc020381a:	95a60613          	addi	a2,a2,-1702 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020381e:	22f00593          	li	a1,559
ffffffffc0203822:	00003517          	auipc	a0,0x3
ffffffffc0203826:	0be50513          	addi	a0,a0,190 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020382a:	9f5fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p1) == 2);
ffffffffc020382e:	00003697          	auipc	a3,0x3
ffffffffc0203832:	40a68693          	addi	a3,a3,1034 # ffffffffc0206c38 <default_pmm_manager+0x3b8>
ffffffffc0203836:	00003617          	auipc	a2,0x3
ffffffffc020383a:	93a60613          	addi	a2,a2,-1734 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020383e:	22e00593          	li	a1,558
ffffffffc0203842:	00003517          	auipc	a0,0x3
ffffffffc0203846:	09e50513          	addi	a0,a0,158 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020384a:	9d5fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc020384e:	00003697          	auipc	a3,0x3
ffffffffc0203852:	3ba68693          	addi	a3,a3,954 # ffffffffc0206c08 <default_pmm_manager+0x388>
ffffffffc0203856:	00003617          	auipc	a2,0x3
ffffffffc020385a:	91a60613          	addi	a2,a2,-1766 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020385e:	22d00593          	li	a1,557
ffffffffc0203862:	00003517          	auipc	a0,0x3
ffffffffc0203866:	07e50513          	addi	a0,a0,126 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020386a:	9b5fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p2) == 1);
ffffffffc020386e:	00003697          	auipc	a3,0x3
ffffffffc0203872:	38268693          	addi	a3,a3,898 # ffffffffc0206bf0 <default_pmm_manager+0x370>
ffffffffc0203876:	00003617          	auipc	a2,0x3
ffffffffc020387a:	8fa60613          	addi	a2,a2,-1798 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020387e:	22b00593          	li	a1,555
ffffffffc0203882:	00003517          	auipc	a0,0x3
ffffffffc0203886:	05e50513          	addi	a0,a0,94 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020388a:	995fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc020388e:	00003697          	auipc	a3,0x3
ffffffffc0203892:	34268693          	addi	a3,a3,834 # ffffffffc0206bd0 <default_pmm_manager+0x350>
ffffffffc0203896:	00003617          	auipc	a2,0x3
ffffffffc020389a:	8da60613          	addi	a2,a2,-1830 # ffffffffc0206170 <commands+0x7f8>
ffffffffc020389e:	22a00593          	li	a1,554
ffffffffc02038a2:	00003517          	auipc	a0,0x3
ffffffffc02038a6:	03e50513          	addi	a0,a0,62 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02038aa:	975fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(*ptep & PTE_W);
ffffffffc02038ae:	00003697          	auipc	a3,0x3
ffffffffc02038b2:	31268693          	addi	a3,a3,786 # ffffffffc0206bc0 <default_pmm_manager+0x340>
ffffffffc02038b6:	00003617          	auipc	a2,0x3
ffffffffc02038ba:	8ba60613          	addi	a2,a2,-1862 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02038be:	22900593          	li	a1,553
ffffffffc02038c2:	00003517          	auipc	a0,0x3
ffffffffc02038c6:	01e50513          	addi	a0,a0,30 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02038ca:	955fc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(*ptep & PTE_U);
ffffffffc02038ce:	00003697          	auipc	a3,0x3
ffffffffc02038d2:	2e268693          	addi	a3,a3,738 # ffffffffc0206bb0 <default_pmm_manager+0x330>
ffffffffc02038d6:	00003617          	auipc	a2,0x3
ffffffffc02038da:	89a60613          	addi	a2,a2,-1894 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02038de:	22800593          	li	a1,552
ffffffffc02038e2:	00003517          	auipc	a0,0x3
ffffffffc02038e6:	ffe50513          	addi	a0,a0,-2 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02038ea:	935fc0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("DTB memory info not available");
ffffffffc02038ee:	00003617          	auipc	a2,0x3
ffffffffc02038f2:	06260613          	addi	a2,a2,98 # ffffffffc0206950 <default_pmm_manager+0xd0>
ffffffffc02038f6:	06500593          	li	a1,101
ffffffffc02038fa:	00003517          	auipc	a0,0x3
ffffffffc02038fe:	fe650513          	addi	a0,a0,-26 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203902:	91dfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0203906:	00003697          	auipc	a3,0x3
ffffffffc020390a:	3c268693          	addi	a3,a3,962 # ffffffffc0206cc8 <default_pmm_manager+0x448>
ffffffffc020390e:	00003617          	auipc	a2,0x3
ffffffffc0203912:	86260613          	addi	a2,a2,-1950 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203916:	26e00593          	li	a1,622
ffffffffc020391a:	00003517          	auipc	a0,0x3
ffffffffc020391e:	fc650513          	addi	a0,a0,-58 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203922:	8fdfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0203926:	00003697          	auipc	a3,0x3
ffffffffc020392a:	25268693          	addi	a3,a3,594 # ffffffffc0206b78 <default_pmm_manager+0x2f8>
ffffffffc020392e:	00003617          	auipc	a2,0x3
ffffffffc0203932:	84260613          	addi	a2,a2,-1982 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203936:	22700593          	li	a1,551
ffffffffc020393a:	00003517          	auipc	a0,0x3
ffffffffc020393e:	fa650513          	addi	a0,a0,-90 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203942:	8ddfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0203946:	00003697          	auipc	a3,0x3
ffffffffc020394a:	1f268693          	addi	a3,a3,498 # ffffffffc0206b38 <default_pmm_manager+0x2b8>
ffffffffc020394e:	00003617          	auipc	a2,0x3
ffffffffc0203952:	82260613          	addi	a2,a2,-2014 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203956:	22600593          	li	a1,550
ffffffffc020395a:	00003517          	auipc	a0,0x3
ffffffffc020395e:	f8650513          	addi	a0,a0,-122 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203962:	8bdfc0ef          	jal	ra,ffffffffc020021e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0203966:	86d6                	mv	a3,s5
ffffffffc0203968:	00003617          	auipc	a2,0x3
ffffffffc020396c:	a8060613          	addi	a2,a2,-1408 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0203970:	22200593          	li	a1,546
ffffffffc0203974:	00003517          	auipc	a0,0x3
ffffffffc0203978:	f6c50513          	addi	a0,a0,-148 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc020397c:	8a3fc0ef          	jal	ra,ffffffffc020021e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0203980:	00003617          	auipc	a2,0x3
ffffffffc0203984:	a6860613          	addi	a2,a2,-1432 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0203988:	22100593          	li	a1,545
ffffffffc020398c:	00003517          	auipc	a0,0x3
ffffffffc0203990:	f5450513          	addi	a0,a0,-172 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203994:	88bfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203998:	00003697          	auipc	a3,0x3
ffffffffc020399c:	15868693          	addi	a3,a3,344 # ffffffffc0206af0 <default_pmm_manager+0x270>
ffffffffc02039a0:	00002617          	auipc	a2,0x2
ffffffffc02039a4:	7d060613          	addi	a2,a2,2000 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02039a8:	21f00593          	li	a1,543
ffffffffc02039ac:	00003517          	auipc	a0,0x3
ffffffffc02039b0:	f3450513          	addi	a0,a0,-204 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02039b4:	86bfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc02039b8:	00003697          	auipc	a3,0x3
ffffffffc02039bc:	12068693          	addi	a3,a3,288 # ffffffffc0206ad8 <default_pmm_manager+0x258>
ffffffffc02039c0:	00002617          	auipc	a2,0x2
ffffffffc02039c4:	7b060613          	addi	a2,a2,1968 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02039c8:	21e00593          	li	a1,542
ffffffffc02039cc:	00003517          	auipc	a0,0x3
ffffffffc02039d0:	f1450513          	addi	a0,a0,-236 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02039d4:	84bfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc02039d8:	00003697          	auipc	a3,0x3
ffffffffc02039dc:	4b068693          	addi	a3,a3,1200 # ffffffffc0206e88 <default_pmm_manager+0x608>
ffffffffc02039e0:	00002617          	auipc	a2,0x2
ffffffffc02039e4:	79060613          	addi	a2,a2,1936 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02039e8:	26500593          	li	a1,613
ffffffffc02039ec:	00003517          	auipc	a0,0x3
ffffffffc02039f0:	ef450513          	addi	a0,a0,-268 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc02039f4:	82bfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc02039f8:	00003697          	auipc	a3,0x3
ffffffffc02039fc:	45868693          	addi	a3,a3,1112 # ffffffffc0206e50 <default_pmm_manager+0x5d0>
ffffffffc0203a00:	00002617          	auipc	a2,0x2
ffffffffc0203a04:	77060613          	addi	a2,a2,1904 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203a08:	26200593          	li	a1,610
ffffffffc0203a0c:	00003517          	auipc	a0,0x3
ffffffffc0203a10:	ed450513          	addi	a0,a0,-300 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203a14:	80bfc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_ref(p) == 2);
ffffffffc0203a18:	00003697          	auipc	a3,0x3
ffffffffc0203a1c:	40868693          	addi	a3,a3,1032 # ffffffffc0206e20 <default_pmm_manager+0x5a0>
ffffffffc0203a20:	00002617          	auipc	a2,0x2
ffffffffc0203a24:	75060613          	addi	a2,a2,1872 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203a28:	25e00593          	li	a1,606
ffffffffc0203a2c:	00003517          	auipc	a0,0x3
ffffffffc0203a30:	eb450513          	addi	a0,a0,-332 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203a34:	feafc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0203a38:	00003697          	auipc	a3,0x3
ffffffffc0203a3c:	3a068693          	addi	a3,a3,928 # ffffffffc0206dd8 <default_pmm_manager+0x558>
ffffffffc0203a40:	00002617          	auipc	a2,0x2
ffffffffc0203a44:	73060613          	addi	a2,a2,1840 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203a48:	25d00593          	li	a1,605
ffffffffc0203a4c:	00003517          	auipc	a0,0x3
ffffffffc0203a50:	e9450513          	addi	a0,a0,-364 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203a54:	fcafc0ef          	jal	ra,ffffffffc020021e <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0203a58:	00003617          	auipc	a2,0x3
ffffffffc0203a5c:	a3860613          	addi	a2,a2,-1480 # ffffffffc0206490 <commands+0xb18>
ffffffffc0203a60:	0c900593          	li	a1,201
ffffffffc0203a64:	00003517          	auipc	a0,0x3
ffffffffc0203a68:	e7c50513          	addi	a0,a0,-388 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203a6c:	fb2fc0ef          	jal	ra,ffffffffc020021e <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0203a70:	00003617          	auipc	a2,0x3
ffffffffc0203a74:	a2060613          	addi	a2,a2,-1504 # ffffffffc0206490 <commands+0xb18>
ffffffffc0203a78:	08100593          	li	a1,129
ffffffffc0203a7c:	00003517          	auipc	a0,0x3
ffffffffc0203a80:	e6450513          	addi	a0,a0,-412 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203a84:	f9afc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc0203a88:	00003697          	auipc	a3,0x3
ffffffffc0203a8c:	02068693          	addi	a3,a3,32 # ffffffffc0206aa8 <default_pmm_manager+0x228>
ffffffffc0203a90:	00002617          	auipc	a2,0x2
ffffffffc0203a94:	6e060613          	addi	a2,a2,1760 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203a98:	21d00593          	li	a1,541
ffffffffc0203a9c:	00003517          	auipc	a0,0x3
ffffffffc0203aa0:	e4450513          	addi	a0,a0,-444 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203aa4:	f7afc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc0203aa8:	00003697          	auipc	a3,0x3
ffffffffc0203aac:	fd068693          	addi	a3,a3,-48 # ffffffffc0206a78 <default_pmm_manager+0x1f8>
ffffffffc0203ab0:	00002617          	auipc	a2,0x2
ffffffffc0203ab4:	6c060613          	addi	a2,a2,1728 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203ab8:	21a00593          	li	a1,538
ffffffffc0203abc:	00003517          	auipc	a0,0x3
ffffffffc0203ac0:	e2450513          	addi	a0,a0,-476 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203ac4:	f5afc0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0203ac8 <copy_range>:
{
ffffffffc0203ac8:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203aca:	00d667b3          	or	a5,a2,a3
{
ffffffffc0203ace:	f486                	sd	ra,104(sp)
ffffffffc0203ad0:	f0a2                	sd	s0,96(sp)
ffffffffc0203ad2:	eca6                	sd	s1,88(sp)
ffffffffc0203ad4:	e8ca                	sd	s2,80(sp)
ffffffffc0203ad6:	e4ce                	sd	s3,72(sp)
ffffffffc0203ad8:	e0d2                	sd	s4,64(sp)
ffffffffc0203ada:	fc56                	sd	s5,56(sp)
ffffffffc0203adc:	f85a                	sd	s6,48(sp)
ffffffffc0203ade:	f45e                	sd	s7,40(sp)
ffffffffc0203ae0:	f062                	sd	s8,32(sp)
ffffffffc0203ae2:	ec66                	sd	s9,24(sp)
ffffffffc0203ae4:	e86a                	sd	s10,16(sp)
ffffffffc0203ae6:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203ae8:	17d2                	slli	a5,a5,0x34
ffffffffc0203aea:	20079f63          	bnez	a5,ffffffffc0203d08 <copy_range+0x240>
    assert(USER_ACCESS(start, end));
ffffffffc0203aee:	002007b7          	lui	a5,0x200
ffffffffc0203af2:	8432                	mv	s0,a2
ffffffffc0203af4:	1af66263          	bltu	a2,a5,ffffffffc0203c98 <copy_range+0x1d0>
ffffffffc0203af8:	8936                	mv	s2,a3
ffffffffc0203afa:	18d67f63          	bgeu	a2,a3,ffffffffc0203c98 <copy_range+0x1d0>
ffffffffc0203afe:	4785                	li	a5,1
ffffffffc0203b00:	07fe                	slli	a5,a5,0x1f
ffffffffc0203b02:	18d7eb63          	bltu	a5,a3,ffffffffc0203c98 <copy_range+0x1d0>
ffffffffc0203b06:	5b7d                	li	s6,-1
ffffffffc0203b08:	8aaa                	mv	s5,a0
ffffffffc0203b0a:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc0203b0c:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc0203b0e:	000a7c17          	auipc	s8,0xa7
ffffffffc0203b12:	b92c0c13          	addi	s8,s8,-1134 # ffffffffc02aa6a0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0203b16:	000a7b97          	auipc	s7,0xa7
ffffffffc0203b1a:	b92b8b93          	addi	s7,s7,-1134 # ffffffffc02aa6a8 <pages>
    return KADDR(page2pa(page));
ffffffffc0203b1e:	00cb5b13          	srli	s6,s6,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc0203b22:	000a7c97          	auipc	s9,0xa7
ffffffffc0203b26:	b8ec8c93          	addi	s9,s9,-1138 # ffffffffc02aa6b0 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc0203b2a:	4601                	li	a2,0
ffffffffc0203b2c:	85a2                	mv	a1,s0
ffffffffc0203b2e:	854e                	mv	a0,s3
ffffffffc0203b30:	b73fe0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc0203b34:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc0203b36:	0e050c63          	beqz	a0,ffffffffc0203c2e <copy_range+0x166>
        if (*ptep & PTE_V)
ffffffffc0203b3a:	611c                	ld	a5,0(a0)
ffffffffc0203b3c:	8b85                	andi	a5,a5,1
ffffffffc0203b3e:	e785                	bnez	a5,ffffffffc0203b66 <copy_range+0x9e>
        start += PGSIZE;
ffffffffc0203b40:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0203b42:	ff2464e3          	bltu	s0,s2,ffffffffc0203b2a <copy_range+0x62>
    return 0;
ffffffffc0203b46:	4501                	li	a0,0
}
ffffffffc0203b48:	70a6                	ld	ra,104(sp)
ffffffffc0203b4a:	7406                	ld	s0,96(sp)
ffffffffc0203b4c:	64e6                	ld	s1,88(sp)
ffffffffc0203b4e:	6946                	ld	s2,80(sp)
ffffffffc0203b50:	69a6                	ld	s3,72(sp)
ffffffffc0203b52:	6a06                	ld	s4,64(sp)
ffffffffc0203b54:	7ae2                	ld	s5,56(sp)
ffffffffc0203b56:	7b42                	ld	s6,48(sp)
ffffffffc0203b58:	7ba2                	ld	s7,40(sp)
ffffffffc0203b5a:	7c02                	ld	s8,32(sp)
ffffffffc0203b5c:	6ce2                	ld	s9,24(sp)
ffffffffc0203b5e:	6d42                	ld	s10,16(sp)
ffffffffc0203b60:	6da2                	ld	s11,8(sp)
ffffffffc0203b62:	6165                	addi	sp,sp,112
ffffffffc0203b64:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc0203b66:	4605                	li	a2,1
ffffffffc0203b68:	85a2                	mv	a1,s0
ffffffffc0203b6a:	8556                	mv	a0,s5
ffffffffc0203b6c:	b37fe0ef          	jal	ra,ffffffffc02026a2 <get_pte>
ffffffffc0203b70:	c56d                	beqz	a0,ffffffffc0203c5a <copy_range+0x192>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203b72:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V))
ffffffffc0203b74:	0017f713          	andi	a4,a5,1
ffffffffc0203b78:	01f7f493          	andi	s1,a5,31
ffffffffc0203b7c:	16070a63          	beqz	a4,ffffffffc0203cf0 <copy_range+0x228>
    if (PPN(pa) >= npage)
ffffffffc0203b80:	000c3683          	ld	a3,0(s8)
    return pa2page(PTE_ADDR(pte));
ffffffffc0203b84:	078a                	slli	a5,a5,0x2
ffffffffc0203b86:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203b8a:	14d77763          	bgeu	a4,a3,ffffffffc0203cd8 <copy_range+0x210>
    return &pages[PPN(pa) - nbase];
ffffffffc0203b8e:	000bb783          	ld	a5,0(s7)
ffffffffc0203b92:	fff806b7          	lui	a3,0xfff80
ffffffffc0203b96:	9736                	add	a4,a4,a3
ffffffffc0203b98:	071a                	slli	a4,a4,0x6
ffffffffc0203b9a:	00e78db3          	add	s11,a5,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203b9e:	10002773          	csrr	a4,sstatus
ffffffffc0203ba2:	8b09                	andi	a4,a4,2
ffffffffc0203ba4:	e345                	bnez	a4,ffffffffc0203c44 <copy_range+0x17c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203ba6:	000cb703          	ld	a4,0(s9)
ffffffffc0203baa:	4505                	li	a0,1
ffffffffc0203bac:	6f18                	ld	a4,24(a4)
ffffffffc0203bae:	9702                	jalr	a4
ffffffffc0203bb0:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0203bb2:	0c0d8363          	beqz	s11,ffffffffc0203c78 <copy_range+0x1b0>
            assert(npage != NULL);
ffffffffc0203bb6:	100d0163          	beqz	s10,ffffffffc0203cb8 <copy_range+0x1f0>
    return page - pages + nbase;
ffffffffc0203bba:	000bb703          	ld	a4,0(s7)
ffffffffc0203bbe:	000805b7          	lui	a1,0x80
    return KADDR(page2pa(page));
ffffffffc0203bc2:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0203bc6:	40ed86b3          	sub	a3,s11,a4
ffffffffc0203bca:	8699                	srai	a3,a3,0x6
ffffffffc0203bcc:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc0203bce:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0203bd2:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203bd4:	08c7f663          	bgeu	a5,a2,ffffffffc0203c60 <copy_range+0x198>
    return page - pages + nbase;
ffffffffc0203bd8:	40ed07b3          	sub	a5,s10,a4
    return KADDR(page2pa(page));
ffffffffc0203bdc:	000a7717          	auipc	a4,0xa7
ffffffffc0203be0:	adc70713          	addi	a4,a4,-1316 # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0203be4:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc0203be6:	8799                	srai	a5,a5,0x6
ffffffffc0203be8:	97ae                	add	a5,a5,a1
    return KADDR(page2pa(page));
ffffffffc0203bea:	0167f733          	and	a4,a5,s6
ffffffffc0203bee:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc0203bf2:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc0203bf4:	06c77563          	bgeu	a4,a2,ffffffffc0203c5e <copy_range+0x196>
            memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
ffffffffc0203bf8:	6605                	lui	a2,0x1
ffffffffc0203bfa:	953e                	add	a0,a0,a5
ffffffffc0203bfc:	6b8010ef          	jal	ra,ffffffffc02052b4 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc0203c00:	86a6                	mv	a3,s1
ffffffffc0203c02:	8622                	mv	a2,s0
ffffffffc0203c04:	85ea                	mv	a1,s10
ffffffffc0203c06:	8556                	mv	a0,s5
ffffffffc0203c08:	98aff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
            assert(ret == 0);
ffffffffc0203c0c:	d915                	beqz	a0,ffffffffc0203b40 <copy_range+0x78>
ffffffffc0203c0e:	00003697          	auipc	a3,0x3
ffffffffc0203c12:	2e268693          	addi	a3,a3,738 # ffffffffc0206ef0 <default_pmm_manager+0x670>
ffffffffc0203c16:	00002617          	auipc	a2,0x2
ffffffffc0203c1a:	55a60613          	addi	a2,a2,1370 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203c1e:	1b200593          	li	a1,434
ffffffffc0203c22:	00003517          	auipc	a0,0x3
ffffffffc0203c26:	cbe50513          	addi	a0,a0,-834 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203c2a:	df4fc0ef          	jal	ra,ffffffffc020021e <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0203c2e:	00200637          	lui	a2,0x200
ffffffffc0203c32:	9432                	add	s0,s0,a2
ffffffffc0203c34:	ffe00637          	lui	a2,0xffe00
ffffffffc0203c38:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc0203c3a:	f00406e3          	beqz	s0,ffffffffc0203b46 <copy_range+0x7e>
ffffffffc0203c3e:	ef2466e3          	bltu	s0,s2,ffffffffc0203b2a <copy_range+0x62>
ffffffffc0203c42:	b711                	j	ffffffffc0203b46 <copy_range+0x7e>
        intr_disable();
ffffffffc0203c44:	d77fc0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203c48:	000cb703          	ld	a4,0(s9)
ffffffffc0203c4c:	4505                	li	a0,1
ffffffffc0203c4e:	6f18                	ld	a4,24(a4)
ffffffffc0203c50:	9702                	jalr	a4
ffffffffc0203c52:	8d2a                	mv	s10,a0
        intr_enable();
ffffffffc0203c54:	d61fc0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203c58:	bfa9                	j	ffffffffc0203bb2 <copy_range+0xea>
                return -E_NO_MEM;
ffffffffc0203c5a:	5571                	li	a0,-4
ffffffffc0203c5c:	b5f5                	j	ffffffffc0203b48 <copy_range+0x80>
ffffffffc0203c5e:	86be                	mv	a3,a5
ffffffffc0203c60:	00002617          	auipc	a2,0x2
ffffffffc0203c64:	78860613          	addi	a2,a2,1928 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0203c68:	07100593          	li	a1,113
ffffffffc0203c6c:	00002517          	auipc	a0,0x2
ffffffffc0203c70:	7a450513          	addi	a0,a0,1956 # ffffffffc0206410 <commands+0xa98>
ffffffffc0203c74:	daafc0ef          	jal	ra,ffffffffc020021e <__panic>
            assert(page != NULL);
ffffffffc0203c78:	00003697          	auipc	a3,0x3
ffffffffc0203c7c:	25868693          	addi	a3,a3,600 # ffffffffc0206ed0 <default_pmm_manager+0x650>
ffffffffc0203c80:	00002617          	auipc	a2,0x2
ffffffffc0203c84:	4f060613          	addi	a2,a2,1264 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203c88:	19400593          	li	a1,404
ffffffffc0203c8c:	00003517          	auipc	a0,0x3
ffffffffc0203c90:	c5450513          	addi	a0,a0,-940 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203c94:	d8afc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0203c98:	00003697          	auipc	a3,0x3
ffffffffc0203c9c:	c8868693          	addi	a3,a3,-888 # ffffffffc0206920 <default_pmm_manager+0xa0>
ffffffffc0203ca0:	00002617          	auipc	a2,0x2
ffffffffc0203ca4:	4d060613          	addi	a2,a2,1232 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203ca8:	17c00593          	li	a1,380
ffffffffc0203cac:	00003517          	auipc	a0,0x3
ffffffffc0203cb0:	c3450513          	addi	a0,a0,-972 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203cb4:	d6afc0ef          	jal	ra,ffffffffc020021e <__panic>
            assert(npage != NULL);
ffffffffc0203cb8:	00003697          	auipc	a3,0x3
ffffffffc0203cbc:	22868693          	addi	a3,a3,552 # ffffffffc0206ee0 <default_pmm_manager+0x660>
ffffffffc0203cc0:	00002617          	auipc	a2,0x2
ffffffffc0203cc4:	4b060613          	addi	a2,a2,1200 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203cc8:	19500593          	li	a1,405
ffffffffc0203ccc:	00003517          	auipc	a0,0x3
ffffffffc0203cd0:	c1450513          	addi	a0,a0,-1004 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203cd4:	d4afc0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203cd8:	00002617          	auipc	a2,0x2
ffffffffc0203cdc:	7e060613          	addi	a2,a2,2016 # ffffffffc02064b8 <commands+0xb40>
ffffffffc0203ce0:	06900593          	li	a1,105
ffffffffc0203ce4:	00002517          	auipc	a0,0x2
ffffffffc0203ce8:	72c50513          	addi	a0,a0,1836 # ffffffffc0206410 <commands+0xa98>
ffffffffc0203cec:	d32fc0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0203cf0:	00003617          	auipc	a2,0x3
ffffffffc0203cf4:	bc860613          	addi	a2,a2,-1080 # ffffffffc02068b8 <default_pmm_manager+0x38>
ffffffffc0203cf8:	07f00593          	li	a1,127
ffffffffc0203cfc:	00002517          	auipc	a0,0x2
ffffffffc0203d00:	71450513          	addi	a0,a0,1812 # ffffffffc0206410 <commands+0xa98>
ffffffffc0203d04:	d1afc0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203d08:	00003697          	auipc	a3,0x3
ffffffffc0203d0c:	be868693          	addi	a3,a3,-1048 # ffffffffc02068f0 <default_pmm_manager+0x70>
ffffffffc0203d10:	00002617          	auipc	a2,0x2
ffffffffc0203d14:	46060613          	addi	a2,a2,1120 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203d18:	17b00593          	li	a1,379
ffffffffc0203d1c:	00003517          	auipc	a0,0x3
ffffffffc0203d20:	bc450513          	addi	a0,a0,-1084 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203d24:	cfafc0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0203d28 <pgdir_alloc_page>:
{
ffffffffc0203d28:	7179                	addi	sp,sp,-48
ffffffffc0203d2a:	ec26                	sd	s1,24(sp)
ffffffffc0203d2c:	e84a                	sd	s2,16(sp)
ffffffffc0203d2e:	e052                	sd	s4,0(sp)
ffffffffc0203d30:	f406                	sd	ra,40(sp)
ffffffffc0203d32:	f022                	sd	s0,32(sp)
ffffffffc0203d34:	e44e                	sd	s3,8(sp)
ffffffffc0203d36:	8a2a                	mv	s4,a0
ffffffffc0203d38:	84ae                	mv	s1,a1
ffffffffc0203d3a:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203d3c:	100027f3          	csrr	a5,sstatus
ffffffffc0203d40:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc0203d42:	000a7997          	auipc	s3,0xa7
ffffffffc0203d46:	96e98993          	addi	s3,s3,-1682 # ffffffffc02aa6b0 <pmm_manager>
ffffffffc0203d4a:	ef8d                	bnez	a5,ffffffffc0203d84 <pgdir_alloc_page+0x5c>
ffffffffc0203d4c:	0009b783          	ld	a5,0(s3)
ffffffffc0203d50:	4505                	li	a0,1
ffffffffc0203d52:	6f9c                	ld	a5,24(a5)
ffffffffc0203d54:	9782                	jalr	a5
ffffffffc0203d56:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc0203d58:	cc09                	beqz	s0,ffffffffc0203d72 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc0203d5a:	86ca                	mv	a3,s2
ffffffffc0203d5c:	8626                	mv	a2,s1
ffffffffc0203d5e:	85a2                	mv	a1,s0
ffffffffc0203d60:	8552                	mv	a0,s4
ffffffffc0203d62:	830ff0ef          	jal	ra,ffffffffc0202d92 <page_insert>
ffffffffc0203d66:	e915                	bnez	a0,ffffffffc0203d9a <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc0203d68:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc0203d6a:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc0203d6c:	4785                	li	a5,1
ffffffffc0203d6e:	04f71e63          	bne	a4,a5,ffffffffc0203dca <pgdir_alloc_page+0xa2>
}
ffffffffc0203d72:	70a2                	ld	ra,40(sp)
ffffffffc0203d74:	8522                	mv	a0,s0
ffffffffc0203d76:	7402                	ld	s0,32(sp)
ffffffffc0203d78:	64e2                	ld	s1,24(sp)
ffffffffc0203d7a:	6942                	ld	s2,16(sp)
ffffffffc0203d7c:	69a2                	ld	s3,8(sp)
ffffffffc0203d7e:	6a02                	ld	s4,0(sp)
ffffffffc0203d80:	6145                	addi	sp,sp,48
ffffffffc0203d82:	8082                	ret
        intr_disable();
ffffffffc0203d84:	c37fc0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203d88:	0009b783          	ld	a5,0(s3)
ffffffffc0203d8c:	4505                	li	a0,1
ffffffffc0203d8e:	6f9c                	ld	a5,24(a5)
ffffffffc0203d90:	9782                	jalr	a5
ffffffffc0203d92:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0203d94:	c21fc0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203d98:	b7c1                	j	ffffffffc0203d58 <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203d9a:	100027f3          	csrr	a5,sstatus
ffffffffc0203d9e:	8b89                	andi	a5,a5,2
ffffffffc0203da0:	eb89                	bnez	a5,ffffffffc0203db2 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc0203da2:	0009b783          	ld	a5,0(s3)
ffffffffc0203da6:	8522                	mv	a0,s0
ffffffffc0203da8:	4585                	li	a1,1
ffffffffc0203daa:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203dac:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203dae:	9782                	jalr	a5
    if (flag)
ffffffffc0203db0:	b7c9                	j	ffffffffc0203d72 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc0203db2:	c09fc0ef          	jal	ra,ffffffffc02009ba <intr_disable>
ffffffffc0203db6:	0009b783          	ld	a5,0(s3)
ffffffffc0203dba:	8522                	mv	a0,s0
ffffffffc0203dbc:	4585                	li	a1,1
ffffffffc0203dbe:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203dc0:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203dc2:	9782                	jalr	a5
        intr_enable();
ffffffffc0203dc4:	bf1fc0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0203dc8:	b76d                	j	ffffffffc0203d72 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc0203dca:	00003697          	auipc	a3,0x3
ffffffffc0203dce:	13668693          	addi	a3,a3,310 # ffffffffc0206f00 <default_pmm_manager+0x680>
ffffffffc0203dd2:	00002617          	auipc	a2,0x2
ffffffffc0203dd6:	39e60613          	addi	a2,a2,926 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0203dda:	1fb00593          	li	a1,507
ffffffffc0203dde:	00003517          	auipc	a0,0x3
ffffffffc0203de2:	b0250513          	addi	a0,a0,-1278 # ffffffffc02068e0 <default_pmm_manager+0x60>
ffffffffc0203de6:	c38fc0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0203dea <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203dea:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203dec:	9402                	jalr	s0

	jal do_exit
ffffffffc0203dee:	656000ef          	jal	ra,ffffffffc0204444 <do_exit>

ffffffffc0203df2 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0203df2:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0203df6:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0203dfa:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0203dfc:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0203dfe:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0203e02:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0203e06:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0203e0a:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0203e0e:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0203e12:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0203e16:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0203e1a:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0203e1e:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0203e22:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0203e26:	0005b083          	ld	ra,0(a1) # 80000 <_binary_obj___user_exit_out_size+0x74ee8>
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0203e2a:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0203e2e:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0203e30:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0203e32:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0203e36:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0203e3a:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0203e3e:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0203e42:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0203e46:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0203e4a:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0203e4e:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0203e52:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0203e56:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0203e5a:	8082                	ret

ffffffffc0203e5c <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203e5c:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203e5e:	10800513          	li	a0,264
{
ffffffffc0203e62:	e022                	sd	s0,0(sp)
ffffffffc0203e64:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203e66:	af9fd0ef          	jal	ra,ffffffffc020195e <kmalloc>
ffffffffc0203e6a:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203e6c:	cd21                	beqz	a0,ffffffffc0203ec4 <alloc_proc+0x68>
         *       uintptr_t pgdir;                            // the base addr of Page Directroy Table(PDT)
         *       uint32_t flags;                             // Process flag
         *       char name[PROC_NAME_LEN + 1];               // Process name
         */

        proc->state = PROC_UNINIT; //进程状态为未初始化
ffffffffc0203e6e:	57fd                	li	a5,-1
ffffffffc0203e70:	1782                	slli	a5,a5,0x20
ffffffffc0203e72:	e11c                	sd	a5,0(a0)
        proc->runs = 0; //运行次数为0
        proc->kstack = 0; //内核栈地址为0
        proc->need_resched = 0; //不需要重新调度
        proc->parent = NULL; //父进程为空
        proc->mm = NULL; //内存管理结构为空
        memset(&proc->context, 0, sizeof(struct context)); //初始化上下文为0
ffffffffc0203e74:	07000613          	li	a2,112
ffffffffc0203e78:	4581                	li	a1,0
        proc->runs = 0; //运行次数为0
ffffffffc0203e7a:	00052423          	sw	zero,8(a0)
        proc->kstack = 0; //内核栈地址为0
ffffffffc0203e7e:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0; //不需要重新调度
ffffffffc0203e82:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL; //父进程为空
ffffffffc0203e86:	02053023          	sd	zero,32(a0)
        proc->mm = NULL; //内存管理结构为空
ffffffffc0203e8a:	02053423          	sd	zero,40(a0)
        memset(&proc->context, 0, sizeof(struct context)); //初始化上下文为0
ffffffffc0203e8e:	03050513          	addi	a0,a0,48
ffffffffc0203e92:	410010ef          	jal	ra,ffffffffc02052a2 <memset>
        proc->tf = NULL; //陷阱帧为空
        proc->pgdir = boot_pgdir_pa; //页目录表基址为引导页目录表物理地址
ffffffffc0203e96:	000a6797          	auipc	a5,0xa6
ffffffffc0203e9a:	7fa7b783          	ld	a5,2042(a5) # ffffffffc02aa690 <boot_pgdir_pa>
        proc->tf = NULL; //陷阱帧为空
ffffffffc0203e9e:	0a043023          	sd	zero,160(s0)
        proc->pgdir = boot_pgdir_pa; //页目录表基址为引导页目录表物理地址
ffffffffc0203ea2:	f45c                	sd	a5,168(s0)
        proc->flags = 0; //进程标志为0
ffffffffc0203ea4:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN + 1); //进程名称为空字符串
ffffffffc0203ea8:	4641                	li	a2,16
ffffffffc0203eaa:	4581                	li	a1,0
ffffffffc0203eac:	0b440513          	addi	a0,s0,180
ffffffffc0203eb0:	3f2010ef          	jal	ra,ffffffffc02052a2 <memset>
        /*
         * below fields(add in LAB5) in proc_struct need to be initialized
         *       uint32_t wait_state;                        // waiting state
         *       struct proc_struct *cptr, *yptr, *optr;     // relations between processes
         */
        proc->wait_state = 0; // 初始化为0，表示不处于等待状态
ffffffffc0203eb4:	0e042623          	sw	zero,236(s0)
        proc->cptr = NULL; // 子进程指针初始化为NULL
ffffffffc0203eb8:	0e043823          	sd	zero,240(s0)
        proc->yptr = NULL; // 年轻兄弟进程指针初始化为NULL
ffffffffc0203ebc:	0e043c23          	sd	zero,248(s0)
        proc->optr = NULL; // 年长兄弟进程指针初始化为NULL
ffffffffc0203ec0:	10043023          	sd	zero,256(s0)
        
    }
    return proc;
}
ffffffffc0203ec4:	60a2                	ld	ra,8(sp)
ffffffffc0203ec6:	8522                	mv	a0,s0
ffffffffc0203ec8:	6402                	ld	s0,0(sp)
ffffffffc0203eca:	0141                	addi	sp,sp,16
ffffffffc0203ecc:	8082                	ret

ffffffffc0203ece <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203ece:	000a6797          	auipc	a5,0xa6
ffffffffc0203ed2:	7f27b783          	ld	a5,2034(a5) # ffffffffc02aa6c0 <current>
ffffffffc0203ed6:	73c8                	ld	a0,160(a5)
ffffffffc0203ed8:	87afd06f          	j	ffffffffc0200f52 <forkrets>

ffffffffc0203edc <user_main>:
// user_main - kernel thread used to exec a user program
static int
user_main(void *arg)
{
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203edc:	000a6797          	auipc	a5,0xa6
ffffffffc0203ee0:	7e47b783          	ld	a5,2020(a5) # ffffffffc02aa6c0 <current>
ffffffffc0203ee4:	43cc                	lw	a1,4(a5)
{
ffffffffc0203ee6:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203ee8:	00003617          	auipc	a2,0x3
ffffffffc0203eec:	03060613          	addi	a2,a2,48 # ffffffffc0206f18 <default_pmm_manager+0x698>
ffffffffc0203ef0:	00003517          	auipc	a0,0x3
ffffffffc0203ef4:	03850513          	addi	a0,a0,56 # ffffffffc0206f28 <default_pmm_manager+0x6a8>
{
ffffffffc0203ef8:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203efa:	9e6fc0ef          	jal	ra,ffffffffc02000e0 <cprintf>
ffffffffc0203efe:	3fe07797          	auipc	a5,0x3fe07
ffffffffc0203f02:	a6278793          	addi	a5,a5,-1438 # a960 <_binary_obj___user_forktest_out_size>
ffffffffc0203f06:	e43e                	sd	a5,8(sp)
ffffffffc0203f08:	00003517          	auipc	a0,0x3
ffffffffc0203f0c:	01050513          	addi	a0,a0,16 # ffffffffc0206f18 <default_pmm_manager+0x698>
ffffffffc0203f10:	00098797          	auipc	a5,0x98
ffffffffc0203f14:	9a078793          	addi	a5,a5,-1632 # ffffffffc029b8b0 <_binary_obj___user_forktest_out_start>
ffffffffc0203f18:	f03e                	sd	a5,32(sp)
ffffffffc0203f1a:	f42a                	sd	a0,40(sp)
    int64_t ret = 0, len = strlen(name);
ffffffffc0203f1c:	e802                	sd	zero,16(sp)
ffffffffc0203f1e:	2e2010ef          	jal	ra,ffffffffc0205200 <strlen>
ffffffffc0203f22:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203f24:	4511                	li	a0,4
ffffffffc0203f26:	55a2                	lw	a1,40(sp)
ffffffffc0203f28:	4662                	lw	a2,24(sp)
ffffffffc0203f2a:	5682                	lw	a3,32(sp)
ffffffffc0203f2c:	4722                	lw	a4,8(sp)
ffffffffc0203f2e:	48a9                	li	a7,10
ffffffffc0203f30:	9002                	ebreak
ffffffffc0203f32:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203f34:	65c2                	ld	a1,16(sp)
ffffffffc0203f36:	00003517          	auipc	a0,0x3
ffffffffc0203f3a:	01a50513          	addi	a0,a0,26 # ffffffffc0206f50 <default_pmm_manager+0x6d0>
ffffffffc0203f3e:	9a2fc0ef          	jal	ra,ffffffffc02000e0 <cprintf>
#else
    KERNEL_EXECVE(exit);
#endif
    panic("user_main execve failed.\n");
ffffffffc0203f42:	00003617          	auipc	a2,0x3
ffffffffc0203f46:	01e60613          	addi	a2,a2,30 # ffffffffc0206f60 <default_pmm_manager+0x6e0>
ffffffffc0203f4a:	3c900593          	li	a1,969
ffffffffc0203f4e:	00003517          	auipc	a0,0x3
ffffffffc0203f52:	03250513          	addi	a0,a0,50 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0203f56:	ac8fc0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0203f5a <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203f5a:	6d14                	ld	a3,24(a0)
{
ffffffffc0203f5c:	1141                	addi	sp,sp,-16
ffffffffc0203f5e:	e406                	sd	ra,8(sp)
ffffffffc0203f60:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f64:	02f6ee63          	bltu	a3,a5,ffffffffc0203fa0 <put_pgdir+0x46>
ffffffffc0203f68:	000a6517          	auipc	a0,0xa6
ffffffffc0203f6c:	75053503          	ld	a0,1872(a0) # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0203f70:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203f72:	82b1                	srli	a3,a3,0xc
ffffffffc0203f74:	000a6797          	auipc	a5,0xa6
ffffffffc0203f78:	72c7b783          	ld	a5,1836(a5) # ffffffffc02aa6a0 <npage>
ffffffffc0203f7c:	02f6fe63          	bgeu	a3,a5,ffffffffc0203fb8 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203f80:	00004517          	auipc	a0,0x4
ffffffffc0203f84:	89853503          	ld	a0,-1896(a0) # ffffffffc0207818 <nbase>
}
ffffffffc0203f88:	60a2                	ld	ra,8(sp)
ffffffffc0203f8a:	8e89                	sub	a3,a3,a0
ffffffffc0203f8c:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203f8e:	000a6517          	auipc	a0,0xa6
ffffffffc0203f92:	71a53503          	ld	a0,1818(a0) # ffffffffc02aa6a8 <pages>
ffffffffc0203f96:	4585                	li	a1,1
ffffffffc0203f98:	9536                	add	a0,a0,a3
}
ffffffffc0203f9a:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203f9c:	e8cfe06f          	j	ffffffffc0202628 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203fa0:	00002617          	auipc	a2,0x2
ffffffffc0203fa4:	4f060613          	addi	a2,a2,1264 # ffffffffc0206490 <commands+0xb18>
ffffffffc0203fa8:	07700593          	li	a1,119
ffffffffc0203fac:	00002517          	auipc	a0,0x2
ffffffffc0203fb0:	46450513          	addi	a0,a0,1124 # ffffffffc0206410 <commands+0xa98>
ffffffffc0203fb4:	a6afc0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203fb8:	00002617          	auipc	a2,0x2
ffffffffc0203fbc:	50060613          	addi	a2,a2,1280 # ffffffffc02064b8 <commands+0xb40>
ffffffffc0203fc0:	06900593          	li	a1,105
ffffffffc0203fc4:	00002517          	auipc	a0,0x2
ffffffffc0203fc8:	44c50513          	addi	a0,a0,1100 # ffffffffc0206410 <commands+0xa98>
ffffffffc0203fcc:	a52fc0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0203fd0 <proc_run>:
{
ffffffffc0203fd0:	7179                	addi	sp,sp,-48
ffffffffc0203fd2:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203fd4:	000a6497          	auipc	s1,0xa6
ffffffffc0203fd8:	6ec48493          	addi	s1,s1,1772 # ffffffffc02aa6c0 <current>
ffffffffc0203fdc:	6098                	ld	a4,0(s1)
{
ffffffffc0203fde:	f406                	sd	ra,40(sp)
ffffffffc0203fe0:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203fe2:	02a70763          	beq	a4,a0,ffffffffc0204010 <proc_run+0x40>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203fe6:	100027f3          	csrr	a5,sstatus
ffffffffc0203fea:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203fec:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203fee:	ef85                	bnez	a5,ffffffffc0204026 <proc_run+0x56>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203ff0:	755c                	ld	a5,168(a0)
ffffffffc0203ff2:	56fd                	li	a3,-1
ffffffffc0203ff4:	16fe                	slli	a3,a3,0x3f
ffffffffc0203ff6:	83b1                	srli	a5,a5,0xc
        current = proc;
ffffffffc0203ff8:	e088                	sd	a0,0(s1)
ffffffffc0203ffa:	8fd5                	or	a5,a5,a3
ffffffffc0203ffc:	18079073          	csrw	satp,a5
        switch_to(&(prev->context), &(next->context));
ffffffffc0204000:	03050593          	addi	a1,a0,48
ffffffffc0204004:	03070513          	addi	a0,a4,48
ffffffffc0204008:	debff0ef          	jal	ra,ffffffffc0203df2 <switch_to>
    if (flag)
ffffffffc020400c:	00091763          	bnez	s2,ffffffffc020401a <proc_run+0x4a>
}
ffffffffc0204010:	70a2                	ld	ra,40(sp)
ffffffffc0204012:	7482                	ld	s1,32(sp)
ffffffffc0204014:	6962                	ld	s2,24(sp)
ffffffffc0204016:	6145                	addi	sp,sp,48
ffffffffc0204018:	8082                	ret
ffffffffc020401a:	70a2                	ld	ra,40(sp)
ffffffffc020401c:	7482                	ld	s1,32(sp)
ffffffffc020401e:	6962                	ld	s2,24(sp)
ffffffffc0204020:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0204022:	993fc06f          	j	ffffffffc02009b4 <intr_enable>
ffffffffc0204026:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0204028:	993fc0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        struct proc_struct *prev = current;
ffffffffc020402c:	6098                	ld	a4,0(s1)
        return 1;
ffffffffc020402e:	6522                	ld	a0,8(sp)
ffffffffc0204030:	4905                	li	s2,1
ffffffffc0204032:	bf7d                	j	ffffffffc0203ff0 <proc_run+0x20>

ffffffffc0204034 <do_fork>:
{
ffffffffc0204034:	7119                	addi	sp,sp,-128
ffffffffc0204036:	f4a6                	sd	s1,104(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0204038:	000a6497          	auipc	s1,0xa6
ffffffffc020403c:	6a048493          	addi	s1,s1,1696 # ffffffffc02aa6d8 <nr_process>
ffffffffc0204040:	4098                	lw	a4,0(s1)
{
ffffffffc0204042:	fc86                	sd	ra,120(sp)
ffffffffc0204044:	f8a2                	sd	s0,112(sp)
ffffffffc0204046:	f0ca                	sd	s2,96(sp)
ffffffffc0204048:	ecce                	sd	s3,88(sp)
ffffffffc020404a:	e8d2                	sd	s4,80(sp)
ffffffffc020404c:	e4d6                	sd	s5,72(sp)
ffffffffc020404e:	e0da                	sd	s6,64(sp)
ffffffffc0204050:	fc5e                	sd	s7,56(sp)
ffffffffc0204052:	f862                	sd	s8,48(sp)
ffffffffc0204054:	f466                	sd	s9,40(sp)
ffffffffc0204056:	f06a                	sd	s10,32(sp)
ffffffffc0204058:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc020405a:	6785                	lui	a5,0x1
ffffffffc020405c:	30f75163          	bge	a4,a5,ffffffffc020435e <do_fork+0x32a>
ffffffffc0204060:	8a2a                	mv	s4,a0
ffffffffc0204062:	892e                	mv	s2,a1
ffffffffc0204064:	89b2                	mv	s3,a2
    proc = alloc_proc();
ffffffffc0204066:	df7ff0ef          	jal	ra,ffffffffc0203e5c <alloc_proc>
ffffffffc020406a:	842a                	mv	s0,a0
    if (proc == NULL) { // 分配失败
ffffffffc020406c:	30050063          	beqz	a0,ffffffffc020436c <do_fork+0x338>
    proc->parent = current;
ffffffffc0204070:	000a6b97          	auipc	s7,0xa6
ffffffffc0204074:	650b8b93          	addi	s7,s7,1616 # ffffffffc02aa6c0 <current>
ffffffffc0204078:	000bb783          	ld	a5,0(s7)
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc020407c:	4509                	li	a0,2
    proc->parent = current;
ffffffffc020407e:	f01c                	sd	a5,32(s0)
    current->wait_state = 0;
ffffffffc0204080:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_obj___user_faultread_out_size-0x8abc>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0204084:	d66fe0ef          	jal	ra,ffffffffc02025ea <alloc_pages>
    if (page != NULL)
ffffffffc0204088:	2c050963          	beqz	a0,ffffffffc020435a <do_fork+0x326>
    return page - pages + nbase;
ffffffffc020408c:	000a6c97          	auipc	s9,0xa6
ffffffffc0204090:	61cc8c93          	addi	s9,s9,1564 # ffffffffc02aa6a8 <pages>
ffffffffc0204094:	000cb683          	ld	a3,0(s9)
ffffffffc0204098:	00003a97          	auipc	s5,0x3
ffffffffc020409c:	780a8a93          	addi	s5,s5,1920 # ffffffffc0207818 <nbase>
ffffffffc02040a0:	000ab703          	ld	a4,0(s5)
ffffffffc02040a4:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc02040a8:	000a6d17          	auipc	s10,0xa6
ffffffffc02040ac:	5f8d0d13          	addi	s10,s10,1528 # ffffffffc02aa6a0 <npage>
    return page - pages + nbase;
ffffffffc02040b0:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02040b2:	5b7d                	li	s6,-1
ffffffffc02040b4:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc02040b8:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc02040ba:	00cb5b13          	srli	s6,s6,0xc
ffffffffc02040be:	0166f633          	and	a2,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc02040c2:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02040c4:	2af67b63          	bgeu	a2,a5,ffffffffc020437a <do_fork+0x346>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc02040c8:	000bb603          	ld	a2,0(s7)
ffffffffc02040cc:	000a6d97          	auipc	s11,0xa6
ffffffffc02040d0:	5ecd8d93          	addi	s11,s11,1516 # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc02040d4:	000db783          	ld	a5,0(s11)
ffffffffc02040d8:	02863b83          	ld	s7,40(a2)
ffffffffc02040dc:	e43a                	sd	a4,8(sp)
ffffffffc02040de:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc02040e0:	e814                	sd	a3,16(s0)
    if (oldmm == NULL)
ffffffffc02040e2:	020b8863          	beqz	s7,ffffffffc0204112 <do_fork+0xde>
    if (clone_flags & CLONE_VM)
ffffffffc02040e6:	100a7a13          	andi	s4,s4,256
ffffffffc02040ea:	180a0963          	beqz	s4,ffffffffc020427c <do_fork+0x248>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc02040ee:	030ba703          	lw	a4,48(s7)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc02040f2:	018bb783          	ld	a5,24(s7)
ffffffffc02040f6:	c02006b7          	lui	a3,0xc0200
ffffffffc02040fa:	2705                	addiw	a4,a4,1
ffffffffc02040fc:	02eba823          	sw	a4,48(s7)
    proc->mm = mm;
ffffffffc0204100:	03743423          	sd	s7,40(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204104:	2ad7e363          	bltu	a5,a3,ffffffffc02043aa <do_fork+0x376>
ffffffffc0204108:	000db703          	ld	a4,0(s11)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc020410c:	6814                	ld	a3,16(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc020410e:	8f99                	sub	a5,a5,a4
ffffffffc0204110:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0204112:	6789                	lui	a5,0x2
ffffffffc0204114:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cc8>
ffffffffc0204118:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc020411a:	864e                	mv	a2,s3
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc020411c:	f054                	sd	a3,160(s0)
    *(proc->tf) = *tf;
ffffffffc020411e:	87b6                	mv	a5,a3
ffffffffc0204120:	12098893          	addi	a7,s3,288
ffffffffc0204124:	00063803          	ld	a6,0(a2)
ffffffffc0204128:	6608                	ld	a0,8(a2)
ffffffffc020412a:	6a0c                	ld	a1,16(a2)
ffffffffc020412c:	6e18                	ld	a4,24(a2)
ffffffffc020412e:	0107b023          	sd	a6,0(a5)
ffffffffc0204132:	e788                	sd	a0,8(a5)
ffffffffc0204134:	eb8c                	sd	a1,16(a5)
ffffffffc0204136:	ef98                	sd	a4,24(a5)
ffffffffc0204138:	02060613          	addi	a2,a2,32
ffffffffc020413c:	02078793          	addi	a5,a5,32
ffffffffc0204140:	ff1612e3          	bne	a2,a7,ffffffffc0204124 <do_fork+0xf0>
    proc->tf->gpr.a0 = 0;
ffffffffc0204144:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0204148:	1c090363          	beqz	s2,ffffffffc020430e <do_fork+0x2da>
    if (++last_pid >= MAX_PID)
ffffffffc020414c:	000a2817          	auipc	a6,0xa2
ffffffffc0204150:	0dc80813          	addi	a6,a6,220 # ffffffffc02a6228 <last_pid.1>
ffffffffc0204154:	00082783          	lw	a5,0(a6)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0204158:	0126b823          	sd	s2,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc020415c:	00000717          	auipc	a4,0x0
ffffffffc0204160:	d7270713          	addi	a4,a4,-654 # ffffffffc0203ece <forkret>
    if (++last_pid >= MAX_PID)
ffffffffc0204164:	0017851b          	addiw	a0,a5,1
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0204168:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc020416a:	fc14                	sd	a3,56(s0)
    if (++last_pid >= MAX_PID)
ffffffffc020416c:	00a82023          	sw	a0,0(a6)
ffffffffc0204170:	6789                	lui	a5,0x2
ffffffffc0204172:	08f55e63          	bge	a0,a5,ffffffffc020420e <do_fork+0x1da>
    if (last_pid >= next_safe)
ffffffffc0204176:	000a2317          	auipc	t1,0xa2
ffffffffc020417a:	0b630313          	addi	t1,t1,182 # ffffffffc02a622c <next_safe.0>
ffffffffc020417e:	00032783          	lw	a5,0(t1)
ffffffffc0204182:	000a6917          	auipc	s2,0xa6
ffffffffc0204186:	4c690913          	addi	s2,s2,1222 # ffffffffc02aa648 <proc_list>
ffffffffc020418a:	08f55a63          	bge	a0,a5,ffffffffc020421e <do_fork+0x1ea>
    proc->pid = get_pid();
ffffffffc020418e:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204190:	45a9                	li	a1,10
ffffffffc0204192:	2501                	sext.w	a0,a0
ffffffffc0204194:	526010ef          	jal	ra,ffffffffc02056ba <hash32>
ffffffffc0204198:	02051793          	slli	a5,a0,0x20
ffffffffc020419c:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02041a0:	000a2797          	auipc	a5,0xa2
ffffffffc02041a4:	4a878793          	addi	a5,a5,1192 # ffffffffc02a6648 <hash_list>
ffffffffc02041a8:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc02041aa:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc02041ac:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02041ae:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc02041b2:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc02041b4:	00893603          	ld	a2,8(s2)
    prev->next = next->prev = elm;
ffffffffc02041b8:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc02041ba:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc02041bc:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc02041c0:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc02041c2:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc02041c4:	e21c                	sd	a5,0(a2)
ffffffffc02041c6:	00f93423          	sd	a5,8(s2)
    elm->next = next;
ffffffffc02041ca:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc02041cc:	0d243423          	sd	s2,200(s0)
    proc->yptr = NULL;
ffffffffc02041d0:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc02041d4:	10e43023          	sd	a4,256(s0)
ffffffffc02041d8:	c311                	beqz	a4,ffffffffc02041dc <do_fork+0x1a8>
        proc->optr->yptr = proc;
ffffffffc02041da:	ff60                	sd	s0,248(a4)
    nr_process++;
ffffffffc02041dc:	409c                	lw	a5,0(s1)
    proc->parent->cptr = proc;
ffffffffc02041de:	fae0                	sd	s0,240(a3)
    wakeup_proc(proc);
ffffffffc02041e0:	8522                	mv	a0,s0
    nr_process++;
ffffffffc02041e2:	2785                	addiw	a5,a5,1
ffffffffc02041e4:	c09c                	sw	a5,0(s1)
    wakeup_proc(proc);
ffffffffc02041e6:	62f000ef          	jal	ra,ffffffffc0205014 <wakeup_proc>
    ret = proc->pid;
ffffffffc02041ea:	00442a03          	lw	s4,4(s0)
}
ffffffffc02041ee:	70e6                	ld	ra,120(sp)
ffffffffc02041f0:	7446                	ld	s0,112(sp)
ffffffffc02041f2:	74a6                	ld	s1,104(sp)
ffffffffc02041f4:	7906                	ld	s2,96(sp)
ffffffffc02041f6:	69e6                	ld	s3,88(sp)
ffffffffc02041f8:	6aa6                	ld	s5,72(sp)
ffffffffc02041fa:	6b06                	ld	s6,64(sp)
ffffffffc02041fc:	7be2                	ld	s7,56(sp)
ffffffffc02041fe:	7c42                	ld	s8,48(sp)
ffffffffc0204200:	7ca2                	ld	s9,40(sp)
ffffffffc0204202:	7d02                	ld	s10,32(sp)
ffffffffc0204204:	6de2                	ld	s11,24(sp)
ffffffffc0204206:	8552                	mv	a0,s4
ffffffffc0204208:	6a46                	ld	s4,80(sp)
ffffffffc020420a:	6109                	addi	sp,sp,128
ffffffffc020420c:	8082                	ret
        last_pid = 1;
ffffffffc020420e:	4785                	li	a5,1
ffffffffc0204210:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc0204214:	4505                	li	a0,1
ffffffffc0204216:	000a2317          	auipc	t1,0xa2
ffffffffc020421a:	01630313          	addi	t1,t1,22 # ffffffffc02a622c <next_safe.0>
    return listelm->next;
ffffffffc020421e:	000a6917          	auipc	s2,0xa6
ffffffffc0204222:	42a90913          	addi	s2,s2,1066 # ffffffffc02aa648 <proc_list>
ffffffffc0204226:	00893e03          	ld	t3,8(s2)
        next_safe = MAX_PID;
ffffffffc020422a:	6789                	lui	a5,0x2
ffffffffc020422c:	00f32023          	sw	a5,0(t1)
ffffffffc0204230:	86aa                	mv	a3,a0
ffffffffc0204232:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc0204234:	6e89                	lui	t4,0x2
ffffffffc0204236:	132e0663          	beq	t3,s2,ffffffffc0204362 <do_fork+0x32e>
ffffffffc020423a:	88ae                	mv	a7,a1
ffffffffc020423c:	87f2                	mv	a5,t3
ffffffffc020423e:	6609                	lui	a2,0x2
ffffffffc0204240:	a811                	j	ffffffffc0204254 <do_fork+0x220>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc0204242:	00e6d663          	bge	a3,a4,ffffffffc020424e <do_fork+0x21a>
ffffffffc0204246:	00c75463          	bge	a4,a2,ffffffffc020424e <do_fork+0x21a>
ffffffffc020424a:	863a                	mv	a2,a4
ffffffffc020424c:	4885                	li	a7,1
ffffffffc020424e:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204250:	01278d63          	beq	a5,s2,ffffffffc020426a <do_fork+0x236>
            if (proc->pid == last_pid)
ffffffffc0204254:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7c6c>
ffffffffc0204258:	fed715e3          	bne	a4,a3,ffffffffc0204242 <do_fork+0x20e>
                if (++last_pid >= next_safe)
ffffffffc020425c:	2685                	addiw	a3,a3,1
ffffffffc020425e:	0ec6d963          	bge	a3,a2,ffffffffc0204350 <do_fork+0x31c>
ffffffffc0204262:	679c                	ld	a5,8(a5)
ffffffffc0204264:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc0204266:	ff2797e3          	bne	a5,s2,ffffffffc0204254 <do_fork+0x220>
ffffffffc020426a:	c581                	beqz	a1,ffffffffc0204272 <do_fork+0x23e>
ffffffffc020426c:	00d82023          	sw	a3,0(a6)
ffffffffc0204270:	8536                	mv	a0,a3
ffffffffc0204272:	f0088ee3          	beqz	a7,ffffffffc020418e <do_fork+0x15a>
ffffffffc0204276:	00c32023          	sw	a2,0(t1)
ffffffffc020427a:	bf11                	j	ffffffffc020418e <do_fork+0x15a>
    if ((mm = mm_create()) == NULL)
ffffffffc020427c:	da7fc0ef          	jal	ra,ffffffffc0201022 <mm_create>
ffffffffc0204280:	8c2a                	mv	s8,a0
ffffffffc0204282:	0e050a63          	beqz	a0,ffffffffc0204376 <do_fork+0x342>
    if ((page = alloc_page()) == NULL)
ffffffffc0204286:	4505                	li	a0,1
ffffffffc0204288:	b62fe0ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc020428c:	c159                	beqz	a0,ffffffffc0204312 <do_fork+0x2de>
    return page - pages + nbase;
ffffffffc020428e:	000cb683          	ld	a3,0(s9)
ffffffffc0204292:	6722                	ld	a4,8(sp)
    return KADDR(page2pa(page));
ffffffffc0204294:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc0204298:	40d506b3          	sub	a3,a0,a3
ffffffffc020429c:	8699                	srai	a3,a3,0x6
ffffffffc020429e:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc02042a0:	0166fb33          	and	s6,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc02042a4:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02042a6:	0cfb7a63          	bgeu	s6,a5,ffffffffc020437a <do_fork+0x346>
ffffffffc02042aa:	000dba03          	ld	s4,0(s11)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc02042ae:	6605                	lui	a2,0x1
ffffffffc02042b0:	000a6597          	auipc	a1,0xa6
ffffffffc02042b4:	3e85b583          	ld	a1,1000(a1) # ffffffffc02aa698 <boot_pgdir_va>
ffffffffc02042b8:	9a36                	add	s4,s4,a3
ffffffffc02042ba:	8552                	mv	a0,s4
ffffffffc02042bc:	7f9000ef          	jal	ra,ffffffffc02052b4 <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc02042c0:	038b8b13          	addi	s6,s7,56
    mm->pgdir = pgdir;
ffffffffc02042c4:	014c3c23          	sd	s4,24(s8)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02042c8:	4785                	li	a5,1
ffffffffc02042ca:	40fb37af          	amoor.d	a5,a5,(s6)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc02042ce:	8b85                	andi	a5,a5,1
ffffffffc02042d0:	4a05                	li	s4,1
ffffffffc02042d2:	c799                	beqz	a5,ffffffffc02042e0 <do_fork+0x2ac>
    {
        schedule();
ffffffffc02042d4:	5c1000ef          	jal	ra,ffffffffc0205094 <schedule>
ffffffffc02042d8:	414b37af          	amoor.d	a5,s4,(s6)
    while (!try_lock(lock))
ffffffffc02042dc:	8b85                	andi	a5,a5,1
ffffffffc02042de:	fbfd                	bnez	a5,ffffffffc02042d4 <do_fork+0x2a0>
        ret = dup_mmap(mm, oldmm);
ffffffffc02042e0:	85de                	mv	a1,s7
ffffffffc02042e2:	8562                	mv	a0,s8
ffffffffc02042e4:	f81fc0ef          	jal	ra,ffffffffc0201264 <dup_mmap>
ffffffffc02042e8:	8a2a                	mv	s4,a0
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc02042ea:	57f9                	li	a5,-2
ffffffffc02042ec:	60fb37af          	amoand.d	a5,a5,(s6)
ffffffffc02042f0:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc02042f2:	c3c5                	beqz	a5,ffffffffc0204392 <do_fork+0x35e>
good_mm:
ffffffffc02042f4:	8be2                	mv	s7,s8
    if (ret != 0)
ffffffffc02042f6:	de050ce3          	beqz	a0,ffffffffc02040ee <do_fork+0xba>
    exit_mmap(mm);
ffffffffc02042fa:	8562                	mv	a0,s8
ffffffffc02042fc:	802fd0ef          	jal	ra,ffffffffc02012fe <exit_mmap>
    put_pgdir(mm);
ffffffffc0204300:	8562                	mv	a0,s8
ffffffffc0204302:	c59ff0ef          	jal	ra,ffffffffc0203f5a <put_pgdir>
    mm_destroy(mm);
ffffffffc0204306:	8562                	mv	a0,s8
ffffffffc0204308:	e5bfc0ef          	jal	ra,ffffffffc0201162 <mm_destroy>
    if (ret != 0) { // 内存管理复制失败
ffffffffc020430c:	a039                	j	ffffffffc020431a <do_fork+0x2e6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc020430e:	8936                	mv	s2,a3
ffffffffc0204310:	bd35                	j	ffffffffc020414c <do_fork+0x118>
    mm_destroy(mm);
ffffffffc0204312:	8562                	mv	a0,s8
ffffffffc0204314:	e4ffc0ef          	jal	ra,ffffffffc0201162 <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0204318:	5a71                	li	s4,-4
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020431a:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc020431c:	c02007b7          	lui	a5,0xc0200
ffffffffc0204320:	0af6ee63          	bltu	a3,a5,ffffffffc02043dc <do_fork+0x3a8>
ffffffffc0204324:	000db703          	ld	a4,0(s11)
    if (PPN(pa) >= npage)
ffffffffc0204328:	000d3783          	ld	a5,0(s10)
    return pa2page(PADDR(kva));
ffffffffc020432c:	8e99                	sub	a3,a3,a4
    if (PPN(pa) >= npage)
ffffffffc020432e:	82b1                	srli	a3,a3,0xc
ffffffffc0204330:	08f6fa63          	bgeu	a3,a5,ffffffffc02043c4 <do_fork+0x390>
    return &pages[PPN(pa) - nbase];
ffffffffc0204334:	000ab783          	ld	a5,0(s5)
ffffffffc0204338:	000cb503          	ld	a0,0(s9)
ffffffffc020433c:	4589                	li	a1,2
ffffffffc020433e:	8e9d                	sub	a3,a3,a5
ffffffffc0204340:	069a                	slli	a3,a3,0x6
ffffffffc0204342:	9536                	add	a0,a0,a3
ffffffffc0204344:	ae4fe0ef          	jal	ra,ffffffffc0202628 <free_pages>
    kfree(proc);
ffffffffc0204348:	8522                	mv	a0,s0
ffffffffc020434a:	ec4fd0ef          	jal	ra,ffffffffc0201a0e <kfree>
    return ret;
ffffffffc020434e:	b545                	j	ffffffffc02041ee <do_fork+0x1ba>
                    if (last_pid >= MAX_PID)
ffffffffc0204350:	01d6c363          	blt	a3,t4,ffffffffc0204356 <do_fork+0x322>
                        last_pid = 1;
ffffffffc0204354:	4685                	li	a3,1
                    goto repeat;
ffffffffc0204356:	4585                	li	a1,1
ffffffffc0204358:	bdf9                	j	ffffffffc0204236 <do_fork+0x202>
    return -E_NO_MEM;
ffffffffc020435a:	5a71                	li	s4,-4
ffffffffc020435c:	b7f5                	j	ffffffffc0204348 <do_fork+0x314>
    int ret = -E_NO_FREE_PROC;
ffffffffc020435e:	5a6d                	li	s4,-5
ffffffffc0204360:	b579                	j	ffffffffc02041ee <do_fork+0x1ba>
ffffffffc0204362:	c599                	beqz	a1,ffffffffc0204370 <do_fork+0x33c>
ffffffffc0204364:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc0204368:	8536                	mv	a0,a3
ffffffffc020436a:	b515                	j	ffffffffc020418e <do_fork+0x15a>
    ret = -E_NO_MEM;
ffffffffc020436c:	5a71                	li	s4,-4
ffffffffc020436e:	b541                	j	ffffffffc02041ee <do_fork+0x1ba>
    return last_pid;
ffffffffc0204370:	00082503          	lw	a0,0(a6)
ffffffffc0204374:	bd29                	j	ffffffffc020418e <do_fork+0x15a>
    int ret = -E_NO_MEM;
ffffffffc0204376:	5a71                	li	s4,-4
ffffffffc0204378:	b74d                	j	ffffffffc020431a <do_fork+0x2e6>
    return KADDR(page2pa(page));
ffffffffc020437a:	00002617          	auipc	a2,0x2
ffffffffc020437e:	06e60613          	addi	a2,a2,110 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0204382:	07100593          	li	a1,113
ffffffffc0204386:	00002517          	auipc	a0,0x2
ffffffffc020438a:	08a50513          	addi	a0,a0,138 # ffffffffc0206410 <commands+0xa98>
ffffffffc020438e:	e91fb0ef          	jal	ra,ffffffffc020021e <__panic>
    {
        panic("Unlock failed.\n");
ffffffffc0204392:	00003617          	auipc	a2,0x3
ffffffffc0204396:	c0660613          	addi	a2,a2,-1018 # ffffffffc0206f98 <default_pmm_manager+0x718>
ffffffffc020439a:	03f00593          	li	a1,63
ffffffffc020439e:	00003517          	auipc	a0,0x3
ffffffffc02043a2:	c0a50513          	addi	a0,a0,-1014 # ffffffffc0206fa8 <default_pmm_manager+0x728>
ffffffffc02043a6:	e79fb0ef          	jal	ra,ffffffffc020021e <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc02043aa:	86be                	mv	a3,a5
ffffffffc02043ac:	00002617          	auipc	a2,0x2
ffffffffc02043b0:	0e460613          	addi	a2,a2,228 # ffffffffc0206490 <commands+0xb18>
ffffffffc02043b4:	19800593          	li	a1,408
ffffffffc02043b8:	00003517          	auipc	a0,0x3
ffffffffc02043bc:	bc850513          	addi	a0,a0,-1080 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc02043c0:	e5ffb0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02043c4:	00002617          	auipc	a2,0x2
ffffffffc02043c8:	0f460613          	addi	a2,a2,244 # ffffffffc02064b8 <commands+0xb40>
ffffffffc02043cc:	06900593          	li	a1,105
ffffffffc02043d0:	00002517          	auipc	a0,0x2
ffffffffc02043d4:	04050513          	addi	a0,a0,64 # ffffffffc0206410 <commands+0xa98>
ffffffffc02043d8:	e47fb0ef          	jal	ra,ffffffffc020021e <__panic>
    return pa2page(PADDR(kva));
ffffffffc02043dc:	00002617          	auipc	a2,0x2
ffffffffc02043e0:	0b460613          	addi	a2,a2,180 # ffffffffc0206490 <commands+0xb18>
ffffffffc02043e4:	07700593          	li	a1,119
ffffffffc02043e8:	00002517          	auipc	a0,0x2
ffffffffc02043ec:	02850513          	addi	a0,a0,40 # ffffffffc0206410 <commands+0xa98>
ffffffffc02043f0:	e2ffb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc02043f4 <kernel_thread>:
{
ffffffffc02043f4:	7129                	addi	sp,sp,-320
ffffffffc02043f6:	fa22                	sd	s0,304(sp)
ffffffffc02043f8:	f626                	sd	s1,296(sp)
ffffffffc02043fa:	f24a                	sd	s2,288(sp)
ffffffffc02043fc:	84ae                	mv	s1,a1
ffffffffc02043fe:	892a                	mv	s2,a0
ffffffffc0204400:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204402:	4581                	li	a1,0
ffffffffc0204404:	12000613          	li	a2,288
ffffffffc0204408:	850a                	mv	a0,sp
{
ffffffffc020440a:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020440c:	697000ef          	jal	ra,ffffffffc02052a2 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0204410:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc0204412:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc0204414:	100027f3          	csrr	a5,sstatus
ffffffffc0204418:	edd7f793          	andi	a5,a5,-291
ffffffffc020441c:	1207e793          	ori	a5,a5,288
ffffffffc0204420:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204422:	860a                	mv	a2,sp
ffffffffc0204424:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204428:	00000797          	auipc	a5,0x0
ffffffffc020442c:	9c278793          	addi	a5,a5,-1598 # ffffffffc0203dea <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204430:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204432:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204434:	c01ff0ef          	jal	ra,ffffffffc0204034 <do_fork>
}
ffffffffc0204438:	70f2                	ld	ra,312(sp)
ffffffffc020443a:	7452                	ld	s0,304(sp)
ffffffffc020443c:	74b2                	ld	s1,296(sp)
ffffffffc020443e:	7912                	ld	s2,288(sp)
ffffffffc0204440:	6131                	addi	sp,sp,320
ffffffffc0204442:	8082                	ret

ffffffffc0204444 <do_exit>:
{
ffffffffc0204444:	7179                	addi	sp,sp,-48
ffffffffc0204446:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc0204448:	000a6417          	auipc	s0,0xa6
ffffffffc020444c:	27840413          	addi	s0,s0,632 # ffffffffc02aa6c0 <current>
ffffffffc0204450:	601c                	ld	a5,0(s0)
{
ffffffffc0204452:	f406                	sd	ra,40(sp)
ffffffffc0204454:	ec26                	sd	s1,24(sp)
ffffffffc0204456:	e84a                	sd	s2,16(sp)
ffffffffc0204458:	e44e                	sd	s3,8(sp)
ffffffffc020445a:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc020445c:	000a6717          	auipc	a4,0xa6
ffffffffc0204460:	26c73703          	ld	a4,620(a4) # ffffffffc02aa6c8 <idleproc>
ffffffffc0204464:	0ce78c63          	beq	a5,a4,ffffffffc020453c <do_exit+0xf8>
    if (current == initproc)
ffffffffc0204468:	000a6497          	auipc	s1,0xa6
ffffffffc020446c:	26848493          	addi	s1,s1,616 # ffffffffc02aa6d0 <initproc>
ffffffffc0204470:	6098                	ld	a4,0(s1)
ffffffffc0204472:	0ee78b63          	beq	a5,a4,ffffffffc0204568 <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc0204476:	0287b983          	ld	s3,40(a5)
ffffffffc020447a:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc020447c:	02098663          	beqz	s3,ffffffffc02044a8 <do_exit+0x64>
ffffffffc0204480:	000a6797          	auipc	a5,0xa6
ffffffffc0204484:	2107b783          	ld	a5,528(a5) # ffffffffc02aa690 <boot_pgdir_pa>
ffffffffc0204488:	577d                	li	a4,-1
ffffffffc020448a:	177e                	slli	a4,a4,0x3f
ffffffffc020448c:	83b1                	srli	a5,a5,0xc
ffffffffc020448e:	8fd9                	or	a5,a5,a4
ffffffffc0204490:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0204494:	0309a783          	lw	a5,48(s3)
ffffffffc0204498:	fff7871b          	addiw	a4,a5,-1
ffffffffc020449c:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc02044a0:	cb55                	beqz	a4,ffffffffc0204554 <do_exit+0x110>
        current->mm = NULL;
ffffffffc02044a2:	601c                	ld	a5,0(s0)
ffffffffc02044a4:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc02044a8:	601c                	ld	a5,0(s0)
ffffffffc02044aa:	470d                	li	a4,3
ffffffffc02044ac:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc02044ae:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02044b2:	100027f3          	csrr	a5,sstatus
ffffffffc02044b6:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044b8:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02044ba:	e3f9                	bnez	a5,ffffffffc0204580 <do_exit+0x13c>
        proc = current->parent;
ffffffffc02044bc:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc02044be:	800007b7          	lui	a5,0x80000
ffffffffc02044c2:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc02044c4:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc02044c6:	0ec52703          	lw	a4,236(a0)
ffffffffc02044ca:	0af70f63          	beq	a4,a5,ffffffffc0204588 <do_exit+0x144>
        while (current->cptr != NULL)
ffffffffc02044ce:	6018                	ld	a4,0(s0)
ffffffffc02044d0:	7b7c                	ld	a5,240(a4)
ffffffffc02044d2:	c3a1                	beqz	a5,ffffffffc0204512 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD)
ffffffffc02044d4:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044d8:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc02044da:	0985                	addi	s3,s3,1
ffffffffc02044dc:	a021                	j	ffffffffc02044e4 <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc02044de:	6018                	ld	a4,0(s0)
ffffffffc02044e0:	7b7c                	ld	a5,240(a4)
ffffffffc02044e2:	cb85                	beqz	a5,ffffffffc0204512 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc02044e4:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_exit_out_size+0xffffffff7fff4fe8>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02044e8:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc02044ea:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02044ec:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc02044ee:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc02044f2:	10e7b023          	sd	a4,256(a5)
ffffffffc02044f6:	c311                	beqz	a4,ffffffffc02044fa <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc02044f8:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044fa:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc02044fc:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc02044fe:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204500:	fd271fe3          	bne	a4,s2,ffffffffc02044de <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204504:	0ec52783          	lw	a5,236(a0)
ffffffffc0204508:	fd379be3          	bne	a5,s3,ffffffffc02044de <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc020450c:	309000ef          	jal	ra,ffffffffc0205014 <wakeup_proc>
ffffffffc0204510:	b7f9                	j	ffffffffc02044de <do_exit+0x9a>
    if (flag)
ffffffffc0204512:	020a1263          	bnez	s4,ffffffffc0204536 <do_exit+0xf2>
    schedule();
ffffffffc0204516:	37f000ef          	jal	ra,ffffffffc0205094 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc020451a:	601c                	ld	a5,0(s0)
ffffffffc020451c:	00003617          	auipc	a2,0x3
ffffffffc0204520:	ac460613          	addi	a2,a2,-1340 # ffffffffc0206fe0 <default_pmm_manager+0x760>
ffffffffc0204524:	24d00593          	li	a1,589
ffffffffc0204528:	43d4                	lw	a3,4(a5)
ffffffffc020452a:	00003517          	auipc	a0,0x3
ffffffffc020452e:	a5650513          	addi	a0,a0,-1450 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204532:	cedfb0ef          	jal	ra,ffffffffc020021e <__panic>
        intr_enable();
ffffffffc0204536:	c7efc0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc020453a:	bff1                	j	ffffffffc0204516 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc020453c:	00003617          	auipc	a2,0x3
ffffffffc0204540:	a8460613          	addi	a2,a2,-1404 # ffffffffc0206fc0 <default_pmm_manager+0x740>
ffffffffc0204544:	21900593          	li	a1,537
ffffffffc0204548:	00003517          	auipc	a0,0x3
ffffffffc020454c:	a3850513          	addi	a0,a0,-1480 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204550:	ccffb0ef          	jal	ra,ffffffffc020021e <__panic>
            exit_mmap(mm);
ffffffffc0204554:	854e                	mv	a0,s3
ffffffffc0204556:	da9fc0ef          	jal	ra,ffffffffc02012fe <exit_mmap>
            put_pgdir(mm);
ffffffffc020455a:	854e                	mv	a0,s3
ffffffffc020455c:	9ffff0ef          	jal	ra,ffffffffc0203f5a <put_pgdir>
            mm_destroy(mm);
ffffffffc0204560:	854e                	mv	a0,s3
ffffffffc0204562:	c01fc0ef          	jal	ra,ffffffffc0201162 <mm_destroy>
ffffffffc0204566:	bf35                	j	ffffffffc02044a2 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0204568:	00003617          	auipc	a2,0x3
ffffffffc020456c:	a6860613          	addi	a2,a2,-1432 # ffffffffc0206fd0 <default_pmm_manager+0x750>
ffffffffc0204570:	21d00593          	li	a1,541
ffffffffc0204574:	00003517          	auipc	a0,0x3
ffffffffc0204578:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc020457c:	ca3fb0ef          	jal	ra,ffffffffc020021e <__panic>
        intr_disable();
ffffffffc0204580:	c3afc0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        return 1;
ffffffffc0204584:	4a05                	li	s4,1
ffffffffc0204586:	bf1d                	j	ffffffffc02044bc <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0204588:	28d000ef          	jal	ra,ffffffffc0205014 <wakeup_proc>
ffffffffc020458c:	b789                	j	ffffffffc02044ce <do_exit+0x8a>

ffffffffc020458e <do_wait.part.0>:
int do_wait(int pid, int *code_store)
ffffffffc020458e:	715d                	addi	sp,sp,-80
ffffffffc0204590:	f84a                	sd	s2,48(sp)
ffffffffc0204592:	f44e                	sd	s3,40(sp)
        current->wait_state = WT_CHILD;
ffffffffc0204594:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc0204598:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc020459a:	fc26                	sd	s1,56(sp)
ffffffffc020459c:	f052                	sd	s4,32(sp)
ffffffffc020459e:	ec56                	sd	s5,24(sp)
ffffffffc02045a0:	e85a                	sd	s6,16(sp)
ffffffffc02045a2:	e45e                	sd	s7,8(sp)
ffffffffc02045a4:	e486                	sd	ra,72(sp)
ffffffffc02045a6:	e0a2                	sd	s0,64(sp)
ffffffffc02045a8:	84aa                	mv	s1,a0
ffffffffc02045aa:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc02045ac:	000a6b97          	auipc	s7,0xa6
ffffffffc02045b0:	114b8b93          	addi	s7,s7,276 # ffffffffc02aa6c0 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc02045b4:	00050b1b          	sext.w	s6,a0
ffffffffc02045b8:	fff50a9b          	addiw	s5,a0,-1
ffffffffc02045bc:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc02045be:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc02045c0:	ccbd                	beqz	s1,ffffffffc020463e <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc02045c2:	0359e863          	bltu	s3,s5,ffffffffc02045f2 <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc02045c6:	45a9                	li	a1,10
ffffffffc02045c8:	855a                	mv	a0,s6
ffffffffc02045ca:	0f0010ef          	jal	ra,ffffffffc02056ba <hash32>
ffffffffc02045ce:	02051793          	slli	a5,a0,0x20
ffffffffc02045d2:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02045d6:	000a2797          	auipc	a5,0xa2
ffffffffc02045da:	07278793          	addi	a5,a5,114 # ffffffffc02a6648 <hash_list>
ffffffffc02045de:	953e                	add	a0,a0,a5
ffffffffc02045e0:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc02045e2:	a029                	j	ffffffffc02045ec <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc02045e4:	f2c42783          	lw	a5,-212(s0)
ffffffffc02045e8:	02978163          	beq	a5,s1,ffffffffc020460a <do_wait.part.0+0x7c>
ffffffffc02045ec:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc02045ee:	fe851be3          	bne	a0,s0,ffffffffc02045e4 <do_wait.part.0+0x56>
    return -E_BAD_PROC;
ffffffffc02045f2:	5579                	li	a0,-2
}
ffffffffc02045f4:	60a6                	ld	ra,72(sp)
ffffffffc02045f6:	6406                	ld	s0,64(sp)
ffffffffc02045f8:	74e2                	ld	s1,56(sp)
ffffffffc02045fa:	7942                	ld	s2,48(sp)
ffffffffc02045fc:	79a2                	ld	s3,40(sp)
ffffffffc02045fe:	7a02                	ld	s4,32(sp)
ffffffffc0204600:	6ae2                	ld	s5,24(sp)
ffffffffc0204602:	6b42                	ld	s6,16(sp)
ffffffffc0204604:	6ba2                	ld	s7,8(sp)
ffffffffc0204606:	6161                	addi	sp,sp,80
ffffffffc0204608:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc020460a:	000bb683          	ld	a3,0(s7)
ffffffffc020460e:	f4843783          	ld	a5,-184(s0)
ffffffffc0204612:	fed790e3          	bne	a5,a3,ffffffffc02045f2 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204616:	f2842703          	lw	a4,-216(s0)
ffffffffc020461a:	478d                	li	a5,3
ffffffffc020461c:	0ef70b63          	beq	a4,a5,ffffffffc0204712 <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc0204620:	4785                	li	a5,1
ffffffffc0204622:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc0204624:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc0204628:	26d000ef          	jal	ra,ffffffffc0205094 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc020462c:	000bb783          	ld	a5,0(s7)
ffffffffc0204630:	0b07a783          	lw	a5,176(a5)
ffffffffc0204634:	8b85                	andi	a5,a5,1
ffffffffc0204636:	d7c9                	beqz	a5,ffffffffc02045c0 <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc0204638:	555d                	li	a0,-9
ffffffffc020463a:	e0bff0ef          	jal	ra,ffffffffc0204444 <do_exit>
        proc = current->cptr;
ffffffffc020463e:	000bb683          	ld	a3,0(s7)
ffffffffc0204642:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc0204644:	d45d                	beqz	s0,ffffffffc02045f2 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204646:	470d                	li	a4,3
ffffffffc0204648:	a021                	j	ffffffffc0204650 <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc020464a:	10043403          	ld	s0,256(s0)
ffffffffc020464e:	d869                	beqz	s0,ffffffffc0204620 <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204650:	401c                	lw	a5,0(s0)
ffffffffc0204652:	fee79ce3          	bne	a5,a4,ffffffffc020464a <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc0204656:	000a6797          	auipc	a5,0xa6
ffffffffc020465a:	0727b783          	ld	a5,114(a5) # ffffffffc02aa6c8 <idleproc>
ffffffffc020465e:	0c878963          	beq	a5,s0,ffffffffc0204730 <do_wait.part.0+0x1a2>
ffffffffc0204662:	000a6797          	auipc	a5,0xa6
ffffffffc0204666:	06e7b783          	ld	a5,110(a5) # ffffffffc02aa6d0 <initproc>
ffffffffc020466a:	0cf40363          	beq	s0,a5,ffffffffc0204730 <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc020466e:	000a0663          	beqz	s4,ffffffffc020467a <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc0204672:	0e842783          	lw	a5,232(s0)
ffffffffc0204676:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8ba8>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020467a:	100027f3          	csrr	a5,sstatus
ffffffffc020467e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204680:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204682:	e7c1                	bnez	a5,ffffffffc020470a <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc0204684:	6c70                	ld	a2,216(s0)
ffffffffc0204686:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc0204688:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc020468c:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc020468e:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204690:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0204692:	6470                	ld	a2,200(s0)
ffffffffc0204694:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0204696:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204698:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc020469a:	c319                	beqz	a4,ffffffffc02046a0 <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc020469c:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc020469e:	7c7c                	ld	a5,248(s0)
ffffffffc02046a0:	c3b5                	beqz	a5,ffffffffc0204704 <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc02046a2:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc02046a6:	000a6717          	auipc	a4,0xa6
ffffffffc02046aa:	03270713          	addi	a4,a4,50 # ffffffffc02aa6d8 <nr_process>
ffffffffc02046ae:	431c                	lw	a5,0(a4)
ffffffffc02046b0:	37fd                	addiw	a5,a5,-1
ffffffffc02046b2:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc02046b4:	e5a9                	bnez	a1,ffffffffc02046fe <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc02046b6:	6814                	ld	a3,16(s0)
ffffffffc02046b8:	c02007b7          	lui	a5,0xc0200
ffffffffc02046bc:	04f6ee63          	bltu	a3,a5,ffffffffc0204718 <do_wait.part.0+0x18a>
ffffffffc02046c0:	000a6797          	auipc	a5,0xa6
ffffffffc02046c4:	ff87b783          	ld	a5,-8(a5) # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc02046c8:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc02046ca:	82b1                	srli	a3,a3,0xc
ffffffffc02046cc:	000a6797          	auipc	a5,0xa6
ffffffffc02046d0:	fd47b783          	ld	a5,-44(a5) # ffffffffc02aa6a0 <npage>
ffffffffc02046d4:	06f6fa63          	bgeu	a3,a5,ffffffffc0204748 <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc02046d8:	00003517          	auipc	a0,0x3
ffffffffc02046dc:	14053503          	ld	a0,320(a0) # ffffffffc0207818 <nbase>
ffffffffc02046e0:	8e89                	sub	a3,a3,a0
ffffffffc02046e2:	069a                	slli	a3,a3,0x6
ffffffffc02046e4:	000a6517          	auipc	a0,0xa6
ffffffffc02046e8:	fc453503          	ld	a0,-60(a0) # ffffffffc02aa6a8 <pages>
ffffffffc02046ec:	9536                	add	a0,a0,a3
ffffffffc02046ee:	4589                	li	a1,2
ffffffffc02046f0:	f39fd0ef          	jal	ra,ffffffffc0202628 <free_pages>
    kfree(proc);
ffffffffc02046f4:	8522                	mv	a0,s0
ffffffffc02046f6:	b18fd0ef          	jal	ra,ffffffffc0201a0e <kfree>
    return 0;
ffffffffc02046fa:	4501                	li	a0,0
ffffffffc02046fc:	bde5                	j	ffffffffc02045f4 <do_wait.part.0+0x66>
        intr_enable();
ffffffffc02046fe:	ab6fc0ef          	jal	ra,ffffffffc02009b4 <intr_enable>
ffffffffc0204702:	bf55                	j	ffffffffc02046b6 <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc0204704:	701c                	ld	a5,32(s0)
ffffffffc0204706:	fbf8                	sd	a4,240(a5)
ffffffffc0204708:	bf79                	j	ffffffffc02046a6 <do_wait.part.0+0x118>
        intr_disable();
ffffffffc020470a:	ab0fc0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        return 1;
ffffffffc020470e:	4585                	li	a1,1
ffffffffc0204710:	bf95                	j	ffffffffc0204684 <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204712:	f2840413          	addi	s0,s0,-216
ffffffffc0204716:	b781                	j	ffffffffc0204656 <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc0204718:	00002617          	auipc	a2,0x2
ffffffffc020471c:	d7860613          	addi	a2,a2,-648 # ffffffffc0206490 <commands+0xb18>
ffffffffc0204720:	07700593          	li	a1,119
ffffffffc0204724:	00002517          	auipc	a0,0x2
ffffffffc0204728:	cec50513          	addi	a0,a0,-788 # ffffffffc0206410 <commands+0xa98>
ffffffffc020472c:	af3fb0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc0204730:	00003617          	auipc	a2,0x3
ffffffffc0204734:	8d060613          	addi	a2,a2,-1840 # ffffffffc0207000 <default_pmm_manager+0x780>
ffffffffc0204738:	37100593          	li	a1,881
ffffffffc020473c:	00003517          	auipc	a0,0x3
ffffffffc0204740:	84450513          	addi	a0,a0,-1980 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204744:	adbfb0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0204748:	00002617          	auipc	a2,0x2
ffffffffc020474c:	d7060613          	addi	a2,a2,-656 # ffffffffc02064b8 <commands+0xb40>
ffffffffc0204750:	06900593          	li	a1,105
ffffffffc0204754:	00002517          	auipc	a0,0x2
ffffffffc0204758:	cbc50513          	addi	a0,a0,-836 # ffffffffc0206410 <commands+0xa98>
ffffffffc020475c:	ac3fb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0204760 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc0204760:	1141                	addi	sp,sp,-16
ffffffffc0204762:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0204764:	f05fd0ef          	jal	ra,ffffffffc0202668 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0204768:	9f2fd0ef          	jal	ra,ffffffffc020195a <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc020476c:	4601                	li	a2,0
ffffffffc020476e:	4581                	li	a1,0
ffffffffc0204770:	fffff517          	auipc	a0,0xfffff
ffffffffc0204774:	76c50513          	addi	a0,a0,1900 # ffffffffc0203edc <user_main>
ffffffffc0204778:	c7dff0ef          	jal	ra,ffffffffc02043f4 <kernel_thread>
    if (pid <= 0)
ffffffffc020477c:	00a04563          	bgtz	a0,ffffffffc0204786 <init_main+0x26>
ffffffffc0204780:	a071                	j	ffffffffc020480c <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc0204782:	113000ef          	jal	ra,ffffffffc0205094 <schedule>
    if (code_store != NULL)
ffffffffc0204786:	4581                	li	a1,0
ffffffffc0204788:	4501                	li	a0,0
ffffffffc020478a:	e05ff0ef          	jal	ra,ffffffffc020458e <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc020478e:	d975                	beqz	a0,ffffffffc0204782 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0204790:	00003517          	auipc	a0,0x3
ffffffffc0204794:	8b050513          	addi	a0,a0,-1872 # ffffffffc0207040 <default_pmm_manager+0x7c0>
ffffffffc0204798:	949fb0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc020479c:	000a6797          	auipc	a5,0xa6
ffffffffc02047a0:	f347b783          	ld	a5,-204(a5) # ffffffffc02aa6d0 <initproc>
ffffffffc02047a4:	7bf8                	ld	a4,240(a5)
ffffffffc02047a6:	e339                	bnez	a4,ffffffffc02047ec <init_main+0x8c>
ffffffffc02047a8:	7ff8                	ld	a4,248(a5)
ffffffffc02047aa:	e329                	bnez	a4,ffffffffc02047ec <init_main+0x8c>
ffffffffc02047ac:	1007b703          	ld	a4,256(a5)
ffffffffc02047b0:	ef15                	bnez	a4,ffffffffc02047ec <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc02047b2:	000a6697          	auipc	a3,0xa6
ffffffffc02047b6:	f266a683          	lw	a3,-218(a3) # ffffffffc02aa6d8 <nr_process>
ffffffffc02047ba:	4709                	li	a4,2
ffffffffc02047bc:	0ae69463          	bne	a3,a4,ffffffffc0204864 <init_main+0x104>
    return listelm->next;
ffffffffc02047c0:	000a6697          	auipc	a3,0xa6
ffffffffc02047c4:	e8868693          	addi	a3,a3,-376 # ffffffffc02aa648 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc02047c8:	6698                	ld	a4,8(a3)
ffffffffc02047ca:	0c878793          	addi	a5,a5,200
ffffffffc02047ce:	06f71b63          	bne	a4,a5,ffffffffc0204844 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc02047d2:	629c                	ld	a5,0(a3)
ffffffffc02047d4:	04f71863          	bne	a4,a5,ffffffffc0204824 <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc02047d8:	00003517          	auipc	a0,0x3
ffffffffc02047dc:	95050513          	addi	a0,a0,-1712 # ffffffffc0207128 <default_pmm_manager+0x8a8>
ffffffffc02047e0:	901fb0ef          	jal	ra,ffffffffc02000e0 <cprintf>
    return 0;
}
ffffffffc02047e4:	60a2                	ld	ra,8(sp)
ffffffffc02047e6:	4501                	li	a0,0
ffffffffc02047e8:	0141                	addi	sp,sp,16
ffffffffc02047ea:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc02047ec:	00003697          	auipc	a3,0x3
ffffffffc02047f0:	87c68693          	addi	a3,a3,-1924 # ffffffffc0207068 <default_pmm_manager+0x7e8>
ffffffffc02047f4:	00002617          	auipc	a2,0x2
ffffffffc02047f8:	97c60613          	addi	a2,a2,-1668 # ffffffffc0206170 <commands+0x7f8>
ffffffffc02047fc:	3df00593          	li	a1,991
ffffffffc0204800:	00002517          	auipc	a0,0x2
ffffffffc0204804:	78050513          	addi	a0,a0,1920 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204808:	a17fb0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("create user_main failed.\n");
ffffffffc020480c:	00003617          	auipc	a2,0x3
ffffffffc0204810:	81460613          	addi	a2,a2,-2028 # ffffffffc0207020 <default_pmm_manager+0x7a0>
ffffffffc0204814:	3d600593          	li	a1,982
ffffffffc0204818:	00002517          	auipc	a0,0x2
ffffffffc020481c:	76850513          	addi	a0,a0,1896 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204820:	9fffb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204824:	00003697          	auipc	a3,0x3
ffffffffc0204828:	8d468693          	addi	a3,a3,-1836 # ffffffffc02070f8 <default_pmm_manager+0x878>
ffffffffc020482c:	00002617          	auipc	a2,0x2
ffffffffc0204830:	94460613          	addi	a2,a2,-1724 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204834:	3e200593          	li	a1,994
ffffffffc0204838:	00002517          	auipc	a0,0x2
ffffffffc020483c:	74850513          	addi	a0,a0,1864 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204840:	9dffb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204844:	00003697          	auipc	a3,0x3
ffffffffc0204848:	88468693          	addi	a3,a3,-1916 # ffffffffc02070c8 <default_pmm_manager+0x848>
ffffffffc020484c:	00002617          	auipc	a2,0x2
ffffffffc0204850:	92460613          	addi	a2,a2,-1756 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204854:	3e100593          	li	a1,993
ffffffffc0204858:	00002517          	auipc	a0,0x2
ffffffffc020485c:	72850513          	addi	a0,a0,1832 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204860:	9bffb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(nr_process == 2);
ffffffffc0204864:	00003697          	auipc	a3,0x3
ffffffffc0204868:	85468693          	addi	a3,a3,-1964 # ffffffffc02070b8 <default_pmm_manager+0x838>
ffffffffc020486c:	00002617          	auipc	a2,0x2
ffffffffc0204870:	90460613          	addi	a2,a2,-1788 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204874:	3e000593          	li	a1,992
ffffffffc0204878:	00002517          	auipc	a0,0x2
ffffffffc020487c:	70850513          	addi	a0,a0,1800 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204880:	99ffb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0204884 <do_execve>:
{
ffffffffc0204884:	7171                	addi	sp,sp,-176
ffffffffc0204886:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204888:	000a6d97          	auipc	s11,0xa6
ffffffffc020488c:	e38d8d93          	addi	s11,s11,-456 # ffffffffc02aa6c0 <current>
ffffffffc0204890:	000db783          	ld	a5,0(s11)
{
ffffffffc0204894:	e94a                	sd	s2,144(sp)
ffffffffc0204896:	f122                	sd	s0,160(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204898:	0287b903          	ld	s2,40(a5)
{
ffffffffc020489c:	ed26                	sd	s1,152(sp)
ffffffffc020489e:	f8da                	sd	s6,112(sp)
ffffffffc02048a0:	84aa                	mv	s1,a0
ffffffffc02048a2:	8b32                	mv	s6,a2
ffffffffc02048a4:	842e                	mv	s0,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc02048a6:	862e                	mv	a2,a1
ffffffffc02048a8:	4681                	li	a3,0
ffffffffc02048aa:	85aa                	mv	a1,a0
ffffffffc02048ac:	854a                	mv	a0,s2
{
ffffffffc02048ae:	f506                	sd	ra,168(sp)
ffffffffc02048b0:	e54e                	sd	s3,136(sp)
ffffffffc02048b2:	e152                	sd	s4,128(sp)
ffffffffc02048b4:	fcd6                	sd	s5,120(sp)
ffffffffc02048b6:	f4de                	sd	s7,104(sp)
ffffffffc02048b8:	f0e2                	sd	s8,96(sp)
ffffffffc02048ba:	ece6                	sd	s9,88(sp)
ffffffffc02048bc:	e8ea                	sd	s10,80(sp)
ffffffffc02048be:	f05a                	sd	s6,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc02048c0:	dd9fc0ef          	jal	ra,ffffffffc0201698 <user_mem_check>
ffffffffc02048c4:	40050a63          	beqz	a0,ffffffffc0204cd8 <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc02048c8:	4641                	li	a2,16
ffffffffc02048ca:	4581                	li	a1,0
ffffffffc02048cc:	1808                	addi	a0,sp,48
ffffffffc02048ce:	1d5000ef          	jal	ra,ffffffffc02052a2 <memset>
    memcpy(local_name, name, len);
ffffffffc02048d2:	47bd                	li	a5,15
ffffffffc02048d4:	8622                	mv	a2,s0
ffffffffc02048d6:	1e87e263          	bltu	a5,s0,ffffffffc0204aba <do_execve+0x236>
ffffffffc02048da:	85a6                	mv	a1,s1
ffffffffc02048dc:	1808                	addi	a0,sp,48
ffffffffc02048de:	1d7000ef          	jal	ra,ffffffffc02052b4 <memcpy>
    if (mm != NULL)
ffffffffc02048e2:	1e090363          	beqz	s2,ffffffffc0204ac8 <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc02048e6:	00002517          	auipc	a0,0x2
ffffffffc02048ea:	92a50513          	addi	a0,a0,-1750 # ffffffffc0206210 <commands+0x898>
ffffffffc02048ee:	82dfb0ef          	jal	ra,ffffffffc020011a <cputs>
ffffffffc02048f2:	000a6797          	auipc	a5,0xa6
ffffffffc02048f6:	d9e7b783          	ld	a5,-610(a5) # ffffffffc02aa690 <boot_pgdir_pa>
ffffffffc02048fa:	577d                	li	a4,-1
ffffffffc02048fc:	177e                	slli	a4,a4,0x3f
ffffffffc02048fe:	83b1                	srli	a5,a5,0xc
ffffffffc0204900:	8fd9                	or	a5,a5,a4
ffffffffc0204902:	18079073          	csrw	satp,a5
ffffffffc0204906:	03092783          	lw	a5,48(s2) # ffffffff80000030 <_binary_obj___user_exit_out_size+0xffffffff7fff4f18>
ffffffffc020490a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020490e:	02e92823          	sw	a4,48(s2)
        if (mm_count_dec(mm) == 0)
ffffffffc0204912:	2c070463          	beqz	a4,ffffffffc0204bda <do_execve+0x356>
        current->mm = NULL;
ffffffffc0204916:	000db783          	ld	a5,0(s11)
ffffffffc020491a:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc020491e:	f04fc0ef          	jal	ra,ffffffffc0201022 <mm_create>
ffffffffc0204922:	842a                	mv	s0,a0
ffffffffc0204924:	1c050d63          	beqz	a0,ffffffffc0204afe <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc0204928:	4505                	li	a0,1
ffffffffc020492a:	cc1fd0ef          	jal	ra,ffffffffc02025ea <alloc_pages>
ffffffffc020492e:	3a050963          	beqz	a0,ffffffffc0204ce0 <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc0204932:	000a6c97          	auipc	s9,0xa6
ffffffffc0204936:	d76c8c93          	addi	s9,s9,-650 # ffffffffc02aa6a8 <pages>
ffffffffc020493a:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc020493e:	000a6c17          	auipc	s8,0xa6
ffffffffc0204942:	d62c0c13          	addi	s8,s8,-670 # ffffffffc02aa6a0 <npage>
    return page - pages + nbase;
ffffffffc0204946:	00003717          	auipc	a4,0x3
ffffffffc020494a:	ed273703          	ld	a4,-302(a4) # ffffffffc0207818 <nbase>
ffffffffc020494e:	40d506b3          	sub	a3,a0,a3
ffffffffc0204952:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204954:	5a7d                	li	s4,-1
ffffffffc0204956:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc020495a:	96ba                	add	a3,a3,a4
ffffffffc020495c:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc020495e:	00ca5713          	srli	a4,s4,0xc
ffffffffc0204962:	ec3a                	sd	a4,24(sp)
ffffffffc0204964:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0204966:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204968:	38f77063          	bgeu	a4,a5,ffffffffc0204ce8 <do_execve+0x464>
ffffffffc020496c:	000a6a97          	auipc	s5,0xa6
ffffffffc0204970:	d4ca8a93          	addi	s5,s5,-692 # ffffffffc02aa6b8 <va_pa_offset>
ffffffffc0204974:	000ab483          	ld	s1,0(s5)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc0204978:	6605                	lui	a2,0x1
ffffffffc020497a:	000a6597          	auipc	a1,0xa6
ffffffffc020497e:	d1e5b583          	ld	a1,-738(a1) # ffffffffc02aa698 <boot_pgdir_va>
ffffffffc0204982:	94b6                	add	s1,s1,a3
ffffffffc0204984:	8526                	mv	a0,s1
ffffffffc0204986:	12f000ef          	jal	ra,ffffffffc02052b4 <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc020498a:	7782                	ld	a5,32(sp)
ffffffffc020498c:	4398                	lw	a4,0(a5)
ffffffffc020498e:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc0204992:	ec04                	sd	s1,24(s0)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc0204994:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_exit_out_size+0x464b9467>
ffffffffc0204998:	14f71963          	bne	a4,a5,ffffffffc0204aea <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020499c:	7682                	ld	a3,32(sp)
    struct Page *page = NULL;
ffffffffc020499e:	4b81                	li	s7,0
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc02049a0:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc02049a4:	0206b903          	ld	s2,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc02049a8:	00371793          	slli	a5,a4,0x3
ffffffffc02049ac:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc02049ae:	9936                	add	s2,s2,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc02049b0:	078e                	slli	a5,a5,0x3
ffffffffc02049b2:	97ca                	add	a5,a5,s2
ffffffffc02049b4:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc02049b6:	00f97c63          	bgeu	s2,a5,ffffffffc02049ce <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc02049ba:	00092783          	lw	a5,0(s2)
ffffffffc02049be:	4705                	li	a4,1
ffffffffc02049c0:	14e78163          	beq	a5,a4,ffffffffc0204b02 <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc02049c4:	77a2                	ld	a5,40(sp)
ffffffffc02049c6:	03890913          	addi	s2,s2,56
ffffffffc02049ca:	fef968e3          	bltu	s2,a5,ffffffffc02049ba <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc02049ce:	4701                	li	a4,0
ffffffffc02049d0:	46ad                	li	a3,11
ffffffffc02049d2:	00100637          	lui	a2,0x100
ffffffffc02049d6:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02049da:	8522                	mv	a0,s0
ffffffffc02049dc:	fd8fc0ef          	jal	ra,ffffffffc02011b4 <mm_map>
ffffffffc02049e0:	89aa                	mv	s3,a0
ffffffffc02049e2:	1e051263          	bnez	a0,ffffffffc0204bc6 <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc02049e6:	6c08                	ld	a0,24(s0)
ffffffffc02049e8:	467d                	li	a2,31
ffffffffc02049ea:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02049ee:	b3aff0ef          	jal	ra,ffffffffc0203d28 <pgdir_alloc_page>
ffffffffc02049f2:	38050363          	beqz	a0,ffffffffc0204d78 <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc02049f6:	6c08                	ld	a0,24(s0)
ffffffffc02049f8:	467d                	li	a2,31
ffffffffc02049fa:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02049fe:	b2aff0ef          	jal	ra,ffffffffc0203d28 <pgdir_alloc_page>
ffffffffc0204a02:	34050b63          	beqz	a0,ffffffffc0204d58 <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204a06:	6c08                	ld	a0,24(s0)
ffffffffc0204a08:	467d                	li	a2,31
ffffffffc0204a0a:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0204a0e:	b1aff0ef          	jal	ra,ffffffffc0203d28 <pgdir_alloc_page>
ffffffffc0204a12:	32050363          	beqz	a0,ffffffffc0204d38 <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204a16:	6c08                	ld	a0,24(s0)
ffffffffc0204a18:	467d                	li	a2,31
ffffffffc0204a1a:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0204a1e:	b0aff0ef          	jal	ra,ffffffffc0203d28 <pgdir_alloc_page>
ffffffffc0204a22:	2e050b63          	beqz	a0,ffffffffc0204d18 <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc0204a26:	581c                	lw	a5,48(s0)
    current->mm = mm;
ffffffffc0204a28:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204a2c:	6c14                	ld	a3,24(s0)
ffffffffc0204a2e:	2785                	addiw	a5,a5,1
ffffffffc0204a30:	d81c                	sw	a5,48(s0)
    current->mm = mm;
ffffffffc0204a32:	f600                	sd	s0,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204a34:	c02007b7          	lui	a5,0xc0200
ffffffffc0204a38:	2cf6e463          	bltu	a3,a5,ffffffffc0204d00 <do_execve+0x47c>
ffffffffc0204a3c:	000ab783          	ld	a5,0(s5)
ffffffffc0204a40:	577d                	li	a4,-1
ffffffffc0204a42:	177e                	slli	a4,a4,0x3f
ffffffffc0204a44:	8e9d                	sub	a3,a3,a5
ffffffffc0204a46:	00c6d793          	srli	a5,a3,0xc
ffffffffc0204a4a:	f654                	sd	a3,168(a2)
ffffffffc0204a4c:	8fd9                	or	a5,a5,a4
ffffffffc0204a4e:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0204a52:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0204a54:	4581                	li	a1,0
ffffffffc0204a56:	12000613          	li	a2,288
ffffffffc0204a5a:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0204a5c:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0204a60:	043000ef          	jal	ra,ffffffffc02052a2 <memset>
    tf->epc = elf->e_entry;
ffffffffc0204a64:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a66:	000db903          	ld	s2,0(s11)
    tf->status &= ~SSTATUS_SIE;
ffffffffc0204a6a:	edd4f493          	andi	s1,s1,-291
    tf->epc = elf->e_entry;
ffffffffc0204a6e:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc0204a70:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a72:	0b490913          	addi	s2,s2,180
    tf->gpr.sp = USTACKTOP;
ffffffffc0204a76:	07fe                	slli	a5,a5,0x1f
    tf->status &= ~SSTATUS_SIE;
ffffffffc0204a78:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a7c:	4641                	li	a2,16
ffffffffc0204a7e:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;
ffffffffc0204a80:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0204a82:	10e43423          	sd	a4,264(s0)
    tf->status &= ~SSTATUS_SIE;
ffffffffc0204a86:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a8a:	854a                	mv	a0,s2
ffffffffc0204a8c:	017000ef          	jal	ra,ffffffffc02052a2 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204a90:	463d                	li	a2,15
ffffffffc0204a92:	180c                	addi	a1,sp,48
ffffffffc0204a94:	854a                	mv	a0,s2
ffffffffc0204a96:	01f000ef          	jal	ra,ffffffffc02052b4 <memcpy>
}
ffffffffc0204a9a:	70aa                	ld	ra,168(sp)
ffffffffc0204a9c:	740a                	ld	s0,160(sp)
ffffffffc0204a9e:	64ea                	ld	s1,152(sp)
ffffffffc0204aa0:	694a                	ld	s2,144(sp)
ffffffffc0204aa2:	6a0a                	ld	s4,128(sp)
ffffffffc0204aa4:	7ae6                	ld	s5,120(sp)
ffffffffc0204aa6:	7b46                	ld	s6,112(sp)
ffffffffc0204aa8:	7ba6                	ld	s7,104(sp)
ffffffffc0204aaa:	7c06                	ld	s8,96(sp)
ffffffffc0204aac:	6ce6                	ld	s9,88(sp)
ffffffffc0204aae:	6d46                	ld	s10,80(sp)
ffffffffc0204ab0:	6da6                	ld	s11,72(sp)
ffffffffc0204ab2:	854e                	mv	a0,s3
ffffffffc0204ab4:	69aa                	ld	s3,136(sp)
ffffffffc0204ab6:	614d                	addi	sp,sp,176
ffffffffc0204ab8:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204aba:	463d                	li	a2,15
ffffffffc0204abc:	85a6                	mv	a1,s1
ffffffffc0204abe:	1808                	addi	a0,sp,48
ffffffffc0204ac0:	7f4000ef          	jal	ra,ffffffffc02052b4 <memcpy>
    if (mm != NULL)
ffffffffc0204ac4:	e20911e3          	bnez	s2,ffffffffc02048e6 <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204ac8:	000db783          	ld	a5,0(s11)
ffffffffc0204acc:	779c                	ld	a5,40(a5)
ffffffffc0204ace:	e40788e3          	beqz	a5,ffffffffc020491e <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0204ad2:	00002617          	auipc	a2,0x2
ffffffffc0204ad6:	67660613          	addi	a2,a2,1654 # ffffffffc0207148 <default_pmm_manager+0x8c8>
ffffffffc0204ada:	25900593          	li	a1,601
ffffffffc0204ade:	00002517          	auipc	a0,0x2
ffffffffc0204ae2:	4a250513          	addi	a0,a0,1186 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204ae6:	f38fb0ef          	jal	ra,ffffffffc020021e <__panic>
    put_pgdir(mm);
ffffffffc0204aea:	8522                	mv	a0,s0
ffffffffc0204aec:	c6eff0ef          	jal	ra,ffffffffc0203f5a <put_pgdir>
    mm_destroy(mm);
ffffffffc0204af0:	8522                	mv	a0,s0
ffffffffc0204af2:	e70fc0ef          	jal	ra,ffffffffc0201162 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204af6:	59e1                	li	s3,-8
    do_exit(ret);
ffffffffc0204af8:	854e                	mv	a0,s3
ffffffffc0204afa:	94bff0ef          	jal	ra,ffffffffc0204444 <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204afe:	59f1                	li	s3,-4
ffffffffc0204b00:	bfe5                	j	ffffffffc0204af8 <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc0204b02:	02893603          	ld	a2,40(s2)
ffffffffc0204b06:	02093783          	ld	a5,32(s2)
ffffffffc0204b0a:	1cf66d63          	bltu	a2,a5,ffffffffc0204ce4 <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204b0e:	00492783          	lw	a5,4(s2)
ffffffffc0204b12:	0017f693          	andi	a3,a5,1
ffffffffc0204b16:	c291                	beqz	a3,ffffffffc0204b1a <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204b18:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204b1a:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204b1e:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204b20:	e779                	bnez	a4,ffffffffc0204bee <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0204b22:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204b24:	c781                	beqz	a5,ffffffffc0204b2c <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204b26:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204b2a:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204b2c:	0026f793          	andi	a5,a3,2
ffffffffc0204b30:	e3f1                	bnez	a5,ffffffffc0204bf4 <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc0204b32:	0046f793          	andi	a5,a3,4
ffffffffc0204b36:	c399                	beqz	a5,ffffffffc0204b3c <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc0204b38:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc0204b3c:	01093583          	ld	a1,16(s2)
ffffffffc0204b40:	4701                	li	a4,0
ffffffffc0204b42:	8522                	mv	a0,s0
ffffffffc0204b44:	e70fc0ef          	jal	ra,ffffffffc02011b4 <mm_map>
ffffffffc0204b48:	89aa                	mv	s3,a0
ffffffffc0204b4a:	ed35                	bnez	a0,ffffffffc0204bc6 <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204b4c:	01093b03          	ld	s6,16(s2)
ffffffffc0204b50:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204b52:	02093983          	ld	s3,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204b56:	00893483          	ld	s1,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204b5a:	00fb7a33          	and	s4,s6,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204b5e:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204b60:	99da                	add	s3,s3,s6
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204b62:	94be                	add	s1,s1,a5
        while (start < end)
ffffffffc0204b64:	053b6963          	bltu	s6,s3,ffffffffc0204bb6 <do_execve+0x332>
ffffffffc0204b68:	aa95                	j	ffffffffc0204cdc <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204b6a:	6785                	lui	a5,0x1
ffffffffc0204b6c:	414b0533          	sub	a0,s6,s4
ffffffffc0204b70:	9a3e                	add	s4,s4,a5
ffffffffc0204b72:	416a0633          	sub	a2,s4,s6
            if (end < la)
ffffffffc0204b76:	0149f463          	bgeu	s3,s4,ffffffffc0204b7e <do_execve+0x2fa>
                size -= la - end;
ffffffffc0204b7a:	41698633          	sub	a2,s3,s6
    return page - pages + nbase;
ffffffffc0204b7e:	000cb683          	ld	a3,0(s9)
ffffffffc0204b82:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b84:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204b88:	40db86b3          	sub	a3,s7,a3
ffffffffc0204b8c:	8699                	srai	a3,a3,0x6
ffffffffc0204b8e:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b90:	67e2                	ld	a5,24(sp)
ffffffffc0204b92:	00f6f8b3          	and	a7,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b96:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b98:	14b8f863          	bgeu	a7,a1,ffffffffc0204ce8 <do_execve+0x464>
ffffffffc0204b9c:	000ab883          	ld	a7,0(s5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204ba0:	85a6                	mv	a1,s1
            start += size, from += size;
ffffffffc0204ba2:	9b32                	add	s6,s6,a2
ffffffffc0204ba4:	96c6                	add	a3,a3,a7
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204ba6:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204ba8:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204baa:	70a000ef          	jal	ra,ffffffffc02052b4 <memcpy>
            start += size, from += size;
ffffffffc0204bae:	6622                	ld	a2,8(sp)
ffffffffc0204bb0:	94b2                	add	s1,s1,a2
        while (start < end)
ffffffffc0204bb2:	053b7363          	bgeu	s6,s3,ffffffffc0204bf8 <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204bb6:	6c08                	ld	a0,24(s0)
ffffffffc0204bb8:	866a                	mv	a2,s10
ffffffffc0204bba:	85d2                	mv	a1,s4
ffffffffc0204bbc:	96cff0ef          	jal	ra,ffffffffc0203d28 <pgdir_alloc_page>
ffffffffc0204bc0:	8baa                	mv	s7,a0
ffffffffc0204bc2:	f545                	bnez	a0,ffffffffc0204b6a <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204bc4:	59f1                	li	s3,-4
    exit_mmap(mm);
ffffffffc0204bc6:	8522                	mv	a0,s0
ffffffffc0204bc8:	f36fc0ef          	jal	ra,ffffffffc02012fe <exit_mmap>
    put_pgdir(mm);
ffffffffc0204bcc:	8522                	mv	a0,s0
ffffffffc0204bce:	b8cff0ef          	jal	ra,ffffffffc0203f5a <put_pgdir>
    mm_destroy(mm);
ffffffffc0204bd2:	8522                	mv	a0,s0
ffffffffc0204bd4:	d8efc0ef          	jal	ra,ffffffffc0201162 <mm_destroy>
    return ret;
ffffffffc0204bd8:	b705                	j	ffffffffc0204af8 <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204bda:	854a                	mv	a0,s2
ffffffffc0204bdc:	f22fc0ef          	jal	ra,ffffffffc02012fe <exit_mmap>
            put_pgdir(mm);
ffffffffc0204be0:	854a                	mv	a0,s2
ffffffffc0204be2:	b78ff0ef          	jal	ra,ffffffffc0203f5a <put_pgdir>
            mm_destroy(mm);
ffffffffc0204be6:	854a                	mv	a0,s2
ffffffffc0204be8:	d7afc0ef          	jal	ra,ffffffffc0201162 <mm_destroy>
ffffffffc0204bec:	b32d                	j	ffffffffc0204916 <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204bee:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204bf2:	fb95                	bnez	a5,ffffffffc0204b26 <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204bf4:	4d5d                	li	s10,23
ffffffffc0204bf6:	bf35                	j	ffffffffc0204b32 <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204bf8:	01093483          	ld	s1,16(s2)
ffffffffc0204bfc:	02893683          	ld	a3,40(s2)
ffffffffc0204c00:	94b6                	add	s1,s1,a3
        if (start < la)
ffffffffc0204c02:	074b7d63          	bgeu	s6,s4,ffffffffc0204c7c <do_execve+0x3f8>
            if (start == end)
ffffffffc0204c06:	db648fe3          	beq	s1,s6,ffffffffc02049c4 <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204c0a:	6785                	lui	a5,0x1
ffffffffc0204c0c:	00fb0533          	add	a0,s6,a5
ffffffffc0204c10:	41450533          	sub	a0,a0,s4
                size -= la - end;
ffffffffc0204c14:	416489b3          	sub	s3,s1,s6
            if (end < la)
ffffffffc0204c18:	0b44fd63          	bgeu	s1,s4,ffffffffc0204cd2 <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204c1c:	000cb683          	ld	a3,0(s9)
ffffffffc0204c20:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204c22:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204c26:	40db86b3          	sub	a3,s7,a3
ffffffffc0204c2a:	8699                	srai	a3,a3,0x6
ffffffffc0204c2c:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c2e:	67e2                	ld	a5,24(sp)
ffffffffc0204c30:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c34:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c36:	0ac5f963          	bgeu	a1,a2,ffffffffc0204ce8 <do_execve+0x464>
ffffffffc0204c3a:	000ab883          	ld	a7,0(s5)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c3e:	864e                	mv	a2,s3
ffffffffc0204c40:	4581                	li	a1,0
ffffffffc0204c42:	96c6                	add	a3,a3,a7
ffffffffc0204c44:	9536                	add	a0,a0,a3
ffffffffc0204c46:	65c000ef          	jal	ra,ffffffffc02052a2 <memset>
            start += size;
ffffffffc0204c4a:	01698733          	add	a4,s3,s6
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204c4e:	0344f463          	bgeu	s1,s4,ffffffffc0204c76 <do_execve+0x3f2>
ffffffffc0204c52:	d6e489e3          	beq	s1,a4,ffffffffc02049c4 <do_execve+0x140>
ffffffffc0204c56:	00002697          	auipc	a3,0x2
ffffffffc0204c5a:	51a68693          	addi	a3,a3,1306 # ffffffffc0207170 <default_pmm_manager+0x8f0>
ffffffffc0204c5e:	00001617          	auipc	a2,0x1
ffffffffc0204c62:	51260613          	addi	a2,a2,1298 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204c66:	2c200593          	li	a1,706
ffffffffc0204c6a:	00002517          	auipc	a0,0x2
ffffffffc0204c6e:	31650513          	addi	a0,a0,790 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204c72:	dacfb0ef          	jal	ra,ffffffffc020021e <__panic>
ffffffffc0204c76:	ff4710e3          	bne	a4,s4,ffffffffc0204c56 <do_execve+0x3d2>
ffffffffc0204c7a:	8b52                	mv	s6,s4
        while (start < end)
ffffffffc0204c7c:	d49b74e3          	bgeu	s6,s1,ffffffffc02049c4 <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204c80:	6c08                	ld	a0,24(s0)
ffffffffc0204c82:	866a                	mv	a2,s10
ffffffffc0204c84:	85d2                	mv	a1,s4
ffffffffc0204c86:	8a2ff0ef          	jal	ra,ffffffffc0203d28 <pgdir_alloc_page>
ffffffffc0204c8a:	8baa                	mv	s7,a0
ffffffffc0204c8c:	dd05                	beqz	a0,ffffffffc0204bc4 <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204c8e:	6785                	lui	a5,0x1
ffffffffc0204c90:	414b0533          	sub	a0,s6,s4
ffffffffc0204c94:	9a3e                	add	s4,s4,a5
ffffffffc0204c96:	416a0633          	sub	a2,s4,s6
            if (end < la)
ffffffffc0204c9a:	0144f463          	bgeu	s1,s4,ffffffffc0204ca2 <do_execve+0x41e>
                size -= la - end;
ffffffffc0204c9e:	41648633          	sub	a2,s1,s6
    return page - pages + nbase;
ffffffffc0204ca2:	000cb683          	ld	a3,0(s9)
ffffffffc0204ca6:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204ca8:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204cac:	40db86b3          	sub	a3,s7,a3
ffffffffc0204cb0:	8699                	srai	a3,a3,0x6
ffffffffc0204cb2:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204cb4:	67e2                	ld	a5,24(sp)
ffffffffc0204cb6:	00f6f8b3          	and	a7,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204cba:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204cbc:	02b8f663          	bgeu	a7,a1,ffffffffc0204ce8 <do_execve+0x464>
ffffffffc0204cc0:	000ab883          	ld	a7,0(s5)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204cc4:	4581                	li	a1,0
            start += size;
ffffffffc0204cc6:	9b32                	add	s6,s6,a2
ffffffffc0204cc8:	96c6                	add	a3,a3,a7
            memset(page2kva(page) + off, 0, size);
ffffffffc0204cca:	9536                	add	a0,a0,a3
ffffffffc0204ccc:	5d6000ef          	jal	ra,ffffffffc02052a2 <memset>
ffffffffc0204cd0:	b775                	j	ffffffffc0204c7c <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204cd2:	416a09b3          	sub	s3,s4,s6
ffffffffc0204cd6:	b799                	j	ffffffffc0204c1c <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204cd8:	59f5                	li	s3,-3
ffffffffc0204cda:	b3c1                	j	ffffffffc0204a9a <do_execve+0x216>
        while (start < end)
ffffffffc0204cdc:	84da                	mv	s1,s6
ffffffffc0204cde:	bf39                	j	ffffffffc0204bfc <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204ce0:	59f1                	li	s3,-4
ffffffffc0204ce2:	bdc5                	j	ffffffffc0204bd2 <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204ce4:	59e1                	li	s3,-8
ffffffffc0204ce6:	b5c5                	j	ffffffffc0204bc6 <do_execve+0x342>
ffffffffc0204ce8:	00001617          	auipc	a2,0x1
ffffffffc0204cec:	70060613          	addi	a2,a2,1792 # ffffffffc02063e8 <commands+0xa70>
ffffffffc0204cf0:	07100593          	li	a1,113
ffffffffc0204cf4:	00001517          	auipc	a0,0x1
ffffffffc0204cf8:	71c50513          	addi	a0,a0,1820 # ffffffffc0206410 <commands+0xa98>
ffffffffc0204cfc:	d22fb0ef          	jal	ra,ffffffffc020021e <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204d00:	00001617          	auipc	a2,0x1
ffffffffc0204d04:	79060613          	addi	a2,a2,1936 # ffffffffc0206490 <commands+0xb18>
ffffffffc0204d08:	2e100593          	li	a1,737
ffffffffc0204d0c:	00002517          	auipc	a0,0x2
ffffffffc0204d10:	27450513          	addi	a0,a0,628 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204d14:	d0afb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204d18:	00002697          	auipc	a3,0x2
ffffffffc0204d1c:	57068693          	addi	a3,a3,1392 # ffffffffc0207288 <default_pmm_manager+0xa08>
ffffffffc0204d20:	00001617          	auipc	a2,0x1
ffffffffc0204d24:	45060613          	addi	a2,a2,1104 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204d28:	2dc00593          	li	a1,732
ffffffffc0204d2c:	00002517          	auipc	a0,0x2
ffffffffc0204d30:	25450513          	addi	a0,a0,596 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204d34:	ceafb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204d38:	00002697          	auipc	a3,0x2
ffffffffc0204d3c:	50868693          	addi	a3,a3,1288 # ffffffffc0207240 <default_pmm_manager+0x9c0>
ffffffffc0204d40:	00001617          	auipc	a2,0x1
ffffffffc0204d44:	43060613          	addi	a2,a2,1072 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204d48:	2db00593          	li	a1,731
ffffffffc0204d4c:	00002517          	auipc	a0,0x2
ffffffffc0204d50:	23450513          	addi	a0,a0,564 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204d54:	ccafb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204d58:	00002697          	auipc	a3,0x2
ffffffffc0204d5c:	4a068693          	addi	a3,a3,1184 # ffffffffc02071f8 <default_pmm_manager+0x978>
ffffffffc0204d60:	00001617          	auipc	a2,0x1
ffffffffc0204d64:	41060613          	addi	a2,a2,1040 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204d68:	2da00593          	li	a1,730
ffffffffc0204d6c:	00002517          	auipc	a0,0x2
ffffffffc0204d70:	21450513          	addi	a0,a0,532 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204d74:	caafb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204d78:	00002697          	auipc	a3,0x2
ffffffffc0204d7c:	43868693          	addi	a3,a3,1080 # ffffffffc02071b0 <default_pmm_manager+0x930>
ffffffffc0204d80:	00001617          	auipc	a2,0x1
ffffffffc0204d84:	3f060613          	addi	a2,a2,1008 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204d88:	2d900593          	li	a1,729
ffffffffc0204d8c:	00002517          	auipc	a0,0x2
ffffffffc0204d90:	1f450513          	addi	a0,a0,500 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204d94:	c8afb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0204d98 <do_yield>:
    current->need_resched = 1;
ffffffffc0204d98:	000a6797          	auipc	a5,0xa6
ffffffffc0204d9c:	9287b783          	ld	a5,-1752(a5) # ffffffffc02aa6c0 <current>
ffffffffc0204da0:	4705                	li	a4,1
ffffffffc0204da2:	ef98                	sd	a4,24(a5)
}
ffffffffc0204da4:	4501                	li	a0,0
ffffffffc0204da6:	8082                	ret

ffffffffc0204da8 <do_wait>:
{
ffffffffc0204da8:	1101                	addi	sp,sp,-32
ffffffffc0204daa:	e822                	sd	s0,16(sp)
ffffffffc0204dac:	e426                	sd	s1,8(sp)
ffffffffc0204dae:	ec06                	sd	ra,24(sp)
ffffffffc0204db0:	842e                	mv	s0,a1
ffffffffc0204db2:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204db4:	c999                	beqz	a1,ffffffffc0204dca <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204db6:	000a6797          	auipc	a5,0xa6
ffffffffc0204dba:	90a7b783          	ld	a5,-1782(a5) # ffffffffc02aa6c0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204dbe:	7788                	ld	a0,40(a5)
ffffffffc0204dc0:	4685                	li	a3,1
ffffffffc0204dc2:	4611                	li	a2,4
ffffffffc0204dc4:	8d5fc0ef          	jal	ra,ffffffffc0201698 <user_mem_check>
ffffffffc0204dc8:	c909                	beqz	a0,ffffffffc0204dda <do_wait+0x32>
ffffffffc0204dca:	85a2                	mv	a1,s0
}
ffffffffc0204dcc:	6442                	ld	s0,16(sp)
ffffffffc0204dce:	60e2                	ld	ra,24(sp)
ffffffffc0204dd0:	8526                	mv	a0,s1
ffffffffc0204dd2:	64a2                	ld	s1,8(sp)
ffffffffc0204dd4:	6105                	addi	sp,sp,32
ffffffffc0204dd6:	fb8ff06f          	j	ffffffffc020458e <do_wait.part.0>
ffffffffc0204dda:	60e2                	ld	ra,24(sp)
ffffffffc0204ddc:	6442                	ld	s0,16(sp)
ffffffffc0204dde:	64a2                	ld	s1,8(sp)
ffffffffc0204de0:	5575                	li	a0,-3
ffffffffc0204de2:	6105                	addi	sp,sp,32
ffffffffc0204de4:	8082                	ret

ffffffffc0204de6 <do_kill>:
{
ffffffffc0204de6:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204de8:	6789                	lui	a5,0x2
{
ffffffffc0204dea:	e406                	sd	ra,8(sp)
ffffffffc0204dec:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204dee:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204df2:	17f9                	addi	a5,a5,-2
ffffffffc0204df4:	02e7e963          	bltu	a5,a4,ffffffffc0204e26 <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204df8:	842a                	mv	s0,a0
ffffffffc0204dfa:	45a9                	li	a1,10
ffffffffc0204dfc:	2501                	sext.w	a0,a0
ffffffffc0204dfe:	0bd000ef          	jal	ra,ffffffffc02056ba <hash32>
ffffffffc0204e02:	02051793          	slli	a5,a0,0x20
ffffffffc0204e06:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204e0a:	000a2797          	auipc	a5,0xa2
ffffffffc0204e0e:	83e78793          	addi	a5,a5,-1986 # ffffffffc02a6648 <hash_list>
ffffffffc0204e12:	953e                	add	a0,a0,a5
ffffffffc0204e14:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204e16:	a029                	j	ffffffffc0204e20 <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204e18:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204e1c:	00870b63          	beq	a4,s0,ffffffffc0204e32 <do_kill+0x4c>
ffffffffc0204e20:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204e22:	fef51be3          	bne	a0,a5,ffffffffc0204e18 <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204e26:	5475                	li	s0,-3
}
ffffffffc0204e28:	60a2                	ld	ra,8(sp)
ffffffffc0204e2a:	8522                	mv	a0,s0
ffffffffc0204e2c:	6402                	ld	s0,0(sp)
ffffffffc0204e2e:	0141                	addi	sp,sp,16
ffffffffc0204e30:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204e32:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204e36:	00177693          	andi	a3,a4,1
ffffffffc0204e3a:	e295                	bnez	a3,ffffffffc0204e5e <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204e3c:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204e3e:	00176713          	ori	a4,a4,1
ffffffffc0204e42:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204e46:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204e48:	fe06d0e3          	bgez	a3,ffffffffc0204e28 <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204e4c:	f2878513          	addi	a0,a5,-216
ffffffffc0204e50:	1c4000ef          	jal	ra,ffffffffc0205014 <wakeup_proc>
}
ffffffffc0204e54:	60a2                	ld	ra,8(sp)
ffffffffc0204e56:	8522                	mv	a0,s0
ffffffffc0204e58:	6402                	ld	s0,0(sp)
ffffffffc0204e5a:	0141                	addi	sp,sp,16
ffffffffc0204e5c:	8082                	ret
        return -E_KILLED;
ffffffffc0204e5e:	545d                	li	s0,-9
ffffffffc0204e60:	b7e1                	j	ffffffffc0204e28 <do_kill+0x42>

ffffffffc0204e62 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204e62:	1101                	addi	sp,sp,-32
ffffffffc0204e64:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204e66:	000a5797          	auipc	a5,0xa5
ffffffffc0204e6a:	7e278793          	addi	a5,a5,2018 # ffffffffc02aa648 <proc_list>
ffffffffc0204e6e:	ec06                	sd	ra,24(sp)
ffffffffc0204e70:	e822                	sd	s0,16(sp)
ffffffffc0204e72:	e04a                	sd	s2,0(sp)
ffffffffc0204e74:	000a1497          	auipc	s1,0xa1
ffffffffc0204e78:	7d448493          	addi	s1,s1,2004 # ffffffffc02a6648 <hash_list>
ffffffffc0204e7c:	e79c                	sd	a5,8(a5)
ffffffffc0204e7e:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204e80:	000a5717          	auipc	a4,0xa5
ffffffffc0204e84:	7c870713          	addi	a4,a4,1992 # ffffffffc02aa648 <proc_list>
ffffffffc0204e88:	87a6                	mv	a5,s1
ffffffffc0204e8a:	e79c                	sd	a5,8(a5)
ffffffffc0204e8c:	e39c                	sd	a5,0(a5)
ffffffffc0204e8e:	07c1                	addi	a5,a5,16
ffffffffc0204e90:	fef71de3          	bne	a4,a5,ffffffffc0204e8a <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204e94:	fc9fe0ef          	jal	ra,ffffffffc0203e5c <alloc_proc>
ffffffffc0204e98:	000a6917          	auipc	s2,0xa6
ffffffffc0204e9c:	83090913          	addi	s2,s2,-2000 # ffffffffc02aa6c8 <idleproc>
ffffffffc0204ea0:	00a93023          	sd	a0,0(s2)
ffffffffc0204ea4:	0e050f63          	beqz	a0,ffffffffc0204fa2 <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204ea8:	4789                	li	a5,2
ffffffffc0204eaa:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204eac:	00003797          	auipc	a5,0x3
ffffffffc0204eb0:	15478793          	addi	a5,a5,340 # ffffffffc0208000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204eb4:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204eb8:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204eba:	4785                	li	a5,1
ffffffffc0204ebc:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ebe:	4641                	li	a2,16
ffffffffc0204ec0:	4581                	li	a1,0
ffffffffc0204ec2:	8522                	mv	a0,s0
ffffffffc0204ec4:	3de000ef          	jal	ra,ffffffffc02052a2 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204ec8:	463d                	li	a2,15
ffffffffc0204eca:	00002597          	auipc	a1,0x2
ffffffffc0204ece:	41e58593          	addi	a1,a1,1054 # ffffffffc02072e8 <default_pmm_manager+0xa68>
ffffffffc0204ed2:	8522                	mv	a0,s0
ffffffffc0204ed4:	3e0000ef          	jal	ra,ffffffffc02052b4 <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204ed8:	000a6717          	auipc	a4,0xa6
ffffffffc0204edc:	80070713          	addi	a4,a4,-2048 # ffffffffc02aa6d8 <nr_process>
ffffffffc0204ee0:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204ee2:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204ee6:	4601                	li	a2,0
    nr_process++;
ffffffffc0204ee8:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204eea:	4581                	li	a1,0
ffffffffc0204eec:	00000517          	auipc	a0,0x0
ffffffffc0204ef0:	87450513          	addi	a0,a0,-1932 # ffffffffc0204760 <init_main>
    nr_process++;
ffffffffc0204ef4:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204ef6:	000a5797          	auipc	a5,0xa5
ffffffffc0204efa:	7cd7b523          	sd	a3,1994(a5) # ffffffffc02aa6c0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204efe:	cf6ff0ef          	jal	ra,ffffffffc02043f4 <kernel_thread>
ffffffffc0204f02:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204f04:	08a05363          	blez	a0,ffffffffc0204f8a <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204f08:	6789                	lui	a5,0x2
ffffffffc0204f0a:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204f0e:	17f9                	addi	a5,a5,-2
ffffffffc0204f10:	2501                	sext.w	a0,a0
ffffffffc0204f12:	02e7e363          	bltu	a5,a4,ffffffffc0204f38 <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204f16:	45a9                	li	a1,10
ffffffffc0204f18:	7a2000ef          	jal	ra,ffffffffc02056ba <hash32>
ffffffffc0204f1c:	02051793          	slli	a5,a0,0x20
ffffffffc0204f20:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204f24:	96a6                	add	a3,a3,s1
ffffffffc0204f26:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204f28:	a029                	j	ffffffffc0204f32 <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204f2a:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x7c7c>
ffffffffc0204f2e:	04870b63          	beq	a4,s0,ffffffffc0204f84 <proc_init+0x122>
    return listelm->next;
ffffffffc0204f32:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204f34:	fef69be3          	bne	a3,a5,ffffffffc0204f2a <proc_init+0xc8>
    return NULL;
ffffffffc0204f38:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f3a:	0b478493          	addi	s1,a5,180
ffffffffc0204f3e:	4641                	li	a2,16
ffffffffc0204f40:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204f42:	000a5417          	auipc	s0,0xa5
ffffffffc0204f46:	78e40413          	addi	s0,s0,1934 # ffffffffc02aa6d0 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f4a:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204f4c:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204f4e:	354000ef          	jal	ra,ffffffffc02052a2 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204f52:	463d                	li	a2,15
ffffffffc0204f54:	00002597          	auipc	a1,0x2
ffffffffc0204f58:	3bc58593          	addi	a1,a1,956 # ffffffffc0207310 <default_pmm_manager+0xa90>
ffffffffc0204f5c:	8526                	mv	a0,s1
ffffffffc0204f5e:	356000ef          	jal	ra,ffffffffc02052b4 <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204f62:	00093783          	ld	a5,0(s2)
ffffffffc0204f66:	cbb5                	beqz	a5,ffffffffc0204fda <proc_init+0x178>
ffffffffc0204f68:	43dc                	lw	a5,4(a5)
ffffffffc0204f6a:	eba5                	bnez	a5,ffffffffc0204fda <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f6c:	601c                	ld	a5,0(s0)
ffffffffc0204f6e:	c7b1                	beqz	a5,ffffffffc0204fba <proc_init+0x158>
ffffffffc0204f70:	43d8                	lw	a4,4(a5)
ffffffffc0204f72:	4785                	li	a5,1
ffffffffc0204f74:	04f71363          	bne	a4,a5,ffffffffc0204fba <proc_init+0x158>
}
ffffffffc0204f78:	60e2                	ld	ra,24(sp)
ffffffffc0204f7a:	6442                	ld	s0,16(sp)
ffffffffc0204f7c:	64a2                	ld	s1,8(sp)
ffffffffc0204f7e:	6902                	ld	s2,0(sp)
ffffffffc0204f80:	6105                	addi	sp,sp,32
ffffffffc0204f82:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204f84:	f2878793          	addi	a5,a5,-216
ffffffffc0204f88:	bf4d                	j	ffffffffc0204f3a <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204f8a:	00002617          	auipc	a2,0x2
ffffffffc0204f8e:	36660613          	addi	a2,a2,870 # ffffffffc02072f0 <default_pmm_manager+0xa70>
ffffffffc0204f92:	40500593          	li	a1,1029
ffffffffc0204f96:	00002517          	auipc	a0,0x2
ffffffffc0204f9a:	fea50513          	addi	a0,a0,-22 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204f9e:	a80fb0ef          	jal	ra,ffffffffc020021e <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204fa2:	00002617          	auipc	a2,0x2
ffffffffc0204fa6:	32e60613          	addi	a2,a2,814 # ffffffffc02072d0 <default_pmm_manager+0xa50>
ffffffffc0204faa:	3f600593          	li	a1,1014
ffffffffc0204fae:	00002517          	auipc	a0,0x2
ffffffffc0204fb2:	fd250513          	addi	a0,a0,-46 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204fb6:	a68fb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204fba:	00002697          	auipc	a3,0x2
ffffffffc0204fbe:	38668693          	addi	a3,a3,902 # ffffffffc0207340 <default_pmm_manager+0xac0>
ffffffffc0204fc2:	00001617          	auipc	a2,0x1
ffffffffc0204fc6:	1ae60613          	addi	a2,a2,430 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204fca:	40c00593          	li	a1,1036
ffffffffc0204fce:	00002517          	auipc	a0,0x2
ffffffffc0204fd2:	fb250513          	addi	a0,a0,-78 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204fd6:	a48fb0ef          	jal	ra,ffffffffc020021e <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204fda:	00002697          	auipc	a3,0x2
ffffffffc0204fde:	33e68693          	addi	a3,a3,830 # ffffffffc0207318 <default_pmm_manager+0xa98>
ffffffffc0204fe2:	00001617          	auipc	a2,0x1
ffffffffc0204fe6:	18e60613          	addi	a2,a2,398 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0204fea:	40b00593          	li	a1,1035
ffffffffc0204fee:	00002517          	auipc	a0,0x2
ffffffffc0204ff2:	f9250513          	addi	a0,a0,-110 # ffffffffc0206f80 <default_pmm_manager+0x700>
ffffffffc0204ff6:	a28fb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0204ffa <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204ffa:	1141                	addi	sp,sp,-16
ffffffffc0204ffc:	e022                	sd	s0,0(sp)
ffffffffc0204ffe:	e406                	sd	ra,8(sp)
ffffffffc0205000:	000a5417          	auipc	s0,0xa5
ffffffffc0205004:	6c040413          	addi	s0,s0,1728 # ffffffffc02aa6c0 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0205008:	6018                	ld	a4,0(s0)
ffffffffc020500a:	6f1c                	ld	a5,24(a4)
ffffffffc020500c:	dffd                	beqz	a5,ffffffffc020500a <cpu_idle+0x10>
        {
            schedule();
ffffffffc020500e:	086000ef          	jal	ra,ffffffffc0205094 <schedule>
ffffffffc0205012:	bfdd                	j	ffffffffc0205008 <cpu_idle+0xe>

ffffffffc0205014 <wakeup_proc>:
#include <sched.h>
#include <assert.h>

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205014:	4118                	lw	a4,0(a0)
{
ffffffffc0205016:	1101                	addi	sp,sp,-32
ffffffffc0205018:	ec06                	sd	ra,24(sp)
ffffffffc020501a:	e822                	sd	s0,16(sp)
ffffffffc020501c:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020501e:	478d                	li	a5,3
ffffffffc0205020:	04f70b63          	beq	a4,a5,ffffffffc0205076 <wakeup_proc+0x62>
ffffffffc0205024:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205026:	100027f3          	csrr	a5,sstatus
ffffffffc020502a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020502c:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020502e:	ef9d                	bnez	a5,ffffffffc020506c <wakeup_proc+0x58>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205030:	4789                	li	a5,2
ffffffffc0205032:	02f70163          	beq	a4,a5,ffffffffc0205054 <wakeup_proc+0x40>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc0205036:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc0205038:	0e042623          	sw	zero,236(s0)
    if (flag)
ffffffffc020503c:	e491                	bnez	s1,ffffffffc0205048 <wakeup_proc+0x34>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020503e:	60e2                	ld	ra,24(sp)
ffffffffc0205040:	6442                	ld	s0,16(sp)
ffffffffc0205042:	64a2                	ld	s1,8(sp)
ffffffffc0205044:	6105                	addi	sp,sp,32
ffffffffc0205046:	8082                	ret
ffffffffc0205048:	6442                	ld	s0,16(sp)
ffffffffc020504a:	60e2                	ld	ra,24(sp)
ffffffffc020504c:	64a2                	ld	s1,8(sp)
ffffffffc020504e:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0205050:	965fb06f          	j	ffffffffc02009b4 <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0205054:	00002617          	auipc	a2,0x2
ffffffffc0205058:	34c60613          	addi	a2,a2,844 # ffffffffc02073a0 <default_pmm_manager+0xb20>
ffffffffc020505c:	45d1                	li	a1,20
ffffffffc020505e:	00002517          	auipc	a0,0x2
ffffffffc0205062:	32a50513          	addi	a0,a0,810 # ffffffffc0207388 <default_pmm_manager+0xb08>
ffffffffc0205066:	a20fb0ef          	jal	ra,ffffffffc0200286 <__warn>
ffffffffc020506a:	bfc9                	j	ffffffffc020503c <wakeup_proc+0x28>
        intr_disable();
ffffffffc020506c:	94ffb0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205070:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc0205072:	4485                	li	s1,1
ffffffffc0205074:	bf75                	j	ffffffffc0205030 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205076:	00002697          	auipc	a3,0x2
ffffffffc020507a:	2f268693          	addi	a3,a3,754 # ffffffffc0207368 <default_pmm_manager+0xae8>
ffffffffc020507e:	00001617          	auipc	a2,0x1
ffffffffc0205082:	0f260613          	addi	a2,a2,242 # ffffffffc0206170 <commands+0x7f8>
ffffffffc0205086:	45a5                	li	a1,9
ffffffffc0205088:	00002517          	auipc	a0,0x2
ffffffffc020508c:	30050513          	addi	a0,a0,768 # ffffffffc0207388 <default_pmm_manager+0xb08>
ffffffffc0205090:	98efb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0205094 <schedule>:

void schedule(void)
{
ffffffffc0205094:	1141                	addi	sp,sp,-16
ffffffffc0205096:	e406                	sd	ra,8(sp)
ffffffffc0205098:	e022                	sd	s0,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020509a:	100027f3          	csrr	a5,sstatus
ffffffffc020509e:	8b89                	andi	a5,a5,2
ffffffffc02050a0:	4401                	li	s0,0
ffffffffc02050a2:	efbd                	bnez	a5,ffffffffc0205120 <schedule+0x8c>
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc02050a4:	000a5897          	auipc	a7,0xa5
ffffffffc02050a8:	61c8b883          	ld	a7,1564(a7) # ffffffffc02aa6c0 <current>
ffffffffc02050ac:	0008bc23          	sd	zero,24(a7)
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc02050b0:	000a5517          	auipc	a0,0xa5
ffffffffc02050b4:	61853503          	ld	a0,1560(a0) # ffffffffc02aa6c8 <idleproc>
ffffffffc02050b8:	04a88e63          	beq	a7,a0,ffffffffc0205114 <schedule+0x80>
ffffffffc02050bc:	0c888693          	addi	a3,a7,200
ffffffffc02050c0:	000a5617          	auipc	a2,0xa5
ffffffffc02050c4:	58860613          	addi	a2,a2,1416 # ffffffffc02aa648 <proc_list>
        le = last;
ffffffffc02050c8:	87b6                	mv	a5,a3
    struct proc_struct *next = NULL;
ffffffffc02050ca:	4581                	li	a1,0
        do
        {
            if ((le = list_next(le)) != &proc_list)
            {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE)
ffffffffc02050cc:	4809                	li	a6,2
ffffffffc02050ce:	679c                	ld	a5,8(a5)
            if ((le = list_next(le)) != &proc_list)
ffffffffc02050d0:	00c78863          	beq	a5,a2,ffffffffc02050e0 <schedule+0x4c>
                if (next->state == PROC_RUNNABLE)
ffffffffc02050d4:	f387a703          	lw	a4,-200(a5)
                next = le2proc(le, list_link);
ffffffffc02050d8:	f3878593          	addi	a1,a5,-200
                if (next->state == PROC_RUNNABLE)
ffffffffc02050dc:	03070163          	beq	a4,a6,ffffffffc02050fe <schedule+0x6a>
                {
                    break;
                }
            }
        } while (le != last);
ffffffffc02050e0:	fef697e3          	bne	a3,a5,ffffffffc02050ce <schedule+0x3a>
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050e4:	ed89                	bnez	a1,ffffffffc02050fe <schedule+0x6a>
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc02050e6:	451c                	lw	a5,8(a0)
ffffffffc02050e8:	2785                	addiw	a5,a5,1
ffffffffc02050ea:	c51c                	sw	a5,8(a0)
        if (next != current)
ffffffffc02050ec:	00a88463          	beq	a7,a0,ffffffffc02050f4 <schedule+0x60>
        {
            proc_run(next);
ffffffffc02050f0:	ee1fe0ef          	jal	ra,ffffffffc0203fd0 <proc_run>
    if (flag)
ffffffffc02050f4:	e819                	bnez	s0,ffffffffc020510a <schedule+0x76>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02050f6:	60a2                	ld	ra,8(sp)
ffffffffc02050f8:	6402                	ld	s0,0(sp)
ffffffffc02050fa:	0141                	addi	sp,sp,16
ffffffffc02050fc:	8082                	ret
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050fe:	4198                	lw	a4,0(a1)
ffffffffc0205100:	4789                	li	a5,2
ffffffffc0205102:	fef712e3          	bne	a4,a5,ffffffffc02050e6 <schedule+0x52>
ffffffffc0205106:	852e                	mv	a0,a1
ffffffffc0205108:	bff9                	j	ffffffffc02050e6 <schedule+0x52>
}
ffffffffc020510a:	6402                	ld	s0,0(sp)
ffffffffc020510c:	60a2                	ld	ra,8(sp)
ffffffffc020510e:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0205110:	8a5fb06f          	j	ffffffffc02009b4 <intr_enable>
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc0205114:	000a5617          	auipc	a2,0xa5
ffffffffc0205118:	53460613          	addi	a2,a2,1332 # ffffffffc02aa648 <proc_list>
ffffffffc020511c:	86b2                	mv	a3,a2
ffffffffc020511e:	b76d                	j	ffffffffc02050c8 <schedule+0x34>
        intr_disable();
ffffffffc0205120:	89bfb0ef          	jal	ra,ffffffffc02009ba <intr_disable>
        return 1;
ffffffffc0205124:	4405                	li	s0,1
ffffffffc0205126:	bfbd                	j	ffffffffc02050a4 <schedule+0x10>

ffffffffc0205128 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc0205128:	000a5797          	auipc	a5,0xa5
ffffffffc020512c:	5987b783          	ld	a5,1432(a5) # ffffffffc02aa6c0 <current>
}
ffffffffc0205130:	43c8                	lw	a0,4(a5)
ffffffffc0205132:	8082                	ret

ffffffffc0205134 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc0205134:	4501                	li	a0,0
ffffffffc0205136:	8082                	ret

ffffffffc0205138 <sys_putc>:
    cputchar(c);
ffffffffc0205138:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc020513a:	1141                	addi	sp,sp,-16
ffffffffc020513c:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc020513e:	fd9fa0ef          	jal	ra,ffffffffc0200116 <cputchar>
}
ffffffffc0205142:	60a2                	ld	ra,8(sp)
ffffffffc0205144:	4501                	li	a0,0
ffffffffc0205146:	0141                	addi	sp,sp,16
ffffffffc0205148:	8082                	ret

ffffffffc020514a <sys_kill>:
    return do_kill(pid);
ffffffffc020514a:	4108                	lw	a0,0(a0)
ffffffffc020514c:	c9bff06f          	j	ffffffffc0204de6 <do_kill>

ffffffffc0205150 <sys_yield>:
    return do_yield();
ffffffffc0205150:	c49ff06f          	j	ffffffffc0204d98 <do_yield>

ffffffffc0205154 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0205154:	6d14                	ld	a3,24(a0)
ffffffffc0205156:	6910                	ld	a2,16(a0)
ffffffffc0205158:	650c                	ld	a1,8(a0)
ffffffffc020515a:	6108                	ld	a0,0(a0)
ffffffffc020515c:	f28ff06f          	j	ffffffffc0204884 <do_execve>

ffffffffc0205160 <sys_wait>:
    return do_wait(pid, store);
ffffffffc0205160:	650c                	ld	a1,8(a0)
ffffffffc0205162:	4108                	lw	a0,0(a0)
ffffffffc0205164:	c45ff06f          	j	ffffffffc0204da8 <do_wait>

ffffffffc0205168 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0205168:	000a5797          	auipc	a5,0xa5
ffffffffc020516c:	5587b783          	ld	a5,1368(a5) # ffffffffc02aa6c0 <current>
ffffffffc0205170:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0205172:	4501                	li	a0,0
ffffffffc0205174:	6a0c                	ld	a1,16(a2)
ffffffffc0205176:	ebffe06f          	j	ffffffffc0204034 <do_fork>

ffffffffc020517a <sys_exit>:
    return do_exit(error_code);
ffffffffc020517a:	4108                	lw	a0,0(a0)
ffffffffc020517c:	ac8ff06f          	j	ffffffffc0204444 <do_exit>

ffffffffc0205180 <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc0205180:	715d                	addi	sp,sp,-80
ffffffffc0205182:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205184:	000a5497          	auipc	s1,0xa5
ffffffffc0205188:	53c48493          	addi	s1,s1,1340 # ffffffffc02aa6c0 <current>
ffffffffc020518c:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc020518e:	e0a2                	sd	s0,64(sp)
ffffffffc0205190:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205192:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0205194:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205196:	47fd                	li	a5,31
    int num = tf->gpr.a0;
ffffffffc0205198:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020519c:	0327ee63          	bltu	a5,s2,ffffffffc02051d8 <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc02051a0:	00391713          	slli	a4,s2,0x3
ffffffffc02051a4:	00002797          	auipc	a5,0x2
ffffffffc02051a8:	26478793          	addi	a5,a5,612 # ffffffffc0207408 <syscalls>
ffffffffc02051ac:	97ba                	add	a5,a5,a4
ffffffffc02051ae:	639c                	ld	a5,0(a5)
ffffffffc02051b0:	c785                	beqz	a5,ffffffffc02051d8 <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc02051b2:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc02051b4:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc02051b6:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02051b8:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02051ba:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02051bc:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02051be:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02051c0:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02051c2:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02051c4:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02051c6:	0028                	addi	a0,sp,8
ffffffffc02051c8:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02051ca:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02051cc:	e828                	sd	a0,80(s0)
}
ffffffffc02051ce:	6406                	ld	s0,64(sp)
ffffffffc02051d0:	74e2                	ld	s1,56(sp)
ffffffffc02051d2:	7942                	ld	s2,48(sp)
ffffffffc02051d4:	6161                	addi	sp,sp,80
ffffffffc02051d6:	8082                	ret
    print_trapframe(tf);
ffffffffc02051d8:	8522                	mv	a0,s0
ffffffffc02051da:	9cffb0ef          	jal	ra,ffffffffc0200ba8 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02051de:	609c                	ld	a5,0(s1)
ffffffffc02051e0:	86ca                	mv	a3,s2
ffffffffc02051e2:	00002617          	auipc	a2,0x2
ffffffffc02051e6:	1de60613          	addi	a2,a2,478 # ffffffffc02073c0 <default_pmm_manager+0xb40>
ffffffffc02051ea:	43d8                	lw	a4,4(a5)
ffffffffc02051ec:	06200593          	li	a1,98
ffffffffc02051f0:	0b478793          	addi	a5,a5,180
ffffffffc02051f4:	00002517          	auipc	a0,0x2
ffffffffc02051f8:	1fc50513          	addi	a0,a0,508 # ffffffffc02073f0 <default_pmm_manager+0xb70>
ffffffffc02051fc:	822fb0ef          	jal	ra,ffffffffc020021e <__panic>

ffffffffc0205200 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0205200:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0205204:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0205206:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0205208:	cb81                	beqz	a5,ffffffffc0205218 <strlen+0x18>
        cnt ++;
ffffffffc020520a:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc020520c:	00a707b3          	add	a5,a4,a0
ffffffffc0205210:	0007c783          	lbu	a5,0(a5)
ffffffffc0205214:	fbfd                	bnez	a5,ffffffffc020520a <strlen+0xa>
ffffffffc0205216:	8082                	ret
    }
    return cnt;
}
ffffffffc0205218:	8082                	ret

ffffffffc020521a <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc020521a:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020521c:	e589                	bnez	a1,ffffffffc0205226 <strnlen+0xc>
ffffffffc020521e:	a811                	j	ffffffffc0205232 <strnlen+0x18>
        cnt ++;
ffffffffc0205220:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0205222:	00f58863          	beq	a1,a5,ffffffffc0205232 <strnlen+0x18>
ffffffffc0205226:	00f50733          	add	a4,a0,a5
ffffffffc020522a:	00074703          	lbu	a4,0(a4)
ffffffffc020522e:	fb6d                	bnez	a4,ffffffffc0205220 <strnlen+0x6>
ffffffffc0205230:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0205232:	852e                	mv	a0,a1
ffffffffc0205234:	8082                	ret

ffffffffc0205236 <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc0205236:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc0205238:	0005c703          	lbu	a4,0(a1)
ffffffffc020523c:	0785                	addi	a5,a5,1
ffffffffc020523e:	0585                	addi	a1,a1,1
ffffffffc0205240:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0205244:	fb75                	bnez	a4,ffffffffc0205238 <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc0205246:	8082                	ret

ffffffffc0205248 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205248:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020524c:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205250:	cb89                	beqz	a5,ffffffffc0205262 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0205252:	0505                	addi	a0,a0,1
ffffffffc0205254:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205256:	fee789e3          	beq	a5,a4,ffffffffc0205248 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020525a:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc020525e:	9d19                	subw	a0,a0,a4
ffffffffc0205260:	8082                	ret
ffffffffc0205262:	4501                	li	a0,0
ffffffffc0205264:	bfed                	j	ffffffffc020525e <strcmp+0x16>

ffffffffc0205266 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205266:	c20d                	beqz	a2,ffffffffc0205288 <strncmp+0x22>
ffffffffc0205268:	962e                	add	a2,a2,a1
ffffffffc020526a:	a031                	j	ffffffffc0205276 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc020526c:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020526e:	00e79a63          	bne	a5,a4,ffffffffc0205282 <strncmp+0x1c>
ffffffffc0205272:	00b60b63          	beq	a2,a1,ffffffffc0205288 <strncmp+0x22>
ffffffffc0205276:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc020527a:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020527c:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0205280:	f7f5                	bnez	a5,ffffffffc020526c <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205282:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0205286:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205288:	4501                	li	a0,0
ffffffffc020528a:	8082                	ret

ffffffffc020528c <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020528c:	00054783          	lbu	a5,0(a0)
ffffffffc0205290:	c799                	beqz	a5,ffffffffc020529e <strchr+0x12>
        if (*s == c) {
ffffffffc0205292:	00f58763          	beq	a1,a5,ffffffffc02052a0 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0205296:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020529a:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020529c:	fbfd                	bnez	a5,ffffffffc0205292 <strchr+0x6>
    }
    return NULL;
ffffffffc020529e:	4501                	li	a0,0
}
ffffffffc02052a0:	8082                	ret

ffffffffc02052a2 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc02052a2:	ca01                	beqz	a2,ffffffffc02052b2 <memset+0x10>
ffffffffc02052a4:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc02052a6:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc02052a8:	0785                	addi	a5,a5,1
ffffffffc02052aa:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc02052ae:	fec79de3          	bne	a5,a2,ffffffffc02052a8 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc02052b2:	8082                	ret

ffffffffc02052b4 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc02052b4:	ca19                	beqz	a2,ffffffffc02052ca <memcpy+0x16>
ffffffffc02052b6:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc02052b8:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc02052ba:	0005c703          	lbu	a4,0(a1)
ffffffffc02052be:	0585                	addi	a1,a1,1
ffffffffc02052c0:	0785                	addi	a5,a5,1
ffffffffc02052c2:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc02052c6:	fec59ae3          	bne	a1,a2,ffffffffc02052ba <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc02052ca:	8082                	ret

ffffffffc02052cc <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02052cc:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02052d0:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02052d2:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02052d6:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02052d8:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02052dc:	f022                	sd	s0,32(sp)
ffffffffc02052de:	ec26                	sd	s1,24(sp)
ffffffffc02052e0:	e84a                	sd	s2,16(sp)
ffffffffc02052e2:	f406                	sd	ra,40(sp)
ffffffffc02052e4:	e44e                	sd	s3,8(sp)
ffffffffc02052e6:	84aa                	mv	s1,a0
ffffffffc02052e8:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02052ea:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02052ee:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc02052f0:	03067e63          	bgeu	a2,a6,ffffffffc020532c <printnum+0x60>
ffffffffc02052f4:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc02052f6:	00805763          	blez	s0,ffffffffc0205304 <printnum+0x38>
ffffffffc02052fa:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02052fc:	85ca                	mv	a1,s2
ffffffffc02052fe:	854e                	mv	a0,s3
ffffffffc0205300:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0205302:	fc65                	bnez	s0,ffffffffc02052fa <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205304:	1a02                	slli	s4,s4,0x20
ffffffffc0205306:	00002797          	auipc	a5,0x2
ffffffffc020530a:	20278793          	addi	a5,a5,514 # ffffffffc0207508 <syscalls+0x100>
ffffffffc020530e:	020a5a13          	srli	s4,s4,0x20
ffffffffc0205312:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc0205314:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205316:	000a4503          	lbu	a0,0(s4)
}
ffffffffc020531a:	70a2                	ld	ra,40(sp)
ffffffffc020531c:	69a2                	ld	s3,8(sp)
ffffffffc020531e:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205320:	85ca                	mv	a1,s2
ffffffffc0205322:	87a6                	mv	a5,s1
}
ffffffffc0205324:	6942                	ld	s2,16(sp)
ffffffffc0205326:	64e2                	ld	s1,24(sp)
ffffffffc0205328:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020532a:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc020532c:	03065633          	divu	a2,a2,a6
ffffffffc0205330:	8722                	mv	a4,s0
ffffffffc0205332:	f9bff0ef          	jal	ra,ffffffffc02052cc <printnum>
ffffffffc0205336:	b7f9                	j	ffffffffc0205304 <printnum+0x38>

ffffffffc0205338 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0205338:	7119                	addi	sp,sp,-128
ffffffffc020533a:	f4a6                	sd	s1,104(sp)
ffffffffc020533c:	f0ca                	sd	s2,96(sp)
ffffffffc020533e:	ecce                	sd	s3,88(sp)
ffffffffc0205340:	e8d2                	sd	s4,80(sp)
ffffffffc0205342:	e4d6                	sd	s5,72(sp)
ffffffffc0205344:	e0da                	sd	s6,64(sp)
ffffffffc0205346:	fc5e                	sd	s7,56(sp)
ffffffffc0205348:	f06a                	sd	s10,32(sp)
ffffffffc020534a:	fc86                	sd	ra,120(sp)
ffffffffc020534c:	f8a2                	sd	s0,112(sp)
ffffffffc020534e:	f862                	sd	s8,48(sp)
ffffffffc0205350:	f466                	sd	s9,40(sp)
ffffffffc0205352:	ec6e                	sd	s11,24(sp)
ffffffffc0205354:	892a                	mv	s2,a0
ffffffffc0205356:	84ae                	mv	s1,a1
ffffffffc0205358:	8d32                	mv	s10,a2
ffffffffc020535a:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020535c:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0205360:	5b7d                	li	s6,-1
ffffffffc0205362:	00002a97          	auipc	s5,0x2
ffffffffc0205366:	1d2a8a93          	addi	s5,s5,466 # ffffffffc0207534 <syscalls+0x12c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020536a:	00002b97          	auipc	s7,0x2
ffffffffc020536e:	3e6b8b93          	addi	s7,s7,998 # ffffffffc0207750 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205372:	000d4503          	lbu	a0,0(s10)
ffffffffc0205376:	001d0413          	addi	s0,s10,1
ffffffffc020537a:	01350a63          	beq	a0,s3,ffffffffc020538e <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc020537e:	c121                	beqz	a0,ffffffffc02053be <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0205380:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205382:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0205384:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205386:	fff44503          	lbu	a0,-1(s0)
ffffffffc020538a:	ff351ae3          	bne	a0,s3,ffffffffc020537e <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020538e:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0205392:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0205396:	4c81                	li	s9,0
ffffffffc0205398:	4881                	li	a7,0
        width = precision = -1;
ffffffffc020539a:	5c7d                	li	s8,-1
ffffffffc020539c:	5dfd                	li	s11,-1
ffffffffc020539e:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02053a2:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053a4:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02053a8:	0ff5f593          	zext.b	a1,a1
ffffffffc02053ac:	00140d13          	addi	s10,s0,1
ffffffffc02053b0:	04b56263          	bltu	a0,a1,ffffffffc02053f4 <vprintfmt+0xbc>
ffffffffc02053b4:	058a                	slli	a1,a1,0x2
ffffffffc02053b6:	95d6                	add	a1,a1,s5
ffffffffc02053b8:	4194                	lw	a3,0(a1)
ffffffffc02053ba:	96d6                	add	a3,a3,s5
ffffffffc02053bc:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02053be:	70e6                	ld	ra,120(sp)
ffffffffc02053c0:	7446                	ld	s0,112(sp)
ffffffffc02053c2:	74a6                	ld	s1,104(sp)
ffffffffc02053c4:	7906                	ld	s2,96(sp)
ffffffffc02053c6:	69e6                	ld	s3,88(sp)
ffffffffc02053c8:	6a46                	ld	s4,80(sp)
ffffffffc02053ca:	6aa6                	ld	s5,72(sp)
ffffffffc02053cc:	6b06                	ld	s6,64(sp)
ffffffffc02053ce:	7be2                	ld	s7,56(sp)
ffffffffc02053d0:	7c42                	ld	s8,48(sp)
ffffffffc02053d2:	7ca2                	ld	s9,40(sp)
ffffffffc02053d4:	7d02                	ld	s10,32(sp)
ffffffffc02053d6:	6de2                	ld	s11,24(sp)
ffffffffc02053d8:	6109                	addi	sp,sp,128
ffffffffc02053da:	8082                	ret
            padc = '0';
ffffffffc02053dc:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc02053de:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053e2:	846a                	mv	s0,s10
ffffffffc02053e4:	00140d13          	addi	s10,s0,1
ffffffffc02053e8:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02053ec:	0ff5f593          	zext.b	a1,a1
ffffffffc02053f0:	fcb572e3          	bgeu	a0,a1,ffffffffc02053b4 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02053f4:	85a6                	mv	a1,s1
ffffffffc02053f6:	02500513          	li	a0,37
ffffffffc02053fa:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02053fc:	fff44783          	lbu	a5,-1(s0)
ffffffffc0205400:	8d22                	mv	s10,s0
ffffffffc0205402:	f73788e3          	beq	a5,s3,ffffffffc0205372 <vprintfmt+0x3a>
ffffffffc0205406:	ffed4783          	lbu	a5,-2(s10)
ffffffffc020540a:	1d7d                	addi	s10,s10,-1
ffffffffc020540c:	ff379de3          	bne	a5,s3,ffffffffc0205406 <vprintfmt+0xce>
ffffffffc0205410:	b78d                	j	ffffffffc0205372 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0205412:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0205416:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020541a:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc020541c:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0205420:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205424:	02d86463          	bltu	a6,a3,ffffffffc020544c <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0205428:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc020542c:	002c169b          	slliw	a3,s8,0x2
ffffffffc0205430:	0186873b          	addw	a4,a3,s8
ffffffffc0205434:	0017171b          	slliw	a4,a4,0x1
ffffffffc0205438:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc020543a:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc020543e:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0205440:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0205444:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205448:	fed870e3          	bgeu	a6,a3,ffffffffc0205428 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc020544c:	f40ddce3          	bgez	s11,ffffffffc02053a4 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0205450:	8de2                	mv	s11,s8
ffffffffc0205452:	5c7d                	li	s8,-1
ffffffffc0205454:	bf81                	j	ffffffffc02053a4 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0205456:	fffdc693          	not	a3,s11
ffffffffc020545a:	96fd                	srai	a3,a3,0x3f
ffffffffc020545c:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205460:	00144603          	lbu	a2,1(s0)
ffffffffc0205464:	2d81                	sext.w	s11,s11
ffffffffc0205466:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205468:	bf35                	j	ffffffffc02053a4 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc020546a:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020546e:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0205472:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205474:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0205476:	bfd9                	j	ffffffffc020544c <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0205478:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020547a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020547e:	01174463          	blt	a4,a7,ffffffffc0205486 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0205482:	1a088e63          	beqz	a7,ffffffffc020563e <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0205486:	000a3603          	ld	a2,0(s4)
ffffffffc020548a:	46c1                	li	a3,16
ffffffffc020548c:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc020548e:	2781                	sext.w	a5,a5
ffffffffc0205490:	876e                	mv	a4,s11
ffffffffc0205492:	85a6                	mv	a1,s1
ffffffffc0205494:	854a                	mv	a0,s2
ffffffffc0205496:	e37ff0ef          	jal	ra,ffffffffc02052cc <printnum>
            break;
ffffffffc020549a:	bde1                	j	ffffffffc0205372 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc020549c:	000a2503          	lw	a0,0(s4)
ffffffffc02054a0:	85a6                	mv	a1,s1
ffffffffc02054a2:	0a21                	addi	s4,s4,8
ffffffffc02054a4:	9902                	jalr	s2
            break;
ffffffffc02054a6:	b5f1                	j	ffffffffc0205372 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02054a8:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02054aa:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02054ae:	01174463          	blt	a4,a7,ffffffffc02054b6 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02054b2:	18088163          	beqz	a7,ffffffffc0205634 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02054b6:	000a3603          	ld	a2,0(s4)
ffffffffc02054ba:	46a9                	li	a3,10
ffffffffc02054bc:	8a2e                	mv	s4,a1
ffffffffc02054be:	bfc1                	j	ffffffffc020548e <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054c0:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc02054c4:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054c6:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02054c8:	bdf1                	j	ffffffffc02053a4 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc02054ca:	85a6                	mv	a1,s1
ffffffffc02054cc:	02500513          	li	a0,37
ffffffffc02054d0:	9902                	jalr	s2
            break;
ffffffffc02054d2:	b545                	j	ffffffffc0205372 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054d4:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc02054d8:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054da:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02054dc:	b5e1                	j	ffffffffc02053a4 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc02054de:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02054e0:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02054e4:	01174463          	blt	a4,a7,ffffffffc02054ec <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc02054e8:	14088163          	beqz	a7,ffffffffc020562a <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc02054ec:	000a3603          	ld	a2,0(s4)
ffffffffc02054f0:	46a1                	li	a3,8
ffffffffc02054f2:	8a2e                	mv	s4,a1
ffffffffc02054f4:	bf69                	j	ffffffffc020548e <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc02054f6:	03000513          	li	a0,48
ffffffffc02054fa:	85a6                	mv	a1,s1
ffffffffc02054fc:	e03e                	sd	a5,0(sp)
ffffffffc02054fe:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0205500:	85a6                	mv	a1,s1
ffffffffc0205502:	07800513          	li	a0,120
ffffffffc0205506:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205508:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc020550a:	6782                	ld	a5,0(sp)
ffffffffc020550c:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc020550e:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0205512:	bfb5                	j	ffffffffc020548e <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205514:	000a3403          	ld	s0,0(s4)
ffffffffc0205518:	008a0713          	addi	a4,s4,8
ffffffffc020551c:	e03a                	sd	a4,0(sp)
ffffffffc020551e:	14040263          	beqz	s0,ffffffffc0205662 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0205522:	0fb05763          	blez	s11,ffffffffc0205610 <vprintfmt+0x2d8>
ffffffffc0205526:	02d00693          	li	a3,45
ffffffffc020552a:	0cd79163          	bne	a5,a3,ffffffffc02055ec <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020552e:	00044783          	lbu	a5,0(s0)
ffffffffc0205532:	0007851b          	sext.w	a0,a5
ffffffffc0205536:	cf85                	beqz	a5,ffffffffc020556e <vprintfmt+0x236>
ffffffffc0205538:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020553c:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205540:	000c4563          	bltz	s8,ffffffffc020554a <vprintfmt+0x212>
ffffffffc0205544:	3c7d                	addiw	s8,s8,-1
ffffffffc0205546:	036c0263          	beq	s8,s6,ffffffffc020556a <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc020554a:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020554c:	0e0c8e63          	beqz	s9,ffffffffc0205648 <vprintfmt+0x310>
ffffffffc0205550:	3781                	addiw	a5,a5,-32
ffffffffc0205552:	0ef47b63          	bgeu	s0,a5,ffffffffc0205648 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0205556:	03f00513          	li	a0,63
ffffffffc020555a:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020555c:	000a4783          	lbu	a5,0(s4)
ffffffffc0205560:	3dfd                	addiw	s11,s11,-1
ffffffffc0205562:	0a05                	addi	s4,s4,1
ffffffffc0205564:	0007851b          	sext.w	a0,a5
ffffffffc0205568:	ffe1                	bnez	a5,ffffffffc0205540 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc020556a:	01b05963          	blez	s11,ffffffffc020557c <vprintfmt+0x244>
ffffffffc020556e:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0205570:	85a6                	mv	a1,s1
ffffffffc0205572:	02000513          	li	a0,32
ffffffffc0205576:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0205578:	fe0d9be3          	bnez	s11,ffffffffc020556e <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020557c:	6a02                	ld	s4,0(sp)
ffffffffc020557e:	bbd5                	j	ffffffffc0205372 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0205580:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205582:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0205586:	01174463          	blt	a4,a7,ffffffffc020558e <vprintfmt+0x256>
    else if (lflag) {
ffffffffc020558a:	08088d63          	beqz	a7,ffffffffc0205624 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc020558e:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0205592:	0a044d63          	bltz	s0,ffffffffc020564c <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0205596:	8622                	mv	a2,s0
ffffffffc0205598:	8a66                	mv	s4,s9
ffffffffc020559a:	46a9                	li	a3,10
ffffffffc020559c:	bdcd                	j	ffffffffc020548e <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc020559e:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02055a2:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc02055a4:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02055a6:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02055aa:	8fb5                	xor	a5,a5,a3
ffffffffc02055ac:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02055b0:	02d74163          	blt	a4,a3,ffffffffc02055d2 <vprintfmt+0x29a>
ffffffffc02055b4:	00369793          	slli	a5,a3,0x3
ffffffffc02055b8:	97de                	add	a5,a5,s7
ffffffffc02055ba:	639c                	ld	a5,0(a5)
ffffffffc02055bc:	cb99                	beqz	a5,ffffffffc02055d2 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc02055be:	86be                	mv	a3,a5
ffffffffc02055c0:	00000617          	auipc	a2,0x0
ffffffffc02055c4:	13860613          	addi	a2,a2,312 # ffffffffc02056f8 <etext+0x28>
ffffffffc02055c8:	85a6                	mv	a1,s1
ffffffffc02055ca:	854a                	mv	a0,s2
ffffffffc02055cc:	0ce000ef          	jal	ra,ffffffffc020569a <printfmt>
ffffffffc02055d0:	b34d                	j	ffffffffc0205372 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02055d2:	00002617          	auipc	a2,0x2
ffffffffc02055d6:	f5660613          	addi	a2,a2,-170 # ffffffffc0207528 <syscalls+0x120>
ffffffffc02055da:	85a6                	mv	a1,s1
ffffffffc02055dc:	854a                	mv	a0,s2
ffffffffc02055de:	0bc000ef          	jal	ra,ffffffffc020569a <printfmt>
ffffffffc02055e2:	bb41                	j	ffffffffc0205372 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc02055e4:	00002417          	auipc	s0,0x2
ffffffffc02055e8:	f3c40413          	addi	s0,s0,-196 # ffffffffc0207520 <syscalls+0x118>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02055ec:	85e2                	mv	a1,s8
ffffffffc02055ee:	8522                	mv	a0,s0
ffffffffc02055f0:	e43e                	sd	a5,8(sp)
ffffffffc02055f2:	c29ff0ef          	jal	ra,ffffffffc020521a <strnlen>
ffffffffc02055f6:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02055fa:	01b05b63          	blez	s11,ffffffffc0205610 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc02055fe:	67a2                	ld	a5,8(sp)
ffffffffc0205600:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205604:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0205606:	85a6                	mv	a1,s1
ffffffffc0205608:	8552                	mv	a0,s4
ffffffffc020560a:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020560c:	fe0d9ce3          	bnez	s11,ffffffffc0205604 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205610:	00044783          	lbu	a5,0(s0)
ffffffffc0205614:	00140a13          	addi	s4,s0,1
ffffffffc0205618:	0007851b          	sext.w	a0,a5
ffffffffc020561c:	d3a5                	beqz	a5,ffffffffc020557c <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020561e:	05e00413          	li	s0,94
ffffffffc0205622:	bf39                	j	ffffffffc0205540 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0205624:	000a2403          	lw	s0,0(s4)
ffffffffc0205628:	b7ad                	j	ffffffffc0205592 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc020562a:	000a6603          	lwu	a2,0(s4)
ffffffffc020562e:	46a1                	li	a3,8
ffffffffc0205630:	8a2e                	mv	s4,a1
ffffffffc0205632:	bdb1                	j	ffffffffc020548e <vprintfmt+0x156>
ffffffffc0205634:	000a6603          	lwu	a2,0(s4)
ffffffffc0205638:	46a9                	li	a3,10
ffffffffc020563a:	8a2e                	mv	s4,a1
ffffffffc020563c:	bd89                	j	ffffffffc020548e <vprintfmt+0x156>
ffffffffc020563e:	000a6603          	lwu	a2,0(s4)
ffffffffc0205642:	46c1                	li	a3,16
ffffffffc0205644:	8a2e                	mv	s4,a1
ffffffffc0205646:	b5a1                	j	ffffffffc020548e <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0205648:	9902                	jalr	s2
ffffffffc020564a:	bf09                	j	ffffffffc020555c <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc020564c:	85a6                	mv	a1,s1
ffffffffc020564e:	02d00513          	li	a0,45
ffffffffc0205652:	e03e                	sd	a5,0(sp)
ffffffffc0205654:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0205656:	6782                	ld	a5,0(sp)
ffffffffc0205658:	8a66                	mv	s4,s9
ffffffffc020565a:	40800633          	neg	a2,s0
ffffffffc020565e:	46a9                	li	a3,10
ffffffffc0205660:	b53d                	j	ffffffffc020548e <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0205662:	03b05163          	blez	s11,ffffffffc0205684 <vprintfmt+0x34c>
ffffffffc0205666:	02d00693          	li	a3,45
ffffffffc020566a:	f6d79de3          	bne	a5,a3,ffffffffc02055e4 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc020566e:	00002417          	auipc	s0,0x2
ffffffffc0205672:	eb240413          	addi	s0,s0,-334 # ffffffffc0207520 <syscalls+0x118>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205676:	02800793          	li	a5,40
ffffffffc020567a:	02800513          	li	a0,40
ffffffffc020567e:	00140a13          	addi	s4,s0,1
ffffffffc0205682:	bd6d                	j	ffffffffc020553c <vprintfmt+0x204>
ffffffffc0205684:	00002a17          	auipc	s4,0x2
ffffffffc0205688:	e9da0a13          	addi	s4,s4,-355 # ffffffffc0207521 <syscalls+0x119>
ffffffffc020568c:	02800513          	li	a0,40
ffffffffc0205690:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205694:	05e00413          	li	s0,94
ffffffffc0205698:	b565                	j	ffffffffc0205540 <vprintfmt+0x208>

ffffffffc020569a <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020569a:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc020569c:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02056a0:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02056a2:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02056a4:	ec06                	sd	ra,24(sp)
ffffffffc02056a6:	f83a                	sd	a4,48(sp)
ffffffffc02056a8:	fc3e                	sd	a5,56(sp)
ffffffffc02056aa:	e0c2                	sd	a6,64(sp)
ffffffffc02056ac:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02056ae:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02056b0:	c89ff0ef          	jal	ra,ffffffffc0205338 <vprintfmt>
}
ffffffffc02056b4:	60e2                	ld	ra,24(sp)
ffffffffc02056b6:	6161                	addi	sp,sp,80
ffffffffc02056b8:	8082                	ret

ffffffffc02056ba <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc02056ba:	9e3707b7          	lui	a5,0x9e370
ffffffffc02056be:	2785                	addiw	a5,a5,1
ffffffffc02056c0:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc02056c4:	02000793          	li	a5,32
ffffffffc02056c8:	9f8d                	subw	a5,a5,a1
}
ffffffffc02056ca:	00f5553b          	srlw	a0,a0,a5
ffffffffc02056ce:	8082                	ret
