.data
   x: .long 11
   ok: .long 1
   i: .long 2
   strok: .asciz "\nprim\n"
   strnok: .asciz "\nneprim\n"
.text

.globl main
main:

    movl x, %eax
    movl $2, %ebx
    cmp %eax, %ebx
    jge myet

start:
    movl x, %eax
    movl i, %ebx
    cmp %eax, %ebx

    jge final # ; if i>=x break

    mov $0, %edx
    mov x, %eax
    div i

    mov $0, %eax
    cmp %edx, %eax

    jne etiq
    mov $0,ok 
    jmp final
etiq:
    mov i, %eax
    add $1, %eax
    mov %eax, i
    jmp start

myet:
    mov $0, ok

final:

    mov ok, %eax
    mov $1, %ebx 
    cmp %eax, %ebx
    je etiq2
    mov $4, %eax
    mov $1, %ebx
    mov $strnok, %ecx
    mov $9, %edx
    int $0x80
    jmp exit
etiq2:
    mov $4, %eax
    mov $1, %ebx
    mov $strok, %ecx
    mov $7, %edx
    int $0x80


exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80