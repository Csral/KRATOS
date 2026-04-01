# Called as: $(MAKE) -f kernel/kernel.mk
# No target selection needed — kernel is universal

# KERNEL_SRCS is now defined
KERNEL_SRCS = kernel.c
KERNEL_OBJ_DIR = $(COMMON_DIR)/kernel
KERNEL_OBJS    = $(addprefix $(KERNEL_OBJ_DIR)/, $(addsuffix .o, $(notdir $(KERNEL_SRCS))))

# ── Targets ───────────────────────────────────────────────────────────────────

.PHONY: kernel_archive

kernel_archive: $(BUILD_DIR)/kernel.a

$(BUILD_DIR)/kernel.a: $(KERNEL_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(AR) rcs $@ $^

# ── Compile rules ─────────────────────────────────────────────────────────────

$(KERNEL_OBJ_DIR)/%.c.o: kernel/%.c
	@mkdir -p $(dir $@)
	$(CC) $(FLAGS) -c $< -o $@
