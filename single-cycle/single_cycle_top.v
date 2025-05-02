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
    .pc(pc),
    .instr(instr)
);


/**
*
* Reading / Writing Register
*
*/
wire [31:0] reg1Out;
wire [31:0] reg2Out;
wire regWrite;
assign regWrite = 1'b1; // TODO: Change with more instructions

register_file get_register(
    .A1(instr[19:15]), // TODO: Not sure if just flatly assigning RD[19:15] works if we were to include U and J type instructions
    .A2(5'b00000),
    .A3(instr[11:7]),
    .WD3(dataOut),
    .clk(clk),
    .WE3(regWrite),
    .RD1(reg1Out),
    .RD2(reg2Out)
);


/**
*
* ALU
*
*/
wire [31:0] ALUOut;

ALU CPU_ALU(
    .SrcA(reg1Out),
    .SrcB(immExt),
    .ALUControl(3'b000),
    .ALUOut(ALUOut)
);



/**
*
* Read in Data
*
*/

wire writeEnable;
assign writeEnable = 1'b0;
wire [31:0] dataOut;
data_memory get_data(
    .A(ALUOut),
    .WD(),
    .clk(clk),
    .WE(writeEnable),
    .RD(dataOut)
);



/**
*
* Data Extension
*
*/
extend extend_imm_i (
    .imm(instr[31:7]),
    .select(0),
    .immExt(immExt)
);

endmodule