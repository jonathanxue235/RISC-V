module register_file(
    input [4:0] in_read1_address,
    input [4:0] in_read2_address,
    input [4:0] in_write_address,
    input [31:0] in_write_data,
    input clk,
    input in_write_enable,
    output [31:0] out_read1_data,
    output [31:0] out_read2_data
);

reg [31:0] registers [31:0];
assign registers[0] = 32'b0;

always @(posedge clk) begin
    if (in_write_enable) begin
        if (in_write_address != 0) begin
            registers[in_write_address] <= in_write_data;
        end
    end
end

assign out_read1_data = registers[in_read1_address];
assign out_read2_data = registers[in_read2_address];

endmodule