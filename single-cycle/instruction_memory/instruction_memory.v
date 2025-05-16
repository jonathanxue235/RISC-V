module instruction_memory(
    input [31:0] in_address,
    output [31:0] out_instruction
);
    reg [63:0] memory [31:0];
    initial begin
        memory[0] = 32'h01234567;
        memory[1] = 32'hAAAAAAAA; // TODO: Write some test instructions
        memory[2] = 32'hBBBBBBBB;
    end
    assign out_instruction = memory[in_address];
endmodule