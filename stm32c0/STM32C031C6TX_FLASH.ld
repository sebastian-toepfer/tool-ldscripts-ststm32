/*
******************************************************************************
**
** @file        : STM32C031C6TX_FLASH.ld
**
** @author      : Sebastian Toepfer
**
** @brief       : Linker script for STM32C031C6TX Device from STM32C0 series
**                      32Kbytes FLASH
**                      12Kbytes RAM
**
**                Set heap size, stack size and stack location according
**                to application requirements.
**
**                Set memory bank area and size if external memory is used
**
**  Target      : STMicroelectronics STM32
**
**  Distribution: The file is distributed as is, without any warranty
**                of any kind.
**
******************************************************************************
*/

/* Entry Point */
ENTRY(Reset_Handler)

/* Memories definition */
MEMORY
{
  FLASH  (rx): ORIGIN = 0x08000000, LENGTH = 32k
  SRAM  (xrw): ORIGIN = 0x20000000, LENGTH = 12k
}

_estack = ORIGIN(SRAM)+LENGTH(SRAM);

/* Specifying the necessary heap and stack sizes */
__max_heap_size  = 0x200;
__max_stack_size = 0x400;

/* Sections */
SECTIONS
{
  /* The program code and other data into "FLASH" Rom type memory */
  .text :
  {
    . = ALIGN(4);
    *(.isr_vector_tbl)
    *(.text)           /* .text sections (code) */
    *(.rodata)
    . = ALIGN(4);
    _etext = .;        /* define a global symbols at end of code */
  } > FLASH

  /* Used by the startup to initialize data */
  _sidata = LOADADDR(.data);

  /* Initialized data sections into "RAM" Ram type memory */
  .data :
  {
    . = ALIGN(4);
    _sdata = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    . = ALIGN(4);
    _edata = .;        /* define a global symbol at data end */

  } > SRAM AT > FLASH

  .bss :
  {
    . = ALIGN(4);
    _sbss = .;         /* define a global symbol at bss start */
    *(.bss)
    . = ALIGN(4);
    _ebss = .;         /* define a global symbol at bss end */
  } > SRAM
}
