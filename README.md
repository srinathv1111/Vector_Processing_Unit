# Vector_Processing_Unit

# ⚙️ Vector Processing Unit (VPU) with RISC-V Integration

This repository contains the **design and integration of a Vector Processing Unit (VPU)** with a **basic RISC-V processor**, written in **Verilog**. The project demonstrates parallel vector computation using a custom vector ALU and load/store architecture, enabling high-throughput operations suitable for scientific computing and signal processing applications.

---

## 📌 Project Overview

- 🚀 **Parallel Execution** of vector operations (Add, Sub, Mul) using 8-lane Vector ALU
- 📥 **Vector Load/Store Unit (VLS)** to handle memory interactions
- 🧠 **Vector Register Bank** with 8 registers, each holding 8 elements
- 🧩 **Integrated with RISC-V** single-cycle processor
- ⚡ **Configurable Vector Length (VLR)** and **Vector Masking (VMR)** for flexible operations

---

## 📚 Table of Contents

- [Project Objective](#project-objective)
- [Architecture](#architecture)
- [Instruction Set](#instruction-set)
- [Components](#components)
- [Performance Summary](#performance-summary)
- [How to Run](#how-to-run)
- [Contributors](#contributors)

---

## 🎯 Project Objective

Design a **Vector Processing Unit (VPU)** capable of:

- Handling element-wise vector operations in parallel
- Supporting vector length up to 8
- Enabling masked operations via VMR
- Interfacing with a RISC-V core and memory system
- Demonstrating significant performance gain over scalar execution

---

## 🏗️ Architecture

- **Vector Register Bank (VRB):** 8 registers × 8 elements
- **Vector ALU:** 8 parallel ALU instances (Add/Sub/Mul)
- **Vector Load Store Unit (VLS):** FSM-controlled memory interface
- **Control Unit:** Handles standard and vector instructions (opcode = `1111111`)
- **Memory-mapped I/O:** For loading vectors and executing operations

---

## 🧾 Instruction Set

### ➕ `Add.VV Vd, Vx, Vy`
Adds elements of Vx and Vy, stores result in Vd  
Opcode: `1111111`, funct7: `0000000`

### ➖ `Sub.VV Vd, Vx, Vy`
Subtracts elements of Vy from Vx, stores in Vd  
Opcode: `1111111`, funct7: `0100000`

### ✖️ `Mul.VV Vd, Vx, Vy`
Multiplies Vx and Vy, stores result in Vd  
Opcode: `1111111`, funct7: `1100000`

### 📥 `Load.V Vd, [Rx]`
Loads vector from memory address in Rx into Vd  
Opcode: `1111111`, funct7: `0000001`

### 🛠️ Set VLR and VMR
Use standard `addi` instructions on registers `r31` (VLR) and `r30` (VMR)

---

## 🧪 How to Run

1. Clone the repository and open it in **Xilinx Vivado**
2. Add all Verilog modules to the project
3. Simulate using the provided `tb.v` testbench
4. Check waveform to verify vector operations (Add/Sub/Mul/Load)
5. For synthesis:
   - Run synthesis and implementation
   - Analyze power, timing, and utilization reports

---


## 📜 License

This project is for academic use only. Feel free to reuse with attribution.

---

