//C_SPI_Tx1_Hex_on_A0
//serial peripheral interface = uses more pins than UART but can achieve higher data rates due to synchronous nature of link

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer

	//set up SPI A0
	UCA0CTL20 |= UCSWRST;		//put A0 into SW reset
	UCA0CTLW0 |= UCSSEL__SMCLK; 	//choose SMCLK	
	UCA1BRW = 10;			//set prescaler to get SCLK = 1M/10 = 100kHz

	UCA0CTLW0 |=  UCSYNC;		//put A0 into SPI mode
	UCA0CTLW0 |= UCMST;		//put into SPI master (sent a clk to master)
	
	//configure the ports 
	P1SEL1 &= ~BIT5;		//P1.5 use SCLK (01)
	P1SEL0 |= BIT5;
	
	P1SEL1 &= ~BIT7;		//P1.7 use SIMO (01) => SEE DATA COMING OUT
	P1SEL0 |= BIT7;
	
	P1SEL1 &= ~BIT6;		//P1.6 use SOMI (01) => NOT USING IT NOW
	P1SEL0 |= BIT6;
	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio (I/O)
	UCA0CTL20 &= ~UCSWRST;		//take A0 out SW reset
	
	int i;
	while(1){
		//SCLK is 100 kHz; 10110010 is 0x4D
		UCA0TXBUF = 0x4D;	//send 0x4D out over SPI
		for (i = 0; i<10000; ++i){
		} 
	}
	return 0;
}