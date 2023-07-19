vlog tb.sv gcd*.sv -cover sbcef +cover=f -O0
vsim tb -c -coverage
coverage exclude -srcfile tb.sv
run -all
coverage report -details -output pre-coverage.rpt
run -all
coverage report -details -output post-coverage.rpt
exit