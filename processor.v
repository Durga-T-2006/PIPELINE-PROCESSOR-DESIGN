
module processor (
    input clk,
    input reset
);

    // === Register & Memory Definitions ===
    reg [15:0] instr_mem [0:15];
    reg [7:0] data_mem [0:15];
    reg [7:0] reg_file [0:15];

    // === Pipeline Registers ===
    reg [15:0] IF_ID_instr;
    reg [15:0] ID_EX_instr;
    reg [7:0] ID_EX_rs1_val, ID_EX_rs2_val;

    reg [15:0] EX_MEM_instr;
    reg [7:0] EX_MEM_alu_out, EX_MEM_rs2_val;

    // === Program Counter ===
    reg [3:0] pc;

    // === Fetch Stage ===
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            IF_ID_instr <= 0;
        end else begin
            IF_ID_instr <= instr_mem[pc];
            pc <= pc + 1;
        end
    end

    // === Decode Stage ===
    wire [3:0] opcode = IF_ID_instr[15:12];
    wire [3:0] rd     = IF_ID_instr[11:8];
    wire [3:0] rs1    = IF_ID_instr[7:4];
    wire [3:0] rs2    = IF_ID_instr[3:0];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ID_EX_instr <= 0;
            ID_EX_rs1_val <= 0;
            ID_EX_rs2_val <= 0;
        end else begin
            ID_EX_instr <= IF_ID_instr;
            ID_EX_rs1_val <= reg_file[rs1];
            ID_EX_rs2_val <= reg_file[rs2];
        end
    end

    // === Execute Stage ===
    reg [7:0] alu_out;
    always @(*) begin
        case (ID_EX_instr[15:12])
            4'b0001: alu_out = ID_EX_rs1_val + ID_EX_rs2_val;  // ADD
            4'b0010: alu_out = ID_EX_rs1_val - ID_EX_rs2_val;  // SUB
            4'b0011: alu_out = data_mem[ID_EX_rs1_val];        // LOAD
            default: alu_out = 0;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            EX_MEM_instr <= 0;
            EX_MEM_alu_out <= 0;
            EX_MEM_rs2_val <= 0;
        end else begin
            EX_MEM_instr <= ID_EX_instr;
            EX_MEM_alu_out <= alu_out;
            EX_MEM_rs2_val <= ID_EX_rs2_val;
        end
    end

    // === MEM/WB Stage ===
    wire [3:0] mem_rd = EX_MEM_instr[11:8];
    wire [3:0] mem_op = EX_MEM_instr[15:12];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Do nothing
        end else begin
            if (mem_op == 4'b0001 || mem_op == 4'b0010 || mem_op == 4'b0011) begin
                reg_file[mem_rd] <= EX_MEM_alu_out;
            end
        end
    end

endmodule
`timescale 1ns/1ps
module tb_processor;

    reg clk, reset;
    processor uut(.clk(clk), .reset(reset));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simulation
    initial begin
        $display("Starting processor simulation...");
        reset = 1;
        #10;
        reset = 0;

        // Initialize instruction memory
        // Format: OPCODE | RD | RS1 | RS2
        // ADD R1 = R2 + R3   => 0001 0001 0010 0011 = 0x1123
        // SUB R4 = R1 - R3   => 0010 0100 0001 0011 = 0x2413
        // LOAD R5 = MEM[R2]  => 0011 0101 0010 xxxx = 0x3520
        uut.instr_mem[0] = 16'h1123;
        uut.instr_mem[1] = 16'h2413;
        uut.instr_mem[2] = 16'h3520;

        // Initialize registers
        uut.reg_file[2] = 8'd10;  // R2
        uut.reg_file[3] = 8'd5;   // R3
        uut.reg_file[1] = 8'd0;   // R1
        uut.reg_file[4] = 8'd0;   // R4
        uut.reg_file[5] = 8'd0;   // R5

        // Initialize memory
        uut.data_mem[10] = 8'd77; 

        #100;

      
        $display("R1 = %d (Expect 15)", uut.reg_file[1]);
        $display("R4 = %d (Expect 10)", uut.reg_file[4]);
        $display("R5 = %d (Expect 77)", uut.reg_file[5]);

        $stop;
    end

endmodule
