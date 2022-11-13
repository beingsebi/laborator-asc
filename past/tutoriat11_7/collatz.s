.data
   x: .space 4
   trei: .long 3
   formatScanf: .asciz "%d"
   formatPrintf: .asciz "%d\n"
.text

.globl main
main:
    pushl $x
    pushl $formatScanf
    call scanf 
    popl %edx
    popl %edx

myloop:
    movl x, %eax
    cmp $1, %eax
    je exit

    movl x, %edx
    and $1, %edx
    cmp $1, %edx 
    je impar
# par 
    movl x, %edx
    shr $1, %edx
    movl %edx, x
    jmp endif

impar:
    xorl %edx, %edx
    movl x, %eax
    mul trei
    inc %eax
    movl %eax, x
endif:
    pushl x
    pushl $formatPrintf
    call printf 
    popl %edx
    popl %edx 
    jmp myloop
   
exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
