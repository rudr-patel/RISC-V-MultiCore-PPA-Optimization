`timescale 1ns / 1ps

module memory (
    input clk,
    input [3:0] wstrb,
    input [31:0] addr,
    input [31:0] wdata,
    output reg [31:0] rdata,
    input valid,
    output reg ready
);
    // 1024 words of 32-bit memory (4KB)
    // In Physical Design, this will eventually be an SRAM Macro
    reg [31:0] mem [0:1023];

    // Simple ready logic: memory is always ready the next cycle
    always @(posedge clk) begin
        ready <= valid;
        if (valid) begin
            // Byte-addressable write logic
            if (wstrb[0]) mem[addr[11:2]][7:0]   <= wdata[7:0];
            if (wstrb[1]) mem[addr[11:2]][15:8]  <= wdata[15:8];
            if (wstrb[2]) mem[addr[11:2]][23:16] <= wdata[23:16];
            if (wstrb[3]) mem[addr[11:2]][31:24] <= wdata[31:24];
            
            // Read data
            rdata <= mem[addr[11:2]];
        end
    end
endmodule

