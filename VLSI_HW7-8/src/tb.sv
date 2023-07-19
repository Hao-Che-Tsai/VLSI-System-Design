`timescale 1ns/1ns
`include "covergroups.sv"
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
  input_file  = $fopen("input_data", "rb");
    if (input_file==0) begin 
      $display("ERROR : CAN NOT OPEN input_file"); 
    end
  output_file = $fopen("output_data", "wb");
    if (output_file==0) begin 
      $display("ERROR : CAN NOT OPEN output_file"); 
    end
    a_in='x;
    b_in='x;
    start=1'b0;
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

  gcd gcd_0(.*);
  gcd_random gcd_rdm;
  cg1 cg1_inst = new();
  cg2 cg2_inst = new();
  cg3 cg3_inst = new();
  cg4 cg4_inst = new();
  
  integer value;
  integer large_num;
  integer small_num;
  integer temp;


initial begin
  $display ("");
  $display ("--------------------------------------------------");
  $display ("----------------Executing Part1.1-----------------");
  $display ("-----------Reads Inputs From input_data-----------");
  $display ("--------------------------------------------------");
  $display ("");

  #(CYCLE*4);  //delay after reset
  while(! $feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
   while(done != 1'b1) #(CYCLE);
   $fdisplay (output_file,"a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
   $display ("a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(input_file);
  $fclose(output_file);
  
  
  $stop;
  
  $display ("");
  $display ("--------------------------------------------------");
  $display ("----------------Executing Part1.2-----------------");
  $display ("------Reads From The Modified post_input_data-----");
  $display ("--------------------------------------------------");
  $display ("");
  
  input_file = $fopen("post_input_data", "rb");
  if (input_file) $display("Success open post_input_data");
  else            $display("Error while open post_input_data");
  output_file = $fopen("post_output_data", "wb");
  if (output_file) $display("Success open post_output_data");
  else             $display("Error while open post_output_data"); 
  
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
   $fdisplay (output_file,"a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
   $display ("a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(input_file);
  $fclose(output_file);
  
  
  
  $display ("");
  $display ("--------------------------------------------------");
  $display ("-----------------Executing Part2------------------");
  $display ("--Generates Random Input And Feeds Them To gcd()--");
  $display ("--------------------------------------------------");
  $display ("");
  
  gcd_rdm = new ();
  output_file = $fopen("random-outputs.txt", "wb");
  if (output_file)  $display("Success open random-outputs.txt");
  else        $display("Error while open random-outputs.txt"); 
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  
  #(CYCLE*4);  //delay after reset
  for (i = 1; i <= 501; i++) begin
    if (gcd_rdm.randomize() == 0) $display ("Error while randomizing");
    a_in = gcd_rdm.a; 
    b_in = gcd_rdm.b;
    start = 1'b1;
    #(CYCLE);
    start = 1'b0;
    while(done != 1'b1) #(CYCLE);
    $fdisplay (output_file,"a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
    $display ("a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result);
    #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(output_file);
  



  $display ("");
  $display ("--------------------------------------------------");
  $display ("-----------------Executing Part3------------------");
  $display ("-----Compares To The Reference Implementation-----");
  $display ("--------------------------------------------------");
  $display ("");
  

  input_file = $fopen("random-outputs.txt", "rb");
  if (input_file) $display("Success open random-outputs.txt");
  else            $display("Error while open random-outputs.txt");
  
  output_file = $fopen("comparison.rpt", "wb");
  if (output_file)  $display("Success open comparison.rpt");
  else        $display("Error while open comparison.rpt"); 
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  #(CYCLE*4);  //delay after reset
  
  while (!$feof(input_file)) begin
    $fscanf(input_file,"a_in = %d,   b_in = %d,   result = %d", a_in, b_in, result); // read the given data
    start=1'b1;
    #(CYCLE);
    start=1'b0;
    while(done != 1'b1) #(CYCLE);
    
    if (a_in >= b_in) begin
      large_num = a_in;
      small_num = b_in;
    end
    else begin
      large_num = b_in;
      small_num = a_in;
    end
    
    while (small_num != 0) begin
      temp = small_num;
      small_num = (large_num % small_num);
      large_num = temp;
      value = large_num;
    end 
    
    if (large_num == 0 && small_num == 0) begin
      value = 0; 
    end
    
    if (result == value) begin
      $fdisplay (output_file,"%d,  %d,  match", a_in, b_in);
      $display ("a_in = %d,   b_in = %d,   match", a_in, b_in);
    end
    else begin
      $fdisplay (output_file,"%d,  %d,   gcd: %d,  behavioral: %d", a_in, b_in, result, value);
      $display ("a_in = %d,   b_in = %d,   gcd: %d,  behavioral: %d", a_in, b_in, result, value);
    end
    #(CYCLE*2); //2 cycle delay between trials
  end
  $fclose(input_file);
  $fclose(output_file);
  
$stop;
end

endmodule