`timescale 1ns/1ns
module Memory_System_TB();
localparam Mem_Depth_tb = 64, Data_Len_tb = 32;
bit MCLK = 1'b0;
logic [31:0] Address_tb = '0;
logic Write_Enable_tb = 1'b0;
logic [Data_Len_tb-1:0] Data_wrt_tb = '0, Read_data_tb = '0;
enum {ROM_test, RAM_test} STATE;

Memory_System
#(
    .MEMORY_DEPTH(Mem_Depth_tb),
    .DATA_WIDTH(Data_Len_tb)
) DUT(
    .Write_Enable_i(Write_Enable_tb),
    .CLK(MCLK),
    .Write_Data(Data_wrt_tb),
    .Address_i(Address_tb),
    .Read_Data(Read_data_tb)
);

logic [Data_Len_tb-1:0] rom_tb [Mem_Depth_tb-1:0];
logic [Data_Len_tb-1:0] ram_tb [Mem_Depth_tb-1:0];

task Check_Results;
input [Data_Len_tb-1:0] MemSys_output, Read_Gold;

if (MemSys_output != Read_Gold) begin
    $display("Ha habido un error, se esperaba el dato %d (%b)...", MemSys_output, MemSys_output);
    $display("Se ha obtenido en su lugar %d (%b)...", Read_Gold, Read_Gold);
    $stop(1);
end

endtask

initial begin
    $readmemh("./datarom.hex", rom_tb);
    $readmemh("./dataram.hex", ram_tb);
end

initial begin : Clock_Signal
    forever #5 MCLK = ~MCLK;
end : Clock_Signal

initial begin
    STATE = ROM_test;
    //Rom test
    for (integer i = 32'h0040_0000, j = 0; i <= 32'h0040_001C; i += 32'h4, j++) begin
        Address_tb = i;
        #10; Check_Results(Read_data_tb, rom_tb[j]);     
    end

    //RAM test

    //Store and test values in the RAM memory
    STATE = RAM_test;
    Write_Enable_tb = 1'b1;
    for (integer i = 32'h1001_0000, j = 0; i <= 32'h1001_0010; i += 32'h4, j++) begin
        Address_tb = i;
        Data_wrt_tb = ram_tb[j];
        #10;
        Check_Results(Read_data_tb, ram_tb[j]);
    end

    $display("Simulacion terminada exitosamente.");
    $stop(2);
end
endmodule
