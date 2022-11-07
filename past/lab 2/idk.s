.data
   x: .long 17
   y: .long 6
   x1: .long 5
   y1: .long 9
   z: .space 4
.text

.globl main
main:
    mov x, %eax
    mov y, %ebx
    cmp %eax, %ebx
    jge et1
    mov x1, %eax
    cmp %eax, %ebx
    jle et
    mov x, %ebx
    sub %eax, %ebx
    jmp final
et:
    add %eax, %ebx
    jmp final
et1:
    mov x1, %eax
    mov y1, %ebx
    cmp %eax, %ebx
    jge et2
    add %eax, %ebx
    jmp final
et2:
    sub %eax, %ebx

final:
    mov %ebx, z
rr:
    mov $1, %eax
    mov $0, %ebx
    int $0x80

    


exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80