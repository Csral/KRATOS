ENTRY(_start)

/* Assumes all memory sections in specification valid */
MEMORY {
    
    /* ZBTSRAM 1 */
    FLASH(rx) : ORIGIN = 0x00000000, LENGTH = 4M
    /* ZBTSRAM 1 wrapped */
    EXT_FLASH(rx) : ORIGIN = 0x00400000, LENGTH = 4M
    RAM(rwx) : ORIGIN = 0x20000000, LENGTH = 8M
    PSRAM(rwx) : ORIGIN = 0x60000000, LENGTH = 16M

}

SECTIONS {

    . = ORIGIN(FLASH);

    .vector_table : {
        KEEP(*(.vector_table))
    } > FLASH

    .text : {
        *(.text*)
    } > FLASH

    .rodata : {
        *(.rodata*)
    } > FLASH

    _sidata = LOADADDR(.data);

    .data : {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM AT > FLASH

    .bss : {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > RAM

}