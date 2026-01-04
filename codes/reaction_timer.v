module reaction_timer (
    input  wire clk,
    input  wire rst,
    input  wire ms_tick,
    input  wire enable,
    output reg [15:0] time_ms
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            time_ms <= 0;
        else if (enable && ms_tick)
            time_ms <= time_ms + 1;
        else if (!enable)
            time_ms <= 0;
    end
endmodule
