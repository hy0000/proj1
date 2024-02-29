`timescale 1ns/1ns
module game_test;
    bit clock;
    always #5 clock = ~clock;

    game_if gif(clock);
    game u_game(gif);
    game_tb tb(gif);

    initial begin
        $fsdbDumpfile("test3.fsdb");
        $fsdbDumpvars(0, game_test);
        tb.reset();
        fork
           tb.run_test("EWESNSE");
           tb.monitor();
        join
        tb.reset();
        fork
            tb.run_test("_E_S_W_E_E");
            tb.monitor();
        join
        tb.reset();
        $finish;
    end
endmodule