.data
   sir: .asciz "abcde"
   n: .long 5
   m: .space 4
   formatPrintf: .asciz "%s\n"
.text

.globl main
main:

   lea sir, %edi

   movl n, %eax
   movl %eax, m
   shr $1, m   # m=n/2
   
   xorl %ecx, %ecx
   mov n, %ebx
   dec %ebx # ebx=m - 1

   startloop:
      cmp %ecx, m
      je finloop
      movb (%edi, %ecx,1), %dl
      movb (%edi,%ebx,1), %al
      movb %al, (%edi, %ecx,1)
      movb %dl, (%edi,%ebx,1)


      inc %ecx
      dec %ebx
   finloop:

   pushl $sir
   pushl $formatPrintf
   call printf

exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
