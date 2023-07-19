# Compile Section
vlib work
vlog -sv +define+FORMAL gcd*.sv
vlog -sv -mfcu -cuname sva_bind +define+FORMAL properties.sv

# PropCheck Section
onerror {exit 1}

###### add directives
# fix one of the  nets to a value

#netlist reset reset_n -active_high -async
#netlist clock clk -period 100
#netlist clock start -ignore

###### Run PropCheck
formal compile -d gcd -cuname sva_bind
formal verify -timeout 30s
exit 0