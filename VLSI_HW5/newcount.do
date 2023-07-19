vlog count.sv newtb.sv
vsim -voptargs=+acc work.newtb_count
add wave *
add wave -position insertpoint  \
sim:/newtb_count/iDUT/count_ps \
sim:/newtb_count/iDUT/count_ns \
sim:/newtb_count/iDUT/stopcount \
sim:/newtb_count/iDUT/reg_ain \
sim:/newtb_count/iDUT/zerocounter \
sim:/newtb_count/iDUT/onecounter 
run -all