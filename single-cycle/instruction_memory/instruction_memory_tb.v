// `include "register_file.v"

module instruction_memory_tb ();

reg [31:0] in_address;
reg clk;
wire [31:0] out_instruction;

instruction_memory DUT(
    .in_address(in_address),
    .out_instruction(out_instruction)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #100 $finish;
end

initial begin
    $dumpfile("instruction_memory.vcd");
    $dumpvars(0, instruction_memory_tb);
end

initial begin
    in_address = 0;
    #10
    in_address = 1;
    #10
    in_address = 2;
    #10;
end

endmodule