# Called as: $(MAKE) -f arch/Makefile.mk
# Working directory remains the project root. CONFIG_* exported from root Makefile.

# Currently only armv7m
ifeq ($(strip $(CONFIG_arch_armv7m)),y)
ARCH_CPU = armv7m
else
ARCH_CPU = armv7m
endif

include arch/$(ARCH_CPU)/Sources.mk
# ARCH_SRCS is now defined by the included Sources.mk

ARCH_OBJ_DIR = $(COMMON_DIR)/arch/$(ARCH_CPU)
ARCH_OBJS    = $(addprefix $(ARCH_OBJ_DIR)/, $(addsuffix .o, $(notdir $(ARCH_SRCS))))

# ── Targets ───────────────────────────────────────────────────────────────────

.PHONY: arch_archive

arch_archive: $(BUILD_DIR)/arch.a

$(BUILD_DIR)/arch.a: $(ARCH_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(AR) rcs $@ $^

# Compile rules
$(ARCH_OBJ_DIR)/%.s.o: arch/$(ARCH_CPU)/%.s
	@mkdir -p $(dir $@)
	$(CC) $(FLAGS) -c $< -o $@

$(ARCH_OBJ_DIR)/%.c.o: arch/$(ARCH_CPU)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(FLAGS) -c $< -o $@
