exit -sim
vlib work
vcom -93 ../data_memory.vhd
vcom -93 data_memory_tb.vhd

vsim data_memory_tb

add wave -hexa *
add wave -hexa /UUT/*
run -a