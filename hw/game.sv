module game (
    input logic n,         // North direction input
    input logic s,         // South direction input
    input logic e,         // East direction input
    input logic w,         // West direction input
    input logic reset,     // Reset input
    input logic clk,       // Clock input
    output logic d,        // Output indicating player is dead
    output logic win       // Output indicating game won
);
    
    logic sw;  // Sword found signal input
    logic v;   // Vorpal sword found signal input

    RoomFSM room_fsm (
        .clk(clk),
        .reset(reset),
        .n(n),
        .s(s),
        .e(e),
        .w(w),
        .sw(sw),
        .v(v),
        .win(win),
        .d(d)
    );

    SwordFSM sword_fsm (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .v(v)
    );

endmodule
