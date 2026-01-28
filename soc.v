`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 03:51:22 PM
// Design Name: 
// Module Name: soc
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
module soc (
    input wire clk,
    input wire rst_n,
    input wire uart_rx,
    input wire [3:0] sw,      // GPIO input
    output wire uart_tx,
    output wire [3:0] led,     // GPIO output

    // Debug outputs for waveform/monitor
    output reg [3:0] debug_acc,
    output reg [7:0] debug_pc
);

//-------------------------------------------------
// Simple CPU (4-bit accumulator-based CPU)
//-------------------------------------------------
reg [3:0] acc;           // accumulator
reg [7:0] pc;            // program counter
reg [7:0] instruction;
reg [3:0] ram [0:15];    // 16x4 RAM
reg [7:0] program [0:15]; // small program memory

wire [3:0] alu_out;
reg [3:0] gpio_out;

// CPU: simple instruction set
// Opcodes (4 bits): 
// 0000: NOP
// 0001: LDA addr -> load acc from RAM
// 0010: ADD addr -> acc = acc + RAM[addr]
// 0011: OUT GPIO -> acc -> GPIO
// 1111: HLT

assign led = gpio_out;

//-----------------ALU-----------------
assign alu_out = acc + ram[instruction[3:0]];

//----------------Program Memory Init-----------------
integer i;
initial begin
    // Simple test program
    program[0] = 8'b0001_0000; // LDA 0
    program[1] = 8'b0010_0001; // ADD 1
    program[2] = 8'b0011_0000; // OUT GPIO
    program[3] = 8'b1111_0000; // HLT

    // RAM init
    ram[0] = 4'd3;
    ram[1] = 4'd5;
    ram[2] = 4'd0;
    ram[3] = 4'd0;
end

//----------------CPU Execution-----------------
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        pc <= 0;
        acc <= 0;
        gpio_out <= 0;
    end else begin
        instruction <= program[pc];
        case(instruction[7:4])
            4'b0000: pc <= pc + 1;                   // NOP
            4'b0001: begin                            // LDA
                acc <= ram[instruction[3:0]];
                pc <= pc + 1;
            end
            4'b0010: begin                            // ADD
                acc <= alu_out;
                pc <= pc + 1;
            end
            4'b0011: begin                            // OUT GPIO
                gpio_out <= acc;
                pc <= pc + 1;
            end
            4'b1111: pc <= pc;                        // HLT
            default: pc <= pc + 1;
        endcase
    end

    // Update debug outputs
    debug_acc <= acc;
    debug_pc  <= pc;
end

//-------------------------------------------------
// UART (Simple Transmit Only for Test)
//-------------------------------------------------
reg [7:0] uart_data;
reg [3:0] uart_cnt;
reg uart_busy_reg;
assign uart_tx = uart_busy_reg ? uart_data[0] : 1'b1;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        uart_data <= 8'd0;
        uart_cnt <= 0;
        uart_busy_reg <= 0;
    end else begin
        if(pc == 3) begin
            uart_data <= acc; // send acc on HLT
            uart_busy_reg <= 1;
        end else begin
            uart_busy_reg <= 0;
        end
    end
end

endmodule
