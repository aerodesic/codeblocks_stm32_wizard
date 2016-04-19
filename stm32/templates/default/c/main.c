/*
 * main.c
 */
[MAIN_INCLUDES]
#include "main.h"
static void prvInitializeHardware(void);
[MAIN_BEFORE]
int main (void)
{
    prvInitializeHardware();
[MAIN_CONTENTS]
    return 0;
}
[MAIN_AFTER]
static void prvInitializeHardware(void)
{[MAIN_INITIALIZE_HARDWARE]}

