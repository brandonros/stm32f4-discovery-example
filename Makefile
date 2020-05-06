PROJ_NAME=blinky
STM_DIR=./STM32F4-Discovery_FW_V1.1.0
STM_SRC = $(STM_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/src
vpath %.c $(STM_SRC)
SRCS = main.c
SRCS += $(STM_DIR)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c
SRCS += $(STM_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c
SRCS += $(STM_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c
SRCS += $(STM_DIR)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f4xx.s
INC_DIRS = $(STM_DIR)/Utilities/STM32F4-Discovery
INC_DIRS += $(STM_DIR)/Libraries/CMSIS/Include
INC_DIRS += $(STM_DIR)/Libraries/CMSIS/ST/STM32F4xx/Include
INC_DIRS += $(STM_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/inc
INC_DIRS += .
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
INCLUDE = $(addprefix -I,$(INC_DIRS))
DEFS = -DUSE_STDPERIPH_DRIVER
CFLAGS = -O3
CFLAGS += -Wall -Wextra -Warray-bounds
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
LFLAGS = -Tstm32_flash.ld

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(INCLUDE) $(DEFS) $(CFLAGS) $(LFLAGS) $^ -o $@
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

clean:
	rm -f *.o $(PROJ_NAME).elf $(PROJ_NAME).bin

flash:
	dfu-util -d 0483:df11 -a 0 -s 0x08000000 -D $(PROJ_NAME).bin
