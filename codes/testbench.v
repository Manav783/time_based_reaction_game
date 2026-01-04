`timescale 1ns / 1ps
module tb_reaction_timer_singleplayer_readable(
    );
      // DUT ports
    reg clk;
    reg rst;
    reg start_btn;
    reg react_btn;
    wire led;
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate the DUT (ensure this matches your design module name)
    reaction_timer_singleplayer uut (
        .clk(clk),
        .rst(rst),
        .start_btn(start_btn),
        .react_btn(react_btn),
        .led(led),
        .seg(seg),
        .an(an)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz
    end

    initial begin
        $display("===============================================");
        $display("? Starting Single-Player Reaction Timer Test");
        $display("===============================================");

        // Initial reset
        rst = 1;
        start_btn = 0;
        react_btn = 0;
        $display("[%0t] ? Reset asserted", $time);
        #1000;
        rst = 0;
        $display("[%0t] ? Reset released", $time);

        // Start first round
        #2000;
        press_start();

        // Wait until LED turns ON (when GO signal occurs)
        wait_for_led_on();

        // React after LED on (allow some time for reaction)
        #20000;
        press_react();

        // Wait to let display show result
        #10000;

        // Start a second round and press too early
        press_start();
        #1000;
        press_react();

        #10000;
        $display("[%0t] ? Simulation finished!", $time);
        $finish;
    end

    //-----------------------------------------
    // Helper Tasks
    //-----------------------------------------
    task press_start;
    begin
        $display("[%0t] ? Start button pressed", $time);
        start_btn = 1;
        #500;            // hold the button (500 ns)
        start_btn = 0;
        $display("[%0t] ? Start button released", $time);
    end
    endtask

    task press_react;
    begin
        $display("[%0t] ? React button pressed", $time);
        react_btn = 1;
        #500;            // hold the button (500 ns)
        react_btn = 0;
        $display("[%0t] ? React button released", $time);
    end
    endtask

    // Wait until LED goes high
    task wait_for_led_on;
    begin
        $display("[%0t] ? Waiting for LED to turn ON...", $time);
        wait (led == 1);
        $display("[%0t] ? LED turned ON - Player can react now!", $time);
    end
    endtask

endmodule
