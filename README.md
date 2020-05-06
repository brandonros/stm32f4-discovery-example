# stm32f4-discovery-example
Makefile + dfu-util to get LEDs blinking

## How to flash the board through USB DFU mode

1. Take every jumper off except JP1. Take both jumpers off CN3. Take the jumpers JP2 and JP3 off from the bottom of the board.
1. Put a jumper between `BOOT0` and `VDD`.
1. Connect with a wire PA9 to 5V.
1. Connect the device using the *micro* USB port, *not* the mini-USB port.
1. `make clean && make && make flash`
1. Unplug the device.
1. Disconnect the BOOT0 jumper.
1. Plug the device in.
