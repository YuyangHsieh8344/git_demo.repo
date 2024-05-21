    .text
    .global main
main:
  //a = 4, b =10
  ldi r16, 0x04
  ldi r17, 0x0a  
  //use r18 for incrementing by 1
  ldi r18, 0x01
  
  
loop_test:
    cp r16, r17
    brge loop_end
    
    add r16, r18
    jmp loop_test
    
    
loop_end:
  
    ldi r16, 0x00

