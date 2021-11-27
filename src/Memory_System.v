module Memory_System
#(
    parameter MEMORY_DEPTH = 64,
    DATA_WIDTH = 32
)(
    input Write_Enable_i, CLK,
    input [DATA_WIDTH-1:0] Write_Data,
    input [31:0] Address_i,

    output [DATA_WIDTH-1:0] Read_Data
);

//Wires declarations for data
wire [DATA_WIDTH-1:0] ram_out, rom_out;
//Wires declaration for directions
wire [$clog2(MEMORY_DEPTH)-1:0] ram_dir, rom_dir;

//Modules instanciation
ROM_mem
#(
    .WORD(DATA_WIDTH), .DEPTH(MEMORY_DEPTH)
) ROM_U0(
    .ADDR(rom_dir),
    .DATA_out(rom_out)
);

RAM_mem
#(
    .WORD(DATA_WIDTH), .DEPTH(MEMORY_DEPTH)
) RAM_U0(
    .ADDR(rom_dir),
    .DATA_in(Write_Data),
    .clk(CLK),
    .we(Write_Enable_i),
    .DATA_out(ram_out)
);

Mux_param
#(    
    .SEL(1), .WORD(DATA_WIDTH)
) MUX_U0(
    .DATAin({ram_out, rom_out}),
    .Select(),
    .DATAout(Read_Data)
);

//Glue logic of directions decoders
always @(Address_i) begin
    if (Address_i > 32'h0040_0000)begin
        
    end
end

endmodule
