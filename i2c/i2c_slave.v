module i2c_slave(
    input scl,
    input reset,
    input sda,

    output reg [7:0] data_out,
    output reg done
);

parameter IDLE = 2'b00,
          ADDR = 2'b01,
          DATA = 2'b10,
          DONE = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge scl or posedge reset)
begin

    if(reset)
    begin
        state <= IDLE;
        bit_count <= 0;
        data_out <= 0;
        done <= 0;
    end

    else
    begin

        case(state)

        IDLE:
        begin
            bit_count <= 0;
            done <= 0;
            state <= ADDR;
        end

        ADDR:
        begin
            bit_count <= bit_count + 1;

            if(bit_count == 7)
            begin
                bit_count <= 0;
                state <= DATA;
            end
        end

        DATA:
        begin

            shift_reg <= {shift_reg[6:0], sda};

            if(bit_count == 7)
            begin
                data_out <= {shift_reg[6:0], sda};
                state <= DONE;
            end
            else
                bit_count <= bit_count + 1;

        end

        DONE:
        begin
            done <= 1;
            state <= IDLE;
        end

        endcase
    end

end

endmodule