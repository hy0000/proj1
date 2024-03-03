`timescale 1ns/1ns
module game_test;
    bit clock;
    always #5 clock = ~clock;

    game_if gif(clock);
    game u_game(gif);
    game_tb tb(gif);

    initial begin
        $fsdbDumpfile("test2.fsdb");
        $fsdbDumpvars(0, game_test);
        tb.reset();
        fork
            tb.run_test("ESWEE");
            tb.monitor();
        join
        $finish;
    end
endmodule