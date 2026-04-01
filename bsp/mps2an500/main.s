        .file    "main.s"
        .arch    armv7-m
        .thumb
        .syntax  unified

        .extern _handler_NMI
        .extern _handler_HardFault
        .extern _handler_MemManage
        .extern _handler_BusFault
        .extern _handler_UsageFault
        .extern _handler_SVCall
        .extern _handler_DebugMonitor
        .extern _handler_PendSV
        .extern _handler_SysTick

        .extern supervisor_main

        .equ handler_RESERVED_7,        0x00000000
        .equ handler_RESERVED_8,        0x00000000
        .equ handler_RESERVED_9,        0x00000000
        .equ handler_RESERVED_10,       0x00000000
        .equ handler_RESERVED_13,       0x00000000

        .equ    __StackTop, 0x20400000
        .section .vector_table, "a", %progbits

        .align   2
        .long   __StackTop
        # handler for RESEt
        .long   _start
        .long   _handler_NMI
        .long   _handler_HardFault
        .long   _handler_MemManage
        .long   _handler_BusFault
        .long   _handler_UsageFault
        .long   handler_RESERVED_7
        .long   handler_RESERVED_8
        .long   handler_RESERVED_9
        .long   handler_RESERVED_10
        .long   _handler_SVCall
        .long   _handler_DebugMonitor
        .long   handler_RESERVED_13
        .long   _handler_PendSV
        .long   _handler_SysTick

        # 15 interrupts

        .equ SYST_CSR, 0xE000E010
        .equ SYST_RVR, 0xE000E014
        .equ SYST_CVR, 0xE000E018
        .equ SYST_CALIB, 0xE000E01C

        .equ VTOR, 0xE000ED08
        .equ CPUID, 0xE000ED00

.section .text
.global _start
.type _start, %function
_start:

        # Do very basic setup here (if any).

        # Configure the system to bare minimum

        SVC #2

        # enable SysTick

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

        # End SysTick config

        b supervisor_main

wait:    b       wait
        .size    _start, .-_start
        .end
