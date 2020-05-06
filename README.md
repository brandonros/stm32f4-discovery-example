# stm32f4-discovery-example
Makefile + dfu-util to get LEDs blinking

## Usage
1. `git clone git@github.com:brandonros/stm32f4-discovery-example.git`
1. `cd stm32f4-discovery-example`
1. Download and extract `STSW-STM32068` from https://www.st.com/en/embedded-software/stsw-stm32068.html which will provide the `STM32F4-Discovery_FW_V1.1.0` directory
1. `make`

## How to flash the board through USB DFU mode
1. Put a jumper on JP1.
1. Put a jumper between BOOT0 and VDD.
1. Connect with a wire PA9 to 5V.
1. Connect the device using the *micro* USB port, *not* the mini-USB port.
1. `make flash`
1. Unplug the device.
1. Disconnect the BOOT0 jumper.
1. Plug the device in.
