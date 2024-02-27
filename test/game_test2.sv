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
        //tb.reset;
        //tb.run_test("E");
        //tb.reset;
        //tb.run_test("ES");
        //tb.reset;
        //tb.run_test("ESW");
        //tb.reset;
        //tb.run_test("ESW");
        //tb.reset;
        tb.run_test("ESE");
        tb.monitor();
    end
endmodule