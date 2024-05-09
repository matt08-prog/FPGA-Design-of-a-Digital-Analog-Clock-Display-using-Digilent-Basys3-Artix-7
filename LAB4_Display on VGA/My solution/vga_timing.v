`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2024 02:13:37 PM
// Design Name: 
// Module Name: vga_timing
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_timing(
    output reg [10:0] vcount = 0,
    output reg vsync = 0,
    output reg vblnk = 0,
    output reg [10:0] hcount = 0,
    output reg hsync = 0,
    output reg hblnk = 0,
    input wire pclk
    );
    
    reg [8:0] hBlankCounter = 0;
    reg [8:0] vBlankCounter = 0;

    always @(posedge pclk) begin
        hcount = hcount + 1;
        
        // start hblank
        if (hcount >= 800) begin
            hBlankCounter = hBlankCounter + 1;
            if (hBlankCounter <= 256) begin
                hblnk = 1'b1;
            end
            else begin
                // end hblank
                hblnk = 1'b0;
                
                hcount = 0;
                hBlankCounter = 0;
                
                vcount = vcount + 1;
                
                // start vBlank
                if (vcount >= 600) begin
                    vBlankCounter = vBlankCounter + 1;
                    vblnk = 1'b1;
                end
                
                // end vblank
                if (vBlankCounter > 28) begin
                    vblnk = 1'b0;
                    vcount = 0;
                    vBlankCounter = 0;
                end
                
                // start vsync
                if (vBlankCounter > 0 && vBlankCounter <= 4) begin
                    vsync = 1'b1;
                end
                
                // end vsync
                else if (vBlankCounter > 4) vsync = 1'b0;
            end
            
            if (hBlankCounter >= 40 && hBlankCounter <= 168) begin
                hsync = 1'b1;
            end
            else hsync = 1'b0;    
        end
    end
endmodule
