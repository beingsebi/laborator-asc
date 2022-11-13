.data
   sir: .long 5, 3, 88, 81, 10, 23, 88
   n: .long 7
   aux: .space 4
   ans: .space 4
   cnt: .space 4
   formatPrintf: .asciz "maximum is %d and it appeared %d times\n"
.text

.globl main
main:
   
   lea sir, %edi
   xorl %ecx, %ecx
   movl $0, ans
   
   startloop1:
   cmp %ecx, n
   je finloop1
      movl (%edi,%ecx,4), %edx
         cmp %edx, ans
         jae notbigger
         movl %edx, ans
         notbigger:
      inc %ecx
      jmp startloop1
   finloop1:

   mov $0, cnt
   xorl %ecx, %ecx

   startloop2:
   cmp %ecx, n
   je finloop2
      movl (%edi,%ecx,4), %edx
         cmp %edx, ans
         jne notequal
         inc cnt
         notequal:
      inc %ecx
      jmp startloop2
   finloop2:

   pushl cnt
   pushl ans
   pushl $formatPrintf
   call printf 
   popl %edx
   popl %edx 
   popl %edx 
exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
