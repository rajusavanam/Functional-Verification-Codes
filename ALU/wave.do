onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/pif/clk_i
add wave -noupdate /top/pif/rst_i
add wave -noupdate /top/pif/valid_i
add wave -noupdate /top/pif/ready_o
add wave -noupdate -expand -group {Operation Signals} -radix decimal /top/pif/operand_a
add wave -noupdate -expand -group {Operation Signals} -radix decimal /top/pif/operand_b
add wave -noupdate -expand -group {Operation Signals} -radix decimal /top/pif/operation
add wave -noupdate -expand -group {Operation Signals} -radix decimal /top/pif/result
add wave -noupdate -expand -group {Assertion Signals} /top/pif/HANDSHAKE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/ADD_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/SUB_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/MUL_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/DIV_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/REM_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/AND_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/OR_OPE
add wave -noupdate -expand -group {Assertion Signals} /top/pif/XOR_OPE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93 ns} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {521 ns} {731 ns}
