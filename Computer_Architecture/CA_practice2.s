    .text
    .global main
main:
    ldi r16, 0xaa
    
    //logical operation
    ldi r17, 0x01
    //r16 = r16 | r17
    //or | operation is useful for setting a bit
    //and & is use for clearing 
    or r16, r17
    
    //r17 = 0b0111_1111
    ldi r17, 0x7f
    and r16, r17
    
    //shifting left and right
    ldi r16, 0x04
    //shift left once (multiply by 2)
    lsl r16
    
    //shift right twice (divide by 4)
    lsr r16
    lsr r16
    
     //addition
    ldi r16, 0x05
    ldi r17, 0x01
    
    add r16, r17
    
    //subtraction
    sub r16, r17
    sub r16, r17
    
    //multiplication 
    ldi r16, 34
    ldi r17, 36
    
    //0x4C8
    mul r16, r17
    

