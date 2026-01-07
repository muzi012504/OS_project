# 操作系统实验八报告


## 练习1：读文件操作实现

### 1 文件读操作流程分析

#### read 系统调用在内核中的调用链

```
用户态 read(fd, buf, count)
        ↓
syscall(SYS_read) → sys_read()
        ↓
file_read(file, buf, len, &file->fd_pos)
        ↓
vop_read(file->node, &iob)
        ↓
sfs_read(sfs_inode, &iob)
        ↓
sfs_io(sfs_inode, &iob, false)  // false 表示读操作
        ↓
sfs_io_nolock()  // 实际的块读写逻辑
```

具体调用链分析：

1. **sys_read()**：从用户态参数获取 fd，找到对应的 `struct file`，调用 `file_read`

2. **file_read()**：检查文件权限，更新文件偏移量，创建 `struct iobuf` 描述 I/O 操作，调用 `vop_read`

3. **vop_read()**：VFS 层的读操作接口，实际调用 `sfs_read`

4. **sfs_read()**：SFS 的读操作函数，包装 `sfs_io` 进行实际的 I/O

5. **sfs_io()**：带锁保护的 I/O 函数，处理 iobuf 的 offset 和 resid，调用 `sfs_io_nolock`

6. **sfs_io_nolock()**：核心的块读写逻辑，根据 offset 计算块号和块内偏移，进行多块数据的读写


### 2 sfs_io_nolock() 函数设计

#### 函数功能

`sfs_io_nolock()` 是 SFS 文件系统中最核心的 I/O 函数，负责在不加锁的情况下完成文件的读写操作。该函数处理了三种数据分布情况：

1. **首块未对齐数据**：offset 不在块边界时，需要读取从 offset 到块末尾的数据
2. **中间完整块数据**：offset 和 endpos 都对齐的情况，可以整块读写
3. **末块未对齐数据**：endpos 不在块边界时，需要读取从块起始到 endpos 的数据

#### 需要实现的核心逻辑

```c
static int
sfs_io_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, void *buf, 
              off_t offset, size_t *alenp, bool write) {
    // 1. 参数校验与边界处理
    // 2. 根据 write 标志选择读写函数指针
    // 3. 计算首块、中间块、末块的数量
    // 4. 处理首块未对齐数据
    // 5. 处理中间完整块
    // 6. 处理末块未对齐数据
    // 7. 更新文件大小（写操作时）
}
```

### 3 代码实现

#### offset 与 block 的计算

文件 offset 到磁盘块的转换是实现的关键：

```c
// 起始块号：offset / SFS_BLKSIZE
uint32_t blkno = offset / SFS_BLKSIZE;

// 块内偏移：offset % SFS_BLKSIZE
off_t blkoff = offset % SFS_BLKSIZE;

// 结束块号：endpos / SFS_BLKSIZE
uint32_t end_blkno = endpos / SFS_BLKSIZE;

// 需要读写的块数（不包括首块和末块）
uint32_t nblks = end_blkno - blkno;

// 首块需要读写的大小
size_t size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
```

#### 多块数据读取处理

```c
// 1. 处理首块（未对齐情况）
if (blkoff != 0) {
    size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
    
    // 加载逻辑块到物理块
    sfs_bmap_load_nolock(sfs, sin, blkno, &ino);
    
    // 读写块内部分数据（从 blkoff 开始，size 字节）
    sfs_buf_op(sfs, buf, size, ino, blkoff);
    
    alen += size;
    if (nblks == 0) goto out;  // 所有数据都在首块中
    
    buf += size;
    blkno++;
    nblks--;
}

// 2. 处理中间完整块
while (nblks != 0) {
    sfs_bmap_load_nolock(sfs, sin, blkno, &ino);
    sfs_block_op(sfs, buf, ino, 1);  // 读写完整块
    alen += SFS_BLKSIZE;
    buf += SFS_BLKSIZE;
    blkno++;
    nblks--;
}

// 3. 处理末块（未对齐情况）
if (endpos % SFS_BLKSIZE != 0) {
    sfs_bmap_load_nolock(sfs, sin, blkno, &ino);
    sfs_buf_op(sfs, buf, endpos % SFS_BLKSIZE, ino, 0);
    alen += endpos % SFS_BLKSIZE;
}
```

#### 内存缓冲区拷贝

