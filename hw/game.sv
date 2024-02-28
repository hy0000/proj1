`timescale 1ns/1ns
module game (
    game_if.DUT gif
);
    
    logic sw;  // Sword found signal input
    logic v;   // Vorpal sword found signal input

    room_fsm u_room_fsm (
        .clock  (gif.clock  ),
        .R      (gif.R      ),
        .n      (gif.n      ),
        .s      (gif.s      ),
        .e      (gif.e      ),
        .w      (gif.w      ),
        .sw     (sw         ),
        .v      (v          ),
        .win    (gif.win    ),
        .d      (gif.d      )
    );

    sword_fsm u_sword_fsm (
        .clock  (gif.clock  ),
        .R      (gif.R      ),
        .sw     (sw         ),
        .v      (v          )
    );

endmodule
