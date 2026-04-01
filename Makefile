-include .config
# Blanket export — all variables including CONFIG_* reach sub-makes
export

CROSS_COMPILE = opt/arm/11/arm-gnu-toolchain-11.3.rel1-mingw-w64-i686-arm-none-eabi/bin/arm-none-eabi-
export CC      = $(CROSS_COMPILE)gcc
export AR      = $(CROSS_COMPILE)ar
export OBJDUMP = $(CROSS_COMPILE)objdump
export OBJCOPY = $(CROSS_COMPILE)objcopy
GDB            = $(CROSS_COMPILE)gdb
QEMU_SYSTEM_ARM = qemu-system-arm

export FLAGS = -mthumb -mcpu=cortex-m7 -nostdlib -nostartfiles -ffreestanding

ifeq ($(strip $(CONFIG_WARNINGS_ALL)), y)
FLAGS += -Wall
endif

ifeq ($(strip $(CONFIG_W_AS_ERRORS)), y)
FLAGS += -Werror
endif

ifeq ($(strip $(CONFIG_DEBUG_SYMBOLS)), y)
FLAGS += -g
endif

# ── Target / linker script selection ─────────────────────────────────────────

ifeq ($(strip $(CONFIG_device_teensy)), y)

ifeq ($(strip $(CONFIG_teensy_rev_b)), y)
LINKER_SCRIPT = linker/teensyB.ld
else ifeq ($(strip $(CONFIG_teensy_rev_c)), y)
LINKER_SCRIPT = linker/teensyC.ld
else
$(error Invalid TEENSY revision selected.)
endif
OUTPUT = teensy

else ifeq ($(strip $(CONFIG_device_mps2an500)), y)
LINKER_SCRIPT = linker/mps2an500.ld 
OUTPUT = mps2-an500
else
$(error No valid target device selected. Run: make menu)
endif

ifeq ($(strip $(CONFIG_USE_CUSTOM_LINKER)), y)
ifeq ($(subst ",,$(strip $(CONFIG_LINKER_SCRIPT_PATH))),)

$(error Path unprovided for custom linker script. Run: make menu)

endif
LINKER_SCRIPT = $(subst ",,$(strip $(CONFIG_LINKER_SCRIPT_PATH)))
endif

ifeq ($(LINKER_SCRIPT),)
$(error LINKER_SCRIPT not set)
endif

# ── Build directories ─────────────────────────────────────────────────────────

BUILD_DIR  = build
COMMON_DIR = $(BUILD_DIR)/common
export BUILD_DIR COMMON_DIR

ARCHIVES = $(BUILD_DIR)/arch.a $(BUILD_DIR)/bsp.a $(BUILD_DIR)/kernel.a

# ── Top-level targets ─────────────────────────────────────────────────────────

.PHONY: all arch bsp kernel clean qemu gdb menu

all: arch bsp kernel \
     $(BUILD_DIR)/$(OUTPUT).elf \
     $(BUILD_DIR)/$(OUTPUT).objdump \
     $(BUILD_DIR)/$(OUTPUT).bin

arch:
	$(MAKE) -f arch/Makefile.mk

bsp:
	$(MAKE) -f bsp/Makefile.mk

kernel:
	$(MAKE) -f kernel/Makefile.mk

# ── Final link ────────────────────────────────────────────────────────────────
# -u _start forces the linker to pull main.s.o from bsp.a,
# which brings the .vector_table section along with it.

$(BUILD_DIR)/$(OUTPUT).elf: $(ARCHIVES)
	$(CC) $(FLAGS) -T $(LINKER_SCRIPT) -u _start \
	    $(BUILD_DIR)/bsp.a $(BUILD_DIR)/arch.a $(BUILD_DIR)/kernel.a \
	    -o $@

$(BUILD_DIR)/$(OUTPUT).objdump: $(BUILD_DIR)/$(OUTPUT).elf
	$(OBJDUMP) -d $< > $@

$(BUILD_DIR)/$(OUTPUT).bin: $(BUILD_DIR)/$(OUTPUT).elf
	$(OBJCOPY) -O binary $< $@

# ── Utility targets ───────────────────────────────────────────────────────────

qemu:
	$(QEMU_SYSTEM_ARM) -m 16M -nographic -machine mps2-an500 -S -cpu cortex-m7\
    -gdb tcp::2345,ipv4 -kernel $(BUILD_DIR)/$(OUTPUT).elf

gdb:
	$(GDB)

menu: clean
	python -m menuconfig

clean:
	rm -rf $(BUILD_DIR)/