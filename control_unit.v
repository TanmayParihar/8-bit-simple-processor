module control_unit(
    input [2:0] opcode,
    output reg reg_write,
    output reg [2:0] alu_op,
    output reg alu_src,
    output reg jump,
    output reg branch    
);
    always @(*) begin
        reg_write = 1'b0;
        alu_op = 3'b111;
        alu_src = 1'b0;
        jump = 1'b0;
        branch = 1'b0;
        
        case (opcode)
            3'b000: begin
                reg_write = 1'b1;
                alu_src = 1'b1;
                alu_op = 3'b100;
            end
            3'b001: begin
                reg_write = 1'b1;
                alu_op = 3'b100;
            end
            3'b010: begin
                reg_write = 1'b1;
                alu_op = 3'b000;
            end
            3'b011: begin
                reg_write = 1'b1;
                alu_op = 3'b001;
            end
            3'b100: begin
                reg_write = 1'b1;
                alu_op = 3'b010;
            end
            3'b101: begin
                reg_write = 1'b1;
                alu_op = 3'b011;
            end
            3'b110: begin
                jump = 1'b1;
            end
            3'b111: begin
                branch = 1'b1;
            end
        endcase
    end
endmodule
