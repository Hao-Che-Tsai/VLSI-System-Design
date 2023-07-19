/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP2
// Date      : Fri May 12 16:51:12 2023
/////////////////////////////////////////////////////////////


module count_W8_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  HADDX1 U1_1_1 ( .A0(A[1]), .B0(A[0]), .C1(carry[2]), .SO(SUM[1]) );
  HADDX1 U1_1_6 ( .A0(A[6]), .B0(carry[6]), .C1(carry[7]), .SO(SUM[6]) );
  HADDX1 U1_1_2 ( .A0(A[2]), .B0(carry[2]), .C1(carry[3]), .SO(SUM[2]) );
  HADDX1 U1_1_5 ( .A0(A[5]), .B0(carry[5]), .C1(carry[6]), .SO(SUM[5]) );
  HADDX1 U1_1_4 ( .A0(A[4]), .B0(carry[4]), .C1(carry[5]), .SO(SUM[4]) );
  HADDX1 U1_1_3 ( .A0(A[3]), .B0(carry[3]), .C1(carry[4]), .SO(SUM[3]) );
  INVX0 U1 ( .IN(A[0]), .QN(SUM[0]) );
  XOR2X1 U2 ( .IN1(carry[7]), .IN2(A[7]), .Q(SUM[7]) );
endmodule


