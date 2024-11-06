.data
prompt: .asciiz "Enter an operation (+ , - , * , / , ^): "
num1_prompt: .asciiz "Enter the first number: "
num2_prompt: .asciiz "Enter the second number: "
result_msg: .asciiz "Result: "
error_msg: .asciiz "Error: Can't Divide by Zero\n"
num1: .word 0
num2: .word 0

.text
.globl main
main:
li $v0, 4
la $a0, prompt
syscall

li $v0, 12
syscall
move $t0, $v0

li $v0, 11
la $a0, 10
syscall

li $v0, 4
la $a0, num1_prompt
syscall

li $v0, 5
syscall
sw $v0, num1

li $v0, 4
la $a0, num2_prompt
syscall

li $v0, 5
syscall
sw $v0, num2


li $t2, 43
beq $t0, $t2, Add
li $t2, 45	
beq $t0, $t2, Sub	
li $t2, 42
beq $t0, $t2, Mul	
li $t2, 47
beq $t0, $t2, Div	
li $t2, 94
beq $t0, $t2, Exp	

Add:
lw $t1, num1
lw $t2, num2
add $t0, $t1, $t2
j result 

Sub:
lw $t1, num1
lw $t2, num2
sub $t0, $t1, $t2
j result

Mul:
lw $t1, num1
lw $t2, num2
mul $t0, $t1, $t2
j result

Div:
lw $t1, num1
lw $t2, num2
li $t0, 0
beq $t2, $t0, err
div $t1, $t2
mflo $t0
j result

Exp:
li $t0, 1
lw $t1, num1
lw $t2, num2
li $t3, 0
j Exp_loop

Exp_loop:
beq $t3, $t2, result
mul $t0, $t0, $t1
addi $t3, $t3, 1
j Exp_loop

result:
li $v0, 4
la $a0, result_msg
syscall

li $v0, 1
move $a0, $t0
syscall

li $v0, 10
syscall

err:
li $v0, 4
la $a0, error_msg
syscall