//cover group 1
covergroup cg_fsm_state @(posedge tb.clk);
  cp_fsm_ps: coverpoint tb.gcd_0.gcd_ctrl_0.ps;
  cp_fsm_ns: coverpoint tb.gcd_0.gcd_ctrl_0.ns;
  cp_fsm_both: cross cp_fsm_ps, cp_fsm_ns;
endgroup: cg_fsm_state




covergroup cg_gcd_mon @(posedge tb.clk);
  cp_gcd_op: coverpoint tb.gcd_0.result {
    bins range_0  = {[0:500]}; 
    bins range_1  = {[500:999]};
    bins range_2  = {[1000:2000]};
    bins range_3  = {[3000:3500]};
    bins range_4  = {[7000:8000]};
    bins range_5  = {5000};
  }
endgroup: cg_gcd_mon




covergroup cg_fsm_ps_mon @(posedge tb.clk);
  cp_gcd_ps_mon: coverpoint tb.gcd_0.gcd_ctrl_0.ps {
    illegal_bins trans = (3 => 1); 
  }
endgroup: cg_fsm_ps_mon




covergroup cg_reg_mon @(posedge tb.clk);
  cp_swap_reg: coverpoint tb.gcd_0.swap_registers;
  cp_sub_reg: coverpoint tb.gcd_0.subtract_registers;
  cp_both_reg: cross cp_swap_reg, cp_sub_reg;
endgroup: cg_reg_mon



property cvr_seq;
  @(posedge tb.clk) tb.reset_n |-> ##[0:2] tb.start |-> ##[70:80] tb.done;
endproperty













