        .file    "r1p1.s"
        .arch    armv7-m
        .thumb
        .syntax  unified

        .extern handler_NMI
        .extern handler_HardFault
        .extern handler_MemManage

        .equ    __StackTop, 0x21000000
        .section .vector_table, "a", %progbits

        .align   2
        .long   __StackTop
        # handler for RESEt
        .long   _start 
        .long   handler_NMI
        .long   handler_HardFault
        .long   handler_MemManage

        # .equ SYST_CSR, 0xE000E010
        # .equ SYST_RVR, 0xE000E014
        # .equ SYST_CVR, 0xE000E018
        # .equ SYST_CALIB, 0xE000E01C

        .equ VTOR, 0xE000ED08
        .equ CPUID, 0xE000ED00

.section .text
.global _start
.type _start, %function
_start:
        mov     r0,#3
        mov     r1,#5
        add     r2, r0, r1

        ldr r0, =0xE000ED08
        ldr r1, [r0]

        mov r7, #2
        svc #2

        # mov r4, #5
        # ldr r0, =SYST_RVR
        # str r4, [r0]

        # eor r4, r4
        # ldr r0, =SYST_CVR
        # str r4, [r0]

        # ldr r4, =3221225472
        # ldr r0, =SYST_CALIB
        # str r4, [r0]

        # ldr r4, =65539
        # ldr r0, =SYST_CSR
        # str r4, [r0]

        # ldr r0, =CPUID
        # ldr r1, [r0]


wait:    b       wait
        .size    _start, .-_start
        .end
