// Tri-State Buffer
// Allows a circuit element to exist in 3 states: logic high (1), logic low (0), and high impedance (Z)
// Simple so verilog
module tri_state_buffer (
    input  wire data_in,
    input  wire enable,
    output wire data_out
);

    assign data_out = (enable) ? data_in : 1'bz;

endmodule
