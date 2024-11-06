.data
double_val: .double 3.14159        # Declare a double-precision value (64-bit)
single_val: .float 1.234           # Declare a single-precision value (32-bit)
result: .double 0.0                # Reserve space for the result

.text
.globl main
main:
    # Load double-precision value into $f0/$f1
    l.d $f0, double_val            # Load double from memory into $f0 and $f1
    
    # Load single-precision float into $f4
    lwc1 $f4, single_val           # Load single float into $f4
    
    # Perform a double-precision operation (e.g., add the double to itself)
    add.d $f2, $f0, $f0            # $f2/$f3 = $f0 + $f0 (double the value)
    
    # Print double-precision result in $f2/$f3
    mov.d $f12, $f2                # Move result to $f12 for printing
    li $v0, 3                      # Syscall to print a double-precision float
    syscall

    # Newline for readability
    li $v0, 11
    li $a0, 10                     # ASCII code for newline
    syscall

    # Perform a single-precision operation (e.g., add the single to itself)
    add.s $f6, $f4, $f4            # $f6 = $f4 + $f4 (double the value)

    # Print single-precision result in $f6
    mov.s $f12, $f6                # Move result to $f12 for printing
    li $v0, 2                      # Syscall to print a single-precision float
    syscall

    # Store the double-precision result back to memory
    s.d $f2, result                # Store the double result from $f2/$f3 into 'result'

    # Exit program
    li $v0, 10                     # Exit syscall
    syscall
