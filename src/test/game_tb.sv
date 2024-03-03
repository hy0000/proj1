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
        @(posedge gif.clock);
        gif.R = 0;
    endtask

    task run_test(string dir_seq);
        for(int i=0; i<dir_seq.len(); i++) begin
            case(dir_seq[i])
                "N": gif.n = 1'b1;
                "S": gif.s = 1'b1;
                "E": gif.e = 1'b1;
                "W": gif.w = 1'b1;
            endcase
            @(posedge gif.clock);
            gif.n = 1'b0;
            gif.s = 1'b0;
            gif.e = 1'b0;
            gif.w = 1'b0;
        end
    endtask

    task monitor;
        // Stop simulation when game over
        while (!(gif.d || gif.win)) begin
            @(posedge gif.clock);
        end
    endtask

endmodule