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
## Vector vs Scalar Execution
![image](https://github.com/user-attachments/assets/942db1c5-3f6b-4779-84b7-6f39c3d1a856)

- The above scalar code would take almost 600+ instructions to execute whereas if we vectorize it, it would take just 5 instructions to finish the program
- With deep pipelining and parallel computing by using multiple ALUs, Vector execution would be consuming very less clock cycles compared to scalar execution
- 
---
---
## VPU Architecture
![image](https://github.com/user-attachments/assets/39a34ba2-cd96-48fe-9482-9d554302546a)

- 🏗 **VMIPS-based VPU design**: Modeled the VPU architecture with design cues from the VMIPS vector processor.
- 📥 **Load/Store Unit**: Capable of fetching one 32-bit element at a time from memory and delivering it to the vector register bank.
- 🧠 **Vector Register Bank**: 8 vector registers × 8 elements, supporting **16 read ports** and **8 write ports** for true parallelism.
- ⚙️ **Vector ALU (VALU)**: Built using **8 parallel ALUs** for performing element-wise Add, Sub, and Mul operations simultaneously.
- 🔀 **Vector Write Data MUX**: Selects data between Load/Store Unit and VALU for writeback into the register bank.
- 📏 **Vector size is fixed at 8 elements** for simplicity.
- 🧾 **VLR and VMR Registers**: 
  - Register `x31` used as **Vector Length Register (VLR)**.
  - Register `x30` used as **Vector Mask Register (VMR)**.
- 🧩 **Integrated with RISC-V Core**: The VPU is fully connected with a RISC-V processor, allowing vector instructions to be fetched and executed through a unified instruction memory.

---

## Partial Datapath of VPU integrated with RISC V
![image](https://github.com/user-attachments/assets/1f38d385-29b5-4f82-bbcc-cc5b24e18ac0)

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
3.4	Instruction formats for RISC-V processor
•	The processor provided will support the above instruction formats
•	The opcodes, funct3 and funct7 values can be referred from the reference sheet
3.5	Instruction format for Load.Vector Instruction: Load.V, Vd, [Rx]
funct7	reserved	Rx (5-bit)	reserved	reserved	Vd (3-bit)	Opcode
0000001	00000	xxxxx	000	00	xxx	1111111
•	Load.V, Vd, [Rx] is the instruction where Rx holds the starting address of the vector elements and Vd is the destination vector register
•	Since there are 8 vector registers, Vd can take any value between 0 to 7
•	Rx can take any value between 1 to 30
3.6	Instruction format for Add.Vector Instruction: Add.VV, Vd, Vx,Vy
funct7	Reserved	Vy (3-bit)	Reserved	Vx(3-bit)	reserved	Vd (3-bit)	opcode
0000000	00	xxx	00	xxx	00000	xxx	1111111
•	Add.VV, Vd, Vx,Vy is the instruction where Vx holds the first vector elements, Vy holds the second vector elements and Vd is the destination vector register
•	Element-wise Vx+Vy will be stored in Vd
•	Since there are 8 vector registers, Vx, Vy, Vd can take any value between 0 to 7
3.7	Instruction format for Sub.Vector Instruction: Sub.VV, Vd, Vx,Vy
funct7	Reserved	Vy (3-bit)	Reserved	Vx(3-bit)	reserved	Vd (3-bit)	opcode
0100000	00	xxx	00	xxx	00000	xxx	1111111
•	Sub.VV, Vd, Vx,Vy is the instruction where Vx holds the first vector elements, Vy holds the second vector elements and Vd is the destination vector register
•	Element-wise Vx-Vy will be stored in Vd
•	Since there are 8 vector registers, Vx, Vy, Vd can take any value between 0 to 7
3.8	Instruction format for Mul.Vector Instruction: Mul.VV, Vd, Vx,Vy
funct7	Reserved	Vy (3-bit)	Reserved	Vx(3-bit)	reserved	Vd (3-bit)	opcode
1100000	00	xxx	00	xxx	00000	xxx	1111111
•	Mul.VV, Vd, Vx,Vy is the instruction where Vx holds the first vector elements, Vy holds the second vector elements and Vd is the destination vector register
•	Element-wise Vx*Vy will be stored in Vd
•	Since there are 8 vector registers, Vx can take any value between 0 to 7
3.9	Instruction to change Vector Length (VLR) or Vector Mask(VMR):               addi R31/R30, r0, VL/VM;
Imm[11:0]	rs1	funct3	rd	Opcode
Vector Length or Mask	00000	000	30d or 31d	0010011
•	This is the normal addi instruction from RISC-V ISA.
•	By using addi instruction, we can change VMR or VLR.
•	We have to use 30 for VMR and 31 for VLR
•	The length or mask has to be given in the 12-bit Immediate field


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

