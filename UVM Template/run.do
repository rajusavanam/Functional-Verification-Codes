vlog list.svh \
+incdir+H:/VLSI_GURU/UVM/UVM_Lib_Files/uvm-1.2/src

vsim -novopt -suppress 12110 top \
-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi

run -all
