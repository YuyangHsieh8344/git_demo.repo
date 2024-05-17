	//data segment
	.data 
	.global __do_copy_data

//data memory start at address 0x4000
//0x11 is written to 0x4000
//0x22 is written to 0x4001
//byte is 8 bits
var1: .byte 0x11, 0x22 

//word is 16 bits => 0x0033 in 0x4002~0x4004, 0x0044 in 0x4004~0x4006
var2: .word 0x0033, 0x0044

str1: .byte 'd', 'o', 'g', 0x00

//.ascii can initalize a string of char but won't automatically add the null
str2: .ascii "dog\0"

	//text segment
	.text

