.data
	cerinta: .space 4
	n: .space 4
	aux: .space 4
	vecin: .space 4
	dims: .space 500
	mat: .space 40000
	formatScanf: .asciz "%d"
	printfInt: .asciz "%d "
	printfEndl: .asciz "\n"
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


# function to get index in array if given #########
# lin and col from matrix						  #
# index = 4*n*lin + 4*col						  #
# lin, col as arguments on the top of the stack   #
# function uses value of n from .data             #
get_index:    									  #
	push %ebp									  #
	mov %esp, %ebp								  #
	push %ebx									  #
												  #
	mov 8(%ebp), %eax # lin						  #
	mov 12(%ebp), %ebx # col					  #
												  #
	sal $2, %eax								  #
	xor %edx, %edx								  #
	mull n										  #
	sal $2, %ebx								  #
	add %ebx, %eax								  #
												  #
	pop %ebx									  #
	pop %ebp									  #	
	# result is in %eax							  #
ret												  #
# #################################################

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
	lea dims, %edi					   #
	xor %ecx, %ecx  			       #
loop_read_dims:   					   #
	cmp %ecx, n  					   #
	je fin_loop_read_dims  			   #
									   #
	pushl $aux  					   #
	call read_int  					   #
	pop %edx  						   #
	mov aux, %eax  					   #
	mov %eax, (%edi,%ecx,4)  		   #
									   #
	inc %ecx						   #
	jmp loop_read_dims   			   #
fin_loop_read_dims:					   #
	# ##################################


# citesc vecinii numerelor si  ##########
# pun in matrice						#
	xor %ecx, %ecx						#
	lea dims, %esi						#
	lea mat, %edi						#
loop_read_muchii:						#
	cmp %ecx, n							#
	je fin_loop_read_muchii				#
										#
	mov (%esi, %ecx,4), %eax			#
	mov %eax, aux						#
# pun din vector in aux cati vecini	am  #
	xor %eax, %eax						#
	loop_vecini:						#
		cmp %eax, aux					#
		je fin_loop_vecini				#
										#
		pushl $vecin					#
		call read_int					#  
		pop %ebx 						#   
										#
		# acum am muchia ecx->vecin	    #
		push %eax						#
		push %ecx						#
										#
		push vecin						#
		push %ecx						#
		call get_index					#
		pop %ecx						#
		pop %ecx						#
# pun in matrice 						#
		add %edi, %eax					#
		movl $1, (%eax)					#
										#
		pop %ecx						#
		pop %eax						#
										#
		inc %eax						#
		jmp loop_vecini					#
	fin_loop_vecini:					#
										#
	inc %ecx							#
	jmp loop_read_muchii				#
fin_loop_read_muchii:					#
#   #####################################


	cmp $1, cerinta
	jne cerinta2

# ###################################################
cerinta1:											#
	xor %ecx, %ecx									#
	lea mat, %esi									#
loop_print_line:									#
	cmp %ecx, n										#
	je fin_loop_print_line							#
													#
	xor %ebx, %ebx									#
	loop_print_coloane:								#
		cmp %ebx, n									#
		je fin_loop_print_coloane					#
													#
# punem in %eax indexul corespunzator				#
		push %ebx									#
		push %ecx									#
		call get_index								#
		pop %edx									#
		pop %edx									#
													#
		add %esi, %eax								#
													#
#	luam valoarea de la adresa aia din matrice		#
		movl (%eax), %eax							#
# si o afisam										#
		pusha										#
		push %eax									#
		push $printfInt								#
		call printf 								#
		pop %eax									#
		pop %eax									#
		popa										#
													#
		inc %ebx									#
		jmp loop_print_coloane						#
	fin_loop_print_coloane:							#
													#
	pusha											#
	push $printfEndl								#
	call printf 									#
	pop %eax										#
	popa											#
													#
	inc %ecx										#
	jmp loop_print_line								#
fin_loop_print_line:								#
# ###################################################


cerinta2:




et_exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80
