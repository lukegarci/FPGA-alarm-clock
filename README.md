# FPGA Alarm Clock

## Description
FPGA-based alarm clock with timekeeping, manual input, and 7-segment display support.  
The design implements a digital clock with an added alarm feature, built using SystemVerilog.  
It includes counters for seconds, minutes, and hours, as well as alarm counters, comparators,  
and a seven-segment display driver.

## Features
- Clock driver that divides the FPGA’s base frequency into 1-second intervals.  
- Counters for seconds, minutes, and hours with rollover logic.  
- Alarm functionality with adjustable time settings.  
- Seven-segment display output for hours and minutes.  
- Manual input buttons to set time and alarm values.  
- Comparator and sync modules for reliable operation.

## Project Structure
- **Counter Modules**: Track time in seconds, minutes, and hours.  
- **Alarm Counters**: Store user-defined alarm time.  
- **Comparator**: Compares clock time and alarm time.  
- **Parser**: Splits values into digits for display.  
- **SevenSeg Driver**: Drives the 7-segment display and outputs alarm match signals.  
- **Sync**: Ensures consistent timing across modules.  

## Simulation
The design was tested in ModelSim. Simulation verified:
- Clock counting functionality.  
- Alarm set and trigger operations.  
- Seven-segment display outputs.  

## Demo Video
[Alarm Clock FPGA Demo](https://media.oregonstate.edu/media/t/1_m4nufbzb)

## Author
Luke Garci  
garcil@oregonstate.edu
