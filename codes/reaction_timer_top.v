module reaction_timer_top (
    input  wire clk,
    input  wire rst,
    input  wire start_btn,
    input  wire react_btn,
    output wire led,
    output wire [6:0] seg,
    output wire [3:0] an
);

    wire ms_tick;
    wire [15:0] rand_delay;
    wire [15:0] reaction_time;
    wire timer_en, show_time, early_error;

    clock_1ms u_clk (.clk(clk), .rst(rst), .ms_tick(ms_tick));
    random_delay u_rand (.clk(clk), .rst(rst), .delay_ms(rand_delay));

    main u_fsm (
        .clk(clk),
        .rst(rst),
        .start_btn(start_btn),
        .react_btn(react_btn),
        .ms_tick(ms_tick),
        .rand_delay(rand_delay),
        .led(led),
        .timer_en(timer_en),
        .early_error(early_error),
        .show_time(show_time)
    );

    reaction_timer u_timer (
        .clk(clk),
        .rst(rst),
        .ms_tick(ms_tick),
        .enable(timer_en),
        .time_ms(reaction_time)
    );

    seven_seg_driver u_disp (
        .clk(clk),
        .rst(rst),
        .number(early_error ? 16'hEEEE : reaction_time),
        .seg(seg),
        .an(an)
    );
endmodule
