# Called as: $(MAKE) -f bsp/Makefile.mk
# Working directory remains the project root. CONFIG_* exported from root Makefile.

BSP_BOARD = NONE

ifeq ($(strip $(CONFIG_device_mps2an500)),y)
BSP_BOARD = mps2an500
else ifeq ($(strip $(CONFIG_device_teensy)),y)
BSP_BOARD = teensy
else
$(error bsp/Makefile.mk: No valid board selected — cannot determine BSP_BOARD)
endif

ifeq ($(strip $(BSP_BOARD)),NONE)
$(error bsp/Makefile.mk: No valid board selected — cannot determine BSP_BOARD)
else ifeq ($(strip $(BSP_BOARD)),)
$(error bsp/Makefile.mk: No valid board selected — cannot determine BSP_BOARD)
endif

include bsp/$(BSP_BOARD)/Sources.mk
# BSP_SRCS is now defined by the included Sources.mk

BSP_OBJ_DIR = $(COMMON_DIR)/bsp/$(BSP_BOARD)
BSP_OBJS    = $(addprefix $(BSP_OBJ_DIR)/, $(addsuffix .o, $(notdir $(BSP_SRCS))))

# ── Targets ───────────────────────────────────────────────────────────────────

.PHONY: bsp_archive

bsp_archive: $(BUILD_DIR)/bsp.a

$(BUILD_DIR)/bsp.a: $(BSP_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(AR) rcs $@ $^

# ── Compile rules ─────────────────────────────────────────────────────────────

$(BSP_OBJ_DIR)/%.s.o: bsp/$(BSP_BOARD)/%.s
	@mkdir -p $(dir $@)
	$(CC) $(FLAGS) -c $< -o $@

$(BSP_OBJ_DIR)/%.c.o: bsp/$(BSP_BOARD)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(FLAGS) -c $< -o $@
