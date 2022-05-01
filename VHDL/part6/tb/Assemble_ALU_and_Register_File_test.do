exit -sim
vlib work

vcom -93 ../Register_File.vhd
vcom -93 ../ALU.vhd
vcom -93 ../Assemble_ALU_and_Register_File.vhd
vcom -93 Assemble_ALU_and_Register_File_tb.vhd

vsim Assemble_ALU_and_Register_File_tb

add wave -hexa *
add wave -deci -position insertpoint  sim:/Assemble_ALU_and_Register_File_tb/UUT/Register_File/Banc
run -a