module decoder_main (
    input [31:0] in_instruction,
    output out_reg_write,
    output out_alu_src_a,
    output out_alu_src_b,
    output [1:0] out_alu_op,
);
reg [6:0] opcode;
assign opcode = in_instruction[6:0];

// Opcode Types
localparam R = 7'b0110011;
localparam ARITH_I = 7'b0010011;
localparam LOAD_I = 7'b0000011;
localparam S = 7'b0100011;
localparam B = 7'b1100011;
localparam J = 7'b1101111;
localparam JUMP_I = 7'b1100111;
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



reg [2:0] funct3;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [11:0] imm_1;
reg [19:0] imm_2;

always @* begin
    case (opcode)
        R: begin
            out_alu_op = 2'b10;
            out_reg_write = 1;
            
        end
        ARITH_I: begin
            out_alu_op = 2'b10;
            out_reg_write = 1;
        end
        LOAD_I: begin
            out_alu_op = 2'b00;
            out_reg_write = 1;
        end
        S: begin
            out_alu_op = 2'b00;
            out_reg_write = 0;
        end
        B: begin
            out_alu_op = 2'b01;
            out_reg_write = 0;
        end
        J: begin
            out_alu_op = 2'b00;
            out_reg_write = 1;
        end
        JUMP_I: begin
            out_alu_op = 2'b00;
            out_reg_write = 1;
        end
        LOAD_U: begin
            out_alu_op = 2'b11;
            out_reg_write = 1;
        end
        ADD_U: begin
            out_alu_op = 2'b11;
            out_reg_write = 1;
        end
        ENV_I: begin
            out_alu_op = 2'b00;
            out_reg_write = 0;
        end
        default: begin
            out_alu_op = 2'b00;
            out_reg_write = 0;
        end
    endcase
end




endmodule