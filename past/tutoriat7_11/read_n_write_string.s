.data
   sir: .space 101
   formatScanf: .asciz "%100[a-zA-Z .]"
   formatPrintf: .asciz "%s\n"
.text

.globl main
main:
    pushl $sir
    pushl $formatScanf
    call scanf 
    popl %edx
    popl %edx

   pushl $sir
   pushl $formatPrintf
   call printf
exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