module count_W8 ( a_in, sel, clk, start, rst, done, cntout );
  input [7:0] a_in;
  input [1:0] sel;
  output [7:0] cntout;
  input clk, start, rst;
  output done;
  wire   \count_ns[0] , stopcount, N43, N44, N45, N46, N47, N48, N49, N50,
         \U3/U4/Z_0 , \U3/U4/Z_1 , \U3/U4/Z_2 , \U3/U4/Z_3 , \U3/U4/Z_4 ,
         \U3/U4/Z_5 , \U3/U4/Z_6 , \U3/U4/Z_7 , n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69;
  wire   [8:0] reg_ain;
  wire   [7:0] zerocounter;
  wire   [7:0] onecounter;

  count_W8_DW01_inc_0 r73 ( .A({\U3/U4/Z_7 , \U3/U4/Z_6 , \U3/U4/Z_5 , 
        \U3/U4/Z_4 , \U3/U4/Z_3 , \U3/U4/Z_2 , \U3/U4/Z_1 , \U3/U4/Z_0 }), 
        .SUM({N50, N49, N48, N47, N46, N45, N44, N43}) );
  DFFARX1 \count_ps_reg[1]  ( .D(done), .CLK(clk), .RSTB(n68), .QN(n65) );
  DFFARX1 \count_ps_reg[0]  ( .D(\count_ns[0] ), .CLK(clk), .RSTB(n68), .Q(n53), .QN(n66) );
  DFFX1 \reg_ain_reg[7]  ( .D(n45), .CLK(clk), .Q(reg_ain[7]) );
  DFFX1 \zerocounter_reg[0]  ( .D(n35), .CLK(clk), .Q(zerocounter[0]) );
  DFFX1 \zerocounter_reg[1]  ( .D(n34), .CLK(clk), .Q(zerocounter[1]) );
  DFFX1 \zerocounter_reg[2]  ( .D(n33), .CLK(clk), .Q(zerocounter[2]) );
  DFFX1 \zerocounter_reg[3]  ( .D(n32), .CLK(clk), .Q(zerocounter[3]) );
  DFFX1 \zerocounter_reg[4]  ( .D(n31), .CLK(clk), .Q(zerocounter[4]) );
  DFFX1 \zerocounter_reg[5]  ( .D(n30), .CLK(clk), .Q(zerocounter[5]) );
  DFFX1 \zerocounter_reg[6]  ( .D(n29), .CLK(clk), .Q(zerocounter[6]) );
  DFFX1 \zerocounter_reg[7]  ( .D(n28), .CLK(clk), .Q(zerocounter[7]) );
  DFFSSRX1 stopcount_reg ( .SETB(n67), .RSTB(n69), .D(1'b0), .CLK(clk), .Q(
        stopcount) );
  DFFX1 \onecounter_reg[0]  ( .D(n43), .CLK(clk), .Q(onecounter[0]) );
  DFFX1 \onecounter_reg[1]  ( .D(n42), .CLK(clk), .Q(onecounter[1]) );
  DFFX1 \onecounter_reg[2]  ( .D(n41), .CLK(clk), .Q(onecounter[2]) );
  DFFX1 \onecounter_reg[3]  ( .D(n40), .CLK(clk), .Q(onecounter[3]) );
  DFFX1 \onecounter_reg[4]  ( .D(n39), .CLK(clk), .Q(onecounter[4]) );
  DFFX1 \onecounter_reg[5]  ( .D(n38), .CLK(clk), .Q(onecounter[5]) );
  DFFX1 \onecounter_reg[6]  ( .D(n37), .CLK(clk), .Q(onecounter[6]) );
  DFFX1 \onecounter_reg[7]  ( .D(n36), .CLK(clk), .Q(onecounter[7]) );
  DFFX1 \reg_ain_reg[0]  ( .D(n52), .CLK(clk), .Q(reg_ain[0]) );
  DFFX1 \reg_ain_reg[3]  ( .D(n48), .CLK(clk), .Q(reg_ain[3]) );
  DFFX1 \reg_ain_reg[4]  ( .D(n47), .CLK(clk), .Q(reg_ain[4]) );
  DFFX1 \reg_ain_reg[2]  ( .D(n49), .CLK(clk), .Q(reg_ain[2]) );
  DFFX1 \reg_ain_reg[5]  ( .D(n46), .CLK(clk), .Q(reg_ain[5]) );
  DFFX1 \reg_ain_reg[1]  ( .D(n50), .CLK(clk), .Q(reg_ain[1]) );
  DFFX1 \reg_ain_reg[6]  ( .D(n51), .CLK(clk), .Q(reg_ain[6]) );
  DFFX1 \reg_ain_reg[8]  ( .D(n44), .CLK(clk), .Q(reg_ain[8]) );
  INVX0 U62 ( .IN(rst), .QN(n68) );
  NOR4X0 U63 ( .IN1(n54), .IN2(reg_ain[0]), .IN3(reg_ain[2]), .IN4(reg_ain[1]), 
        .QN(n69) );
  OR4X1 U64 ( .IN1(reg_ain[3]), .IN2(reg_ain[4]), .IN3(reg_ain[5]), .IN4(
        reg_ain[6]), .Q(n54) );
  AO21X1 U65 ( .IN1(reg_ain[0]), .IN2(n55), .IN3(n56), .Q(n52) );
  AO222X1 U66 ( .IN1(reg_ain[6]), .IN2(n55), .IN3(a_in[5]), .IN4(n56), .IN5(
        reg_ain[5]), .IN6(\count_ns[0] ), .Q(n51) );
  AO222X1 U67 ( .IN1(reg_ain[1]), .IN2(n55), .IN3(a_in[0]), .IN4(n56), .IN5(
        reg_ain[0]), .IN6(\count_ns[0] ), .Q(n50) );
  AO222X1 U68 ( .IN1(reg_ain[2]), .IN2(n55), .IN3(a_in[1]), .IN4(n56), .IN5(
        reg_ain[1]), .IN6(\count_ns[0] ), .Q(n49) );
  AO222X1 U69 ( .IN1(reg_ain[3]), .IN2(n55), .IN3(a_in[2]), .IN4(n56), .IN5(
        reg_ain[2]), .IN6(\count_ns[0] ), .Q(n48) );
  AO222X1 U70 ( .IN1(reg_ain[4]), .IN2(n55), .IN3(a_in[3]), .IN4(n56), .IN5(
        reg_ain[3]), .IN6(\count_ns[0] ), .Q(n47) );
  AO222X1 U71 ( .IN1(reg_ain[5]), .IN2(n55), .IN3(a_in[4]), .IN4(n56), .IN5(
        reg_ain[4]), .IN6(\count_ns[0] ), .Q(n46) );
  AO222X1 U72 ( .IN1(reg_ain[7]), .IN2(n55), .IN3(a_in[6]), .IN4(n56), .IN5(
        reg_ain[6]), .IN6(\count_ns[0] ), .Q(n45) );
  AO222X1 U73 ( .IN1(reg_ain[8]), .IN2(n55), .IN3(a_in[7]), .IN4(n56), .IN5(
        reg_ain[7]), .IN6(\count_ns[0] ), .Q(n44) );
  NOR2X0 U74 ( .IN1(\count_ns[0] ), .IN2(n55), .QN(n56) );
  AOI21X1 U75 ( .IN1(n65), .IN2(n66), .IN3(\count_ns[0] ), .QN(n55) );
  AO22X1 U76 ( .IN1(onecounter[0]), .IN2(n57), .IN3(N43), .IN4(n58), .Q(n43)
         );
  AO22X1 U77 ( .IN1(onecounter[1]), .IN2(n57), .IN3(N44), .IN4(n58), .Q(n42)
         );
  AO22X1 U78 ( .IN1(onecounter[2]), .IN2(n57), .IN3(N45), .IN4(n58), .Q(n41)
         );
  AO22X1 U79 ( .IN1(onecounter[3]), .IN2(n57), .IN3(N46), .IN4(n58), .Q(n40)
         );
  AO22X1 U80 ( .IN1(onecounter[4]), .IN2(n57), .IN3(N47), .IN4(n58), .Q(n39)
         );
  AO22X1 U81 ( .IN1(onecounter[5]), .IN2(n57), .IN3(N48), .IN4(n58), .Q(n38)
         );
  AO22X1 U82 ( .IN1(onecounter[6]), .IN2(n57), .IN3(N49), .IN4(n58), .Q(n37)
         );
  AO22X1 U83 ( .IN1(onecounter[7]), .IN2(n57), .IN3(N50), .IN4(n58), .Q(n36)
         );
  NOR2X0 U84 ( .IN1(n67), .IN2(n57), .QN(n58) );
  NOR2X0 U85 ( .IN1(n67), .IN2(reg_ain[8]), .QN(n57) );
  AO22X1 U86 ( .IN1(zerocounter[0]), .IN2(n59), .IN3(n60), .IN4(N43), .Q(n35)
         );
  AO22X1 U87 ( .IN1(zerocounter[1]), .IN2(n59), .IN3(n60), .IN4(N44), .Q(n34)
         );
  AO22X1 U88 ( .IN1(zerocounter[2]), .IN2(n59), .IN3(n60), .IN4(N45), .Q(n33)
         );
  AO22X1 U89 ( .IN1(zerocounter[3]), .IN2(n59), .IN3(n60), .IN4(N46), .Q(n32)
         );
  AO22X1 U90 ( .IN1(zerocounter[4]), .IN2(n59), .IN3(n60), .IN4(N47), .Q(n31)
         );
  AO22X1 U91 ( .IN1(zerocounter[5]), .IN2(n59), .IN3(n60), .IN4(N48), .Q(n30)
         );
  AO22X1 U92 ( .IN1(zerocounter[6]), .IN2(n59), .IN3(n60), .IN4(N49), .Q(n29)
         );
  AO22X1 U93 ( .IN1(zerocounter[7]), .IN2(n59), .IN3(n60), .IN4(N50), .Q(n28)
         );
  NOR2X0 U94 ( .IN1(n67), .IN2(n59), .QN(n60) );
  AND2X1 U95 ( .IN1(reg_ain[8]), .IN2(\count_ns[0] ), .Q(n59) );
  INVX0 U96 ( .IN(n67), .QN(\count_ns[0] ) );
  MUX21X1 U97 ( .IN1(stopcount), .IN2(n61), .S(n66), .Q(n67) );
  NAND2X0 U98 ( .IN1(start), .IN2(n65), .QN(n61) );
  AO22X1 U99 ( .IN1(n62), .IN2(zerocounter[7]), .IN3(n63), .IN4(onecounter[7]), 
        .Q(cntout[7]) );
  AO22X1 U100 ( .IN1(n62), .IN2(zerocounter[6]), .IN3(n63), .IN4(onecounter[6]), .Q(cntout[6]) );
  AO22X1 U101 ( .IN1(n62), .IN2(zerocounter[5]), .IN3(n63), .IN4(onecounter[5]), .Q(cntout[5]) );
  AO22X1 U102 ( .IN1(n62), .IN2(zerocounter[4]), .IN3(n63), .IN4(onecounter[4]), .Q(cntout[4]) );
  AO22X1 U103 ( .IN1(n62), .IN2(zerocounter[3]), .IN3(n63), .IN4(onecounter[3]), .Q(cntout[3]) );
  AO22X1 U104 ( .IN1(n62), .IN2(zerocounter[2]), .IN3(n63), .IN4(onecounter[2]), .Q(cntout[2]) );
  AO22X1 U105 ( .IN1(n62), .IN2(zerocounter[1]), .IN3(n63), .IN4(onecounter[1]), .Q(cntout[1]) );
  AO22X1 U106 ( .IN1(n62), .IN2(zerocounter[0]), .IN3(n63), .IN4(onecounter[0]), .Q(cntout[0]) );
  NOR2X0 U107 ( .IN1(n64), .IN2(sel[0]), .QN(n63) );
  AND2X1 U108 ( .IN1(sel[0]), .IN2(done), .Q(n62) );
  INVX0 U109 ( .IN(n64), .QN(done) );
  NAND2X0 U110 ( .IN1(stopcount), .IN2(n53), .QN(n64) );
  MUX21X1 U111 ( .IN1(zerocounter[7]), .IN2(onecounter[7]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_7 ) );
  MUX21X1 U112 ( .IN1(zerocounter[6]), .IN2(onecounter[6]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_6 ) );
  MUX21X1 U113 ( .IN1(zerocounter[5]), .IN2(onecounter[5]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_5 ) );
  MUX21X1 U114 ( .IN1(zerocounter[4]), .IN2(onecounter[4]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_4 ) );
  MUX21X1 U115 ( .IN1(zerocounter[3]), .IN2(onecounter[3]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_3 ) );
  MUX21X1 U116 ( .IN1(zerocounter[2]), .IN2(onecounter[2]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_2 ) );
  MUX21X1 U117 ( .IN1(zerocounter[1]), .IN2(onecounter[1]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_1 ) );
  MUX21X1 U118 ( .IN1(zerocounter[0]), .IN2(onecounter[0]), .S(reg_ain[8]), 
        .Q(\U3/U4/Z_0 ) );
endmodule

