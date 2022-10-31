.data
    x: .long 40
    y: .long 1
    rez: .long 0 
.text

.globl main
main:
    
    shr $4, x
    shl $4, y
    
    mov x, %eax
    add y, %eax

    mov %eax, rez

    mov $1, %eax
    mov $0, %ebx
    int $0x80