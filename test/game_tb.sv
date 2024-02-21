`timescale 1ns/1ns

module game_tb;

    logic n, s, e, w;
    logic reset, clk;
    logic d, win;

    initial begin
        reset = 1; clk = 0;
        #50 reset = 0;
        #5 clk = 1;
        forever
            #5 clk = ~clk;
    end

    // Direction control for character death
    initial begin
        $fsdbDumpfile("test.fsdb");
        $fsdbDumpvars(0, game_tb);

        n = 1'b0;
        s = 1'b0;
        e = 1'b0;
        w = 1'b0;
        #100;

        @(posedge clk) e = 1'b1;
        @(posedge clk) e = 1'b0; s = 1'b1;
        @(posedge clk) s = 1'b0; w = 1'b1;
        @(posedge clk) w = 1'b0; e = 1'b1;
        @(posedge clk) ;
        @(posedge clk) e = 1'b0;
        #100;
        $finish;
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