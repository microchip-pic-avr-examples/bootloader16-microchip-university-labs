/**
  @Generated 16-bit Bootloader Source File

  @Company:
    Microchip Technology Inc.

  @File Name: 
    interrupts.S

  @Summary:
    This is the interrupts.S file generated using 16-bit Bootloader

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
/* This file lists all of the interrupts in the system and how they will be
 * handled.  This file is use by both the hardware interrupt table and the 
 * user remap table to make sure they both stay in sync.
 *
 * IMPORTANT NOTE: Once a boot loader is deployed using this file, this file 
 * can not be modified in the end application.  Take care when selecting how to 
 * handle each interrupt at the development of the boot loader.
 *
 * Options:
 *   remap_to_application - this forwards the interrupt directly to the
 *   user application.  Each interrupt forwarded will require 2 instructions
 *   for the GOTO in the user reamapping table thus taking up 6 bytes of program
 *   memory each.  This is the safest option for all interrupts implemented in 
 *   hardware.  
 *
 *   keep_in_bootloader - this option will keep the interrupt in the boot
 *   loader.  If the interrupt function is defined, it will just to that
 *   function.  If it is not defined, it will jump to the default interrupt 
 *   handler function.
 *
 *   remap_to_application_default - this forwards the interrupt directly to the
 *   user application's default interrupt handler rather than the specified 
 *   unique interrupt vector.  This option is useful for interrupts that the
 *   application does not expect to use.  Since each interrupt forwarded by the
 *   remap_to_application option takes 2 instruction words, can get quite costly
 *   to forward all possible interrupts.  Interrupts forwarded with this option
 *   do not take any additional code space to forward.  Since multiple
 *   interrupts will be forwarded to the same vector, the user code will have to
 *   check to see which interrupt triggered to process them accordingly.  
 */
    
#ifdef REMAP_TABLE    

