###########################################################
#	Michael Strand
#	2/12/21

###########################################################
#		Program Description
	
#	This program will take user input of odd integers between
#	1-25 inclusive. A cardinal value of -1 when input will
#	stop the program and display data about the previous run.
#	The data will include the total sum of valid integers
#	input, the count of valid integers, the average of valid
#	integers, and the remainder of the average.
###########################################################
#		Register Usage
#	$t0 = temp counter
#	$t1 = counter base address
#	$t2 = cardinal number 
#	$t3 = sum of integers
#	$t4	= 1
#	$t5	= 25
#	$t6 = temp sum
#	$t7 = 
#	$t8 = remainder base address
#	$t9 = average base address
###########################################################
		.data
counter: .word 0
avg: .word 0
sum: .word 0
remain: .word 0

greeting: .asciiz "\nPlease enter an ODD integer between 1 and 25. \nEnter -1 to end program."
error_msg: .asciiz "\nInvalid input. "
card_msg: .asciiz "\nYou entered -1. The program will now end."

input_sum: .asciiz "\nSum of valid input: "
input_count: .asciiz "\nValid input count: "
input_avg: .asciiz "\nAverage of inputs: "
input_rem: .asciiz "\nRemainder of input average: "

###########################################################
		.text
main:

	li $t2, -1					#load $t2 with cardinal value -1
	li $t4, 1					#load $t4 with value 1
	li $t5, 25					#load $t5 with value 25
	la $t1, counter				#base address for variable counter
	la $t3, sum					#base address for variable sum
	la $t8, remain				#base address for remainder
	la $t9, avg					#base address for average

	prompt:
		li $v0, 4				#begin print string system call
		la $a0, greeting		#load greeting 
		syscall

		li $v0, 5				#get user input
		syscall

		beq $t2, $v0, print		#if input = -1 end program
		
		bgt $v0, $t5, error		#branch to error msg for input > 25
		blt $v0, $t4, error		#branch to error msg for input < 1

		li $t7, 2				#load value 2 into $t7
		rem $t7, $v0, $t7		#get remainder of user input and $t7
		beqz $t7, error			#branch if remainder is 0

		add $t6, $t6, $v0		#add valid user inputs
		addi $t0, $t0, 1		#keep track of count

		b prompt				#loop back to prompt

	error:
		li $v0, 4				#start print string system call
		la $a0, error_msg		#print error msg for invalid input
		syscall

		b prompt				#loop back to prompt

	print:
		sw $t0, 0 ($t1)			#put count into counter variable
		sw $t6, 0 ($t3)			#put sum of input into sum variable

		li $t0, 2				#put value 2 into $t0
		div $t7, $t6, $t0		#divide the sum by 2, store in $t7
		sw $t7, 0 ($t9)			#store average in avg variable

		rem $t7, $t6, $t0		#get the remainder of the division
		sw $t7, 0 ($t8)			#store remainder in variable remain

		li $v0, 4				#start print string system call
		la $a0, card_msg		#print program end message
		syscall

		li $v0, 4				#start print string system call
		la $a0, input_sum		#print string
		syscall

		li $v0, 1				#start print int system call
		la $a0, sum				#load address of variable
		lw $a0, 0 ($a0)			#load int from variable
		syscall

		li $v0, 4				#start print string system call
		la $a0, input_count		#print string
		syscall

		li $v0, 1				#start print int system call
		la $a0, counter			#load address of variable
		lw $a0, 0 ($a0)			#load int from variable
		syscall

		li $v0, 4				#start print string system call
		la $a0, input_avg		#print string
		syscall

		li $v0, 1				#start print int system call
		la $a0, avg				#load address of variable
		lw $a0, 0 ($a0)			#load int from variable
		syscall

		li $v0, 4				#start print string system call
		la $a0, input_rem		#print string
		syscall

		li $v0, 1				#start print int system call
		la $a0, remain			#load address of variable
		lw $a0, 0 ($a0)			#load int from variable
		syscall

end:
	li $v0, 10		#End Program
	syscall
###########################################################

