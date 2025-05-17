module ALU_tb ();

reg [31:0] in_data1;
reg [31:0] in_data2;
reg [2:0] in_select;
wire [31:0] out_data;


// funct3 types
localparam ADD = 3'b000;
localparam XOR = 3'b100;
localparam OR = 3'b110;
localparam AND = 3'b111;
localparam SHIFT_LEFT = 3'b001;
localparam SHIFT_RIGHT = 3'b101;
localparam SET_LESS = 3'b010;
localparam SET_LESS_UNSIGNED = 3'b011;


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
    in_data1 = 2; in_data2 = 4; in_select = XOR; #10; // 6
    in_data1 = 3; in_data2 = 4; in_select = OR; #10; // 7
    in_data1 = 3; in_data2 = 2; in_select = AND; #10; // 2
    in_data1 = 1; in_data2 = 5; in_select = SHIFT_LEFT; #10; // 32
    in_data1 = 17; in_data2 = 1; in_select = SHIFT_RIGHT; #10; // 8
    in_data1 = -10; in_data2 = 5; in_select = SET_LESS; #10; // 1
    in_data1 = 10; in_data2 = 5; in_select = SET_LESS; #10; // 0
    in_data1 = -10; in_data2 = 5; in_select = SET_LESS_UNSIGNED; #10; // 0
    in_data1 = 10; in_data2 = 5; in_select = SET_LESS_UNSIGNED; #10; // 0
    in_data1 = 9; in_data2 = 9; in_select = 8; #10; // 0
end

endmodule