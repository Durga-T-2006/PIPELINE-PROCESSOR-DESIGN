COMPANY : CODTECH IT SOLUTIONS

NAME : AARANYA M

INTERN ID : CT04DH854

DOMAIN : VLSI

DURATION : 4 WEEKS

MENTOR : NEELA SANTHOSH

DESCRIPTION OF TASK-3 :As part of the CodTech internship program, Task 3 was to design and simulation of a 4-stage pipelined processor capable of executing basic instructions such as ADD, SUB, and LOAD.

The primary objective of this task was to understand and implement pipelining, which is a fundamental technique used in modern processor architectures to improve instruction throughput.

Objective:

To develop a functional 4-stage pipelined processor model and verify its operation using simulation tools. The processor was required to handle basic instruction types and show the correct execution across each

pipeline stage.

Pipeline Stages: The processor was designed using the following four pipeline stages:

Instruction Fetch (IF) – Retrieves the instruction from memory.

Instruction Decode (ID) – Decodes the instruction and reads required operands.

Execution (EX) – Performs the arithmetic or logic operation.

Memory/Write Back (MEM/WB) – Either accesses memory (in case of LOAD) or writes the result back to the register file.

Implementation:

The processor design was implemented using Verilog HDL (Hardware Description Language). Each pipeline stage was created as a separate module, with pipeline registers introduced between stages to hold intermediate

values and maintain instruction flow. Control signals and instruction formats were carefully managed to ensure correct data propagation and minimal hazard conditions.

The basic instruction set was defined as follows:

ADD: Performs addition of two registers and stores the result in a destination register.

SUB: Performs subtraction in a similar manner.

LOAD: Loads data from memory into a register.

Simulation:

Simulation was performed using ModelSim, a powerful simulation tool for VHDL and Verilog designs. Each stage’s functionality was verified step-by-step using testbenches. The simulation output confirmed that:

Instructions moved through each pipeline stage sequentially.

The results were correctly written back to the registers or loaded from memory.

Pipeline registers correctly stored intermediate values for each clock cycle.

The waveform output from ModelSim clearly illustrated the pipelining effect, where multiple instructions were in different stages of execution simultaneously.

Outcome:

This task provided valuable practical experience in digital design and processor architecture. By completing the pipelined processor design and verifying it through simulation, I developed a deeper understanding

of how pipelining increases throughput and the importance of handling hazards and data dependencies in real-time.

#OUTPUT#

<img width="835" height="441" alt="image" src="https://github.com/user-attachments/assets/032f88f7-da88-4f05-a06f-e37bcb72fdd2" />
