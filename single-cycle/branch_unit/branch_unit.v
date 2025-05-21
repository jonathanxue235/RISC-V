module branch_unit (
    input wire in_branch,
    input wire [2:0] in_branch_op,
    input wire [31:0] in_a,
    input wire [31:0] in_b,

    output reg out_branch
);

localparam BEQ = 3'b000;
localparam BNE = 3'b001;
localparam BLT = 3'b100;
localparam BGE = 3'b101;
localparam BLTU = 3'b110;
localparam BGEU = 3'b111;
localparam JAL_JALR = 3'b010;

always @(*) begin
    if (!in_branch) begin
        out_branch = 0;
    end else begin
        case (in_branch_op)
            BEQ:
                out_branch = in_a == in_b;
            BNE:
                out_branch = in_a != in_b;
            BLT:
                out_branch = $signed(in_a) < $signed(in_b);
            BGE:
                out_branch = $signed(in_a) >= $signed(in_b);
            BLTU:
                out_branch = in_a < in_b;
            BGEU:
                out_branch = in_a >= in_b;
            JAL_JALR:
                out_branch = 1;
            default:
                out_branch = 0;
        endcase
    end
end
endmodule