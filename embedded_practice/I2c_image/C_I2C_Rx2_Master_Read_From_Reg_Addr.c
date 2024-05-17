//reading from specific register address
//counting from h00 to h60 and reset back to h00
//UCMODE = I2C mode
//UCMST = master
//UCTR = transmit = write
//I2CSA = slave address = 0x68

char Data_In = 0;

int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer
	
	//set up B0 for I2C
	UCB0CTLW0 |= UCSWRST; 		//put in SW RST
	
	UCB0CTLW0 |= UCSSEL_3;		//choose  SMCLK
	UCB0BRW = 10; 			    //set prescaler to 10
	
	UCB0CTLW0 |= UCMODE_3;		//put into I2C mode
	UCB0CTLW0 |= UCMST;		    //set as master
	UCB0I2CSA = 0x68;		    //set slave address RTC - 0x68
	
	UCB0CTLW1 |= UCASTP_2; 		//auto STOP mode
	UCB0TBCNT = 1; 			    //count = 1 byte 
	
	//set up ports 
	P1SEL1 &= ~BIT3;		    //P1.3 = SCL (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT3;	
	
	P1SEL1 &= ~BIT2;		    //P1.2 = SDA (P1SEL1:P1SEL0 = 01)
	P1SEL0 |= BIT2;
	
	PM5CTL0 &= ~LOCKLPM5;		//turn on gpio
	UCB0CTLW0 &= ~UCSWRST; 		//take B0 out of SW RST	
	
	//enable B0 Tx0 IRQ
	UCB0IE |= UCTXIE0; 		    //local enable for Tx0
    UCB0IE |= UCRXIE0;          //local enable for Rx0
	__enable_interrupt();		//enable maskable
	
    //main loop
	while(1)
	{
        //transmit register address with WRITE message
        UCB0CTLW0 |= UCTR;		        //put into Tx mode (write)
		UCB0CTLW0 |= UCTXSTT;	        //manually start message (START)

        while ( (UCB0IFG & UCSTPIEG) == 0 ){}
            UCB0IFG &= ~UCSTPIEG;       //Clear the stop flag
        

        //Recieve data from slave with a READ message
		  UCB0CTLW0 &= ~UCTR;		    //put into Rx mode (read)
		UCB0CTLW0 |= UCTXSTT;	        //manually start message (START)

        while ( (UCB0IFG & UCSTPIEG) == 0 ){}
            UCB0IFG &= ~UCSTPIEG;       //Clear the stop flag
        
	}
	
	//ISRs
	#pragma vector = EUSCI_B0_VECTOR
 	__interrupt void EUSCI_B0_I2C_ISR(void)
	{	
		switch(UCB0IV){
             case 0x18:                  //ID 18: TXIFG
                UCB0TXBUF = 0x03;       //send reg address
                break;

            case 0x16:                  //ID 16: RXIFG0
                Data_In = UCB0RXBUF;    //read data from Rx buf
                break;
            
            default:

                break;
           
        }
	}
	

	return 0;
}