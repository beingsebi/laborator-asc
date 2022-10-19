.data
    hw: .ascii "Hello world!\n"
        len = . - hw
.text

.globl main
main:
    
    mov $4, %eax
    mov $1, %ebx
    mov $hw, %ecx
    mov $len, %edx 
    int $0x80

    mov $1, %eax
    mov $0, %ebx
    int $0x80