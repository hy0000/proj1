module RoomFSM (
    input logic clk,       // Clock input
    input logic reset,     // Reset input
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
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= CAVE; // Initial state
        end
        else begin
            current_state <= next_state;
        end
    end

    // Default assignments for outputs
    assign win = (current_state == VAULT    );
    assign d   = (current_state == GRAVEYARD);

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
endmodule : RoomFSM
