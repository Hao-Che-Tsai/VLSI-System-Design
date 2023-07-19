`timescale 1ns/1ns
`ifdef option
  `include "covergroups.sv"
`else
  `include "mod_covergroups.sv"
`endif 
`include "gcd_random.sv"

module tb; //testbench module 

integer input_file, output_file, in, out;
integer i;

parameter CYCLE = 100; 

reg clk, reset_n;
reg start, done;
reg [31:0] a_in, b_in; 
reg [31:0] result;


//clock generation for write clock
initial begin
  clk <= 0; 
  forever #(CYCLE/2) clk = ~clk;
end

//release of reset_n relative to two clocks
initial begin
    a_in='x;
    b_in='x;
    start=1'b0;
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

  gcd gcd_0(.*);
  gcd_random gcd_rdm;
  cg_fsm_state cg_fsm_state_inst = new();
  cg_gcd_mon cg_gcd_mon_inst = new();
  cg_fsm_ps_mon cg_fsm_ps_mon_inst = new();
  cg_reg_mon cg_reg_mon_inst = new();
  cover property (cvr_seq);
  //cover property (cvr_silly);




initial begin

if ($test$plusargs("two")) begin
  $display ("");
  $display ("--------------------------------------------------");
  $display ("-----------------Executing Part2------------------");
  $display ("-----------------Collect coverage-----------------");
  $display ("--------------------------------------------------");
  $display ("");

input_file = $fopen("post_input_data.txt", "rb");
  if (input_file) $display("Success open post_input_data.txt");
  else            $display("Error while open post_input_data.txt");
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  
  #(CYCLE*4);  //delay after reset
  while(!$feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
   while(done != 1'b1) #(CYCLE);
   $display ("a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(input_file);
end
//$stop;
  
  
if ($test$plusargs("three")) begin
  $display ("");
  $display ("--------------------------------------------------");
  $display ("-----------------Executing Part3------------------");
  $display ("----------------Increase coverage-----------------");
  $display ("--------------------------------------------------");
  $display ("");
  
  input_file = $fopen("mod_input_data.txt", "rb");
  if (input_file) $display("Success open mod_input_data");
  else            $display("Error while open mod_input_data");

  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  
  #(CYCLE*4);  //delay after reset
  while(!$feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
   while(done != 1'b1) #(CYCLE);
   $display ("a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(input_file);
end
//$stop;

if ($test$plusargs("five")) begin
  $display ("");
  $display ("--------------------------------------------------");
  $display ("-----------------Executing Part5------------------");
  $display ("------------------Coverage Cost-------------------");
  $display ("--------------------------------------------------");
  $display ("");
  
  gcd_rdm = new ();
  output_file = $fopen("rp_input_data.txt", "wb");
  if (output_file)  $display("Success open rp_input_data");
  else        $display("Error while open rp_input_data"); 
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  
  #(CYCLE*4);  //delay after reset
  for (i = 1; i <= 1000; i++) begin
    if (gcd_rdm.randomize() == 0) $display ("Error while randomizing");
    a_in = gcd_rdm.a; 
    b_in = gcd_rdm.b;
    start = 1'b1;
    #(CYCLE);
    start = 1'b0;
    while(done != 1'b1) #(CYCLE);
    $fdisplay (output_file,"a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
    if(i % 50 == 0) begin
      $display ("For #%d ,a_in = %d,   b_in = %d,   result = %d", i, a_in, b_in, result);
    end
    #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(output_file);
end


  $stop;
end

endmodule