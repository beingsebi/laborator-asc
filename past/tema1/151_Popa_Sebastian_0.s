.data
	cerinta: .space 4
	n: .space 4
	aux: .space 4
	vecin: .space 4
	sursa: .space 4
	destinatie: .space 4
	lungime: .space 4
	dims: .space 500
	mat: .space 50000
	m1: .space 50000
	m2: .space 50000
	mres: .space 50000

    formatScanf: .asciz "%d"
	printfInt: .asciz "%d "
	printfEndl: .asciz "\n"
.text

# ###################################################
# function to read an integer            	        #
# takes one parameter from the top of the stack, 	#
# the address where you want to store the read nr	#
read_int:                             	         	#
	push %ebp                                    	#
	mov %esp, %ebp                               	#
	pusha  											#
				                                 	#
	push 8(%ebp)                                   	#
	pushl $formatScanf                             	#
	call scanf                                     	#
	add $8, %esp								   	#
								   				   	#
	popa                                           	#
	pop %ebp                                       	#
ret    # end_read_int							  	#
# ###################################################


# function to get index in array if given #######
# index = 4*n*lin + 4*col						#
# get_index(lin,col,n) 							#
get_index:    									#
	push %ebp									#
	mov %esp, %ebp								#
	push %ebx									#
												#
	mov 8(%ebp), %eax # lin						#
	mov 12(%ebp), %ebx # col					#
												#
	sal $2, %eax								#
	xor %edx, %edx								#
	mull 16(%ebp)								#
	sal $2, %ebx								#
	add %ebx, %eax								#
												#
	pop %ebx									#
	pop %ebp									#	
	# result is in %eax							#
ret		# end get_index				 			#
# ###############################################


# init_mat($mat,n) ##############################
init_mat: 										#
	push %ebp		# done						#					  
	mov %esp, %ebp								#
												#
	xor %ecx, %ecx # i							#
	for_init1:									#
	cmp %ecx, 12(%ebp)							#
	je end_for_init1							#
												#
		xor %edx, %edx # j						#
		for_init2:								#
		cmp %edx, 12(%ebp)						#
		je end_for_init2						#
												#
			push %ecx 							#
			push %edx							#
												#
			pushl 12(%ebp) # n					#
			pushl %edx # j						#
			pushl %ecx # i						#
			call get_index						#
			addl $12, %esp # pop				#
			add 8(%ebp), %eax					# 
	# am in eax adresa elementului matrice[i][j]#
			mov $0, (%eax) # pun 0 acolo   		#
												#
			pop %edx							#
			pop %ecx							#
												#
		inc %edx								#
		jmp for_init2							#
		end_for_init2:							#
												#
	inc %ecx									#	
	jmp for_init1								#
	end_for_init1:								#
												#
	pop %ebp # done								#
ret		# end init_mat							#
# ###############################################


# ###################################################
print_mat: # print_mat($mat,n)						#
	push %ebp # done								#
	mov %esp, %ebp									#
													#
	xor %ecx, %ecx									#
loop_print_line:									#
	cmp %ecx, 12(%ebp)								#
	je fin_loop_print_line							#
													#
	xor %edx, %edx									#
	loop_print_coloane:								#
		cmp %edx, 12(%ebp)							#
		je fin_loop_print_coloane					#
													#
	# punem in %eax indexul corespunzator			#
		push %ecx		# keep1						#
		push %edx		# keep2						#
													#
		pushl 12(%ebp)								#
		push %edx									#
		push %ecx									#
		call get_index								#
		addl $12, %esp # pop						#
		add 8(%ebp), %eax							#
													#
		pop %edx		# keep2						#
		pop %ecx		# keep1						#
													#
													#
	#	luam valoarea de la adresa aia din matrice	#
		movl (%eax), %eax							#
		# si o afisam								#
		pusha			# keep						#
		push %eax									#
		push $printfInt								#
		call printf 								#
		addl $8, %esp								#
		popa			# keep						#
													#
		inc %edx									#
		jmp loop_print_coloane						#
	fin_loop_print_coloane:							#
													#
	pusha		# keep								#
	push $printfEndl								#
	call printf 									#
	pop %eax										#
	popa		# keep								#
													#
	inc %ecx										#
	jmp loop_print_line								#
fin_loop_print_line:								#
													#
	pop %ebp # done									#
ret		# end print_mat								#
# ###################################################


