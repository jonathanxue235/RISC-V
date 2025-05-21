
module ALU (
    input [31:0] in_data1,
    input [31:0] in_data2,
    input [3:0] in_select, // {[2:0] funct3, funct7[5]} as ALU Op Code
    output reg [31:0] out_data
);

// {[2:0] funct3, funct7} as ALU Op Code
localparam ADD = 4'b0000;
localparam SUB = 4'b0001;
localparam XOR = 4'b1000;
localparam OR = 4'b1100;
localparam AND = 4'b1110;
localparam SHIFT_LEFT = 4'b0010;
localparam SHIFT_RIGHT_LOGICAL = 4'b1010;
localparam SHIFT_RIGHT_ARITHMETIC = 4'b1011;
localparam SET_LESS = 4'b0100;
localparam SET_LESS_UNSIGNED = 4'b0110;

always @* begin
    case (in_select)
        ADD: begin 
            out_data = in_data1 + in_data2;
        end
        SUB: begin
            out_data = in_data1 - in_data2;
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
        SHIFT_RIGHT_LOGICAL: begin
            out_data = in_data1 >> in_data2;
        end
        SHIFT_RIGHT_ARITHMETIC: begin
            out_data = $signed(in_data1) >>> in_data2;
        end
        SET_LESS: begin
            out_data = $signed(in_data1) < $signed(in_data2);
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