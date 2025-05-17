module decoder_alu (
   input [1:0] in_alu_op,
   input [2:0] in_funct3,
   input [6:0] in_funct7,
   output [2:0] out_alu_control
);

// funct3 types
localparam ADD = 3'b000;
localparam XOR = 3'b100;
localparam OR = 3'b110;
localparam AND = 3'b111;
localparam SHIFT_LEFT = 3'b001;
localparam SHIFT_RIGHT = 3'b101;
localparam SET_LESS = 3'b010;
localparam SET_LESS_UNSIGNED = 3'b011;



reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [11:0] imm_1;
reg [19:0] imm_2;




endmodule