.data
    x: .long 2
    y: .long 7
    sum : .space 4

.text

.globl main
main:
    mov x, %eax
    add y, %eax
    add $0x30, %eax
    mov %eax, sum

    mov $4, %eax
    mov $1, %ebx
    mov $sum, %ecx
    mov $1, %edx
    int $0x80

    mov $1, %eax
    mov $0, %ebx
    int $0x80