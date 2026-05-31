`timescale 1ns/1ps

module i2c_slave_tb;

reg scl;
reg reset;
reg sda;

wire [7:0] data_out;
wire done;

i2c_slave dut(
    .scl(scl),
    .reset(reset),
    .sda(sda),
    .data_out(data_out),
    .done(done)
);

initial
begin
    scl = 0;
    forever #5 scl = ~scl;
end

initial
begin

    reset = 1;
    sda = 1;

    #20 reset = 0;

    // Address bits
    repeat(8)
    begin
        sda = $random;
        #10;
    end

    // Data = 11001100
    sda=1; #10;
    sda=1; #10;
    sda=0; #10;
    sda=0; #10;
    sda=1; #10;
    sda=1; #10;
    sda=0; #10;
    sda=0; #10;

    #50;

    $finish;

end

endmodule