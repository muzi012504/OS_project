#ifndef __KERN_MM_MEMLAYOUT_H__
#define __KERN_MM_MEMLAYOUT_H__

/* 所有物理内存映射到此地址 */
#define KERNBASE            0xFFFFFFFFC0200000 // = 0x80200000(物理内存中内核的起始位置, KERN_BEGIN_PADDR) + 0xFFFFFFFF40000000(偏移量, PHYSICAL_MEMORY_OFFSET)
// 将物理内存映射到虚拟内存空间的最后一段
#define KMEMSIZE            0x7E00000          // 物理内存的最大容量
// 0x7E00000 = 0x8000000 - 0x200000
// QEMU 默认RAM为 0x80000000到0x88000000, 128MiB, 0x80000000到0x80200000被OpenSBI占用
#define KERNTOP             (KERNBASE + KMEMSIZE) // 0x88000000对应的虚拟地址

#define PHYSICAL_MEMORY_END         0x88000000      // 物理内存结束地址
#define PHYSICAL_MEMORY_OFFSET      0xFFFFFFFF40000000 // 物理内存偏移量
#define KERNEL_BEGIN_PADDR          0x80200000      // 内核物理起始地址
#define KERNEL_BEGIN_VADDR          0xFFFFFFFFC0200000 // 内核虚拟起始地址

#define KSTACKPAGE          2                           // 内核栈中的页面数量
#define KSTACKSIZE          (KSTACKPAGE * PGSIZE)       // 内核栈大小

#ifndef __ASSEMBLER__

#include <defs.h>
#include <list.h>

typedef uintptr_t pte_t;    // 页表项类型
typedef uintptr_t pde_t;    // 页目录项类型

/* *
 * struct Page - 页面描述符结构。每个Page描述一个
 * 物理页面。在kern/mm/pmm.h中，你可以找到很多有用的函数
 * 用于将Page转换为其他数据类型，例如物理地址。
 * */
struct Page {
    int ref;                        // 页面帧的引用计数器
    uint64_t flags;                 // 描述页面帧状态的标志位数组
    unsigned int property;          // 空闲块中的页面数量，用于首次适应内存管理器
    list_entry_t page_link;         // 空闲链表链接
};

/* 描述页面帧状态的标志位 */
#define PG_reserved                 0       // 如果该位=1：页面被内核保留，不能在alloc/free_pages中使用；否则该位=0
#define PG_property                 1       // 如果该位=1：页面是空闲内存块的头页面（包含一些连续地址的页面），可以在alloc_pages中使用；如果该位=0：如果页面是空闲内存块的头页面，则该页面和内存块已被分配。或者该页面不是头页面。

#define SetPageReserved(page)       ((page)->flags |= (1UL << PG_reserved))      // 设置页面为保留状态
#define ClearPageReserved(page)     ((page)->flags &= ~(1UL << PG_reserved))     // 清除页面保留状态
#define PageReserved(page)          (((page)->flags >> PG_reserved) & 1)         // 检查页面是否保留
#define SetPageProperty(page)       ((page)->flags |= (1UL << PG_property))      // 设置页面属性标志
#define ClearPageProperty(page)     ((page)->flags &= ~(1UL << PG_property))     // 清除页面属性标志
#define PageProperty(page)          (((page)->flags >> PG_property) & 1)         // 检查页面属性标志

// 将链表条目转换为页面
#define le2page(le, member)                 \
    to_struct((le), struct Page, member)

/* free_area_t - 维护一个双向链表来记录空闲（未使用）页面 */
typedef struct {
    list_entry_t free_list;         // 链表头
    unsigned int nr_free;           // 此空闲链表中的空闲页面数量
} free_area_t;

#endif /* !__ASSEMBLER__ */

#endif /* !__KERN_MM_MEMLAYOUT_H__ */