matrix_mult: # (m1,m2,mres,n) 
			# mres= m1*m2
	
	push %ebp		# done							  
	mov %esp, %ebp	

	# 8(%ebp) -> m1
	# 12(%ebp) -> m2
	# 16(%ebp) -> mres
	# 20(%ebp) -> n

	subl $20, %esp # done
	push %esi # done
	push %edi # done

	lea m1, %esi
	lea m2, %edi
	
	pushl 20(%ebp) # n
	pushl 16(%ebp) # $mres
	call init_mat
	addl $8, %esp # pop

	movl $0, -4(%ebp)  # -> i
	movl $0, -8(%ebp)  # -> j	
	movl $0, -12(%ebp) # -> k
	#	-16(%ebp) aux1
	#	-20(%ebp) aux2
	for1:
	mov -4(%ebp), %eax
	cmp %eax, 20(%ebp)
	je end_for1

		for2:
		mov -8(%ebp), %eax
		cmp %eax, 20(%ebp)
		je end_for2

			for3:
			mov -12(%ebp), %eax
			cmp %eax, 20(%ebp)
			je end_for3

			# mres[i][j]+=m1[i][k]*m2[k][j]
			pushl 20(%ebp) # n
			pushl -12(%ebp) # k
			pushl -4(%ebp) # i
			call get_index
			addl $12, %esp # pop
			
			add %esi, %eax
			mov (%eax), %edx
			push %edx # retin valoarea

			pushl 20(%ebp) # n
			pushl -8(%ebp) # j
			pushl -12(%ebp) # k
			call get_index
			addl $12, %esp # pop

			add %edi, %eax
			mov (%eax), %edx

			mov %edx, %eax
			xor %edx, %edx 
			pop %ecx  # iau prima valoare de pe stiva
			mull %ecx
			# am in eax rezultatul
			
			push %eax # retin pe stiva


			pushl 20(%ebp) # n
			pushl -8(%ebp) # j
			pushl -4(%ebp) # i
			call get_index
			addl $12, %esp # pop

			push %esi
			lea mres, %esi
			add %esi, %eax
			pop %esi
			# am in eax adresa la care trebuie sa pun rezultatul

			mov (%eax), %edx # am vechea valoarea de la (i,j) in edx
			pop %ecx # ce trebuie sa adun

			add %ecx, %edx # am noul reezultat in %edx

			mov %edx, (%eax) # pun la loc in matrice
			

			incl -12(%ebp)
			jmp for3
			end_for3:

		incl -8(%ebp)
		jmp for2
		end_for2:

	incl -4(%ebp)
	jmp for1
	end_for1:

	pop %edi # done
	pop %esi # done 
	addl $20, %esp # done
	pop %ebp # done
ret

.globl  main
main:
    # ####################
	# read cerinta # #####
	pushl $cerinta # #####
	call read_int  # #####
	pop %eax       # #####
	# ####################


    # ###################
	# read n ###### #####
	pushl $n	  # #####
	call read_int # #####
	pop %eax	  # #####
	# ###################


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

	pushl n
	pushl $mat
	call init_mat
	add $8, %esp # pop

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
		pushl n							#
		push vecin						#
		push %ecx						#
		call get_index					#
		pop %ecx						#
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


	cmpl $1, cerinta
	jne cerinta2

# ###########################
cerinta1:	# doar printam	#
	pushl n					#
	pushl $mat				#
	call print_mat			#
	addl $8, %esp # pop		#
	jmp et_exit				#
# ###########################

cerinta2:

	# ####################
	# read lungime # #####
	pushl $lungime # #####
	call read_int  # #####
	pop %eax       # #####
	# ####################


	# ####################
	# read sursa   # #####
	pushl $sursa   # #####
	call read_int  # #####
	pop %eax       # #####
	# ####################


	# ####################
	# read destinatie   ##
	pushl $destinatie    #
	call read_int  # #####
	pop %eax       # #####
	# ####################

	###
	# init rezultat cu 0
	# pune 1 pe diag princ la rezultat
	# functie de copiat matrice dintr-o parte in alta

	xor %ecx, %ecx
	loop_pow:
	cmp %ecx, lungime
	je fin_loop_pow
	



	inc %ecx
	jmp loop_pow
	fin_loop_pow:


et_exit:
	mov $1, %eax
	xorl %ebx, %ebx
	int $0x80
