# RISCV PIPELINED PROCESSOR

<img width="1129" height="370" alt="PROCESSR_blk_1" src="https://github.com/user-attachments/assets/6f751c8a-7429-41b5-8a78-4308a442bec2" />



## Overview:

This project implements a **5-stage pipelined RISC-V Processor (RV32I)** in Verilog HDL. The processor supports a wide range of instructions from the RV32I instruction set, including I-type, R-type, S-type, B-type, J-type, and U-type (LUI only). It features a **fully functional forwarding unit and hazard detection unit (HDU)** to handle data hazards and control hazards efficiently.

The design is capable of executing simple C programs after converting them into RISC-V machine code. It is tested with `LW` and `SW` instructions to verify correct pipeline data forwarding and memory operations.

## Pipeline Stages:

The processor follows the classic 5-stage RISC-V pipeline structure:

1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execute (EX)**
4. **Memory Access (MEM)**
5. **Write Back (WB)**

## Supported Instruction Types:

* I-type
* R-type
* S-type
* B-type
* J-type
* U-type (Only LUI)

## Modules:

* **Program Counter (PC):** Keeps track of the next instruction address.
* **Instruction Memory (i\_mem):** Holds program instructions.
* **IF/ID, ID/EX, EX/MEM, MEM/WB Pipeline Registers:** Buffers to hold data between pipeline stages.
* **Instruction Decoder (inst\_decode):** Decodes fetched instruction into control signals and operands.
* **Control Unit (CU):** Generates control signals for the pipeline.
* **Register File (regFile):** 32 general-purpose registers.
* **ALU (Arithmetic Logic Unit):** Performs arithmetic and logic operations.
* **Data Memory (data\_mem):** For load/store instructions.
* **Forwarding Unit (FU):** Resolves data hazards by forwarding ALU/memory results.
* **Hazard Detection Unit (HDU):** Detects and stalls pipeline for load-use hazards.
* **Flush Unit:** Handles flushing in case of branch or jump mispredictions.

## Data Hazard Handling:

* **Forwarding Unit (FU):** Dynamically forwards data from EX/MEM or MEM/WB pipeline registers to resolve ALU data dependencies.
* **Hazard Detection Unit (HDU):** Stalls pipeline for Load-Use hazards to prevent reading stale data.

## Control Hazard Handling:

* **Flush Logic:** Flushes IF/ID pipeline register in case of taken branches or jumps to prevent wrong-path instructions from executing.

## Memory Specifications:

* **Instruction Memory:** 2^22 x 32-bit
* **Data Memory:** 32KB 

## Steps to Run a C Program on This Processor:

### Step 1: Write a C Program

```c
int main() {
    int a = 5;
    int b = 7;
    int c = a + b;
    return 0;
}
```

### Step 2: Compile to RISC-V Assembly

* Use **Compiler Explorer (godbolt.org)**
* Select RISC-V 32-bit target.
* Copy the generated assembly code.

### Step 3: Convert Assembly to Machine Code

* Paste the assembly into **Venus Simulator**.
* Assemble the code.
* Dump hexadecimal machine code.

### Step 4: Load into Instruction Memory

* Save the machine code in a `.hex` file (one instruction per line).
* Use Verilog `$readmemh` to load this into `i_mem` module.

### Step 5: Run Simulation

* Simulate in **ModelSim** or equivalent simulator.
* Observe register and memory writes in console output.

### Step 6: Verify Outputs

* Check register file writes (`regFile`) for correctness.
* Ensure load (`LW`) and store (`SW`) instructions access data memory accurately.


## References:

* [RISC-V ISA Specification](https://riscv.org/specifications/)
* "Computer Organization and Design" by David A. Patterson & John L. Hennessy.
* Online Verilog tutorials and RISC-V resources.
