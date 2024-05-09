//C_UART_Rx1_Toggling_LED1

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	
	//set up UART
	UCA1CTLW0 |= UCSWRST;		//Put UART A1 into SW reset
	UCA1CTLW0 |= UCSSEL__SMCLK;	//BRCLK = SMCLK (115200 baud)
	
	UCA1BRW = 8; 			//set prescaler to 8
	UCA1MCTLW |= 0xD600; 		//set modulation & low freq
	
	//set up pins 
	P4SEL1 &= ~BIT2;		//want p4.3 to use UART A1 Rx
	P4SEL0 |= BIT2;			//P4SEL1.3 : P4SEL0.4 = 01
	
	P1DIR |= BIT0;			//set P1.0 to output (LED1)
	P1OUT &= ~BIT0;			//turn off LED1 initially
	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio (I/O)
	
	UCA1CTLW0 &= ~UCSWRST;		//take UART A1 out of SW reset
	
	//set up IRQ A1 RXIFG
	UCA1IE |= UCRXIE; 		//local enable for A1 RXIFG
	__enable_interrupt();		//global en for maskable
	
	//main loop
	int i; 
	while(1){
	}
	
	return 0;
}

//ISRs
#pragma vector = EUSCI_A1_VECTOR
__interrupt void EUSCI_A1_RX_ISR(void){
	//Press t to toggle LED1
	if (UCA1RXBUF == 't'){
		P1OUT ^= BIT0; 		//toggle LED1 
	}

}