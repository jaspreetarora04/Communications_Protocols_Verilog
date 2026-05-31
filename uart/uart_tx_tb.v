`timescale 1ns/1ps

module uart_tx_tb;

reg clk;
reg reset;
reg tx_start;
reg [7:0] data_in;

wire tx;
wire tx_busy;
wire tx_done;

uart_tx dut(
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx),
    .tx_busy(tx_busy),
    .tx_done(tx_done)
);

always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;
    tx_start = 0;
    data_in = 0;

    #20;
    reset = 0;

    // First Transmission
    

    #10;
    data_in = 8'b10110010;
    tx_start = 1;

    #10;
    tx_start = 0;

    // Second Transmission

    #120;

    data_in = 8'b11001100;
    tx_start = 1;

    #10;
    tx_start = 0;

    #200;

    $finish;

end

initial
begin

    $monitor(
    "Time=%0t TX=%b Busy=%b Done=%b",
    $time,
    tx,
    tx_busy,
    tx_done);

end
endmodule