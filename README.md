# Communication Protocols in Verilog

---

## Overview

This repository contains a collection of communication protocol implementations written in Verilog HDL.

The goal of this repository is to strengthen RTL design skills, protocol understanding, finite state machine(FSM) based control logic, serial communication techniques, and verification through simulation testbenches.

---

## Implemented Protocols

### UART (Universal Asynchronous Receiver Transmitter)

- UART Transmitter
- UART Receiver
- Testbenches

### SPI (Serial Peripheral Interface)

- SPI Master
- SPI Slave
- Testbenches

### I2C (Inter-Integrated Circuit)

- I2C Master
- I2C Slave
- Testbenches

---

## Repository Structure

```text
Communication_Protocols_Verilog/
├── uart
│   ├── uart_tx.v
│   ├── uart_tx_tb.v
│   ├── uart_rx.v
│   └── uart_rx_tb.v
│
├── spi
│   ├── spi_master.v
│   ├── spi_master_tb.v
│   ├── spi_slave.v
│   └── spi_slave_tb.v
│
└── i2c
    ├── i2c_master.v
    ├── i2c_master_tb.v
    ├── i2c_slave.v
    └── i2c_slave_tb.v
```

---

## Learning Outcomes

Through these projects, the following concepts are practiced:

- Finite State Machine (FSM) Design
- Serial Communication Protocols
- RTL Coding in Verilog
- State Transition Logic
- Data Transmission and Reception
- Verification using Testbenches
- Digital System Design Methodology

---

## Tools

- Verilog HDL
- Vivado Simulator

---

## Future Enhancements

- Baud Rate Generator
- Advanced UART Controller
- SPI Multi-Slave Support
- Ethernet MAC Controller

---

## Author

Jaspreet Arora

Electronics and Communication Engineering