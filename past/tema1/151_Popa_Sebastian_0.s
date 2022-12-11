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
	mres: .space 50000
	rezultat: .space 50000

    formatScanf: .asciz "%d"
	printfInt: .asciz "%d "
	printfEndl: .asciz "\n"
.text


# ###################################################
# function to read an integer            	        #
# read_int($x) give the address						#
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


# ###################################################
print_int:     # print_int(x)          	         	#
	push %ebp                                    	#
	mov %esp, %ebp                               	#
	pusha			# keep							#
		push 8(%ebp)								#
		push $printfInt								#
		call printf 								#
		addl $8, %esp								#		
													#
		pushl $0        							#
		call fflush 								#
		addl $4, %esp								#
	popa											#
	pop %ebp                                       	#
ret    # end_print_int							  	#
# ###################################################

# ###############################################
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
	# am in eax adresa 							#	
	# elementului matrice[i][j]#				#
			movl $0, (%eax) # pun 0 acolo   	#
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


# ###############################
iden_mat: # iden_mat($mat,n)	#
	push %ebp # done			#
	mov %esp, %ebp				#
								#
	push 12(%ebp) # n			#
	push 8(%ebp)  # mat			#
	call init_mat				#
	add $8, %esp  # pop			#
								#
	xor %ecx, %ecx # i			#
	for_iden:					#
	cmp %ecx, 12(%ebp)			#
	je end_for_iden				#
								#
		pushl 12(%ebp) # n		#
		push %ecx      # i		#
		push %ecx	   # i		#
		call get_index			#
		addl $12, %esp # pop	#
								#
		add 8(%ebp), %eax		#
		movl $1, (%eax)			#
								#
	inc %ecx					#
	jmp for_iden				#
	end_for_iden:				#
								#
	pop %ebp # done				#
ret		# end iden_mat			#
# ###############################


# #######################################
copy_mat: # copy_mat($a, $b, n) b<-a	#	
	push %ebp							#
	mov %esp, %ebp						#
	push %esi							#
	push %edi							#
										#
	mov 8(%ebp), %esi					#
	mov 12(%ebp), %edi					#
										#
	xor %edx, %edx						#
	mov 16(%ebp), %eax					#
	mull 16(%ebp)						#
										#
	xor %ecx, %ecx						#
	for_copy:							#
	cmp %ecx, %eax						#
	je end_for_copy						#
										#
	mov (%esi, %ecx, 4), %edx			#
	mov %edx, (%edi, %ecx, 4)			#
										#
	inc %ecx							#
	jmp for_copy						#
	end_for_copy:						#
										#
	pop %edi							#
	pop %esi							#
	pop %ebp							#
ret	# end copy_mat						#
# #######################################


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
	#	luam valoarea de la adresa 					#
	# aia din matrice								#
		movl (%eax), %eax							#
													#
		push %eax									#
		call print_int								#
		pop %eax									#
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


	subl $12, %esp # done
	push %esi # done
	push %edi # done

	mov 8(%ebp), %esi
	mov 12(%ebp), %edi
	
	pushl 20(%ebp) # n
	pushl 16(%ebp) # $mres
	call init_mat
	addl $8, %esp # pop

	#	-4(%ebp) i
	#	-8(%ebp) j
	#	-12(%ebp) k
	
	movl $0, -4(%ebp) # i
	for1:
	movl -4(%ebp), %eax
	cmpl %eax, 20(%ebp)
	je end_for1

		movl $0, -8(%ebp)  # j	
		for2:
		movl -8(%ebp), %eax
		cmpl %eax, 20(%ebp)
		je end_for2

			movl $0, -12(%ebp) # k
			for3:
			movl -12(%ebp), %eax
			cmpl %eax, 20(%ebp)
			je end_for3
				# mres[i][j]+=m1[i][k]*m2[k][j]
				pushl 20(%ebp) # n
				pushl -12(%ebp) # k
				pushl -4(%ebp) # i
				call get_index
				addl $12, %esp # pop
				
				add %esi, %eax
				mov (%eax), %eax
				push %eax # retin m1[i][k] done

				pushl 20(%ebp) # n
				pushl -8(%ebp) # j
				pushl -12(%ebp) # k
				call get_index
				addl $12, %esp # pop

				add %edi, %eax
				movl (%eax), %eax
				xor %edx, %edx 
				pop %ecx  # iau prima valoare de pe stiva done
				mull %ecx
				# am in eax ce trebuie sa adun rezultatul
				
				push %eax # retin pe stiva ce trb sa adun done

				pushl 20(%ebp) # n
				pushl -8(%ebp) # j
				pushl -4(%ebp) # i
				call get_index
				addl $12, %esp # pop

				add 16(%ebp), %eax
				# am in eax adresa la care trebuie sa pun rezultatul

				mov (%eax), %edx # am vechea valoarea de la (i,j) in edx
				pop %ecx # ce trebuie sa adun

				add %ecx, %edx # am noul rezultat in %edx

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
	addl $12, %esp # done
	pop %ebp # done
