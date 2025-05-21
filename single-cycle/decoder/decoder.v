module decoder (
    input [31:0] in_instruction,
    output reg [6:0] out_opcode, // DONE
    output reg out_branch, // DONE
    output reg [2:0] out_branch_op, // DONE
    output reg out_reg_write, // DONE
    output reg out_mem_write, // DONE
    output reg out_alu_src_a, // DONE
    output reg out_alu_src_b, // DONE
    output reg [3:0] out_alu_op, // DONE
    output reg [4:0] out_rd, // DONE
    output reg [4:0] out_rs1, // DONE
    output reg [4:0] out_rs2, // DONE
    output reg [1:0] out_choose_result // DONE
);

assign out_opcode = in_instruction[6:0];
logic [2:0] funct3;
logic [6:0] funct7;
assign funct3 = in_instruction[14:12];
assign funct7 = in_instruction[31:25];


// Opcode Types
localparam R = 7'b0110011;
localparam ARITH_I = 7'b0010011;
localparam LOAD_I = 7'b0000011;
localparam S = 7'b0100011;
localparam B = 7'b1100011;
localparam JAL = 7'b1101111;
localparam JALR = 7'b1100111;
localparam LOAD_U = 7'b0110111;
localparam ADD_U = 7'b0010111;
localparam ENV_I = 7'b1110011;

// funct3 types
localparam ADD = 3'b000;
localparam XOR = 3'b100;
localparam OR = 3'b110;
localparam AND = 3'b111;
localparam SHIFT_LEFT = 3'b001;
localparam SHIFT_RIGHT = 3'b101;
localparam SET_LESS = 3'b010;
localparam SET_LESS_UNSIGNED = 3'b011;

// choose result types
localparam ALU = 2'b00;
localparam PC = 2'b01;
localparam MEM = 2'b10;

always @(*) begin
    out_rd = in_instruction[11:7];
    out_rs1 = LOAD_U == out_opcode ? 5'b00000 : in_instruction[19:15];
    out_rs2 = in_instruction[24:20];
    case (out_opcode)
        R: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 1;
            out_alu_src_a = 0; // Use Register
            out_alu_src_b = 0; // Use Register
            out_mem_write = 0;
            if (funct3 == ADD || funct3 == SHIFT_RIGHT) begin
                out_alu_op = {funct3, funct7[5]};
            end else begin
                out_alu_op = {funct3, 1'b0};
            end
            out_choose_result = ALU;
        end
        ARITH_I: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 1;
            out_alu_src_a = 0;
            out_alu_src_b = 1;
            out_mem_write = 0;
            if (funct3 == SHIFT_RIGHT) begin
                out_alu_op = {funct3, in_instruction[30]};
            end else begin
                out_alu_op = {funct3, 1'b0};
            end
            out_choose_result = ALU;
        end
        LOAD_I: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 1;
            out_alu_src_a = 0;
            out_alu_src_b = 1;
            out_mem_write = 0;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = MEM;
        end
        S: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 0;
            out_alu_src_a = 0;
            out_alu_src_b = 1;
            out_mem_write = 1;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = ALU;
        end
        B: begin 
            out_branch = 1;
            out_branch_op = funct3;
            out_reg_write = 0;
            out_alu_src_a = 0;
            out_alu_src_b = 0;
            out_mem_write = 0;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = ALU;
        end
        JAL: begin
            out_branch = 1;
            out_branch_op = 3'b010;
            out_reg_write = 1;
            out_alu_src_a = 1;
            out_alu_src_b = 1;
            out_mem_write = 0;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = PC;
        end
        JALR: begin
            out_branch = 1;
            out_branch_op = 3'b010;
            out_reg_write = 1;
            out_alu_src_a = 0;
            out_alu_src_b = 1;
            out_mem_write = 0;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = PC;
        end
        LOAD_U: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 1;
            out_alu_src_a = 0;
            out_alu_src_b = 1;
            out_mem_write = 0;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = ALU;
        end
        ADD_U: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 1;
            out_alu_src_a = 1;
            out_alu_src_b = 1;
            out_mem_write = 0;
            out_alu_op = {ADD, 1'b0};
            out_choose_result = ALU;
        end
        ENV_I: begin
            // TODO: Figure out what to put here
            // out_branch = 0;
            // out_branch_op = 3'b000;
            // out_reg_write = 0;
            // out_alu_src_a = 0;
            // out_alu_src_b = 0;
            // out_mem_write = 0;
        end
        default: begin
            out_branch = 0;
            out_branch_op = 3'b000;
            out_reg_write = 0;
            out_alu_src_a = 0;
            out_alu_src_b = 0;
            out_mem_write = 0;
            out_alu_op = 4'b0000;
        end
    endcase
end
endmodule