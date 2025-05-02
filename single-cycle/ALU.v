module ALU (
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0] ALUControl,
    output [31:0] ALUOut,
);

localparam ADD = 3'b000;

always @* begin
    case (ALUControl)
        ADD: begin
            ALUOut = SrcA + SrcB;
        end
        default: begin
            ALUOut = 31'b0;
        end
    endcase
end

endmodule