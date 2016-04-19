/*
 * target.ld prototype file for STM32.  This is run through a macro
 * substitution before creating the final target.ld file.
 *
 * This file has been configured for the [LD_PROCESSOR] processor.
 */

/* Entry Point from the startup code. */
ENTRY(Reset_Handler)

_estack = [LD_RAMEND];    /* end of RAM */

_Min_Heap_Size = [LD_MINHEAP];
_Min_Stack_Size = [LD_MINSTACK];

/* Specify the memory areas */
MEMORY
{[LD_SEGMENT_LIST]}

/* Define output sections */
SECTIONS
{
  /* Interrupt vectors */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } >FLASH

  /* Program code */
  .text :
  {
    . = ALIGN(4);
    *(.text)           /* Base .text section */
    *(.text*)          /* Other .text* sections */
    *(.glue_7)         /* arm/thumb code */
    *(.glue_7t)        /* thumb/arm code */
    *(.eh_frame)

    KEEP (*(.init))
    KEEP (*(.fini))

    . = ALIGN(4);
    _etext = .;        /* Globals are at end of text */
  } >FLASH

  /* Initialized constant area */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } >FLASH

  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH
  .ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >FLASH

  .preinit_array     :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } >FLASH

  .init_array :
  {
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
  } >FLASH

  .fini_array :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } >FLASH

  /* Initialized data setup */ 
  _sidata = LOADADDR(.data);

  /* Initialized data goes into RAM but it copied from FLASH */
  .data : 
  {
    . = ALIGN(4);
    _sdata = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */

    . = ALIGN(4);
    _edata = .;        /* define a global symbol at data end */
  } >RAM AT> FLASH

  
  /* Uninitialized data goes only in RAM */
  . = ALIGN(4);
  .bss :
  {
    _sbss = .;
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)

    . = ALIGN(4);
    _ebss = .;
    __bss_end__ = _ebss;
  } >RAM

  /* User heap */
  ._user_heap_stack :
  {
    . = ALIGN(4);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(4);
  } >RAM

  

  /* Discard stuff from standard libraries */
  /DISCARD/ :
  {
    libc.a ( * )
    libm.a ( * )
    libgcc.a ( * )
  }

  .ARM.attributes 0 : { *(.ARM.attributes) }
}
