`timescale 1ns/1ns
module Game (
    GameIf.DUT game_if
);
    
    logic sw;  // Sword found signal input
    logic v;   // Vorpal sword found signal input

    RoomFSM room_fsm (
        .clk    (game_if.clk    ),
        .reset  (game_if.reset  ),
        .n      (game_if.n      ),
        .s      (game_if.s      ),
        .e      (game_if.e      ),
        .w      (game_if.w      ),
        .sw     (sw             ),
        .v      (v              ),
        .win    (game_if.win    ),
        .d      (game_if.d      )
    );

    SwordFSM sword_fsm (
        .clk    (game_if.clk    ),
        .reset  (game_if.reset  ),
        .sw     (sw             ),
        .v      (v              )
    );

endmodule
