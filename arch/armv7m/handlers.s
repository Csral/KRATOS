    .file "handlers.s"
    .arch armv7-m
    .thumb
    .syntax unified

    .globl _handler_NMI
    .globl _handler_HardFault
    .globl _handler_MemManage
    .globl _handler_BusFault
    .globl _handler_UsageFault
    .globl _handler_SVCall
    .globl _handler_DebugMonitor
    .globl _handler_PendSV
    .globl _handler_SysTick

    .extern handler_NMI
    .extern handler_HardFault
    .extern handler_MemManage
    .extern handler_BusFault
    .extern handler_UsageFault
    .extern handler_SVCall
    .extern handler_DebugMonitor
    .extern handler_PendSV
    .extern handler_SysTick

    # -----------------------------
    #
    # REFER: ARMv7-M Architecture Reference Manual - B.1.5.8 (Exception entry and return)
    # 
    #                             Handler wrapper convention
    # Each handler below follows the same base convention as mentioned:
    #
    # 1. Capture SP address and pass it to C handler as arg0 adhering to AAPCS convention
    # 2. Establish a software stack frame to prevent the caller's stack.
    # 3. Preserve EXC_RETURN magic value provided in Link Register (r14) by the processor. Branch with Link (calling C function)
    #     will override r14.
    # 4. Restore the original stack frame at exception entry
    # 5. bx lr with EXC_RETURN in lr - the value is intercepted by processor to execute exception return mechanism.
    #
    # NOTE: Any modifications to Link Registers may be performed if required.
    # NOTE: Each wrapper can handle more functionality than specified above but must handle specified functionality
    #         as a minimum.
    #
    # -----------------------------

.section .text

.type _handler_NMI, %function
_handler_NMI:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_NMI
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_HardFault, %function
_handler_HardFault:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_HardFault
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_MemManage, %function
_handler_MemManage:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_MemManage
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_BusFault, %function
_handler_BusFault:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_BusFault
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_UsageFault, %function
_handler_UsageFault:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_UsageFault
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_SVCall, %function
_handler_SVCall:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_SVCall
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_DebugMonitor, %function
_handler_DebugMonitor:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_DebugMonitor
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_PendSV, %function
_handler_PendSV:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_PendSV
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr

.type _handler_SysTick, %function
_handler_SysTick:

    add r0, sp, #0
    push {r7}
    add r7, sp, #0

    push {r14}
    bl handler_SysTick
    pop {r14}

    mov.w sp, r7
    pop {r7}

    bx lr