- **用户态到内核态**：使用 `copy_from_user()` 安全地访问用户提供的缓冲区
- **内核态缓冲区**：使用 `memcpy()` 直接拷贝
- **块读写函数**：
  - `sfs_rbuf()`：从磁盘块读取数据到内存（参数：sfs, buf, len, blkno, blkoff）
  - `sfs_wbuf()`：将数据写入磁盘块
  - `sfs_rblock()`：读取完整磁盘块
  - `sfs_wblock()`：写入完整磁盘块


## 练习2：基于文件系统的执行程序机制

### 1 修改目标

将用户程序的加载方式从**固定内存位置**改为**从 SFS 文件系统动态读取**：

1. **文件系统集成**：通过 VFS 接口读取存储在磁盘上的 ELF 可执行文件
2. **动态加载**：运行时根据文件名打开并读取可执行文件
3. **内存映射**：将读取的代码段、数据段映射到进程的用户地址空间
4. **参数传递**：支持命令行参数的传递（argc, argv）

### 2 load_icode() 改写设计

#### 打开可执行文件

```c
int fd = open(path, O_RDONLY);
if (fd < 0) {
    goto bad_mm;
}
```

#### 读取 ELF 头

```c
struct elfhdr elf;
if ((ret = load_icode_read(fd, &elf, sizeof(elf), 0)) != 0) {
    goto bad_fd;
}

if (elf.e_magic != ELF_MAGIC) {
    ret = -E_INVAL;
    goto bad_fd;
}
```

#### 解析 Program Header

```c
struct proghdr ph;
for (int i = 0; i < elf.e_phnum; i++) {
    off_t phoff = elf.e_phoff + i * sizeof(ph);
    if ((ret = load_icode_read(fd, &ph, sizeof(ph), phoff)) != 0) {
        goto bad_fd;
    }
    
    if (ph.p_type == ELF_PT_LOAD) {
        // 处理可加载段
    }
}
```

#### 构建用户态地址空间

```c
// 1. 为 TEXT/DATA/BSS 段创建 VMA
if ((ret = mm_map(mm, ph.p_va, ph.p_memsz, 
                  PTE_U | PTE_W, NULL)) != 0) {
    goto bad_fd;
}

// 2. 为每个段分配物理页并读取数据
for (ph.p_filesz < ph.p_memsz) {
    void *page = pgdir_alloc_page(mm->pgdir, NULL, PTE_U | PTE_W);
    load_icode_read(fd, page, PGSIZE, ph.p_offset);
    // BSS 段清零
    if (ph.p_filesz < PGSIZE) {
        memset(page + ph.p_filesz, 0, PGSIZE - ph.p_filesz);
    }
}
```

#### 设置 trapframe 入口

```c
struct trapframe *tf = current->tf;
tf->epc = elf.e_entry;           // 程序入口点
tf->gpr.sp = stacktop;           // 用户栈指针
tf->gpr.a0 = argc;               // argc
tf->gpr.a1 = stacktop + argc * sizeof(char *);  // argv
tf->status = (read_csr(sstatus) | SSTATUS_SPIE) & ~SSTATUS_SPP;
```



## 扩展练习 Challenge1：基于 UNIX 的 PIPE 机制设计方案

### 方案设计

#### 1. 数据结构设计
管道的核心是基于内存的字节流缓冲区，需结合同步互斥机制（自旋锁/信号量）保证读写安全，同时关联文件系统抽象（与文件描述符体系兼容）。

```c
#include <spinlock.h>
#include <semaphore.h>

// 管道缓冲区大小（UNIX 经典值）
#define PIPE_BUF_SIZE 4096

// 管道核心数据结构
struct pipe_inode {
    // 管道数据缓冲区
    char buf[PIPE_BUF_SIZE];
    // 读指针：下一个要读取的字节位置
    int read_pos;
    // 写指针：下一个要写入的字节位置
    int write_pos;
    // 同步互斥：保护缓冲区的自旋锁（防止并发读写冲突）
    struct spinlock lock;
    // 同步：读信号量（缓冲区有数据时唤醒读进程）
    struct semaphore read_sem;
    // 同步：写信号量（缓冲区有空位时唤醒写进程）
    struct semaphore write_sem;
    // 引用计数：关联的文件描述符数量
    int ref_count;
    // 管道状态：是否有读端/写端（0 无，1 有）
    int read_open;
    int write_open;
};

// 兼容 ucore 文件系统的 file_operations 结构体
// 管道作为特殊文件，重载 read/write/close 等操作
struct file_operations pipe_fops = {
    .read = pipe_read,    // 管道读操作
    .write = pipe_write,  // 管道写操作
    .close = pipe_close,  // 管道关闭操作
};
```

