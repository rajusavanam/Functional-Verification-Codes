onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Clock/Reset Signals} /memory_tb/dut/clk_i
add wave -noupdate -expand -group {Clock/Reset Signals} /memory_tb/dut/rst_i
add wave -noupdate -expand -group {Handshaking Signals} /memory_tb/dut/valid_i
add wave -noupdate -expand -group {Handshaking Signals} /memory_tb/dut/ready_o
add wave -noupdate -expand -group {Memory Signals} /memory_tb/dut/wr_rd_i
add wave -noupdate -expand -group {Memory Signals} /memory_tb/dut/addr_i
add wave -noupdate -expand -group {Memory Signals} /memory_tb/dut/wdata_i
add wave -noupdate -expand -group {Memory Signals} /memory_tb/dut/rdata_o
add wave -noupdate /memory_tb/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {399185 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 192
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
WaveRestoreZoom {0 ps} {405751 ps}
