vlog +incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src \
	list.svh

vsim -novopt -suppress 12110 top\
	-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi\
	+UVM_TESTNAME=delayed_wr_only_test
#	+UVM_VERBOSITY=UVM_HIGH \
#	+UVM_OBJECTION_TRACE \
#	+UVM_PHASE_TRACE \
#	+UVM_RESOURCE_DB_TRACE \
#	+UVM_CONFIG_DB_TRACE \
#	+UVM_MAX_QUIT_COUNT

add wave -position insertpoint sim:/top/pif/*

run -all
