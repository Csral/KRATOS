-include .config

CROSS_COMPILE=opt/arm/11/arm-gnu-toolchain-11.3.rel1-mingw-w64-i686-arm-none-eabi/bin/arm-none-eabi-
CC = $(CROSS_COMPILE)gcc
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
GDB = $(CROSS_COMPILE)gdb
QEMU_SYSTEM_ARM = qemu-system-arm
FLAGS = -mthumb -mcpu=cortex-m7 -nostdlib -nostartfiles -ffreestanding

FILES = r1p1/r1p1.s r1p1/r1p1.c

ifeq ($(strip $(CONFIG_device_teensy40)), y)
LINKER_SCRIPT = linker/teensy40.ld
else ifeq ($(strip $(CONFIG_device_mps2an500)), y)
LINKER_SCRIPT = linker/r1p1.ld
else
LINKER_SCRIPT = linker/r1p1m7.ld
endif

ifeq ($(strip $(CONFIG_USE_CUSTOM_LINKER)), y)

ifeq ($(subst ",,$(strip $(CONFIG_LINKER_SCRIPT_PATH))),)
$(error Path unprovided for custom linker script. Use menuconfig or python -m menuconfig to fix)
endif

LINKER_SCRIPT = $(subst ",,$(strip $(CONFIG_LINKER_SCRIPT_PATH)))
endif

ifeq ($(LINKER_SCRIPT),)
$(error LINKER_SCRIPT not set)
endif

LDFLAGS = -T $(LINKER_SCRIPT)

ifeq ($(strip $(CONFIG_WARNINGS_ALL)), y)
FLAGS += -Wall
endif

ifeq ($(strip $(CONFIG_W_AS_ERRORS)), y)
FLAGS += -Werror
endif

ifeq ($(strip $(CONFIG_DEBUG_SYMBOLS)), y)
FLAGS += -g
endif

.PHONY: all clean qemu gdb menu

all: mps2-an500.elf mps2-an500.objdump mps2-an500.bin

mps2-an500.elf: $(FILES)
	$(CC) $(FLAGS) $(LDFLAGS) -o $@ $(FILES)

mps2-an500.objdump: mps2-an500.elf
	$(OBJDUMP) -d mps2-an500.elf > mps2-an500.objdump

mps2-an500.bin: mps2-an500.elf
	$(OBJCOPY) -O binary mps2-an500.elf mps2-an500.bin

qemu:
	$(QEMU_SYSTEM_ARM) -m 16M  -nographic -machine mps2-an500 -S -cpu cortex-m7 -gdb tcp::2345,ipv4 -kernel mps2-an500.elf

gdb:
	$(GDB)

menu: clean
	python -m menuconfig
	
clean:
	rm -rf mps2-an500.elf mps2-an500.objdump mps2-an500.bin