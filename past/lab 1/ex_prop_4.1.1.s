.data
    x: .long 1
    y: .long 2
    afis: .space 4
.text

.globl main
main:
    
    mov x, %eax
    mov y, %ebx
    movl %eax, y
    movl %ebx, x

    # afisez pe y (si are intr-adevar  
    #        valoarea initiala a lui x)
    /* 
    mov y, %eax
    add $0x30, %eax # transform in caracter
    mov %eax, afis 
    mov $4, %eax # afisez
    mov $1, %ebx
    mov $afis, %ecx
    mov $1, %edx
    int $0x80 
    */
    
    mov $1, %eax
    mov $0, %ebx
    int $0x80