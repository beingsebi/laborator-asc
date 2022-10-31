.data
   a: .long 1
   b: .long -1
   c: .long 0
   min: .space 4
.text

.globl main
main:
    
    movl a, %eax
    movl b, %ebx

    cmp %eax, %ebx
    jle blea

    movl %eax, min 
    jmp endif1
blea:
    movl %ebx, min
endif1:

    movl c, %eax
    movl min, %ebx

    cmp %eax, %ebx
    jle final
    movl %eax, min

final:
    mov $1, %eax
    mov $0, %ebx
    int $0x80