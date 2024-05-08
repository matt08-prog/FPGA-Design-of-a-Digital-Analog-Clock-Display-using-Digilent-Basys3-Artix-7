// File: quad_seven_seg.v
// This is the top level design for EE178 Lab #2.
// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).
`timescale 1 ns / 1 ps
// Declare the module and its ports. This is
// using Verilog-2001 syntax.
module quad_seven_seg (
 input wire clk,
 input wire [3:0] val3,
 input wire dot3,
 input wire [3:0] val2,
 input wire dot2,
 input wire [3:0] val1,
 input wire dot1,
 input wire [3:0] val0,
 input wire dot0,
 output reg an3,
 output reg an2,
 output reg an1,
 output reg an0,
 output reg ca,
 output reg cb,
 output reg cc,
 output reg cd,
 output reg ce,
 output reg cf,
 output reg cg,
 output reg dp
// (* dont_touch = "true" *) output reg [2:0] next_digit
 );
 // Describe the actual circuit for the assignment.
 
// reg next_digit = 0;

 reg [2:0] next_digit = 0;
 reg A = 0, B = 0, C = 0, D = 0;
 
 always @(posedge clk) begin
    an3 <= 1'b1;
    an2 <= 1'b1;
    an1 <= 1'b1;
    an0 <= 1'b1;
    case (next_digit)
        0: begin 
            an3 <= 1'b0;
            
            A = val3[3];
            B = val3[2];
            C = val3[1];
            D = val3[0];
            dp <= dot3;
            
            next_digit <= 1;
           end
        1: begin
            an2 <= 1'b0;
            
            A = val2[3];
            B = val2[2];
            C = val2[1];
            D = val2[0];
            dp <= dot2;
            
            next_digit <= 2;
           end
        2: begin
            an1 <= 1'b0;
            
            A = val1[3];
            B = val1[2];
            C = val1[1];
            D = val1[0];
            dp <= dot1;
            
            next_digit <= 3;
           end
        3: begin
            an0 <= 1'b0;
            
            A = val0[3];
            B = val0[2];
            C = val0[1];
            D = val0[0];
            dp <= dot0;
            
            next_digit <= 0;
           end
    endcase

    ca <= 1'b1;
    cb <= 1'b1;
    cc <= 1'b1;
    cd <= 1'b1;
    ce <= 1'b1;
    cf <= 1'b1;
    cg <= 1'b1;

    // A
    if (A || (B && D) | C | (!B && !D)) begin
        ca <= 0;
    end

    // B
    if (!B || (!C && !D) || (C && D)) begin
        cb <= 0;
    end

    // C
    if (!C || D || B) begin
        cc <= 0;
    end

    // D
    if ((!B && !D) || (!B && C) || (B && !C && D) || (C && !D) || A) begin
        cd <= 0;
    end

    // E
    if ((!B && !D) || (C && !D)) begin
        ce <= 0;
    end

    // F
    if ((!C && !D) || (B && !C) || (B && !D) || A) begin
        cf <= 0;
    end

    // G
    if ((!B && C) || (B && !C) || A || (B && !D)) begin
        cg <= 0;
    end
    
    
//    next_digit <=  1;
//    if (next_digit > 3)
//        next_digit <= 0;
//    #1;
//    an3 <= 1'b1;
//    an2 <= 1'b0;
//    an1 <= 1'b1;
//    an0 <= 1'b1;
//    ca <= 1'b0;
//    cb <= 1'b1;
//    cc <= 1'b0;
//    cd <= 1'b0;
//    ce <= 1'b0;
//    cf <= 1'b0;
//    cg <= 1'b0;
    
    
 end
 
 
endmodule