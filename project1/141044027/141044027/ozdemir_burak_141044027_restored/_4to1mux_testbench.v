`define DELAY 20
module _4to1mux_testbench(); 
reg [4:0]select; 
reg a,b,c,d;
wire sum; 

_4to1mux x(sum,select,a,b,c,d);

initial begin
select[0] = 1'b0; select[1] = 1'b0; a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b0;
#`DELAY;
select[0] = 1'b0; select[1] = 1'b1; a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0;
#`DELAY;
select[0] = 1'b1; select[1] = 1'b0; a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0;
#`DELAY;
select[0] = 1'b1; select[1] = 1'b1; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1;
#`DELAY;
end
 
 
initial
begin
$monitor("time = %2d, select=%b,  a =%b, b=%b, c=%b, d=%b, ", $time, select, a,b,c,d);
end
 
endmodule