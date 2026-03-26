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