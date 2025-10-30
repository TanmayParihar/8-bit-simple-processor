module alu(
    input [7:0] a,
    input [7:0] b,
    input [2:0] alu_op,
    output reg [7:0] result,
    output reg zero
);
    always @(*) begin
        case(alu_op)
            3'b000: result = a+b;
            3'b001: result = a-b;
            3'b010: result = a&b;
            3'b011: result = a|b;
            3'b100: result = b;
            default: result = 8'h00;
        endcase
        
        if (result == 8'h00) begin
            zero = 1'b1;
        end else begin
            zero = 1'b0;
        end
        
    end
endmodule
