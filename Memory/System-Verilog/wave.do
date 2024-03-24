onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/pif/clk_i
add wave -noupdate /top/pif/rst_i
add wave -noupdate -expand -group {Memory Signals} /top/pif/wr_rd_en_i
add wave -noupdate -expand -group {Memory Signals} /top/pif/valid_i
add wave -noupdate -expand -group {Memory Signals} /top/pif/ready_o
add wave -noupdate -expand -group {Memory Signals} /top/pif/addr_i
add wave -noupdate -expand -group {Memory Signals} /top/pif/wdata_i
add wave -noupdate -expand -group {Memory Signals} /top/pif/rdata_o
add wave -noupdate -expand -group Assertions /top/dut_assert/HANDSHAKE
add wave -noupdate -expand -group Assertions /top/dut_assert/RDATA
add wave -noupdate -expand -group Assertions /top/dut_assert/WDATA
add wave -noupdate -expand -group Assertions /top/dut_assert/WR_RD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {2100 ns}
