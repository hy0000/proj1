`timescale 1ns/1ns
module game_tb (
    GameIf.TEST game_if
);

    initial begin
        game_if.n = 1'b0;
        game_if.s = 1'b0;
        game_if.e = 1'b0;
        game_if.w = 1'b0;
        game_if.reset = 1;
        #50
        game_if.reset = 0;
    end

    task reset();
        game_if.reset = 1;
        #50
        game_if.reset = 0;
    endtask

    task run_test(string dir_seq);
        if(game_if.reset)
            @(!game_if.reset)

        for(int i=0; i<dir_seq.len(); i++) begin
            game_if.n = 1'b0;
            game_if.s = 1'b0;
            game_if.e = 1'b0;
            game_if.w = 1'b0;
            case(dir_seq[i])
                "N": game_if.n = 1'b1;
                "S": game_if.s = 1'b1;
                "E": game_if.e = 1'b1;
                "W": game_if.w = 1'b1;
            endcase
            @(posedge game_if.clk);
        end
    endtask

    task monitor;
        fork
            // Output monitoring
            forever @(posedge game_if.clk) begin
                $display("d = %b, win = %b", game_if.d, game_if.win);
            end
            // Stop simulation when game over
            forever @(posedge game_if.clk) begin
                if (game_if.d || game_if.win) begin
                    $finish;
                end
            end
        join
    endtask

endmodule