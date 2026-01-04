module clock_1ms (
    input  wire clk,
    input  wire rst,
    output reg  ms_tick
);

    reg [16:0] clk_div;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_div <= 0;
            ms_tick <= 0;
        end else begin
            if (clk_div == 99_999) begin
                clk_div <= 0;
                ms_tick <= 1;
            end else begin
                clk_div <= clk_div + 1;
                ms_tick <= 0;
            end
        end
    end
endmodule
