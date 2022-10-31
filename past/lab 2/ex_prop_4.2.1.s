.data
    x: .long 40
    y: .long 1
    rez1: .long 0 
    op: .long 16
    prod: .space 4
    cat: .space 4
    rez2: .space 4
    okay: .asciz "\nPASS\n"
    notokay: .asciz "\nFAIL\n"
.text

.globl main
main:
    
    mov $0, %edx
    mov  x, %eax
    idiv op
    movl %eax, cat

    mov $0, %edx
    mov  y, %eax
    imul op

    add cat, %eax
    movl %eax, rez1



    shr $4, x
    shl $4, y
    mov x, %eax
    add y, %eax
    mov %eax, rez2

    mov rez1, %eax
    mov rez2, %ebx
    cmp %eax, %ebx
    je etiq
    mov $4, %eax
    mov $1, %ebx
    mov $notokay, %ecx
    mov $11, %edx
    int $0x80
    jmp final
etiq:
    mov $4, %eax
    mov $1, %ebx
    mov $okay, %ecx
    mov $7, %edx
    int $0x80


final:
    mov $1, %eax
    mov $0, %ebx
    int $0x80