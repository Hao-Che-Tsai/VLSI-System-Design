`timescale 1ns/1ns


module tb_controller();


logic [2:0] req;
logic [2:0] done;
logic clk, rst;  // Input signals to the DUT.

logic [1:0] mstate;
logic [1:0] accmodule;

controller iDUT(.req(req), .done(done), .reset(rst), .clk(clk), .mstate(mstate), .accmodule(accmodule));



initial begin

clk = 0;
rst = 1;
req = 3'b000;
done = 3'b000;

# 14 rst = 0;


//Rubric 1 : M1 initial request and DONE
# 2 req = 3'b001;
# 10 req = 3'b000;

# 15 done = 3'b001;
# 5 done = 3'b000;


//Rubric 2 : M2 initial request and DONE
# 2 req = 3'b010;
# 10 req = 3'b000;

# 15 done = 3'b010;
# 5 done = 3'b000;


//Rubric 3 : M2 initial request and memory stays at most 2 cycles
# 2 req = 3'b010;
# 10 req = 3'b000;

# 25 done = 3'b010;
# 5 done = 3'b000;


//Rubric 4 : M3 initial request and DONE
# 2 req = 3'b100;
# 10 req = 3'b000;

# 15 done = 3'b100;
# 5 done = 3'b000;


//Rubric 5 : M3 initial request and memory stays at most 2 cycles
# 2 req = 3'b100;
# 10 req = 3'b000;

# 25 done = 3'b100;
# 5 done = 3'b000;


//Rubric 6 : M1, M2, and/or M3 initial request and DONE.
# 2 req = 3'b111;
# 10 req = 3'b000;

# 10 req = 3'b001;
# 10 req = 3'b000;

# 35 done = 3'b001;
# 5 done = 3'b000;


//Rubric 7 :  Module 2 and module 3 both request
# 10 req = 3'b110;
# 10 req = 3'b000;

# 15 done = 3'b010;
# 5 done = 3'b000;

//Rubric 8 : Module 2 and module 3 both request again
# 10 req = 3'b110;
# 10 req = 3'b000;

# 15 done = 3'b100;
# 5 done = 3'b000;


//Rubric 9 :  M2 requests, M1 to interupts.
# 2 req = 3'b010;
# 10 req = 3'b000;

# 10 req = 3'b001;
# 10 req = 3'b000;

# 35 done = 3'b001;
# 5 done = 3'b000;

//Rubric 10 :  M3 requests, M1 to interupts.
# 2 req = 3'b100;
# 10 req = 3'b000;

# 10 req = 3'b001;
# 10 req = 3'b000;

# 35 done = 3'b001;
# 5 done = 3'b000;



# 20 $dumpflush;
$stop;


end

initial begin
$dumpfile("test.vcd");
$dumpvars(1, tb_controller);

end


always
	#5 clk = ~clk;

endmodule