# For Code Coverage
vlog list.svh +incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src

vopt work.top +cover=fcbest -o alu_coverage

vsim -coverage alu_coverage \
	-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
	-sv_seed 04022924
	
coverage save -onexit alu_coverage_base_test.ucdb

#add wave -position insertpoint sim:top/pif/*
do wave.do
run -all
