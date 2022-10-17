.data
    x: .long 23 /* x=23*/
    y: .long 71 /*y=71*/
    zece: .long 10
    lstd : .space 4 /* (x+y)%10*/

.text

.globl main
main:
    mov x, %eax
    add y, %eax /*eax = x+y*/
    
    mov zece, %ebx
    mov $0, %edx /*fara asta da FLOATING POINT EXCEPTION*/
    idiv %ebx /*edx = (x+y)%10*/
    mov %edx, %eax

    add $0x30, %eax /*transform in caracter*/
    mov %eax, lstd 

    mov $4, %eax /*afisez*/
    mov $1, %ebx
    mov $lstd, %ecx
    mov $1, %edx
    int $0x80

    mov $1, %eax
    mov $0, %ebx
    int $0x80