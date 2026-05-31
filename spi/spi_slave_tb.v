`timescale 1ns/1ps

module spi_slave_tb;

reg sclk;
reg reset;
reg cs;
reg mosi;

wire [7:0] data_out;
wire done;

spi_slave dut(
    .sclk(sclk),
    .reset(reset),
    .cs(cs),
    .mosi(mosi),
    .data_out(data_out),
    .done(done)
);

initial
begin

    sclk = 0;

    forever #5 sclk = ~sclk;

end

initial
begin

    reset = 1;
    cs = 1;
    mosi = 0;

    #20;

    reset = 0;
    cs = 0;

    // 10110010

    mosi = 1; #10;
    mosi = 0; #10;
    mosi = 1; #10;
    mosi = 1; #10;
    mosi = 0; #10;
    mosi = 0; #10;
    mosi = 1; #10;
    mosi = 0; #10;

    cs = 1;

    #50;

    $finish;

end

initial
begin

    $monitor(
    "Time=%0t MOSI=%b DATA=%b DONE=%b",
    $time,
    mosi,
    data_out,
    done);

end

endmodule