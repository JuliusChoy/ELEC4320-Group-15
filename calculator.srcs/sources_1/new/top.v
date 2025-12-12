`timescale 1ns / 1ps

module electronic_calculator_top(
        clk_in,
        reset,
        ALU_in_A,
        ALU_in_B,
        OPcode,
        EC_out
    );
    
    input  clk_in;
    input  reset;
    input wire [31:0] ALU_in_A, ALU_in_B;
    input wire [3:0] OPcode;
    output reg [31:0] EC_out;
    
    wire clk_300MHz;
    wire locked;
    wire [31:0] ALU_out;
    wire valid_out;
    reg valid_in = 1'b0;
    
    /*CORE MODULES*/
    

   clk_300_mhz clk_300_mhz(
       .clk_in1     (clk_in),
       .clk_out1    (clk_300MHz),
       .locked      (locked),
       .reset       (reset)
   );
    
    ALU ALU(
        .clk        (clk_300MHz),
        .rst        (reset),           // Added Reset
        .valid_in   (valid_in),   // Handshake: new operation is valid
        .in_A       (ALU_in_A),
        .in_B       (ALU_in_B),
        .opcode     (OPcode),
        .valid_out  (valid_out),    // Handshake: result is valid
        .ALU_out    (ALU_out)
    );

endmodule
