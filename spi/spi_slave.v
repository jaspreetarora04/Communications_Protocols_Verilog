module spi_slave(
    input sclk,
    input reset,
    input cs,
    input mosi,

    output reg [7:0] data_out,
    output reg done
);

reg [2:0] bit_count;

always @(posedge sclk or posedge reset)
begin

    if(reset)
    begin
        data_out <= 0;
        bit_count <= 0;
        done <= 0;
    end

    else if(!cs)
    begin

        data_out <= {data_out[6:0], mosi};

        if(bit_count == 7)
        begin
            done <= 1;
            bit_count <= 0;
        end

        else
        begin
            done <= 0;
            bit_count <= bit_count + 1;
        end

    end

end

endmodule