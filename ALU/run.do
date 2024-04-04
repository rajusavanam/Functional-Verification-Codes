# For Functional Coverage
vlog list.svh +incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src

vsim -novopt -suppress 12110 top -assertdebug\
	-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
	-sv_seed 04022924 \
	+UVM_TESTNAME=base_test

#add wave -position insertpoint sim:top/pif/*
do wave.do
run -all
