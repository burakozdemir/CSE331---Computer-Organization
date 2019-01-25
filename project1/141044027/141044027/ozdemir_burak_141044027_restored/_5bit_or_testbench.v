`define DELAY 20
module _5bit_or_testbench(); 
reg [4:0]a, b; 
wire [4:0]sum; 

_5bit_or _5bfor (sum,a,b);

initial begin
a = 5'b00001; b = 5'b00001;
#`DELAY;
a = 5'b00011; b = 5'b00010;
#`DELAY;
a = 5'b00111; b = 5'b00000;
#`DELAY;
a = 5'b11111; b = 5'b00000;
#`DELAY;
a = 5'b00001; b = 5'b00100;
#`DELAY;
a = 5'b00000; b = 5'b00000;
#`DELAY;
a = 5'b00000; b = 5'b00000;
end
 
 
initial
begin
$monitor("time = %2d, a =%b, b=%b, sum=%b", $time, a, b, sum);
end
 
endmodule