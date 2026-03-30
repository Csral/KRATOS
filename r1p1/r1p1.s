        .file    "r1p1.s"
        .arch    armv7-m
        .thumb
        .syntax  unified

        .extern handler_NMI
        .extern handler_HardFault
        .extern handler_MemManage
        .extern handler_BusFault
        .extern handler_UsageFault
        .extern handler_SVCall
        .extern handler_DebugMonitor
        .extern handler_PendSV
        .extern handler_SysTick

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
        .long   handler_NMI
        .long   handler_HardFault
        .long   handler_MemManage
        .long   handler_BusFault
        .long   handler_UsageFault
        .long   handler_RESERVED_7
        .long   handler_RESERVED_8
        .long   handler_RESERVED_9
        .long   handler_RESERVED_10
        .long   handler_SVCall
        .long   handler_DebugMonitor
        .long   handler_RESERVED_13
        .long   handler_PendSV
        .long   handler_SysTick

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

        SVC #2

        # End SysTick config


wait:    b       wait
        .size    _start, .-_start
        .end
