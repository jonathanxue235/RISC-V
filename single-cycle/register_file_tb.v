// `include "register_file.v"

module register_file_tb ();

reg [4:0] in_read1_address;
reg [4:0] in_read2_address;
reg [4:0] in_write_address;
reg [31:0] in_write_data;
reg clk;
reg in_write_enable;
reg reset;
wire [31:0] out_read1_data;
wire [31:0] out_read2_data;

register_file DUT(
    .in_read1_address(in_read1_address),
    .in_read2_address(in_read2_address),
    .in_write_address(in_write_address),
    .in_write_data(in_write_data),
    .clk(clk),
    .in_write_enable(in_write_enable),
    .reset(reset),
    .out_read1_data(out_read1_data),
    .out_read2_data(out_read2_data)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #100 $finish;
end

initial begin
    $dumpfile("register_file.vcd");
    $dumpvars(0, register_file_tb);
end

initial begin
    reset = 1;
    #10 
    reset = 0; in_write_enable = 0; in_read1_address = 0; in_read2_address = 0; in_write_address = 0; in_write_data = 0;
    #10
    in_write_enable = 1; in_write_data = 10; in_write_address = 0; in_read1_address = 0; in_read2_address = 1;
    #10
    in_write_enable = 1; in_write_data = 20; in_write_address = 1; in_read1_address = 0; in_read2_address = 1;
    #10
    in_write_enable = 1; in_write_data = 30; in_write_address = 5; in_read1_address = 1; in_read2_address = 5;
    #10;
end





endmodule