### 2. 核心接口设计

| 接口名 | 语义描述 |
|--------|----------|
| `int pipe(int fd[2])` | 创建匿名管道，返回两个文件描述符：fd[0] 为读端，fd[1] 为写端。成功返回 0，失败返回错误码。创建时初始化 pipe_inode，设置 read_open/write_open 为 1，初始化锁和信号量。 |
| `ssize_t pipe_read(struct file *filp, char *buf, size_t count)` | 从管道读取数据：<br>1. 加锁，检查读端是否有效；<br>2. 若缓冲区为空且写端未关闭，阻塞在 read_sem；<br>3. 从 read_pos 读取数据到用户缓冲区，更新 read_pos；<br>4. 释放锁，唤醒等待的写进程（post write_sem）；<br>5. 返回实际读取的字节数，若写端关闭且缓冲区空则返回 0。 |
| `ssize_t pipe_write(struct file *filp, const char *buf, size_t count)` | 向管道写入数据：<br>1. 加锁，检查写端是否有效；<br>2. 若缓冲区满且读端未关闭，阻塞在 write_sem；<br>3. 从用户缓冲区写入数据到 pipe_inode 的 buf，更新 write_pos；<br>4. 释放锁，唤醒等待的读进程（post read_sem）；<br>5. 返回实际写入的字节数，若读端关闭则触发 SIGPIPE 信号并返回错误。 |
| `int pipe_close(struct file *filp)` | 关闭管道的读/写端：<br>1. 加锁，减少 ref_count；<br>2. 若关闭的是读端，设置 read_open=0，唤醒写进程；<br>3. 若关闭的是写端，设置 write_open=0，唤醒读进程；<br>4. 若 ref_count 为 0，释放 pipe_inode 资源；<br>5. 释放锁，返回 0。 |

### 3. 同步互斥处理
- **互斥**：通过 `spinlock` 保证对管道缓冲区（read_pos/write_pos/buf）的并发访问互斥，防止读写指针混乱。
- **同步**：
  - 读进程：缓冲区为空时，阻塞在 `read_sem`，等待写进程写入数据后唤醒。
  - 写进程：缓冲区满时，阻塞在 `write_sem`，等待读进程读取数据后唤醒。
- **异常处理**：若读端关闭后写进程继续写，触发 SIGPIPE；若写端关闭后读进程读完缓冲区数据，返回 EOF（0）。


## 扩展练习 Challenge2：基于 UNIX 的软连接和硬连接机制设计方案

### 设计方案

#### 1. 数据结构设计
硬连接复用原有 inode（通过引用计数实现），软连接需新增独立 inode 类型存储目标路径，均需通过锁保证 inode 操作的原子性。

```c
#include <spinlock.h>
#include <fs.h>

// inode 类型枚举（扩展 ucore 原有定义）
enum inode_type {
    INODE_REG,    // 普通文件
    INODE_DIR,    // 目录
    INODE_HARDLINK,// 硬连接（复用普通文件 inode，仅标识类型）
    INODE_SYMLINK // 软连接（符号链接）
};

// 基础 inode 结构（ucore 原有结构扩展）
struct inode {
    // 唯一标识（文件系统内）
    uint32_t ino;
    // 文件类型（包含硬/软连接）
    enum inode_type type;
    // 引用计数：硬连接数（核心，硬连接本质是增加该计数）
    int link_count;
    // 保护 inode 操作的自旋锁（同步互斥核心）
    struct spinlock lock;
    
    // 普通文件/目录数据（原有字段）
    size_t size;
    struct file_operations *fops;
    
    // 软连接特有字段：存储目标文件的路径（动态分配）
    char *symlink_target;
};

// 目录项结构（用于存储文件名与 inode 的映射，硬/软连接均依赖此）
struct dir_entry {
    // 文件名
    char name[256];
    // 对应的 inode 编号
    uint32_t ino;
    // 标识该目录项是否为硬/软连接
    enum inode_type entry_type;
};
```
### 2. 核心接口设计

