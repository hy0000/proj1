`timescale 1ns/1ns
module game_test;
    bit clk;
    always #5 clk = ~clk;

    GameIf game_if(clk);
    Game game(game_if);
    game_tb tb(game_if);

    initial begin
        $fsdbDumpfile("test1.fsdb");
        $fsdbDumpvars(0, game_test);
        tb.reset();
        fork
            tb.run_test("ESWEE");
            tb.monitor();
        join
    end
endmodule