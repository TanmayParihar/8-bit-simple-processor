module register_file(
    input clk,
    input rst,
    input reg_write,
    input [2:0] read_addr1,
    input [2:0] read_addr2,
    input [2:0] write_addr,
    input [7:0] in,
    output [7:0] out1,
    output [7:0] out2
);
    reg [7:0] registers[0:7];
    integer i;
    
    assign out1 = registers[read_addr1];
    assign out2 = registers[read_addr2];
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i=0; i<8; i=i+1) begin
                registers[i] <= 8'h00;
            end
        end else if (reg_write) begin
            registers[write_addr] <= in;
        end
    end
endmodule
