/**
  @Generated 16-bit Bootloader Source File

  @Company:
    Microchip Technology Inc.

  @File Name: 
    boot_application_header.c

  @Summary:
    This is the boot_application_header.c file generated using 16-bit Bootloader

  @Description:
    This header file provides implementations for driver APIs for all modules selected in the GUI.
    Generation Information :
        Product Revision  :  16-bit Bootloader - 1.19.1
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

#include "../memory/flash.h"
#include "boot_application_header.h"
#include "boot_config.h"
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "boot_process.h"

#define APPLICATION_RESET_REMAP_SIZE 4

/* Offset from the start of the application image to the application details section */
#define APPLICATION_DETAILS_OFFSET (BOOT_CONFIG_VERIFICATION_APPLICATION_HEADER_SIZE + APPLICATION_RESET_REMAP_SIZE)

enum BOOT_APPLICATION_DETAIL_ID_PRIVATE
{
    START_OF_APPLICATION_DETAIL_ID = 0x0000,
    END_OF_APPLICATION_DETAIL_ID = 0x0001
};   

/*
 * APPLICATION_DETAIL_PREFIX_SIZE is 6u
 * 2 bytes for the Detail ID
 * 4 bytes for the Detail Length
 */
#define APPLICATION_DETAIL_PREFIX_SIZE 6u

struct APPLICATION_DETAIL
{
    uint16_t id;
    uint32_t dataLength;
    uint32_t dataAddress;
};

static void ApplicationDetailPrefixGet(struct APPLICATION_DETAIL *entry, uint32_t address)
{
    entry->id = FLASH_ReadWord16(address);

    entry->dataLength = FLASH_ReadWord16(address + 2u);
    entry->dataLength += ((uint32_t)FLASH_ReadWord16(address + 4u)) << 16;

    entry->dataAddress = address + APPLICATION_DETAIL_PREFIX_SIZE;
}

static bool IsEven(uint32_t address)
{
    return (address & 0x01) == 0;
}

static bool ApplicationDetailDataRead(struct APPLICATION_DETAIL *entry, uint16_t* dataBuffer, size_t bufferLength)
{
    size_t dataRemaining = entry->dataLength;
    uint32_t dataAddress = entry->dataAddress;
    bool valid = IsEven(dataRemaining);

    if(valid)
    {
        if(dataRemaining > bufferLength)
        {
            dataRemaining = bufferLength;
        }

        while(dataRemaining)
        {
            *dataBuffer++ = FLASH_ReadWord16(dataAddress);
            dataAddress += 2;

            dataRemaining -= 2;
        }
    }

    return valid;
}

bool BOOT_ApplicationDetailGet(enum BOOT_IMAGE image, enum BOOT_APPLICATION_DETAIL_ID id, uint16_t* dataBuffer, size_t bufferLength)
{
    struct APPLICATION_DETAIL entry;
    uint32_t nextApplicationDetailAddress = BOOT_ImageAddressGet(image, BOOT_CONFIG_APPLICATION_IMAGE_APPLICATION_HEADER_ADDRESS + APPLICATION_DETAILS_OFFSET);
    bool entryFound = false;

    ApplicationDetailPrefixGet(&entry, nextApplicationDetailAddress);

    /* Verify the start of the expanded header */
    if((entry.id == START_OF_APPLICATION_DETAIL_ID) && (entry.dataLength == 2))
    {
        uint16_t countOfApplicationDetails;

        if(ApplicationDetailDataRead(&entry, &countOfApplicationDetails, 2))
        {
            unsigned int i;

            for(i=1; i<countOfApplicationDetails; i++)
            {
                nextApplicationDetailAddress += APPLICATION_DETAIL_PREFIX_SIZE + entry.dataLength;
                ApplicationDetailPrefixGet(&entry, nextApplicationDetailAddress);

                if(entry.id == id)
                {
                    entryFound = ApplicationDetailDataRead(&entry, dataBuffer, bufferLength);
                }

                if(entryFound == true)
                {
                    break;
                }
            }
        }
    }

    return entryFound;
}

bool BOOT_VersionNumberGet(enum BOOT_IMAGE image, uint32_t *versionNumber)
{
    memset(versionNumber, 0x00, sizeof(uint32_t));
    return BOOT_ApplicationDetailGet(image, BOOT_APPLICATION_DETAIL_ID_VERSION_NUMBER, (uint16_t*)versionNumber, sizeof(uint32_t));
}



