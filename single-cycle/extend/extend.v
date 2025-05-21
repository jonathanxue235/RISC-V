
module extend (
    input wire [31:0] in_inst,       
    input wire [6:0] in_opcode,
    output reg [31:0] out_immediate_extended
);
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



  always @* begin
        case (in_opcode)
            ARITH_I, LOAD_I, JUMP_I: begin
                if (in_inst[31] == 1'b1) begin
                    out_immediate_extended = {20'hFFFFF, in_inst[31:20]};
                end else begin
                    out_immediate_extended = {20'h00000, in_inst[31:20]};
                end
            end
            S: begin
                if (in_inst[31] == 1'b1) begin
                    out_immediate_extended = {20'hFFFFF, in_inst[31:25], in_inst[11:7]};
                end else begin
                    out_immediate_extended = {20'h00000, in_inst[31:25], in_inst[11:7]};
                end
            end
            LUI, AUIPC: out_immediate_extended = {in_inst[31:12], 12'h000};
            JAL: begin 
                if (in_inst[31] == 1'b1) begin 
                    out_immediate_extended = {20'hFFF, in_inst[31], in_inst[19:12],  in_inst[20], in_inst[30:21], 1'b0};
                end else begin
                    out_immediate_extended = {20'h000, in_inst[31], in_inst[19:12],  in_inst[20], in_inst[30:21], 1'b0};
                end
            end
            BRANCH: begin 
                if (in_inst[31] == 1'b1) begin 
                    out_immediate_extended = {20'hFFFFF, in_inst[31], in_inst[7], in_inst[30:25], in_inst[11:8], 1'b0};
                end else begin
                    out_immediate_extended = {20'h00000, in_inst[31], in_inst[7], in_inst[30:25], in_inst[11:8], 1'b0};
                end
            end
            ENV_I: begin // TODO: Fix
                if (in_inst[31] == 1'b1) begin
                    out_immediate_extended = {20'hFFFFF, in_inst[31:20]};
                end else begin
                    out_immediate_extended = {20'h00000, in_inst[31:20]};
                end
            end
            default: out_immediate_extended = 32'hFFFF_FFFF;
        endcase
    end
endmodule
/*
module extend (
    input [24:0] in_data, // Pass Instr[31:7] always 
    input in_select, // 0 = Instr[31:20], 1 = Instr[31:25] + Instr[11:7]
    output [31:0] out_data
);

always @* begin
    if (in_select == 1)
        out_data = { {20{in_data[24]}}, in_data[24:18], in_data[4:0]};
    else
        out_data = { {20{in_data[24]}}, in_data[24:13]};
end
endmodule
*/