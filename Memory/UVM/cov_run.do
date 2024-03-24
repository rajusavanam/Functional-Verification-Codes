vlog +incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src list.svh

vopt work.top +cover=fcbest -o mem_wr_rd 

vsim -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
	 -coverage mem_wr_rd\
	 +UVM_TESTNAME=mem_n_wr_n_rd_test

coverage save -onexit mem_n_wr_n_rd_test.ucdb

#add wave -position insertpoint sim:/top/pif/*
do wave.do

run -all
