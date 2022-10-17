.data
    var: .space 12
.text

.globl main
main:

    mov $3, %eax
    mov $1, %ebx
    mov $var, %ecx
    mov $12, %edx
    int $0x80

    mov $4, %eax
    mov $1, %ebx
    mov $var, %ecx
    mov $12, %edx
    int $0x80





    mov $1, %eax
    mov $0, %ebx
    int $0x80