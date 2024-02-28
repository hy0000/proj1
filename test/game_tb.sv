`timescale 1ns/1ns
module game_tb (
    game_if.TEST gif
);

    initial begin
        gif.n = 1'b0;
        gif.s = 1'b0;
        gif.e = 1'b0;
        gif.w = 1'b0;
        gif.R = 0;
        // Output monitoring
        $monitor("@ %0t : d = %b, win = %b",$time, gif.d, gif.win);
        #10000;
        $display("ERROR: time out after %0t", $time);
        $finish;
    end

    task reset;
        #10;
        gif.R = 1;
        #50;
        gif.R = 0;
        #10;
    endtask

    task run_test(string dir_seq);
        for(int i=0; i<dir_seq.len(); i++) begin
            gif.n = 1'b0;
            gif.s = 1'b0;
            gif.e = 1'b0;
            gif.w = 1'b0;
            case(dir_seq[i])
                "N": gif.n = 1'b1;
                "S": gif.s = 1'b1;
                "E": gif.e = 1'b1;
                "W": gif.w = 1'b1;
            endcase
            @(posedge gif.clock);
        end
    endtask

    task monitor;
        // Stop simulation when game over
        forever @(posedge gif.clock) begin
            if (gif.d || gif.win) begin
                $finish;
            end
        end
    endtask

endmodule