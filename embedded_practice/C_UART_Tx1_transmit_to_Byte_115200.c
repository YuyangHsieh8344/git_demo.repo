int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	
	//set up UART
	UCA1CTLW0 |= UCSWRST;		//Put UART A1 into SW reset
	UCA1CTLW0 |= UCSSEL__SMCLK;	//Choose SMCLK for UART A1
	
	UCA1BRW = 8; 			//set prescaler to 8
	UCA1MCTLW |= 0xD600; 		//configure modulation setting + low freq
	
	//set up ports 
	P4SEL1 &= ~BIT3;		//P4SEL1.3 : P4SEL0.4 = 01
	P4SEL0 |= BIT3;			//puts UART A1 Tx on P4.3
	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio
	
	UCA1CTLW0 &= ~UCSWRST;		//Put UART A1 into SW reset
	
	//main loop
	
	int i; 
	while(1){
		UCA1TXBUF = 0x4D; 		//send x4D out over UART A1
		for (i=0; i <10000; i++){	//delay between frame
		}
	}
	return 0;
}