# SOC_Peripherals

🌍 Welcome World!

Welcome to my **second GitHub repository** 🎉
This project is a **Simple System-on-Chip (SoC) RTL design** implemented using **Verilog HDL** and verified through **simulation waveforms**.

This repository is created to learn, design, and understand **basic SoC architecture**, including **processor execution, UART communication, and GPIO interfacing** at the RTL level.

📌 What is a SoC?

A **System-on-Chip (SoC)** integrates multiple components such as:
* A **processor core**
* **Communication peripherals** (UART)
* **Input/Output interfaces** (LEDs, switches)
into a **single digital system**, enabling complete functionality on one chip.

SoCs are widely used in:
* Embedded systems
* Microcontrollers
* FPGA-based designs
* Learning processor and RTL fundamentals

## Project Overview

This repository contains a **basic SoC design** with the following components:
* Simple **Processor Core**
* **UART interface** for serial communication
* **GPIO interface** (LEDs and switches)
* Testbench for functional verification

The SoC executes instructions sequentially, processes data internally, and communicates results through LEDs and UART.


## Processor Core

## Processor Signals

* `debug_pc[7:0]` – Program Counter (instruction address)
* `debug_acc[3:0]` – Accumulator (data register)
* `clk` – System clock
* `rst_n` – Active-low reset

## Processor Working

1. On reset, the processor initializes internal registers
2. After reset deassertion, the **Program Counter increments sequentially**
3. Instructions are fetched and executed one by one
4. The **Accumulator updates based on instruction execution**
5. Final computed values are forwarded to output peripherals


## GPIO Interface (LEDs & Switches)

## GPIO Signals

* `led[3:0]` – Output LEDs
* `sw[3:0]` – Input switches

## GPIO Working

* The processor writes computed results to the LED outputs
* Switch inputs can be used as external inputs to the SoC
* In simulation, the LED output reflects the processor’s final result



## UART Interface

## UART Signals

* `uart_tx` – Serial transmit line
* `uart_rx` – Serial receive line

## UART Working

* The processor transmits data through the UART transmitter
* `uart_tx` remains HIGH in idle state and toggles during transmission
* UART activity in the waveform confirms successful serial communication


## 📊 Simulation Results

From the simulation waveform:

* Clock and reset behave correctly
* Program Counter increments sequentially

  
  00 → 01 → 02 → ... → 0F
  
* Accumulator updates during execution

  
  0 → 3 → 8
  
* LED output reflects the final value

  
  led[3:0] = 8
  
* UART transmit line shows valid activity

✅ These results confirm **correct SoC functionality**.


## Features

* Simple SoC architecture in Verilog HDL
* Processor with Program Counter and Accumulator
* UART communication interface
* GPIO (LED & switch) integration
* Fully verified using behavioral simulation
* Beginner-friendly RTL design

# Output waveform
![image alt](https://github.com/Ramyasilica/SOC_Peripherals/blob/db1cd25f145ff68c8801e5f67631ab84c941f32e/Minisoc.jpg)


 🧾 Conclusion

This repository demonstrates a **working SoC RTL design** integrating a processor core, UART interface, and GPIO peripherals. The simulation waveform verifies correct instruction execution, data flow, and peripheral interaction, making this project a strong foundation for understanding SoC design principles.

---

## Thank you for visiting!

This is my **second repository**, and more advanced RTL and SoC projects will be added soon 🚀
Feel free to explore, learn, and suggest improvements.


