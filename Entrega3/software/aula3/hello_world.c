#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

//#define SIM

// LED Peripheral
#define REG_DATA_OFFSET 1
#define PS2_E_0_BASE 0x41000


int main(void){
  unsigned int led = 0;
  unsigned int *p_led = (unsigned int *) PERIPHERAL_LED_0_BASE;
  volatile unsigned int *ps2 = (unsigned int *) PS2_E_0_BASE;

  if(ps2_init(PS2_E_0_BASE))
	  while(1){};

  while(1){
	  int left_click = ps2_read_clickleft(PS2_E_0_BASE);
	  printf("%x \n", left_click);
  };
  return 0;
}

int ps2_init(unsigned int base){
	volatile unsigned int *ps2 = (unsigned int *) base;
	uint id = *(ps2 + 2);
	if (id != 0xA5A5A5A5){
		  printf("Read error - ps2 peripherical");
		  return 1;
	  }
	*(ps2 + 0) = 1;
	//*(ps2 + 0) = 0;

	//delay_us(100);

	return 0 ;
}

int ps2_halt(unsigned int base){
	volatile unsigned int *ps2 = (unsigned int *) base;
	*ps2 = 0;
	return 0;

}

int ps2_read_clickleft(unsigned int base){
	volatile unsigned int *ps2 = (unsigned int *) base;
	//return *(ps2 +1);
	return (*(ps2 + 1) >> 16);
	//return ((*(ps2 + 1) >> 16) & 0x1);
}
