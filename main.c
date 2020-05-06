#include "stm32f4_discovery.h"

#define GREEN  LED4_PIN
#define ORANGE LED3_PIN
#define RED    LED5_PIN
#define BLUE   LED6_PIN
#define ALL_LEDS (GREEN | ORANGE | RED | BLUE) // all leds

#define PAUSE_LONG  4000000L
#define PAUSE_SHORT 1000000L

#define LEDS_GPIO_PORT (GPIOD)

uint16_t leds[LEDn] = {GREEN, ORANGE, RED, BLUE};

GPIO_InitTypeDef GPIO_InitStructure;

void delay(__IO uint32_t nCount) {
  while (nCount--) {
    __asm("nop"); // do nothing
  }
}

void setup_leds(void) {
  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOD, ENABLE);
  GPIO_InitStructure.GPIO_Pin   = ALL_LEDS;
  GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd  = GPIO_PuPd_NOPULL;
  GPIO_Init(LEDS_GPIO_PORT, &GPIO_InitStructure);
}

void led_round(void) {
  int i;
  for (i = 0; i < LEDn; i++) {
    GPIO_SetBits(LEDS_GPIO_PORT, leds[i]);
    delay(PAUSE_LONG);
    GPIO_ResetBits(LEDS_GPIO_PORT, ALL_LEDS);
  }
}

void flash_all_leds(void) {
  int i;
  for (i = 0; i < 4; i++) {
    GPIO_SetBits(LEDS_GPIO_PORT, ALL_LEDS);
    delay(PAUSE_SHORT);
    GPIO_ResetBits(LEDS_GPIO_PORT, ALL_LEDS);
    delay(PAUSE_SHORT);
  }
}

int main(void) {
  setup_leds();
  while (1) {
    led_round();
    flash_all_leds();
  }
  return 0;
}
