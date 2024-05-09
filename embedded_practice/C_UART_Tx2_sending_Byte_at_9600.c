//baud rate = 9600; period = 1/9600 = 104 µs (micro second) 
//in waveform will check the width between period
int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	
	//set up UART
	UCA1CTLW0 |= UCSWRST;		//Put UART A1 into SW reset
	UCA1CTLW0 |= UCSSEL__ACLK;	//Choose ACLK for UART A1
	
	UCA1BRW = 3; 			//set prescaler to 3
	UCA1MCTLW |= 0x9200; 		//configure modulation setting
	
	//set up pins 
	P4SEL1 &= ~BIT3;		//want p4.3 to use UART A1 Tx
	P4SEL0 |= BIT3;			//P4SEL1.3 : P4SEL0.4 = 01

	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio (I/O)
	
	UCA1CTLW0 &= ~UCSWRST;		//take UART A1 out of SW reset
	
	//main loop
	
	int i; 
	while(1){
		//0b10101010 = 0x55 (waveform)
		UCA1TXBUF = 0x55; 		//transmit 0x55 over UART A1 Tx
		for (i=0; i <10000; i++){	//delay between frame
		}
	}
	return 0;
}