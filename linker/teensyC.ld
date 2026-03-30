ENTRY(_start)

MEMORY {

    ITCM(rx) : ORIGIN = 0x00000000, LENGTH = 128K
    FLASH(rx) : ORIGIN = 0x60000000, LENGTH = 16M
    DTCM(rw) : ORIGIN = 0x20000000, LENGTH = 128K
    OCRAM(rwx) : ORIGIN = 0x20200000, LENGTH = 256K
    SDRAM(rwx) : ORIGIN = 0x80000000, LENGTH = 32M
}

SECTIONS {

    . = ORIGIN(FLASH);

    .vector_table : ALIGN(1024) {
        KEEP(*(.vector_table))
    } > FLASH

    .text : {
        . = ALIGN(4);
        *(.text*)
    } > FLASH

    .rodata : {
        *(.rodata*)
    } > FLASH

    _sidata = LOADADDR(.data);

    .data : {
        _sdata = .;
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > DTCM AT > FLASH

    .bss : {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > DTCM

}