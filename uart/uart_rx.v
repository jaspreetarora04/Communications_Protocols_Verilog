module uart_rx(
    input clk,
    input reset,
    input rx,

    output reg [7:0] data_out,
    output reg rx_done
);

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= IDLE;
        bit_count <= 0;
        data_out <= 8'd0;
        rx_done <= 0;
    end

    else
    begin

        rx_done <= 0;

        case(state)

        // IDLE
        IDLE:
        begin

            if(rx == 0)
                state <= START;

        end

        // START
        
        START:
        begin

            bit_count <= 0;
            state <= DATA;

        end
]
        // DATA
        
        DATA:
        begin

            data_out[bit_count] <= rx;

            if(bit_count == 7)
                state <= STOP;
            else
                bit_count <= bit_count + 1;

        end

        // STOP
        
        STOP:
        begin

            rx_done <= 1'b1;
            state <= IDLE;

        end

        default:
            state <= IDLE;

        endcase

    end

end

endmodule