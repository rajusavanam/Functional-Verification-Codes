vlog +incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src list.svh

vsim -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
	 -novopt -suppress 12110 top -assertdebug\
	 +UVM_TESTNAME=mem_wr_rd_test

#add wave -position insertpoint sim:/top/pif/*
do wave.do

run -all
