.data
    hw: .asciz "Hello world!\n"

.text

.globl main
main:
    
    mov $4, %eax
    mov $1, %ebx
    mov $hw, %ecx
    mov $13, %edx /*?? \n ->  +1 sau +2*/
    int $0x80

    mov $1, %eax
    mov $0, %ebx
    int $0x80