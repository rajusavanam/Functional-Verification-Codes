onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wr_clk_i
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rd_clk_i
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rst_i
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wr_en_i
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rd_en_i
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wr_ptr
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wr_ptr_rd_clk
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wdata_i
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/full_o
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/error_o
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/empty_o
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rd_ptr
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rd_ptr_wr_clk
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rdata_o
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wr_toggle_flag
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rd_toggle_flag
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/wr_toggle_flag_rd_clk
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/rd_toggle_flag_wr_clk
add wave -noupdate -radix unsigned /fifo_tb_testcase/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1627 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 238
configure wave -valuecolwidth 51
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {423 ps}
