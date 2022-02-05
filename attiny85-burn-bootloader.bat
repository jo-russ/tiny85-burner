@echo off
set AVD="D:\~elektro.drive\!Arduino\bin\hardware\tools\avr\bin\avrdude.exe"
set AVD_CFG="D:\~elektro.drive\!Arduino\bin\hardware\tools\avr\etc\avrdude.conf"
set FIRMWARE=".\micronucleus\firmware\releases\t85_default.hex"

echo Burning fuses. Please wait...
set OPT=-v -v -v -v

: Baud Rate
set OPT=%OPT% -b 19200

: Port
set OPT=%OPT% -P COM5

: Device
set OPT=%OPT% -p attiny85

: Programmer
:usbtiny, stk500, avrisp, avr109, usbasp
set OPT=%OPT% -c stk500v1

: Erase Chip
set OPT=%OPT% -e

: Fuses
: 0 = enabled (!!!)
:
: Fuse extended byte:
: 0xFE = - - - -   - 1 1 0
:                        ^
:                        |
:                        +---- SELFPRGEN (enable self programming flash)
set OPT=%OPT% -Uefuse:w:0xfe:m

: Fuse high byte:
: 0xdd = 1 1 0 1   1 1 0 1
:        ^ ^ ^ ^   ^ \-+-/
:        | | | |   |   +------ BODLEVEL 2..0 (brownout trigger level -> 2.7V)
:        | | | |   +---------- EESAVE (preserve EEPROM on Chip Erase -> not preserved)
:        | | | +-------------- WDTON (watchdog timer always on -> disable)
:        | | +---------------- SPIEN (enable serial programming -> enabled)
:        | +------------------ DWEN (debug wire enable)
:        +-------------------- RSTDISBL (disable external reset -> enabled)
set OPT=%OPT% -Uhfuse:w:0xdd:m


: Fuse low byte:
: 0xe1 = 1 1 1 0   0 0 0 1
:        ^ ^ \+/   \--+--/
:        | |  |       +------- CKSEL 3..0 (clock selection -> HF PLL)
:        | |  +--------------- SUT 1..0 (BOD enabled, fast rising power)
:        | +------------------ CKOUT (clock output on CKOUT pin -> disabled)
:        +-------------------- CKDIV8 (divide clock by 8 -> don't divide)
set OPT=%OPT% -Ulfuse:w:0xe1:m


%AVD% -C %AVD_CFG% %OPT% -Uflash:w:%FIRMWARE%:i

echo Done!
