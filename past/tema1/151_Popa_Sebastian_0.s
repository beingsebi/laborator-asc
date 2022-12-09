.data
    formatScanf: .asciz "%d"
	cerinta: .space 4
	n: .space 4
	aux: .space 4
	dims: .space 500
.text

# ##################################################
# function to read an integer                     ##
# takes one parameter from the top of the stack,   #
# the address where you want to store the read nr  #
read_int:                                          #
	push %ebp                                      #
	mov %esp, %ebp                                 #
	                                               #
	pusha                                          #
	push 8(%ebp)                                   #
	pushl $formatScanf                             #
	call scanf                                     #
	pop %eax                                       #
	pop %eax                                       #
	popa                                           #
	pop %ebp                                       #
ret                                                #
# ##################################################

.globl  main
main:
    # ##############
	# read cerinta #
	pushl $cerinta #
	call read_int  #
	pop %eax       #
	# ##############

    # #############
	# read n ######
	pushl $n	  #
	call read_int #
	pop %eax	  #
	# #############

    # ##################################
	# read nr legaturi pt fiecare nod ##
	lea dims, %esi					   #
	xor %ecx, %ecx  			       #
loop_read:   						   #
	cmp %ecx, n  					   #
	je fin_loop_read  				   #
									   #
	pushl $aux  					   #
	call read_int  					   #
	pop %edx  						   #
	mov aux, %eax  					   #
	mov %eax, (%esi,%ecx,4)  		   #
									   #
	inc %ecx						   #
	jmp loop_read					   #
fin_loop_read:						   #
	# ##################################


et_exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80
