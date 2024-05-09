//TOGGLING LED1 USING A CCR0 COMPARE IN C
//Toverflow = T.N=0.5s = (1/32kHz).N   
//solve N => N=16384	

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	//set up ports
	P1DIR |= BIT0;  		//set P1.0 to an output
	P1OUT &= ~BIT0; 		//clear LED1 initially
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio

	//set up timer
	TB0CTL |= TBCLR;		//reset timer
	TB0CTL |= TBSSEL__ACLK; 	//Clock = ACLK (32kHz)
	TB0CTL |= MC__UP; 		//Mode = up mode for CCR0
	TB0CCR0 = 16384;		//set CCR0 = 16384
	  
	//set up Timer Compare IRQ
	TB0CCTL0 |= CCIE;		//local enable for CCR0
	__enable_interrupt();		//Enable maskable IRQs
	TB0CCTL0 &= ~CCIFG;		//Clear Flag
	
	//Main Loop
	while(1){			//Loop Forever
	} 


	return 0;
}

//--ISRs---------------------------------------------------------//
#pragma vector = TIMER0_B0_VECTOR
__interrupt void ISR_TB0_CCR0(void)
{ 
	P1OUT ^= BIT0;			//Toggle LED1
	TB0CCTL0 &= ~CCIFG;		//Clear Flag

}

