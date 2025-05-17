module ALU (
    input [31:0] in_data1,
    input [31:0] in_data2,
    input [2:0] in_select,
    output reg [31:0] out_data
);

// funct3 types
localparam ADD = 3'b000;
localparam XOR = 3'b100;
localparam OR = 3'b110;
localparam AND = 3'b111;
localparam SHIFT_LEFT = 3'b001;
localparam SHIFT_RIGHT = 3'b101;
localparam SET_LESS = 3'b010;
localparam SET_LESS_UNSIGNED = 3'b011;

always @* begin
    case (in_select)
        ADD: begin 
            out_data = in_data1 + in_data2;
        end
        XOR: begin
            out_data = in_data1 ^ in_data2;
        end
        OR: begin
            out_data = in_data1 | in_data2;
        end
        AND: begin
            out_data = in_data1 & in_data2;
        end
        SHIFT_LEFT: begin
            out_data = in_data1 << in_data2;
        end
        SHIFT_RIGHT: begin
            out_data = in_data1 >> in_data2;
        end
        SET_LESS: begin
            out_data = {~in_data1[31], in_data1} < {~in_data2[31], in_data2};
        end
        SET_LESS_UNSIGNED: begin
            out_data = in_data1 < in_data2;
        end
        default: begin
           out_data = 31'b0;
        end
    endcase
end

endmodule