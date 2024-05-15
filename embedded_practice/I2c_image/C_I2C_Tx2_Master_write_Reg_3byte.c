//write_three_byte_to_I2C_slave
//UCMODE = I2C mode
//UCMST = master
//UCTR = transmit = write
//I2CSA = slave address = 0x68

int Data_Cnt = 0;
char Packet[] = {0x03, 0x33, 0x44, 0x55};


int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	
	//set up B0 for I2C
	UCB0CTLW0 |= UCSWRST; 		//put in SW RST
	
	UCB0CTLW0 |= UCSSEL_3;		//choose  SMCLK
	UCB0BRW = 10; 			//set prescaler to 10
	
	UCB0CTLW0 |= UCMODE_3;		//put into I2C mode
	UCB0CTLW0 |= UCMST;		//set as master
	UCB0CTLW0 |= UCTR;		//[ut into Tx mode (write)
	UCB0I2CSA = 0x68;		//set slave address RTC - 0x68
	
	UCB0CTLW1 |= UCASTP_2; 		//auto STOP mode
	UCB0TBCNT = 1; 			//count = 1 byte 
	
	//set up ports 
	P1SEL1 &= ~BIT3;		//P1.3 = SCL (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT3;	
	
	P1SEL1 &= ~BIT2;		//P1.2 = SDA (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT2;
	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio
	UCB0CTLW0 &= ~UCSWRST; 		//take B0 out of SW RST	
	
	//enable B0 Tx0 IRQ
	UCB0IE |= UCTXIE0; 		//local enable for Tx0
	__enable_interrupt();		//enable maskable
	
	int i;
	while(1)
	{
		UCB0CTLW0 |= UCTXSTT;	//manually start message (START)
		for (i=0; i<100;++i)
		{
		}			//delay
	}
	
	//ISRs
	#pragma vector = EUSCI_B0_VECTOR
 	__interrupt void EUSCI_B0_I2C_ISR(void)
	{	
		if(Data_Cnt == sizeof(Packet) -1)){
			UCB0TXBUF = Packet[Data_Cnt];
			Data_Cnt = 0;
		} else{
			UCB0TXBUF = Packet[Data_Cnt];
			Data_Cnt++;
		}
	}
	

	return 0;
}