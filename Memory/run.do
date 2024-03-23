vlog memory_tb_testcase.v
vsim memory_tb_testcase +testcase=fd_write_fd_read 
add wave -position insertpoint sim:memory_tb_testcase/dut/*
#do wave.do
run -all
