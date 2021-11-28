onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Memory_System_TB/STATE
add wave -noupdate /Memory_System_TB/MCLK
add wave -noupdate -radix hexadecimal /Memory_System_TB/Address_tb
add wave -noupdate /Memory_System_TB/Write_Enable_tb
add wave -noupdate -radix hexadecimal /Memory_System_TB/Data_wrt_tb
add wave -noupdate -radix hexadecimal /Memory_System_TB/Read_data_tb
add wave -noupdate -radix hexadecimal /Memory_System_TB/DUT/Address_i
add wave -noupdate -radix hexadecimal /Memory_System_TB/DUT/Write_Data
add wave -noupdate -radix hexadecimal /Memory_System_TB/DUT/Read_Data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {109 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {64 ns}
