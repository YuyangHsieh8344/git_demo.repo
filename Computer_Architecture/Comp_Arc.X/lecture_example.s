    .data 
    .global __do_copy_data
    
a: .byte 1
b: .byte 2
c: .byte 3
 
    .text
    .global main
    


//f2(int x)
f2: 
    // Save call-saved register
    push r28
    // Set up constant value 2 in r28
    ldi r28, 0x02
    // Move input parameter x (in r24) to a temporary register r18
    //r18 now has 0x02 
    mov r18, r24
    // Compute y = x + 2
    add r18, r28
    // Move result y back to r24 (as return value)
    //r18 now has 0x04
    mov r24, r18
    // Restore call-saved register
    pop r28
    ret

//f1(int v, int r) => r24 = a = v, r22 = b = r
f1:
    // Save r24 to stack (this is v)
    push r24
    // Prepare argument "x" for f2 (which should be r, in r22)
    mov r24, r22
    
    // Call f2(r)
    call f2
    
    // Move result of f2 (in r24) to r18
    mov r18, r24 
    // Restore the value of r24 (v) from stack
    pop r24
    // Compute z += v => r18 = r18 + r24
    add r18, r24
    // Move result z back to r24 (as return value)
    mov r24, r18 
    
    ret

main:
    // r18 - r27 and r30-r31 are call-used registers
    // Prepare argument "a"
    ldi r25, 0x00
    lds r24, a
    // Prepare argument "b"
    ldi r23, 0x00
    lds r22, b
    
    // Call f1(a, b)  
    call f1
    // Store result c in r24 to memory location of c
    sts c, r24
    
    // End of program
    ret
