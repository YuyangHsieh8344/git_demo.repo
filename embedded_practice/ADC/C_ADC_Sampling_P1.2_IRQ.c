

#include <msp430.h>

unsigned int ADC_Value;

int main(void){
    WDTCTL = WDTPW | WDTHOLD; 	//stop watchdog timer

    //set up ports
    P1DIR |= BIT0;              //set P1.0 to output(LED1)
    P6DIR |= BIT6;              //set P6.6 to output (LED2)

    P1SEL1 |= BIT2;             //choose analog function for P1.2
    P1SEL0 |= BIT2;             //11 = Analog

    PM5CTL0 &= ~LOCKLPM5;       //turn on I/O

    //configure the ADC
    ADCCTL0 &= ~ADCSHT;         //set conv clock cycles = 16 (10)
    ADCCTL0 |= ADCSHT_2;        
    ADCCTL0 |= ADCON;           //turn on ADC

    ADCCTL1 |= ADCSSEL_2;       //choose SMCLK
    ADCCTL1 |= ADCSHP;          //Sample singal source = sampling timer

    ADCCTL2 &= ~ADCRES;         //clear resolution
    ADCCTL2 |= ADCRES_2;        //12-bit resolution

    ADCMCTL0 |= ADCIMCH_2;      //ADC input = A2 (P1.2)

    //set up IRQ 
    ADCIE |= ADCIE0;            //conversion complete IRQ, local enable
    __enable_interrupt();       //enable maskables

    //main loop   
    while (1){
        ADCCTL0 |= ADCENC | ADCSC;          //enable and start conv.


        while ((ADCIFG & ADCIFG0) == 0 );   //wait for conversion complete 

    }
    return 0;
}

//ISR
#pragma vector = ADC_VECTOR
__interrupt void ADC_ISR(void){
    ADC_Value = ADCMEM0;           //read ADC value
    if(ADC_Value > 3613){
        P1OUT |= BIT0;                  //LED1 = ON (RED)
            P6OUT &= ~BIT6;                 //LED2 = OFF (GREEN)
        } else{
            P6OUT |= BIT6;                  //LED1 = ON (GREEN)
            P1OUT &= ~BIT0;                 //LED2 = OFF (RED)
    }

}


  