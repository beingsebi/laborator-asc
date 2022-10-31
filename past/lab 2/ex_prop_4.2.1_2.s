.data
    x: .long 40
    y: .long 1
    op: .long 16
    prod: .space 4
    cat: .space 4
    rez: .space 4
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
    movl %eax, rez

    mov $1, %eax
    mov $0, %ebx
    int $0x80