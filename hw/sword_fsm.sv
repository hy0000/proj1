`timescale 1ns/1ns
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
