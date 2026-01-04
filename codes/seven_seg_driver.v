
module seven_seg_driver (
    input  wire        clk,        // 100 MHz clock
    input  wire        rst,
    input  wire [15:0] number,     // value to display
    output reg  [6:0]  seg,        // segments A-G
    output reg  [3:0]  an          // anodes (active LOW)
);

    reg [15:0] refresh_cnt;
    reg [1:0]  digit_sel;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            refresh_cnt <= 0;
            digit_sel   <= 0;
        end else begin
            if (refresh_cnt == 49_999) begin
                refresh_cnt <= 0;
                digit_sel   <= digit_sel + 1;
            end else begin
                refresh_cnt <= refresh_cnt + 1;
            end
        end
    end


    reg [3:0] digit_val;

    always @(*) begin
        case (digit_sel)
            2'd0: digit_val = number % 10;
            2'd1: digit_val = (number / 10)   % 10;
            2'd2: digit_val = (number / 100)  % 10;
            2'd3: digit_val = (number / 1000) % 10;
            default: digit_val = 4'd0;
        endcase
    end

    always @(*) begin
        case (digit_val)
            4'd0: seg = 7'b0000001;
            4'd1: seg = 7'b1001111;
            4'd2: seg = 7'b0010010;
            4'd3: seg = 7'b0000110;
            4'd4: seg = 7'b1001100;
            4'd5: seg = 7'b0100100;
            4'd6: seg = 7'b0100000;
            4'd7: seg = 7'b0001111;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0000100;
            4'hE: seg = 7'b0110000;  // 'E'
            default: seg = 7'b1111111;
        endcase
    end

    always @(*) begin
        if (number == 16'hEEEE) begin
            an  = 4'b0000;          // show EEEE
            seg = 7'b0110000;
        end else begin
            an = 4'b1111;
            an[digit_sel] = 1'b0;   // enable current digit
        end
    end

endmodule
