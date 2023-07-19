module controller(
  input logic [2:0] req,
  input logic [2:0] done,
  output logic [1:0] mstate,
  output logic [1:0] accmodule,
  input reset, clk
	);
  
enum logic [3:0]{
   IDLE = 4'b1000,
   M1   = 4'b0001,
   M2   = 4'b0010,
   M3   = 4'b0100
  } controller_ns, controller_ps;
  
parameter MONE =0;
parameter MTWO =1;
parameter MTHREE =2;
parameter MIDLE =3;

reg [1:0] count; 
logic interrupt = 'b0;
logic [1:0] alt = 2'b10; 
  
always_ff @(posedge clk, posedge reset)
  if (reset) controller_ps <= IDLE;
  else     controller_ps <= controller_ns;
    
    
always_ff @(posedge clk)
    case (controller_ns)
      M1: begin     
        if (interrupt && req[0] == 1) count <= 'b1; 
        else if (count == 'b1)     count <= count + 'b1;  
        else             count <= 'b0;
      end
      
      M2: begin
        if (req[1]) count <= 'b1;
        else      count <= count + 'b1;
      end
      
      M3: begin
        if (req[2]) count <= 'b1;
        else      count <= count + 'b1;
      end
      
      default:  count <= 'b0;
    endcase
    
always_ff @(posedge clk)
  if (req == 3'b110) begin
    if (alt == M2) alt <= M3; 
    else       alt <= M2; 
end


always_comb begin
    interrupt = 'b0;
  unique case (controller_ps)
      IDLE: begin
        mstate = 2'b00;
		accmodule = 2'b00;
        casez (req) 
          3'b??1:       controller_ns = M1;
          3'b010:       controller_ns = M2;
          3'b100:       controller_ns = M3;
          
          3'b110: begin
            if (alt == M2)  controller_ns = M2;
            else      controller_ns = M3;
          end
          default:      controller_ns = IDLE;
        endcase        
      end
      
      M1: begin
        mstate = 2'b01;
		accmodule = 2'b01;
        if (done[0]) begin
          unique case (req)
            3'b000:       controller_ns = IDLE; 
            3'b010:       controller_ns = M2; 
            3'b100:       controller_ns = M3; 
            
            3'b110: begin
              if (alt == M2)  controller_ns = M2;
              else        controller_ns = M3;
            end
          endcase          
        end 
      
        else if (count == 2) begin
          controller_ns = IDLE;
        end

        else          controller_ns = M1;
      end
      
      M2: begin
        mstate = 2'b10;
		accmodule = 2'b10;
        if (done[1] && (req == 'b0)) controller_ns = IDLE; 
       
        else if (req[0]) begin
          controller_ns = M1;
          interrupt = 1;
        end
       
        else if (count == 2) begin
          if (req[2])       controller_ns = M3; 
          else          controller_ns = IDLE;
        end
        
        else          controller_ns = M2;
      end
      
      M3: begin
        mstate = 2'b11;
		accmodule = 2'b11;
        if (done[2] && req == 'b0) controller_ns = IDLE; 
        
        else if (req[0]) begin
          controller_ns = M1;
          interrupt = 1;
        end
        
        else if (count == 2) begin
          if (req[1])     controller_ns = M2; 
          else          controller_ns = IDLE;
        end

        else          controller_ns = M3;
      end
    
    endcase
  end

endmodule