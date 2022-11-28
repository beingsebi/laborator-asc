.data
   sir: .space 400
   formatScanf: .asciz "%s"
   formatPrintf: .asciz "%d\n"
   len: .space 4
   cnt: .long 0
   
.text

.globl main
main:
   pushl $sir
   call gets 
   popl %eax


   pushl $sir
   call strlen
   popl %ebx
   mov %eax,len # strlen stores the answer in eax
   
   lea sir, %esi
   xorl %ecx, %ecx

loop:

   cmp len, %ecx
   je fin_loop

   xorl %eax, %eax
   movb (%esi, %ecx,1), %al

# 97, 101, 105, 111, and 117
   cmp $97, %eax
   je is_vowel
   cmp $101, %eax
   je is_vowel
   cmp $105, %eax
   je is_vowel
   cmp $111, %eax
   je is_vowel
   cmp $117, %eax
   je is_vowel
# 65, 69, 73, 79, and 85
   cmp $65, %eax
   je is_vowel
   cmp $69, %eax
   je is_vowel
   cmp $73, %eax
   je is_vowel
   cmp $79, %eax
   je is_vowel
   cmp $85, %eax
   je is_vowel
   
   jmp not_vowel
   is_vowel:
   inc cnt

   not_vowel:
   inc %ecx
   jmp loop

fin_loop:

   push cnt
   pushl $formatPrintf
   call printf 
   pop %eax
   pop %eax
   
et_exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
