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

   pushl x
   pushl $formatPrintf
   call printf 
   popl %edx
   popl %edx 

exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80