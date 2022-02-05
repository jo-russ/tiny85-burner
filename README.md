# tiny85-burner
Burn USB bootloader to atTiny85 (and some others too) witn arduino Nano3

1. Get nano3 board
2. Wire it up

![](https://raw.githubusercontent.com/jo-russ/tiny85-burner/main/at-tiny85-nano3.jpg)

3. Open in arduino and flash the ArduinoISP-Nano3.ino project
4. Get micronucleus firmware here: https://github.com/micronucleus/micronucleus.git
5. Edit paths in attiny85-burn-bootloader.bat (might look and adjust fuses settings there too if you need extra I/O pin instead of reset)
6. Run it
7. Download drivers: https://github.com/digistump/DigistumpArduino/releases
8. Enjoy your digispark clone!

More info on this project here: https://weekendrepair.wordpress.com/2022/02/05/flashing-usb-bootloader-to-at-tiny85-with-nano3-board/
