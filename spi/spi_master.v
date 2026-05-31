module spi_master(
    input clk,
    input reset,
    input start,
    input [7:0] data_in,

    output reg mosi,
    output reg sclk,
    output reg cs,
    output reg done
);

parameter IDLE     = 2'b00;
parameter LOAD     = 2'b01;
parameter TRANSFER = 2'b10;
parameter DONE     = 2'b11;

reg [1:0] state;
reg [7:0] shift_reg;
reg [2:0] bit_count;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= IDLE;
        cs <= 1;
        sclk <= 0;
        mosi <= 0;
        done <= 0;
        bit_count <= 0;
    end

    else
    begin

        done <= 0;

        case(state)

     
        IDLE:
        begin
            cs <= 1;
            sclk <= 0;

            if(start)
                state <= LOAD;
        end

        
        LOAD:
        begin
            cs <= 0;
            shift_reg <= data_in;
            bit_count <= 0;
            state <= TRANSFER;
        end
       
        TRANSFER:
        begin

            mosi <= shift_reg[7];

            shift_reg <= shift_reg << 1;

            sclk <= ~sclk;

            if(bit_count == 7)
                state <= DONE;
            else
                bit_count <= bit_count + 1;

        end
       
        DONE:
        begin

            cs <= 1;
            sclk <= 0;
            done <= 1;
            state <= IDLE;

        end

        endcase

    end

end

endmodule