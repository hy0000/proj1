`timescale 1ns/1ps
module game_tb;

    logic n, s, e, w;
    logic reset, clk;
    logic d, win;

    // Clock generation
    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    // Reset generation
    initial begin
        reset = 1'b1;
        #10;
        reset = 1'b0;
    end

    // Direction control for character death
    initial begin
        n = 1'b0;
        s = 1'b1;
        e = 1'b0;
        w = 1'b0;
        #20;
    end

    // Output monitoring
    always @(posedge clk) begin
        $display("d = %b, win = %b", d, win);
    end

    // Instantiating the DUT
    game game (
        .n(n),
        .s(s),
        .e(e),
        .w(w),
        .reset(reset),
        .clk(clk),
        .d(d),
        .win(win)
    );

    // Stop simulation when game over
    always @(posedge clk) begin
        if (d || win) begin
            $stop;
        end
    end

endmodule