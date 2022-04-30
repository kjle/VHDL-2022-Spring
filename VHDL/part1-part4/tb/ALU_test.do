exit -sim
vlib work
vcom -93 ../ALU.vhd
vcom -93 ALU_tb.vhd

vsim ALU_tb

add wave -decimal *
run -a