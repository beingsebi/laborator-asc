.data
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d\n"
    x: .space 4
   
.text

.globl main
main:
    pushl $x
    pushl $formatScanf
    call scanf
    pop %eax
    pop %eax
    
    movl $1, %ecx


loop:
    cmp x, %ecx
    jg fin_loop

    movl $0, %edx
    movl x, %eax    
    div %ecx

    cmp $0, %edx
    je divizor
    jmp ne_divizor
    
    divizor:
    push %ecx
    pushl $formatPrintf
    call printf
    pop %ecx 
    pop %ecx 
  
    ne_divizor:
    
    inc %ecx
    jmp loop
fin_loop:

et_exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
