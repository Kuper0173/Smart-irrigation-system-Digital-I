#include <stdint.h>
#include "libs/time.h"
#include "libs/uart.h"

#define IO_BASE 0x400000
#define PERIP_LED_PWM 0x00410000
#define SETDUTY 0x01


// Punteros a los registros de hardware
volatile uint32_t *const gp = (uint32_t *)IO_BASE;
volatile uint32_t *const setduty = (uint32_t *)(PERIP_LED_PWM + SETDUTY);

const char hello[] = "START PWM\n\r";
int main(){
  uint8_t i=0;
  putstring(hello);
  while(1){
    for(i=0; i<128; i++){
      *setduty = i;
      wait(15);
    }
    for(i=127; i>0; i--){
      *setduty = i;
      wait(15);
    }
  }
}
