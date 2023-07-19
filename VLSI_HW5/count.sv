module count #(parameter W = 8) (
  input [W-1:0] a_in,
  input [1:0] sel,
  input clk,
  input start,
  input rst,
  output logic done,
  output logic [W-1:0] cntout
);
  
  enum logic [1:0] {
    IDLE  = 2'b00,
    COUNT = 2'b01,
    DONE  = 2'b10
  } count_ps, count_ns;

  logic [W:0] reg_ain;
  logic [W-1:0] zerocounter;
  logic [W-1:0] onecounter;

  logic stopcount;
  
  always_ff @(posedge clk, posedge rst) begin
    if (rst) count_ps <= IDLE;
    else     count_ps <= count_ns;
  end

  always_comb begin
    unique case (count_ps)    
    
      IDLE: begin
        if (start) begin 
          count_ns = COUNT;
          done = 0;
        end
        else begin
          count_ns = IDLE;
          done = 0;
        end        
      end
      
      COUNT: begin
        if (stopcount) begin
          count_ns = DONE;
          done = 1; 
        end
        else begin
          count_ns = COUNT;
          done = 0;
        end
      end
      
      DONE: begin
        count_ns = IDLE;
        done = 0;
      end           
       
    endcase  
  end

  always @(posedge clk) begin
    if (count_ns == COUNT) begin
      if (reg_ain[W-2:0] == 'b0) begin
        stopcount = 'b1;
      end
    end  
    else stopcount = 'b0;
  end

  always @(posedge clk) begin
    if (count_ps == IDLE) begin
      reg_ain <= {a_in, 1'b1};
    end
    if (count_ns == COUNT && !done) begin
      reg_ain <= (reg_ain << 1); 
    end
  end
  
  always_ff @(posedge clk) begin
    if (count_ns == COUNT && !done) begin       
      if (reg_ain[W] == 1'b0) zerocounter <= zerocounter + 1'b1; 
      else if (reg_ain[W] == 1'b1)   onecounter <= onecounter + 1'b1; 
    end
    else begin
     zerocounter <= 'b0;
     onecounter <= 'b0;
    end
  end


  always_comb begin    
    if (count_ns == DONE) begin
      unique case (sel)
        2'b01: cntout = zerocounter;
        2'b10: cntout = onecounter;
      endcase
    end
    else begin
      cntout = 'b0; 
    end
  end
  
endmodule