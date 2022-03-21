/*
    (c) 2020 Microchip Technology Inc. and its subsidiaries. You may use this
    software and any derivatives exclusively with Microchip products.

    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
    WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
    PARTICULAR PURPOSE, OR ITS INTERACTION WITH MICROCHIP PRODUCTS, COMBINATION
    WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION.

    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
    BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
    FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
    ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
    THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.

    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE
    TERMS.
*/

#ifndef __I2C2_DRIVER_H
#define __I2C2_DRIVER_H

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
 
typedef void (*interruptHandler)(void);

/* arbitration interface */
void i2c2_driver_close(void);

/* Interrupt interfaces */
void i2c2_enableIRQ(void);
bool i2c2_IRQisEnabled(void);
void i2c2_disableIRQ(void);
void i2c2_clearIRQ(void);
void i2c2_setIRQ(void);
void i2c2_waitForEvent(uint16_t*);

/* I2C interfaces */
bool  i2c2_driver_driver_open(void);
char i2c2_driver_getRXData(void);
void i2c2_driver_TXData(uint8_t);
void i2c2_driver_resetBus(void);
void i2c2_driver_start(void);
void i2c2_driver_restart(void);
void i2c2_driver_stop(void);
bool i2c2_driver_isNACK(void);
void i2c2_driver_startRX(void);
void i2c2_driver_sendACK(void);
void i2c2_driver_sendNACK(void);
void i2c2_driver_clearBusCollision(void);

bool  i2c2_driver_initSlaveHardware(void);
void i2c2_driver_releaseClock(void);
bool i2c2_driver_isBuferFull(void);
bool i2c2_driver_isStart(void);
bool i2c2_driver_isStop(void);
bool i2c2_driver_isAddress(void);
bool i2c2_driver_isData(void);
bool i2c2_driver_isRead(void);
void i2c2_driver_enableStartIRQ(void);
void i2c2_driver_disableStartIRQ(void);
void i2c2_driver_enableStopIRQ(void);
void i2c2_driver_disableStopIRQ(void);

void i2c2_driver_setBusCollisionISR(interruptHandler handler);
void i2c2_driver_setMasterI2cISR(interruptHandler handler);
void i2c2_driver_setSlaveI2cISR(interruptHandler handler);

#endif // __I2C2_DRIVER_H
