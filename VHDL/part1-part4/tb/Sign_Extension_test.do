exit -sim
vlib work
vcom -93 ../MUX.vhd
vcom -93 ../Sign_Extension.vhd
vcom -93 Sign_Extension_tb.vhd

vsim Sign_Extension_tb

add wave -decimal *
add wave -hexa /uut/*
run -a