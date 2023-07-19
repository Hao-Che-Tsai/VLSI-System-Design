vlog count.sv tb.sv
vsim -voptargs=+acc work.tb_count
add wave *
add wave -position insertpoint  \
sim:/tb_count/iDUT/count_ps \
sim:/tb_count/iDUT/count_ns \
sim:/tb_count/iDUT/stopcount \
sim:/tb_count/iDUT/reg_ain \
sim:/tb_count/iDUT/zerocounter \
sim:/tb_count/iDUT/onecounter 
run -all