module instruction_memory(
    input [31:0] pc,
    output [31:0] instr
);
    reg [31:0] memory [31:0];
    assign instr = memory[addr];
    always @* begin
        memory[0] = 32'h00000000;
        memory[1] = 32'h00000000; // TODO: Write some test instructions
    end
    
endmodule