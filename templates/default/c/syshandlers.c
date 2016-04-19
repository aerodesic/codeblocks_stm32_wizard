/*
 * syshandlers.c
 *
 * Implement the needed system handler intercepts.
 */
[MAIN_INCLUDES]
void NMI_Handler(void)
{
}

/*
 * Hard Fault exceptions
 */
void HardFault_Handler(void)
{
    for (;;)
    {
    }
}

/*
 * Memory Manager exceptions
 */
void MemManage_Handler(void)
{
    for (;;)
    {
    }
}

/*
 * Bus Fault exceptions
 */
void BusFault_Handler(void)
{
    for (;;)
    {
    }
}

/*
 * Usage Fault exceptions.
 */
void UsageFault_Handler(void)
{
    for (;;)
    {
    }
}

/*
 * Debug Monitor exceptions.
 */
void DebugMon_Handler(void)
{
}

/*
 * System tick handler
 */
void SysTick_Handler(void)
{
#ifdef FreeRTOS
    osSystickHandler();
#endif
#ifdef HAL_MODULE_ENABLED
    HAL_IncTick(); 
#endif
}

