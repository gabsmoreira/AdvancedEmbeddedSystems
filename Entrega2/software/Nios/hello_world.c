/*
 * PIO test
 *
 */

#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"

#define PIO_1_BASE 0x0
#define PIO_1_IRQ 0
#define PIO_0_BASE 0x11000

 int n = 0;
 /* A variable to hold the value of the button pio edge capture register. */

volatile int edge_capture;
volatile int on = 0;
volatile int adder;
volatile int counter;

void init_pio();

int main()
{
    n = 0;
    init_pio();


    //while(1){
    	//unsigned int *p_pioIn_reversed = (unsigned int *) {*(p_pioIn + 3), *(p_pioIn + 2), *(p_pioIn + 1), *(p_pioIn)};
    	//IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,  on);
    	//adder += *(p_pioIn + 3);

    //}
    while (1) {
       IOWR_ALTERA_AVALON_PIO_DATA(PIO_1_BASE, n);
       counter += adder;
       if (counter > 100000){
    	   counter = 0;
    	   if (on == 0){
    	       	on = 1;
    	       }
		   else{
			on = 0;
		   }
		   IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, on);

       }
  }

    return 0;
}

 /*******************************************************************
 * static void handle_button_interrupts( void* context, alt_u32 id)*
 *                                                                 *
 * Handle interrupts from the buttons.                             *
 * This interrupt event is triggered by a button/switch press.     *
 * This handler sets *context to the value read from the button    *
 * edge capture register.  The button edge capture register        *
 * is then cleared and normal program execution resumes.           *
 * The value stored in *context is used to control program flow    *
 * in the rest of this program's routines.                         *
 ******************************************************************/

void handle_button_interrupts(void* context, alt_u32 id)
{
    /* Cast context to edge_capture's type. It is important that this be
     * declared volatile to avoid unwanted compiler optimization.
     */
    volatile int* edge_capture_ptr = (volatile int*) context;
    /* Store the value in the Button's edge capture register in *context. */
    *edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE);
    n++;
    /* Reset the Button's edge capture register. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0);
    unsigned int *p_pioIn = (unsigned int *) PIO_1_BASE;
    adder = *(p_pioIn);
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0);
    //PIO_0_BASE = on;
    //printf("Hello");
}

/* Initialize the pio. */

void init_pio()
{
    /* Recast the edge_capture pointer to match the alt_irq_register() function
     * prototype. */
    void* edge_capture_ptr = (void*) &edge_capture;
    /* Enable first four interrupts. */
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_1_BASE, 0xf);
    /* Reset the edge capture register. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0x0);
    /* Register the interrupt handler. */
    alt_irq_register(PIO_1_IRQ, edge_capture_ptr,
                      handle_button_interrupts );
}


#if defined(MAIN1)
int main()
{
  volatile int in,  out;
  while (1)
  {
      in = IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE);
      out = in;
      IOWR_ALTERA_AVALON_PIO_DATA(PIO_1_BASE, out);
  }
 }
 #endif
