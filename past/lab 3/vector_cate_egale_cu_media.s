# cate numere dintr-un vector sunt egale cu catul 
# mediei aritmetice a tuturor numerelor
.data
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d\n"
    n: .space 4
    aux: .space 4
    sir: .space 400
    sum: .long 0
    med: .space 4
    rez: .long 0
.text
.globl main
main:
    lea sir, %esi

    pushl $n 
    pushl $formatScanf
    call scanf 
    pop %eax
    pop %eax

    xorl %ecx, %ecx
loop_read:
    cmp n, %ecx
    je fin_loop_read

    push %ecx

    pushl $aux
    pushl $formatScanf
    call scanf
    pop %eax
    pop %eax

    pop %ecx

    mov aux, %eax
    add %eax, sum
    mov %eax, (%esi,%ecx,4)
    inc %ecx
    jmp loop_read
fin_loop_read:

    xor %edx, %edx
    mov sum, %eax
    div n 
    mov %eax, med

    xor %ecx, %ecx
loop:
    cmp %ecx, n
    je fin_loop

    mov (%esi,%ecx,4), %eax
    cmp %eax, med
    jne ne_egal
    inc rez
ne_egal:
    inc %ecx
    jmp loop
fin_loop:

    pushl rez
    pushl $formatPrintf
    call printf 
    

et_exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
