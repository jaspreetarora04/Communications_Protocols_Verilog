module i2c_master(
    input clk,
    input reset,
    input start,
    input [6:0] addr,
    input [7:0] data_in,

    output reg scl,
    output reg sda,
    output reg done
);

parameter IDLE      = 3'b000,
          START_ST  = 3'b001,
          ADDR_ST   = 3'b010,
          DATA_ST   = 3'b011,
          STOP_ST   = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= IDLE;
        scl <= 1;
        sda <= 1;
        done <= 0;
        bit_count <= 0;
    end
    else
    begin
        done <= 0;

        case(state)

        IDLE:
        begin
            scl <= 1;
            sda <= 1;

            if(start)
                state <= START_ST;
        end

        START_ST:
        begin
            sda <= 0;
            shift_reg <= {addr,1'b0}; // write bit
            bit_count <= 7;
            state <= ADDR_ST;
        end

        ADDR_ST:
        begin
            sda <= shift_reg[bit_count];

            if(bit_count == 0)
            begin
                shift_reg <= data_in;
                bit_count <= 7;
                state <= DATA_ST;
            end
            else
                bit_count <= bit_count - 1;
        end

        DATA_ST:
        begin
            sda <= shift_reg[bit_count];

            if(bit_count == 0)
                state <= STOP_ST;
            else
                bit_count <= bit_count - 1;
        end

        STOP_ST:
        begin
            sda <= 1;
            done <= 1;
            state <= IDLE;
        end

        endcase
    end
end

endmodule