// MODULE FINISHED

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