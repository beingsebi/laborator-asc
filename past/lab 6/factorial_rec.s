.data
   
.text

factorial: # (n)
	push %ebp
	mov %esp, %ebp

	cmp $1, 8(%ebp)
	jle unu

	mov 8(%ebp), %edx
	mov %edx, %ecx # n
	dec %edx # n-1

	push %ecx

	push %edx
	call factorial
	pop %edx

	xor %edx, %edx
	pop %ecx
	mull %ecx
	


jmp fin_unu
unu:
	mov $1, %eax
fin_unu:
	pop %ebp
ret


.globl main
main:

push $5
call factorial
pop %ecx

exit: 
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
