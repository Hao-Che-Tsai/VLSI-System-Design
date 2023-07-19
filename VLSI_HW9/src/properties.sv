`ifdef FORMAL
  
  // Property: p_startonce
  // The property should trigger at posedge clk since we are asserting start signal only once. We use the implication operator (|->) to specify the relationship.
  // The trigger should be the positive edge of the clock because we want to check the property when the clock changes from low to high.
  property p_startonce;
    @(posedge clk) start |-> ##1 !start[*20];
  endproperty

  // Property: p_evdone
  // This property should also trigger at posedge clk. We are checking that once start is asserted, done is eventually followed.
  // Again, we use the positive edge of the clock because we are checking the property when the state changes.
  property p_evdone;
    @(posedge clk) start |-> ##[0:$] done;
  endproperty

  // Property: p_sanity
  // This property should trigger at posedge clk. We are verifying that at every start of calculation if a_in <= b_in then result is eventually <= a_in.
  // As before, the positive edge of the clock is used as the triggering event since we are interested in state changes.
  property p_sanity;
    @(posedge clk) start && a_in <= b_in |-> ##[0:$] result <= a_in;
  endproperty
  
  // Property: p_divides
  // This property should trigger at posedge clk. We want to ensure that when the calculation is done, the result divides both a_in and b_in.
  // The positive edge of the clock is the right choice for the trigger since we're interested in the state right after the calculation has finished.
  property p_divides;
    @(posedge clk) done |-> ##[0:$] (a_in % result == 0 && b_in % result == 0);
  endproperty
  
`endif
