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

module room_fsm (
    input logic clock,     // Clock input
    input logic R,     // Reset input
    input logic n,         // North direction input
    input logic s,         // South direction input
    input logic e,         // East direction input
    input logic w,         // West direction input
    input logic v,         // Vorpal sword found signal input
    output logic sw,       // Sword found signal output
    output logic win,      // Output indicating game won
    output logic d         // Output indicating player is dead
);

    typedef enum logic [2:0] {
        CAVE,
        TUNNEL,
        RIVER,
        STASH,
        DEN,
        VAULT,
        GRAVEYARD
    } State;

    State current_state, next_state;

    // D flip-flop to store the current state
    always_ff @(posedge clock or posedge R) begin
        if (R) begin
            current_state <= CAVE; // Initial state
        end
        else begin
            current_state <= next_state;
        end
    end

    // Default assignments for outputs
    assign win = (current_state == VAULT    );
    assign d   = (current_state == GRAVEYARD);
    assign sw  = (current_state == STASH    );

    // State transition logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            CAVE      : begin
                if(e) next_state = TUNNEL;
            end

            TUNNEL    : begin
                if(s) next_state = RIVER;
                if(w) next_state = CAVE ;
            end

            RIVER     : begin
                if(n) next_state = TUNNEL;
                if(e) next_state = DEN   ;
                if(w) next_state = STASH ;
            end

            STASH     : begin
                if(e) next_state = RIVER;
            end

            DEN       : begin
                if(v)
                    next_state = VAULT;
                else
                    next_state = GRAVEYARD;
            end
        endcase
    end
endmodule

module sword_fsm (
    input logic clock,     // Clock input
    input logic R,         // Reset input
    input logic sw,        // Sword found signal input
    output logic v         // Output indicating vorpal sword found
);

    typedef enum logic [1:0] {
        NO_SWORD,
        HAS_SWORD
    } State;

    State current_state, next_state;

    // D flip-flop to store the current state
    always_ff @(posedge clock or posedge R) begin
        if (R) begin
            current_state <= NO_SWORD; // Initial state
        end
        else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            NO_SWORD: next_state = (sw) ? HAS_SWORD : NO_SWORD;
            // HAS_SWORD: next_state = HAS_SWORD;
            default: next_state = current_state;
        endcase
    end

    // Output logic
    assign v = (current_state == HAS_SWORD);

endmodule