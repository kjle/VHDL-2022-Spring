exit -sim
vlib work
vcom -93 ../ALU.vhd
vcom -93 ../MUX.vhd
vcom -93 ../Sign_Extension.vhd
vcom -93 ../Register_File.vhd
vcom -93 ../Data_memory.vhd
vcom -93 ../Register_Charge.vhd
vcom -93 ../Processing_Unit.vhd
vcom -93 Processing_Unit_tb.vhd

vsim Processing_Unit_tb

add wave /clk
add wave /rst

add wave /alusrc
add wave /wrsrc
add wave /regwr
add wave /memwr

add wave -unsigned /rn
add wave -unsigned /rd
add wave -unsigned /rm
add wave -decimal /imm
add wave -decimal /busout

add wave -decimal /uut/busa
add wave -decimal /uut/busb

add wave -decimal /uut/data_memory/*

run -a