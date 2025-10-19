#ifndef __LIBS_LIST_H__
#define __LIBS_LIST_H__

#ifndef __ASSEMBLER__

#include <defs.h>

/* *
 * 简单双向链表的实现。
 *
 * 一些内部函数("__xxx")在操作整个链表而不是单个条目时很有用，
 * 因为有时我们已经知道下一个/前一个条目，通过直接使用它们
 * 而不是使用通用的单条目例程可以生成更好的代码。
 * */

// 链表节点结构
struct list_entry {
    struct list_entry *prev, *next;  // 前驱节点和后继节点指针
};

typedef struct list_entry list_entry_t;

// 函数声明
static inline void list_init(list_entry_t *elm) __attribute__((always_inline));
static inline void list_add(list_entry_t *listelm, list_entry_t *elm) __attribute__((always_inline));
static inline void list_add_before(list_entry_t *listelm, list_entry_t *elm) __attribute__((always_inline));
static inline void list_add_after(list_entry_t *listelm, list_entry_t *elm) __attribute__((always_inline));
static inline void list_del(list_entry_t *listelm) __attribute__((always_inline));
static inline void list_del_init(list_entry_t *listelm) __attribute__((always_inline));
static inline bool list_empty(list_entry_t *list) __attribute__((always_inline));
static inline list_entry_t *list_next(list_entry_t *listelm) __attribute__((always_inline));
static inline list_entry_t *list_prev(list_entry_t *listelm) __attribute__((always_inline));

static inline void __list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) __attribute__((always_inline));
static inline void __list_del(list_entry_t *prev, list_entry_t *next) __attribute__((always_inline));

/* *
 * list_init - 初始化一个新的链表节点
 * @elm: 要初始化的新节点
 * 功能：将节点的prev和next都指向自己，形成空循环链表
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
}

/* *
 * list_add - 添加一个新节点（在指定节点之后添加）
 * @listelm: 要添加到的链表头（在此节点之后添加）
 * @elm:     要添加的新节点
 * 功能：在指定节点之后插入新节点
 * */
static inline void
list_add(list_entry_t *listelm, list_entry_t *elm) {
    list_add_after(listelm, elm);
}

/* *
 * list_add_before - 在指定节点之前添加新节点
 * @listelm: 要添加到的链表头（在此节点之前添加）
 * @elm:     要添加的新节点
 * 功能：在指定节点之前插入新节点
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
}

/* *
 * list_add_after - 在指定节点之后添加新节点
 * @listelm: 要添加到的链表头（在此节点之后添加）
 * @elm:     要添加的新节点
 * 功能：在指定节点之后插入新节点
 * */
static inline void
list_add_after(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm, listelm->next);
}

/* *
 * list_del - 从链表中删除节点
 * @listelm: 要从链表中删除的节点
 * 功能：将节点从链表中移除，但节点本身的状态未定义
 * 注意：删除后对此节点调用list_empty()不会返回true
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
}

/* *
 * list_del_init - 从链表中删除节点并重新初始化它
 * @listelm: 要从链表中删除的节点
 * 功能：将节点从链表中移除，并重新初始化为空节点
 * 注意：删除后对此节点调用list_empty()返回true
 * */
static inline void
list_del_init(list_entry_t *listelm) {
    list_del(listelm);
    list_init(listelm);
}

/* *
 * list_empty - 测试链表是否为空
 * @list: 要测试的链表头
 * 返回值：true-链表为空，false-链表非空
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
}

/* *
 * list_next - 获取下一个节点
 * @listelm: 当前链表节点
 * 返回值：下一个节点的指针
 * */
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
}

/* *
 * list_prev - 获取前一个节点
 * @listelm: 当前链表节点
 * 返回值：前一个节点的指针
 * */
static inline list_entry_t *
list_prev(list_entry_t *listelm) {
    return listelm->prev;
}

/* *
 * __list_add - 在两个已知连续节点之间插入新节点（内部函数）
 * @elm:  要插入的新节点
 * @prev: 前一个节点
 * @next: 后一个节点
 * 功能：在prev和next之间插入elm节点
 * 注意：这是内部函数，需要调用者确保prev和next是连续的
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
    elm->next = next;
    elm->prev = prev;
}

/* *
 * __list_del - 通过使前驱/后继节点相互指向来删除链表节点（内部函数）
 * @prev: 要删除节点的前一个节点
 * @next: 要删除节点的后一个节点
 * 功能：将prev和next节点直接连接，跳过中间的节点
 * 注意：这是内部函数，需要调用者确保prev和next是连续的
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
    next->prev = prev;
}

#endif /* !__ASSEMBLER__ */

#endif /* !__LIBS_LIST_H__ */