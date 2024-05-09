//TIMER CAPTURE on the MSP430FR2355 (SW Trig)


int WhatICaptured =0;  			//address is at 0x2000 data memory

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	//set up ports
	P1DIR |= BIT0;  		//set P1.0 to an output (LED1)
	P1OUT &= ~BIT0; 		//clear LED1 initially

	P4DIR &= ~BIT1;			//set P4.1 to input (SW1)
	P4REN |= BIT1;			//Enable resistor
	P4OUT |= BIT1;			//Makes resistor a pull-up
	P4IES |= BIT1;			//set IRQ sensitivity from H-to-L

	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio (digital I/O)


	//set up port IRQ
	P4IE |= BIT1;			//local enable for P4.1
	__enable_interrupt();		//enable maskable IRQ
	P4IFG &= ~BIT1;			//Clear Flag for P4IFG

	//set up timer
	TB0CTL |= TBCLR;		//reset timer
	TB0CTL |= TBSSEL__ACLK; 	//Clock = ACLK (32kHz)
	TB0CTL |= MC__CONTINUOUS; 	//Mode = continuous mode  
	TB0CTL |= ID__8;		//Divide by 8 in prescaler
	
	//set up Capture
	TB0CCTL0 |= CAP;		//put CCR0 into Capture mode
	TB0CCTL0 |= CM__BOTH;		//sensitive to both edges
	TB0CCTL0 |= CCIS__GND; 		//put capture input level at GND
	  
	
	
	while(1){
	}	

	return 0;
}

//--ISRs---------------------------------------------------------//
#pragma vector = PORT4_VECTOR
__interrupt void ISR_Port4_SW1(void)
{ 
	P1OUT ^= BIT0;			//Toggle LED1
	TB0CCTL0 ^= ~CCIS0;		//Switch back and forward btw GND and VCC
	WhatICaptured = TB0CCR0;	//store of captured value
	P4IFG &= ~BIT1;			//Clear Flag for P4IFG
}


