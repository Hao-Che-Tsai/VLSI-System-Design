`timescale 1ns/1ns

module tb_count();

parameter W = 8;
reg [W-1:0] a_in;
reg [1:0] sel;
reg clk;
reg start;
reg rst;
wire done;
wire [W-1:0] cntout;  

count #(.W(W)) iDUT(.*);

initial begin
  clk = 1;
  rst = 1;
  start = 0;

  #14 rst = 0;

  //case1: correct cntout=3 while another a_in interrupt
  #6 a_in = 8'b0000_1011; //count this
  start = 1;
  sel = 2'b10; // count 1
  #10 start = 0;
  
  #10 a_in = 8'b1111_1111; // this won't count
  #100
  
  
  //case2: corrext cntout=7 when there's an a_in before the start=1
  #10 a_in = 8'b1101_1001; // this won't count

  #10 start = 1;
  a_in = 8'b0000_0100; //count this
  sel = 2'b01; //count 0
  #10 start = 0;
  #100
  
  
  //case3: correct cntout=4 with x in a_in
  a_in = 8'b1010_x101; // count this
  #30 start = 1;
  #10 start = 0;
  #30 sel = 2'b10; // count 1, but x is one of the bit
  #80
    
    
  //case4: correct cntout=2 with z in a_in
  #30 start = 1; a_in = 8'b0z01_zz01; // count this
  #10 start = 0;
  #10 sel = 2'b10; // count 1, but x is one of the bit
  #80  
   
    
  //case5: correct cntout=0 for all bits in a_in is x
  #10 start = 1; a_in = 8'bxxxx_xxxx; //count this
  #10 start = 0; 
  sel = 2'b01; //count 0
  #90
  
  
  //case6: correct cntout=0 for all bits in a_in is z
  #10 start = 1; a_in = 8'bzzzz_zzzz; //count this
  #10 start = 0;
  sel = 2'b10; //count 1
  #90
  
    
  $stop;
end

// one clock cycle is 10ns
always
  #5 clk = ~clk;

endmodule