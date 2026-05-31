module uart_tx(
    input clk,
    input reset,
    input tx_start,
    input [7:0] data_in,

    output reg tx,
    output reg tx_busy,
    output reg tx_done
);

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state     <= IDLE;
        tx        <= 1'b1;
        tx_busy   <= 1'b0;
        tx_done   <= 1'b0;
        bit_count <= 3'd0;
        data_reg  <= 8'd0;
    end

    else
    begin

        tx_done <= 0;

        case(state)

       
        IDLE:
       
        begin
            tx <= 1'b1;
            tx_busy <= 1'b0;

            if(tx_start)
            begin
                data_reg <= data_in;
                state <= START;
                tx_busy <= 1'b1;
            end
        end

       
        START:
        
        begin
            tx <= 1'b0;
            bit_count <= 0;
            state <= DATA;
        end

      
        DATA:
        
        begin

            tx <= data_reg[bit_count];

            if(bit_count == 7)
                state <= STOP;
            else
                bit_count <= bit_count + 1;

        end

       
        STOP:
       
        begin

            tx <= 1'b1;

            tx_done <= 1'b1;
            tx_busy <= 1'b0;

            state <= IDLE;

        end

        default:
            state <= IDLE;

        endcase

    end

end

endmodule