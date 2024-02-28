`timescale 1ns/1ns
module game_test;
    bit clk;
    always #5 clk = ~clk;

    GameIf game_if(clk);

    Game game(game_if);
    game_tb tb(game_if);

    initial begin
        $fsdbDumpfile("test3.fsdb");
        $fsdbDumpvars(0, game_test);
        tb.reset();
        fork
           tb.run_test("_E_W_E_S_N_S_W_E_E");
           tb.monitor();
        join
    end
endmodule