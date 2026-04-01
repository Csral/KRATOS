#include "includes/exceptions.h"

void handler_NMI(void) {

    asm("nop");
    return;

};

void handler_HardFault(void) {

    asm("nop");
    while(1);

};

void handler_MemManage(void) {

    asm("mov r0, #28");
    return;

};

void handler_BusFault(void) {

    asm("mov r0, #28");
    return;

};

void handler_UsageFault(void) {

    asm("mov r0, #28");
    return;

};

void handler_SVCall(void) {

    asm("nop");
    return;

};

void handler_DebugMonitor(void) {

    asm("mov r0, #28");
    return;

};

void handler_PendSV(void) {

    asm("mov r0, #28");
    return;

};

void handler_SysTick(void) {

    asm("mov r0, #28");
    return;

};