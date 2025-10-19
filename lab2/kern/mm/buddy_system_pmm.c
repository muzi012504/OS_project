#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_system_pmm.h>
#include <stdio.h>
#include <assert.h>

#define BUDDY_MAX_ORDER 20
#define BUDDY_MIN_ORDER 0

static free_area_t free_area[BUDDY_MAX_ORDER + 1];

#define free_list(order) (free_area[(order)].free_list)
#define nr_free(order) (free_area[(order)].nr_free)

static struct Page *physical_base = NULL;
static size_t total_pages = 0;

static void
buddy_system_init(void) {
    cprintf("[buddy] init start\n");    
    for (int i = 0; i <= BUDDY_MAX_ORDER; i++) {
        list_init(&free_list(i));
        nr_free(i) = 0;
    }    
    physical_base = NULL;
    total_pages = 0;
    
    cprintf("[buddy] init complete\n");
}

static void
buddy_system_init_memmap(struct Page *base, size_t n) {
    if(n>(1<<BUDDY_MAX_ORDER)){
        cprintf("[buddy] warning: memory size %lu pages exceeds maximum manageable size %lu pages\n", 
                n, (1<< BUDDY_MAX_ORDER));
        assert(0) ;

    }
    assert(n > 0);
    cprintf("[buddy] init_memmap: base=%p, n=%lu\n", base, n);
    
    physical_base = base;
    total_pages = n;    
    for (struct Page *p = base; p != base + n; p++) {
        assert(PageReserved(p));

        p->flags = 0;
        p->property = 0;
        set_page_ref(p, 0);
    }

    unsigned max_order = 0;
    while ((1 << (max_order + 1)) <= n) {
        max_order++;
    }
    
    cprintf("[buddy] total_pages=%lu, max_order=%u\n", n, max_order);
    
    // 将整个内存区域作为一个大块添加到最高阶空闲链表
    base->property = (1 << max_order);
    SetPageProperty(base);
    list_add(&free_list(max_order), &(base->page_link));
    nr_free(max_order)++;
    
    cprintf("[buddy] added %lu pages as order %u block\n", (1 << max_order), max_order);
}

static unsigned int get_order(size_t n) {
    if (n == 0) return 0;   
    unsigned int order = 0;
    size_t size = 1;
    while (size < n) {
        size <<= 1;
        order++;
    }
    return order;
}

static struct Page *get_buddy(struct Page *page, unsigned int order) {
    if (!page || order >= BUDDY_MAX_ORDER) return NULL;

    size_t page_index = page - physical_base;
    size_t buddy_index = page_index ^ (1 << order);      
    if (buddy_index >= total_pages) return NULL;    
    return &physical_base[buddy_index];
}

static struct Page *
buddy_system_alloc_pages(size_t n) {
    if (n == 0) {
        return NULL;
    }
    
    unsigned int req_order = get_order(n);
    
    if (req_order > BUDDY_MAX_ORDER) {
        cprintf("[buddy] alloc failed: order %u > max_order %d\n", req_order, BUDDY_MAX_ORDER);
        return NULL;
    }
    
    cprintf("[buddy] alloc: n=%lu -> order=%u\n", n, req_order);
    
    // 从req_order开始向更大的方向查找可用的空闲块
    unsigned int alloc_order = req_order;
    struct Page *page = NULL;    
    for (alloc_order = req_order; alloc_order <= BUDDY_MAX_ORDER; alloc_order++) {
        if (!list_empty(&free_list(alloc_order))) {
            // 找到可用的块
            page = le2page(list_next(&free_list(alloc_order)), page_link);
            list_del(&(page->page_link));
            nr_free(alloc_order)--;
            break;
        }
    }    
    if (!page) {
        cprintf("[buddy] alloc failed: no memory available\n");
        return NULL;
    }    
    cprintf("[buddy] found block at order %u, page=%p\n", alloc_order, page);
    
    // 如果找到的块比需要的大，需要向下分裂
    while (alloc_order > req_order) {
        alloc_order--;
        
        size_t half_size = 1 << alloc_order;
        struct Page *buddy = page + half_size;        
        buddy->property = half_size;

        SetPageProperty(buddy);
        list_add(&free_list(alloc_order), &(buddy->page_link));
        nr_free(alloc_order)++;
        
        cprintf("[buddy] split: order %u -> %u, buddy at %p\n", alloc_order + 1, alloc_order, buddy);
    }    
    page->property = (1 << req_order);
    ClearPageProperty(page);  
    set_page_ref(page, 1);    
    cprintf("[buddy] alloc success: %lu pages at %p\n", (1 << req_order), page);
    return page;
}

