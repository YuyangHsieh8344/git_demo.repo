	

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	//set up ports
	P1DIR |= BIT0;  		//set P1.0 to an output
	P1OUT &= ~BIT0; 		//clear LED1 initially
	PMSCTL0 &= ~LOCKLPMS;		//turn on gpio

	//set up timer
	TB0CTL |= TBCLR;		//reset timer
	TB0CTL |= TBSSEL__ACLK; 	//Clock = ACLK
	TB0CTL |= MC__CONTINUOUS; 	//Mode = Continuous
	  
	//set up TB0 overflow IRQ
	TB0CTL |= TBIE;			//local enable for TB0 overflow
	__enable_interrupt();		//Enable maskable IRQs
	TB0CTL &= ~TBIFG;		//Clear IRQ Flag
	
	//Main Loop
	while(1){			//Loop Forever
	} 


	return 0;
}

//--ISRs---------------------------------------------------------//
#pragma vector = TIMER0_B1_VECTOR
__interrupt void ISR_TB0_Overflow(void)
{ 
	P1OUT ^= BIT0;			//Toggle LED1
	TB0CTL &= ~TBIFG;		//Clear IRQ Flag
}

