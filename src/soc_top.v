`timescale 1ns / 1ps

module soc_top (
    input clk,
    input resetn,
    output trap_core0,
    output trap_core1,
    
    // Core 0 Memory Interface
    output        mem_valid_0,
    input         mem_ready_0,
    output [31:0] mem_addr_0,
    output [31:0] mem_wdata_0,
    output [3:0]  mem_wstrb_0,
    input  [31:0] mem_rdata_0,

    // Core 1 Memory Interface
    output        mem_valid_1,
    input         mem_ready_1,
    output [31:0] mem_addr_1,
    output [31:0] mem_wdata_1,
    output [3:0]  mem_wstrb_1,
    input  [31:0] mem_rdata_1
);

    // Internal wires for ports we don't want to send to the chip pins
    wire [31:0] irq_dummy = 32'b0;

    // Core 0: High Performance
    picorv32 #(
        .BARREL_SHIFTER(1),
        .ENABLE_COUNTERS(1)
    ) core0 (
        .clk         (clk),
        .resetn      (resetn),
        .trap        (trap_core0),
        .mem_valid   (mem_valid_0),
        .mem_instr   (),
        .mem_ready   (mem_ready_0),
        .mem_addr    (mem_addr_0),
        .mem_wdata   (mem_wdata_0),
        .mem_wstrb   (mem_wstrb_0),
        .mem_rdata   (mem_rdata_0),
        // Look-ahead interface (unused)
        .mem_la_read (), .mem_la_write(), .mem_la_addr(), .mem_la_wdata(), .mem_la_wstrb(),
        // PCPI interface (unused)
        .pcpi_valid  (), .pcpi_insn (), .pcpi_rs1  (), .pcpi_rs2  (), 
        .pcpi_wr     (1'b0), .pcpi_rd (32'b0), .pcpi_wait (1'b0), .pcpi_ready (1'b0),
        // IRQ & Trace
        .irq         (irq_dummy), .eoi (), .trace_valid(), .trace_data()
    );

    // Core 1: Area Optimized
    picorv32 #(
        .BARREL_SHIFTER(0),
        .ENABLE_COUNTERS(1)
    ) core1 (
        .clk         (clk),
        .resetn      (resetn),
        .trap        (trap_core1),
        .mem_valid   (mem_valid_1),
        .mem_instr   (),
        .mem_ready   (mem_ready_1),
        .mem_addr    (mem_addr_1),
        .mem_wdata   (mem_wdata_1),
        .mem_wstrb   (mem_wstrb_1),
        .mem_rdata   (mem_rdata_1),
        // Look-ahead interface
        .mem_la_read (), .mem_la_write(), .mem_la_addr(), .mem_la_wdata(), .mem_la_wstrb(),
        // PCPI interface
        .pcpi_valid  (), .pcpi_insn (), .pcpi_rs1  (), .pcpi_rs2  (), 
        .pcpi_wr     (1'b0), .pcpi_rd (32'b0), .pcpi_wait (1'b0), .pcpi_ready (1'b0),
        // IRQ & Trace
        .irq         (irq_dummy), .eoi (), .trace_valid(), .trace_data()
    );

endmodule
// Ensure there is a blank line here for the EOFNEWLINE warning