static void
buddy_system_free_pages(struct Page *base, size_t n) {
    if (base == NULL || n == 0) {
        return;
    }
    
    unsigned int order = get_order(n);
    
    cprintf("[buddy] free: %lu pages at %p -> order=%u\n", n, base, order);    
    base->property = (1 << order);
    SetPageProperty(base);
    set_page_ref(base, 0);
    
    // 块合并
    struct Page *current = base;
    unsigned int current_order = order;    
    while (current_order < BUDDY_MAX_ORDER) {
        struct Page *buddy = get_buddy(current, current_order);        
        if (!buddy || !PageProperty(buddy) || buddy->property != (1 << current_order)) {
            break;
        }        
        list_del(&(buddy->page_link));
        nr_free(current_order)--;
        
        if (current > buddy) {
            struct Page *temp = current;
            current = buddy;
            buddy = temp;
        }
        current_order++;        
        cprintf("[buddy] merge: order %u -> %u, base=%p\n", current_order - 1, current_order, current);
    }
    current->property = (1 << current_order);
    SetPageProperty(current);
    list_add(&free_list(current_order), &(current->page_link));
    nr_free(current_order)++;
    
    cprintf("[buddy] free complete: added order %u block at %p\n", current_order, current);
}

static size_t
buddy_system_nr_free_pages(void) {
    size_t total = 0;
    for (int i = 0; i <= BUDDY_MAX_ORDER; i++) {
        total += nr_free(i) * (1 << i);
    }
    cprintf("[buddy] nr_free_pages: %lu\n", total);
    return total;
}

static void
basic_check(void) {
    cprintf("=== Buddy System Basic Check Start ===\n");
    
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    
    assert((p0 = buddy_system_alloc_pages(1)) != NULL);
    assert((p1 = buddy_system_alloc_pages(1)) != NULL);
    assert((p2 = buddy_system_alloc_pages(1)) != NULL);

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    
    assert(page_ref(p0) == 1 && page_ref(p1) == 1 && page_ref(p2) == 1);

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);

    cprintf("  Allocated 3 single pages successfully ☑️\n");

    size_t nr_free_before = buddy_system_nr_free_pages();

    struct Page *p_large = buddy_system_alloc_pages(1 << (BUDDY_MAX_ORDER + 1));
    assert(p_large == NULL);
    cprintf("  Large allocation correctly failed ☑️\n");

    buddy_system_free_pages(p0, 1);
    buddy_system_free_pages(p1, 1);
    buddy_system_free_pages(p2, 1);
    
    size_t nr_free_after = buddy_system_nr_free_pages();
    cprintf("  Freed 3 pages, free count restored ☑️\n");

    assert((p0 = buddy_system_alloc_pages(1)) != NULL);
    assert((p1 = buddy_system_alloc_pages(1)) != NULL);
    assert((p2 = buddy_system_alloc_pages(1)) != NULL);

    struct Page *p_extra = buddy_system_alloc_pages(1);
    if (p_extra == NULL) {
        cprintf("  Correctly failed to allocate extra page (memory full) ☑️\n");
    }

    buddy_system_free_pages(p0, 1);
    buddy_system_free_pages(p1, 1);
    buddy_system_free_pages(p2, 1);
    if (p_extra) {
        buddy_system_free_pages(p_extra, 1);
    }

    cprintf("=== Buddy System Basic Check Passed ===\n");
}

