`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 03:53:05 PM
// Design Name: 
// Module Name: soc_tb
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


module soc_tb();

reg clk;
reg rst_n;
reg uart_rx;
reg [3:0] sw;
wire uart_tx;
wire [3:0] led;

// Debug outputs
wire [3:0] debug_acc;
wire [7:0] debug_pc;

// Instantiate SoC
soc uut (
    .clk(clk),
    .rst_n(rst_n),
    .uart_rx(uart_rx),
    .sw(sw),
    .uart_tx(uart_tx),
    .led(led),
    .debug_acc(debug_acc),
    .debug_pc(debug_pc)
);

initial clk = 0;
always #5 clk = ~clk; // 100 MHz clock
initial begin
    rst_n = 0;
    uart_rx = 1;
    sw = 4'b0000;
    #20;
    rst_n = 1;
end

// Monitor outputs
initial begin
    $monitor("Time=%0t | PC=%0d | ACC=%0d | LED=%b | UART_TX=%b", 
              $time, debug_pc, debug_acc, led, uart_tx);
end

initial begin
    #200 $finish;
end

endmodule

