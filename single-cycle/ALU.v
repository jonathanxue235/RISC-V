module ALU (
    input [31:0] in_data1,
    input [31:0] in_data2,
    input [2:0] in_select,
    output [31:0] out_data,
);

localparam ADD = 3'b000;

always @* begin
    case (in_select)
        ADD: begin
            out_data = in_data1 + in_data2;
        end
        default: begin
            out_data = 31'b0;
        end
    endcase
end

endmodule