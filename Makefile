CROSS_COMPILE=D:/Programming/Embedded/Arm/RTOS/opt/arm/11/arm-gnu-toolchain-11.3.rel1-mingw-w64-i686-arm-none-eabi/bin/arm-none-eabi-
CC = $(CROSS_COMPILE)gcc
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
GDB = $(CROSS_COMPILE)gdb
QEMU_SYSTEM_ARM = qemu-system-arm
FLAGS = -g -mthumb -mcpu=cortex-m7 -nostdlib -nostartfiles -ffreestanding -Wl,-Tr1p1.ld

FILES = r1p1/r1p1.s r1p1/r1p1.c

.PHONY: all clean qemu gdb

all: mps2-an500.elf mps2-an500.objdump mps2-an500.bin

mps2-an500.elf: $(FILES)
	$(CC) $(FLAGS) -o $@ $(FILES)

mps2-an500.objdump: mps2-an500.elf
	$(OBJDUMP) -d mps2-an500.elf > mps2-an500.objdump

mps2-an500.bin: mps2-an500.elf
	$(OBJCOPY) -O binary mps2-an500.elf mps2-an500.bin

qemu:
	$(QEMU_SYSTEM_ARM) -m 16M  -nographic -machine mps2-an500 -S -cpu cortex-m7 -gdb tcp::2345,ipv4 -kernel mps2-an500.elf

gdb:
	$(GDB)

clean:
	rm mps2-an500.elf mps2-an500.objdump mps2-an500.bin