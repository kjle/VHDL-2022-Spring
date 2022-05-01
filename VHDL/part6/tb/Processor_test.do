exit -sim
vlib work
vcom -93 ../ALU.vhd
vcom -93 ../MUX.vhd
vcom -93 ../Sign_Extension.vhd
vcom -93 ../Register_File.vhd
vcom -93 ../Data_memory.vhd
vcom -93 ../Register_Charge.vhd
vcom -93 ../Processing_Unit.vhd
vcom -93 ../instruction_memory3.vhd
vcom -93 ../Instruction_Management_Unit.vhd
vcom -93 ../Decoder.vhd
vcom -93 ../Processor.vhd
vcom -93 Processor_tb.vhd

vsim Processor_tb

add wave -hexa *
add wave -hexa -position insertpoint sim:/processor_tb/UUT/Processing_Unit/Register_File/Banc
add wave -hexa -position insertpoint sim:/processor_tb/UUT/Processing_Unit/Data_Memory/datas
run -a