`define DELAY 20
module likeALU_testbench(); 
reg [4:0]a,b; 
reg [1:0]select;
wire [4:0]sum; 

likeALU x(sum,a,b,select);

initial begin
select[0] = 1'b0; select[1] = 1'b0; a[0]= 1'b1; a[1]= 1'b1; a[2]= 1'b1; a[3]= 1'b1; a[4]= 1'b1;
												b[0]= 1'b1; b[1]= 1'b0; b[2]= 1'b0; b[3]= 1'b0; b[4]= 1'b1;
#`DELAY;
select[0] = 1'b1; select[1] = 1'b0; a[0]= 1'b1; a[1]= 1'b1; a[2]= 1'b0; a[3]= 1'b0; a[4]= 1'b0;
												b[0]= 1'b1; b[1]= 1'b0; b[2]= 1'b0; b[3]= 1'b0; b[4]= 1'b0;
#`DELAY;
select[0] = 1'b0; select[1] = 1'b1; a[0]= 1'b1; a[1]= 1'b0; a[2]= 1'b1; a[3]= 1'b0; a[4]= 1'b1;
												b[0]= 1'b0; b[1]= 1'b1; b[2]= 1'b0; b[3]= 1'b1; b[4]= 1'b0;
#`DELAY;
select[0] = 1'b1; select[1] = 1'b1; a[0]= 1'b0; a[1]= 1'b1; a[2]= 1'b1; a[3]= 1'b0; a[4]= 1'b1;
												b[0]= 1'b0; b[1]= 1'b1; b[2]= 1'b1; b[3]= 1'b0; b[4]= 1'b1;
#`DELAY;
end
 
 
initial
begin
$monitor("time = %2d, select=%b,  a=%b, b=%b, sum=%b", $time, select,a,b,sum);
end
 
endmodule