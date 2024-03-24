vlog list.svh

#vopt work.top +cover=fcbest -o memory_wr_rd
#vsim -coverage memory_wr_rd -assertdebug
#coverage save -onexit multiple_wr_rd.ucdb

vsim -novopt -suppress 12110 top -assertdebug


#add wave -position insertpoint sim:top/pif/*
do wave.do

run -all
