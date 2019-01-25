`define DELAY 20
module _5bit_full_adder_testbench(); 
reg [4:0]a, b; 
reg carry_in;
wire [4:0]sum; 
wire carry_out;

_5bit_adder _5bfadd (sum, carry_out, a, b, carry_in);

initial begin
a = 5'b00000; b = 5'b00000; carry_in = 1'b0;
#`DELAY;
a = 5'b00001; b = 5'b00001; carry_in = 1'b0;
#`DELAY;
a = 5'b00011; b = 5'b00011; carry_in = 1'b0;
#`DELAY;
a = 5'b00000; b = 5'b00111; carry_in = 1'b0;
#`DELAY;
a = 5'b01111; b = 5'b00000; carry_in = 1'b0;
#`DELAY;
a = 5'b00110; b = 5'b00001; carry_in = 1'b0;
#`DELAY;
a = 5'b11111; b = 5'b11111; carry_in = 1'b0;
end
 
 
initial
begin
$monitor("time = %2d, a =%b, b=%b, carry_in=%b, sum=%b, carry_out=%b", $time, a, b, carry_in, sum, carry_out);
end
 
endmodule