| 接口名 | 语义描述 |
|--------|----------|
| `int link(const char *oldpath, const char *newpath)` | 创建硬连接：<br>1. 加锁（oldpath 对应的 inode 锁）；<br>2. 检查 oldpath 是否为目录（目录不允许创建硬连接，UNIX 规则）；<br>3. 查找 newpath 所在目录，新增 dir_entry，指向 oldpath 的 inode；<br>4. 增加 oldpath 对应 inode 的 link_count；<br>5. 释放锁，成功返回 0，失败返回错误码。 |
| `int symlink(const char *target, const char *linkpath)` | 创建软连接：<br>1. 为软连接创建新的 inode，类型设为 INODE_SYMLINK；<br>2. 加锁（新 inode 锁）；<br>3. 将 target 路径字符串存入 inode 的 symlink_target 字段；<br>4. 在 linkpath 所在目录新增 dir_entry，指向该新 inode；<br>5. 设置新 inode 的 link_count=1，释放锁；<br>6. 成功返回 0，失败返回错误码。 |
| `int unlink(const char *path)` | 删除硬/软连接：<br>1. 查找 path 对应的 dir_entry 和 inode，加 inode 锁；<br>2. 若为硬连接：减少 inode 的 link_count，删除 dir_entry；若 link_count 减至 0，释放 inode 及数据；<br>3. 若为软连接：删除 dir_entry，释放软连接 inode 的 symlink_target 内存，释放该 inode；<br>4. 释放锁，成功返回 0，失败返回错误码。 |
| `ssize_t readlink(const char *path, char *buf, size_t bufsize)` | 读取软连接目标路径：<br>1. 查找 path 对应的 inode，检查类型是否为 INODE_SYMLINK；<br>2. 加 inode 锁，将 symlink_target 复制到用户缓冲区 buf（最多 bufsize 字节）；<br>3. 释放锁，返回复制的字节数，失败返回错误码。 |

### 3. 同步互斥处理
- **互斥**：所有操作 inode 的接口（link/symlink/unlink/readlink）均需先获取对应 inode 的 `spinlock`，防止并发修改 link_count、symlink_target 等关键字段。
- **硬连接特殊处理**：修改 inode 的 link_count 时必须原子操作，避免多进程同时增减导致计数错误。
- **软连接循环检测**：解析软连接时（如 open 软连接路径），需限制递归深度（如最大 8 层），防止软连接循环引用导致死循环，检测到循环时返回 ELOOP 错误。





## 实验重要知识点与对应OS原理知识点的理解

