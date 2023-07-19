vlog tb.sv gcd*.sv -work rtl_work +define+option
vsim rtl_work.tb -voptargs=+acc=npr -c -coverage -do run.do +two
mv -f report.rpt func.low.rpt

vlog tb.sv gcd*.sv -work rtl_work 
vsim rtl_work.tb -voptargs=+acc=npr -c -coverage -do run.do +three
mv -f report.rpt func.high.rpt

vlog tb.sv gcd*.sv -work rtl_work 
time vsim rtl_work.tb -voptargs=+acc=npr -c -coverage -do run.do +five
mv -f report.rpt func.rdn.rpt