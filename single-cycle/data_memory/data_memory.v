module data_memory(
    input [31:0] in_address,
    input [31:0] in_write_data,
    input reset,
    input clk,
    input in_write_enable,
    output [31:0] out_data
);

    reg [63:0] memory [31:0];
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            for (integer i = 0; i < 64; i = i + 1) begin
                memory[i] = 32'b0;
            end
        end
        if (in_write_enable) begin
            memory[in_address] <= in_write_data;
        end
    end
    assign out_data = memory[in_address];
endmodule