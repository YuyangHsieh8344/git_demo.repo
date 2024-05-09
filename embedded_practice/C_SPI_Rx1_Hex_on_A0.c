//C_SPI_Rx1_Hex_on_A0
Receiving a Byte as a SPI Master


int main(void){

	WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer