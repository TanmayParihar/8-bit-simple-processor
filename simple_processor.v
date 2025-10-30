module simple_processor(
    input clk,
    input rst
);
    reg [7:0] pc;
    reg [7:0] inst_mem[0:255];
    wire [7:0] instruction;
    wire [2:0] opcode;
    wire [7:0] immediate;
    wire [7:0] reg_out1, reg_out2;
    wire [7:0] alu_in2;
    wire [7:0] alu_result;
    wire alu_zero;
    wire reg_write, alu_src, jump, branch;
    wire [2:0] alu_op;
    
    assign instruction = inst_mem[pc];
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 8'h00;
        end else if (jump || (branch && alu_zero)) begin
            pc <= immediate;
        end else begin
            pc <= pc + 1;
        end      
    end
    
    assign opcode = instruction[7:5];
    assign write_addr1 = instruction[4:2];
    assign reg_addr1 = instruction[4:2];
    assign reg_addr2 = instruction[1:0];
    assign immediate = {3'b000, instruction[4:0]};
    
    control_unit cu (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .jump(jump),
        .branch(branch)
    );
    
    register_file rf (
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write),
        .read_addr1(reg_addr1),
        .read_addr2(reg_addr2),
        .write_addr(write_addr),
        .in(alu_result),
        .out1(reg_out1),
        .out2(reg_out2)
    );
    
     assign alu_in2 = (alu_src) ? immediate : reg_out2;
     
     alu alu_inst (
        .a(reg_out1),
        .b(alu_in2),
        .alu_op(alu_op),
        .result(alu_result),
        .zero(alu_zero)
    );
    
    initial begin
        inst_mem[0] = 8'h0D;
        inst_mem[1] = 8'h12;
        inst_mem[2] = 8'h46;
        inst_mem[3] = 8'hC0;
    end

endmodule
