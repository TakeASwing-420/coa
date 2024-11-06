.data
array: .space 40                      # Allocate space for 10 integers (10 x 4 bytes)
msg_prompt: .asciiz "Enter 10 integers:\n"
msg_index: .asciiz "Enter integer"
msg_result: .asciiz "Array contents:\n"

.text
.globl main
main:
    # Print the prompt message
    li $v0, 4
    la $a0, msg_prompt
    syscall

    # Initialize loop counter for input
    li $t0, 0                        # $t0 will be our index for array
	li $t1, 40                       # Load 10 to compare with index

input_loop:
    # Check if we've read 10 integers
    beq $t0, $t1, display_array      # If $t0 == 10, go to display_array

    # Print "Enter integer <index>: "
    li $v0, 4
    la $a0, msg_index
    syscall

    # Print the index
    li $v0, 1
    move $a0, $t0
    syscall

    # Prompt user for integer input
    li $v0, 5                        # Syscall for integer input
    syscall
    sw $v0, array($t0)               # Store the integer in the array

    # Increment index and loop
    addi $t0, $t0, 4                 # Move to the next array element (next 4 bytes)
    j input_loop

display_array:
    # Print the result message
    li $v0, 4
    la $a0, msg_result
    syscall

    # Initialize loop counter for output
    li $t0, 0                        # Reset index for display loop
	li $t1, 40                       # End of array (10 integers * 4 bytes)

output_loop:
    # Check if we've printed all 10 integers
    beq $t0, $t1, exit               # If $t0 == 40, end the loop

    # Load the integer from the array and print it
    lw $a0, array($t0)               # Load integer from array
    li $v0, 1                        # Syscall to print integer
    syscall

    # Print a newline for readability
    li $v0, 11
    li $a0, 10                       # ASCII code for newline
    syscall

    # Increment index and loop
    addi $t0, $t0, 4                 # Move to next element in the array
    j output_loop

exit:
    # Exit the program
    li $v0, 10                       # Syscall to exit
    syscall