ret

.globl  main
main:

    # ####################
	# read cerinta 		 #
	pushl $cerinta       #
	call read_int 		 #
	pop %eax       	     #
	# ####################


    # ###################
	# read n 			#
	pushl $n	 		#
	call read_int 		#
	pop %eax	  		#
	# ###################


    # ##################################
	# read nr legaturi pt fiecare varf #
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


# #######################################
# citesc vecinii numerelor si  ##########
# pun in matricea de adiacenta			#
	pushl n								#
	pushl $mat							#
	call init_mat						#
	add $8, %esp # pop					#
										#
	xor %ecx, %ecx						#
	lea dims, %esi						#
	lea mat, %edi						#
loop_read_muchii:						#
	cmp %ecx, n							#
	je fin_loop_read_muchii				#
										#
	mov (%esi, %ecx,4), %eax			#
	mov %eax, aux						#
	# pun din vector in 				#
	# aux cati vecini am 				#
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
		add $12, %esp # pop				#
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


# ###########################################################
cerinta2:													#
															#
	# ##############										#
	# read lungime # 										#
	pushl $lungime # 										#
	call read_int  # 										#
	pop %eax       # 										#
	# ##############										#
															#
	# ##############										#
	# read sursa   #										#
	pushl $sursa   #										#
	call read_int  #										#
	pop %eax       #										#
	# ##############										#
															#	
	# #################										#
	# read destinatie #										#
	pushl $destinatie #										#
	call read_int     #										#
	pop %eax          #										#
	# #################										#
															#
															#
	# matricea iden #										#
	# in rezultat	#										#
	push n			#										#
	push $rezultat	#										#
	call iden_mat	#										#
	addl $8, %esp 	#										#
	# ###############										#
															#
															#
# ######################################					#
#   rezultat*=mat de lungime ori		#					#
	xor %ecx, %ecx						#					#
	loop_pow:							#					#
	cmp %ecx, lungime					#					#
	je fin_loop_pow						#					#
										#					#
	# rezultat= rezultat * mat			#					#
	# i.e.								#					#
	# matrix_mult(mat,rezultat,mresn)	#					#
	# mat_copy(mres,rezultat,n)			#					#
	push %ecx							#					#
		push n 							#					#
		push $mres						#					#
		push $mat						#					#
		push $rezultat					#					#
		call matrix_mult				#					#
		add $16, %esp					#					#
										#					#
		push n							#					#
		push $rezultat					#					#
		push $mres						#					#
		call copy_mat					#					#
		add $12, %esp					#					#
	pop %ecx							#					#
										#					#
	inc %ecx							#					#
	jmp loop_pow						#					#
	fin_loop_pow:						#					#
# #######################################					#
															#
															#
# ###################										#
# if u wanna see	#										#
# the entire matrix	#										#
#	push n			#										#
#	push $rezultat	#										#
#	call print_mat	#										#
#	add $8, %esp	#										#
# ###################										#
															#
															#
# ###################################						#
# print rezultat[sursa][destinatie] #						#
	push n							#						#
	push destinatie					#						#
	push sursa						#						#
	call get_index					#						#
	add $12, %esp					#						#
									#						#
	lea rezultat, %esi				#						#
	add %esi, %eax					#						#
	mov (%eax), %eax				#						#
	push %eax						#						#
	call print_int					#						#
	pop %eax						#						#
# ###################################						#
# ###########################################################														


# #######################						
et_exit:				#
	mov $1, %eax		#
	xorl %ebx, %ebx		#
	int $0x80			#
# #######################