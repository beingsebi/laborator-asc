.data
    formatScanf1: .asciz "%d%d"
    formatScanf2: .asciz "%d"
    formatPrintf: .asciz "%d\n"
    x: .space 4
    n: .space 4
    aux: .space 4
    vector: .space 400
    answer: .space 400
    k: .long 0
   
.text
.globl main
main:

# read n, x
    pushl $n
    pushl $x
    pushl $formatScanf1
    call scanf 
    pop %eax
    pop %eax
    pop %eax

    lea answer, %edi
    lea vector, %esi
    xorl %ecx, %ecx
loop_read:
    cmp %ecx, n
    je fin_loop_read

        push %ecx # read v[ecx]

        pushl $aux
        pushl $formatScanf2
        call scanf
        pop %eax
        pop %eax

        pop %ecx 

    mov aux, %eax
    mov %eax, (%esi, %ecx,4)

    inc %ecx
    jmp loop_read
fin_loop_read:

    xorl %ecx, %ecx
    xorl %ebx, %ebx
loop:
    cmp %ecx, n
    je fin_loop

    xor %edx, %edx
    mov (%esi, %ecx, 4),%eax
    idivl x

    cmp $0, %edx
    jne nu_multiplu
# multiplu
    mov (%esi, %ecx, 4), %eax
    mov %eax, (%edi, %ebx, 4)
    inc %ebx

nu_multiplu:  
    inc %ecx
    jmp loop
fin_loop:
    movl %ebx, k

    xorl %ecx, %ecx
loop_print:
    cmp %ecx, k
    je fin_loop_print

    push %ecx

    push (%edi, %ecx, 4)
    push $formatPrintf
    call printf
    pop %eax
    pop %eax
    pop %ecx    

    inc %ecx
    jmp loop_print
fin_loop_print:

et_exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
