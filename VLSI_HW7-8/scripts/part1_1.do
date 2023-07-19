vlog provided_tb.sv gcd*.sv -cover sbcef +cover=f -O0
vsim provided_tb -c -coverage
coverage exclude -srcfile provided_tb.sv
run -all
coverage report -details -output pre-coverage.rpt
exit