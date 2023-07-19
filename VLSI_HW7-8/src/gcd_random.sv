class gcd_random;

rand bit [15:0] a;
rand bit [15:0] b;

function automatic bit is_prime(input [15:0] number);
    for (int i = 2; i < number; i++) begin
      if (number % i == 0) return 0;
    end
    return number > 1;
endfunction


function [15:0] gen_prime();
    reg [15:0] num = 0;
    while (!is_prime(num)) begin
      num = $urandom_range(10000, 65536); 
    end
    return num;
endfunction

constraint num { 
      a == $urandom_range(10000, 65536); 
      b == gen_prime();
}

endclass

