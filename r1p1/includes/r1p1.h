#ifndef _R1P1_H_
#define _R1P1_H_

void handler_NMI(void);
void handler_HardFault(void);
void handler_MemManage(void);
void handler_BusFault(void);
void handler_UsageFault(void);
void handler_SVCall(void);
void handler_DebugMonitor(void);
void handler_PendSV(void);
void handler_SysTick(void);

void supervisor_main(void);

#endif