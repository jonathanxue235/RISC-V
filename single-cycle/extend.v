// MODULE FINISHED

module extend (
    input [24:0] imm, // Pass Instr[31:7] always 
    input select, // 0 = Instr[31:20], 1 = Instr[31:25] + Instr[11:7]
    input [31:0] immExt
);

always @* begin
    if (select == 1)
        immExt = { {20{imm[24]}}, imm[24:18], imm[4:0]};
    else
        immExt = { {20{imm[24]}}, imm[24:13]};
end
endmodule