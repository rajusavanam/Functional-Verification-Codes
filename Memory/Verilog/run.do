vlog memory_tb.v
vsim -novopt -suppress 12110 memory_tb +testcase=fd_write_fd_read
# add wave -position insertpoint sim:memory_tb/dut/*
do wave.do
run -all