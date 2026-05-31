`timescale 1ns/1ps

module uart_rx_tb;

reg clk;
reg reset;
reg rx;

wire [7:0] data_out;
wire rx_done;

uart_rx dut(
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .data_out(data_out),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;
    rx = 1;

    #20;
    reset = 0;

    // Send 8'b10110010
    

    #10 rx = 0;  // Start Bit

    #10 rx = 0;  // D0
    #10 rx = 1;  // D1
    #10 rx = 0;  // D2
    #10 rx = 0;  // D3
    #10 rx = 1;  // D4
    #10 rx = 1;  // D5
    #10 rx = 0;  // D6
    #10 rx = 1;  // D7

    #10 rx = 1;  // Stop Bit

    #50;

    $finish;

end

initial
begin

    $monitor(
    "Time=%0t RX=%b DATA=%b DONE=%b",
    $time,
    rx,
    data_out,
    rx_done);

end

endmodule