module arbiter(
	output logic 	gnt,
	output logic 	tout,
	input 	clk, rst_n, dly, done, req, reset
	);

	reg [4:0] 	count;

	enum logic [2:0]{
		IDLE  	= 3'b000,
		BBUSY 	= 3'b001,
		BWAIT 	= 3'b010,
		BFREE 	= 3'b011,
		TIMEOUT = 3'b100
	} arbiter_ps, arbiter_ns;


	always_ff @(posedge clk, negedge rst_n)
		if (!rst_n)	arbiter_ps <= IDLE;
		else		arbiter_ps <= arbiter_ns;


	always_ff @(posedge clk)
		case (arbiter_ns)
			BBUSY:		count <= count + 3'b1;
			default:	count <= 3'b0;		
		endcase


	always_comb begin
		gnt = 1'b0;	
		tout = 1'b0;	
   
		unique case (arbiter_ps)
   
			IDLE: begin
				if (req)		arbiter_ns = BBUSY;	
				else			arbiter_ns = IDLE;
			end

			BBUSY: begin
				gnt = 1'b1;
 			  if (count == 2)	arbiter_ns = TIMEOUT;
				else if (!done)		arbiter_ns = BBUSY;	
				else if (dly)		arbiter_ns = BWAIT;	
				else			arbiter_ns = BFREE;
			end

		
			TIMEOUT: begin
				tout = 1'b1;
 			  if (!reset)		arbiter_ns = TIMEOUT;
 		  	else if (!dly)		arbiter_ns = BFREE;	
  	  	else			arbiter_ns = BWAIT;	
			end

			BWAIT: begin
				gnt = 1'b1;
				if (!dly)		arbiter_ns = BFREE;
				else			arbiter_ns = BWAIT;	
			end

			BFREE: begin
				if (req)		arbiter_ns = BBUSY;	
				else			arbiter_ns = IDLE;
			end
		endcase

	end
	

initial begin
	#5;
	forever begin 
	#10 $display("%t ns : The 'state' becomes: %0s, gnt:%0d, tout:%0d", $time, arbiter_ns, gnt, tout);
	end
end


endmodule
