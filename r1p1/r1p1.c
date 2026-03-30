#include "r1p1.h"

void handler_NMI(void) {

    asm("mov r0, #18");

    while (1) {

    }

};

void handler_HardFault(void) {

    asm("mov r0, #20");

    while (1) {
        
    }

};

void handler_MemManage(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_BusFault(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_UsageFault(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_RESERVED_7(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_RESERVED_8(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_RESERVED_9(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_RESERVED_10(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_SVCall(void) {

    asm("mov r0, #52");
    asm("push {r0, r7}");

    while (1) {
        
    }

};

void handler_DebugMonitor(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_RESERVED_13(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_PendSV(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};

void handler_SysTick(void) {

    asm("mov r0, #28");

    while (1) {
        
    }

};