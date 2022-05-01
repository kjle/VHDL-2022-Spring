vlib work
vcom -93 ../Register_File.vhd
vcom -93 Register_File_tb.vhd

vsim Register_File_tb

add wave -decimal *
add wave -decimal /Register_File_tb/UUT/*
run -a