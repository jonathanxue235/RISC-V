module ALU_tb ();

reg [31:0] in_data1;
reg [31:0] in_data2;
reg [3:0] in_select; // {[2:0] funct3, funct7} as ALU Op Code
wire [31:0] out_data;

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

ALU DUT(
    .in_data1(in_data1),
    .in_data2(in_data2),
    .in_select(in_select),
    .out_data(out_data)
);

initial begin
    #200 $finish;
end

initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, ALU_tb);
end

initial begin
    in_data1 = 0; in_data2 = 0; in_select = ADD; #10; // 0
    in_data1 = 1; in_data2 = 2; in_select = ADD; #10; // 3
    in_data1 = 1; in_data2 = 2; in_select = SUB; #10; // -1
    in_data1 = 2; in_data2 = 4; in_select = XOR; #10; // 6
    in_data1 = 3; in_data2 = 4; in_select = OR; #10; // 7
    in_data1 = 3; in_data2 = 2; in_select = AND; #10; // 2
    in_data1 = 1; in_data2 = 5; in_select = SHIFT_LEFT; #10; // 32
    in_data1 = 17; in_data2 = 1; in_select = SHIFT_RIGHT_LOGICAL; #10; // 8
    in_data1 = -1; in_data2 = 2; in_select = SHIFT_RIGHT_ARITHMETIC; #10; // -1
    in_data1 = -10; in_data2 = 5; in_select = SET_LESS; #10; // 1
    in_data1 = 10; in_data2 = 5; in_select = SET_LESS; #10; // 0
    in_data1 = -10; in_data2 = 5; in_select = SET_LESS_UNSIGNED; #10; // 0
    in_data1 = 10; in_data2 = 5; in_select = SET_LESS_UNSIGNED; #10; // 0
    in_data1 = 9; in_data2 = 9; in_select = 8; #10; // 0
end

endmodule