//C_SPI_Rx1_Hex_on_A0
Receiving a Byte as a SPI Master

int Rx_Data;

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	
	//set up SPI A0
	UCA0CTLW0 |= UCSWRST;		//put A0 into SW reset
	UCA0CTLW0 |= UCSSEL__SMCLK; 	//choose SMCLK	
	UCA0BRW = 10;			//set prescaler to get SCLK = 1M/10 = 100kHz
	
	UCA0CTLW0 |=  UCSYNC;		//put A0 into SPI mode
	UCA0CTLW0 |= UCMST;		//put into SPI master (sent a clk to master)
	
	//configure ports
	P1DIR |= BIT0;			//set p1.0 (LED1) to output 
	P1OUT &= ~BIT0;			//LED1 = OFF initially

	P6DIR |= BIT6;			//set p6.6 (LED2) to output 
	P6OUT &= ~BIT6;			//LED2 = OFF initially
	
	P4DIR &= ~BIT1;			//set p4.1 (SW1) to input 
	P4REN |= BIT1;			//turn on resistor
	P4OUT |= BIT1;			//makes resistor a pull up
	P4IES |= BIT1;			//make sensitive to H-to-L

	P2DIR &= ~BIT3;			//set p2.3 (SW2) to input 
	P2REN |= BIT3;			//turn on resistor
	P2OUT |= BIT3;			//makes resistor a pull up
	P2IES |= BIT3;			//make sensitive to H-to-L

	P1SEL1 &= ~BIT5;		//P1.5 = SCLK (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT5;	
	
	P1SEL1 &= ~BIT7;		//P1.7 = SIMO (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT7;	

	P1SEL1 &= ~BIT6;		//P1.6 = SOMI (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT6;	
	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio (I/O)
	UCA0CTLW0 &= ~UCSWRST;		//take A0 out SW reset
	
	//set up IRQs
	P4IE |= BIT1;			//enable P4.1 IRQ (SW1)
	P4IFG &= ~BIT1;			//clear flag
	
	P2IE |= BIT3;			//enable P2.2 IRQ (SW2)
	P2IFG &= ~BIT3;			//clear flag
	

	UCA0IE |= UCRXIE;		//enable SPI Rx IRQ
	UCA0IFG &= ~UCRXIFG;		//clear flag
	
	__enable_interrupt();		//enable maskable IRQs
	
	while(1){
	}

	return 0;
}

//ISR
//ISR for SW1
#pragma vector = PORT4_VECTOR
__interrupt void ISR_Port4_S1(void){

	UCA0TXBUF = 0x10;		//Tx 0x10 out over SPI
	P4IFG &= ~BIT1;			//clear flag for p4.1
}

//ISR for SW2
#pragma vector = PORT2_VECTOR
__interrupt void ISR_Port2_S2(void){

	UCA0TXBUF = 0x66;		//Tx 0x66 out over SPI
	P2IFG &= ~BIT3;			//clear flag for p2.3
}

//DATA is in A0 SPI buffer
#pragma vector = EUSCI_A0_VECTOR
__interrupt void ISR_EUSCI_A0(void){

	Rx_Data = UCA0RXBUF;		//read Rx buffer
	if (Rx_Data == 0x10){
		P1OUT ^= BIT0; 		//Toggle LED1
	}else if (Rx_Data == 0x66){
		P6OUT ^= BIT6; 		//Toggle LED2
	}

	UCA1IFG &= ~UCTXCPTIFG;		//clears Tx complete flag
}