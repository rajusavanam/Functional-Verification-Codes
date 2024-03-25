onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/pif/aclk
add wave -noupdate /top/pif/arst
add wave -noupdate -group Write_Address_Channel /top/pif/awid
add wave -noupdate -group Write_Address_Channel /top/pif/awaddr
add wave -noupdate -group Write_Address_Channel /top/pif/awlen
add wave -noupdate -group Write_Address_Channel /top/pif/awsize
add wave -noupdate -group Write_Address_Channel /top/pif/awburst
add wave -noupdate -group Write_Address_Channel /top/pif/awlock
add wave -noupdate -group Write_Address_Channel /top/pif/awcache
add wave -noupdate -group Write_Address_Channel /top/pif/awprot
add wave -noupdate -group Write_Address_Channel /top/pif/awvalid
add wave -noupdate -group Write_Address_Channel /top/pif/awready
add wave -noupdate -group Write_Data_Channel /top/pif/wid
add wave -noupdate -group Write_Data_Channel /top/pif/wdata
add wave -noupdate -group Write_Data_Channel /top/pif/wstrb
add wave -noupdate -group Write_Data_Channel /top/pif/wlast
add wave -noupdate -group Write_Data_Channel /top/pif/wvalid
add wave -noupdate -group Write_Data_Channel /top/pif/wready
add wave -noupdate -group Write_Response_Channel /top/pif/bid
add wave -noupdate -group Write_Response_Channel /top/pif/bresp
add wave -noupdate -group Write_Response_Channel /top/pif/bvalid
add wave -noupdate -group Write_Response_Channel /top/pif/bready
add wave -noupdate -group Read_Address_Channel /top/pif/arid
add wave -noupdate -group Read_Address_Channel /top/pif/araddr
add wave -noupdate -group Read_Address_Channel /top/pif/arlen
add wave -noupdate -group Read_Address_Channel /top/pif/arsize
add wave -noupdate -group Read_Address_Channel /top/pif/arburst
add wave -noupdate -group Read_Address_Channel /top/pif/arlock
add wave -noupdate -group Read_Address_Channel /top/pif/arcache
add wave -noupdate -group Read_Address_Channel /top/pif/arprot
add wave -noupdate -group Read_Address_Channel /top/pif/arvalid
add wave -noupdate -group Read_Address_Channel /top/pif/arready
add wave -noupdate -group Read_Data/Response_Channel /top/pif/rid
add wave -noupdate -group Read_Data/Response_Channel /top/pif/rdata
add wave -noupdate -group Read_Data/Response_Channel /top/pif/rresp
add wave -noupdate -group Read_Data/Response_Channel /top/pif/rlast
add wave -noupdate -group Read_Data/Response_Channel /top/pif/rvalid
add wave -noupdate -group Read_Data/Response_Channel /top/pif/rready
add wave -noupdate -group Assertions /top/pif/AW_HANDSHAKE
add wave -noupdate -group Assertions /top/pif/W_HANDSHAKE
add wave -noupdate -group Assertions /top/pif/B_HANDSHAKE
add wave -noupdate -group Assertions /top/pif/AR_HANDSHAKE
add wave -noupdate -group Assertions /top/pif/R_HANDSHAKE
add wave -noupdate -group Assertions /top/pif/AW_ADDRESS
add wave -noupdate -group Assertions /top/pif/AR_ADDRESS
add wave -noupdate -group Assertions /top/pif/W_DATA
add wave -noupdate -group Assertions /top/pif/R_DATA
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
WaveRestoreZoom {4871 ns} {5160 ns}
