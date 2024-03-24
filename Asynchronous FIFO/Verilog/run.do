vlog fifo_tb_testcase.v
vsim fifo_tb_testcase +testcase=wr_rd_concurrent
#add wave -position insertpoint sim:fifo_tb_testcase/dut/*
do wave.do
run -all
