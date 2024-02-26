`timescale 1ns/1ns
module game_harness;
    bit clk;
    always #5 clk = ~clk;

    GameIf game_if(clk);

    Game game(game_if);
    game_tb tb(game_if);

    initial begin
        $fsdbDumpfile("game_tb.fsdb");
        $fsdbDumpvars(0, game_tb);

        tb.run_test("ESWEE");
    end
endmodule