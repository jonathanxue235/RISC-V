module data_memory_tb ();

reg [31:0] in_address;
reg [31:0] in_write_data;
reg clk;
reg reset;
reg in_write_enable;
wire [31:0] out_data;

data_memory DUT(
    .in_address(in_address),
    .in_write_data(in_write_data),
    .clk(clk),
    .in_write_enable(in_write_enable),
    .reset(reset),
    .out_data(out_data)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #100 $finish;
end

initial begin
    $dumpfile("data_memory.vcd");
    $dumpvars(0, data_memory_tb);
end

initial begin
    reset = 1;
    #10 
    reset = 0; in_write_enable = 0; in_address = 0; in_write_data = 0;
    #10
    in_write_enable = 1; in_write_data = 10; in_address = 0;
    #10
    in_write_enable = 1; in_write_data = 20; in_address = 1;
    #10;
    in_write_enable = 0; in_address = 0;
    #10;
    in_write_enable = 0; in_address = 1;
    #10;
end





endmodule