REMAP_TO_APPLICATION   OscillatorFail       
REMAP_TO_APPLICATION   AddressError       
REMAP_TO_APPLICATION   NVMError       
REMAP_TO_APPLICATION   StackError       
REMAP_TO_APPLICATION   MathError       
REMAP_TO_APPLICATION_DEFAULT   ReservedTrap5       
REMAP_TO_APPLICATION   GeneralError       
REMAP_TO_APPLICATION_DEFAULT   ReservedTrap7       
REMAP_TO_APPLICATION   INT0Interrupt       
REMAP_TO_APPLICATION   IC1Interrupt       
REMAP_TO_APPLICATION   OC1Interrupt       
REMAP_TO_APPLICATION   T1Interrupt       
REMAP_TO_APPLICATION   DMA0Interrupt       
REMAP_TO_APPLICATION   IC2Interrupt       
REMAP_TO_APPLICATION   OC2Interrupt       
REMAP_TO_APPLICATION   T2Interrupt       
REMAP_TO_APPLICATION   T3Interrupt       
REMAP_TO_APPLICATION   SPI1Interrupt       
REMAP_TO_APPLICATION   SPI1TXInterrupt       
REMAP_TO_APPLICATION   U1RXInterrupt       
REMAP_TO_APPLICATION   U1TXInterrupt       
REMAP_TO_APPLICATION   ADC1Interrupt       
REMAP_TO_APPLICATION   DMA1Interrupt       
REMAP_TO_APPLICATION   NVMInterrupt       
REMAP_TO_APPLICATION   SI2C1Interrupt       
REMAP_TO_APPLICATION   MI2C1Interrupt       
REMAP_TO_APPLICATION   CompInterrupt       
REMAP_TO_APPLICATION   IOCInterrupt       
REMAP_TO_APPLICATION   INT1Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt21       
REMAP_TO_APPLICATION_DEFAULT   Interrupt22       
REMAP_TO_APPLICATION_DEFAULT   Interrupt23       
REMAP_TO_APPLICATION   DMA2Interrupt       
REMAP_TO_APPLICATION   OC3Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt26       
REMAP_TO_APPLICATION_DEFAULT   Interrupt27       
REMAP_TO_APPLICATION_DEFAULT   Interrupt28       
REMAP_TO_APPLICATION   INT2Interrupt       
REMAP_TO_APPLICATION   U2RXInterrupt       
REMAP_TO_APPLICATION   U2TXInterrupt       
REMAP_TO_APPLICATION   SPI2Interrupt       
REMAP_TO_APPLICATION   SPI2TXInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt34       
REMAP_TO_APPLICATION_DEFAULT   Interrupt35       
REMAP_TO_APPLICATION   DMA3Interrupt       
REMAP_TO_APPLICATION   IC3Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt38       
REMAP_TO_APPLICATION_DEFAULT   Interrupt39       
REMAP_TO_APPLICATION_DEFAULT   Interrupt40       
REMAP_TO_APPLICATION   OC5Interrupt       
REMAP_TO_APPLICATION   OC6Interrupt       
REMAP_TO_APPLICATION   CCT3Interrupt       
REMAP_TO_APPLICATION   CCT4Interrupt       
REMAP_TO_APPLICATION   PMPInterrupt       
REMAP_TO_APPLICATION   DMA4Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt47       
REMAP_TO_APPLICATION_DEFAULT   Interrupt48       
REMAP_TO_APPLICATION   SI2C2Interrupt       
REMAP_TO_APPLICATION   MI2C2Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt51       
REMAP_TO_APPLICATION_DEFAULT   Interrupt52       
REMAP_TO_APPLICATION   INT3Interrupt       
REMAP_TO_APPLICATION   INT4Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt55       
REMAP_TO_APPLICATION_DEFAULT   Interrupt56       
REMAP_TO_APPLICATION_DEFAULT   Interrupt57       
REMAP_TO_APPLICATION   SPI1RXInterrupt       
REMAP_TO_APPLICATION   SPI2RXInterrupt       
REMAP_TO_APPLICATION   SPI3RXInterrupt       
REMAP_TO_APPLICATION   DMA5Interrupt       
REMAP_TO_APPLICATION   RTCCInterrupt       
REMAP_TO_APPLICATION   CCP1Interrupt       
REMAP_TO_APPLICATION   CCP2Interrupt       
REMAP_TO_APPLICATION   U1ErrInterrupt       
REMAP_TO_APPLICATION   U2ErrInterrupt       
REMAP_TO_APPLICATION   CRCInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt68       
REMAP_TO_APPLICATION_DEFAULT   Interrupt69       
REMAP_TO_APPLICATION_DEFAULT   Interrupt70       
REMAP_TO_APPLICATION_DEFAULT   Interrupt71       
REMAP_TO_APPLICATION   LVDInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt73       
REMAP_TO_APPLICATION_DEFAULT   Interrupt74       
REMAP_TO_APPLICATION_DEFAULT   Interrupt75       
REMAP_TO_APPLICATION_DEFAULT   Interrupt76       
REMAP_TO_APPLICATION   CTMUInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt78       
REMAP_TO_APPLICATION_DEFAULT   Interrupt79       
REMAP_TO_APPLICATION_DEFAULT   Interrupt80       
REMAP_TO_APPLICATION_DEFAULT   Interrupt81       
REMAP_TO_APPLICATION_DEFAULT   Interrupt82       
REMAP_TO_APPLICATION_DEFAULT   Interrupt83       
REMAP_TO_APPLICATION   I2C1BCInterrupt       
REMAP_TO_APPLICATION   I2C2BCInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt86       
REMAP_TO_APPLICATION_DEFAULT   Interrupt87       
REMAP_TO_APPLICATION_DEFAULT   Interrupt88       
REMAP_TO_APPLICATION_DEFAULT   Interrupt89       
REMAP_TO_APPLICATION   SPI3Interrupt       
REMAP_TO_APPLICATION   SPI3TXInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt92       
REMAP_TO_APPLICATION_DEFAULT   Interrupt93       
REMAP_TO_APPLICATION   CCP3Interrupt       
REMAP_TO_APPLICATION   CCP4Interrupt       
REMAP_TO_APPLICATION   CLC1Interrupt       
REMAP_TO_APPLICATION   CLC2Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt98       
REMAP_TO_APPLICATION_DEFAULT   Interrupt99       
REMAP_TO_APPLICATION_DEFAULT   Interrupt100       
REMAP_TO_APPLICATION   CCT1Interrupt       
REMAP_TO_APPLICATION   CCT2Interrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt103       
REMAP_TO_APPLICATION_DEFAULT   Interrupt104       
REMAP_TO_APPLICATION_DEFAULT   Interrupt105       
REMAP_TO_APPLICATION   FSTInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt107       
REMAP_TO_APPLICATION   ECCInterrupt       
REMAP_TO_APPLICATION   I2C3BCInterrupt       
REMAP_TO_APPLICATION   RTCCTSInterrupt       
REMAP_TO_APPLICATION_DEFAULT   Interrupt111       
REMAP_TO_APPLICATION_DEFAULT   Interrupt112       
REMAP_TO_APPLICATION_DEFAULT   Interrupt113       
REMAP_TO_APPLICATION_DEFAULT   Interrupt114       
REMAP_TO_APPLICATION_DEFAULT   Interrupt115       
REMAP_TO_APPLICATION_DEFAULT   Interrupt116       
REMAP_TO_APPLICATION   JTAGInterrupt       

#endif
