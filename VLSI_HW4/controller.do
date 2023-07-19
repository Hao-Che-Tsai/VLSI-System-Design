vlog controller.sv tb_controller.sv
vsim -voptargs=+acc work.tb_controller
add wave *
add wave /tb_controller/iDUT/controller_ps
run -all