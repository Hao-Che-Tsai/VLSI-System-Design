vlog tb_gl.sv count_gate.v /nfs/guille/a1/cadlibs/synop_lib/SAED_EDK90nm/Digital_Standard_Cell_Library/verilog/*.v -work work_gate
vsim -voptargs=+acc work_gate.tb_count  
add wave *
run -all