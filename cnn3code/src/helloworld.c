/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "xil_io.h"
#include "xil_printf.h"
#include "sleep.h"

/* From Vivado Address Editor */
#define CONV_BASEADDR  0x40000000
#define REG0_OFFSET   0x00

int main()
{
    u32 reg_val;
    u32 pixel;

    xil_printf("\r\nHello World from CNN Accelerator!\r\n");

    while (1)
    {
        reg_val = Xil_In32(CONV_BASEADDR + REG0_OFFSET);
        pixel   = reg_val & 0x00FFFFFF;

        xil_printf("Pixel Result = %lu\r\n", pixel);

        sleep(1);
    }

    return 0;
}
