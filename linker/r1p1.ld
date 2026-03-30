ENTRY(_start)

MEMORY {
    FLASH(rx) : ORIGIN = 0x0000000, LENGTH = 1024K
    RAM(rwx) : ORIGIN = 0x20000000, LENGTH = 4M
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