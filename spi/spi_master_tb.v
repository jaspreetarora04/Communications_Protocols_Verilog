`timescale 1ns/1ps

module spi_master_tb;

reg clk;
reg reset;
reg start;
reg [7:0] data_in;

wire mosi;
wire sclk;
wire cs;
wire done;

spi_master dut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(data_in),
    .mosi(mosi),
    .sclk(sclk),
    .cs(cs),
    .done(done)
);

always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;
    start = 0;

    #20;
    reset = 0;

    data_in = 8'b10110010;

    #10;
    start = 1;

    #10;
    start = 0;

    #200;

    $finish;

end

initial
begin

    $monitor(
    "Time=%0t MOSI=%b SCLK=%b CS=%b DONE=%b",
    $time,
    mosi,
    sclk,
    cs,
    done);

end

endmodule