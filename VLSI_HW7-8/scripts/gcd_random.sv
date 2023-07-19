class gcd_random;

rand bit [15:0] a;
rand bit [15:0] b;

constraint num { 
a <= 'd500;
a > 'd0;
b < 'd500; 
b > 'd0; 
a + b == 'd500; 
}

endclass