`timescale 1ns/1ps

module i2c_master_tb;

reg clk;
reg reset;
reg start;
reg [6:0] addr;
reg [7:0] data_in;

wire scl;
wire sda;
wire done;

i2c_master dut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .addr(addr),
    .data_in(data_in),
    .scl(scl),
    .sda(sda),
    .done(done)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;
    start = 0;

    #20 reset = 0;

    addr = 7'b1010101;
    data_in = 8'b11001100;

    #10 start = 1;
    #10 start = 0;

    #200 $finish;

end

endmodule