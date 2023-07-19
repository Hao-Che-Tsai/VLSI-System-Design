`timescale 1ns/1ns

module newtb_count();

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

  //case1: a_in=10101110   sel=10   cntout=  5
  #6 a_in = 8'b1010_1110; //count this
  start = 1;
  sel = 2'b10; // count 1
  #10 start = 0;
  #100
  
  //case2: a_in=10101110   sel=01   cntout=  3
  #10 a_in = 8'b1010_1110; //count this
  start = 1;
  sel = 2'b01; // count 0
  #10 start = 0;
  #100
  
  //case3: a_in=xxxxxxxx   sel=10   cntout=  0
  #10 a_in = 8'bxxxx_xxxx; //count this
  start = 1;
  sel = 2'b10; // count 1
  #10 start = 0;
  #100
  
  //case4: a_in=xxxxxxxx   sel=01   cntout=  0
  #10 a_in = 8'bxxxx_xxxx; //count this
  start = 1;
  sel = 2'b01; // count 0
  #10 start = 0;
  #100
  
  //case5: a_in=zzzzzzzz   sel=10   cntout=  0
  #10 a_in = 8'bzzzz_zzzz; //count this
  start = 1;
  sel = 2'b10; // count 1
  #10 start = 0;
  #100
  
  //case6: a_in=zzzzzzzz   sel=01   cntout=  0
  #10 a_in = 8'bzzzz_zzzz; //count this
  start = 1;
  sel = 2'b01; // count 0
  #10 start = 0;
  #100
  
  //case7: a_in=1xz01xz0   sel=10   cntout=  2
  #10 a_in = 8'b1xz0_1xz0; //count this
  start = 1;
  sel = 2'b10; // count 1
  #10 start = 0;
  #100
  
  //case8: a_in=1xz01xz0   sel=01   cntout=  2
  #10 a_in = 8'b1xz0_1xz0; //count this
  start = 1;
  sel = 2'b01; // count 0
  #10 start = 0;
  #100
  
  
  //case9: a_in=0011011z   sel=10   cntout=  4
  #10 a_in = 8'b0011_011z; //count this
  start = 1;
  sel = 2'b10; // count 1
  #10 start = 0;
  #100
  
  //case10: a_in=0011011z   sel=01   cntout=  3
  #10 a_in = 8'b0011_011z; //count this
  start = 1;
  sel = 2'b01; // count 0
  #10 start = 0;
  #100
  
  $stop;
end

// one clock cycle is 10ns
always
  #5 clk = ~clk;

endmodule