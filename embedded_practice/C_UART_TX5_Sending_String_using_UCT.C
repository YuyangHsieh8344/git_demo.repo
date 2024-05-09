//C_UART_TX5_Sending_String_using_UCTXCPTIFG

char message[] = " Hello World ";
unsigned int position;

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer

	//ser up UART A1
	UCA1CTLW0 |= UCSWRST;		//put into SW reset
	UCA1CTLW0 |= UCSSEL__SMCLK  	//Choose SMCLK = BRCLK (115200 baud) 
	UCA1BRW = 8; 			//Prescaler = 8
	//OS16(Oversampling mode with 16-bit)
	UCA1MCTLW = 0xD600		//OS16 = low freq, set modulation
	
	// P4.1 (port 4 bit 1)
	P4DIR &= ~BIT1;			//Change P4.1 in input (SW1)
	P4REN |= BIT1;			//enable resistor
	//pull-up resistor pulls the signal line to a high logic level (VCC) 
	P4OUT |= BIT1;			// make it a pull up
	P4IES |= BIT1;			//Make IRQ sent H-to-L

	// P4.3 (port 4 bit 3)
	P4SEL &= ~BIT3;			//Change P4.3 function to A1 UART Tx
	P4SEL |= BIT3;			//P4SEL1.3 : P4SEL0.4 = 01	

	PM5CTL0 &= LOCKLPM5; 		//turn on gpio

	UCA1CTLW0 &= ~UCSWRST;		//clear UART A1 out of SW reset
	
	//enable IRQs
	P4IE |= BIT1;			//enable SW1 IRQ
	P4IFG &= ~BIT1;			//clear flag
	__enable_interrupt();		//global en IRQs

	int i; 
	while(1){
	
	} 

	return 0;
}

//ISR
#pragma vector = PORT4_VECTOR
__interrupt void ISR_Port4_S1(void){
	position = 0;
	UCA1IE |= UCTXCPIE; 		//turns on Tx complete IRQ
	UCA1IFG &= ~UCTXCPTIFG;		//clears Tx complete flag
	UCA1TXBUF = message[position];	//put first char from message to Tx buf
	
	P4IFG &= ~BIT1;			//clear flag for p4.1
}


#pragma vector = EUSCI_A1_VECTOR
__interrupt void ISR_EUSCI_A1(void){

	if (position == sizeof(message)){
		UCA1IE &= ~UCTXCPIE; 		//turns off Tx complete IRQ 
	}
	else{
		position++;
		UCA1TXBUF = message[position];	//put NEXT char from message to Tx buf
	}

	UCA1IFG &= ~UCTXCPTIFG;		//clears Tx complete flag
}