`timescale 1ns/1ns
module game_test1;
    bit clk;
    always #5 clk = ~clk;

    GameIf game_if(clk);

    Game game(game_if);
    game_tb tb(game_if);

    initial begin
        $fsdbDumpfile("tb1.fsdb");
        $fsdbDumpvars(0, game_tb);
        fork
           tb.run_test("EWESNSWEE");
           tb.monitor();
        join
    end
endmodule