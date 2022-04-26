/**
  @Generated 16-bit Bootloader Source File

  @Company:
    Microchip Technology Inc.

  @File Name: 
    boot_verify_crc32.c

  @Summary:
    This is the boot_verify_crc32.c file generated using 16-bit Bootloader

  @Description:
    This header file provides implementations for driver APIs for all modules selected in the GUI.
    Generation Information :
        Product Revision  :  16-bit Bootloader - 1.19.0
        Device            :  PIC24FJ128GA705
    The generated drivers are tested against the following:
        Compiler          :  XC16 v1.36B
        MPLAB             :  MPLAB X v5.15
*/
/*
Copyright (c) [2012-2022] Microchip Technology Inc.  

    All rights reserved.

    You are permitted to use the accompanying software and its derivatives 
    with Microchip products. See the Microchip license agreement accompanying 
    this software, if any, for additional info regarding your rights and 
    obligations.
    
    MICROCHIP SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT 
    WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT 
    LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE, NON-INFRINGEMENT 
    AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT WILL MICROCHIP OR ITS
    LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT, NEGLIGENCE, STRICT 
    LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER LEGAL EQUITABLE 
    THEORY FOR ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES INCLUDING BUT NOT 
    LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES, 
    OR OTHER SIMILAR COSTS. 
    
    To the fullest extend allowed by law, Microchip and its licensors 
    liability will not exceed the amount of fees, if any, that you paid 
    directly to Microchip to use this software. 
    
    THIRD PARTY SOFTWARE:  Notwithstanding anything to the contrary, any 
    third party software accompanying this software is subject to the terms 
    and conditions of the third party's license agreement.  To the extent 
    required by third party licenses covering such third party software, 
    the terms of such license will apply in lieu of the terms provided in 
    this notice or applicable license.  To the extent the terms of such 
    third party licenses prohibit any of the restrictions described here, 
    such restrictions will not apply to such third party software.
*/

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>

#include "../memory/flash.h"
#include "boot_config.h"
#include "boot_process.h"

#include <stdio.h>

#define MEMCPY_BUFFERS_MATCH 0

extern uint32_t CRC32Bit(uint32_t crc, uint32_t input);
extern uint32_t CRCFlash(uint32_t crcSeed, uint32_t startAddress, uint32_t endAddress);

struct BOOT_VERIFY_APPLICATION_HEADER
{
    uint32_t crc32;
    uint32_t startAddress;
    uint32_t endAddress;
};

static const uint32_t applicationHeaderAddress = BOOT_CONFIG_APPLICATION_IMAGE_APPLICATION_HEADER_ADDRESS;

static inline bool isOdd(uint32_t number)
{
    return ((number & 0x00000001) == 0x00000001);
}

static void ApplicationHeaderRead(uint32_t sourceAddress, struct BOOT_VERIFY_APPLICATION_HEADER *applicationHeader)
{
    applicationHeader->crc32 = FLASH_ReadWord16(sourceAddress);
    applicationHeader->crc32 += ((uint32_t)FLASH_ReadWord16(sourceAddress + 2)) << 16;

    applicationHeader->startAddress = FLASH_ReadWord16(sourceAddress + 4);
    applicationHeader->startAddress += ((uint32_t)FLASH_ReadWord16(sourceAddress + 6)) << 16;

    applicationHeader->endAddress = FLASH_ReadWord16(sourceAddress + 8);
    applicationHeader->endAddress += ((uint32_t)FLASH_ReadWord16(sourceAddress + 10)) << 16;
}

bool BOOT_ImageVerify(enum BOOT_IMAGE image)
{   
    struct BOOT_VERIFY_APPLICATION_HEADER applicationHeader;
    uint32_t calculatedCRC;

    if( image >= BOOT_IMAGE_COUNT )
    {
        return false;
    }

    ApplicationHeaderRead(BOOT_ImageAddressGet(image, applicationHeaderAddress), &applicationHeader);

    if( isOdd(applicationHeader.startAddress) )
    {
        return false;
    }
    
    if( isOdd(applicationHeader.endAddress) )
    {
        return false;
    }

    if( applicationHeader.startAddress < BOOT_CONFIG_PROGRAMMABLE_ADDRESS_LOW )
    {
        return false;
    }

    if( applicationHeader.endAddress < BOOT_CONFIG_PROGRAMMABLE_ADDRESS_LOW )
    {
        return false;
    }

    if( applicationHeader.startAddress > BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH )
    {
        return false;
    }

    if( applicationHeader.endAddress > BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH )
    {
        return false;
    }
    
    if( applicationHeader.startAddress > applicationHeader.endAddress)
    {
        return false;
    }
    
    /* Is the application header outside the memory range to be verified? */
    if( (applicationHeaderAddress < applicationHeader.startAddress) ||
        (applicationHeaderAddress > applicationHeader.endAddress)
    )
    {
        calculatedCRC = CRCFlash(0x00000000, BOOT_ImageAddressGet(image, applicationHeader.startAddress), BOOT_ImageAddressGet(image, applicationHeader.endAddress));
    }
    else
    {
        /* If the application header is inside of the memory range to be verified, we
         * can't include the CRC value inside the CRC calculation, so we must
         * ignore the CRC value in the application header by pushing in 0s instead.
         */
        calculatedCRC = 0;
        if(applicationHeader.startAddress != applicationHeaderAddress)
        {
            calculatedCRC = CRCFlash(calculatedCRC, BOOT_ImageAddressGet(image, applicationHeader.startAddress), BOOT_ImageAddressGet(image, applicationHeaderAddress - 2));
        }
        /* push in 2 instructions of 0s to blank out the CRC signature in the
         * image applicationHeader.
         */
        calculatedCRC = CRCFlash(calculatedCRC, 0, 0);
        calculatedCRC = CRCFlash(calculatedCRC, 0, 0);
        /* resume with the rest of the application image. */
        calculatedCRC = CRCFlash(calculatedCRC, BOOT_ImageAddressGet(image, applicationHeaderAddress + 4), BOOT_ImageAddressGet(image, applicationHeader.endAddress));
    }
    
    return ( calculatedCRC  == applicationHeader.crc32 );
}

bool BOOT_Verify(void)
{
    return BOOT_ImageVerify(0);
}
