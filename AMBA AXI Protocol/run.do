vlog list.svh \
+incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src

vsim -novopt -suppress 12110 top -assertdebug\
-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
+UVM_TESTNAME=test_wr_rd\
+UVM_VERBOSITY=UVM_HIGH 

#add wave -position insertpoint sim:/top/pif/*

do wave.do

run -all