| 实验核心知识点 | 具体内容 | 对应 OS 原理 |
|----------------|----------|--------------|
| 虚拟文件系统（VFS）抽象层 | 1. 定义 inode_ops 等函数指针结构体，统一 SFS、设备文件的访问接口<br>2. 上层 open/read/write 系统调用通过 VFS 转发，无需感知底层差异<br>3. 核心数据结构：inode（文件元信息）、file（进程-文件关联）、dentry（路径-索引节点映射） | 文件系统抽象与兼容性<br>1. VFS 作为内核子系统，屏蔽不同文件系统（Ext4、FAT、网络文件系统等）的实现差异<br>2. 为用户态提供统一的文件操作接口，是“一切皆文件”哲学的核心支撑<br>3. 索引节点（inode）与目录项（dentry）的分离设计，实现路径解析与文件元信息的解耦 |
| Simple File System（SFS）实现 | 1. 磁盘布局：超级块（sfs_super）→ 根目录 inode → 空闲块位图 → 数据块<br>2. 多级索引：直接索引（12 个块）+ 一级间接索引，支持最大 4MB 文件<br>3. 目录本质是特殊文件，存储 sfs_disk_entry 结构（文件名 + inode 号） | 磁盘文件系统的核心机制<br>1. 超级块：存储文件系统的全局元信息（块数、魔数、空闲块数），是文件系统的“身份证”<br>2. 索引节点机制：通过索引块映射文件数据，解决磁盘空间离散分配的寻址问题<br>3. 目录管理：目录作为文件存储子项的索引关系，实现文件的树形组织 |
| 设备文件映射 | 1. 将 stdin/stdout/disk0 封装为设备文件，实现 device 结构体及 d_io 接口<br>2. 设备 inode 的 in_type 标记类型，通过 dev_node_ops 关联读写逻辑<br>3. stdin 基于缓冲区 + 等待队列实现阻塞读，stdout 直接调用 cputchar 输出 | 设备抽象与文件接口统一<br>1. 设备文件系统（devfs）：将硬件设备映射为文件，通过标准文件接口完成设备 I/O，简化用户编程<br>2. 字符设备 vs 块设备：stdin/stdout 是字符设备（流式读写），disk0 是块设备（按块读写，需对齐）<br>3. 阻塞 I/O 模型：stdin 无数据时进程挂起，有数据时唤醒，是操作系统 I/O 调度的基础 |
| 系统调用与进程文件关联 | 1. sys_open 流程：路径解析 → 查找/创建 inode → 分配 file 结构 → 绑定进程 fd_array<br>2. read/write 通过 file->node 找到 inode，调用底层 vop_read/vop_write<br>3. 进程 files_struct 管理打开文件，fd 是 fd_array 的索引 | 进程文件描述符管理<br>1. 文件描述符（fd）：进程级的文件句柄，本质是内核文件表的索引，实现进程对文件的独立访问<br>2. 文件表与索引节点表分离：多个进程可通过不同 file 结构共享同一个 inode，实现文件共享<br>3. 系统调用的分层处理：用户态调用 → 系统调用封装 → VFS 层转发 → 底层文件系统/设备驱动执行 |
| 用户程序加载与 Shell 实现 | 1. do_execve 通过文件系统打开 ELF 文件，load_icode 读取文件内容并映射到进程地址空间<br>2. Shell 核心逻辑：readline 读取输入 → gettoken 解析命令 → fork+exec 执行程序 → waitpid 回收子进程<br>3. 支持重定向（</>）、命令分隔（;） | 程序执行与用户交互<br>1. exec 系列系统调用：替换进程的代码段和数据段，实现程序加载，依赖文件系统读取可执行文件<br>2. 进程创建与回收：fork 复制父进程上下文，exec 加载新程序，waitpid 实现父子进程同步<br>3. 命令行解释器（Shell）：用户与内核的交互界面，解析命令并转化为系统调用，是用户态的核心应用 |
| 同步互斥机制 | 1. 用信号量（semaphore）保护临界资源：如 vdev_list_sem 保护设备链表，disk0_sem 保护磁盘 I/O<br>2. inode 操作加锁（lock_sin），防止并发修改导致的元信息不一致 | 并发控制与临界区保护<br>1. 信号量与自旋锁：解决多进程/中断上下文对共享资源的竞争问题<br>2. 文件系统的原子性：保证元信息（如空闲块位图、inode 链接数）的修改是原子操作，避免数据损坏 |


## OS原理中重要但实验未覆盖的知识点
### 1. 日志文件系统与崩溃一致性
- 实验中的 SFS 是简单的非日志文件系统，若发生掉电或崩溃，可能导致元信息（如超级块、inode）与数据块不一致。而实际 OS 中的 Ext3/4、XFS 等采用日志（Journal）机制，先将修改写入日志区，再提交到数据区，保证崩溃后可恢复。

### 2. 文件系统缓存（Page Cache）
- 内核会将访问过的文件数据缓存到内存（页缓存），减少磁盘 I/O 次数；通过写回机制（Write-back）延迟写入磁盘，通过预读机制提升顺序读性能。

### 3. 硬链接与软链接的完整实现
- 硬链接是多个目录项指向同一个 inode（增加链接数），删除硬链接仅减少计数；软链接是独立文件，存储目标路径。实验指导手册提到了概念，但 SFS 未实现链接操作的系统调用（link/unlink/symlink）。

### 4. 网络文件系统（NFS/SMB）
- VFS 的核心优势之一是支持网络文件系统，将远程服务器的文件挂载到本地目录树，用户通过本地接口访问远程文件。

### 5. 文件权限与访问控制
- UNIX/Linux 文件系统通过权限位（rwx） 和用户/组 ID 实现访问控制，内核在 open/read/write 时检查进程权限。

### 6. 异步 I/O（AIO）
- 传统 read/write 是阻塞 I/O，而异步 I/O 允许进程发起 I/O 请求后继续执行，I/O 完成后通过信号或回调通知进程，提升高并发场景下的性能。