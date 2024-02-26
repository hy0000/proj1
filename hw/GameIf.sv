`timescale 1ns/1ns
interface GameIf(input bit clk);

    logic n, s, e, w, reset, d, win;

    modport DUT (
       input n, s, e, w, reset, clk,
       output d, win
    );

    modport TEST (
        output n, s, e, w, reset,
        input d, win, clk
    );
endinterface