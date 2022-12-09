# pb 1. daca intr-un vector toate elem sunt distincte. vector de frecventa
.data
    formatScanf: .asciz "%d"
    formatPrintf1: .asciz "Elementele vectorului nu sunt distincte 2 cate 2, primul element dublat este %d\n"
    formatPrintf2: .asciz "Elementele sunt distincte 2 cate 2\n"
    n: .space 4
    k: .space 4
    aux: .space 4
    sir: .space 80000
    unu: .long 1
.text
.globl main
main:
    lea sir, %esi

    pushl $n 
    pushl $formatScanf
    call scanf 
    pop %eax
    pop %eax

    pushl $k 
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

    mov aux, %ecx
    mov (%esi,%ecx,4), %eax
    inc %eax
    mov %eax, (%esi,%ecx,4)
    

    pop %ecx
    inc %ecx
    jmp loop_read
fin_loop_read:



    xor %ecx, %ecx
loop:
    cmp n, %ecx # aici  trebuia k
    je fin_loop 
    
    mov (%esi,%ecx,4), %eax
    cmp %eax, unu
    jae et_ok

    pushl %ecx
    pushl $formatPrintf1
    call printf
    pop %eax
    pop %eax
    jmp et_exit
et_ok:
    inc %ecx
    jmp loop
fin_loop:    


    pushl $formatPrintf2
    call printf
    pop %eax
et_exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
