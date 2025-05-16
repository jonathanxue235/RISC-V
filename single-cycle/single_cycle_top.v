module single_cycle_top(
    input clk,
    input reset
);


/**
*
* Program Counter (PC) as well as next PC
*
*/
reg [31:0] pc;
reg [31:0] pc_next;

always @(posedge clk) begin
    if (reset) begin
        pc <= 32'h00003000;
    end else begin
        pc <= pc_next;
    end
end

always @* begin
    pc_next = pc + 4;
end



/**
*
* Getting Instruction Based on Program Counter
*
*/
wire [31:0] instr;
wire [31:0] immExt;

instruction_memory instructions(
    .in_address(pc),
    .out_instruction(instr)
);


/**
*
* Reading / Writing Register
*
*/
wire [31:0] reg1Out;
wire [31:0] reg2Out;
wire regWrite;

register_file get_register(
    .in_read1_address(instr[19:15]), // TODO: Not sure if just flatly assigning RD[19:15] works if we were to include U and J type instructions
    .in_read2_address(5'b00000),
    .in_write_address(instr[11:7]),
    .in_write_data(dataOut),
    .clk(clk),
    .in_write_enable(regWrite),
    .out_read1_data(reg1Out),
    .out_read2_data(reg2Out)
);


/**
*
* ALU
*
*/
wire [31:0] ALUOut;

ALU CPU_ALU(
    .in_data1(reg1Out),
    .in_data2(immExt),
    .in_select(3'b000),
    .out_data(ALUOut)
);



/**
*
* Read in Data
*
*/

wire writeEnable;
wire [31:0] dataOut;
data_memory get_data(
    .in_address(ALUOut),
    .in_write_data(),
    .clk(clk),
    .in_write_enable(writeEnable),
    .out_data(dataOut)
);



/**
*
* Data Extension
*
*/
extend extend_imm_i (
    .in_data(instr[31:7]),
    .in_select(0),
    .out_data(immExt)
);

/**
*
* Main Decoder
*
*/
wire [2:0] funct3;
wire [6:0] funct7;
wire select1;
wire select2;
wire [1:0] aluOp

decoder_main decode_main (
    .in_instruction(instr),
    .out_funct3(funct3),
    .out_funct7(funct7),
    .out_reg_write(regWrite),
    .out_mem_write(writeEnable),
    .out_alu_src_a(select1),
    .out_alu_src_b(select2),
    .out_alu_op(aluOp)
)





endmodule