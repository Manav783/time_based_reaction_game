module random_delay (
    input  wire clk,
    input  wire rst,
    output reg [15:0] delay_ms
);

    reg [9:0] rand_val;

    always @(posedge clk or posedge rst) begin
        if (rst)
            rand_val <= 0;
        else
            rand_val <= rand_val + 13;
    end

    always @(*) begin
        delay_ms = 1000 + (rand_val % 1000);
    end
endmodule