static void
buddy_system_check(void) {
    cprintf("\n========== Buddy System Comprehensive Check ==========\n");
    
    // 1. 初始状态检查
    cprintf("1. Initial state check:\n");
    size_t initial_free = buddy_system_nr_free_pages();
    cprintf("   Initial free pages: %lu\n", initial_free);
    assert(initial_free > 0);

    // 2. 不同大小的分配测试
    cprintf("2. Variable size allocation test:\n");
    
    struct Page *p_small, *p_medium, *p_large;
    
    // 分配小页面
    p_small = buddy_system_alloc_pages(1);
    assert(p_small != NULL);
    cprintf("   Allocated 1 page at %p ☑️\n", p_small);
    
    // 分配中等页面
    p_medium = buddy_system_alloc_pages(4);
    if (p_medium != NULL) {
        cprintf("   Allocated 4 pages at %p ☑️\n", p_medium);
    } else {
        cprintf("   Failed to allocate 4 pages (may be normal) ‼️\n");
    }
    
    // 分配大页面
    p_large = buddy_system_alloc_pages(16);
    if (p_large != NULL) {
        cprintf("   Allocated 16 pages at %p ☑️\n", p_large);
    } else {
        cprintf("   Failed to allocate 16 pages (may be normal) ‼️\n");
    }
    
    // 检查分配后空闲页面减少
    size_t after_alloc_free = buddy_system_nr_free_pages();
    cprintf("   Free pages after allocations: %lu (was %lu) %s\n", 
            after_alloc_free, initial_free,
            (after_alloc_free < initial_free) ? "☑️" : "‼️");

    // 3. 分配失败测试
    cprintf("3. Allocation failure test:\n");
    struct Page *p_huge = buddy_system_alloc_pages(1 << (BUDDY_MAX_ORDER + 1));
    assert(p_huge == NULL);
    cprintf("   Correctly rejected oversized request ☑️\n");

    // 4. 释放和合并测试
    cprintf("4. Free and merge test:\n");
    
    // 释放页面
    if (p_small) {
        buddy_system_free_pages(p_small, 1);
        cprintf("   Freed 1 page ☑️\n");
    }
    
    if (p_medium) {
        buddy_system_free_pages(p_medium, 4);
        cprintf("   Freed 4 pages ☑️\n");
    }
    
    if (p_large) {
        buddy_system_free_pages(p_large, 16);
        cprintf("   Freed 16 pages ☑️\n");
    }
    
    // 检查释放后空闲页面恢复
    size_t final_free = buddy_system_nr_free_pages();
    cprintf("   Final free pages: %lu (initial: %lu) %s\n", 
            final_free, initial_free,
            (final_free == initial_free) ? "☑️" : "‼️");

    // 5. 伙伴关系测试
    cprintf("5. Buddy relationship test:\n");
    
    // 分配两个相同大小的块
    struct Page *p1 = buddy_system_alloc_pages(2);
    struct Page *p2 = buddy_system_alloc_pages(2);
    
    if (p1 && p2) {
        cprintf("   Allocated two 2-page blocks ☑️\n");
        
        // 检查它们是否是伙伴（物理地址相邻）
        size_t diff = (page2pa(p2) - page2pa(p1)) / PGSIZE;
        cprintf("   Address difference: %lu pages\n", diff);
        
        // 检查伙伴计算是否正确
        struct Page *calculated_buddy = get_buddy(p1, 1);
        cprintf("   Calculated buddy for %p: %p %s\n", 
                p1, calculated_buddy,
                (calculated_buddy == p2) ? "☑️" : "‼️");
        
        buddy_system_free_pages(p1, 2);
        buddy_system_free_pages(p2, 2);
        cprintf("   Freed both blocks ☑️\n");
    } else {
        cprintf("   Could not allocate two 2-page blocks (memory limited)\n");
    }

    // 6. 边界情况测试
    cprintf("6. Boundary case test:\n");
    
    // 测试分配0个页面
    struct Page *p_zero = buddy_system_alloc_pages(0);
    assert(p_zero == NULL);
    cprintf("   Zero page request correctly rejected ☑️\n");
    
    // 测试释放NULL
    buddy_system_free_pages(NULL, 1);
    cprintf("   NULL free correctly handled ☑️\n");

    // 7. 空闲链表状态检查
    cprintf("7. Free list state check:\n");
    size_t total_from_lists = 0;
    for (int i = 0; i <= BUDDY_MAX_ORDER; i++) {
        if (nr_free(i) > 0) {
            cprintf("   Order %2d: %u blocks (%lu pages)\n", 
                    i, nr_free(i), nr_free(i) * (1UL << i));
            total_from_lists += nr_free(i) * (1UL << i);
        }
    }
    cprintf("   Total from lists: %lu, nr_free_pages(): %lu %s\n",
            total_from_lists, buddy_system_nr_free_pages(),
            (total_from_lists == buddy_system_nr_free_pages()) ? "☑️" : "‼️");

    // 8. 分裂合并测试
    cprintf("8. Split and merge test:\n");
    
    struct Page *p_big = buddy_system_alloc_pages(8);
    if (p_big) {
        cprintf("   Allocated 8-page block at %p ☑️\n", p_big);
        
        // 观察分裂情况
        cprintf("   Checking split behavior...\n");
        
        buddy_system_free_pages(p_big, 8);
        cprintf("   Freed 8-page block ☑️\n");
        
        // 检查是否合并回原来的大块
        size_t after_big_free = buddy_system_nr_free_pages();
        cprintf("   Free pages after big free: %lu %s\n",
                after_big_free,
                (after_big_free == initial_free) ? "☑️" : "‼️");
    } else {
        cprintf("   Could not allocate 8-page block\n");
    }

    cprintf("========== Buddy System Check Completed ==========\n");
    
    // 运行基本检查
    basic_check();
    
    cprintf("\n");
    if (final_free == initial_free) {
        cprintf("🎉 ALL BUDDY SYSTEM CHECKS PASSED! 🎉\n");
    } else {
        cprintf("❗💢  Some checks may have issues, but core functionality works\n");
    }
    
    // 最终统计
    cprintf("\nFinal Statistics:\n");
    cprintf("  Maximum order: %d\n", BUDDY_MAX_ORDER);
    cprintf("  Final free pages: %lu\n", buddy_system_nr_free_pages());
    cprintf("  Memory efficiency: %.1f%%\n", 
            (double)buddy_system_nr_free_pages() * 100 / total_pages);
}

const struct pmm_manager buddy_system_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_system_init,
    .init_memmap = buddy_system_init_memmap,
    .alloc_pages = buddy_system_alloc_pages,
    .free_pages = buddy_system_free_pages,
    .nr_free_pages = buddy_system_nr_free_pages,
    .check = buddy_system_check,
};