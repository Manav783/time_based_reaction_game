module main (
    input  wire clk,
    input  wire rst,
    input  wire start_btn,
    input  wire react_btn,
    input  wire ms_tick,
    input  wire [15:0] rand_delay,

    output reg  led,
    output reg  timer_en,
    output reg  early_error,
    output reg  show_time
);

    localparam IDLE  = 3'd0,
               WAIT  = 3'd1,
               GO    = 3'd2,
               SHOW  = 3'd3,
               EARLY = 3'd4;

    reg [2:0] state;
    reg [15:0] wait_cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            wait_cnt <= 0;
        end else begin
            case (state)

                IDLE: begin
                    if (start_btn) begin
                        wait_cnt <= rand_delay;
                        state <= WAIT;
                    end
                end

                WAIT: begin
                    if (react_btn)
                        state <= EARLY;
                    else if (ms_tick) begin
                        if (wait_cnt == 0)
                            state <= GO;
                        else
                            wait_cnt <= wait_cnt - 1;
                    end
                end

                GO: begin
                    if (react_btn)
                        state <= SHOW;
                end

                SHOW: begin
                    if (start_btn)
                        state <= IDLE;
                end

                EARLY: begin
                    if (start_btn)
                        state <= IDLE;
                end

            endcase
        end
    end

    always @(*) begin
        led         = (state == GO);
        timer_en    = (state == GO);
        show_time   = (state == SHOW);
        early_error = (state == EARLY);
    end
endmodule
