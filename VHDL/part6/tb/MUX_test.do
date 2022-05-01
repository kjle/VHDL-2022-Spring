exit -sim
vlib work
vcom -93 ../MUX.vhd
vcom -93 MUX_tb.vhd

vsim MUX_tb

add wave -decimal *
run -a
