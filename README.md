# Time Based Reaction Game 
## Overview
This project implements a single-player reaction time game using Verilog HDL.
The system measures how quickly a user responds to a visual cue after a random delay.
It is designed to demonstrate FSM-based control, accurate timing, and 7-segment display interfacing on FPGA.
The player presses a start button, waits for a random delay, and reacts as soon as an LED turns ON. The measured reaction time is displayed in milliseconds.

## Features
- Randomized reaction delay generation
- Accurate reaction time measurement (1 ms resolution)
- Early reaction detection with error indication
- LED-based visual cue
- 4-digit seven-segment display output
- Modular and clean RTL design

## Game Flow
- Player presses START button
- System waits for a random delay
- LED turns ON indicating GO
- Player presses REACT button
- Reaction time is calculated and displayed
- Early presses are flagged as an error

## Modules
- reaction_timer_top.v – Top-level module integrating all submodules
- main.v – FSM control logic for the reaction game 
- clock_1ms.v – Generates a 1 ms timing tick from system clock
- random_delay.v – Pseudo-random delay generator
- reaction_timer.v – Reaction time counter (ms resolution) 
- seven_seg_driver.v – 4-digit seven-segment display controller

## Simulation 
Simulated using Xlinix Vivado and implemented on Nexys 4 DDR

## Documentation
Detailed report available in: `Report.pdf`
testbench.v – Testbench for functional verification
