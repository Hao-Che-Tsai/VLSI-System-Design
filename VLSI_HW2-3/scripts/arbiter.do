add wave *


#initialization
force clk 0 0, 1 5 -r 10
force rst_n 'h0
force dly 'h0
force done 'h0
force req 'h0
force reset 'h0

run 10ns
force rst_n 'h1

#test case 1
run 20ns
force	 req 'h1
run 10ns                                                                                        
force done 'h0                                                                                  
force done 'h1                                                                                  
force dly 'h1                                                                                   
force req 'h0                                                                                   
run 10ns                                                                                        
force done 'h0                                                                                  
force dly 'h0                                                                                   
force req 'h0                                                                                   
run 20ns                                                                                        
                                                                                                
#test case 2                                                                                    
                                                                                                
run 30ns                                                                                        
force req 'h1                                                                                   
force reset 'h0                                                                                 
run 20ns                                                                                        
force reset 'h0                                                                                 
force dly 'h1                                                                                   
force req 'h0                                                                                   
run 20ns                                                                                        
force reset 'h1                                                                                 
force dly 'h1
force req 'h0
run 10ns
force reset 'h0
force dly 'h0
run 20ns

#test case 3

run 30ns
force req 'h1
run 20ns
force reset 'h1
force dly 'h0
force req 'h0
run 20ns

#test case 4

run 30ns
force req 'h1
run 10ns
force done 'h1
force dly 'h0
force req 'h0
run 10ns
force done 'h0
run 20ns


exit
