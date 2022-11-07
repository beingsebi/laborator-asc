.data
   x: .space 4
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


    movl $0xffffffff, %eax
    movl x, %ebx
    imul %ebx 



   pushl %eax
   pushl $formatPrintf
   call printf 
   popl %edx
   popl %edx 
# ############## 2

    movl x, %eax
    not %eax
    inc %eax

    pushl %eax
    pushl $formatPrintf
    call printf 
    popl %edx
    popl %edx 
# ######### 3
    movl x, %eax
    neg %eax

    pushl %eax
    pushl $formatPrintf
    call printf 
    popl %edx
    popl %edx 
exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80