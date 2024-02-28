`timescale 1ns/1ns
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