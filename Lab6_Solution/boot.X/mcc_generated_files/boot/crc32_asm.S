/**
  @Generated 16-bit Bootloader Source File

  @Company:
    Microchip Technology Inc.

  @File Name: 
    crc32_asm.S

  @Summary:
    This is the crc32_asm.S file generated using 16-bit Bootloader

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

.include "xc.inc"
   
.section *,bss
CRCTable: .space 1024
  
.text
        
CRCTableData:
.long     0x00000000, 0x814141AB, 0x83C3C2FD, 0x02828356 
.long     0x86C6C451, 0x078785FA, 0x050506AC, 0x84444707 
.long     0x8CCCC909, 0x0D8D88A2, 0x0F0F0BF4, 0x8E4E4A5F 
.long     0x0A0A0D58, 0x8B4B4CF3, 0x89C9CFA5, 0x08888E0E 
.long     0x98D8D3B9, 0x19999212, 0x1B1B1144, 0x9A5A50EF 
.long     0x1E1E17E8, 0x9F5F5643, 0x9DDDD515, 0x1C9C94BE 
.long     0x14141AB0, 0x95555B1B, 0x97D7D84D, 0x169699E6    
.long     0x92D2DEE1, 0x13939F4A, 0x11111C1C, 0x90505DB7 
.long     0xB0F0E6D9, 0x31B1A772, 0x33332424, 0xB272658F 
.long     0x36362288, 0xB7776323, 0xB5F5E075, 0x34B4A1DE 
.long     0x3C3C2FD0, 0xBD7D6E7B, 0xBFFFED2D, 0x3EBEAC86 
.long     0xBAFAEB81, 0x3BBBAA2A, 0x3939297C, 0xB87868D7 
.long     0x28283560, 0xA96974CB, 0xABEBF79D, 0x2AAAB636 
.long     0xAEEEF131, 0x2FAFB09A, 0x2D2D33CC, 0xAC6C7267 
.long     0xA4E4FC69, 0x25A5BDC2, 0x27273E94, 0xA6667F3F 
.long     0x22223838, 0xA3637993, 0xA1E1FAC5, 0x20A0BB6E 
.long     0xE0A08C19, 0x61E1CDB2, 0x63634EE4, 0xE2220F4F 
.long     0x66664848, 0xE72709E3, 0xE5A58AB5, 0x64E4CB1E 
.long     0x6C6C4510, 0xED2D04BB, 0xEFAF87ED, 0x6EEEC646
.long     0xEAAA8141, 0x6BEBC0EA, 0x696943BC, 0xE8280217 
.long     0x78785FA0, 0xF9391E0B, 0xFBBB9D5D, 0x7AFADCF6 
.long     0xFEBE9BF1, 0x7FFFDA5A, 0x7D7D590C, 0xFC3C18A7
.long     0xF4B496A9, 0x75F5D702, 0x77775454, 0xF63615FF
.long     0x727252F8, 0xF3331353, 0xF1B19005, 0x70F0D1AE
.long     0x50506AC0, 0xD1112B6B, 0xD393A83D, 0x52D2E996
.long     0xD696AE91, 0x57D7EF3A, 0x55556C6C, 0xD4142DC7
.long     0xDC9CA3C9, 0x5DDDE262, 0x5F5F6134, 0xDE1E209F 
.long     0x5A5A6798, 0xDB1B2633, 0xD999A565, 0x58D8E4CE
.long     0xC888B979, 0x49C9F8D2, 0x4B4B7B84, 0xCA0A3A2F
.long     0x4E4E7D28, 0xCF0F3C83, 0xCD8DBFD5, 0x4CCCFE7E
.long     0x44447070, 0xC50531DB, 0xC787B28D, 0x46C6F326
.long     0xC282B421, 0x43C3F58A, 0x414176DC, 0xC0003777
.long     0x40005999, 0xC1411832, 0xC3C39B64, 0x4282DACF
.long     0xC6C69DC8, 0x4787DC63, 0x45055F35, 0xC4441E9E
.long     0xCCCC9090, 0x4D8DD13B, 0x4F0F526D, 0xCE4E13C6
.long     0x4A0A54C1, 0xCB4B156A, 0xC9C9963C, 0x4888D797
.long     0xD8D88A20, 0x5999CB8B, 0x5B1B48DD, 0xDA5A0976
.long     0x5E1E4E71, 0xDF5F0FDA, 0xDDDD8C8C, 0x5C9CCD27
.long     0x54144329, 0xD5550282, 0xD7D781D4, 0x5696C07F
.long     0xD2D28778, 0x5393C6D3, 0x51114585, 0xD050042E
.long     0xF0F0BF40, 0x71B1FEEB, 0x73337DBD, 0xF2723C16
.long     0x76367B11, 0xF7773ABA, 0xF5F5B9EC, 0x74B4F847
.long     0x7C3C7649, 0xFD7D37E2, 0xFFFFB4B4, 0x7EBEF51F
.long     0xFAFAB218, 0x7BBBF3B3, 0x793970E5, 0xF878314E
.long     0x68286CF9, 0xE9692D52, 0xEBEBAE04, 0x6AAAEFAF
.long     0xEEEEA8A8, 0x6FAFE903, 0x6D2D6A55, 0xEC6C2BFE
.long     0xE4E4A5F0, 0x65A5E45B, 0x6727670D, 0xE66626A6
.long     0x622261A1, 0xE363200A, 0xE1E1A35C, 0x60A0E2F7
.long     0xA0A0D580, 0x21E1942B, 0x2363177D, 0xA22256D6
.long     0x266611D1, 0xA727507A, 0xA5A5D32C, 0x24E49287
.long     0x2C6C1C89, 0xAD2D5D22, 0xAFAFDE74, 0x2EEE9FDF
.long     0xAAAAD8D8, 0x2BEB9973, 0x29691A25, 0xA8285B8E
.long     0x38780639, 0xB9394792, 0xBBBBC4C4, 0x3AFA856F
.long     0xBEBEC268, 0x3FFF83C3, 0x3D7D0095, 0xBC3C413E
.long     0xB4B4CF30, 0x35F58E9B, 0x37770DCD, 0xB6364C66
.long     0x32720B61, 0xB3334ACA, 0xB1B1C99C, 0x30F08837
.long     0x10503359, 0x911172F2, 0x9393F1A4, 0x12D2B00F
.long     0x9696F708, 0x17D7B6A3, 0x155535F5, 0x9414745E
.long     0x9C9CFA50, 0x1DDDBBFB, 0x1F5F38AD, 0x9E1E7906
.long     0x1A5A3E01, 0x9B1B7FAA, 0x9999FCFC, 0x18D8BD57
.long     0x8888E0E0, 0x09C9A14B, 0x0B4B221D, 0x8A0A63B6
.long     0x0E4E24B1, 0x8F0F651A, 0x8D8DE64C, 0x0CCCA7E7
.long     0x044429E9, 0x85056842, 0x8787EB14, 0x06C6AABF
.long     0x8282EDB8, 0x03C3AC13, 0x01412F45, 0x80006EEE
    
//******************************************************************************
// void void PopulateCRCTable(void)
//
// Working registers used: W0-W2
// Modifies TBLPAG, but saves/restores original value.
//
// Loads RAM variables for CRC calculation.  Needs to be called before the
// CRCFlash() routine can be called.
//
// This is kept as a separate function instead of inlined into the CRCFlash so
// that it can be replaced by a formulaic approach instead of a table copy to 
// reduce flash if desired.  This would increase the verification time but
// reduce the flash foot print.
//******************************************************************************
PopulateCRCTable:
    //Load KTable data from flash into RAM variable for quicker access.  This
    // burns quite a bit of RAM, but saves a good amount of time.
    push.d W0
    push W2

    mov     #CRCTable, W0
    mov     tblpage(#CRCTableData), W1
    mov     W1, _TBLPAG
    mov     tbloffset(#CRCTableData), W1
    mov     #0x200, W2
CRCTableCopyLoop:
    tblrdl  [W1++], [W0++]
    dec     W2, W2
    bra     NZ, CRCTableCopyLoop
            
    pop W2
    pop.d W0
    return
              
//******************************************************************************
// uint32_t CRCFlash(uint32_t crcSeed, uint32_t startAddress, uint32_t endAddress)
// 
// This function will calculate the CRC32 value of the flash between the
// specified start and end address (inclusive).  If start address is 0,
// one instruction of 0s will be injected instead.
//******************************************************************************           
.equ paramStartAddressLow, W2
.equ paramStartAddressHigh, W3
.equ paramStartAddress, paramStartAddressLow
            
.equ paramEndAddressLow, W4
.equ paramEndAddressHigh, W5
.equ paramEndAddress, paramEndAddressLow
            
.equ crcLow, W0
.equ crcHigh, W1
.equ crc, crcLow
            
.equ currentAddressLow, W6
.equ currentAddressHigh, W7
.equ currentAddress, currentAddressLow
            
.equ endAddressLow, W8
.equ endAddressHigh, W9
.equ endAddress, endAddressLow
            
.equ instructionDataLow, W2
.equ instructionDataHigh, W3
.equ instructionData, instructionDataLow
            
.equ crcTableIndex, W5
.equ crcTableOffset, W5
.equ crcTablePointer, W5
.equ crcTableAddress, W4
            
.global _CRCFlash
_CRCFlash:
    push    TBLPAG
    push.d  W8

    call    PopulateCRCTable
            
    //Add 2 to the end address to make it exclusive instead of inclusive
    mov.d   paramEndAddress, endAddress
    add     #2, endAddressLow
    addc    #0, endAddressHigh

    mov.d   paramStartAddress, currentAddress
            
    mov     #CRCTable, crcTableAddress
        
    //if startAddress = 0, then inject one instruction of zeros instead of
    // reading the data.
    add     #0,currentAddressLow
    bra     NZ, CRCCheckAddresses
    add     #0,currentAddressHigh
    bra     NZ, CRCCheckAddresses
            
    clr     instructionDataLow
    clr     instructionDataHigh
    bra     CRCCalc
          
CRCCheckAddresses:
    //if(currentAddress == endAddress) { return crc; }
    cp      currentAddressLow, endAddressLow
    bra     NZ, CRCLoop
    cp      currentAddressHigh, endAddressHigh
    bra     Z, CRCLoopEnd
   
CRCLoop:  

    //Read instruction data for processing
    mov     currentAddressHigh, TBLPAG
    tblrdl  [currentAddressLow], instructionDataLow
    tblrdh  [currentAddressLow], instructionDataHigh
            
    //Each instruction has 4 bytes we need to calculate the CRC against.

CRCCalc:
    //First byte calculation: crc = CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[0] ] ^ (crc << 8)
    //((crc >> 24) & 0xFF)
    lsr     crcHigh, #8, crcTableIndex
    //((crc >> 24) & 0xFF) ^ instructionByte[0]
    xor.b   crcTableIndex, instructionDataLow, crcTableIndex
    //Table is 32-bits per entry so multiply by 4 to get offset from index
    sl      crcTableIndex, #2, crcTableOffset
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[0] ]
    add     crcTableAddress, crcTableOffset, crcTablePointer
    //(crc << 8)
    sl      crcHigh, #8, crcHigh
    swap    crcLow
    xor.b   crcLow, crcHigh, crcHigh
    clr.b   crcLow        
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[0] ] ^ (crc << 8)
    xor     crcLow, [crcTablePointer++], crcLow
    xor     crcHigh, [crcTablePointer], crcHigh
            
    //Second byte calculation: crc = CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[1] ] ^ (crc << 8)
    //((crc >> 24) & 0xFF) ^ instructionByte[1]
    xor     instructionDataLow, crcHigh, crcTableIndex
    lsr     crcTableIndex, #8, crcTableIndex
    //Table is 32-bits per entry so multiply by 4 to get offset from index
    sl      crcTableIndex, #2, crcTableOffset
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[1] ]
    add     crcTableAddress, crcTableOffset, crcTablePointer
    //(crc << 8)
    sl      crcHigh, #8, crcHigh
    swap    crcLow
    xor.b   crcLow, crcHigh, crcHigh
    clr.b   crcLow
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[1] ] ^ (crc << 8)
    xor     crcLow, [crcTablePointer++], crcLow
    xor     crcHigh, [crcTablePointer], crcHigh

    //Third byte calculation: crc = CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[2] ] ^ (crc << 8)
    //((crc >> 24) & 0xFF)
    lsr     crcHigh, #8, crcTableOffset
    //((crc >> 24) & 0xFF) ^ instructionByte[2]
    xor.b   crcTableOffset, instructionDataHigh, crcTableOffset
    //Table is 32-bits per entry so multiply by 4 to get offset from index    
    sl      crcTableOffset, #2, crcTableOffset
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[2] ]
    add     crcTableAddress, crcTableOffset, crcTablePointer
    //(crc << 8)
    sl      crcHigh, #8, crcHigh
    swap    crcLow
    xor.b   crcLow, crcHigh, crcHigh
    clr.b   crcLow
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[2] ] ^ (crc << 8)
    xor     crcLow, [crcTablePointer++], crcLow
    xor     crcHigh, [crcTablePointer], crcHigh
       
    //Forth byte calculation: crc = CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[3] ] ^ (crc << 8)
    //((crc >> 24) & 0xFF) ^ instructionByte[3]
    xor     instructionDataHigh, crcHigh, crcTableOffset
    lsr     crcTableOffset, #8, crcTableOffset
    //Table is 32-bits per entry so multiply by 4 to get offset from index
    sl      crcTableOffset, #2, crcTableOffset
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[3] ]
    add     crcTableAddress, crcTableOffset, crcTablePointer
    //(crc << 8)
    sl      crcHigh, #8, crcHigh
    swap    crcLow
    xor.b   crcLow, crcHigh, crcHigh
    clr.b   crcLow
    //CRCTable[ ((crc >> 24) & 0xFF) ^ instructionByte[3] ] ^ (crc << 8)
    xor     crcLow, [crcTablePointer++], crcLow
    xor     crcHigh, [crcTablePointer], crcHigh
         
    //currentAddress += 2
    add     #2, currentAddressLow
    addc    #0, currentAddressHigh

    //while(currentAddress != endAddress)
    cp      currentAddressLow, endAddressLow
    bra     NZ, CRCLoop
    cp      currentAddressHigh, endAddressHigh
    bra     NZ, CRCLoop
            
CRCLoopEnd:
    
    pop.d   W8
    pop     TBLPAG
	return
