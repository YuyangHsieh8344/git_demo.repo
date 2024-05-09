//sending ASC11 characters to a terminal
// (1/115200) = 8.6 µs


int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer

	//ser up UART A1
	UCA1CTLW0 |= UCSWRST;		//put into SW reset
	UCA1CTLW0 |= UCSSEL__SMCLK  	//Choose SMCLK = BRCLK (115200 baud) 
	UCA1BRW = 8; 			//Prescaler = 8
	//OS16(Oversampling mode with 16-bit)
	UCA1MCTLW = 0xD600		//OS16 = low freq, set modulation
	
	// P4.3 (port 4 bit 3)
	P4SEL &= ~BIT3;			//Change P4.3 function to A1 UART Tx
	P4SEL |= BIT3;			//P4SEL1.3 : P4SEL0.4 = 01 

	PM5CTL0 &= LOCKLPM5; 		//turn on gpio

	UCA1CTLW0 &= ~UCSWRST;		//clear UART A1 out of SW reset


	int i; 
	while(1){
		//01000001 = 0x41(hex) = 2^6 +1 = 65 (decimal) => waveform 
		////transmit ASCII code for 'A' over UART A1 Tx
		UCA1TXBUF = 'A'; 	
		for (i=0; i <10000; i++){	//delay between frame
		}
	}





	return 0;
}