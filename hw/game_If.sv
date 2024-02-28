`timescale 1ns/1ns
interface game_if(input bit clock);

    logic n, s, e, w, R, d, win;

    modport DUT (
       input n, s, e, w, R, clock,
       output d, win
    );

    modport TEST (
        output n, s, e, w, R,
        input d, win, clock
    );
endinterface