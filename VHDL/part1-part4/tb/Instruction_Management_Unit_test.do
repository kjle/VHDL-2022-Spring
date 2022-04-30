exit -sim
vlib work

vcom -93 ../Sign_Extension.vhd
vcom -93 ../instruction_memory.vhd
vcom -93 ../Instruction_Management_Unit.vhd
vcom -93 Instruction_Management_Unit_tb.vhd

vsim -novopt Instruction_Management_Unit_tb

view signals
add wave -hexa *
add wave -deci -position insertpoint  sim:/Instruction_Management_Unit_tb/UUT/PC
run -all