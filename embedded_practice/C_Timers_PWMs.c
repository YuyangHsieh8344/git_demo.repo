//Flashing LED1 with a 5% Duty Cycke PWM using multiple compares in C
//delta t = T.N 
//CCR0 =>  1s = (1/32.768K).N =>  N=32768   	LED1 set it to ON
//CCR1 =>  50ms = (1/32.768K).N =>  N= 1638  	LED1 set it to OFF (5% Duty Cycke)

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	//set up ports
	P1DIR |= BIT0;  		//set P1.0 to an output
	P1OUT |= ~BIT0; 		//set LED1 initially
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio

	//set up timer
	TB0CTL |= TBCLR;		//reset timer
	TB0CTL |= TBSSEL__ACLK; 	//Clock = ACLK (32kHz)
	TB0CTL |= MC__UP; 		//Mode = up mode for CCR0 (so CCR0 doesnt rolls the timer back to 0)
	TB0CCR0 = 32768;		//set CCR0 = 32768
	TB0CCR1 = 1638;			//set CCR1 = 1638
	  
	//set up Timer Compare IRQ
	TB0CCTL0 |= CCIE;		//local enable for CCR0
	TB0CCTL1 |= CCIE;		//local enable for CCR1
	__enable_interrupt();		//Enable maskable IRQs
	TB0CCTL0 &= ~CCIFG;		//Clear Flag for CCR0
	TB0CCTL1 &= ~CCIFG;		//Clear Flag for CCR1	

	//Main Loop
	while(1){			//Loop Forever
	} 


	return 0;
}

//--ISRs---------------------------------------------------------//
#pragma vector = TIMER0_B0_VECTOR
__interrupt void ISR_TB0_CCR0(void)
{ 
	P1OUT |= BIT0;			//Turn LED1 ON
	TB0CCTL0 &= ~CCIFG;		//Clear Flag for CCR0
	
}

#pragma vector = TIMER0_B1_VECTOR   	//ISR for Duty Cycle
__interrupt void ISR_TB0_CCR1(void)
{ 
	P1OUT &= BIT0;			//Turn LED1 OFF
	TB0CCTL1 &= ~CCIFG;		//Clear Flag for CCR1 (so it won't get stuck)

}

