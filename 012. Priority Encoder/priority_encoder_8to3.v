module priority_encoder_8to3 (
    input  [7:0] I,       // 8 input lines
    output reg [2:0] Y    // 3-bit output (reg since its inside an "always" block)
);
// I thought this was way to simple for VHDL, so this will be implemented in verilog to brush up on thsi format.
always @(*) begin
    casex (I) // casex used to implement 'x' (wildcard) 
        8'b1xxxxxxx: Y = 3'b111; // I[7] // 8'b and 3'b represents number of bits
        8'b01xxxxxx: Y = 3'b110; // I[6]
        8'b001xxxxx: Y = 3'b101; // I[5]
        8'b0001xxxx: Y = 3'b100; // I[4]
        8'b00001xxx: Y = 3'b011; // I[3]
        8'b000001xx: Y = 3'b010; // I[2]
        8'b0000001x: Y = 3'b001; // I[1]
        8'b00000001: Y = 3'b000; // I[0]
        default:     Y = 3'b000; // No input active
    endcase
end

endmodule
