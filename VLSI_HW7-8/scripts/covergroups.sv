covergroup cg1 @(posedge tb.clk);
  cp_ps: coverpoint tb.gcd_0.gcd_ctrl_0.ps {
    bins test = {0};
    bins swap = {1};
    bins subt = {2};
    bins done = {3};
  }
  cp_ns: coverpoint tb.gcd_0.gcd_ctrl_0.ns {
    bins test = {0};
    bins swap = {1};
    bins subt = {2};
    bins done = {3};
  }
  cp_psXns: cross cp_ps, cp_ns {
    illegal_bins ill_subt = binsof(cp_ps.subt) && (binsof(cp_ns.subt) || binsof(cp_ns.swap));
    illegal_bins ill_swap = binsof(cp_ps.swap) && (binsof(cp_ns.test) || binsof(cp_ns.swap));
    illegal_bins ill_done = binsof(cp_ps.done) && (binsof(cp_ns.swap) || binsof(cp_ns.subt));
    illegal_bins ill_test = binsof(cp_ps.test) && binsof(cp_ns.test);
    ignore_bins valid_subtXdone = binsof(cp_ps.subt) && binsof(cp_ns.done);
    ignore_bins valid_swapXdone = binsof(cp_ps.swap) && binsof(cp_ns.done);
    }
endgroup: cg1

covergroup cg2 @(posedge tb.clk);
  cp_GCD_port: coverpoint tb.gcd_0.result {
    bins range_0  = {[0:750]}; 
    bins range_1  = {[900:4500]};
    bins range_2  = {[5000:10000]};
    bins range_3  = {800};
  }
endgroup: cg2

covergroup cg3 @(posedge tb.clk);
  cp_illtrans: coverpoint tb.gcd_0.gcd_ctrl_0.ps {
    illegal_bins trans = (3 => 1); 
  }
endgroup: cg3

covergroup cg4 @(posedge tb.clk);
  cp_sequence: coverpoint tb.gcd_0.gcd_ctrl_0.ps iff (tb.reset_n) {
    bins seq = (3[*1:2] => 0[->1:100] => 3);
  }
endgroup: cg4
